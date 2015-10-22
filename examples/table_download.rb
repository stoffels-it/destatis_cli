require 'destatis_cli'

des = DestatisCli::DestatisCli.new('conf/webs_custom.yml', 'conf/secrets.yml')

puts des.get_data('dl', 'tab', '61241-0002', 'GP09Y2')
