all: css js html
.PHONY: all html js css clean

html:
	@echo "Preparing HTML"
	
js:
	@echo "Preparing JS"
	mkdir -p pub/js

css:
	@echo "Preparing CSS"
	mkdir -p pub/css
	sass dev/scss/:pub/css/

clean:
	echo "Cleaning Pub Folder"
	rm -rf ./pub/
	mkdir -p pub
