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

ensure_directories:
	@mkdir -p ./app/i18n/{locale,sources}

ensure_crowdin_conf:
	@if [ ! -f ./crowdin.yaml ] ; then echo "\nWARNING:\n\nYou do not have a crowdin.yaml file.\\nThis configuration file is required in order to work with holmes translations.\\nThere's a sample file called crowdin.yaml.sample you can use to create your own version.\n\n" && exit 1; fi

extract_translations: ensure_directories
	@grunt extract_translations

upload_translations: ensure_crowdin_conf extract_translations
	@crowdin-cli upload sources

fix_translations:
	@echo
	@echo "Fixing language files..."
	@echo
	@for f in `ls app/i18n/locale`; do grep "Language" app/i18n/locale/$$f/web.po; if [ $$? -ne 0 ] ; then echo 'msgid ""' >/tmp/$$f.po && echo 'msgstr ""' >> /tmp/$$f.po && echo "\"Language: $$f" >> /tmp/$$f.po && echo "\"" >> /tmp/$$f.po && tail -n +3 "app/i18n/locale/$$f/web.po" >> /tmp/$$f.po; cp /tmp/$$f.po ./app/i18n/locale/$$f/web.po; fi; done
	@echo
	@echo "If you can read 'Language: <language code>' that means there's nothing to fix in that language file."
	@echo

compile_translations:
	@grunt compile_translations

download_translations: ensure_crowdin_conf ensure_directories
	@crowdin-cli download
	@$(MAKE) fix_translations
	@$(MAKE) compile_translations
