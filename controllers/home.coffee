module.exports = (app) ->

	HomeController =
		login: (req, res) ->
			res.render 'seguranca/logon'

		logon: (req, res) ->
			passport = app.passport
			#passport.authenticate 'local-login', { successRedirect: '/profile', failureRedirect: '/login', failureFlash: true }
			passport.authenticate 'local', { successRedirect: '/', failureRedirect: '/login' }

		logout: (req, res) ->
			req.logout()
			res.redirect '/'