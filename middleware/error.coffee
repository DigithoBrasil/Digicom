exports.notFound = (req, res, next) ->
	res.status 404
	res.render '404'

exports.serverError = (error, req, res, next) ->
	res.status 500
	res.render 'error', error: error