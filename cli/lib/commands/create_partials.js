(function() {
  var CreateModule, Utils, scripts_folder;

  Utils = require('../utils');

  scripts_folder = path.join(__dirname, '../../../', "/src/partials");

  CreateModule = (function() {
    function CreateModule() {
      var data, file_name, folder_name, name, values;
      values = program.args[0].split("/");
      folder_name = Utils.pluralize(values[0]);
      name = Utils.lowercase(values[1]);
      file_name = "" + folder_name + "/" + name + ".jade";
      fs.exists(path.join(scripts_folder, file_name), function(exists) {
        if (exists) {
          console.log("File already exists.");
          return process.exit(0);
        }
      });
      fs.mkdir(path.join(scripts_folder, folder_name), '755', function(data) {});
      data = "p " + name;
      fs.writeFile(path.join(scripts_folder, file_name), data, 'utf8', function(err) {
        if (err) {
          throw err;
        }
        return console.log("File created succesfully.");
      });
    }

    return CreateModule;

  })();

  module.exports = CreateModule;

}).call(this);
