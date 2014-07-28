(function() {
  var DestroyModule, Utils, scripts_folder, templates_folder;

  Utils = require('../utils');

  templates_folder = path.join(__dirname, '../..', "/templates");

  scripts_folder = path.join(__dirname, '../../../', "/src/scripts");

  DestroyModule = (function() {
    function DestroyModule() {
      var file_name, folder_name, module_name, name, values;
      values = program.args[0].split("/");
      module_name = Utils.lowercase(values[0]);
      folder_name = Utils.pluralize(values[0]);
      name = Utils.lowercase(values[1]);
      file_name = "" + folder_name + "/" + name + "_" + module_name + ".coffee";
      fs.exists(path.join(scripts_folder, file_name), function(exists) {
        if (!exists) {
          console.log("File not found.");
          return process.exit(0);
        }
      });
      fs.unlink(path.join(scripts_folder, file_name), function(err) {
        if (err) {
          throw err;
        }
        return console.log("File destroyed successfully");
      });
    }

    return DestroyModule;

  })();

  module.exports = DestroyModule;

}).call(this);
