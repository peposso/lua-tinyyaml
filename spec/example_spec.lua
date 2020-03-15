-- .vscode/settings.json <<
--   "Lua.workspace.library": {
--     "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1": true
--   },
local busted = require 'busted'
local assert = require 'luassert'
local yaml = require 'tinyyaml'

busted.describe("example", function()

  local t = yaml.parse(io.open("spec/example.yaml"):read('*a'))

  busted.it("map", function()
    assert.same(
      'Ben-Kiki',
      t.map['Block style'].Oren
    )
    -- not supported
    -- assert.same(
    --   'Evans',
    --   t.map['Flow style'].Clark
    -- )
  end)

  busted.it("omap", function()
    assert.same(
      'South-American constrictor snake. Scaly.',
      t.omap.Bestiary[3].anaconda
    )
    -- assert.same(
    --   {one='1', two='2', three='3'},
    --   t.omap.Numbers
    -- )
  end)

  busted.it("pairs", function()
    assert.same(
      'with client.',
      t.pairs['Block tasks'][4].meeting
    )
    -- not supported.
    -- assert.same(
    --   {meeting='with boss'},
    --   t.pairs['Flow tasks'][2]
    -- )
  end)

  busted.it("set", function()
    assert.same(
      true,
      t.set['baseball players']['Sammy Sosa']
    )
    assert.same(
      true,
      t.set['baseball teams']['New York Yankees']
    )
  end)

  busted.it("seq", function()
    local expected = {"Mercury", "Venus", "Earth", "Mars",
                      "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"}
    assert.same(
      expected,
      t.seq['Block style']
    )
    assert.same(
      expected,
      t.seq['Flow style']
    )
  end)

  busted.it("bool", function()
    for _, v in ipairs(t.bool) do
      assert.same(
        'boolean',
        type(v)
      )
    end
    assert.same(
      {true, true, true, false, false, false},
      t.bool
    )
  end)

  busted.it("float", function()
    -- canonical: 6.8523015e+5
    -- exponentioal: 685.230_15e+03
    -- fixed: 685_230.15
    -- sexagesimal: 190:20:30.15
    -- negative infinity: -.inf
    -- not a number: .NaN
    local function isnan(n)
      if type(n) ~= 'number' then return false end
      return n ~= n
    end

    assert.same(
      '6.8523015e+5',  -- not supported
      t.float.canonical
    )
    assert.same(
      '685.230_15e+03',  -- not supported
      t.float.exponentioal
    )
    assert.same(
      '685_230.15',  -- not supported
      t.float.fixed
    )
    assert.same(
      '190:20:30.15',  -- not supported
      t.float.sexagesimal
    )
    assert.same(
      -math.huge,
      t.float['negative infinity']
    )
    assert.same(
      true,
      isnan(t.float['not a number'])
    )
  end)

  busted.it("int", function()
    -- canonical: 685230
    -- decimal: +685_230
    -- octal: 02472256
    -- hexadecimal: 0x_0A_74_AE
    -- binary: 0b1010_0111_0100_1010_1110
    -- sexagesimal: 190:20:30

    assert.same(
      685230,
      t.int.canonical
    )
    assert.same(
      '+685_230',  -- not supported
      t.int.decimal
    )
    assert.same(
      2472256,  -- not correct yaml spec
      t.int.octal
    )
    assert.same(
      '0x_0A_74_AE',  -- not supported
      t.int.hexadecimal
    )
    assert.same(
      '0b1010_0111_0100_1010_1110',  -- not supported
      t.int.binary
    )
    assert.same(
      '190:20:30',  -- not supported
      t.int.sexagesimal
    )
  end)

  busted.it("merge", function()
    -- not supported
  end)

  -- busted.it("null", function()
  --   assert.same(
  --     'yaml.null',
  --     tostring(t.null.empty)
  --   )
  --   assert.same(
  --     'yaml.null',
  --     tostring(t.null.canonical)
  --   )
  --   assert.same(
  --     'yaml.null',
  --     tostring(t.null.english)
  --   )
  --   assert.same(
  --     'yaml.null',
  --     tostring(t.null.sparse[1])
  --   )
  --   assert.same(
  --     'yaml.null',
  --     tostring(t.null.sparse[3])
  --   )
  --   assert.same(
  --     'yaml.null',
  --     tostring(t.null.sparse[5])
  --   )
  -- end)

  busted.it("string", function()
    assert.same(
      'abcd',
      t.string.inline1
    )
    assert.same(
      'abcd',
      t.string.inline2
    )
    assert.same(
      'abcd',
      t.string.inline3
    )
    assert.same(
      'aaa\nbbb\nccc\n',
      t.string.block1
    )
    assert.same(
      'aaa bbb ccc\n',
      t.string.block4
    )
  end)
end)
