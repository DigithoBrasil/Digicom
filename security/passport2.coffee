LocaStrategy = require('passport-local').Strategy
Organizador = require '../models/organizador'

module.exports = (passport) ->

	passport.serializeUser (user, done) ->
		console.log '##### serializeUser'

		done null, user.id

	passport.deserializeUser (id, done) ->
		console.log '##### deserializeUser'
		teste = email: 1

		done null, teste

		###Organizador.findById id, (err, user) ->
			done err, user###

	passport.use 'local-login', new LocalStrategy({usernameField: 'email', passwordField: 'password', passReqToCallback: true}), (req, email, password, done) ->
		console.log '##### .use'

		teste = email: 1
		done null, teste

	    ###Organizador.findOne { 'login' :  email }, (err, user) ->
	    	return done err if err
	        return done null, false, req.flash('loginMessage', 'No user found.') if not !user
	        return done null, false, req.flash('loginMessage', 'Oops! Wrong password.') if not !user.validPassword password

	        done null, user###