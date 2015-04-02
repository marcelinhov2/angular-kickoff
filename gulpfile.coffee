gulp          = require 'gulp'
open          = require 'open'
es            = require 'event-stream'
coffee        = require 'gulp-coffee'
jade          = require 'gulp-jade'
stylus        = require 'gulp-stylus'
concat        = require 'gulp-concat'
uglify        = require 'gulp-uglify'
inject        = require 'gulp-inject'
connect       = require 'gulp-connect'
imagemin      = require 'gulp-imagemin'
bowerFiles    = require 'main-bower-files'
rimraf        = require 'rimraf'
classify      = require 'gulp-ng-classify'
rename        = require "gulp-rename"
templateCache = require 'gulp-angular-templatecache'
runSequence   = require 'run-sequence'
preprocess    = require 'gulp-preprocess'

paths =
  index:    'src/index.jade'
  fonts:    'src/fonts/**/*'
  images:   'src/images/**/*'
  styles:   'src/styles/**/*.styl'
  scripts:  'src/scripts/**/*.coffee'
  partials: 'src/partials/**/*.jade'

############################## Development ##############################

# Clean development build folder
gulp.task "clean", (cb) ->
  rimraf.sync "./www"
  cb null

gulp.task 'move_bower', ->
  gulp.src './bower_components/**/*'
    .pipe gulp.dest 'www/bower_components'

gulp.task "concat_bower", ->
  gulp.src bowerFiles({
      filter: /\.js$/i,
      paths: {
        bowerDirectory: './bower_components',
      }
    })
    .pipe(concat( 'dependencies.js') )
    .pipe gulp.dest "www/scripts"

# Compile coffee, generate source maps, trigger livereload
gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe preprocess context: NODE_ENV: 'testing'
    .pipe do classify
    .pipe coffee bare: false
    .pipe gulp.dest 'www/scripts'

#Compile stylus, trigger livereload
gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'www/styles'

gulp.task 'styles:reload', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'www/styles'
    .pipe connect.reload()

#Copy images, trigger livereload
gulp.task 'images', ->
  gulp.src paths.images
    .pipe gulp.dest 'www/images'

# Copy fonts
gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe gulp.dest 'www/fonts'

#Compile Jade, trigger livereload
gulp.task 'partials', ->
  gulp.src paths.partials
    .pipe jade pretty: yes
    .pipe templateCache('templates', {standalone:true, root: '/partials/'} )
    .pipe rename(extname: '.js')
    .pipe gulp.dest 'www/scripts'

#Compile index.jade, inject compiled stylesheets, inject compiled scripts, inject bower packages
gulp.task 'index', ->
  gulp.src paths.index
    .pipe jade pretty: yes
    .pipe inject(es.merge(
      gulp.src './www/styles/**/*.css', read: no
    ,
      gulp.src './www/scripts/**/*.js', read: no
    ), ignorePath: '/www', addRootSlash: false)
    .pipe gulp.dest 'www/'

gulp.task 'reload', ->
  gulp.src paths.index
    .pipe connect.reload()

# Launch server and open app in default browser
gulp.task 'server', ['compile', 'watch'], ->
  connect.server
    port       : 1337
    root       : 'www'
    livereload : yes
    fallback   : 'www/index.html'

  open 'http://localhost:1337'

# Register tasks
gulp.task 'watch', ->
  gulp.watch paths.partials , ['compile']
  gulp.watch paths.scripts  , ['compile']
  gulp.watch paths.styles   , ['styles:reload']
  gulp.watch paths.images   , ['compile']
  gulp.watch paths.index    , ['compile']

gulp.task 'compile', ['clean'], (cb) ->
  runSequence(
    'move_bower', 
    'concat_bower', 
    [
      'scripts', 
      'styles', 
      'images', 
      'fonts'
    ], 
    'partials',
    'index', 
    'reload', 
    cb
  );


# PRODUCTION

# Clean development build folder
gulp.task "clean:prod", (cb) ->
  rimraf.sync "./dist"
  cb null

gulp.task "concat_bower:prod", ->
  gulp.src bowerFiles({
      filter: /\.js$/i,
      paths: {
        bowerDirectory: './bower_components',
      }
    })
    .pipe concat 'dependencies.js'
    .pipe uglify()
    .pipe gulp.dest "dist/scripts"

# Compile coffee, generate source maps, trigger livereload
gulp.task 'scripts:prod', ->
  gulp.src paths.scripts
    .pipe preprocess context: NODE_ENV: 'production'
    .pipe do classify
    .pipe coffee bare: false
    .pipe uglify()
    .pipe concat 'app.js'
    .pipe gulp.dest 'dist/scripts'

#Compile stylus, trigger livereload
gulp.task 'styles:prod', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'dist/styles'

#Copy images, trigger livereload
gulp.task 'images:prod', ->
  gulp.src paths.images
    .pipe do imagemin
    .pipe gulp.dest 'dist/images'

# Copy fonts
gulp.task 'fonts:prod', ->
  gulp.src paths.fonts
    .pipe gulp.dest 'dist/fonts'

#Compile Jade, trigger livereload
gulp.task 'partials:prod', ->
  gulp.src paths.partials
    .pipe jade pretty: yes
    .pipe templateCache('templates', {standalone:true, root: '/partials/'} )
    .pipe rename(extname: '.js')
    .pipe uglify()
    .pipe gulp.dest 'dist/scripts'

#Compile index.jade, inject compiled stylesheets, inject compiled scripts, inject bower packages
gulp.task 'index:prod', ->
  gulp.src paths.index
    .pipe inject(es.merge(
      gulp.src './dist/styles/**/*.css', read: no
    ,
      gulp.src [
        './dist/scripts/dependencies.js'
        './dist/scripts/templates.js'
        './dist/scripts/app.js'
      ], read: no
    ), ignorePath: '/dist', addRootSlash: false)
    .pipe gulp.dest 'dist/'

gulp.task 'compile:prod', ['clean:prod'], (cb) ->
  runSequence(
    'concat_bower:prod', 
    [
      'scripts:prod', 
      'styles:prod', 
      'images:prod', 
      'fonts:prod'
    ], 
    'partials:prod',
    'index:prod'
    cb
  );

gulp.task 'default' , ['server']
gulp.task 'build' , ['compile:prod']