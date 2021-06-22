-- .vscode/settings.json <<
--   "Lua.workspace.library": {
--     "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1": true
--   },
local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

local expected = {
  map = {
    Fruit = "apple",
    Fruit_1 = "orange",
    Fruit_2 = "banana",
    Vegetable = "celery",
    Vegetable_1 = "cucumber",
    Vegetable_2 = "broccoli"
  }
}

busted.describe("duplicate keys", function()
  busted.describe("in block style", function()
    busted.it("preserves duplicate map keys", function()
      assert.same(
        expected,
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
    busted.it("recognizes existing _ keys", function()
      assert.same(
        expected,
        yaml.parse([[
          map:
            Fruit   : apple
            Fruit_1 : orange
            Fruit   : banana
            Vegetable   : celery
            Vegetable_1 : cucumber
            Vegetable   : broccoli
        ]])
      )
    end)
  end)
  busted.describe("in flow style", function()
    busted.it("preserves duplicate map keys", function()
      assert.same(
        expected,
        yaml.parse([[
          map: { Fruit: apple, Fruit: orange, Fruit: banana, Vegetable: celery, Vegetable: cucumber, Vegetable: broccoli }
        ]])
      )
    end)
    busted.it("recognizes existing _ keys", function()
      assert.same(
        expected,
        yaml.parse([[
          map: { Fruit: apple, Fruit_1: orange, Fruit: banana, Vegetable: celery, Vegetable_1: cucumber, Vegetable: broccoli }
        ]])
      )
    end)
  end)
end)