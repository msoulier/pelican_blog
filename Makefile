PELICAN=pelican
PELICANOPTS=

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py
HEROKUDIR=$(HOME)/work/static_blog
FIREFOX=$(shell which firefox)
ifeq ($(FIREFOX),)
	FIREFOX = /Applications/Firefox.app/Contents/MacOS/firefox
endif

help:
	@echo "Firefox is '$(FIREFOX)'"
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   make regenerate                  regenerate files upon modification '
	@echo '   make serve                       serve site at http://localhost:8000'
	@echo '   make devserver                   start/restart develop_server.sh    '
	@echo '   make heroku                      push to production heroku site     '
	@echo '   make view                        view the static site in firefox    '
	@echo '                                                                       '

heroku:
	rsync -vaz --delete --exclude '.git' $(OUTPUTDIR)/ $(HEROKUDIR)

view:
	(cd $(OUTPUTDIR) && $(FIREFOX) index.html)

html: clean $(OUTPUTDIR)/index.html
	mkdir $(OUTPUTDIR)/static
	cp -R images $(OUTPUTDIR)/static
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	find $(OUTPUTDIR) -mindepth 1 -delete
	touch $(OUTPUTDIR)/index.php
	echo 'php_flag engine off' > $(OUTPUTDIR)/.htaccess

regenerate: clean
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
	cd $(OUTPUTDIR) && python -m SimpleHTTPServer

devserver:
	$(BASEDIR)/develop_server.sh restart

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

.PHONY: html help clean regenerate serve devserver publish ssh_upload rsync_upload dropbox_upload ftp_upload github
