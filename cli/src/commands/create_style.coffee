Utils = require('../utils')

# Folders
styles_folder = path.join( __dirname, '../../../', "/src/styles")

class CreateStyle
	constructor:() ->
		name = Utils.lowercase(program.args[0])
		file_name = "#{name}.styl"

		fs.exists path.join( styles_folder, file_name), (exists) ->
			if exists
				console.log("File already exists.")
				process.exit(0)

		import_text = "\n@import '#{file_name}'"

		fs.readFile path.join( styles_folder, "/app.styl"), 'utf8', (err, data) =>
			throw err  if err
			data = data.replace '"mixins.styl"', '"mixins.styl"' + import_text
			
			fs.writeFile path.join( styles_folder, "app.styl"),
									 data,
									 'utf8', 
									 (err) ->
				throw err if err
				console.log "File app.styl was successfully updated."	

		fs.writeFile path.join( styles_folder, file_name),'', 'utf8', (err) ->
			throw err if err
			console.log "File created successfully."

module.exports =  CreateStyle