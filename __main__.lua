function req(file_path)
  if allow_requires then
    local message = "Requiring file " .. file_path
    debug_print(2, message, nil, "req")
    require(file_path)
  else
    local message = "Doing file " .. file_path .. ".lua"
    debug_print(2, message, nil, "req")
    dofile(file_path .. ".lua")
  end
end

function add_req(file_path)
  debug_print(2, "Checking required_files for " .. file_path, nil, "add_req")
  if required_files then
    for i = 1, #required_files do
      if file_path == required_files[i] then
        return
      end
    end
    debug_print(2, file_path .. " not found in list. Appending", nil, "add_req")
    required_files[#required_files + 1] = file_path
  end
  req(file_path)
end

function set_defaults()
  assert(1 == 0, "Don't call set_defaults : not implemented")
end

function script_path()
  -- Source : https://stackoverflow.com/a/23535333
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

function rld()
  for i = 1, #required_files do
    local fp = required_files[i]
    req(fp)
  end
end

function check_ready_state(address, size, check_values, should_match, interval)
  --   matches = should_match or true
  if should_match == nil then
    matches = true
  else
    matches = should_match
  end
  --   local check_interval = interval or read_interval
  if interval == nil then
    check_interval = read_interval
  else
    check_interval = interval
  end
  -- https://wiki.cheatengine.org/index.php?title=createTimer
  check_timer = createTimer(getMainForm(), false)

  check_timer.OnTimer = function(check_timer)
    -- find way of taking this out of function
    local address = readInteger(emu + inv) + emu + 0x4
    -- hard coding it is terrible
    local val = readBytes(address, size)
    local match_found = false
    local check_string = ""
    for i = 1, #check_values do
      check_string = check_string .. check_values[i] .. ", "
    end
    if debug_verbosity > 0 then
      print("Reading from: " .. nb(address))
      print("Reading interval (milliseconds): " .. nb(check_interval))
      print("Checking for values: " .. check_string)
      print("Check for matches?" .. string.format("%s", matches))
      print("Found value: " .. val)
    end
    for i = 1, #check_values do
      local chval = check_values[i]
      if val == chval then
        match_found = true
      end
    end
    if matches then
      is_ready = match_found
    else
      is_ready = not match_found
    end
  end

  check_timer.Interval = check_interval
  check_timer.Enabled = true
  return check_timer
end

function init()
  required_files = {
    root_dir .. 'lua/cheat_engine',
    root_dir .. 'lua/debug',
    root_dir .. 'lua/lazy',
    root_dir .. 'lua/strings',
    root_dir .. 'lua/tables',
    root_dir .. 'lua/aliases',
  }
  dofile(root_dir .. 'lua/debug.lua')
  for i = 1, #required_files do
    req(required_files[i])
  end
end

root_dir = script_path()

init()

-- START_INCLUDE

function check_criteria(in_value, check_type, check_range, return_corrected_value)
  local val_type = type(in_value)
  local range_min, range_max
  local check_type = check_type or ""
  local type_match = false
  local range_match = false
  local matches = false
  debug_print(9, "Value : " .. tostring(in_value), nil, "check_criteria")
  debug_print(9, "Type : " .. val_type, nil, "check_criteria")
  if type(check_range) == "table" then
    range_min, range_max = check_range[1], check_range[2]
  else
    range_min, range_max = 0, check_range
  end
  if check_type and val_type == string.lower(check_type) then
    type_match = true
  else
    type_match = true
  end
  if check_range then
    if (range_min <= in_value) and (range_max >= in_value) then
      range_match = true
    end
  else
    range_match = true
  end
  if type_match and range_match then
    matches = true
  end
  debug_print(9, "Match type : " .. tostring(type_match) .. "  Match range : " .. tostring(range_max), nil, "check_criteria")
  debug_print(9, "Matches : " .. tostring(matches), nil, "check_criteria")
  if return_corrected_value and type_match then
    local corrected_output
    if val_type == "number" then
      if in_value < range_min then
        corrected_output = range_min
      elseif in_value > range_max then
        corrected_output = range_max
      end
    elseif val_type == "string" then
      corrected_output = string.sub(in_value, 1, range_max)
    end
    return corrected_output
  else
    return matches
  end
end

function set_optional(var_to_check, default_value, force_type, force_range, allow_corrected)
  -- check if var_to_check is a table or single value
  debug_print(5, "Checking : " .. tostring(var_to_check) .. "  Type : " .. type(var_to_check), nil, "set_optional")
  if var_to_check == nil then
    debug_print(8, "Returning default : " .. tostring(default_value), nil, "set_optional")
    return default_value
  end
  -- if var_to_check is a table of checks, then iterate and return false if any don't match, else return true
  if type(var_to_check) == "table" and var_to_check.checklist then
    for i = 1, #var_to_check.checklist do
      local check = check_criteria(var_to_check.checklist[i], force_type, force_range)
      if check then
        if allow_corrected then
          local out_var = check_criteria(var_to_check.checklist[i], force_type, force_range, true)
          debug_print(8, "Returning : " .. tostring(out_var), nil, "set_optional")
          return out_var
        end
        debug_print(8, "Returning : " .. tostring(var_to_check.checklist[i]), nil, "set_optional")
        return var_to_check.checklist[i]
      end
    end
  end
  if check_criteria(var_to_check, force_type, force_range) then
    if allow_corrected then
      local out_var = check_criteria(var_to_check, force_type, force_range, allow_corrected)
      debug_print(8, "Returning : " .. tostring(out_var), nil, "set_optional")
      return out_var
    end
    debug_print(8, "Returning : " .. tostring(var_to_check), nil, "set_optional")
    return var_to_check
  end
  debug_print(8, "Returning : nil", nil, "set_optional")
  return nil
end

-- STOP_INCLUDE
