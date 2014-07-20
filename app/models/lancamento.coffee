Mongoose = require 'mongoose'

lancamentoSchema = new Mongoose.Schema
	data: type: Date, required: true
	finalidade: type: String, required: true
	detalhesDaCompra: type: String, required: true
	valor: type: Number, required: true

Lancamento = Mongoose.model 'Lancamento', lancamentoSchema

module.exports = Lancamento