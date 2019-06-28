add_req(root_dir .. "games/final_fantasy_7/__init__")
add_req(root_dir .. "games/final_fantasy_7/translations")
add_req(root_dir .. "games/final_fantasy_7/cheats")
add_req(root_dir .. "games/final_fantasy_7/versions")
add_req(root_dir .. "games/final_fantasy_7/themes")

function set_dropdown_link_tables()
  assert(1 == 0, "Don't call set_dropdown_link_tables : not implemented")
end

function check_steam_processes()
  assert(1 == 0, "Don't call check_steam_processes : not implemented")
end

table_info = [[Table info goes here]]

-- START_INCLUDE
force_lang = nil
current_lang = "eng"

weapon_stats = {}
armour_stats = {}
real_stats = {}
display_stats = {}
battle_stats = {}
battle_atb = {}
battle_limit_break = {}
chocobo_stats_1 = {}
chocobo_stats_2 = {}
battle_char_names = {}
menu_options = {}

initial_weapons = {
  {
    "Buster Sword", 0,
    { 0x23, 0xFF, 0x11, 0xFF, 0x12, 0xFF, 0x01, 0x00, 0x60, 0x00, 0xFF, 0xF8, 0xFF, 0xFF, 0x01, 0x02, 0x00, 0x04, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x06, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x1B, 0x05, 0x09, 0xFF, 0xFF, 0xFF, 0xFF }
  },

  {
    "Leather Glove", 16,
    { 0x23, 0xFF, 0x11, 0xFF, 0x0D, 0xFF, 0x01, 0x02, 0x63, 0x00, 0xFF, 0xFB, 0xFF, 0xFF, 0x04, 0x00, 0x00, 0x08, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x5E, 0x05, 0x24, 0xFF, 0xFF, 0xFE, 0xFF }
  },
  {
    "Gatling Gun", 32,
    { 0x03, 0xFF, 0x11, 0xFF, 0x0E, 0xFF, 0x01, 0x00, 0x61, 0x10, 0xFF, 0xF8, 0xFF, 0xFF, 0x02, 0x00, 0x00, 0x20, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x2E, 0x2F, 0x2D, 0xFF, 0xFF, 0xFF, 0xFF }
  },
  {
    "Mythril Clip", 48,
    { 0x23, 0xFF, 0x11, 0xFF, 0x18, 0xFF, 0x01, 0x00, 0x64, 0x00, 0xFF, 0xF8, 0xFF, 0xFF, 0x10, 0x00, 0x00, 0x08, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x06, 0xFF, 0xFF, 0xFF, 0x06, 0x07, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6D, 0x8D, 0x05, 0x24, 0xFF, 0xFF, 0xFE, 0xFF }
  },
  {
    "Guard Stick", 62,
    { 0x23, 0xFF, 0x11, 0xFF, 0x0C, 0xFF, 0x01, 0x00, 0x63, 0x00, 0xFF, 0xF8, 0xFF, 0xFF, 0x08, 0x00, 0x00, 0x08, 0xFF, 0xFF, 0x02, 0x01, 0x03, 0xFF, 0x02, 0x01, 0x04, 0xFF, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x17, 0x05, 0x36, 0xFF, 0xFF, 0xF6, 0xFF }
  },
  {
    "Spear", 73,
    { 0x23, 0xFF, 0x11, 0xFF, 0x2C, 0xFF, 0x01, 0x00, 0x61, 0x00, 0xFF, 0xFB, 0xFF, 0xFF, 0x00, 0x01, 0x00, 0x10, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x08, 0xFF, 0xFF, 0xFF, 0x06, 0x07, 0x06, 0x07, 0x00, 0x00, 0x00, 0x00, 0x56, 0x5A, 0x05, 0x18, 0xFF, 0xFF, 0xF6, 0xFF }
  },
  {
    "4-point Shuriken", 87,
    { 0x03, 0xFF, 0x11, 0xFF, 0x17, 0xFF, 0x01, 0x00, 0x64, 0x00, 0xFF, 0xFB, 0xFF, 0xFF, 0x20, 0x00, 0x00, 0x20, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x06, 0xFF, 0xFF, 0xFF, 0x06, 0x07, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x59, 0x55, 0x05, 0x30, 0xFF, 0xFF, 0xF6, 0xFF }
  },
  {
    "Yellow M-phone", 101,
    { 0x23, 0xFF, 0x11, 0xFF, 0x24, 0xFF, 0x01, 0x00, 0x64, 0x00, 0xFF, 0xFB, 0xFF, 0xFF, 0x40, 0x00, 0x00, 0x08, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x08, 0xFF, 0xFF, 0xFF, 0x06, 0x07, 0x05, 0x05, 0x00, 0x00, 0x00, 0x00, 0x35, 0x22, 0x05, 0x24, 0xFF, 0xFF, 0xF6, 0xFF }
  },
  {
    "Quicksilver", 114,
    { 0x03, 0xFF, 0x11, 0xFF, 0x26, 0xFF, 0x01, 0x00, 0x6E, 0x00, 0xFF, 0xF9, 0xFF, 0xFF, 0x80, 0x00, 0x00, 0x20, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0x0A, 0xFF, 0xFF, 0xFF, 0x06, 0x07, 0x05, 0x05, 0x00, 0x00, 0x00, 0x00, 0x12, 0x7B, 0x2F, 0x2A, 0xFF, 0xFF, 0xF6, 0xFF }
  },
}

perfect_weapon_stats_1 = { 0x03, 0xFF, 0x11, 0xFF, 0xFE, 0xFF, 0x03, 0x00, 0xFE, 0x00, 0xFF, 0xF8, 0xFF, 0xFF }
perfect_weapon_stats_2 = { 0x02, 0x00, 0x04, 0xFF, 0xFF, 0x02, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFF, 0xFF, 0x06, 0x07, 0x06, 0x07, 0x06, 0x07, 0x06, 0x07, 0x12, 0x1B, 0x05, 0x09, 0xFF, 0xFF, 0xFF, 0xFF }

initial_armour = { 0x00, 0xFF, 0x08, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x01, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF }

perfect_armour_stats = { 0x00, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0x00, 0x06, 0x07, 0x06, 0x07, 0x06, 0x07, 0x06, 0x07, 0x03, 0xFF, 0x01, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x01, 0x02, 0x03, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF }

initial_accessory = { 0x00, 0xFF, 0x0A, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x01, 0xFE, 0xFF }

-- 255 strength and magic, absorb all elements, permanent haste, immune to all status effects except: poison, haste, regen, barrier, mbarrier, reflect, shield
perfect_accessory_stats = { 0x00, 0x02, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0xF7, 0x7E, 0xE0, 0x07, 0xFF, 0x01, 0xFE, 0xFF }

config_menu_settings = {
  shape = { "off", "type", "desc" },
  { 0, 0, "Battle speed" },
  { 1, 0, "Battle message" },
  { 2, 0, "Sound / Controller / Cursor / ATB" }, -- 0=Mono, normal, initial, active; 0x40=recommended; 0x80=wait
  { 3, 0, "Camera angle / Magic order" },
  { 0x14, 0, "Field message speed" },
}

materia_array = {
  shape = { "Offset", "Value" },
  { 0, 0x49 },
  { 4, 0x48 },
  { 8, 0x47 },
  { 12, 0x46 },
  { 16, 0x45 },
  { 20, 0x44 },
  { 24, 0x41 },
  { 28, 0x40 },
  { 32, 0x3E },
  { 36, 0x3D },
  { 40, 0x3C },
  { 44, 0x3B },
  { 48, 0x3A },
  { 52, 0x39 },
  { 56, 0x38 },
  { 60, 0x37 },
  { 64, 0x36 },
  { 68, 0x35 },
  { 72, 0x34 },
  { 76, 0x33 },
  { 80, 0x32 },
  { 84, 0x31 },
  { 88, 0x23 },
  { 92, 0x22 },
  { 96, 0x21 },
  { 100, 0x20 },
  { 104, 0x1F },
  { 108, 0x1E },
  { 112, 0x1D },
  { 116, 0x1C },
  { 120, 0x1B },
  { 124, 0x1A },
  { 128, 0x19 },
  { 132, 0x18 },
  { 136, 0x17 },
  { 140, 0x30 },
  { 144, 0x2C },
  { 148, 0x2B },
  { 152, 0x2A },
  { 156, 0x29 },
  { 160, 0x28 },
  { 164, 0x27 },
  { 168, 0x25 },
  { 172, 0x24 },
  { 176, 0x15 },
  { 180, 0x14 },
  { 184, 0x13 },
  { 188, 0x0F },
  { 192, 0x0E },
  { 196, 0x12 },
  { 200, 0x11 },
  { 204, 0x10 },
  { 208, 0x0D },
  { 212, 0x0C },
  { 216, 0x0B },
  { 220, 0x0A },
  { 224, 0x09 },
  { 228, 0x08 },
  { 232, 0x07 },
  { 236, 0x06 },
  { 240, 0x05 },
  { 244, 0x04 },
  { 248, 0x03 },
  { 252, 0x02 },
  { 256, 0x01 },
  { 260, 0x00 },
  { 264, 0x5A },
  { 268, 0x59 },
  { 272, 0x58 },
  { 276, 0x57 },
  { 280, 0x56 },
  { 284, 0x55 },
  { 288, 0x54 },
  { 292, 0x53 },
  { 296, 0x52 },
  { 300, 0x51 },
  { 304, 0x50 },
  { 308, 0x4F },
  { 312, 0x4E },
  { 316, 0x4D },
  { 320, 0x4C },
  { 324, 0x4B },
  { 328, 0x4A },
  { 796, 0xFFFFFFFF },
}

function custom_type_menu_item_qty()
  if type(ff7_menu_item_qty_bytestovalue) == "function" then return end
  local typename = "FF7 Menu Item Quantity"
  local bytecount = 2
  local functionbasename = "ff7_menu_item_qty_"
  function ff7_menu_item_qty_bytestovalue(b1, b2, address)
    if (b1 == 255) and (b2 == 255) then
      return 0
    end
    local props = final_fantasy_vii_menu_items(b1, b2)
    return props.qty
  end
  function ff7_menu_item_qty_valuetobytes(integer, address)
    local b_1, b_2 = readBytes(address, 2, false)
    local i_rem = b_2 % 2
    if integer > 99 then
      integer = 99
    end
    return b_1, ((integer * 2) + i_rem)
  end
  registerCustomTypeLua(typename, bytecount, ff7_menu_item_qty_bytestovalue, ff7_menu_item_qty_valuetobytes, isFloat)
end

function custom_type_menu_item_id()
  if type(ff7_menu_item_id_bytestovalue) == "function" then return end
  local typename = "FF7 Menu Item ID"
  local bytecount = 2
  local functionbasename = "ff7_menu_item_id_"
  function ff7_menu_item_id_bytestovalue(b1, b2, address)
    if (b1 == 255) and (b2 == 255) then
      return 65535
    end
    local props = final_fantasy_vii_menu_items(b1, b2)
    return props.id
  end
  function ff7_menu_item_id_valuetobytes(integer, address)
    local b_1, b_2 = readBytes(address, 2, false)
    local cur_qty = b_2 // 2
    local qty_byte = (2 * cur_qty) + (integer // 256)
    local id_byte = integer % 256
    return id_byte, qty_byte
  end
  registerCustomTypeLua(typename, bytecount, ff7_menu_item_id_bytestovalue, ff7_menu_item_id_valuetobytes, isFloat)
end

function custom_type_3_bytes()
  if type(three_bytes_bytestovalue) == "function" then return end
  local typename = "3 Bytes"
  local bytecount = 3
  local functionbasename = "three_bytes_"
  function three_bytes_bytestovalue(b1, b2, b3, address)
    local total = b1 + (b2 * 256) + (b3 * (256 ^ 2))
    return total
  end
  function three_bytes_valuetobytes(integer, address)
    local hex_str = "000000" .. string.format("%X", integer)
    local b_1 = tonumber(hex_str:sub(#hex_str - 1, #hex_str), 16)
    local b_2 = tonumber(hex_str:sub(#hex_str - 3, #hex_str - 2), 16)
    local b_3 = tonumber(hex_str:sub(#hex_str - 5, #hex_str - 4), 16)
    return b_1, b_2, b_3
  end
  registerCustomTypeLua(typename, bytecount, three_bytes_bytestovalue, three_bytes_valuetobytes, isFloat)
end

function custom_type_ff7_string()
  -- This was supposed to correctly display text from the game memory
  -- I don't know how to make a custom type show a string instead of a number
  assert(1 == 0, "Don't call custom_type_ff7_string : not implemented")
  local typename = "FF7 String"
  local bytecount = 9
  local functionbasename = "ff7_string_"
  function ff7_string_bytestovalue(b1, b2, b3, b4, b5, b6, b7, b8, b9, address)
    local chars = { b1, b2, b3, b4, b5, b6, b7, b8, b9 }
    local shift_value = 32
    local out_string = ""
    for i = 1, #chars do
      if chars[i] == 0 then
        break
      end
      out_string = out_string .. string.char(chars[i] + shift_value)
    end
    return out_string
  end
  function ff7_string_valuetobytes(integer, address)
    return 0
  end
  registerCustomTypeLua(typename, bytecount, ff7_string_bytestovalue, ff7_string_valuetobytes, isFloat)
end

function register_custom_types()
  -- Source: https://wiki.cheatengine.org/index.php?title=Help_File:Script_engine#registerCustomTypeLua
  -- https://wiki.cheatengine.org/index.php?title=Lua:registerCustomTypeLua
  custom_type_menu_item_qty()
  custom_type_menu_item_id()
  custom_type_3_bytes()
end

function load_ff7_config(memory_record, deactivate_on_fail_time)
  memory_record.Description = "Loading ..."
  if process then
    for i = 1, #steam_versions do
      if process == (steam_versions[i][1]) .. ".exe" then
        cfg = steam_versions[i][3]
        base_mem = 0x400000
        current_lang = force_lang or steam_versions[i][4]
        local out_string = (steam_versions[i][2])
        memory_record.Description = out_string
        return out_string
      end
    end
    local game_ver = detect_ps1_game_version()
    for i = 1, #playstation_versions do
      for j = 1, #playstation_versions[i][2] do
        if playstation_versions[i][2][j] == game_ver then
          cfg = playstation_versions[i][3]
          current_lang = force_lang or playstation_versions[i][4]
          local out_string = playstation_versions[i][1] .. " (" .. game_ver .. ")"
          memory_record.Description = out_string
          return out_string
        end
      end
    end
  end
  local error_message = "Could not detect game version and load its config"
  memory_record.Description = error_message
  if deactivate_on_fail_time then delayed_deactivate(memory_record, deactivate_on_fail_time) end
  return error_message
end

function set_base_mem()
  modules = {
    { "mednafen_psx_hw_libretro.dll", 0x829D20 },
    { "mednafen_psx_libretro.dll", 0x52ED00 },
    { "ePSXe.exe", 0xA82020 },
  }
  processes = {
    { "ePSXe.exe", 0xA82020 },
  }
  for i = 1, #modules do
    debug_print(4, "Checking for " .. modules[i][1], nil, "set_base_mem")
    local mod_mem = getAddressSafe(modules[i][1])
    if mod_mem then
      debug_print(4, "Found " .. modules[i][1], nil, "set_base_mem")
      module_address = mod_mem
      base_mem = mod_mem + modules[i][2]
      debug_print(6, "module_address = " .. mod_mem .. "  base_mem = " .. base_mem, nil, "set_base_mem")
      return
    end
  end
  for i = 1, #processes do
    if process == processes[i][1] then
      base_mem = processes[i][2]
      debug_print(4, "Found " .. process, nil, "set_base_mem")
      return
    end
  end
  if process then
    for i = 1, #steam_versions do
      if process == (steam_versions[i][1]) .. ".exe" then
        return
      end
    end
  end
  base_mem = find_ff7_base_mem()
  return
end

function compare_versions()
  print("[INFO] Comparing feature support for each known version of Final Fantasy VII")
  print("[INFO] More unimplemented addresses generally means more features missing")
  local version_table = {}
  for i = 1, #steam_versions do
    version_table[#version_table + 1] = { steam_versions[i][2], steam_versions[i][3] }
  end
  for i = 1, #playstation_versions do
    version_table[#version_table + 1] = { playstation_versions[i][1], playstation_versions[i][3] }
  end
  for i = 1, #version_table do
    local table_ = check_matching_values(version_table[i][2], unimplemented)
    local out_string = "Name : " .. version_table[i][1] .. "\nTotal addresses : " .. table_.key_count .. "\nUnimplemented addresses : " .. table_.matched_count
    print(out_string)
    print("Missing addresses")
    for j = 1, #table_.matched_keys do
      print("\t" .. table_.matched_keys[j])
    end
    print("-----------------------------------------")
  end
end

function final_fantasy_vii_menu_items(number, byte_2)
  local qty_byte
  local id_byte
  local props = {}
  if number == 65535 or (number == 255 and byte_2 == 255) then
    return "empty"
  end
  if number > 255 then
    local hex_str = string.format("%X", number)
    qty_byte = hex_str:sub(#hex_str - 3, #hex_str - 2)
    qty_byte = tonumber(qty_byte, 16)
    id_byte = hex_str:sub(#hex_str - 1, #hex_str)
    id_byte = tonumber(id_byte, 16)
  elseif number <= 255 and byte_2 <= 255 then
    id_byte = number
    qty_byte = byte_2
  end
  props.id_byte = id_byte
  props.qty_byte = qty_byte
  props.id = id_byte + ((qty_byte % 2) * 256)
  props.qty = math.floor(qty_byte / 2)
  if debug_verbosity > 7 then
    debug_print(7, "Properties table : ", nil, "final_fantasy_vii_menu_items")
    recursive_print(props)
  end
  return props
end

function find_ff7_base_mem()
  local ps1_sig = "03 00 00 00 80 0C 5A 27 08 00 40 03 00 00 00 00"
  local result = easy_scan(0, nil, ps1_sig)
  if result then return result end
end

function set_data()
  weapon_stats = {
    ['shape'] = { "off", "type", "desc" },
    { 4, 0, tr.atk[current_lang] },
    { 8, 0, tr.atk[current_lang] .. " %" },
    { 0, 0, tr.atk_range[current_lang], ddl = "weapon_range_template" },
    { 0x18, 0, tr.bonus_mag[current_lang], ddl = "weapon_stat_bonus_template" },
    { 0x19, 0, tr.bonus_spi[current_lang], ddl = "weapon_stat_bonus_template" },
    { 5, 0, tr.added_status[current_lang], ddl = "weapon_status_effect_template" },
    { nil, "header", tr.added_elem[current_lang], options = "moHideChildren", children = create_shaped_table({
      ['shape'] = { "off", "type", "desc" },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, tr.fire[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, tr.ice[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, tr.lightning[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 3, ['Binary.Size'] = 1 } }, tr.earth[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 4, ['Binary.Size'] = 1 } }, tr.poison[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 5, ['Binary.Size'] = 1 } }, tr.gravity[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 6, ['Binary.Size'] = 1 } }, tr.water[current_lang] },
      { 0x10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 7, ['Binary.Size'] = 1 } }, tr.wind[current_lang] },
      { 0x11, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, tr.holy[current_lang] },
    }) },
    { 6, 0, tr.mat_growth[current_lang], ddl = "materia_growth_template" },
    { nil, "header", tr.mat_slots[current_lang], options = "moHideChildren", children = create_shaped_table({
      ['shape'] = { "off", "type", "desc" },
      { 0x1C, 1, tr.mat_slots[current_lang] .. " 1 & 2", hex = true, ddl = "materia_slots_template" },
      { 0x1E, 1, tr.mat_slots[current_lang] .. " 3 & 4", hex = true, ddl = "materia_slots_template" },
      { 0x20, 1, tr.mat_slots[current_lang] .. " 5 & 6", hex = true, ddl = "materia_slots_template" },
      { 0x22, 1, tr.mat_slots[current_lang] .. " 7 & 8", hex = true, ddl = "materia_slots_template" },
    }) },
    { 0xE, 0, tr.equip_char[current_lang], ddl = "equippable_character_template" },
  }
  armour_stats = {
    ['shape'] = { "off", "type", "desc" },
    { 2, 0, tr.def[current_lang] },
    { 3, 0, tr.mag_def[current_lang] },
    { 4, 0, tr.def[current_lang] .. " %" },
    { 5, 0, tr.mag_def[current_lang] .. " %" },
    { 6, 0, tr.resist_status[current_lang], ddl = "weapon_status_effect_template" },
    { nil, "header", "Stat bonuses", options = "moHideChildren", children = {
      { ['off'] = 0x18, ['type'] = 0, ['desc'] = tr.bonus_stat_type[current_lang] .. " 1", ddl = "armour_stat_bonus_template", children = {
        { ['off'] = 0x1C, ['type'] = 0, ['desc'] = tr.bonus_stat_val[current_lang] .. " 1" },
      } },
      { ['off'] = 0x19, ['type'] = 0, ['desc'] = tr.bonus_stat_type[current_lang] .. " 2", ddl = "armour_stat_bonus_template", children = {
        { ['off'] = 0x1D, ['type'] = 0, ['desc'] = tr.bonus_stat_val[current_lang] .. " 2" },
      } },
      { ['off'] = 0x1A, ['type'] = 0, ['desc'] = tr.bonus_stat_type[current_lang] .. " 3", ddl = "armour_stat_bonus_template", children = {
        { ['off'] = 0x1E, ['type'] = 0, ['desc'] = tr.bonus_stat_val[current_lang] .. " 3" },
      } },
      { ['off'] = 0x1B, ['type'] = 0, ['desc'] = tr.bonus_stat_type[current_lang] .. " 4", ddl = "armour_stat_bonus_template", children = {
        { ['off'] = 0x1F, ['type'] = 0, ['desc'] = tr.bonus_stat_val[current_lang] .. " 4" },
      } },
    } },
    --{ 0x14, 0, tr.resist_elem[current_lang] },
    { 0x11, 0, tr.mat_growth[current_lang], ddl = "materia_growth_template" },
    { nil, "header", tr.mat_slots[current_lang], options = "moHideChildren", children = {
      { ['off'] = 9, ['type'] = 1, ['desc'] = tr.mat_slots[current_lang] .. " 1 & 2", hex = true, ddl = "materia_slots_template" },
      { ['off'] = 11, ['type'] = 1, ['desc'] = tr.mat_slots[current_lang] .. " 3 & 4", hex = true, ddl = "materia_slots_template" },
      { ['off'] = 13, ['type'] = 1, ['desc'] = tr.mat_slots[current_lang] .. " 5 & 6", hex = true, ddl = "materia_slots_template" },
      { ['off'] = 15, ['type'] = 1, ['desc'] = tr.mat_slots[current_lang] .. " 7 & 8", hex = true, ddl = "materia_slots_template" },
    } },
    { 0x12, 0, tr.equip_char[current_lang], ddl = "equippable_character_template" },
  }
  accessory_stats = {
    shape = { "off", "type", "desc" },
    { 0, 0, tr.bonus_stat[current_lang], ddl = "armour_stat_bonus_template", children = {
      { ['off'] = 2, ['type'] = 0, ['desc'] = tr.bonus_amount[current_lang] },
    } },
    { 1, 0, tr.bonus_stat[current_lang], ddl = "armour_stat_bonus_template", children = {
      { ['off'] = 3, ['type'] = 0, ['desc'] = tr.bonus_amount[current_lang] },
    } },
    { 5, 0, tr.auto_stat_effect[current_lang], ddl = "auto_status_template" },
    { 12, 0, tr.equip_chars[current_lang], ddl = "equippable_character_template" },
    { 4, 0, tr.elem_def_type[current_lang], ddl = "elemental_defense_type_template" },
    { nil, "header", tr.elem_defenses[current_lang], options = "moHideChildren", children = create_shaped_table({
      ['shape'] = { "off", "type", "desc", ['ddl'] = "has_protection_template" },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, elem_names[current_lang][1] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, elem_names[current_lang][2] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, elem_names[current_lang][3] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 3, ['Binary.Size'] = 1 } }, elem_names[current_lang][4] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 4, ['Binary.Size'] = 1 } }, elem_names[current_lang][5] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 5, ['Binary.Size'] = 1 } }, elem_names[current_lang][6] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 6, ['Binary.Size'] = 1 } }, elem_names[current_lang][7] },
      { 6, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 7, ['Binary.Size'] = 1 } }, elem_names[current_lang][8] },
      { 7, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, elem_names[current_lang][9] },
    }) },
    { nil, "header", tr.status_def[current_lang], options = "moHideChildren", children = create_shaped_table({
      ['shape'] = { "off", "type", "desc", ['ddl'] = "has_protection_template" },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, sta_names[current_lang][1] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, sta_names[current_lang][2] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, sta_names[current_lang][3] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 3, ['Binary.Size'] = 1 } }, sta_names[current_lang][4] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 4, ['Binary.Size'] = 1 } }, sta_names[current_lang][5] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 5, ['Binary.Size'] = 1 } }, sta_names[current_lang][6] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 6, ['Binary.Size'] = 1 } }, sta_names[current_lang][7] },
      { 8, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 7, ['Binary.Size'] = 1 } }, sta_names[current_lang][8] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, sta_names[current_lang][9] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, sta_names[current_lang][10] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, sta_names[current_lang][11] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 3, ['Binary.Size'] = 1 } }, sta_names[current_lang][12] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 4, ['Binary.Size'] = 1 } }, sta_names[current_lang][13] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 5, ['Binary.Size'] = 1 } }, sta_names[current_lang][14] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 6, ['Binary.Size'] = 1 } }, sta_names[current_lang][15] },
      { 9, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 7, ['Binary.Size'] = 1 } }, sta_names[current_lang][16] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, sta_names[current_lang][17] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, sta_names[current_lang][18] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, sta_names[current_lang][19] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 4, ['Binary.Size'] = 1 } }, sta_names[current_lang][21] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 5, ['Binary.Size'] = 1 } }, sta_names[current_lang][22] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 6, ['Binary.Size'] = 1 } }, sta_names[current_lang][23] },
      { 10, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 7, ['Binary.Size'] = 1 } }, sta_names[current_lang][24] },
      { 11, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, sta_names[current_lang][25] },
      { 11, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, sta_names[current_lang][26] },
      { 11, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, sta_names[current_lang][27] },
    }) },
    --{ 13, 0, "?? byte 13" },
    --{ 14, 0, "?? byte 14" },
    --{ 15, 0, "?? byte 15" },
  }
  real_stats = {
    shape = { "off", "type", "desc" },
    { 13, 0, tr.lb[current_lang] },
    { 42, 1, tr.cur_hp[current_lang] },
    { 44, 1, tr.max_hp[current_lang] },
    { 46, 1, tr.cur_mp[current_lang] },
    { 48, 1, tr.max_mp[current_lang] },
    { 0, 0, tr.base_str[current_lang] },
    { 4, 0, tr.base_dex[current_lang] },
    { 1, 0, tr.base_vit[current_lang] },
    { 2, 0, tr.base_mag[current_lang] },
    { 3, 0, tr.base_spi[current_lang] },
    { 5, 0, tr.base_luc[current_lang] },
    { 6, 0, tr.extra_str[current_lang] },
    { 10, 0, tr.extra_dex[current_lang] },
    { 7, 0, tr.extra_vit[current_lang] },
    { 8, 0, tr.extra_mag[current_lang] },
    { 9, 0, tr.extra_spi[current_lang] },
    { 11, 0, tr.extra_luc[current_lang] },
    { 26, 0, tr.cur_weapon[current_lang], ddl = "equipped_weapon_template" },
    { 27, 0, tr.cur_armour[current_lang], ddl = "equipped_armour_template" },
    { 28, 0, tr.cur_acc[current_lang], ddl = "equipped_accessory_template" },
    { 29, 0, tr.added_status[current_lang], ddl = "menu_status_effect_template" },
    { 34, 1, tr.total_kills[current_lang] },
    { 12, 0, tr.cur_lb_level[current_lang] },
    { 36, 0, tr.lb_1_used[current_lang] },
    { 38, 0, tr.lb_2_used[current_lang] },
    { 40, 0, tr.lb_3_used[current_lang] },
    --{ 54, 1, "?? HP" },
    --{ 56, 1, "?? MP" },
    { -1, 0, tr.cur_level[current_lang] },
    { 58, 2, tr.cur_exp[current_lang] },
    --{ 54, 0, "?? Attack effect 1", hex = true },
    --{ 55, 0, "?? Attack type" },
    --{ 56, 0, "?? Attack effect 2", hex = true },
    { 126, 2, tr.exp_to_level[current_lang] },
  }
  display_stats = {
    shape = { "Offset", "Type", "Description" },
    { 14, 1, tr.cur_hp[current_lang] },
    { 16, 1, tr.max_hp[current_lang] },
    { 18, 1, tr.cur_mp[current_lang] },
    { 20, 1, tr.max_mp[current_lang] },
    { 0, 0, tr.str[current_lang] },
    { 4, 0, tr.dex[current_lang] },
    { 1, 0, tr.vit[current_lang] },
    { 2, 0, tr.mag[current_lang] },
    { 3, 0, tr.spi[current_lang] },
    { 5, 0, tr.luc[current_lang] },
    { 6, 1, tr.atk[current_lang] },
    { 8, 1, tr.def[current_lang] },
    { 10, 1, tr.mag_atk[current_lang] },
    { 12, 1, tr.mag_def[current_lang] },
  }
  battle_stats = {
    shape = { "Offset", "Type", "Description" },
    { -4, 1, tr.cur_mp[current_lang] },
    { -2, 1, tr.max_mp[current_lang] },
    { 0, 2, tr.cur_hp[current_lang] },
    { 4, 2, tr.max_hp[current_lang] },
  }
  battle_atb = {
    { 0, 0, tr.atb[current_lang] },
  }
  battle_limit_break = {
    { 0, 0, tr.lb[current_lang] },
  }
  chocobo_stats_1 = {
    -- http://forums.qhimm.com/index.php?topic=3241.0
    shape = { "off", "type", "desc" },
    { 0xF, 0, tr.choc_colour[current_lang], ddl = "chocobo_colour_template" },
    { 0xE, 0, tr.choc_gender[current_lang], ddl = "chocobo_gender_template" },
    { 0xD, 0, tr.choc_wins[current_lang], ddl = "chocobo_class_template" },
    { 0, 1, tr.cur_dash[current_lang] },
    { 2, 1, tr.max_dash[current_lang] },
    { 4, 1, tr.cur_run[current_lang] },
    { 6, 1, tr.max_run[current_lang] },
    { 8, 0, tr.accel[current_lang] },
    { 9, 0, tr.coop[current_lang] },
    { 0xA, 0, tr.intel[current_lang] },
    { 0xB, 0, tr.persona[current_lang] },
  }
  chocobo_stats_2 = {
    shape = { "off", "type", "desc" },
    { 0, 1, tr.stamina[current_lang] },
  }
  battle_char_names = {
    tr.top_char[current_lang],
    tr.mid_char[current_lang],
    tr.bot_char[current_lang],
    tr.enemy[current_lang] .. " ?",
    tr.enemy[current_lang] .. " 1",
    tr.enemy[current_lang] .. " 2",
    tr.enemy[current_lang] .. " 3",
    tr.enemy[current_lang] .. " 4",
    tr.enemy[current_lang] .. " 5",
  }
  menu_options = create_shaped_table({
    ['shape'] = { "off", "type", "desc", ['ddl'] = "menu_options_template" },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, tr.item[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, tr.magic[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 2, ['Binary.Size'] = 1 } }, tr.materia[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 3, ['Binary.Size'] = 1 } }, tr.equip[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 4, ['Binary.Size'] = 1 } }, tr.status[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 5, ['Binary.Size'] = 1 } }, tr.order[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 6, ['Binary.Size'] = 1 } }, tr.limit[current_lang] },
    { 0, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 7, ['Binary.Size'] = 1 } }, tr.config[current_lang] },
    { 1, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 0, ['Binary.Size'] = 1 } }, tr.phs[current_lang] },
    { 1, { ['type'] = 9, ['options'] = { ['Binary.Startbit'] = 1, ['Binary.Size'] = 1 } }, tr.save[current_lang] },
  })
end

register_custom_types()

-- STOP_INCLUDE
