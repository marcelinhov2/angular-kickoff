Utils = require('../utils')

# Folders
partials_folder = path.join( __dirname, '../../../', "/src/partials")

class CreatePartial
	constructor:() ->
		values = program.args[0].split("/")
		folder_name = Utils.pluralize(values[0])
		name = Utils.lowercase(values[1])
		file_name = "#{name}.jade"

		fs.exists path.join( partials_folder, folder_name, file_name), (exists) ->
			if exists
				console.log("File already exists.")
				process.exit(0)
		
		fs.exists path.join(partials_folder, folder_name), (exists) -> 
			if !exists
				fs.mkdir path.join(partials_folder, folder_name), '755'

			data = "p #{name}"
			fs.writeFile path.join( partials_folder, folder_name, file_name), data, 'utf8', (err) ->
				throw err if err
				console.log "File created successfully."

module.exports =  CreatePartial