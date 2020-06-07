package = "lua-tinyyaml"
version = "1.0-0"
source = {
   url = "git://github.com/peposso/lua-tinyyaml",
   tag = "1.0"
}

description = {
   summary = "a tiny yaml (subset) parser for pure lua",
   homepage = "https://github.com/peposso/lua-tinyyaml",
   license = "MIT License",
   maintainer = "peposso"
}

build = {
   type = "builtin",
   modules = {
      ["tinyyaml"] = "tinyyaml.lua"
   }
}
