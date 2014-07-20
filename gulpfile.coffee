gulp = require 'gulp'
gutil = require 'gulp-util'
watch = require 'gulp-watch'
mocha = require 'gulp-mocha'

# Rodar coffe em console
# mocha test/unit/models/pessoaTeste.coffee --compilers coffee:coffee-script/register

gulp.task 'mocha-watch', ->
	pastaTestes = 'test/**/*.coffee'
	pastaModels = 'app/models/**/*.coffee'
	
	# ** procura em sub-folders
	gulp.src [pastaTestes, pastaModels], read: false
		.pipe watch emit: 'all', (files) ->
			files
				.pipe mocha reporter: 'nyan'
				.on 'error', (error) ->
                    console.log error.stack if !/tests? failed/.test(error.stack)

gulp.task 'default', ['mocha-watch']