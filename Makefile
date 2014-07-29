BO=node_modules/.bin/bower
GU=node_modules/.bin/gulp

setup:
	rm -rf .git
	npm install
	@$(BO) install

server:
	@$(GU) server

compile:
	@$(GU) compile

build:
	@$(GU) build