all:ScoreEngine_gem

ScoreEngine_gem:
	gem build spec/ScoreEngine.gemspec
	cp ScoreEngine-*.gem ../dist/

install:
	sudo gem install --local dist/ScoreEngine-0.1.gem

uninstall:
	sudo gem uninstall ScoreEngine 

