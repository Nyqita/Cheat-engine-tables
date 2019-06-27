function read_signed_integer(addr)
  -- Source: https://www.cheatengine.org/forum/viewtopic.php?t=581916&sid=3a46569be3bed52c4f740e7c2e47b1c4
  local val = readInteger(addr)
  local sign = bAnd(val, 0x80000000)
  return sign == 0 and val or val - 0x100000000
end

function load_table_code(n)
  -- Source: https://www.cheatengine.org/forum/viewtopic.php?p=5599154&sid=743ade2bd83c4e8106aeb59c84aeaca1#5599154
  local t = findTableFile(n)
  if t ~= nil then
    local s = t.Stream
    local c = readStringLocal(s.Memory, s.Size)
    return c ~= nil and loadstring(c) -- return a function
  end
end

function load_lua_file(lua_file_path)
  assert(1 == 0, "Don't call loadLuaFile : not implemented")
  if lua_file_path == "test" then
    lua_file_path = "__main__.lua"
  end

  local f = load_table_code(lua_file_path)
  print(type(f))
  if type(f) == 'function' then
    f()
  else
    print('not loaded')
  end
end

function check_bytes(address, in_val)
  assert(1 == 0, "Don't call loadLuaFile : not implemented")
  debugPrint(3, "Address : " .. nb(address) .. "  Value : " .. nb(in_val), nil, "checkBytes()")
  local check_val = to_byte_string(in_val, true)
  local check_bytes = table_to_string(check_val.bytes_table)
  local check_length = check_val.bytes_length
  local found_array = readBytes(address, check_length, true)
  local found_bytes = table_to_string(found_array, " ", false, nil, true)

  -- tableToString(in_table, delimiter, reversed, to_hex, return_all)
  local matches = false

  local simple_f = table.concat(found_array, "")
  local simple_c = table.concat(to_byte_string(in_val), "")
  debugPrint(7, "Simple found string : " .. simple_f .. "  Simple check string : " .. simple_c, nil, "checkBytes()")
  if simple_f == simple_c then
    debugPrint(3, "Values match", nil, "checkBytes()")
    return true
  end
  debugPrint(3, "Values do not match", nil, "checkBytes()")
  return false
end

-- START_INCLUDE

function detect_ps1_game_version()
  local mednafen_sig = "cdrom:\\"
  local epsxe_sig = "BOOT = cdrom:\\"
  local game_sig, search_sig
  -- todo implement support for other emulators
  if getAddressSafe("mednafen_psx_hw_libretro.dll") or getAddressSafe("mednafen_psx_libretro.dll") then
    game_sig = mednafen_sig
  elseif getAddressSafe("ePSXe.exe") then
    game_sig = epsxe_sig
  end

  if game_sig then
    debugPrint(4, "Signature : " .. string.pstring(game_sig), nil, "detect_ps1_game_version")
    search_sig = string_to_byte_string(game_sig, "00 00 00 00 ")
  else
    search_sig = "00 00 00 00 00 00 00 00 63 64 72 6F 6D 3A 5C"
  end
  debugPrint(4, "Searching for bytes : " .. string.pstring(search_sig), nil, "detect_ps1_game_version")

  local aob_results
  --aob_results = AOBScan(search_sig).Text
  aob_results = easy_scan(base_mem, nil, search_sig)
  aob_results = string.format("%X", aob_results)
  debugPrint(4, "Found " .. aob_results, nil, "detect_ps1_game_version")

  local cdrom_addr = tonumber(tostring(aob_results), 16)
  debugPrint(5, "Game identifier string address : " .. nb(cdrom_addr), nil, "detect_ps1_game_version")
  local game_version_string = readString(cdrom_addr + #string.split(search_sig, " "))
  game_version_string = string.split(game_version_string, ";")[1]
  game_version_string = string.gsub(game_version_string, "%.", "")
  debugPrint(5, "Game identifier string : " .. game_version_string, nil, "detect_ps1_game_version")
  return game_version_string
end

function create_dropdown_list(values_table)
  -- Reference : https://www.cheatengine.org/forum/viewtopic.php?t=603797&sid=d1c04426b5a702bbefe612a955f7d37d
  local sl = createStringlist()
  sl.Sorted = true
  for key, value in pairs(values_table) do
    if type(key) == "number" and type(value) == "string" then
      sl.add(key .. ":" .. value)
    end
  end
  print(sl.Text)
  return sl
end

function create_dropdown_string(values_table)
  -- Reference : https://www.cheatengine.org/forum/viewtopic.php?p=5643704&sid=33cbe1c6bbf02ff70496b789d6dd07ab
  local out_string = ""
  local new_line
  --if #values_table ~= 0 then
  for key, value in ipairs(values_table) do
    if type(key) == "number" and type(value) == "string" then
      new_line = tostring(key) .. ":" .. tostring(value) .. "\n"
      --print(new_line)
      out_string = out_string .. new_line
    end
  end
  for i = 1, #values_table do
    new_line = tostring(values_table[i][1]) .. ":" .. values_table[i][2] .. "\n"
    --print(new_line)
    out_string = out_string .. new_line
  end
  --print(out_string)
  return out_string
end

function set_dropdown_list(memory_record, string_list, options)
  -- Reference : https://wiki.cheatengine.org/index.php?title=Lua:Class:MemoryRecord
  --[[
DropDownLinked: boolean
    if dropdown list refers to list of another memory record eg. (memrec name)

DropDownLinkedMemrec: string
    Description of linked memrec or emptystring if not linked

DropDownList: StringList
    list of "value:description" lines, lists are still separate objects when linked, read-write

DropDownReadOnly: boolean
    true if 'Disallow manual user input' is set

DropDownDescriptionOnly: boolean
    self explanatory

DisplayAsDropDownListItem: boolean
    self explanatory

DropDownCount: integer
    equivalent to .DropDownList.Count

DropDownValue: Array
    Array to access values in DropDownList (ReadOnly)

DropDownDescription: Array
    Array to access Descriptions in DropDownList (ReadOnly)
--]]
  local DisplayAsDropDownListItem
  local DropDownReadOnly
  local DropDownDescriptionOnly
  if options then
    DisplayAsDropDownListItem = setOptional(options.dadli, false)
    DropDownReadOnly = setOptional(options.ddro, false)
    DropDownDescriptionOnly = setOptional(options.dddo, false)
  end
  memory_record.DropDownList.Text = string_list
end

function cls()
  -- Source : https://www.cheatengine.org/forum/viewtopic.php?t=601157&sid=fffbc653e1affef130b8a5c4eaaad3ee
  GetLuaEngine().MenuItem5.doClick()
end

function get_mr_desc(description)
  -- Source : https://wiki.cheatengine.org/index.php?title=Lua:Class:Addresslist
  return AddressList.getMemoryRecordByDescription(description)
end

function get_mr_id(id)
  -- Source : https://wiki.cheatengine.org/index.php?title=Lua:Class:Addresslist
  return AddressList.getMemoryRecordByID(id)
end

function find_signature(signature_aob)
  local aob_scan_results = AOBScan(signature_aob)
  return tonumber(aob_scan_results[0], 16)
end

function set_memory_record(memory_record, args_table, base_address, append_to_entry)
  -- Reference: https://wiki.cheatengine.org/index.php?title=Lua:Class:MemoryRecord
  --[[
  vtByte=0
  vtWord=1
  vtDword=2
  vtQword=3
  vtSingle=4
  vtDouble=5
  vtString=6
  vtUnicodeString=7 --Only used by autoguess
  vtByteArray=8
  vtBinary=9
  vtAutoAssembler=11
  vtPointer=12 --Only used by autoguess and structures
  vtCustom=13
  vtGrouped=14
  --]]
  local offset = args_table.off or args_table.offset or nil
  local description = args_table.desc or args_table.description or nil
  local type_ = args_table.type
  local dropdown_linked = args_table.ddl or args_table.dropdown_linked or args_table.dropdownlinked or nil
  local disallow_manual_user_input = args_table.dmui or nil
  local only_show_the_description_part = args_table.ostdp or nil
  local make_the_record_display_values_like_the_dropdown_list = args_table.mtrdvltdl or nil
  local show_as_hex = args_table.hex or nil
  local options = args_table.opt or args_table.options or nil
  local child_elements = args_table.child or args_table.children or nil
  local parent = append_to_entry or nil

  if debug_verbosity > 0 then
    debugPrint(5, "Description : " .. description, nil, "setMemrec")
    debugPrint(5, "Base address : " .. nb(base_address), nil, "setMemrec")
    debugPrint(5, "Offset : " .. nb(offset), nil, "setMemrec")
  end
  if type(type_) == "string" then
    debugPrint(5, "Type : " .. type_, nil, "setMemrec")
    if type_ == "header" then
      memory_record.type = 0
      memory_record.isGroupHeader = true
    else
      memory_record.type = 13
      memory_record.CustomTypeName = type_
    end
  elseif type(type_) == "table" then
    memory_record.type = type_['type']
    for key, value in pairs(type_['options']) do
      if key == "Binary.Startbit" then
        memory_record.Binary.Startbit = value
      elseif key == "Binary.Size" then
        memory_record.Binary.Size = value
      elseif key == "Aob.Size" then
        memory_record.Aob.Size = value
      elseif key == "String.Size" then
        memory_record.String.Size = value
      elseif key == "String.Unicode" then
        memory_record.String.Unicode = value
      elseif key == "String.Codepage" then
        memory_record.String.Codepage = value
      end
    end
  else
    memory_record.type = type_
  end
  if description then
    memory_record.Description = description
  end
  if base_address and offset and (type ~= "header") then
    memory_record.Address = base_address + offset
  end
  if dropdown_linked then
    debugPrint(5, "Dropdown linked : " .. dropdown_linked, nil, "setMemrec")
    memory_record.DropDownLinked = true
    memory_record.DropDownLinkedMemrec = dropdown_linked
  end
  if disallow_manual_user_input then
    debugPrint(5, "Disallow manual user input", nil, "setMemrec")
    memory_record.DropDownReadOnly = true
  end
  if only_show_the_description_part then
    debugPrint(5, "Only show the description part", nil, "setMemrec")
    memory_record.DropDownDescriptionOnly = true
  end
  if make_the_record_display_values_like_the_dropdown_list then
    debugPrint(5, "Make the record display values like the dropdown list", nil, "setMemrec")
    memory_record.DisplayAsDropDownListItem = true
  end
  if show_as_hex then
    debugPrint(5, "Show as hexadecimal", nil, "setMemrec")
    memory_record.ShowAsHex = true
  end
  if options then
    memory_record.Options = options
    debugPrint(5, "Options : " .. string.pstring(options), nil, "setMemrec")
  end
  if parent then
    memory_record.appendToEntry(parent)
  end
  if child_elements then
    for i = 1, #child_elements do
      local child_arguments = {}
      --child_arguments = deepCopy(args_table)
      --child_arguments["children"] = nil
      --child_arguments["child"] = nil
      for key, value in pairs(child_elements[i]) do
        child_arguments[key] = value
      end
      for j = 1, #child_elements[i] do
        child_arguments[j] = child_elements[i][j]
      end
      --print("\n" .. string.pstring(description))
      --print("args_table : " .. string.pstring(args_table, "\n"))
      --print("\nCHILD ARGUMENTS: " .. string.pstring(child_arguments, "\n"))
      debugPrint(8, "Child element : " .. string.pstring(child_arguments), nil, "setMemrec")
      set_memory_record(create_mr(), child_arguments, base_address, memory_record)
    end
  end
end

function delayed_deactivate(memrec, wait_time)
  local t = createTimer()
  t.Interval = setOptional(wait_time, 100)
  t.OnTimer = function(t)
    memrec.Active = false
    t.Destroy()
  end
end

function easy_scan(start_address, end_address, array_of_bytes)
  -- Reference : https://forum.cheatengine.org/viewtopic.php?p=5729086
  --[[

MemScan Class (Inheritance: Object)
getCurrentMemscan() : Returns the current memory scan object. If tabs are used the current tab's memscan object
createMemScan(progressbar OPTIONAL) : Returns a new MemScan class object

properties
  LastScanWasRegionScan: boolean - returns true is the previous scan was an unknown initial value
  LastScanValue: string
  LastScanType: ScanType/string - 'stNewScan', 'stFirstScan', 'stNextScan'
  ScanresultFolder: string - Path where the results are stored
  OnScanDone: function(memscan) - Set a function to be called when the scan has finished
  OnGuiUpdate: function(memscan, TotalAddressesToScan, CurrentlyScanned, ResultsFound) - Called during the scan so you can update the interface if needed
  FoundList: FoundList - The foundlist currently attached to this memscan object
  OnlyOneResult: boolean - If this is set to true memscan will stop scanning after having found the first result, and written the address to "Result"
  Result: Integer - If OnlyOneResult is used this will contain the address after a scan has finished

methods

  firstScan(scanoption, vartype, roundingtype, input1, input2 ,startAddress ,stopAddress ,protectionflags ,alignmenttype ,"alignmentparam" ,isHexadecimalInput ,isNotABinaryString, isunicodescan, iscasesensitive);
    Does an initial scan.
    memscan: The MemScan object created with createMemScan
    scanOption: Defines what type of scan is done. Valid values for firstscan are:
      soUnknownValue: Unknown initial value scan
      soExactValue: Exact Value scan
      soValueBetween: Value between scan
      soBiggerThan: Bigger than ... scan
      soSmallerThan: smaller than ... scan

    vartype: Defines the variable type. Valid variable types are:
      vtByte
      vtWord  2 bytes
      vtDword 4 bytes
      vtQword 8 bytes
      vtSingle float
      vtDouble
      vtString
      vtByteArray
      vtGrouped
      vtBinary
      vtAll

    roundingtype: Defined the way scans for exact value floating points are handled
      rtRounded : Normal rounded scans. If exact value = "3" then it includes 3.0 to 3.49999999. If exact value is "3.0" it includes 3.00 to 3.0499999999
      rtTruncated: Truncated algorithm. If exact value = "3" then it includes 3.0 to 3.99999999. If exact value is "3.0" it includes 3.00 to 3.099999999
      rtExtremerounded: Rounded Extreme. If exact value = "3" then it includes 2.0000001 to 3.99999999. If exact value is "3.0" it includes 2.900000001 to 3.099999999

    input1: If required by the scanoption this is a string of the given variable type
    input2: If requires by the scanoption this is the secondary input

    startAddress : The start address to scan from. You want to set this to 0
    stopAddress  : The address the scan should stop at. (You want to set this to 0xffffffffffffffff)

    protectionflags : See aobscan about protectionflags
    alignmenttype : Scan alignment type. Valid options are:
      fsmNotAligned : No alignment check
      fsmAligned    : The address must be dividable by the value in alignmentparam
      fsmLastDigits : The last digits of the address must end with the digits provided by alignmentparam

    alignmentparam : String that holds the alignment parameter.

    isHexadecimalInput: When true this will handle the input field as a hexadecimal string else decimal
    isNotABinaryString: When true and the varType is vtBinary this will handle the input field as a decimal instead of a binary string
    isunicodescan: When true and the vartype is vtString this will do a unicode (utf16) string scan else normal utf8 string
    iscasesensitive : When true and the vartype is vtString this check if the case matches

  nextScan(scanoption, roundingtype, input1,input2, isHexadecimalInput, isNotABinaryString, isunicodescan, iscasesensitive, ispercentagescan, savedresultname OPTIONAL);
    Does a next scan based on the current addresslist and values of the previous scan or values of a saved scan
    memscan: The MemScan object that has previously done a first scan
    scanoption:
      soExactValue: Exact Value scan
      soValueBetween: Value between scan
      soBiggerThan: Bigger than ... scan
      soSmallerThan: smaller than ... scan
      soIncreasedValue: Increased value scan
      soIncreasedValueBy: Increased value by scan
      soDecreasedValue: Decreased value scan
      soDecreasedValueBy: Decreased value by scan
      soChanged: Changed value scan
      soUnchanged: Unchanged value scan

    roundingtype: Defined the way scans for exact value floating points are handled
      rtRounded : Normal rounded scans. If exact value = "3" then it includes 3.0 to 3.49999999. If exact value is "3.0" it includes 3.00 to 3.0499999999
      rtTruncated: Truncated algoritm. If exact value = "3" then it includes 3.0 to 3.99999999. If exact value is "3.0" it includes 3.00 to 3.099999999
      rtExtremerounded: Rounded Extreme. If exact value = "3" then it includes 2.0000001 to 3.99999999. If exact value is "3.0" it includes 2.900000001 to 3.099999999

    input1: If required by the scanoption this is a string of the given variable type
    input2: If requires by the scanoption this is the secondary input

    isHexadecimalInput: When true this will handle the input field as a hexadecimal string else decimal
    isNotABinaryString: When true and the varType is vtBinary this will handle the input field as a decimal instead of a binary string
    isunicodescan: When true and the vartype is vtString this will do a unicode (utf16) string scan else normal utf8 string
    iscasesensitive : When true and the vartype is vtString this check if the case matches
    ispercentage: When true and the scanoption is of type soValueBetween, soIncreasedValueBy or soDecreasedValueBy will cause CE to do a precentage scan instead of a normal value scan
    savedResultName: String that holds the name of a saved result list that should be compared against. First scan is called "FIRST"

  newScan() : Clears the current results
  waitTillDone() : Waits for the memscan thread(s) to finish scanning. Always use this
  saveCurrentResults(name) : Save the current scanresults to a unique name for this memscan. This save can be used to compare against in a subsequent next scan
  getAttachedFoundlist() : Returns a FoundList object if one is attached to this scanresults. Returns nil otherwise

  setOnlyOneResult(state): If set to true before you start a scan, this will cause the scanner to only return one result. Note that it does not work with a foundlist
  getOnlyResult(): Only works if returnOnlyOneResult is true. Returns nil if not found, else returns the address that was found (integer)
  getProgress(): returns a table with fields: TotalAddressesToScan, CurrentlyScanned, ResultsFound
--]]
  local mem_scan = createMemScan()
  mem_scan.OnlyOneResult = true
  local start_mem = start_address or 0
  local end_mem = end_address or 0x7fffffffffff
  mem_scan.firstScan(soExactValue, vtByteArray, nil, array_of_bytes, nil, start_mem, end_mem,
      "", nil, nil, true, nil, nil, nil)
  mem_scan.waitTillDone()
  return mem_scan.Result
end

function create_mr()
  local mr = getAddressList().createMemoryRecord()
  return mr
end

function show_memo(memo_text, window_width, window_height, font_size)
  local window_width = window_width or 1000
  local window_height = window_height or 1000
  local font_size = font_size or 12
  -- Reference : https://wiki.cheatengine.org/index.php?title=Lua:Class:Form
  local f = createForm(true)
  f.Name = "Information"
  f.Width = window_width
  f.Height = window_height
  -- Reference : https://wiki.cheatengine.org/index.php?title=Lua:Class:Control
  f.Top = 10
  f.Left = 10
  --[[
  Form Class: (Inheritance: ScrollingWinControl->CustomControl->WinControl->Control->Component->Object)
properties
  AllowDropFiles: boolean - Allows files to be dragged into the form
  ModalResult: integer - The current ModalResult value of the form. Note: When this value gets set the modal form will close
  Menu: MainMenu - The main menu of the form

  OnClose: function(sender) - The function to call when the form gets closed
  OnDropFiles: function(sender, {filenames}) - Called when files are dragged on top of the form. Filenames is an arraytable with the files
  FormState: FormState string ReadOnly - The current state of the form. Possible values: fsCreating, fsVisible, fsShowing, fsModal, fsCreatedMDIChild, fsBorderStyleChanged, fsFormStyleChanged, fsFirstShow, fsDisableAutoSize

methods
  centerScreen(); : Places the form at the center of the screen
  hide() : Hide the form
  show() : show the form
  close():  Closes the form. Without an onClose this will be the same as hide
  bringToFront(): Brings the form to the foreground
  showModal() : show the form and wait for it to close and get the close result
  isForegroundWindow(): returns true if the specified form has focus
  setOnClose(function)  : function (sender) : Return a CloseAction to determine how to close the window
  getOnClose() : Returns the function
  getMenu() : Returns the mainmenu object of this form
  setMenu(mainmenu)

  setBorderStyle( borderstyle):  Sets the borderstyle of the window
  getBorderStyle()

  printToRasterImage(rasterimage): Draws the contents of the form to a rasterimage class object
  dragNow():  Call this on mousedown on any object if you wish that the mousemove will drag the whole form arround. Useful for borderless windows (Dragging will stop when the mouse button is released)
  --]]
  --print("Creating Form object")
  local memo = createMemo(f)
  --[[
Memo Class: (Inheritance: Edit->WinControl->Control->Component->Object)
createMemo(owner): Creates a Memo class object which belongs to the given owner. Owner can be any object inherited from WinControl

properties
  Lines: Strings - Strings object for this memo
  WordWrap: boolean - Set if words at the end of the control should go to the next line
  WantTabs: Boolean - Set if tabs will add a tab to the memo. False if tab will go to the next control
  WantReturns: Boolean - Set if returns will send a event or not
  Scrollbars: Scrollstyle - Set the type of ascrollbars to show (ssNone, ssHorizontal, ssVertical, ssBoth,
    ssAutoHorizontal, ssAutoVertical, ssAutoBoth)

methods
  append(string)
  getLines() : returns a Strings class
  getWordWrap()
  setWordWrap(boolean)
  getWantTabs()
  setWantTabs(boolean)
  getWantReturns()
  setWantReturns(boolean)
  getScrollbars()
  setScrollbars(scrollbarenumtype) :
  Sets the scrollbars. Horizontal only takes affect when wordwrap is disabled
  valid enum types:
    ssNone : No scrollbars
    ssHorizontal: Has a horizontal scrollbar
    ssVertical: Has a vertical scrollbar
    ssBoth: Has both scrollbars
    ssAutoHorizontal: Same as above but only shows when there actually is something to scroll for
    ssAutoVertical: " " " " ...
    ssAutoBoth: " " " " ...
  --]]
  --[[

Strings Class: (Inheritance : Object) (Mostly an abstract class)
properties
  LineBreak: String - the character(s) to count as a linebreak
  Text : String - All the strings in one string
  Count: Integer - The number of strings in this list
  String[]: String - Array to access one specific string in the list
  [] = String[]

methods
  clear() : Deletes all strings in the list
  add(string) : adds a string to the list
  delete(index) : Deletes a string from the list
  getText() : Returns all the strings as one big string
  setText() : Sets the strings of the given strings object to the given text (can be multiline)
  indexOf(string): Returns the index of the specified string. Returns -1 if not found
  insert(index, string): Inserts a string at a specific spot moving the items after it

  getCount(): Returns the number is strings in the list
  remove(string); Removes the given string from the list
  loadFromFile(filename) : Load the strings from a textfile
  saveToFile(filename) : Save the strings to a textfile

  getString(index) : gets the string at the given index
  setString(index, string) : Replaces the string at the given index
  beginUpdate() : Stops updates from triggering other events (prevents flashing)
  endUpdate(): call after beginUpdate
  --]]
  memo.Width = window_width
  memo.Height = window_height
  memo.Lines.add(memo_text)
  memo.setScrollbars(ssAutoVertical)
  memo.ReadOnly = true
  memo.Color = 0x101010
  memo.Font.Color = 0xF0F0F0
  memo.Font.Name = "Consolas"
  memo.Font.Size = font_size
  f.onClose = function()
    f.destroy()
  end
  return f
end

-- STOP_INCLUDE
