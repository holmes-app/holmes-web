setup:
	@bundle
	@npm install .
	@bower install

run:
	@grunt serve

unit:
	@grunt test
