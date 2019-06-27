function cleant_string(in_string, strip_white_spaces, remove_spaces, force_lower_case)
  assert(1 == 0, "Don't call cleanString : not implemented")
  local rem_spc = remove_spaces or false
  local flc = force_lower_case or false
  local temp_str = in_string
  if rem_spc then
    temp_str = temp_str:gsub(" ", "")
  end
  if flc then
    temp_str = temp_str:lower()
  end
end

function string_replace(in_string, replacements_table)
  assert(1 == 0, "Don't call string_replace : not implemented")
  -- assumes replacements table is such : { "original_string" = "replacements_string", )
end

function normalise_names(in_string, force_lower_case)
  assert(1 == 0, "Don't call normalise_names : not implemented")
  -- replace property names such as 'desc' with 'description' etc.
  local flc = force_lower_case or false
  local replacements = {
    { 'Description', { 'desc', 'dsc', 'dscr', 'descr' } },
    { 'Offset', { 'os', 'off', 'offs', 'oset' } },
    { 'Type', { 'typ' } },
  }
  debugPrint(8, "Normalising : " .. in_string, nil, "normaliseNames")
  for i = 1, #replacements do
    local proper = replacements[i][1]
    for j = 1, #replacements[i][2] do
      local cur_string = #replacements[i][2][j]
      if in_string == cur_string then
        if flc then
          return string.lower(replacements[i][1])
        end
        return replacements[i][1]
      end
    end
  end
  if flc then
    return string.lower(in_string)
  end
  return in_string
end

function time_string(number_of_seconds)
  assert(1 == 0, "Don't call time_string : not implemented")
  local seconds = tonumber(number_of_seconds)
  if seconds <= 0 then
    return "00:00:00";
  else
    local hours = string.format("%02.f", math.floor(seconds / 3600));
    local minutes = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)));
    local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - minutes * 60));
    local mils = seconds - math.floor(seconds)
    local milliseconds = string.format("%03.f", math.floor(mils * 1000));
    local mil_string
    if mils > 0 then
      mil_string = "." .. milliseconds
    else
      mil_string = ""
    end
    return hours .. ":" .. minutes .. ":" .. secs .. mil_string
  end
end

-- START_INCLUDE

function to_hex_string(number)
  out_str = string.format("%X", number)
  return out_str
end

function number_bases(number)
  if number then
    local out_string = "0x" .. string.format("%X", number) .. "  ( " .. cv(number) .. " )"
    return out_string
  else
    return "nil"
  end
end

function table_to_string(in_table, delimiter, reversed, to_hex, return_all)
  local delimiter = delimiter or " "
  local reversed = reversed or false
  local to_hex = to_hex or false
  local return_all = return_all or false
  local dec_table = {}
  local hex_table = {}
  local dec_string = ""
  local hex_string = ""
  debugPrint(3, "Inside tableToString()", nil, "tableToString")
  debugPrint(5, "Delimiter : " .. delimiter, nil, "tableToString")
  debugPrint(5, "Reversed : " .. tostring(reversed), nil, "tableToString")
  debugPrint(5, "To hex : " .. tostring(to_hex), nil, "tableToString")
  debugPrint(5, "Return all : " .. tostring(return_all), nil, "tableToString")
  if debug_verbosity >= 5 then
    recursive_print(in_table)
  end
  for i = 1, #in_table do
    local cur_val
    debugPrint(7, "Iteration : " .. i, nil, "tableToString")
    if reversed then
      cur_val = in_table[-i]
      debugPrint(7, "Current value : " .. cur_val, nil, "tableToString")
    else
      cur_val = in_table[i]
    end
    debugPrint(7, "Current value : " .. cur_val, nil, "tableToString")
    dec_table[i] = tostring(cur_val)
    hex_table[i] = hx(tonumber(cur_val))
    dec_string = dec_string .. tostring(cur_val) .. delimiter
    hex_string = hex_string .. hx(cur_val) .. delimiter
  end

  dec_string = string.sub(dec_string, 1, -2)
  hex_string = string.sub(hex_string, 1, -2)
  debugPrint(5, "Decimal string : " .. dec_string, nil, "tableToString")
  debugPrint(5, "Hexadecimal string : " .. hex_string, nil, "tableToString")

  if return_all then
    local ret_data = {}
    ret_data.dec_string = dec_string
    ret_data.hex_string = hex_string
    ret_data.dec_table = dec_table
    ret_data.hex_table = hex_table
    return ret_data
  end

  if to_hex then
    return hex_string
  else
    return dec_string
  end
end

function to_byte_string(number, return_all_data, force_byte_length)
  local do_return = return_all_data or false
  local return_as_hex = return_as_hex or false
  local as_hex = string.format("%X", number)
  local hex_length = (#as_hex + (#as_hex % 2))
  local bytes_length = math.floor(hex_length / 2)
  if #as_hex % 2 == 1 then
    as_hex = "0" .. as_hex
  end
  local bytes_table = {}
  local bytes_string = ""
  local bytes_decimal_string = ""
  debugPrint(3, "As hex : " .. as_hex, nil, "toByteString")
  debugPrint(5, "Hex length : " .. hex_length, nil, "toByteString")
  debugPrint(5, "Bytes length : " .. bytes_length, nil, "toByteString")

  for i = 1, math.floor(hex_length / 2) do
    if force_byte_length and #bytes_table == force_byte_length then
      break
    end
    local start_cut = hex_length - (i * 2) + 1
    local end_cut = hex_length - ((i - 1) * 2)
    debugPrint(7, "Start at char pos : " .. start_cut .. "  End at char pos : " .. end_cut, nil, "toByteString")
    local hex_chars = string.sub(as_hex, start_cut, end_cut)
    bytes_string = bytes_string .. hex_chars .. " "
    bytes_decimal_string = bytes_decimal_string .. string.format("%X", tonumber(hex_chars, 16)) .. " "
    bytes_table[#bytes_table + 1] = tonumber(hex_chars, 16)
  end

  bytes_string = string.sub(bytes_string, 1, -2)
  bytes_decimal_string = string.sub(bytes_decimal_string, 1, -2)

  if debug_verbosity >= 5 then
    recursive_print(bytes_table)
  end

  if do_return then
    local returned_data = {}
    returned_data.as_hex = as_hex
    returned_data.hex_length = hex_length
    returned_data.bytes_length = bytes_length
    returned_data.bytes_table = bytes_table
    returned_data.bytes_string = bytes_string
    returned_data.bytes_decimal_string = bytes_decimal_string
    return returned_data
  end

  return bytes_table
end

function check_print_output_width(max_value, fill_character)
  -- Displays a long string of numbers to help determine the width of the printed output
  local max_value = max_value or 500
  local fill_character = fill_character or "#"
  local out_string = ""
  for i = 1, max_value // 5 do
    out_string = out_string .. string.rpad(tostring(i * 5), 5, fill_character)
  end
  print(out_string)
end

string.lpad = function(str, len, char)
  -- Source: https://snipplr.com/view/13092/strlpad--pad-string-to-the-left/
  -- Pads str to length len with char from right
  if char == nil then
    char = ' '
  end
  return str .. string.rep(char, len - #str)
end

string.rpad = function(str, len, char)
  -- Source: https://snipplr.com/view/13091/strrpad--pad-string-to-the-right/
  -- Pads str to length len with char from left
  if char == nil then
    char = ' '
  end
  return string.rep(char, len - #str) .. str
end

string.split = function(inputstr, sep)
  --https://stackoverflow.com/a/7615129
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function string_to_byte_string(in_string, prepend_with, append_with)
  local prepend = prepend_with or ""
  local append = append_with or ""
  local byte_string_hex = ""
  local byte_string_dec = ""
  local byte_table = stringToByteTable(in_string)
  for index, char in ipairs(byte_table) do
    byte_string_hex = byte_string_hex .. string.format("%X", char) .. " "
    byte_string_dec = byte_string_dec .. tostring(char) .. " "
  end
  local out_table = {}
  out_table.hex_string = prepend .. byte_string_hex .. append
  out_table.dec_string = prepend .. byte_string_dec .. append

  --return out_table
  return out_table.hex_string
end

function cv(amount, round_down, significant_figures)
  -- Source: http://lua-users.org/wiki/FormattingNumbers
  if round_down then
    amount = math.floor(amount)
  end
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if (k == 0) then
      break
    end
  end
  return formatted
end

string.pstring = function(input, element_separator, key_value_separator, ignore_number_keys)
  -- -- -- Begin test
  if input == "__test__" then
    local test_table = { "1", "One", { 1, 2 }, "Five:Six", nil, ['some_key'] = 'some_value', ['some_other_key'] = 'some_other_value' }
    print("Running test version of string.pstring() with following table")
    recursive_print(test_table)
    local result = string.pstring(test_table, element_separator, key_value_separator, ignore_number_keys)
    print("Resulting output")
    print(result)
    return
  end
  -- -- -- End test

  local ksep = key_value_separator or "="
  local esep = element_separator or ", "
  local ignore_num_keys = ignore_number_keys or true
  local input_type = type(input)
  --debugPrint(10, "Input type : " .. input_type, nil, "string.pstring")
  if input_type == "string" then
    return '"' .. input .. '"'
  elseif input_type == "number" then
    return tostring(input)
  elseif input_type == "nil" then
    return "nil"
  elseif input_type == "table" then
    local out_string = "{ "
    local sub_string
    for i = 1, #input do
      sub_string = string.pstring(input[i], element_separator, key_value_separator, ignore_num_keys)
      out_string = out_string .. sub_string .. esep
    end
    for key, value in pairs(input) do
      if ignore_num_keys and type(key) == "number" then
      elseif ksep == "=" then
        local key_string = '[' .. string.pstring(key) .. ']'
        local value_string = string.pstring(value)
        sub_string = key_string .. ksep .. value_string .. esep
        out_string = out_string .. sub_string
      else
        sub_string = string.pstring(key) .. ksep .. string.pstring(value) .. esep
        out_string = out_string .. sub_string
      end
    end
    out_string = out_string .. "}"
    return out_string
  else
    return tostring(input)
  end
end

-- STOP_INCLUDE
