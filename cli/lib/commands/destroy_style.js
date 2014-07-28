(function() {
  var DestroyStyle, Utils, styles_folder;

  Utils = require('../utils');

  styles_folder = path.join(__dirname, '../../../', "/src/styles");

  DestroyStyle = (function() {
    function DestroyStyle() {
      var file_name, name;
      name = Utils.lowercase(program.args[0]);
      file_name = "" + name + ".styl";
      fs.exists(path.join(styles_folder, file_name), function(exists) {
        if (!exists) {
          console.log("File not found.");
          return process.exit(0);
        }
      });
      fs.readFile(path.join(styles_folder, "/app.styl"), 'utf8', (function(_this) {
        return function(err, data) {
          if (err) {
            throw err;
          }
          data = data.replace("@import '" + file_name + "'", '');
          fs.writeFile(path.join(styles_folder, "app.styl"), data, 'utf8', function(err) {});
          if (err) {
            throw err;
          }
          return console.log("File created successfully.");
        };
      })(this));
      fs.unlink(path.join(styles_folder, file_name), function(err) {
        if (err) {
          throw err;
        }
        return console.log("File destroyed successfully");
      });
    }

    return DestroyStyle;

  })();

  module.exports = DestroyStyle;

}).call(this);
