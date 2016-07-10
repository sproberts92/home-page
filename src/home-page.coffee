populateCurrentWeather = (data) ->
	cCond = data['data']['current_condition'][0]
	
	$('#currentImg').attr('src', getWeatherImage(cCond))

	$('#currentTemp'        ).html(cCond['temp_C'] + '/')
	$('#feelsLike'          ).html(cCond['FeelsLikeC'])
	$('#humidity'           ).html(cCond['humidity'] + '/')
	$('#cloudCover'         ).html(cCond['cloudcover'])
	$('#windSpeed'          ).html(cCond['windspeedKmph'] + '/')
	$('#windDirection'      ).html(cCond['winddir16Point'])
	$('#observationTime'    ).html(cCond['observation_time'])

getWeatherImage = (cCond) ->
	wCode = parseInt(cCond['weatherCode'], 10)

	if wCode is 113
		'assets/weather/sun.svg'
	else if wCode is 116
		'assets/weather/cloud-2.svg'
	else if wCode in [143, 122, 119]
		'assets/weather/cloud-1.svg'
	else
		console.log wCode
		cCond['weatherIconUrl'][0]['value']

getDayName = (date) ->
	daysOfTheWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
	d = date.split('-')
	d = new Date(d[0], d[1] - 1, d[2])
	daysOfTheWeek[d.getDay()]

populateForcast = (data, day) ->
	weather = data['data']['weather'][day]
	hourly = data['data']['weather'][day]['hourly'][0]

	$("##{day}currentImg").attr('src', getWeatherImage(hourly))

	dayName = ''
	if day == 0
		dayName = 'Today'
	else
		dayName = getDayName(weather['date'])

	$("##{day}date"         ).html(dayName)
	$("##{day}max"          ).html(weather['maxtempC'] + '/')
	$("##{day}feelsLike"    ).html(hourly['FeelsLikeC'] + '/')
	$("##{day}min"          ).html(weather['mintempC'])
	$("##{day}humidity"     ).html(hourly['humidity'] + '/')
	$("##{day}cloudCover"   ).html(hourly['cloudcover'] + '/')
	$("##{day}uvIndex"      ).html(weather['uvIndex'])
	$("##{day}chanceOfRain" ).html(hourly['chanceofrain'] + '/')
	$("##{day}rain"         ).html(hourly['precipMM'])
	$("##{day}windSpeed"    ).html(hourly['windspeedKmph'] + '/')
	$("##{day}windGust"     ).html(hourly['WindGustKmph'] + '/')
	$("##{day}windDirection").html(hourly['winddir16Point'])

populateStocks = (data) ->
	count = data['query']['count']
	for i in [0..count]
		console.log data['query']['results']['quote'][i]

$(document).ready ->

	requestParams = {key : apiKey, q : loc, format: 'json', num_of_days: 5}

	data = $.getJSON baseWeatherApiUrl, requestParams
		.success (data, resp) ->
			populateCurrentWeather(data)
			populateForcast(data, day) for day in [0..4]

		.fail (data, resp) ->
			console.log data
			console.log resp

	stocksString = stocks.join('","')
	query = 'SELECT * FROM yahoo.finance.quotes where symbol in ("' + stocksString + '")'
	
	requestParams = {q: query, format: 'json', env: 'store://datatables.org/alltableswithkeys'}

	data = $.getJSON baseFinanceApiUrl, requestParams
		.success (data, resp) ->
			populateStocks(data)
			
		.fail (data, resp) ->
			console.log this.url
			console.log data
			console.log resp

