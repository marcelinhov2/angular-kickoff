Utils = require('../utils')

# Folders
templates_folder = path.join( __dirname, '../..', "/templates")
scripts_folder = path.join( __dirname, '../../../', "/src/scripts")

class CreateModule
	constructor:() ->
		values = program.args[0].split("/")
		module_name = Utils.lowercase(values[0])
		folder_name = Utils.pluralize(values[0])
		name = Utils.lowercase(values[1])

		fs.readFile path.join( templates_folder, "/modules"), 'utf8', (err, data) =>
			throw err  if err
			data = data.replace "~NAME", Utils.camelize(name)
			data = data.replace "~MODULE", Utils.camelize(module_name)
			file_name = "#{folder_name}/#{name}_#{module_name}.coffee"
			
			fs.writeFile path.join( scripts_folder, file_name),
									 data,
									 'utf8', 
									 (err) ->
				throw err if err			

module.exports =  CreateModule