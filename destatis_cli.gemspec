Gem::Specification.new do |s|
  s.name           = 'destatis_cli'
  s.version        = '0.1.0'
  s.date           = '2015-10-13'
  s.summary        = 'Client for DESTATIS GENESIS-Webservice'
  s.description    = 'Client for GENESIS-Webservice of the german DESTATIS (Statistisches Bundesamt) data pool.'
  s.authors        = ['Sarah Stoffels']
  s.email          = 'rubygems@stoffels.it'
  s.files          = ['lib/destatis_cli.rb', 'lib/fixnum.rb', 'conf/webservice.yml']
  s.homepage       = 'http://rubygems.org/gems/destatis_client'
  s.license        = 'GPLv3'
  s.add_runtime_dependency 'savon', '>= 2.11.1'
end
