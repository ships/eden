q1 = function(frame)
  local quadrant = frame
  quadrant.x = frame.x + frame.w / 2
  quadrant.y = frame.y
  quadrant.w = frame.w / 2
  quadrant.h = frame.h / 2
  return quadrant
end
q2 = function(frame)
  local quadrant = frame
  quadrant.x = frame.x
  quadrant.y = frame.y
  quadrant.w = frame.w / 2
  quadrant.h = frame.h / 2
  return quadrant
end
q3 = function(frame)
  local quadrant = frame
  quadrant.x = frame.x
  quadrant.y = frame.y + frame.h/2
  quadrant.w = frame.w / 2
  quadrant.h = frame.h / 2
  return quadrant
end
q4 = function(frame)
  local quadrant = frame
  quadrant.x = frame.x + frame.w / 2
  quadrant.y = frame.y + frame.h / 2
  quadrant.w = frame.w / 2
  quadrant.h = frame.h / 2
  return quadrant
end
lsplit = function(frame)
  local split = frame
  split.x = frame.x
  split.y = frame.y
  split.w = frame.w / 2
  split.h = frame.h
  return split
end
rsplit = function(frame)
  local split = frame
  split.x = frame.x + frame.w/2
  split.y = frame.y
  split.w = frame.w / 2
  split.h = frame.h
  return split
end
tsplit = function(frame)
  local split = frame
  split.x = frame.x
  split.y = frame.y
  split.w = frame.w
  split.h = frame.h / 2
  return split
end
bsplit = function(frame)
  local split = frame
  split.x = frame.x
  split.y = frame.y + frame.h/2
  split.w = frame.w
  split.h = frame.h / 2
  return split
end

column = function(frame, segments, i, mult)
  mult = mult or 1
  local col_w = frame.w / segments
  local quadrant = frame

  quadrant.w = col_w * mult
  quadrant.h = frame.h
  quadrant.x = frame.x + (i * col_w)
  quadrant.y = frame.y

  return quadrant
end

qw0 = function(frame)
  return column(frame, 5, 0)
end
qw1 = function(frame)
  return column(frame, 5, 1)
end
qw2 = function(frame)
  return column(frame, 5, 2)
end
qw3 = function(frame)
  return column(frame, 5, 3)
end
qw4 = function(frame)
  return column(frame, 5, 4)
end
