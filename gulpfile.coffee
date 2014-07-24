gulp = require 'gulp'
gutil = require 'gulp-util'
watch = require 'gulp-watch'
mocha = require 'gulp-mocha'
nodemon = require 'gulp-nodemon'

_pastaDeTestes = 'test/**/*.coffee'
_pastaDeModels = 'app/models/**/*.coffee'

gulp.task 'mocha-watch', ->
	gulp.watch [_pastaDeTestes, _pastaDeModels], ['mocha']

gulp.task 'mocha', ->
	gulp.src [_pastaDeTestes, _pastaDeModels], read: false
		.pipe mocha reporter: 'nyan'
		.on 'error', (error) ->
			console.log error.stack if !/tests? failed/.test(error.stack)

gulp.task 'nodemon', ->
	nodemon script: 'app/server.js'

gulp.task 'test', ['mocha-watch']
gulp.task 'default', ['nodemon']