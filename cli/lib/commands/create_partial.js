(function() {
  var CreatePartial, Utils, partials_folder;

  Utils = require('../utils');

  partials_folder = path.join(__dirname, '../../../', "/src/partials");

  CreatePartial = (function() {
    function CreatePartial() {
      var file_name, folder_name, name, values;
      values = program.args[0].split("/");
      folder_name = Utils.pluralize(values[0]);
      name = Utils.lowercase(values[1]);
      file_name = "" + name + ".jade";
      fs.exists(path.join(partials_folder, folder_name, file_name), function(exists) {
        if (exists) {
          console.log("File already exists.");
          return process.exit(0);
        }
      });
      fs.exists(path.join(partials_folder, folder_name), function(exists) {
        var data;
        if (!exists) {
          fs.mkdir(path.join(partials_folder, folder_name), '755');
        }
        data = "p " + name;
        return fs.writeFile(path.join(partials_folder, folder_name, file_name), data, 'utf8', function(err) {
          if (err) {
            throw err;
          }
          return console.log("File created successfully.");
        });
      });
    }

    return CreatePartial;

  })();

  module.exports = CreatePartial;

}).call(this);
