-- START_INCLUDE
function debug_setter(debug_var)
  local debug_var = debug_var or debug_verbosity
  local max_val = 10
  local min_val = 0
  local user_input = inputQuery(
          "Set debugging level",
          "Enter new debugging level (from 0 to 10) or press Escape key to set to 0.\n*** WARNING: setting this to 10 will show EVERY debug message ***",
          "1"
  )
  if user_input == nil then
    debug_var = min_val
  else
    local lev = tonumber(user_input)
    if lev < min_val then
      debug_var = min_val
    elseif lev > max_val then
      debug_var = max_val
    else
      debug_var = lev
    end

    if debug_var > min_val then
      print("Setting debug level to " .. debug_var)
    end
  end
  return debug_var
end

function debug_print(minimum_debug_level, debug_message, debug_level, caller_name)
  local dbl = debug_level or debug_verbosity or 0
  local name
  if caller_name == nil then
    name = ""
  else
    name = "[" .. caller_name .. "]  "
  end
  if dbl >= minimum_debug_level then
    print(name .. debug_message)
  end
end

function print_function_parameters(function_args, function_name)
  local fn = function_name or "func"
  for key, value in pairs(function_args) do
    if type(value) == "table" then
      print("( " .. fn .. " ) [ " .. tostring(key) .. " ] { " .. type(value) .. " } ")
      recursive_print(value)
    else
      print("( " .. fn .. " ) [ " .. tostring(key) .. " ] { " .. type(value) .. " } " .. tostring(value))
    end
  end
end

function test_error(error_type)
  if string.lower(error_type) == "assertion" or string.lower(error_type) == "assert" then
    assert(1 == 2, "Test assertion error")
  else
    error(error_type)
  end
end

function dumb_timer(function_name, run_iterations, ...)
  debug_print(1, "Iterations : " .. run_iterations, nil, "dumb_timer")
  local start_time, end_time, test_time
  start_time = os.clock()
  for i = 1, run_iterations do
    function_name(select(1, ...))
  end
  end_time = os.clock()
  test_time = end_time - start_time
  return test_time
end

function test_timer(function_name, test_iterations, print_result, ...)
  local iterations = test_iterations or 0
  local do_print = print_result or false
  debug_print(1, "Function name : " .. tostring(function_name), nil, "test_timer")
  debug_print(1, "Function iterations : " .. tostring(iterations), nil, "test_timer")
  debug_print(1, "Print : " .. tostring(do_print), nil, "test_timer")
  -- dynamic iterations
  if test_iterations == 0 then
    local base_ = 10
    local max_exponent = 10
    local time_threshold = 1 -- max number of seconds to spend timing
    local check_time
    local quit_on_next_loop = false
    i_ = 0
    iterations = math.floor(base_ ^ i_)
    print("Running smart iterations. Target time : " .. time_threshold .. " seconds")
    for i = 0, max_exponent do
      if quit_on_next_loop then
        print(i + 1 .. " : Running " .. cv(iterations, true) .. " iterations")
        check_time = dumb_timer(function_name, iterations, ...)
        print("Completed in " .. check_time .. " seconds")
        print("Averaged " .. (check_time / iterations) .. " seconds per run")
        return
      end
      print(i + 1 .. " : Running " .. cv(iterations, true) .. " iterations")
      check_time = dumb_timer(function_name, iterations, ...)
      print("Completed in " .. check_time .. " seconds")
      if check_time > time_threshold then
        print("Averaged " .. (check_time / iterations) .. " seconds per run")
        return
      elseif (check_time * base_) > time_threshold then
        iterations = time_threshold / (check_time / iterations)
        quit_on_next_loop = true
        --print(iterations)
      else
        i_ = i_ + 1
        iterations = math.floor(base_ ^ i_)
      end
    end
  else
    dumb_timer(function_name, iterations, ...)
  end
  if do_print then
    print("Ran test " .. cv(iterations) .. " times.\nCompleted in " .. test_time .. " seconds")
  end
  return test_time
end

function test_suite()
  create_number_list("__test__")
  create_numbered_table("__test__")
  join_tables("__test__")
  table.zip("__test__")
end

function wt(some_object)
  print(type(some_object))
  return type(some_object)
end

function selected_tn()
  local atv = AddressList.Component[0]
  local tn = atv.Selected
  if tn then
    print("TreeNode Index : " .. string.pstring(tn.Index))
    print("Text: " .. string.pstring(tn.Text))
    print("Parent: " .. string.pstring(tn.Parent))
    print("Level: " .. string.pstring(tn.Level))
    print("HasChildren: " .. string.pstring(tn.HasChildren))
    print("Expanded: " .. string.pstring(tn.Expanded))
    print("Count : " .. string.pstring(tn.Count))
    print("Items[]: " .. string.pstring(tn.Items))
    print("Index: " .. string.pstring(tn.Index))
    print("AbsoluteIndex: " .. string.pstring(tn.AbsoluteIndex))
    print("Selected: " .. string.pstring(tn.Selected))
    print("MultiSelected: " .. string.pstring(tn.MultiSelected))
    print("Data: " .. string.pstring(tn.Data))
  end
end
-- STOP_INCLUDE
