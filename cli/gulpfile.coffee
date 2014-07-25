gulp       = require 'gulp'
gutil      = require 'gulp-util'
coffee     = require 'gulp-coffee'

paths =
  scripts: 'src/**/*.coffee'

# Compile coffee, generate source maps, trigger livereload
gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe coffee bare: false
    .pipe gulp.dest 'lib'

# Register tasks
gulp.task 'watch', ->
  gulp.watch paths.scripts  , ['scripts']

gulp.task 'default' , ['watch']
