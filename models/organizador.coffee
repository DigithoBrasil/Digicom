Mongoose  = require 'mongoose'
Natureza = require '../models/natureza'
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

# TODO: Reponsabilidade é dele???
organizadorSchema.methods.validarSenha = (senha, cb) ->
	bcrypt.compare senha, @senha, (err, isMatch) ->
		return cb err if err

		cb null, isMatch

organizadorSchema.methods.lancarCredito = (data, detalhes, valor) ->
	throw new Error 'Data deve ser informada' if not data
	throw new Error 'Detalhes devem ser informados' if not detalhes
	throw new Error 'Valor deve ser informado' if not valor

	new Lancamento
		data: data
		natureza: Natureza.credito
		detalhes: detalhes
		valor: valor

organizadorSchema.methods.lancarDebito = (data, comprovante, fornecedor, detalhes, valor) ->
	throw new Error 'Data deve ser informada' if not data
	throw new Error 'Comprovante deve ser informado' if not comprovante
	throw new Error 'Fornecedor deve ser informado' if not fornecedor
	throw new Error 'Valor deve ser informado' if not valor

	new Lancamento
		data: data
		natureza: Natureza.debito
		comprovante: comprovante
		fornecedor: fornecedor
		detalhes: detalhes
		valor: valor

module.exports = Mongoose.model 'Organizador', organizadorSchema