(function() {
  var AngularKickoff, CreateModule, CreatePartial, CreateStyle;

  CreateModule = require('./commands/create_modules');

  CreatePartial = require('./commands/create_partials');

  CreateStyle = require('./commands/create_styles');

  AngularKickoff = (function() {
    function AngularKickoff() {
      program.version('0.0.1').option('-g, --generate <module> [value]', 'Generate files').parse(process.argv);
      if (program.generate === "module") {
        return new CreateModule;
      }
      if (program.generate === "partial") {
        return new CreatePartial;
      }
      if (program.generate === "style") {
        return new CreateStyle;
      }
      return console.log("Not exists");
    }

    return AngularKickoff;

  })();

  module.exports = new AngularKickoff;

}).call(this);
