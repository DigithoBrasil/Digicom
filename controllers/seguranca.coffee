Mongoose = require 'mongoose'
Organizador = require '../models/organizador'

module.exports = (app) ->

	SegurancaController =
		logon: (req, res) ->
			res.render 'seguranca/logon'

		autenticar: (req, res) ->
			dados = req.body

			Organizador.findOne login: dados.login, (erro, organizador) ->
				
				organizador.validarSenha dados.senha, (erro, senhaCorreta) ->
					throw erro if erro

					if not senhaCorreta
						res.redirect '/logon'
						return

					req.session.loginOrganizador = organizador.login
					res.redirect '/lancamento/incluir'

		logout: (req, res) ->
			delete req.session.loginOrganizador

			res.redirect '/'