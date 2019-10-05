package = "lua-tinyyaml"
version = "0.1-0"
source = {
   url = "git://github.com/iresty/lua-tinyyaml",
   tag = "v0.1"
}

description = {
   summary = "a tiny yaml (subset) parser for pure lua",
   homepage = "https://github.com/iresty/lua-tinyyaml",
   license = "MIT License",
   maintainer = "peposso"
}

build = {
   type = "builtin",
   modules = {
      ["tinyyaml"] = "tinyyaml.lua"
   }
}
