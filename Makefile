BO=node_modules/.bin/bower
GU=node_modules/.bin/gulp
KA=node_modules/karma/bin/karma
PR=node_modules/.bin/protractor

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
	@$(GU) compile --compress

karma:
	@$(KA) start tests/karma.conf.js

# protractor:
# 	@$(PR) tests/protractor-conf.js