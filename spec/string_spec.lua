-- .vscode/settings.json <<
--   "Lua.workspace.library": {
--     "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1": true
--   },
local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("string", function()

  busted.it("string:", function()
    assert.same(
      {
        value = "hello"
      },
      yaml.parse([[
        value: hello #world
      ]])
    )

    assert.same(
      {
        value = "hello# world"
      },
      yaml.parse([[
        value: hello# world
      ]])
    )

    assert.same(
      {
        value = "hello"
      },
      yaml.parse([[
        value: 'hello' # world
      ]])
    )
  end)

  busted.it("string: key contains controlchar", function()
    assert.same(
      {
        ["hello:world"] = true
      },
      yaml.parse([[
        hello:world: true
      ]])
    )

    assert.same(
      {
        ["hello:world"] = true
      },
      yaml.parse([[
        hello:world : true
      ]])
    )

    assert.same(
      {
        ["hello world"] = true
      },
      yaml.parse([[
        hello world: true
      ]])
    )

    assert.same(
      {
        ["hello world"] = true
      },
      yaml.parse([[
        hello world     : true
      ]])
    )

    assert.same(
      {
        ["hello#world"] = true
      },
      yaml.parse([[
        hello#world: true
      ]])
    )

    assert.same(
      {
        ["hello#world"] = true
      },
      yaml.parse([[
        hello#world : true
      ]])
    )
  end)

  busted.it("string: quoted key", function()
    assert.same(
      {
        ["hello world"] = true
      },
      yaml.parse([[
        "hello world": true
      ]])
    )

    assert.same(
      {
        ["hello world"] = true
      },
      yaml.parse([[
        "hello world": true
      ]])
    )

    assert.same(
      {
        ["hello world"] = true
      },
      yaml.parse([[
        'hello world': true
      ]])
    )

    assert.same(
      {
        ["hello#world"] = true
      },
      yaml.parse([[
        'hello#world': true
      ]])
    )

    assert.same(
      {
        ["hello':'world"] = true
      },
      yaml.parse([[
        "hello':'world": true
      ]])
    )
  end)

  busted.it("string: hash in quoted", function()
    assert.same(
      {
        value = "hello #world"
      },
      yaml.parse([[
        value: "hello #world" # hello world
      ]])
    )

    assert.same(
      {
        value = "hello #world"
      },
      yaml.parse([[
        value: 'hello #world' # hello world
      ]])
    )
  end)
end)
