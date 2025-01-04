function Linemode:size_and_mtime()
  local size = self._file:size()
  local mtime = math.floor(self._file.cha.mtime or 0)
  local mtime_str = os.date("%Y-%m-%d %H:%M", mtime)

  return string.format("%s %s", size and ya.readable_size(size) or "-", mtime_str)
end
