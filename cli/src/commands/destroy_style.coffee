Utils = require('../utils')

# Folders
styles_folder = path.join( __dirname, '../../../', "/src/styles")

class DestroyStyle
	constructor:() ->
		name = Utils.lowercase(program.args[0])
		file_name = "#{name}.styl"

		fs.exists path.join( styles_folder, file_name), (exists) ->
			if !exists
				console.log("File not found.")
				process.exit(0)


		fs.readFile path.join( styles_folder, "/app.styl"), 'utf8', (err, data) =>
			throw err  if err
			data = data.replace "@import '#{file_name}'", ''
			
			fs.writeFile path.join( styles_folder, "app.styl"),
									 data,
									 'utf8', 
									 (err) ->
				throw err if err
				console.log "File created successfully."	

		fs.unlink path.join( styles_folder, file_name), (err) ->
			throw err if err
			console.log "File destroyed successfully"

module.exports = DestroyStyle