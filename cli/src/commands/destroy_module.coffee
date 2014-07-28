Utils = require('../utils')

# Folders
templates_folder = path.join( __dirname, '../..', "/templates")
scripts_folder = path.join( __dirname, '../../../', "/src/scripts")

class DestroyModule
	constructor:() ->
		values = program.args[0].split("/")
		module_name = Utils.lowercase(values[0])
		folder_name = Utils.pluralize(values[0])
		name = Utils.lowercase(values[1])
		file_name = "#{folder_name}/#{name}_#{module_name}.coffee"
		
		fs.exists path.join( scripts_folder, file_name), (exists) ->
			if !exists
				console.log("File not found.")
				process.exit(0)

		fs.unlink path.join(scripts_folder, file_name), (err) ->
			throw err if err
			console.log "File destroyed successfully"

module.exports = DestroyModule