--[[
Preview images and videos using Ueberzugpp:

Usage example:
    fileviewer <video/*>
        \ #ueberzug#video %px %py %pw %ph
        \ %pc
        \ #ueberzug#clear

    fileviewer <image/*>
        \ #ueberzug#image %px %py %pw %ph
        " or \ #ueberzug#image_no_cache %px %py %pw %ph
        \ %pc
        \ #ueberzug#clear
--]]

local layer_id = 'vifm-preview'
local uberzugpp_pipe
local cache_dir_path

local function get_cache_dir_path()
  if cache_dir_path ~= nil then
    return cache_dir_path
  end

  local dir_path = os.getenv('XDG_CACHE_HOME')
  if not dir_path then
    dir_path = os.getenv('HOME') .. '/.cache'
  end
  cache_dir_path = dir_path .. '/ueberzugpp'
  vifm.makepath(cache_dir_path)
  return cache_dir_path
end

local function get_pipe()
  if uberzugpp_pipe ~= nil then
    return uberzugpp_pipe
  end

  local pipe_path = os.getenv('UBERZUGPP_PIPE_PATH')
  if pipe_path == nil then
    return nil, 'No pipe path to ueberzugpp specified, missing environment variable UBERZUGPP_PIPE_PATH'
  end

  local err
  uberzugpp_pipe, err = io.open(pipe_path, 'w')
  if uberzugpp_pipe == nil then
    return nil, 'Failed to open pipe to ueberzugpp\n' .. err
  end
  return uberzugpp_pipe
end

local function clear(info)
  local pipe, err = get_pipe()
  if pipe == nil then
    return { lines = { err } }
  end

  local format = '{"action":"remove", "identifier":"%s"}\n'
  local message = format:format(layer_id)
  pipe:write(message)
  pipe:flush()
  return { lines = {} }
end

local function view(info)
  local pipe, err = get_pipe()
  if pipe == nil then
    return { lines = { err } }
  end

  local format = '{"action":"add", "identifier":"%s", "scaler":"contain",'
      .. ' "x":%d, "y":%d, "max_width":%d, "max_height":%d,'
      .. ' "path":"%s"}\n'
  local message = format:format(
    layer_id, info.x, info.y,
    info.width, info.height, info.path
  )
  pipe:write(message)
  pipe:flush()
  return { lines = {} }
end

local function cached_view_with(info, ext, thumbnailer)
  local function get_thumb_path_without_extension(path)
    local cache_path = get_cache_dir_path()
    local job = vifm.startjob {
      cmd = 'stat --printf "%n%i%F%s%W%Y" -- "' .. path .. '" | sha512sum',
    }
    local sha = job:stdout():read('*all'):sub(1, -5)
    return cache_path .. '/' .. sha
  end

  local function file_exists(path)
    local f = io.open(path, "r")
    return f ~= nil and io.close(f)
  end

  local thumb_partial_path = get_thumb_path_without_extension(info.path)
  local thumb_full_path = thumb_partial_path .. ext
  if not file_exists(thumb_full_path) then
    thumbnailer(thumb_full_path, thumb_partial_path, ext)
  end
  info.path = thumb_full_path
  return view(info)
end

local function cached_view(info, fmt)
  local thumbnailer = function(thumb_full_path)
    vifm.startjob { cmd = fmt:format(info.path, thumb_full_path) }:wait()
  end
  cached_view_with(info, '.jpg', thumbnailer)
end

local function image_no_cache(info)
  return view(info)
end
local function image(info)
  return cached_view(info, 'convert -thumbnail 720 "%s" "%s"')
end
local function video(info)
  return cached_view(info, 'ffmpegthumbnailer -i "%s" -o "%s" -s 720 -q 5')
end

local function handle(info)
  local added = vifm.addhandler(info)
  if not added then
    vifm.sb.error(string.format('Failed to register #%s#%s', vifm.plugin.name, info.name))
  end
end

handle { name = 'clear', handler = clear }
handle { name = 'image', handler = image }
handle { name = 'image_no_cache', handler = image_no_cache }
handle { name = 'video', handler = video }

local M = {}
return M
