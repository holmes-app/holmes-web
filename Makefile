VERSION=`grep '"version"' package.json | cut -d'"' -f4`
PKG="holmes-web-$(VERSION)"

setup:
	@bundle
	@npm install .
	@bower install

run:
	@grunt serve

unit:
	@grunt test

release:
	@mkdir -p releases
	@rm -rf $(PKG)
	@grunt build
	@mv dist $(PKG)
	@tar cvjf releases/$(PKG).tar.bz2 $(PKG)
	@tar cvzf releases/$(PKG).tar.gz $(PKG)
	@zip -r releases/$(PKG).zip $(PKG)
	@rm -rf $(PKG)
