(function() {
  var CreateStyle, Utils, styles_folder;

  Utils = require('../utils');

  styles_folder = path.join(__dirname, '../../../', "/src/styles");

  CreateStyle = (function() {
    function CreateStyle() {
      var data, file_name, name;
      name = Utils.lowercase(program.args[0]);
      file_name = "" + name + ".styl";
      fs.exists(path.join(styles_folder, file_name), function(exists) {
        if (exists) {
          console.log("File already exists.");
          return process.exit(0);
        }
      });
      data = "\n@import '" + file_name + "'";
      fs.appendFile(path.join(styles_folder, "/app.styl"), data, (function(_this) {
        return function(err) {
          if (err) {
            throw err;
          }
        };
      })(this));
      fs.writeFile(path.join(styles_folder, file_name), '', 'utf8', function(err) {
        if (err) {
          throw err;
        }
        return console.log("File created succesfully.");
      });
    }

    return CreateStyle;

  })();

  module.exports = CreateStyle;

}).call(this);
