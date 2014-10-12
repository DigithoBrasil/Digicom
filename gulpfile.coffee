gulp = require 'gulp'
gutil = require 'gulp-util'
taskListing = require 'gulp-task-listing'
watch = require 'gulp-watch'
mocha = require 'gulp-mocha'
nodemon = require 'gulp-nodemon'
sass = require 'gulp-sass'

_pastaDeTestes = 'test/**/*.coffee'
_pastaDeModels = 'models/**/*.coffee'
_pastaDoSass = './public/sass/**/*.scss'

gulp.task 'help', taskListing

gulp.task 'mocha-watch', ->
	gulp.watch [_pastaDeTestes, _pastaDeModels], ['mocha']

gulp.task 'mocha', ->
	gulp.src [_pastaDeTestes, _pastaDeModels], read: false
		.pipe mocha reporter: 'nyan'
		.on 'error', (error) ->
			console.log error.stack if !/tests? failed/.test(error.stack)

gulp.task 'sass-watch', ->
	gulp.watch _pastaDoSass, ['sass']

gulp.task 'sass', ->
	gulp.src _pastaDoSass
		.pipe sass()
		.pipe gulp.dest './public/css'

gulp.task 'nodemon', ->
	nodemon
		script: 'server.js'
		ext: '*.coffee'

gulp.task 'test', ['mocha-watch']
gulp.task 'css', ['sass-watch']
gulp.task 'watch', ['mocha-watch', 'sass-watch']
gulp.task 'default', ['nodemon']