# Generators
CreateModule = require './commands/create_module'
CreatePartial = require './commands/create_partial'
CreateStyle = require './commands/create_style'

# Destroyers
DestroyModule = require './commands/destroy_module'
DestroyPartial = require './commands/destroy_partial'
DestroyStyle = require './commands/destroy_style'

class AngularKickoff
	constructor:() ->
		program.on '--help', ->
		  console.log '  Examples:'
		  console.log ''
		  console.log '    To create modules use:'
		  console.log '    	$ angular-kickoff -g module folder/module'
		  console.log ''
		  
		program
			.version('0.1.0')
			.option('-g, --generate <option> [value]', 'Generate files')
			.option('-d, --destroy <option> [value]', 'Generate files')
			.parse(process.argv)

		
		
		# Generators
		return new CreateModule if program.generate == "module"
		return new CreatePartial if program.generate == "partial"
		return new CreateStyle if program.generate == "style"

		# Destroyers
		return new DestroyModule if program.destroy == "module"
		return new DestroyPartial if program.destroy == "partial"
		return new DestroyStyle if program.destroy == "style"

		# Command not found
		return console.log "Not exists"

module.exports = new AngularKickoff