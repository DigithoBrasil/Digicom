module.exports = (app) ->

	HomeController =
		login: (req, res) ->
			res.render 'seguranca/logon', message: req.flash 'loginMessage'

		logon: (req, res) ->
			passport = app.passport
			passport.authenticate 'local-login', { successRedirect: '/profile', failureRedirect: '/login', failureFlash: true }

		logout: (req, res) ->
			req.logout()
			res.redirect '/'