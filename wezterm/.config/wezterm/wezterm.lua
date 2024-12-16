local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Rouge 2"
config.font = wezterm.font("JetBrains Mono")
config.window_background_image = "/Users/lisandrobertoli/gojo.png"
config.max_fps = 240

config.window_background_image_hsb = {
	-- Darken the background image
	brightness = 0.1,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1.8,
	saturation = 0.5,
}
-- and finally, return the configuration to wezterm
return config
