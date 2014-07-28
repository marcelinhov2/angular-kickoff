(function() {
  var AngularKickoff, CreateModule, CreatePartial, CreateStyle, DestroyModule, DestroyPartial, DestroyStyle;

  CreateModule = require('./commands/create_module');

  CreatePartial = require('./commands/create_partial');

  CreateStyle = require('./commands/create_style');

  DestroyModule = require('./commands/destroy_module');

  DestroyPartial = require('./commands/destroy_partial');

  DestroyStyle = require('./commands/destroy_style');

  AngularKickoff = (function() {
    function AngularKickoff() {
      program.on('--help', function() {
        console.log('  Examples:');
        console.log('');
        console.log('    To create modules use:');
        console.log('    	$ angular-kickoff -g module folder/module');
        return console.log('');
      });
      program.version('0.1.0').option('-g, --generate <option> [value]', 'Generate files').option('-d, --destroy <option> [value]', 'Generate files').parse(process.argv);
      if (program.generate === "module") {
        return new CreateModule;
      }
      if (program.generate === "partial") {
        return new CreatePartial;
      }
      if (program.generate === "style") {
        return new CreateStyle;
      }
      if (program.destroy === "module") {
        return new DestroyModule;
      }
      if (program.destroy === "partial") {
        return new DestroyPartial;
      }
      if (program.destroy === "style") {
        return new DestroyStyle;
      }
      return console.log("Not exists");
    }

    return AngularKickoff;

  })();

  module.exports = new AngularKickoff;

}).call(this);
