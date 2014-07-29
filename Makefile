BO=node_modules/.bin/bower
GU=node_modules/.bin/gulp

setup:
	npm install
	@$(BO) install

remove_remote:
	rm -rf .git

server:
	@$(GU) server

compile:
	@$(GU) compile

build:
	@$(GU) build