module.exports = (app) ->
	
	LancamentoController =
		index: (req, res) ->
			res.render 'lancamento/index'

		incluir: (req, res) ->
			res.render 'lancamento/incluir'

		salvar: (req, res) ->
			lancamento = req.body.lancamento

			# Salvar

			res.render 'lancamento/index'