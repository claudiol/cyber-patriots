all:ScoreEngine_gem

ScoreEngine_gem:
	gem build spec/ScoreEngine.gemspec
	mv ScoreEngine-*.gem ../roles/cpatriot-fedora-setup/files/

install:
	sudo gem install --local ../roles/roles/cpatriot-fedora-setup/files/ScoreEngine-0.1.gem

uninstall:
	sudo gem uninstall ScoreEngine 

