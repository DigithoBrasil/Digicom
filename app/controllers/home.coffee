module.exports = (app) ->

	HomeController =
		index: (req, res) ->
			res.render 'home/index'