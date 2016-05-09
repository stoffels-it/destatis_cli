#!/usr/bin/ruby

# optionally choose version
gem 'destatis_cli', '=0.1.0'
require 'destatis_cli'

conf_custom = 'conf/webs_custom.yml'
secrets = 'conf/secrets.yml'

des = DestatisCli::Client.new(conf_custom, secrets)

puts des.get_data('dl', 'tab', '61241-0002', 'GP09Y2')
