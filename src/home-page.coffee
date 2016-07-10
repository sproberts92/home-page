$(document).ready ->

	requestParams = {key : apiKey, q : loc, format: 'json', num_of_days: 5}

	data = $.getJSON baseApiUrl, requestParams
		.success (data, resp) ->
			console.log resp
			console.log data
		.fail (data, resp) ->
			console.log data
			console.log resp

