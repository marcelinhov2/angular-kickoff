BO=node_modules/.bin/bower
GU=node_modules/.bin/gulp

setup:
	rm -rf .git
	npm install
	@$(BO) install

serve:
	@$(GU) serve

compile:
	@$(GU) compile

build:
	@$(GU) build