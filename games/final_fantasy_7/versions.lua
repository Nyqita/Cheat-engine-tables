function guess_ps1_values(in_dict)
  in_dict.current_roster = in_dict.menu_items_base - 0x4
  in_dict.materia_base = in_dict.menu_items_base + 0x280
  in_dict.gil = in_dict.menu_items_base + 0x680
  in_dict.total_play_time = in_dict.menu_items_base + 0x684
  in_dict.save_phs = in_dict.menu_items_base + 0x6C6
  in_dict.key_items = in_dict.menu_items_base + 0x6E8
  in_dict.chocobo_stats_1_base = in_dict.menu_items_base + 0x8C8
  in_dict.chocobo_stats_2_base = in_dict.menu_items_base + 0x9EC
  in_dict.config_menu_settings = in_dict.menu_items_base + 0xBDC
  in_dict.post_battle = in_dict.menu_items_base + 0xBF8

  in_dict.debug_mode_2 = in_dict.current_screen + 0xB9A or unimplemented

  in_dict.random_battles_world_enabled = in_dict.random_battles_world + 4 or unimplemented
  in_dict.random_battles_world_loop_count = in_dict.random_battles_world + 9 or unimplemented
  in_dict.random_battles_world_loop_tick = in_dict.random_battles_world + 8 or unimplemented
  in_dict.random_battles_world_safe_distance = in_dict.random_battles_world or unimplemented

  in_dict.menu_rgb_offset = 3

end

function guess_steam_values(in_dict)
  in_dict.random_battles_world_safe_distance = in_dict.random_battles_world or unimplemented
  in_dict.random_battles_world_loop_tick = in_dict.random_battles_world or unimplemented
  in_dict.random_battles_world_loop_count = in_dict.random_battles_world + 0xD or unimplemented
  in_dict.random_battles_world_enabled = in_dict.random_battles_world + 0x14 or unimplemented

  in_dict.menu_rgb_offset = 4

  in_dict.post_battle = in_dict.post_battle + 0x0
  in_dict.battle_atb_base = in_dict.post_battle + 0xA855
  in_dict.battle_limit_break_base = in_dict.post_battle + 0xAB00
  in_dict.battle_stats_base = in_dict.post_battle + 0xCE48
  in_dict.battle_items_base = in_dict.post_battle + 0xE094
  in_dict.random_battles_field = in_dict.post_battle + 0x3233A8

  in_dict.menu_stats_base = in_dict.gil - 0x641A
  in_dict.accessory_stats_base = in_dict.menu_stats_base + 0x2646
  in_dict.armour_stats_base = in_dict.menu_stats_base + 0x2846
  in_dict.weapon_stats_base = in_dict.menu_stats_base + 0x4296
  in_dict.real_stats_base = in_dict.menu_stats_base + 0x58F4
  in_dict.current_roster = in_dict.menu_stats_base + 0x5D96
  in_dict.menu_items_base = in_dict.menu_stats_base + 0x5D9A
  in_dict.materia_base = in_dict.menu_stats_base + 0x601A
  in_dict.gil = in_dict.menu_stats_base + 0x641A
  in_dict.total_play_time = in_dict.menu_stats_base + 0x641E
  in_dict.save_phs = in_dict.menu_stats_base + 0x6460
  in_dict.key_items = in_dict.menu_stats_base + 0x6482
  in_dict.chocobo_stats_1_base = in_dict.menu_stats_base + 0x6662
  in_dict.chocobo_stats_2_base = in_dict.menu_stats_base + 0x6786
  in_dict.config_menu_settings = in_dict.menu_stats_base + 0x6976
end

unimplemented = 0x7FFFFFFFFFFF

default_values = {}
dv = default_values
dv.total_play_time = unimplemented -- 4 bytes: total play time ( in seconds )
dv.menu_items_base = unimplemented -- 1 byte: menu item slot 1 ID
dv.menu_stats_base = unimplemented -- 1 byte: top character's displayed strength in the menu
dv.menu_stats_offset = 0x440 -- offset between each character's menu stats
dv.battle_items_base = unimplemented -- address of battle item slot 1 ID
dv.materia_base = unimplemented -- 1 byte: materia slot 1 ID
dv.real_stats_base = unimplemented -- address of cloud's raw strength stat ( find string "#LOUD" - 14 0xE bytes ) or AOB (HEX 15 11 15 11 08 10)
dv.real_stats_offset = 0x84 -- offset between each character's real stats
dv.gil = unimplemented -- address of gil
dv.post_battle = unimplemented -- address of EXP rewarded after battle
dv.save_phs = unimplemented -- address of 2 bytes that determine if PHS and / or save are available in the menu
dv.weapon_stats_base = unimplemented -- address of byte Buster Sword's attack range ( 35 0x23 = close range ) AOB_HEX (23 FF 11 FF 12 FF 01 00 60 00 FF F8 FF FF 01 02 00 04 FF FF 02 FF FF FF 02 FF FF FF 06 07 00 00 00 00 00 00 12 1B 05 09 FF FF FF FF)
dv.weapon_stats_offset = 0x2C -- offset between each weapon's stats
dv.armour_stats_base = unimplemented -- address of byte bronze bangle's defense minus 2 AOB_HEX (00 FF 08 00 00 00 FF FF 00 00 00 00 00 00 00 00 00 00 FF 01 00 00 00 FF 00 FF FF FF 00 FF FF FF FE FF FF FF)
dv.armour_stats_offset = 0x24
dv.chocobo_stats_1_base = unimplemented  -- address of chocobo 1's dash stat
dv.chocobo_stats_1_offset = 0x10
dv.chocobo_stats_2_base = unimplemented  -- address of chocobo 1's stamina stat
dv.chocobo_stats_2_offset = 0x2
dv.config_menu_settings = unimplemented  -- address of battle speed menu setting
dv.battle_stats_base = unimplemented -- 2 bytes : top character's hp
dv.battle_stats_offset = 0x68
dv.battle_atb_base = unimplemented -- byte : top character's atb gauge
dv.battle_atb_offset = 0x44
dv.battle_limit_break_base = unimplemented -- byte : top character's limit break gauge
dv.battle_limit_break_offset = 0x34
dv.enemy_stats_offset = 0x68
dv.current_roster = unimplemented -- address of byte determining which character is in your top character slot
dv.random_battles_world = unimplemented -- 4 bytes search for 0xFFFFFF74 IMMEDIATELY after leaving a random battle on the world map
dv.random_battles_world_enabled = unimplemented
dv.random_battles_world_loop_count = unimplemented
dv.random_battles_world_loop_tick = unimplemented
dv.random_battles_world_safe_distance = unimplemented
dv.random_battles_field = unimplemented
dv.menu_rgb = unimplemented -- 12 bytes, default is AOB_HEX 0 0 176 0 0 128 0 0 80 0 0 32
dv.menu_rgb_offset = unimplemented
dv.current_screen = unimplemented -- https://gamefaqs.gamespot.com/ps/197341-final-fantasy-vii/faqs/3897
dv.debug_mode_2 = unimplemented
dv.key_items = unimplemented
dv.accessory_stats_base = unimplemented -- 00 FF 0A FF FF FF FF FF 00 00 00 00 FF 01 FE FF 01 FF 0A FF FF FF FF FF 00 00 00 00 FF 01 FE FF
dv.accessory_stats_offset = 0x10

-- "Final Fantasy VII (USA)" "SCUS_941.63;1", "SCUS_941.64;1", "SCUS_941.65;1"
FF7_PSX_NTSC_US = deep_copy(default_values)
ff7_us = FF7_PSX_NTSC_US

ff7_us.menu_items_base = 0x9CBE0

ff7_us.menu_stats_base = 0x9D84E
ff7_us.battle_stats_base = 0xF840C
ff7_us.battle_atb_base = 0xF5BBD
ff7_us.battle_limit_break_base = 0x9D866
ff7_us.battle_items_base = 0x1671B8
ff7_us.real_stats_base = 0x9C73A
ff7_us.post_battle = 0x9D7D8
ff7_us.weapon_stats_base = 0x738A0
ff7_us.armour_stats_base = 0x71E44
ff7_us.accessory_stats_base = 0x71C24
ff7_us.accessory_stats_offset = 0x10
--ff7_us.enemy_stats_base = 0xF85AC

ff7_us.random_battles_field = 0x7173C
ff7_us.random_battles_world = 0x11627C
ff7_us.random_battles_world_safe_distance = ff7_us.random_battles_world
ff7_us.random_battles_world_enabled = ff7_us.random_battles_world + 4
ff7_us.random_battles_world_loop_count = ff7_us.random_battles_world + 9
ff7_us.random_battles_world_loop_tick = ff7_us.random_battles_world + 8

--ff7_us.limit_break_growth = 0xA1450
ff7_us.menu_rgb = 0x49208
ff7_us.current_screen = 0x9A05C
ff7_us.debug_mode_2 = 0x9ABF6

ff7_us.battle_limit_break_base = 0xF5E68
ff7_us.battle_limit_break_offset = 0x34

guess_ps1_values(ff7_us)

-- "Final Fantasy VII International (Japan)" = {"SLPS_010.57;1", "SLPS_010.58;1", "SLPS_010.59;1", "SLPS_010.60;1"}
FF7_PSX_NTSC_JP_International = deep_copy(default_values)
ff7_int = FF7_PSX_NTSC_JP_International
ff7_int.armour_stats_base = 0x71CAC
ff7_int.battle_items_base = 0x1675B4
ff7_int.menu_items_base = 0x9C230
ff7_int.menu_stats_base = 0x9CE9E
ff7_int.random_battles_field = 0x715A4
ff7_int.real_stats_base = 0x9BD8A
ff7_int.weapon_stats_base = 0x73708
ff7_int.battle_stats_base = 0xF8808
ff7_int.current_screen = 0x996B0
ff7_int.battle_atb_base = 0xF5FB9
ff7_int.battle_limit_break_base = 0xF6264
ff7_int.random_battles_world = 0x11624C
ff7_int.menu_rgb = 0x49040
ff7_int.accessory_stats_base = 0x71A8C

guess_ps1_values(ff7_int)

-- Final Fantasy VII (UK) = {"SCES_008.67;1", "SCES_108.67;1", "SCES_208.67;1"}
FF7_PSX_PAL_UK = deep_copy(default_values)
ff7_uk = FF7_PSX_PAL_UK

ff7_uk.menu_items_base = 0x9CAAC

ff7_uk.key_items = 0x9D194
ff7_uk.menu_stats_base = 0x9D71A
ff7_uk.real_stats_base = 0x9C606
ff7_uk.weapon_stats_base = 0x73784
ff7_uk.armour_stats_base = 0x71D28
ff7_uk.random_battles_field = 0x71620
ff7_uk.current_screen = 0x99F2C
ff7_uk.random_battles_world = 0x116240
ff7_uk.battle_stats_base = 0xF8420
ff7_uk.battle_limit_break_base = 0xF5E7C
ff7_uk.battle_limit_break_offset = 0x34
ff7_uk.battle_items_base = 0x1671CC
ff7_uk.battle_atb_base = 0xF5BD1
ff7_uk.menu_rgb = 0x1D252C
ff7_uk.accessory_stats_base = 0x71B08

guess_ps1_values(ff7_uk)

-- Final Fantasy VII Steam ( version 1.0.9 English )
ff7_steam_ENGLISH_v_1_0_9 = deep_copy(default_values)
ff7_en = ff7_steam_ENGLISH_v_1_0_9
ff7_en.gil = 0x9C08B4
ff7_en.post_battle = 0x59E2C0
ff7_en.random_battles_world = 0xA3A87C
ff7_en.menu_rgb = 0x51EFC8
guess_steam_values(ff7_en)

-- Final Fantasy VII Steam ( version 1.0.9 French )
ff7_steam_FRENCH_v_1_0_9 = deep_copy(default_values)
ff7_fr = ff7_steam_FRENCH_v_1_0_9
ff7_fr.random_battles_world = 0xA18048
ff7_fr.post_battle = 0x5A00B0
ff7_fr.menu_rgb = 0x595F40
ff7_fr.gil = 0xB3A5F4
guess_steam_values(ff7_fr)

-- Final Fantasy VII Steam ( version 1.0.9 German )
ff7_steam_GERMAN_v_1_0_9 = deep_copy(default_values)
ff7_de = ff7_steam_GERMAN_v_1_0_9
ff7_de.gil = 0xB395E4
ff7_de.random_battles_world = 0xA17018
ff7_de.post_battle = 0x59F080
ff7_de.menu_rgb = 0x595AA8
guess_steam_values(ff7_de)

-- Final Fantasy VII Steam ( version 1.0.9 Spanish )
ff7_steam_SPANISH_v_1_0_9 = deep_copy(default_values)
ff7_es = ff7_steam_SPANISH_v_1_0_9
ff7_es.gil = 0xB3B0C4
ff7_es.post_battle = 0x5A0B10
ff7_es.random_battles_world = 0xA18AA8
ff7_es.menu_rgb = 0x596D80
guess_steam_values(ff7_es)

steam_versions = {
  { "FF7_EN", "Final Fantasy VII for Steam (English)", ff7_steam_ENGLISH_v_1_0_9, "eng" },
  { "FF7_FR", "Final Fantasy VII pour Steam (Français)", ff7_steam_FRENCH_v_1_0_9, "fre" },
  { "FF7_ES", "Final Fantasy VII para Steam (Español)", ff7_steam_SPANISH_v_1_0_9, "spa" },
  { "FF7_DE", "Final Fantasy VII für Steam (Deutsche)", ff7_steam_GERMAN_v_1_0_9, "ger" },
}

playstation_versions = {
  { "Final Fantasy VII for PlayStation (NTSC-U USA)", { "SCUS_94163", "SCUS_94164", "SCUS_94165" }, FF7_PSX_NTSC_US, "eng" },
  { "Final Fantasy VII International for PlayStation (NTSC-J Japan)", { "SLPS_01057", "SLPS_01058", "SLPS_01059", "SLPS_01060" }, FF7_PSX_NTSC_JP_International, "eng" },
  { "Final Fantasy VII for PlayStation (PAL Europe)", { "SCES_00867", "SCES_10867", "SCES_20867" }, FF7_PSX_PAL_UK, "eng" },
}
