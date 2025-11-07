# Docker Integration Patterns for UV Projects

Best practices for containerizing Python applications that use `uv`.

## Basic Dockerfile

```dockerfile
FROM python:3.12-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Set working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --frozen --no-dev

# Copy application code
COPY . .

# Run application
CMD ["uv", "run", "python", "-m", "myapp"]
```

## Multi-Stage Build

```dockerfile
# Build stage
FROM python:3.12-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .

# Runtime stage
FROM python:3.12-slim

WORKDIR /app

# Copy virtual environment from builder
COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app /app

# Use virtual environment
ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "-m", "myapp"]
```

## With Development Dependencies

```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install all dependencies including dev
RUN uv sync --frozen

# Copy application code
COPY . .

# Default to running tests
CMD ["uv", "run", "pytest"]
```

## Optimized for Layer Caching

```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

# Set Python environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

# Copy only dependency files first (better caching)
COPY pyproject.toml uv.lock ./

# Install dependencies (cached layer)
RUN uv sync --frozen --no-dev --no-install-project

# Copy application code
COPY . .

# Install the project itself
RUN uv sync --frozen --no-dev

# Run application
CMD ["uv", "run", "python", "-m", "myapp"]
```

## With Build Secrets (for Private Dependencies)

```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

COPY pyproject.toml uv.lock ./

# Mount GitHub token as secret
RUN --mount=type=secret,id=github_token \
    GITHUB_TOKEN=$(cat /run/secrets/github_token) \
    uv sync --frozen --no-dev

COPY . .

CMD ["uv", "run", "python", "-m", "myapp"]
```

Build with:
```bash
docker build --secret id=github_token,env=GITHUB_TOKEN -t myapp .
```

## Alpine-Based (Smaller Image)

```dockerfile
FROM python:3.12-alpine

# Install build dependencies
RUN apk add --no-cache git

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .

CMD ["uv", "run", "python", "-m", "myapp"]
```

## For FastAPI Applications

```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "myapp.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## With Health Checks

```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY . .

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD uv run python -c "import requests; requests.get('http://localhost:8000/health')"

CMD ["uv", "run", "uvicorn", "myapp.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Monorepo/Workspace Pattern

```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

# Copy root workspace files
COPY pyproject.toml uv.lock ./

# Copy all workspace packages
COPY packages/ ./packages/

# Install all workspace dependencies
RUN uv sync --frozen --no-dev

# Copy main application
COPY src/ ./src/

CMD ["uv", "run", "python", "-m", "myapp"]
```

## Docker Compose with UV

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - .:/app
      - /app/.venv  # Don't mount .venv from host
    environment:
      - DATABASE_URL=postgresql://postgres:postgres@db:5432/myapp
    depends_on:
      - db
    command: uv run uvicorn myapp.main:app --host 0.0.0.0 --reload

  db:
    image: postgres:16
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: myapp
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

**Dockerfile for development:**
```dockerfile
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /app

# Install with dev dependencies for development
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen

COPY . .

CMD ["uv", "run", "uvicorn", "myapp.main:app", "--host", "0.0.0.0", "--reload"]
```

## Best Practices

1. **Use `--frozen` flag** to ensure lock file is respected
2. **Copy `uv` from official image** instead of installing via pip
3. **Use multi-stage builds** for smaller production images
4. **Set `UV_COMPILE_BYTECODE=1`** for faster startup
5. **Mount `.venv` as volume** in docker-compose to prevent host/container conflicts
6. **Use `--no-dev`** for production images
7. **Set `PYTHONUNBUFFERED=1`** to see logs immediately
8. **Copy dependency files before code** for better layer caching

## Environment Variables

Useful environment variables for UV in Docker:

```dockerfile
ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1
```

- `UV_COMPILE_BYTECODE=1`: Compile Python files to bytecode (faster startup)
- `UV_LINK_MODE=copy`: Copy files instead of linking (more reliable in containers)
- `PYTHONUNBUFFERED=1`: Don't buffer stdout/stderr
- `PYTHONDONTWRITEBYTECODE=1`: Don't write .pyc files

## Troubleshooting

### Build fails with "lock file not found"

Ensure `uv.lock` is committed and copied:
```dockerfile
COPY pyproject.toml uv.lock ./
```

### Dependencies not found at runtime

Make sure to either:
1. Use `uv run` to execute commands, or
2. Activate the virtual environment in PATH:
```dockerfile
ENV PATH="/app/.venv/bin:$PATH"
```

### Slow builds

Optimize layer caching:
```dockerfile
# Copy dependencies first
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copy code later
COPY . .
```
