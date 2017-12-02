Gem::Specification.new do |s|
  s.name        = 'ScoreEngine'
  s.version     = '0.1'
  s.date        = '2015-12-01'
  s.summary     = "Cyber Patriots Simple Scoring Engine for Fedora Image"
  s.description = "Cyber Patriots Simple Scoring Engine for Fedora Image"
  s.authors     = ["Lester Claudio"]
  s.email       = 'lester@redhat.com'
  s.files       = ["lib/score_lib.rb", "lib/message_plugin.rb", "lib/plugin.rb", "plugins/become-user.rb", "plugins/login-defs-check.rb", "plugins/selinux.rb", "plugins/sudoers.rb", "plugins/firewalld.rb", "plugins/php-backdoor.rb", "plugins/ssh-protocol.rb", "conf/score-engine.conf", "score_engine.rb"]
  s.homepage    =
    'https://github.com/claudiol/cyber-patriots'
  s.license       = 'GPL'
end
