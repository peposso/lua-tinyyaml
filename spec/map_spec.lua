-- .vscode/settings.json <<
--   "Lua.workspace.library": {
--     "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1": true
--   },
local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("map", function()

  busted.it("map with colon for item", function()

    assert.same(
        {
          value = {"a:1"}
        },
        yaml.parse([[
          value:
            - a:1
        ]])
      )

    assert.same(
        {
          value = {"a:1"}
        },
        yaml.parse([[
          value:
            - "a:1"
        ]])
      )

      assert.same(
        {
          value = {{a = 1}}
        },
        yaml.parse([[
          value:
            - a: 1
        ]])
      )
  end)
end)
