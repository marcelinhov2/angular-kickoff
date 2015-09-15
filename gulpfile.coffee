gulp          = require 'gulp'
argv          = require('yargs').argv
cache         = require 'gulp-cached'
gulpif        = require 'gulp-if'
open          = require 'open'
es            = require 'event-stream'
coffee        = require 'gulp-coffee'
less          = require 'gulp-less'
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
rev           = require 'gulp-rev'

paths =
  base:       'src/'
  index:      'src/index.html'
  fonts:      'src/fonts/**/*'
  images:     'src/images/**/*'
  styles:     'src/styles/**/*.less'
  base_style: 'src/styles/base.less'
  scripts:    'src/scripts/**/*.coffee'
  partials:   'src/partials/**/*.html'

folder = if (argv.compress) then 'dist' else 'www'
env = if (argv.compress) then 'production' else 'testing'

gulp.task "clean", (cb) ->
  rimraf.sync "./#{folder}"
  cb null

gulp.task "concat_bower", ->
  gulp.src bowerFiles({
      filter: /\.js$/i,
      paths: {
        bowerDirectory: './bower_components',
      }
    })
    .pipe(concat( 'dependencies.js') )
    .pipe gulpif(argv.compress, uglify())
    .pipe gulpif(argv.compress, rev())
    .pipe gulp.dest "#{folder}/scripts"

gulp.task 'scripts', ->
  gulp.src paths.scripts
    .pipe cache('scripts')
    .pipe preprocess context: NODE_ENV: env
    .pipe do classify
    .pipe coffee bare: false
    .pipe gulpif(argv.compress, uglify())
    .pipe gulpif(argv.compress, concat('app.js'))
    .pipe gulpif(argv.compress, rev())
    .pipe gulp.dest "#{folder}/scripts"

gulp.task 'styles', ->
  gulp.src paths.base_style
    .pipe less()
    .pipe gulpif(argv.compress, rev())
    .pipe gulp.dest "#{folder}/styles"

gulp.task 'styles:reload', ->
  gulp.src paths.base_style
    .pipe less()
    .pipe gulp.dest "#{folder}/styles"
    .pipe connect.reload()

gulp.task 'images', ->
  gulp.src paths.images
    .pipe cache('images')
    .pipe gulpif(argv.compress, imagemin())
    .pipe gulp.dest "#{folder}/images"

gulp.task 'fonts', ->
  gulp.src paths.fonts
    .pipe cache('fonts')
    .pipe gulp.dest "#{folder}/fonts"

gulp.task 'partials', ->
  gulp.src paths.partials
    .pipe templateCache('templates', {standalone:true, root: '/partials/'} )
    .pipe rename(extname: '.js')
    .pipe gulpif(argv.compress, uglify())
    .pipe gulpif(argv.compress, rev())
    .pipe gulp.dest "#{folder}/scripts"

gulp.task 'index', ->
  if(argv.compress)
    scripts = [
      "./#{folder}/scripts/dependencies-*.js"
      "./#{folder}/scripts/templates-*.js"
      "./#{folder}/scripts/app-*.js"
    ]
  else
    scripts = "./#{folder}/scripts/**/*.js"

  gulp.src paths.index
    .pipe inject(es.merge(
      gulp.src "./#{folder}/styles/**/*.css", read: no
    ,
      gulp.src scripts, read: no
    ), ignorePath: "/#{folder}", addRootSlash: false)
    .pipe gulp.dest "#{folder}/"

gulp.task 'server', ->
  connect.server
    port       : 1337
    root       : "#{folder}"
    livereload : yes
    fallback   : "#{folder}/index.html"

  open 'http://localhost:1337'

gulp.task 'up', (cb) ->
  runSequence(
    'clean', 
    'concat_bower', 
    'compile', 
    'watch', 
    'server' 
    cb
  );

gulp.task 'reload', ->
  gulp.src paths.index
    .pipe connect.reload()

# Register tasks
gulp.task 'watch', ->
  gulp.watch paths.partials , ['compile']
  gulp.watch paths.scripts  , ['compile']
  gulp.watch paths.styles   , ['styles:reload']
  gulp.watch paths.images   , ['compile']
  gulp.watch paths.index    , ['compile']

gulp.task 'compile', (cb) ->
  runSequence(
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

gulp.task 'build', (cb) ->
  runSequence(
    'clean',
    'concat_bower', 
    'compile', 
    cb
  );

gulp.task 'default' , ['up']