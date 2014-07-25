(function() {
  var AngularKickoff, CreateModule;

  CreateModule = require('./commands/create_modules');

  AngularKickoff = (function() {
    function AngularKickoff() {
      program.version('0.0.1').option('-g, --generate <module> [value]', 'Generate files').parse(process.argv);
      if (program.generate === "module") {
        return new CreateModule;
      }
      if (program.generate === "partial") {
        return new CreatePartial;
      }
    }

    return AngularKickoff;

  })();

  module.exports = new AngularKickoff;

}).call(this);
