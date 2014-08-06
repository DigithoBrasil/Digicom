Mongoose  = require 'mongoose'
Lancamento = require '../models/lancamento'

bcrypt = require 'bcrypt-nodejs'
SALT_WORK_FACTOR = 10

organizadorSchema = new Mongoose.Schema
	nome: type: String, required: true
	login: type: String, required: true
	senha: type: String, required: true

organizadorSchema.pre 'save', (next) ->
	organizador = @

	return next() if not organizador.isModified 'senha'

	bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
		return next err if err

		bcrypt.hash organizador.senha, salt, null, (err, hash) ->
			return next err if err

			organizador.senha = hash
			next()

organizadorSchema.methods.lancar = (data, natureza, finalidade, detalhesDaCompra, valor) ->
	throw new Error 'Data deve ser informada' if not data
	throw new Error 'Natureza deve ser informada' if not natureza
	throw new Error 'Finalidade deve ser informada' if not finalidade
	throw new Error 'Valor deve ser informado' if not valor

	new Lancamento { data: data, natureza: natureza, finalidade: finalidade, detalhesDaCompra: detalhesDaCompra, valor: valor }

# TODO: Reponsabilidade é dele???
organizadorSchema.methods.validarSenha = (senha, cb) ->
	bcrypt.compare senha, @senha, (err, isMatch) ->
		return cb err if err

		cb null, isMatch

module.exports = Mongoose.model 'Organizador', organizadorSchema