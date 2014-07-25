CreateModule = require './commands/create_modules'
CreatePartial = require './commands/create_partials'
CreateStyle = require './commands/create_styles'

class AngularKickoff
	constructor:() ->
		program
			.version('0.0.1')
			.option('-g, --generate <module> [value]', 'Generate files')
			.parse(process.argv)
		
		return new CreateModule if program.generate == "module"
		return new CreatePartial if program.generate == "partial"
		return new CreateStyle if program.generate == "style"
		return console.log "Not exists"

module.exports = new AngularKickoff