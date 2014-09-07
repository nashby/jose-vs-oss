var self    = require("sdk/self");
var pageMod = require('sdk/page-mod');

pageMod.PageMod({
  include: "*.github.com",
  contentStyleFile: self.data.url("jose.css"),
  contentScriptFile: self.data.url("jose.js")
});
