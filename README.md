#Angular Kickoff Seed
AngularJS application boilerplate for Ng-Classify lovers

__based on:__ [ng-classify](https://github.com/CaryLandholt/ng-classify)

__inspirated in:__ [angular-hipster-seed](https://github.com/t3chnoboy/angular-hipster-seed)


##Features
* CLI to generate and destroy modules, styles and partials ( Contribution of: [viniciuszago](https://github.com/viniciuszago) );
* Auto create/delete of src files inside app folder;
* Jade instead of html;
* Coffee-Script instead of JS;
* Ng-Classify for better AngularJs Declarations;
* Stylus instead of css;
* Automatic compilation;
* Livereload without any plugins;
* Production build with optimizations;
* Automatic bower components injection;
* Automatic scripts and stylesheets injection.

##Installation

Clone repo using git
```sh
git clone https://github.com/marcelinhov2/angular-kickoff.git
cd angular-kickoff
```
Erase remote
```sh
make remove_remote
```
Install dependencies
```sh
make setup
```

##Usage

###CLI
Example of how to use the Command Line Interface of the seed:

__Options:__
```sh
angular-kickoff -h, --help                       # Output usage information
angular-kickoff -V, --version                    # Output the version number
angular-kickoff -g, --generate <option> [value]  # Generate files
angular-kickoff -d, --destroy <option> [value]   # Generate files
```

__Ng-Classify Modules Available (module_name):__ 

* ```animation```  https://github.com/CaryLandholt/ng-classify#animation
* ```config```     https://github.com/CaryLandholt/ng-classify#config
* ```constant```   https://github.com/CaryLandholt/ng-classify#constant
* ```controller``` https://github.com/CaryLandholt/ng-classify#controller 
* ```directive```  https://github.com/CaryLandholt/ng-classify#directive
* ```factory```    https://github.com/CaryLandholt/ng-classify#factory
* ```filter```     https://github.com/CaryLandholt/ng-classify#filter
* ```provider```   https://github.com/CaryLandholt/ng-classify#provider
* ```run```        https://github.com/CaryLandholt/ng-classify#run
* ```service```    https://github.com/CaryLandholt/ng-classify#service
* ```value```      https://github.com/CaryLandholt/ng-classify#value

__Examples:__ 
```sh
angular-kickoff -g module module_name/class_name   # create modules
angular-kickoff -g partial folder_name/name        # create partials
angular-kickoff -g style name                      # create styles
angular-kickoff -d module module_name/class_name   # destroy modules
angular-kickoff -d partial folder_name/name        # destroy partials
angular-kickoff -d style name                      # destroy styles
```

###Clean remote
This command automatically erase the .git folder.
```sh
make remove_remote
```

###Running the App during Development
This command automatically compiles coffee, jade and stylus, injects bower components, generates source maps, starts livereload server and opens your app in the browser.
```sh
make server
```

###Compiling app for development
This command compiles project and generates source maps. Output goes to ```sh app/``` folder
```
make compile
```

###Building the App for Production
This command compiles project and optimizes it for production. Output goes to ```sh dist/``` folder
```
make build
```

##Directory layout

### Source

```sh
angular-kickoff
└── src
    ├── images               # image files
    ├── index.jade           # app layout file (the main jade template file of the app)
    ├── partials             # angular view partials (partial jade templates)
    │   ├── directives       # partial directives
    │   └── views            # partial views
    ├── scripts              # coffeescripts
    │   ├── main.coffee      # application
    │   ├── controllers      # application controllers
    │   ├── directives       # application directives
    │   ├── factories        # application factories
    │   ├── filters          # application filters
    │   └── services         # application services
    └── styles               # stylus stylesheets
        ├── animation.styl   # animation classes ( http://daneden.github.io/animate.css/ )
        ├── app.styl         # this file, import all the others files that you create
        ├── colors.styl      # here goes your colors vars
        ├── fonts.styl       # here goes your font-face declaration
        ├── mixins.styl      # here goes your mixins
        ├── reset.styl       # here goes your reset styles ( http://meyerweb.com/eric/tools/css/reset/ )
        └── transitions.styl # here goes your ng-view transitions ( https://github.com/mgechev/angular-transitions )
```

### Development build

```sh
angular-kickoff
 app                      # development build
  ├── bower_components
  ├── fonts
  ├── images
  ├── index.html          # compiled app layout
  ├── partials            # compiled partials
  │   ├── directives
  │   └── views
  ├── scripts             # compiled scripts with source maps
  │   ├── main.js
  │   ├── dependencies.js # bower_components compiled files
  │   ├── controllers
  │   ├── directives
  │   ├── factories
  │   ├── filters
  │   └── services
  └── styles               # compiled stylesheets
      └── app.css
```

###Production build

```sh
 dist                     # production build
  ├── bower_components
  ├── fonts
  ├── images               # optimized images
  ├── index.html           # minified app layout
  ├── partials             # minified partials
  │   ├── directives
  │   └── views
  ├── scripts
  │   ├── dependencies.js  # minified and concatenated bower_components
  │   └── main.js          # minified and concatenated javascripts
  └── styles
      └── style.css        # minified and concatenated styles
```

##TODO's
* Prerender.io
* Tests