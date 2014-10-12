exports.verificar = (req, res, next) ->
	if not req.session.loginOrganizador
		res.redirect '/logon'
	else
		next()