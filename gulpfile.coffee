gulp       = require 'gulp'
open       = require 'open'
es         = require 'event-stream'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
ngmin      = require 'gulp-ngmin'
clean      = require 'gulp-clean'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
inject     = require 'gulp-inject'
connect    = require 'gulp-connect'
imagemin   = require 'gulp-imagemin'
sourcemaps = require 'gulp-sourcemaps'
bowerFiles = require 'main-bower-files'
rimraf     = require 'rimraf'
addsrc     = require 'gulp-add-src'
classify   = require 'gulp-ng-classify'


paths =
  index:     'src/index.jade'
  fonts:     'src/fonts/**/*'
  images:    'src/images/**/*'
  styles:    'src/styles/app.styl'
  scripts:   'src/scripts/**/*.coffee'
  partials:  'src/partials/**/*.jade'



############################## Development ##############################


# Compile coffee, generate source maps, trigger livereload
gulp.task 'scripts', ['move_bower'], ->
  gulp.src paths.scripts
    .pipe do classify
    .pipe coffee bare: false
    .pipe gulp.dest 'app/scripts'

gulp.task 'move_bower', (cb) ->
  gulp.src './bower_components/**/*'
    .pipe gulp.dest 'app/bower_components'

  cb null

#Compile stylus, trigger livereload
gulp.task 'styles', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe gulp.dest 'app/styles'
    .pipe connect.reload()

#Copy images, trigger livereload
gulp.task 'images', ->
  gulp.src paths.images
    .pipe gulp.dest 'app/images'

# Copy fonts
gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe gulp.dest 'app/fonts'

#Compile Jade, trigger livereload
gulp.task 'partials', ->
  gulp.src paths.partials
    .pipe jade pretty: yes
    .pipe gulp.dest 'app/partials'

#Compile index.jade, inject compiled stylesheets, inject compiled scripts, inject bower packages
gulp.task 'index', ['clean', 'scripts', 'concat_bower', 'styles', 'partials', 'images', 'fonts'], ->
  gulp.src paths.index
    .pipe jade pretty: yes
    .pipe inject(es.merge(
      gulp.src './app/styles/**/*.css', read: no
    ,
      gulp.src './app/scripts/**/*.js', read: no
    ), ignorePath: '/app')
    .pipe gulp.dest 'app/'
    .pipe connect.reload()

gulp.task "concat_bower", ->
  gulp.src bowerFiles()
    .pipe(concat( 'dependencies.js') )
    .pipe gulp.dest "app/scripts"

# Launch server and open app in default browser
gulp.task 'serve', ['compile', 'watch'], ->
  connect.server
    port       : 1337
    root       : 'app'
    livereload : yes
    fallback   : 'app/index.html'

  open 'http://localhost:1337'

# Clean development build folder
gulp.task "clean", (cb) ->
  rimraf.sync "./app"
  cb null

# Register tasks
gulp.task 'watch', ->
  gulp.watch paths.partials , ['index']
  gulp.watch paths.scripts  , ['index']
  gulp.watch paths.styles   , ['styles']
  gulp.watch paths.images   , ['index']
  gulp.watch paths.index    , ['index']


############################## Build ##############################


# Compile coffee, generate source maps, trigger livereload
gulp.task 'scripts:prod', ['move_bower:prod'], ->
  gulp.src paths.scripts
    .pipe do classify
    .pipe do sourcemaps.init
    .pipe coffee bare: false
    .pipe do sourcemaps.write
    .pipe concat 'main.js'
    .pipe gulp.dest 'dist/scripts'

gulp.task 'move_bower:prod', (cb) ->
  gulp.src './bower_components/**/*'
    .pipe gulp.dest 'dist/bower_components'

  cb null

#Compile stylus, trigger livereload
gulp.task 'styles:prod', ->
  gulp.src paths.styles
    .pipe stylus()
    .pipe concat 'styles.css'
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
    .pipe do jade
    .pipe gulp.dest 'dist/partials'

#Compile index.jade, inject compiled stylesheets, inject compiled scripts, inject bower packages
gulp.task 'index:prod', ['clean:prod', 'scripts:prod', 'concat_bower:prod', 'styles:prod', 'partials:prod', 'images:prod', 'fonts:prod'], ->
  gulp.src paths.index
    .pipe do jade
    .pipe inject(es.merge(
      gulp.src './dist/styles/**/*.css', read: no
    ,
      gulp.src './dist/scripts/**/*.js', read: no
    ), ignorePath: ['/dist', '/app'])
    .pipe gulp.dest 'dist/'

gulp.task "concat_bower:prod", ->
  gulp.src bowerFiles()
    .pipe(concat( 'dependencies.js') )
    .pipe gulp.dest "dist/scripts"

# Launch server and open app in default browser
gulp.task 'serve', ['compile', 'watch'], ->
  connect.server
    port       : 1337
    root       : 'app'
    livereload : yes
    fallback   : 'app/index.html'

  open 'http://localhost:1337'

# Clean development build folder
gulp.task "clean:prod", (cb) ->
  rimraf.sync "./dist"
  cb null

gulp.task 'build' , ['scripts:prod', 'styles:prod', 'images:prod', 'partials:prod', 'fonts:prod', 'index:prod']
gulp.task 'compile' , ['scripts', 'styles', 'images', 'partials', 'fonts', 'index']
gulp.task 'default' , ['serve']
