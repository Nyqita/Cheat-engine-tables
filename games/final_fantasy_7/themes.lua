function prompt_theme()
  local theme_list_text = ""
  for i = 1, #rgb_themes do
    theme_list_text = theme_list_text .. "\n" .. i .. "\t" .. rgb_themes[i].title .. " by " .. rgb_themes[i].author
  end
  local user_input = inputQuery(
          "Choose theme number",
          "Enter the corresponding number of your desired theme from the list below" .. theme_list_text,
          "1"
  )
  if type(tonumber(user_input)) == "number" then
    --print("You chose theme " .. user_input)
    theme_setter(tonumber(user_input))
  else
    --print("That doesn't seem like a valid number. Not changing the current theme")
  end
end

function theme_setter(theme_index)
  -- Reference : https://imgur.com/a/sKP6G
  local total_themes = #rgb_themes
  current_theme = (theme_index - 1) % total_themes + 1
  local theme = rgb_themes[current_theme]
  if debug_verbosity >= 1 then
    debug_print(1, "Applying theme #" .. current_theme)
    recursive_print(theme)
  end
  local tl = { theme.tl.r, theme.tl.g, theme.tl.b }
  local tr = { theme.tr.r, theme.tr.g, theme.tr.b }
  local bl = { theme.bl.r, theme.bl.g, theme.bl.b }
  local br = { theme.br.r, theme.br.g, theme.br.b }
  write_rgb(tl, tr, bl, br)
end

function write_rgb(top_left, top_right, bottom_left, bottom_right)
  -- -- -- Begin test
  if top_left == "__test__" then
    local test_colours = {
      { 0, 10, 20 },
      { 80, 90, 100 },
      { 160, 170, 180 },
      { 240, 250, 255 },
    }
    print("Running test version of write_rgb() with following table")
    recursive_print(test_colours)
    write_rgb(table.unpack(test_colours))
    return
  end
  -- -- -- End test
  local rgb_cfg = {
    ['tl'] = { base_mem + cfg.menu_rgb + (cfg.menu_rgb_offset * 0), top_left },
    ['tr'] = { base_mem + cfg.menu_rgb + (cfg.menu_rgb_offset * 1), top_right },
    ['bl'] = { base_mem + cfg.menu_rgb + (cfg.menu_rgb_offset * 2), bottom_left },
    ['br'] = { base_mem + cfg.menu_rgb + (cfg.menu_rgb_offset * 3), bottom_right },
  }
  --rPrint(top_left)
  --rPrint(top_right)
  --rPrint(bottom_left)
  --rPrint(bottom_right)
  --rPrint(rgb_cfg)
  for key, value in pairs(rgb_cfg) do
    local address = value[1]
    local val = value[2]
    debug_print(3, "Writing RGB (" .. string.pstring(val) .. ") to " .. nb(address))
    writeBytes(address, val)
  end
  --print("done")
end

-- Source : https://imgur.com/a/sKP6G
rgb_themes = {
  {
    ["title"]  = "Default Menu",
    ["author"] = "unknown",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 176 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 80 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 128 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 32 },
  },

  {
    ["title"]  = "Aeris' Flowers",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 0 },
    ["bl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
    ["tr"]     = { ["r"] = 255, ["g"] = 276, ["b"] = 88 },
    ["br"]     = { ["r"] = 255, ["g"] = 176, ["b"] = 0 },
  },

  {
    ["title"]  = "Aqualung",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 0, ["g"] = 50, ["b"] = 175 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 255 },
    ["tr"]     = { ["r"] = 0, ["g"] = 200, ["b"] = 255 },
    ["br"]     = { ["r"] = 0, ["g"] = 50, ["b"] = 175 },
  },

  {
    ["title"]  = "Auron's Robe",
    ["author"] = "des kr",
    ["tl"]     = { ["r"] = 120, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 80, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 150, ["g"] = 150, ["b"] = 0 },
  },

  {
    ["title"]  = "Aurora Borealis",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 81, ["g"] = 0, ["b"] = 255 },
    ["tr"]     = { ["r"] = 255, ["g"] = 111, ["b"] = 111 },
    ["br"]     = { ["r"] = 173, ["g"] = 197, ["b"] = 0 },
  },

  {
    ["title"]  = "Beam of Darkness",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 27, ["g"] = 135, ["b"] = 30 },
    ["bl"]     = { ["r"] = 0, ["g"] = 33, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 33, ["b"] = 0 },
    ["br"]     = { ["r"] = 27, ["g"] = 135, ["b"] = 30 },
  },

  {
    ["title"]  = "Black Waltz",
    ["author"] = "des kr",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 60 },
    ["tr"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Blue Moon",
    ["author"] = "shawNe0",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 000 },
    ["bl"]     = { ["r"] = 49, ["g"] = 67, ["b"] = 115 },
    ["tr"]     = { ["r"] = 36, ["g"] = 88, ["b"] = 255 },
    ["br"]     = { ["r"] = 68, ["g"] = 255, ["b"] = 255 },
  },

  {
    ["title"]  = "Catastrophe",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 35, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 36, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 95, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 1, ["g"] = 0, ["b"] = 32 },
  },

  {
    ["title"]  = "Chocobo Plains",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 100, ["g"] = 106, ["b"] = 0 },
    ["bl"]     = { ["r"] = 50, ["g"] = 57, ["b"] = 0 },
    ["tr"]     = { ["r"] = 50, ["g"] = 64, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Clash of the Elements",
    ["author"] = "Shadow Flare",
    ["tl"]     = { ["r"] = 105, ["g"] = 12, ["b"] = 37 },
    ["bl"]     = { ["r"] = 35, ["g"] = 35, ["b"] = 35 },
    ["tr"]     = { ["r"] = 45, ["g"] = 45, ["b"] = 45 },
    ["br"]     = { ["r"] = 37, ["g"] = 12, ["b"] = 105 },
  },

  {
    ["title"]  = "Cosmo Candle",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 175, ["g"] = 50, ["b"] = 0 },
    ["bl"]     = { ["r"] = 255, ["g"] = 200, ["b"] = 0 },
    ["tr"]     = { ["r"] = 50, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 120, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Dark Light",
    ["author"] = "Majin Legacy",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 128, ["g"] = 128, ["b"] = 128 },
  },

  {
    ["title"]  = "Dark Side of the Moon",
    ["author"] = "des kr",
    ["tl"]     = { ["r"] = 122, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 150, ["g"] = 150, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 62 },
  },

  {
    ["title"]  = "Earth Colors",
    ["author"] = "deathguise950",
    ["tl"]     = { ["r"] = 0, ["g"] = 120, ["b"] = 255 },
    ["bl"]     = { ["r"] = 90, ["g"] = 60, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 130, ["b"] = 0 },
    ["br"]     = { ["r"] = 90, ["g"] = 60, ["b"] = 0 },
  },

  {
    ["title"]  = "Egokiller801's Preset",
    ["author"] = "Egokiller801",
    ["tl"]     = { ["r"] = 0, ["g"] = 166, ["b"] = 166 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 88, ["g"] = 0, ["b"] = 112 },
    ["br"]     = { ["r"] = 255, ["g"] = 137, ["b"] = 043 },
  },

  {
    ["title"]  = "Eternal Rainbow",
    ["author"] = "The Yellow Mage",
    ["tl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 0 },
    ["tr"]     = { ["r"] = 255, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 255 },
    ["br"]     = { ["r"] = 0, ["g"] = 255, ["b"] = 0 },
  },

  {
    ["title"]  = "Final Fantasy X",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 105, ["g"] = 189, ["b"] = 235 },
    ["bl"]     = { ["r"] = 105, ["g"] = 189, ["b"] = 235 },
    ["tr"]     = { ["r"] = 205, ["g"] = 205, ["b"] = 122 },
    ["br"]     = { ["r"] = 236, ["g"] = 179, ["b"] = 255 },
  },

  {
    ["title"]  = "From the Abyss",
    ["author"] = "Shadow Flare",
    ["tl"]     = { ["r"] = 95, ["g"] = 0, ["b"] = 140 },
    ["bl"]     = { ["r"] = 16, ["g"] = 28, ["b"] = 16 },
    ["tr"]     = { ["r"] = 20, ["g"] = 35, ["b"] = 20 },
    ["br"]     = { ["r"] = 76, ["g"] = 0, ["b"] = 10 },
  },

  {
    ["title"]  = "Golden Ray",
    ["author"] = "sonicboom52591",
    ["tl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
    ["bl"]     = { ["r"] = 85, ["g"] = 84, ["b"] = 0 },
    ["tr"]     = { ["r"] = 85, ["g"] = 84, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Holy Unleashed",
    ["author"] = "BlackDoom",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
    ["tr"]     = { ["r"] = 125, ["g"] = 100, ["b"] = 30 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Icy Fields",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
    ["bl"]     = { ["r"] = 0, ["g"] = 88, ["b"] = 129 },
    ["tr"]     = { ["r"] = 0, ["g"] = 88, ["b"] = 176 },
    ["br"]     = { ["r"] = 0, ["g"] = 255, ["b"] = 255 },
  },

  {
    ["title"]  = "Lifestream Rainbow",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 175 },
    ["bl"]     = { ["r"] = 0, ["g"] = 200, ["b"] = 255 },
    ["tr"]     = { ["r"] = 50, ["g"] = 100, ["b"] = 128 },
    ["br"]     = { ["r"] = 255, ["g"] = 175, ["b"] = 255 },
  },

  {
    ["title"]  = "Light of Darkness",
    ["author"] = "Final_Valkyrie",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 100, ["g"] = 100, ["b"] = 100 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "HH_King's Preset",
    ["author"] = "HH_King",
    ["tl"]     = { ["r"] = 45, ["g"] = 44, ["b"] = 27 },
    ["tr"]     = { ["r"] = 58, ["g"] = 44, ["b"] = 57 },
    ["bl"]     = { ["r"] = 89, ["g"] = 44, ["b"] = 57 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Midgar Lights",
    ["author"] = "Cloudii_17",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 200, ["b"] = 0 },
    ["tr"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "The Newspaper",
    ["author"] = "xoxJayoxo",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 45, ["g"] = 45, ["b"] = 45 },
    ["br"]     = { ["r"] = 150, ["g"] = 150, ["b"] = 150 },
  },

  {
    ["title"]  = "New World Order",
    ["author"] = "Shadow Flare",
    ["tl"]     = { ["r"] = 0, ["g"] = 100, ["b"] = 100 },
    ["bl"]     = { ["r"] = 40, ["g"] = 40, ["b"] = 40 },
    ["tr"]     = { ["r"] = 100, ["g"] = 100, ["b"] = 100 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Night Horizon",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 74 },
    ["bl"]     = { ["r"] = 15, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 22, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Northern Cave",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 44, ["g"] = 176, ["b"] = 88 },
    ["tr"]     = { ["r"] = 44, ["g"] = 88, ["b"] = 176 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Once in a Blue Moon",
    ["author"] = "sonicboom52591",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 51 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 55 },
  },

  {
    ["title"]  = "Pea Soup",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 138, ["g"] = 170, ["b"] = 0 },
    ["bl"]     = { ["r"] = 81, ["g"] = 112, ["b"] = 0 },
    ["tr"]     = { ["r"] = 98, ["g"] = 166, ["b"] = 0 },
    ["br"]     = { ["r"] = 173, ["g"] = 197, ["b"] = 0 },
  },

  {
    ["title"]  = "Purple Haze",
    ["author"] = "NintendoBoy259",
    ["tl"]     = { ["r"] = 9, ["g"] = 7, ["b"] = 15 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 79, ["g"] = 61, ["b"] = 131 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Purple Hope",
    ["author"] = "sonicboom52591",
    ["tl"]     = { ["r"] = 92, ["g"] = 0, ["b"] = 122 },
    ["bl"]     = { ["r"] = 139, ["g"] = 0, ["b"] = 119 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Purple Rays",
    ["author"] = "Shadow Flare",
    ["tl"]     = { ["r"] = 111, ["g"] = 0, ["b"] = 135 },
    ["bl"]     = { ["r"] = 0, ["g"] = 40, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 27, ["b"] = 0 },
    ["br"]     = { ["r"] = 99, ["g"] = 0, ["b"] = 120 },
  },

  {
    ["title"]  = "Sepia Horizon",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 60, ["g"] = 18, ["b"] = 0 },
    ["bl"]     = { ["r"] = 15, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 22, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Seto's Spirit",
    ["author"] = "zombieluzz",
    ["tl"]     = { ["r"] = 95, ["g"] = 0, ["b"] = 95 },
    ["bl"]     = { ["r"] = 80, ["g"] = 40, ["b"] = 20 },
    ["tr"]     = { ["r"] = 105, ["g"] = 30, ["b"] = 75 },
    ["br"]     = { ["r"] = 90, ["g"] = 50, ["b"] = 0 },
  },

  {
    ["title"]  = "Silver Edge",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 129, ["g"] = 128, ["b"] = 128 },
    ["bl"]     = { ["r"] = 1, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 129, ["g"] = 129, ["b"] = 129 },
  },

  {
    ["title"]  = "Silver Landscape",
    ["author"] = "Legend_Saber",
    ["tl"]     = { ["r"] = 92, ["g"] = 95, ["b"] = 91 },
    ["tr"]     = { ["r"] = 91, ["g"] = 88, ["b"] = 91 },
    ["bl"]     = { ["r"] = 80, ["g"] = 80, ["b"] = 80 },
    ["br"]     = { ["r"] = 31, ["g"] = 32, ["b"] = 32 },
  },

  {
    ["title"]  = "Simple & Elegant",
    ["author"] = "Tyrant_Wave",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 233, ["g"] = 233, ["b"] = 233 },
    ["br"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Sprite",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 115, ["g"] = 115, ["b"] = 190 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 190 },
    ["bl"]     = { ["r"] = 0, ["g"] = 187, ["b"] = 0 },
    ["br"]     = { ["r"] = 115, ["g"] = 187, ["b"] = 115 },
  },

  {
    ["title"]  = "Starlight Ray",
    ["author"] = "Sephiru",
    ["tl"]     = { ["r"] = 000, ["g"] = 000, ["b"] = 000 },
    ["bl"]     = { ["r"] = 041, ["g"] = 020, ["b"] = 071 },
    ["tr"]     = { ["r"] = 019, ["g"] = 020, ["b"] = 042 },
    ["br"]     = { ["r"] = 000, ["g"] = 000, ["b"] = 000 },
  },

  {
    ["title"]  = "Strawberry Banana",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 150, ["g"] = 20, ["b"] = 20 },
    ["bl"]     = { ["r"] = 150, ["g"] = 20, ["b"] = 20 },
    ["tr"]     = { ["r"] = 255, ["g"] = 150, ["b"] = 150 },
    ["br"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 0 },
  },

  {
    ["title"]  = "Sunkist",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 255, ["g"] = 105, ["b"] = 75 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 100 },
    ["tr"]     = { ["r"] = 0, ["g"] = 144, ["b"] = 118 },
    ["br"]     = { ["r"] = 255, ["g"] = 105, ["b"] = 75 },
  },

  {
    ["title"]  = "Terracotta",
    ["author"] = "Kong K Rool",
    ["tl"]     = { ["r"] = 145, ["g"] = 82, ["b"] = 45 },
    ["bl"]     = { ["r"] = 189, ["g"] = 60, ["b"] = 39 },
    ["tr"]     = { ["r"] = 214, ["g"] = 142, ["b"] = 95 },
    ["br"]     = { ["r"] = 155, ["g"] = 86, ["b"] = 70 },
  },

  {
    ["title"]  = "The Planet's Dream",
    ["author"] = "sonicboom52591",
    ["tl"]     = { ["r"] = 75, ["g"] = 50, ["b"] = 0 },
    ["bl"]     = { ["r"] = 51, ["g"] = 0, ["b"] = 84 },
    ["tr"]     = { ["r"] = 151, ["g"] = 38, ["b"] = 255 },
    ["br"]     = { ["r"] = 201, ["g"] = 32, ["b"] = 6 },
  },

  {
    ["title"]  = "This Guy Are Sick",
    ["author"] = "Snausages",
    ["tl"]     = { ["r"] = 0, ["g"] = 175, ["b"] = 135 },
    ["bl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 75 },
    ["tr"]     = { ["r"] = 0, ["g"] = 100, ["b"] = 130 },
    ["br"]     = { ["r"] = 60, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Tiger Stripe",
    ["author"] = "demotbra",
    ["tl"]     = { ["r"] = 223, ["g"] = 107, ["b"] = 0 },
    ["bl"]     = { ["r"] = 87, ["g"] = 38, ["b"] = 15 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 255, ["g"] = 94, ["b"] = 75 },
  },

  {
    ["title"]  = "Venusian Sunset",
    ["author"] = "deathguise950",
    ["tl"]     = { ["r"] = 110, ["g"] = 0, ["b"] = 255 },
    ["bl"]     = { ["r"] = 100, ["g"] = 0, ["b"] = 110 },
    ["tr"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 255, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Vincent's Blood",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 0, ["g"] = 0, ["b"] = 0 },
    ["bl"]     = { ["r"] = 80, ["g"] = 0, ["b"] = 0 },
    ["tr"]     = { ["r"] = 75, ["g"] = 0, ["b"] = 0 },
    ["br"]     = { ["r"] = 200, ["g"] = 0, ["b"] = 0 },
  },

  {
    ["title"]  = "Wutai Sky",
    ["author"] = "Bijutsu Sensei",
    ["tl"]     = { ["r"] = 0, ["g"] = 50, ["b"] = 175 },
    ["bl"]     = { ["r"] = 0, ["g"] = 200, ["b"] = 255 },
    ["tr"]     = { ["r"] = 0, ["g"] = 130, ["b"] = 215 },
    ["br"]     = { ["r"] = 255, ["g"] = 255, ["b"] = 255 },
  },

  {
    ["title"]  = "Xbox Bios Theme",
    ["author"] = "jamiedude10",
    ["tl"]     = { ["r"] = 171, ["g"] = 171, ["b"] = 70 },
    ["bl"]     = { ["r"] = 133, ["g"] = 255, ["b"] = 51 },
    ["tr"]     = { ["r"] = 0, ["g"] = 93, ["b"] = 57 },
    ["br"]     = { ["r"] = 0, ["g"] = 175, ["b"] = 57 },
  },

}
