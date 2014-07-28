(function() {
  var CreateStyle, Utils, styles_folder;

  Utils = require('../utils');

  styles_folder = path.join(__dirname, '../../../', "/src/styles");

  CreateStyle = (function() {
    function CreateStyle() {
      var file_name, import_text, name;
      name = Utils.lowercase(program.args[0]);
      file_name = "" + name + ".styl";
      fs.exists(path.join(styles_folder, file_name), function(exists) {
        if (exists) {
          console.log("File already exists.");
          return process.exit(0);
        }
      });
      import_text = "\n@import '" + file_name + "'";
      fs.readFile(path.join(styles_folder, "/app.styl"), 'utf8', (function(_this) {
        return function(err, data) {
          if (err) {
            throw err;
          }
          data = data.replace('"mixins.styl"', '"mixins.styl"' + import_text);
          fs.writeFile(path.join(styles_folder, "app.styl"), data, 'utf8', function(err) {});
          if (err) {
            throw err;
          }
          return console.log("File created successfully.");
        };
      })(this));
      fs.writeFile(path.join(styles_folder, file_name), '', 'utf8', function(err) {
        if (err) {
          throw err;
        }
        return console.log("File created successfully.");
      });
    }

    return CreateStyle;

  })();

  module.exports = CreateStyle;

}).call(this);
