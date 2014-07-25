Utils = require('../utils')

# Folders
scripts_folder = path.join( __dirname, '../../../', "/src/partials")

class CreateModule
	constructor:() ->
		values = program.args[0].split("/")
		folder_name = Utils.pluralize(values[0])
		name = Utils.lowercase(values[1])
		file_name = "#{folder_name}/#{name}.jade"

		fs.exists path.join( scripts_folder, file_name), (exists) ->
			if exists
				console.log("File already exists.")
				process.exit(0)
		
		fs.mkdir path.join(scripts_folder, folder_name), '755'

		data = "p #{name}"
		
		fs.writeFile path.join( scripts_folder, file_name), data, 'utf8', (err) ->
			throw err if err
			console.log "File created succesfully."

module.exports =  CreateModule