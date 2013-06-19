# $Id$

## require
assets  = require 'connect-assets'
express = require 'express'
fs = require 'fs'
# routes = require './routes'
# collage = (require './routes/collage')(__dirname + '/public')
# user = require './routes/user'
http = require 'http'
path = require 'path'

## constants
applicationPath = "#{__dirname}/app"


## build app
app = express()
app.use assets()

# all environments
app.set 'port', process.env.PORT || 3000
app.set 'views', "#{__dirname}/app/views"
app.set 'view engine', 'jade'
app.use express.favicon() 
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser 'your secret here'
app.use express.session()
app.use app.router
#app.use require('stylus').middleware __dirname + '/public'
app.use express.static(path.join __dirname, 'public' )

# development only
if 'development' is app.get 'env'
  app.use express.errorHandler() 

# append controllers.

# set config locals
app.locals.collageRoot = "#{__dirname}/public"

files = fs.readdirSync applicationPath + '/controllers'
files.forEach (file) ->
  filePath = "#{applicationPath}/controllers/#{file}"
  console.log "Loading controller: %s",filePath
  require(filePath)(app)

# app.get('/', routes.index)
# app.get '/collage', collage.index
# app.get '/collage/files', collage.files
# app.get '/users', user.list)

http.createServer(app).listen(app.get('port'), () ->
  console.log "Express server listening on port #{app.get('port')}"
)

