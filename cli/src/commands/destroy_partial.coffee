Utils = require('../utils')

# Folders
partials_folder = path.join( __dirname, '../../../', "/src/partials")

class DestroyPartial
	constructor:() ->
		values = program.args[0].split("/")
		folder_name = Utils.pluralize(values[0])
		name = Utils.lowercase(values[1])
		file_name = "#{folder_name}/#{name}.jade"

		fs.exists path.join(partials_folder, file_name), (exists) ->
			if !exists
				console.log("File not found.")
				process.exit(0)

		fs.unlink path.join(partials_folder, file_name), (err) ->
			throw err if err
			console.log "File destroyed successfully"

		fs.readdir path.join(partials_folder, folder_name), (err, data) ->
			throw err if err
			if !data.length
				fs.rmdir path.join(partials_folder, folder_name), (err) ->
					throw err if err
					console.log "Folder destroyed successfully"

module.exports = DestroyPartial