populateCurrentWeather = (data) ->
	cCond = data['data']['current_condition'][0]
	
	$('#currentImg').attr('src', cCond['weatherIconUrl'][0]['value'])

	$('#currentTemp'		).html(cCond['temp_C'])
	$('#feelsLike'			).html(cCond['FeelsLikeC'])
	$('#humidity'			).html(cCond['humidity'])
	$('#cloudCover'			).html(cCond['cloudcover'])
	$('#windSpeed'			).html(cCond['windspeedKmph'])
	$('#windDirection'		).html(cCond['winddir16Point'])
	$('#observationTime'	).html(cCond['observation_time'])

populateForcast = (data, day) ->
	weather = data['data']['weather'][day]
	hourly = data['data']['weather'][day]['hourly'][0]

	$("##{day}currentImg").attr('src', hourly['weatherIconUrl'][0]['value'])

	$("##{day}date"			).html(weather['date'])
	$("##{day}max"			).html(weather['maxtempC'])
	$("##{day}min"			).html(weather['mintempC'])
	$("##{day}feelsLike"	).html(hourly['FeelsLikeC'])
	$("##{day}humidity"		).html(hourly['humidity'])
	$("##{day}cloudCover"	).html(hourly['cloudcover'])
	$("##{day}uvIndex"		).html(weather['uvIndex'])
	$("##{day}rain"			).html(hourly['precipMM'])
	$("##{day}chanceOfRain"	).html(hourly['chanceofrain'])
	$("##{day}windSpeed"	).html(hourly['windspeedKmph'])
	$("##{day}windGust"		).html(hourly['WindGustKmph'])
	$("##{day}windDirection").html(hourly['winddir16Point'])

$(document).ready ->

	requestParams = {key : apiKey, q : loc, format: 'json', num_of_days: 5}

	data = $.getJSON baseApiUrl, requestParams
		.success (data, resp) ->
			populateCurrentWeather(data)
			populateForcast(data, day) for day in [0..4]

		.fail (data, resp) ->
			console.log data
			console.log resp

