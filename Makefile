BO=node_modules/.bin/bower
GU=node_modules/.bin/gulp
KA=node_modules/karma/bin/karma

setup:
	npm install
	@$(BO) install

remove_remote:
	rm -rf .git

server:
	@$(GU) up

compile:
	@$(GU) compile

build:
	@$(GU) build --compress

karma:
	@$(KA) start tests/karma-tests/karma.conf.js

protractor:
	@$(GU) e2e_tests