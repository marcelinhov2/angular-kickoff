CreateModule = require './commands/create_modules'

class AngularKickoff
	constructor:() ->
		program
			.version('0.0.1')
			.option('-g, --generate <module> [value]', 'Generate files')
			.parse(process.argv)
		
		return new CreateModule if program.generate == "module"
		return new CreatePartial if program.generate == "partial"

module.exports = new AngularKickoff