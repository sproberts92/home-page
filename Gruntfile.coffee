module.exports = (grunt) ->
	grunt.initConfig({
		concat: {
			files: {
				src: ['src/home-page.coffee']
				dest: 'build/home-page.coffee'
			}
		}

		coffee: {
			compile: {
				options: {
					bare: true
				},
				files :{
					'build/home-page.js': ['build/home-page.coffee']
				}
			}
		}

		uglify: {
			options: {
				mangle: {
					toplevel: true,
					eval: true,
					except: ['start']
				}
			},
			my_target: {
				files: {
					'build/home-page.min.js': ['build/home-page.bundle.js']
				}
			}
		}

		watch: {
			scripts: {
				files: ['src/*.coffee'],
				tasks: ['default']
			}
		}

		clean: ['build/*.js', 'build/*.coffee']
	})

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.registerTask 'default', ['concat', 'coffee', 'uglify']
