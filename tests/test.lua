#! /usr/bin/env luvit
local fs = require "fs"
local yaml = require "../tinyyaml"

local doc = yaml.parse(fs.readFileSync("tests/test.yaml"))

p(doc)

for k, v in pairs(doc['timestamp']) do
  -- check timestamp:__tostring()
  print(k, tostring(v))
end
