var tabs = require("sdk/tabs");
var self = require("sdk/self");

tabs.on('ready', function(tab) {
  tab.attach({
    contentScriptFile: self.data.url("jose.js")
  });
});
