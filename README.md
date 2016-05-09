# destatis_cli
Webservice client for the GENESIS webservice of german "Statistisches Bundesamt" [Destatis](https://www-genesis.destatis.de/genesis/online?Menu=Webservice) currently using [savon](https://github.com/savonrb/savon) "Heavy metal SOAP client".

* Please be aware, that the account for data access is available free of charge but for automated data queries (e.g. via the webservice) you need to pay an annual fee.
* Set some defaults in *examples/conf/webs_custom.yml*, enter your account data into *examples/conf/secrets.yml* and use the module according to the example scripts.
* You can choose between different data formats for the result. *[in progress]*
* Find a reference about the available services, methods and parameters in *conf/webservice.yml*. Service and method must be provided with the *Client.new* statement. The parameters can be set via the custom config file. You can use the short names like e.g. "dl", "diag" for service and method, but also the original terms "DownloadService", "diagramm_download".

# Build gem from source

* git clone https://github.com/stoffels-it/destatis_cli.git
* if you had an older gem version of destatis_cli installed before, check it with gem list --local
* and uninstall it with gem uninstall destatis_cli
* cd destatis_cli
* gem build destatis_cli.gemspec
* gem install destatis_cli-0.1.0.gem (insert current version here)
* start with an example like:
```ruby
require 'destatis_cli'

conf_custom = 'conf/webs_custom.yml'
secrets = 'conf/secrets.yml'

des = DestatisCli::Client.new(conf_custom, secrets)

puts des.get_data('dl', 'tab', '61241-0002', 'GP09Y2')
```
