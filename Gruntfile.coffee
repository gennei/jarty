module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-typescript'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'compile', ['concat:jarty', 'typescript:jarty', 'typescript:test']
  grunt.registerTask 'default', ['compile']
  grunt.registerTask 'release', ['compile', 'uglify']

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    typescript:
      jarty:
        src:  ['compiled/jarty.ts']
        dest: 'compiled/jarty.js'
        options:
          target: 'es3'
          sourcemap: true
          declaration: true
      test:
        src: ['test/**/*.ts']
        dest: 'compiled'
        options:
          target: 'es3'

    concat:
      jarty:
        src: [
          'src/wrap/intro.ts.txt',
          'src/version.ts',
          'src/utils.ts',
          'src/exceptions.ts',
          'src/compiler/interfaces.ts',
          'src/compiler/translator.ts',
          'src/compiler/rules.ts',
          'src/compiler/compiler.ts',
          'src/runtime/interfaces.ts',
          'src/runtime/global.ts',
          'src/runtime/pipes.ts',
          'src/runtime/pipes/core.ts',
          'src/runtime/pipes/escape.ts',
          'src/runtime/functions.ts',
          'src/runtime/functions/core.ts',
          'src/runtime/runtime.ts',
          'src/jarty.ts',
          'src/wrap/outro.ts.txt',
        ]
        dest: 'compiled/jarty.ts'

    uglify:
      dist:
        files:
          'compiled/jarty.min.js': ['compiled/jarty.js']

    clean:
      compiled:
        src: ['compiled']

    watch:
      files: ['src/**/*.ts', 'test/**/*.ts']
      tasks: ['compile']
