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

		data = "\n@import '#{file_name}'"
		fs.appendFile path.join( styles_folder, "/app.styl"), data, (err) =>
			throw err  if err

		fs.writeFile path.join( styles_folder, file_name),'', 'utf8', (err) ->
			throw err if err
			console.log "File created succesfully."

module.exports =  CreateStyle