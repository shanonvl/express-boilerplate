module.exports = (app) ->

	index = (req,res) ->
		res.render 'index'

	app.get '/', index