(function() {
  var CreateModule, Utils, scripts_folder, templates_folder;

  Utils = require('../utils');

  templates_folder = path.join(__dirname, '../..', "/templates");

  scripts_folder = path.join(__dirname, '../../../', "/src/scripts");

  CreateModule = (function() {
    function CreateModule() {
      var folder_name, module_name, name, values;
      values = program.args[0].split("/");
      module_name = Utils.lowercase(values[0]);
      folder_name = Utils.pluralize(values[0]);
      name = Utils.lowercase(values[1]);
      fs.readFile(path.join(templates_folder, "/modules"), 'utf8', (function(_this) {
        return function(err, data) {
          var file_name;
          if (err) {
            throw err;
          }
          data = data.replace("~NAME", Utils.camelize(name));
          data = data.replace("~MODULE", Utils.camelize(module_name));
          file_name = "" + folder_name + "/" + name + "_" + module_name + ".coffee";
          fs.writeFile(path.join(scripts_folder, file_name), data, 'utf8', function(err) {});
          if (err) {
            throw err;
          }
        };
      })(this));
    }

    return CreateModule;

  })();

  module.exports = CreateModule;

}).call(this);
