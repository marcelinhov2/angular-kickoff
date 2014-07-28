(function() {
  var DestroyPartial, Utils, partials_folder;

  Utils = require('../utils');

  partials_folder = path.join(__dirname, '../../../', "/src/partials");

  DestroyPartial = (function() {
    function DestroyPartial() {
      var file_name, folder_name, name, values;
      values = program.args[0].split("/");
      folder_name = Utils.pluralize(values[0]);
      name = Utils.lowercase(values[1]);
      file_name = "" + folder_name + "/" + name + ".jade";
      fs.exists(path.join(partials_folder, file_name), function(exists) {
        if (!exists) {
          console.log("File not found.");
          return process.exit(0);
        }
      });
      fs.unlink(path.join(partials_folder, file_name), function(err) {
        if (err) {
          throw err;
        }
        return console.log("File destroyed successfully");
      });
      fs.readdir(path.join(partials_folder, folder_name), function(err, data) {
        if (err) {
          throw err;
        }
        if (!data.length) {
          return fs.rmdir(path.join(partials_folder, folder_name), function(err) {
            if (err) {
              throw err;
            }
            return console.log("Folder destroyed successfully");
          });
        }
      });
    }

    return DestroyPartial;

  })();

  module.exports = DestroyPartial;

}).call(this);
