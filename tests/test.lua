#! /usr/bin/env luvit
local fs = require "fs"
local yaml = require "../tinyyaml"
p(yaml.parse(fs.readFileSync("tests/test.yaml")))
