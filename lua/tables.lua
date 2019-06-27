-- todo use https://github.com/jzrake/lunum
-- todo use https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
-- i should have searched for other people's versions before spending so much time writing my own shitty code
-- the above libraries should end up replacing most of this rubbish

function merge_tables(t1, t2)
  assert(1 == 0, "Don't call merge_tables : not implemented")
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      merge(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

function table_print(tbl, indent)
  assert(1 == 0, "Don't call table_print : not implemented")
  -- Source: https://stackoverflow.com/a/22460068
  -- Print contents of `tbl`, with indentation.
  -- `indent` sets the initial level of indentation.
  if not indent then
    indent = 0
  end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      table_print(v, indent + 1)
    elseif type(v) == "boolean" then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

function tablePrint(tbl, indent, do_print)
  assert(1 == 0, "Don't call tablePrint : not implemented")
  -- Source: https://stackoverflow.com/a/22460068
  -- Print contents of `tbl`, with indentation.
  -- `indent` sets the initial level of indentation.
  if not indent then
    indent = 0
  end
  if not do_print then
    do_print = false
  end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      if do_print then
        print(formatting)
      end
      tablePrint(v, indent + 1)
      return formatting
    elseif type(v) == "boolean" then
      if do_print then
        print(formatting .. tostring(v))
      end
      return formatting .. tostring(v)
    else
      if do_print then
        print(formatting .. v)
      end
      return formatting .. v
    end
  end
end

function enum(names, offset, exclusions)
  assert(1 == 0, "Don't call enum : not implemented")
  -- Source : https://github.com/sulai/Lib-Pico8/blob/master/lang.lua
  -- todo implement exclusions
  offset = offset or 1
  local objects = {}
  local size = 0
  for idr, name in pairs(names) do
    local id = idr + offset - 1
    local obj = {
      id   = id, -- id
      idr  = idr, -- 1-based relative id, without offset being added
      name = name    -- name of the object
    }
    objects[name] = obj
    objects[id] = obj
    size = size + 1
  end
  objects.idstart = offset        -- start of the id range being used
  objects.idend = offset + size - 1   -- end of the id range being used
  objects.size = size
  objects.all = function()
    local list = {}
    for _, name in pairs(names) do
      add(list, objects[name])
    end
    local i = 0
    return function()
      i = i + 1
      if i <= #list then
        return list[i]
      end
    end
  end
  return objects
end

function build_value_table(names_list, base_value, value_increment, value_name)
  assert(1 == 0, "Don't call build_value_table : not implemented")
  local out_table = {}
  local base_val = base_value or 0
  local val_inc = value_increment or 1
  local value_name = value_name or "value"
  for i = 1, #names_list do
    out_table[i] = { value_name = base_val + (val_inc * i), names_list[i] }
  end
  return out_table
end

function matrix_print(table_row, table_col, delimiter_char, max_column_width, justified)
  assert(1 == 0, "Don't call matrix_print : not implemented")
  -- find the longest element in each column
  local mw = max_column_width or 10
  local justify = justified or "right"
  local delimiter = delimiter_char or ","
  local row_names = {}
  local col_names = {}
  --local out_string = string.lpad("", mw, " ")
  local out_string = ""
  -- start with the top row ( column names )
  -- regular row is ROW_NAMES[I] NAME[J] NAME[J] etc.
end

-- START_INCLUDE

function deep_copy(object)
  -- Source: https://forums.coronalabs.com/topic/27482-copy-not-direct-reference-of-table/?p=147749
  local lookup_table = {}
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for index, value in pairs(object) do
      new_table[_copy(index)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  return _copy(object)
end

function print_dictionary(associative_table, as_python_dict, as_hex)
  local as_py = as_python_dict or false
  for key, value in pairs(associative_table) do
    local val_string
    if type(value) == "number" and as_hex then
      val_string = "0x" .. string.format("%X", value)
    elseif type(value) == "string" then
      val_string = '"' .. tostring(value) .. '"'
    else
      val_string = tostring(value)
    end
    if as_py then
      print('"' .. tostring(key) .. '" : ' .. val_string .. ",")
    else
      print(key .. " = " .. val_string)
    end
  end
end

function recursive_print(s, l, i)
  -- recursive Print (structure, limit, indent)
  --[[
  Source: https://gist.github.com/stuby/5445834#file-rPrint-lua
  rPrint(struct, [limit], [indent])   Recursively print arbitrary data.
    Set limit (default 100) to stanch infinite loops.
    Indents tables as [KEY] VALUE, nested tables as [KEY] [KEY]...[KEY] VALUE
    Set indent ("") to prefix each line:    Mytable [KEY] [KEY]...[KEY] VALUE
--]]
  local l = (l) or 100
  local i = i or "" -- default item limit, indent string
  if (l < 1) then
    print "ERROR: Item limit reached."
    return l - 1
  end
  local ts = type(s)
  if (ts ~= "table") then
    print(i, ts, s)
    return l - 1
  end
  print(i, ts) -- print "table"
  for k, v in pairs(s) do
    -- print "[KEY] VALUE"
    l = recursive_print(v, l, i .. "\t[" .. tostring(k) .. "]")
    if (l < 0) then
      break
    end
  end
  return l
end

function multiply_table(in_table, multiplier)
  debugPrint(5, "Called multiply_table()", nil, "multiply_table")
  -- used to calculate new offsets table
  -- e.g. multiplyTable ( { 1, 2, 3, 4} , 2 ) would return { 2, 4, 6, 8}
  local multiplied_table = {}
  for i = 1, #in_table do
    debugPrint(7, "Iteration : " .. i .. "  Number : " .. in_table[i] .. "  Multiplier : " .. multiplier, nil,
        "multiply_table")
    multiplied_table[i] = tonumber(in_table[i]) * multiplier
  end
  return multiplied_table
end

function add_tables(tables)
  debugPrint(5, "Called add_tables()", nil, "add_tables")
  -- used to calculate new offsets table
  -- e.g. addTables ( { {1, 2, 3, 4}, {2, 4, 6, 8} } ) would return {3, 6, 8, 12}
  -- especially useful when calling multiplyTable()
  -- e.g. addTables ( { { 1, 2, 3, 4 } , multiplyTable ( { 0, 1, 2, 3 } , 2 ) } ) would return { 1, 4, 7, 10 }
  -- addTables ( { { 1, 2, 3, 4 } , multiplyTable ( { 0, 1, 2, 3 } , 2 ) } )
  local longest_table = 0
  local summed_table = {}
  for i = 1, #tables do
    local cur_length = #tables[i]
    if cur_length > longest_table then
      longest_table = cur_length
    end
  end

  for i = 1, longest_table do
    summed_table[i] = 0
  end

  for i = 1, #tables do
    debugPrint(7, "Iteration : " .. i, nil, "add_tables")
    for j = 1, longest_table do
      debugPrint(9, "Iteration : " .. i .. " : " .. j, nil, "add_tables")
      if tables[i][j] then
        summed_table[j] = summed_table[j] + tables[i][j]
      end
    end
  end
  return summed_table
end

function create_shaped_table(in_table, remove_numbered_keys, force_lower_case_keys)
  --assert(in_table[1], "create_shaped_table was passed an argument that was not a table") -- is this how asserts work?
  local rnk = remove_numbered_keys or false
  local flc = force_lower_case_keys or false
  debugPrint(3, "Remove numbered keys : " .. tostring(rnk), nil, "create_shaped_table")
  debugPrint(3, "Force lower case keys : " .. tostring(flc), nil, "create_shaped_table")
  if in_table[1] and in_table.shape then
    if debug_verbosity >= 3 then
      recursive_print(in_table)
    end
    local out_table = {}
    for i = 1, #in_table do
      debugPrint(5, "Outer loop iteration : " .. i, nil, "create_shaped_table")
      local sub_table = {}
      for key, value in pairs(in_table[i]) do
        debugPrint(7, "Current key : " .. tostring(key) .. "  Type : " .. type(key) .. "  Value : " .. tostring(value),
            nil, "create_shaped_table")
        local new_key
        if rnk and type(key) == "number" then
          local do_nothing
        elseif type(key) == "string" and flc then
          new_key = string.lower(key)
        else
          new_key = key
        end
        if new_key then
          debugPrint(7, "New key : " .. tostring(new_key), nil, "create_shaped_table")
          sub_table[new_key] = value
        end
      end
      for j = 1, #in_table.shape do
        debugPrint(7, "Inner loop iteration : " .. j, nil, "create_shaped_table")
        local sub_val = in_table[i][j]
        local sub_key = in_table.shape[j]
        local new_sub_key
        --debugPrint(7, "{Key} " .. sub_key .. "  {Key type} " .. type(sub_key) .. "  {Value} " .. sub_val .. "  {Value type} " .. type(sub_val), nil, "create_shaped_table")
        debugPrint(7,
            "Key : {" .. type(sub_key) .. "} [" .. sub_key .. "]  Value : (" .. type(sub_val) .. ") <" .. string.pstring(sub_val) .. ">",
            nil, "create_shaped_table")
        if flc then
          new_sub_key = string.lower(sub_key)
        else
          new_sub_key = sub_key
        end
        debugPrint(7,
            "Setting new key : {" .. type(new_sub_key) .. "} [" .. new_sub_key .. "]  Value : (" .. type(sub_val) .. ") <" .. string.pstring(sub_val) .. ">",
            nil, "create_shaped_table")
        --debugPrint(7, "Setting new key : " .. new_sub_key, nil, "create_shaped_table")
        sub_table[new_sub_key] = sub_val
      end
      for key, value in pairs(in_table.shape) do
        sub_table[key] = value
      end
      out_table[i] = sub_table
    end
    return out_table
  else
    return in_table
  end
end

function check_matching_values(in_dict, match_value)
  local matches = 0
  local mismatches = 0
  local out_table = {}
  local matched_keys = {}
  local mismatched_keys = {}
  assert(in_dict and match_value, "Need both an associative table and a value to check")
  for key, value in pairs(in_dict) do
    if value == match_value then
      matches = matches + 1
      matched_keys[#matched_keys + 1] = key
    else
      mismatched_keys[#mismatched_keys + 1] = key
      mismatches = mismatches + 1
    end
  end
  out_table.matched_keys = matched_keys
  out_table.mismatched_keys = mismatched_keys
  out_table.matched_count = matches
  out_table.mismatch_count = mismatches
  out_table.key_count = matches + mismatches
  return out_table
end

function range_string_to_number_list(in_string)
  debugPrint(9, "In string : " .. in_string, nil, "range_string_to_number_list")
  local start_num, end_num
  local number_table = {}
  local iteration = 1
  local split_string = string.split(in_string, ":")
  if #split_string > 1 then
    start_num = tonumber(split_string[1])
    end_num = tonumber(split_string[2])
    for i = start_num, end_num do
      number_table[iteration] = i
      iteration = iteration + 1
    end
    return number_table
  else
    return { in_string }
  end
end

function create_number_list(numbers)
  -- -- -- Begin test
  if numbers == "__test__" then
    local test_numbers = {
      { 1, 2, "3:7" },
      { 10, 11, "15:21" },
      23,
      27,
      { 29, 30 },
      { 31 },
    }
    print("[INFO] Running test version of create_number_list() with following table")
    recursive_print(test_numbers)
    print("[INFO] Resulting table")
    local expected = { 1, 2, 3, 4, 5, 6, 7, 10, 11, 15, 16, 17, 18, 19, 20, 21, 23, 27, 29, 30, 31 }
    local result = create_number_list(test_numbers)
    recursive_print(result)
    print("[INFO] Comparing actual result with expected result")
    if deep_compare(expected, result) then
      print("[INFO] Actual result and expected result match. create_number_list('__test__') complete")
    else
      print("[WARN] Actual result and expected result do not match. create_number_list('__test__') failed")
    end
    test_timer(create_number_list, 0, true, test_numbers)
    return
  end
  -- -- -- End test

  local number_list = {}
  if type(numbers) == "table" then
    for i = 1, #numbers do
      local sub_list
      if type(numbers[i]) == "table" then
        sub_list = create_number_list(numbers[i])
      elseif type(numbers[i]) == "string" then
        sub_list = range_string_to_number_list(numbers[i])
      elseif type(numbers[i]) == "number" then
        number_list[#number_list + 1] = numbers[i]
      end
      if sub_list then
        for j = 1, #sub_list do
          number_list[#number_list + 1] = sub_list[j]
        end
      end
    end
  end
  if type(numbers) == "string" then
    local sub_list = range_string_to_number_list(numbers)
    for i = 1, #sub_list do
      number_list[#number_list + 1] = sub_list[i]
    end
  end
  return number_list
end

function get_dictionary_length(in_dict)
  local counter = 0
  for key, value in pairs(in_dict) do
    counter = counter + 1
  end
  return counter
end

function create_numbered_table(number_list, string_list)
  -- -- -- Begin test
  if number_list == "__test__" then
    local test_numbers = { 1, 3, 5, 7, 9, 10, 12, 14, 16, 20 }
    local test_strings = { "1", "3", "5", "7", "9", "10", "12", "14", "16", "20" }
    print("[INFO] Running test version of create_numbered_table() with following tables")
    recursive_print(test_numbers)
    recursive_print(test_strings)
    print("[INFO] Resulting table")
    local result = create_numbered_table(test_numbers, test_strings)
    local expected = { { 1, "1" }, { 3, "3" }, { 5, "5" }, { 7, "7" }, { 9, "9" }, { 10, "10" }, { 12, "12" }, { 14, "14" }, { 16, "16" }, { 20, "20" } }
    recursive_print(result)
    print("[INFO] Comparing actual result with expected result")
    if deep_compare(expected, result) then
      print("[INFO] Actual result and expected result match. create_number_list('__test__') complete")
    else
      print("[WARN] Actual result and expected result do not match. create_number_list('__test__') failed")
    end
    print("Testing run time")
    --local test_func = create_numbered_table
    --local test_params = table.unpack({test_numbers, test_strings})
    --local test_iterations = 1000000
    --test_timer(test_func, test_iterations, true, test_params)
    test_timer(create_numbered_table, 0, true, table.unpack({ test_numbers, test_strings }))
    return
  end
  -- -- -- End test
  local out_table = {}
  debugPrint(5, "Number list and string list", nil, "create_numbered_table")
  if debug_verbosity > 5 then
    recursive_print(number_list);
    recursive_print(string_list)
  end
  assert(#number_list == #string_list, "Number list and string list have different lengths")
  for i = 1, #number_list do
    out_table[#out_table + 1] = { number_list[i], string_list[i] }
  end
  return out_table
end

function join_tables(...)
  -- -- -- Begin test
  if (select(1, ...)) == "__test__" then
    local test_tables = {
      { 1, 2, 3, 4, 5 },
      { 6, 7, 8, 9, 10 },
      { "a", "b", "c" },
      { { "first", 1 }, { "second", 2 }, "third" },
    }
    print("[INFO] Running test version of create_numbered_table() with following tables")
    recursive_print(test_tables)
    local result = join_tables(table.unpack(test_tables))
    local expected = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "a", "b", "c", { "first", 1, }, { "second", 2, }, "third" }
    print("[INFO] Resulting table")
    recursive_print(result)
    print("[INFO] Comparing actual result with expected result")
    if deep_compare(expected, result) then
      print("[INFO] Actual result and expected result match. create_number_list('__test__') complete")
    else
      print("[WARN] Actual result and expected result do not match. create_number_list('__test__') failed")
      return
    end
    print("Testing run time")
    --local test_func = join_tables
    --local test_params = table.unpack(test_tables)
    --local test_iterations = 1000000
    --test_timer(test_func, test_iterations, true, test_params)
    --test_timer(join_tables, 100000, true, table.unpack(test_tables))
    test_timer(join_tables, 0, true, table.unpack(test_tables))
    return
  end
  -- -- -- End test
  local first = (select(1, ...))
  local num_tables = select("#", ...)
  if num_tables > 1 then
    for i = 2, num_tables do
      local cur_table = (select(i, ...))
      for j = 1, #cur_table do
        local cur_elem = cur_table[j]
        --if type(cur_elem) == "table" then
        --  local sub_table = join_tables(cur_elem)
        --  for k = 1, #sub_table do
        --    print("join_tables recursion")
        --    first[#first + 1] = sub_table[k]
        --  end
        --end
        first[#first + 1] = cur_elem
      end
    end
  end
  --print("completed")
  return first
end

function table.flatten(arr)
  local result = { }

  local function flatten(arr)
    for _, v in ipairs(arr) do
      if type(v) == "table" then
        flatten(v)
      else
        table.insert(result, v)
      end
    end
  end

  flatten(arr)
  return result
end

function table.zip(...)
  -- -- -- Begin test
  if select("#", ...) == 1 and (select(1, ...)) == "__test__" then
    local test_tables = { { 1, 2, 3 }, { "4", "5", "6" }, { 7, "8", 9, "10" }, { "11", { 12, 13, 14 }, 15, "16, 17" } }
    print("[INFO] Running test version of table.zip() with following table")
    recursive_print(test_tables)
    print("[INFO] Resulting table")
    local expected = { { 1, "4", 7, "11" }, { 2, "5", "8", { 12, 13, 14 } }, { 3, "6", 9, 15 }, { "10", "16, 17" } }
    local result = table.zip(table.unpack(test_tables))
    print(string.pstring(result, nil, nil, true))
    recursive_print(result)
    print("[INFO] Comparing actual result with expected result")
    if deep_compare(expected, result) then
      print("[INFO] Actual result and expected result match. table.zip('__test__') complete")
    else
      print("[WARN] Actual result and expected result do not match. table.zip('__test__') failed")
    end
    print("Testing run time")
    test_timer(table.zip, 0, true, table.unpack(test_tables))
    return
  end
  -- -- -- End test

  local longest_table_length = 0
  for i = 1, select("#", ...) do
    local current_table_length = #(select(i, ...))
    if current_table_length > longest_table_length then
      longest_table_length = current_table_length
    end
  end
  local out_table = {}
  for i = 1, longest_table_length do
    local sub_table = {}
    for j = 1, select("#", ...) do
      local value = (select(j, ...))[i] or nil
      --sub_table[j] = value
      sub_table[#sub_table + 1] = value
    end
    out_table[i] = sub_table
  end
  return out_table
end

function table.contains(t, value)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Returns true if the table contains the specified value.
  for _, v in pairs(t) do
    if (v == value) then
      return true
    end
  end
  return false
end

function table.extract(arr, fname)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Enumerates an array of objects and returns a new table containing
  -- only the value of one particular field.
  local result = { }
  for _, v in ipairs(arr) do
    table.insert(result, v[fname])
  end
  return result
end

function table.flatten(arr)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Flattens a hierarchy of tables into a single array containing all
  -- of the values.
  local result = { }

  local function flatten(arr)
    for _, v in ipairs(arr) do
      string.pstring(_)
      string.pstring(v)
      if type(v) == "table" then
        flatten(v)
      else
        table.insert(result, v)
      end
    end
  end

  flatten(arr)
  return result
end

function table.implode(arr, before, after, between)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Merges an array of items into a string.
  local result = ""
  for _, v in ipairs(arr) do
    if (result ~= "" and between) then
      result = result .. between
    end
    result = result .. before .. v .. after
  end
  return result
end

function table.insertflat(tbl, values)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Inserts a value of array of values into a table. If the value is
  -- itself a table, its contents are enumerated and added instead. So
  -- these inputs give these outputs:
  --   "x" -> { "x" }
  --   { "x", "y" } -> { "x", "y" }
  --   { "x", { "y" }} -> { "x", "y" }
  if type(values) == "table" then
    for _, value in ipairs(values) do
      table.insertflat(tbl, value)
    end
  else
    table.insert(tbl, values)
  end
end

function table.isempty(t)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Returns true if the table is empty, and contains no indexed or keyed values.
  return next(t) == nil
end

function table.join(...)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Adds the values from one array to the end of another and
  -- returns the result.
  local result = { }
  for _, t in ipairs(arg) do
    if type(t) == "table" then
      for _, v in ipairs(t) do
        table.insert(result, v)
      end
    else
      table.insert(result, t)
    end
  end
  return result
end

function table.keys(tbl)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Return a list of all keys used in a table.
  local keys = {}
  for k, _ in pairs(tbl) do
    table.insert(keys, k)
  end
  return keys
end

function table.merge(...)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Adds the key-value associations from one table into another
  -- and returns the resulting merged table.
  local result = { }
  for _, t in ipairs(arg) do
    if type(t) == "table" then
      for k, v in pairs(t) do
        result[k] = v
      end
    else
      error("invalid value")
    end
  end
  return result
end

function table.translate(arr, translation)
  -- Source : https://github.com/premake/premake-4.x/blob/master/src/base/table.lua
  -- Translates the values contained in array, using the specified
  -- translation table, and returns the results in a new array.
  local result = { }
  for _, value in ipairs(arr) do
    local tvalue
    if type(translation) == "function" then
      tvalue = translation(value)
    else
      tvalue = translation[value]
    end
    if (tvalue) then
      table.insert(result, tvalue)
    end
  end
  return result
end

function deep_compare(t1, t2, ignore_mt)
  -- Source : https://web.archive.org/web/20131225070434/http://snippets.luacode.org/snippets/Deep_Comparison_of_Two_Values_3
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  -- non-table types can be directly compared
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then return t1 == t2 end
  for k1, v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not deep_compare(v1, v2) then return false end
  end
  for k2, v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not deep_compare(v1, v2) then return false end
  end
  return true
end

table.print = recursive_print

-- STOP_INCLUDE
