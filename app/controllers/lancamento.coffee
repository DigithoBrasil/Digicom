module.exports = (app) ->
	
	LancamentoController =
		index: (req, res) ->
			res.render 'lancamento/index'

		criar: (req, res) ->
			res.render 'lancamento/index'