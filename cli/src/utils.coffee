class Utils
	each: (arr, func, index=0) ->
  	if index < arr.length then [ func(arr[index], index), @each(arr, func, index + 1)... ] else []
 
	camelize: (input) ->
		input = @lowercase(input)
		pieces = input.split(/[\W_-]/)
		@each(pieces, @capitalize).join("")
	 
	capitalize: (input) ->
	  input.charAt(0).toUpperCase() + input.slice(1)
	 
	lowercase: (input) ->
	  input.toLowerCase()
	 
	underscore: (input) ->
	  pieces = input.replace(/([A-Z])/g, '_$1').split(/[\W_-]/).filter (n) -> !!n
	  @each(pieces, @lowercase ).join("_")

	pluralize: (input) ->
		if input.slice(-1) == "y"
			input = @lowercase(input.slice(0, -1) + "ies")
		else
			input = @lowercase(input + "s")
 
module.exports = new Utils