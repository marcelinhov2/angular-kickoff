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
      console.log '  Ng-Classify Modules Available (module_name): '
      console.log '' 
      console.log '    animation / config / constant / controller / directive /'.cyan
      console.log '    factory / filter / provider / run / service / value'.cyan
      console.log ''
      console.log '  Examples:'
      console.log '' 
      console.log '    To create modules:'
      console.log '      $ angular-kickoff -g module module_name/class_name'.green
      console.log '' 
      console.log '    To create partials:'
      console.log '      $ angular-kickoff -g partial folder_name/name'.green
      console.log ''
      console.log '    To create styles:'
      console.log '      $ angular-kickoff -g style name'.green
      console.log ''
      console.log '    To destroy modules:'
      console.log '      $ angular-kickoff -d module module_name/class_name'.red
      console.log '' 
      console.log '    To destroy partials:'
      console.log '      $ angular-kickoff -d partial folder_name/name'.red
      console.log ''
      console.log '    To destroy styles:'
      console.log '      $ angular-kickoff -d style name'.red
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
		return console.log program.help()

module.exports = new AngularKickoff