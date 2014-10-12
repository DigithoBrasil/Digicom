Mongoose = require 'mongoose'

lancamentoSchema = new Mongoose.Schema
	data: type: Date, required: true
	natureza: type: String, required: true
	comprovante: type: String
	fornecedor: type: String
	detalhes: type: String
	valor: type: Number, required: true

module.exports = Mongoose.model 'Lancamento', lancamentoSchema