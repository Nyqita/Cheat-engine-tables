function handle_matrices(args)
  assert(1 == 0, "Don't call handle_matrices : not implemented")
  -- -- -- Begin test
  if args == "__test__" then

    local expected
    local result

    print("[INFO] Comparing actual result with expected result")
    if deep_compare(expected, result) then
      print("[INFO] Actual result and expected result match. create_number_list('__test__') complete")
    else
      print("[WARN] Actual result and expected result do not match. create_number_list('__test__') failed")
    end
    test_timer(handle_matrices, 0, true, test_numbers)
    return
  end
  -- -- -- End test

  debugPrint(3, "Matrices tables:\n" .. string.pstring(matrices), nil, "lazyChildMaker")
  -------------------------------------------
  -- should receive tables like the following
  local char_names = {
    "Cloud",
    "Barret",
    "Tifa",
    "Aeris",
    "Red XIII",
    "Cait Sith",
    "Vincent",
    "Cid / past Sephiroth",
  }
  matrices.x_name = "Names"
  matrices.x_table = lazy_tables_maker(char_names, 0, 0x84, "offset", "description")
  --matrices.x_labels = { "first name", "second name", "third name" }
  -- i'm assuming that a table of tables has its order preserved, even though a table of key, values doesn't
  matrices.x_labels = {}
  for i = 1, #matrices.x_table do
    matrices.x_labels[i] = matrices.x_table[i].description
  end

  matrices.y_name = "Stats"
  matrices.y_table = {
    { offset = 42, type = 1, description = "Current HP" },
    { offset = 44, type = 1, description = "Maximum HP" },
    { offset = 46, type = 1, description = "Current MP" },
    { offset = 48, type = 1, description = "Maximum MP" },
    { offset = 0, type = 0, description = "Raw Strength" },
    { offset = 4, type = 0, description = "Raw Dexterity" },
    { offset = 1, type = 0, description = "Raw Vitality" },
    { offset = 2, type = 0, description = "Raw Magic" },
    { offset = 3, type = 0, description = "Raw Spirit" },
    { offset = 5, type = 0, description = "Raw Luck" },
    { offset = 6, type = 0, description = "Supplemented Strength" },
    { offset = 10, type = 0, description = "Supplemented Dexterity" },
    { offset = 7, type = 0, description = "Supplemented Vitality" },
    { offset = 8, type = 0, description = "Supplemented Magic" },
    { offset = 9, type = 0, description = "Supplemented Spirit" },
    { offset = 11, type = 0, description = "Supplemented Luck" },
    { offset = -1, type = 0, description = "Current Level" },
    { offset = 12, type = 0, description = "Selected Limit Level" },
    { offset = 14, type = "FF7 String", description = "Name" },
    { offset = 31, type = 0, description = "??" },
    { offset = 32, type = 0, description = "??" },
    { offset = 33, type = 0, description = "Final Limit Break?" },
    { offset = 34, type = 1, description = "Kills" },
    { offset = 36, type = 0, description = "Times limit 1 used" },
    { offset = 38, type = 0, description = "Times limit 2 used" },
    { offset = 40, type = 0, description = "Times limit 3 used" },
    { offset = 54, type = 1, description = "?? HP" },
    { offset = 56, type = 1, description = "?? MP" },
  }
  matrices.y_labels = {}
  for i = 1, #matrices.y_table do
    matrices.y_labels[i] = matrices.y_table[i].description
  end

  -------------------------------------------
  local mat_x, mat_y = lazy_matrix_maker(matrices.x_table, matrices.y_table)

  local x_axis_name = matrices.x_name
  local x_length = #mat_x
  local y_axis_name = matrices.y_name
  local y_length = #mat_y

  -- how should the entries be built?
  -- 1 means creating children with X and grandchildren with Y
  -- 2 means creating children with Y and grandchildren with X
  -- 0 means creating both of the above as children ( ultimately creating great-grandchildren )
  local build
  if string.lower(matrices.build == "x") or matrices.build == "1" then
    build = 1
  elseif string.lower(matrices.build == "y") or matrices.build == "2" then
    build = 2
  elseif string.lower(matrices.build == "both") or matrices.build == "0" then
    build = 0
  end

  if build == 0 then
    local x = getAddressList().createMemoryRecord()
    x.Description = "Organised by " .. x_axis_name
    local y = getAddressList().createMemoryRecord()
    y.Description = "Organised by " .. y_axis_name
    for i = 1, #matrices.x.descriptions do
      local x_d = matrices.x.descriptions[i]
      local e = getAddressList().createMemoryRecord()
      e.Description = matrices.x.descriptions[i]
      for j = 1, #matrices.y.descriptions do
        local y_d = matrices.y.descriptions[j]
        local f = getAddressList().createMemoryRecord()
        set_memory_record(f, { off = mat_x[x_d][y_d] }, base_address + base_offset)
        f.appendToEntry(e)
      end
      e.appendToEntry(x)
    end
    for i = 1, #matrices.y.descriptions do
      local y_d = matrices.y.descriptions[i]
      local e = getAddressList().createMemoryRecord()
      e.Description = matrices.y.descriptions[i]
      for j = 1, #matrices.x.descriptions do
        local x_d = matrices.x.descriptions[j]
        local f = getAddressList().createMemoryRecord()
        set_memory_record(f, { off = mat_y[y_d][x_d] }, base_address + base_offset)
        f.appendToEntry(e)
      end
      e.appendToEntry(x)
    end
    x.appendToEntry(par)
    y.appendToEntry(par)
  end

  for i = 0, #matrices - 1 do
    local e = getAddressList().createMemoryRecord()
    set_memory_record(e, args_table[i + 1], base_address + base_offset)
    e.appendToEntry(par)
  end
  return
end

function lazy_merge_cells(x_table, y_table)
  assert(1 == 0, "Don't call lazy_merge_cells : not implemented")
  -- todo normalise key names first
  local out_table = xt
  for key, value in pairs(yt) do
    debugPrint(9, "Old value : " .. tostring(value), nil, "mergeCells")
    local val_type = type(value)
    local new_value
    if val_type == "table" then
      new_value = add_tables(out_table[key], yt[key])
    elseif val_type == "number" then
      new_value = out_table[key] + yt[key]
    elseif val_type == "string" then
      new_value = out_table[key] .. " | " .. yt[key]
    end
    debugPrint(9, "New value : " .. new_value, nil, "mergeCells")
    out_table[key] = new_value
  end
end

function lazy_tables_maker(labels_list, base_val, value_inc, value_name, label_name)
  --assert(1 == 0, "Don't call lazy_tables_maker : not implemented")
  local out_table = {}
  --out_table["keys_list"] = labels_list
  local base_value = base_val or 0
  local value_increment = value_inc or 1
  local value = value_name or "value"
  local label = label_name or "label"
  for i = 1, #labels_list do
    local sub_table = {}
    sub_table[value] = base_value + (value_increment * (i - 1))
    sub_table[label] = labels_list[i]
    out_table[i] = sub_table
  end
  return out_table
end

function lazy_matrix_maker(axis_1, axis_2)
  assert(1 == 0, "Don't call lazy_matrix_maker : not implemented")
  -- todo THIS TURNED INTO A HUGE MESS. START FROM SCRATCH?
  local axis_x, axis_y
  local testing = false
  local old_debug_level = debug_
  if type(axis_1) == "string" and string.lower(axis_1) == "test" then
    testing = true
    -- testing code
    -- test tables show two types of expected table parameter
    -- e.g. a 'dumb' table with properties 'offsets' and 'descriptions' OR
    -- a 'smart' table containing tables, each sub-table having properties 'off', 'desc', etc.
    print("[TEST] *** Running lazyMatrixMaker() in test mode ***")
    axis_x = { offsets = 0x80, descriptions = { "name1", "name2", "name3", } }
    axis_y = {
      { off = 0x0, desc = "attr1" },
      { off = 0x2, desc = "attr2" },
      { off = 0x6, desc = "attr3" },
    }
  else
    axis_x, axis_y = axis_1, axis_2
  end

  if debug_verbosity > 3 then
    debugPrint(3, "Table X", nil, "lazyMatrixMaker")
    recursive_print(axis_x)
    debugPrint(3, "Table Y", nil, "lazyMatrixMaker")
    recursive_print(axis_y)
  end

  local axis_x_iterations
  local axis_y_iterations
  local x_has_desc = axis_x.descriptions and axis_x.descriptions[1]
  local x_has_off = axis_x.offsets
  local y_has_desc = axis_y.descriptions and axis_y.descriptions[1]
  local y_has_off = axis_y.offsets

  if x_has_desc then
    --if axis_x.descriptions[1] then
    debugPrint(5, "Axis X has descriptions table", nil, "lazyMatrixMaker")
    axis_x_iterations = #axis_x.descriptions
    --end
  elseif type(axis_x[1]) == "table" then
    debugPrint(5, "Axis X does not have descriptions table", nil, "lazyMatrixMaker")
    axis_x_iterations = #axis_x
  else
    print("[ERROR] COULDN'T DETERMINE LENGTH OF AXIS X. YOU SHOULDN'T HAVE REACHED THIS CODE")
  end

  if y_has_desc then
    --if axis_y.descriptions[1] then
    debugPrint(5, "Axis Y has descriptions table", nil, "lazyMatrixMaker")
    axis_y_iterations = #axis_y.descriptions
    --end
  elseif type(axis_y[1]) == "table" then
    debugPrint(5, "Axis Y does not have descriptions table", nil, "lazyMatrixMaker")
    axis_y_iterations = #axis_y
  else
    print("[ERROR] COULDN'T DETERMINE LENGTH OF AXIS Y. YOU SHOULDN'T HAVE REACHED THIS CODE")
  end

  debugPrint(5, "Axis X iterations : " .. nb(axis_x_iterations), nil, "lazyMatrixMaker")
  debugPrint(5, "Axis Y iterations : " .. nb(axis_y_iterations), nil, "lazyMatrixMaker")
  local tbl_1 = {}
  local tbl_2 = {}

  -- OUTER LOOP FOR X AXIS
  for i = 1, axis_x_iterations do
    debugPrint(5, "Axis X iteration : " .. i, nil, "lazyMatrixMaker")
    if x_has_desc then
      name_x = axis_x.descriptions[i]
    else
      name_x = axis_x[i].desc
    end

    if x_has_off then
      offset_x = axis_x.offsets * (i - 1)
    else
      offset_x = axis_x[i].off
    end
    debugPrint(7, "X Name : " .. name_x, nil, "lazyMatrixMaker")
    debugPrint(7, "X Offset : " .. offset_x, nil, "lazyMatrixMaker")

    tbl_1[name_x] = {}

    -- INNER LOOP FOR Y AXIS
    for j = 1, axis_y_iterations do
      if y_has_desc then
        name_y = axis_y.descriptions[j]
      else
        name_y = axis_y[j].desc
      end

      if y_has_off then
        offset_y = axis_y.offsets * (j - 1)
      else
        offset_y = axis_y[j].off
      end

      debugPrint(7, "Y Name : " .. name_y, nil, "lazyMatrixMaker")
      debugPrint(7, "Y Offset : " .. offset_y, nil, "lazyMatrixMaker")

      if tbl_2[name_y] == nil then
        tbl_2[name_y] = {}
      end

      tbl_1[name_x][name_y] = {}
      tbl_2[name_y][name_x] = {}

      local cur_offset = offset_x + offset_y
      tbl_1[name_x][name_y] = cur_offset
      tbl_2[name_y][name_x] = cur_offset

    end

  end
  if testing then
    print("TABLE X")
    recursive_print(tbl_1)
    print("TABLE Y")
    recursive_print(tbl_2)
    debug_verbosity = old_debug_level
  end
  return tbl_1, tbl_2
end

-- START_INCLUDE

function lazy_write_timer(args, timer_object)
  local num_children = setOptional(args.number_of_children, 1, "number")
  local base_address = setOptional(args.base_address, 0, "number")
  local base_offset = setOptional(args.base_offset, 0, "number")
  local base_increment = setOptional(args.base_increment, 4, "number")
  local offset_increment = setOptional(args.offset_increment, 4, "number")
  local base_value = setOptional(args.base_value, 99, "number")
  local value_increment = setOptional(args.value_increment, 0, "number")
  local write_interval = setOptional(args.write_interval, 100, "number", { 10, 60000 }, true)
  local max_value = setOptional(args.max_value, 100, "number")
  local min_value = setOptional(args.min_value, 1, "number")
  local value_type = setOptional(args.type, 0, "number")
  local values_table = setOptional(args.values_table, nil, "table")

  if debug_verbosity > 0 then
    debugPrint(3, "Debug output for lazyWriteTimer function", nil, "lazyWriteTimer")
    debugPrint(3, "Number of child entries : " .. nb(num_children), nil, "lazyWriteTimer")
    debugPrint(3, "Base address : " .. nb(base_address), nil, "lazyWriteTimer")
    debugPrint(3, "Base offset : " .. nb(base_offset), nil, "lazyWriteTimer")
    debugPrint(3, "Base increment : " .. nb(base_increment), nil, "lazyWriteTimer")
    debugPrint(3, "Offset increment : " .. nb(offset_increment), nil, "lazyWriteTimer")
    debugPrint(3, "Offsets :", nil, "lazyWriteTimer")
    debugPrint(3, string.pstring(offsets_table))
    if debug_verbosity >= 3 then
      recursive_print(offsets_table)
    end
    debugPrint(3, "Base value : " .. nb(base_value), nil, "lazyWriteTimer")
    debugPrint(3, "Value increment :  " .. nb(value_increment), nil, "lazyWriteTimer")
    debugPrint(3, "Minimum value : " .. nb(min_value), nil, "lazyWriteTimer")
    debugPrint(3, "Maximum value : " .. nb(max_value), nil, "lazyWriteTimer")
  end

  local timer = setOptional(timer_object, createTimer(nil, false))
  timer.Interval = setOptional(args.interval, write_interval)
  timer.OnTimer = function(timer)
    local cur_add
    local cur_val
    if values_table then
      -- expects values_table to be { { offset1 , value1 } , { offset2 , value2 } , etc }
      for i = 1, #values_table do
        cur_add = base_address + base_offset + values_table[i][1]
        cur_val = values_table[i][2]
        debugPrint(5, "Address : " .. nb(cur_add) .. "  Value : " .. nb(cur_val), nil, "lazyWriteTimer")
        if value_type == 1 then
          writeSmallInteger(cur_add, cur_val)
        elseif value_type == 2 then
          writeInteger(cur_add, cur_val)
        elseif value_type == 3 then
          writeQword(cur_add, cur_val)
        else
          writeBytes(cur_add, to_byte_string(cur_val))
        end
      end
    else
      for i = 0, num_children - 1 do
        cur_add = base_address + base_offset + (base_increment * i)
        cur_val = base_value + (value_increment * i)
        debugPrint(5, "Address : " .. nb(cur_add) .. "  Value : " .. nb(cur_val), nil, "lazyWriteTimer")
        if value_type == 1 then
          writeSmallInteger(cur_add, cur_val)
        elseif value_type == 2 then
          writeInteger(cur_add, cur_val)
        elseif value_type == 3 then
          writeQword(cur_add, cur_val)
        else
          writeBytes(cur_add, to_byte_string(cur_val))
        end
      end
    end
    -- timer.Enabled = true
  end
  return timer
end

function lazy_child_maker(args)
  if debug_verbosity > 9 then
    printFunctionParameters(args, "lazyChildMaker")
  end
  local par = args.parent
  local num_children = setOptional(args.number_of_children, 3)
  local base_address = setOptional(args.base_address, 0)
  local base_offset = setOptional(args.base_offset, 0)
  local base_increment = setOptional(args.base_increment, 0)
  local offset_increment = setOptional(args.offset_increment, 4)
  local offsets_table = setOptional(args.offsets, {})
  local base_value = setOptional(args.base_value, 1)
  local value_increment = setOptional(args.value_increment, 0)
  local max_value = setOptional(args.max_value, 100)
  local min_value = setOptional(args.min_value, 1)
  local descr_table = setOptional(args.descriptions_list, {})
  local matrices = setOptional(args.matrices, nil)
  local args_table = setOptional(args.args_table, {})
  local desc_prepend = setOptional(args.desc_prepend, "Entry ")
  local desc_append = setOptional(args.desc_append, "")
  local dropdown_linked = setOptional(args.dropdown_linked, nil)
  -- Variable type reference: https://wiki.cheatengine.org/index.php?title=Lua:Class:MemoryRecord#Properties
  local var_type = setOptional(args.type, 2)
  local custom_type_name = setOptional(args.custom_type_name, nil)
  local nested = setOptional(args.nested, nil)
  local options = setOptional(args.options, nil)
  local collapse_parent = setOptional(args.collapse_parent, false)

  if descr_table[1] then
    num_children = #descr_table
  end

  if debug_verbosity > 0 then
    debugPrint(3, "Debug output for LazyChildMaker function", nil, "lazyChildMaker")
    debugPrint(1, "Trying to generate child entries for " .. par.description, nil, "lazyChildMaker")
    debugPrint(1, "ID : " .. par.ID, nil, "lazyChildMaker")
    debugPrint(3, "Number of child entries : " .. nb(num_children), nil, "lazyChildMaker")
    debugPrint(3, "Base address : " .. nb(base_address), nil, "lazyChildMaker")
    debugPrint(3, "Base offset : " .. nb(base_offset), nil, "lazyChildMaker")
    debugPrint(3, "Base increment : " .. nb(base_increment), nil, "lazyChildMaker")
    debugPrint(3, "Offset increment : " .. nb(offset_increment), nil, "lazyChildMaker")
    debugPrint(3, "Offsets :", nil, "lazyChildMaker")
    debugPrint(3, string.pstring(offsets_table))
    if debug_verbosity >= 3 then
      recursive_print(offsets_table)
    end
    debugPrint(3, "Base value : " .. nb(base_value), nil, "lazyChildMaker")
    debugPrint(3, "Value increment :  " .. nb(value_increment), nil, "lazyChildMaker")
    debugPrint(3, "Minimum value : " .. nb(min_value), nil, "lazyChildMaker")
    debugPrint(3, "Maximum value : " .. nb(max_value), nil, "lazyChildMaker")
    debugPrint(3, "Descriptions list:", nil, "lazyChildMaker")
    if debug_verbosity >= 3 then
      recursive_print(descr_table)
    end
    debugPrint(3, string.pstring(descr_table))
    debugPrint(3, "Size : " .. nb(var_type), nil, "lazyChildMaker")
    debugPrint(3, "Nested : " .. tostring(nested), nil, "lazyChildMaker")
  end

  if matrices and (type(matrices) == "table") and pairs(matrices) then
    handle_matrices(args)
  end

  if args_table[1] then
    if debug_verbosity > 3 then
      debugPrint(3, "Arguments table length : " .. #args_table, nil, "lazyChildMaker")
      recursive_print(args_table)
    end
    for i = 0, #args_table - 1 do
      local e = getAddressList().createMemoryRecord()
      set_memory_record(e, args_table[i + 1], base_address + base_offset, par)
      --e.appendToEntry(par)
    end
    return
  end

  for i = 0, num_children - 1 do
    debugPrint(5, "Iteration : " .. nb(i), nil, "lazyChildMaker")
    local e = getAddressList().createMemoryRecord()
    -- check if descr_table is a table of tables
    if type(descr_table[i + 1]) == "string" then
      e.description = descr_table[i + 1]
    else
      e.description = desc_prepend .. i + 1 .. desc_append
    end

    local cur_add
    if i == 0 then
      cur_add = base_address + base_offset
    else
      cur_add = base_address + base_offset + (base_increment * i)
    end
    debugPrint(5, "Address : " .. nb(cur_add), nil, "lazyChildMaker")
    e.address = cur_add
    local curval = nil
    if base_value then
      curval = base_value
      if value_increment then
        curval = curval + (value_increment * i)
      end
    end
    if curval then
      debugPrint(5, "Current value : " .. nb(curval), nil, "lazyChildMaker")
      if args.base_value then
        if args.max_value or args.min_value then
          e.value = (curval % (1 + max_value - min_value)) + min_value
        else
          e.value = curval
        end
      end
    end
    if offsets_table[1] then
      debugPrint(1, "Offsets list has length greater than 0", nil, "lazyChildMaker")
      e.address = base_address + base_offset
      e.setOffsetCount(#offsets_table)
      for j = 1, (#offsets_table) do
        e.setOffset(j - 1, offsets_table[j])
      end
      local val = offsets_table[#offsets_table] + (i * offset_increment)
      e.setOffset((#offsets_table - 1), val)
    end
    local desc, off, type_
    if type(descr_table[i + 1]) == "table" then
      debugPrint(
          3,
          "Description " .. i + 1 .. " is a table.  Length : " .. nb(#descr_table[i + 1]),
          nil,
          "lazyChildMaker"
      )
      if debug_verbosity >= 5 then
        recursive_print(descr_table[i + 1])
      end

      if #descr_table[i + 1] == 3 then
        -- assumes table is {offset, type, description}
        off, type_, desc = descr_table[i + 1][1], descr_table[i + 1][2], descr_table[i + 1][3]
        debugPrint(
            7,
            "Offset : " .. nb(off) .. "  Type : " .. type_ .. "  Description : " .. desc,
            nil,
            "lazyChildMaker"
        )
      elseif #descr_table[i + 1] == 2 then
        -- assumes table is either {offset, description} or {description, offset}
        local first, second = descr_table[i + 1][1], descr_table[i + 1][2]
        debugPrint(7, "First : " .. first .. "  Second : " .. second, nil, "lazyChildMaker")

        if ((type(first) == "number") and (type(second) == "string")) then
          off, desc = first, second
        elseif ((type(first) == "string") and (type(second) == "number")) then
          off, desc = second, first
        end

      else
        off = descr_table[i + 1].off
        desc = descr_table[i + 1].desc

      end

      if val then
        e.setOffset((#offsets_table - 1), off)
      else
        e.address = base_address + base_offset + off
      end
      e.description = desc
    end
    debugPrint(5, "Type is : " .. type(type_) .. "  Value : " .. tostring(type_), nil, "lazyChildMaker")

    if custom_type_name then
      debugPrint(5, "Custom type is : " .. custom_type_name, nil, "lazyChildMaker")
      e.type = 13
      e.CustomTypeName = custom_type_name
    else
      e.type = setOptional(type_, var_type)
    end

    if dropdown_linked then
      debugPrint(5, "Linked dropdown : " .. dropdown_linked, nil, "lazyChildMaker")
      e.DropDownLinked = true
      e.DropDownLinkedMemrec = dropdown_linked
    end

    if options then
      e.Options = options
    end

    if collapse_parent then
      par.Collapsed = true
    end

    if nested then
      local new_par = par.Child[i]
      debugPrint(5, "Nesting inside child : (" .. new_par.ID .. ")  " .. new_par.Description, nil, "lazyChildMaker")
      e.appendToEntry(new_par)
    else
      e.appendToEntry(par)
    end

  end
end

function lazy_child_deleter(memory_record, reset_options)
  --local res_op = reset_options or false
  local mr = memory_record
  -- Causes "TTreeNodes.GetNodeFromIndex Index SOMENUMBER out of bounds (Count=SOMENUMBER)" error when deactivating with space key, but NOT when deactivating with left mouse button
  debugPrint(1, "Invoked lazyChildDeleter()", nil, "lazyChildDeleter")
  debugPrint(2, "Deleting all child entries of (" .. mr.id .. ") " .. mr.description, nil, "lazyChildDeleter")
  local cnt = mr.Count
  debugPrint(3, "Memory record children : " .. cnt, nil, "lazyChildDeleter", nil, "lazyChildDeleter")
  if cnt > 0 then
    local start_, end_ = 1, cnt
    -- mr.active = false
    debugPrint(
        5,
        "For i = " .. start_ .. ", " .. end_ .. "  ( " .. (1 + end_ - start_) .. " )",
        nil,
        "lazyChildDeleter"
    )
    for i = 1, cnt do
      local rec = mr.Child[0]
      local desc_ = rec.description
      local id_ = rec.id
      debugPrint(7, "Iteration : " .. i, nil, "lazyChildDeleter")
      debugPrint(8, "Deleting ID : " .. id_ .. "  Name : " .. desc_, nil, "lazyChildDeleter")
      -- rec.Active = false
      -- memoryrecord_delete(rec)
      rec.destroy()
      debugPrint(9, "Successfully destroyed (" .. id_ .. ") " .. desc_, nil, "lazyChildDeleter")
    end
  end
  --if res_op then memory_record.Options = nil end
  if reset_options then memory_record.Options = nil end
end

function child_deactivator(memoryRecord, recursive)
  if memoryRecord.Count and (memoryRecord.Count > 0) then
    for i = 0, memoryRecord.Count - 1 do
      memoryRecord.Child[i].Active = false
      if recursive then
      child_deactivator(memoryRecord.Child[i], recursive)
      end
    end
  end
end

-- STOP_INCLUDE

function getTreeNodeByMemoryRecordID(memoryRecordID)
  assert(1 == 0, "Don't call getTreeNodeByMemoryRecordID : not implemented")
  -- return a TreeNode object associated with the given memoryRecord
end

function childDeleter(memoryRecord)
  assert(1 == 0, "Don't call childDeleter : not implemented")
  -- Destroy child entries by setting the HasChildren property of the associated TreeNode object to false
  local treeNode = getTreeNodeByMemoryRecordID(memoryRecord.ID)
  treeNode.HasChildren = false
  -- treeNode.deleteChildren()
end

function recursiveChildDisabler()
  assert(1 == 0, "Don't call recursiveChildDisabler : not implemented")
end

function childCreator(memoryRecord, numberOfChildrenMemoryRecords)
  for i = 1, numberOfChildrenMemoryRecords do
    local childMemoryRecord = getAddressList().createMemoryRecord()
    childMemoryRecord.Description = "Child memory record " .. i
    childMemoryRecord.appendToEntry(memoryRecord)
  end
end

function childDeleter1(memoryRecord)
  -- Keep checking the number of children and delete the first child, until no children remain
  while memoryRecord.Count > 0 do
    local childRecord = memoryRecord.Child[0]
    childRecord.destroy()
    --memoryrecord_delete(childRecord)
  end
end

function childDeleter2(memoryRecord)
  -- Count forwards from 1 to the total number of children, and delete the first child
  for i = 1, memoryRecord.Count do
    local childRecord = memoryRecord.Child[0]
    childRecord.destroy()
    --memoryrecord_delete(childRecord)
  end
end

function childDeleter3(memoryRecord)
  -- Count backwards from the total number of children to 1, and delete the last child
  for i = memoryRecord.Count - 1, 0, -1 do
    local childRecord = memoryRecord.Child[i]
    childRecord.destroy()
    --memoryrecord_delete(childRecord)
  end
end