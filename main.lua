-----------------------------------------------------------------------------------------
--
-- main.lua
-- Parallax Scrolling Background
--
-- Created by Jorge Tapia on 6/13/16.
-- Copyright © 2016 Parallax Scrolling Background. All rights reserved.
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

local bg1 = {"bg/bg1/layer5.png", "bg/bg1/layer4.png", "bg/bg1/layer3.png", "bg/bg1/layer2.png", "bg/bg1/layer1.png"}
local bgs = { bg1 }

math.randomseed(os.time())
local layers = bgs[math.random(1, #bgs)]

local parallax = require("parallax")
parallax:init(layers, 8.0, 3.0)
parallax:start()
