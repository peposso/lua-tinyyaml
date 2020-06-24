-- .vscode/settings.json <<
--   "Lua.workspace.library": {
--     "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1": true
--   },
local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("duplicate keys", function()
  busted.it("preserves duplicate map keys in block style", function()
    assert.same(
      {
        map = {
          Fruit = "apple",
          Fruit_1 = "orange",
          Fruit_2 = "banana",
          Vegetable = "celery",
          Vegetable_1 = "cucumber",
          Vegetable_2 = "broccoli"
        }
      },
      yaml.parse([[
        map:
          Fruit : apple
          Fruit : orange
          Fruit : banana
          Vegetable : celery
          Vegetable : cucumber
          Vegetable : broccoli
      ]])
    )
  end)
  busted.it("preserves duplicate map keys in flow style", function()
    assert.same(
      {
        map = {
          Fruit = "apple",
          Fruit_1 = "orange",
          Fruit_2 = "banana",
          Vegetable = "celery",
          Vegetable_1 = "cucumber",
          Vegetable_2 = "broccoli"
        }
      },
      yaml.parse([[
        map: { Fruit: apple, Fruit: orange, Fruit: banana, Vegetable: celery, Vegetable: cucumber, Vegetable: broccoli }
      ]])
    )
  end)
end)