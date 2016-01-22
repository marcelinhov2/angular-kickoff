#Angular Kickoff
AngularJS application boilerplate for Ng-Classify lovers

__inspirated from:__ [angular-hipster-seed](https://github.com/t3chnoboy/angular-hipster-seed)

##Dependecies
To use this structure, you will need [NodeJS](https://www.google.com.br/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=installing%20nodejs) and [NPM](https://www.google.com.br/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=installing+npm) installed.

##Features
* Auto create/delete of src files inside www folder;
* Ng-Classify for better AngularJs Declarations;
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
This command compiles project and generates source maps. Output goes to ```sh www/``` folder
```
make compile
```

###Building the App for Production
This command compiles project and optimizes it for production. Output goes to ```sh dist/``` folder
```
make build
```
##Karma tests

### Running tests
With the server running, you can execute ```make karma``` to run your tests. It will instance a new server at port 9876 and you will be able to write your tests with LiveReload.

##Directory layout

### Source

```sh
angular-kickoff
└── src
    ├── index.html           # app layout file (the main jade template file of the app)
    ├── images               # image files
    ├── partials             # angular view partials
    │   ├── directives       # partial directives
    │   └── views            # partial views
    ├── scripts              # coffeescripts ( You can choose your folder structure )
    │   ├── main.coffee      # Main File
    └── styles               # stylus stylesheets ( You can choose your folder structure )
        └── base.less        # this file, import all the others files that you create
```

### Development build

```sh
angular-kickoff
 www                      # development build
  ├── index.html          # compiled app layout
  ├── fonts
  ├── images
  ├── scripts             # compiled scripts in the same folder/file structure of ```src``` folder
  │   ├── app.js
  │   ├── templates.js
  │   └── dependencies.js # bower_components compiled files
  └── styles              # compiled stylesheets
      └── base.css
```

###Production build

```sh
angular-kickoff
 dist                     # production build
  ├── index.html          
  ├── fonts
  ├── images
  ├── scripts             
  │   ├── app-{revision}.js
  │   ├── templates-{revision}.js
  │   └── dependencies-{revision}.js # bower_components compiled files
  └── styles              # compiled stylesheets
      └── base-{revision}.css
```