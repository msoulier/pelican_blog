PELICAN=pelican
PELICANOPTS=

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py
HEROKUDIR=$(HOME)/work/static_blog

help:
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
	@echo '   make installthemes               install the local themes to the virtualenv for use '
	@echo '                                                                       '

heroku:
	rsync -vaz --delete --exclude '.git' $(OUTPUTDIR)/ $(HEROKUDIR)

installthemes:
	rm -rf $(HOME)/envs/pelican/lib/python2.6/site-packages/pelican/themes/butidigress
	cp -R themes/butidigress $(HOME)/envs/pelican/lib/python2.6/site-packages/pelican/themes

view:
	(cd $(OUTPUTDIR) && firefox index.html)

html: clean installthemes $(OUTPUTDIR)/index.html
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
