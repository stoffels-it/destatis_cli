# destatis_cli
Webservice client for the GENESIS webservice of german "Statistisches Bundesamt" [Destatis](https://www-genesis.destatis.de/genesis/online?Menu=Webservice) currently using [savon](https://github.com/savonrb/savon) "Heavy metal SOAP client".

* Please be aware, that the account for data access is available free of charge but for automated data queries (e.g. via the webservice) you need to pay an annual fee.
* Set some defaults in *examples/conf/webs_custom.yml*, enter your account data into *examples/conf/secrets.yml* and use the module according to the example scripts.
* You can choose between different data formats for the result. *[in progress]*
* Find a reference about the available services, methods and parameters in *conf/webservice.yml*. Service and method must be provided with the *Client.new* statement. The parameters can be set via the custom config file. You can use the short names like e.g. "dl", "diag" for service and method, but also the original terms "DownloadService", "diagramm_download".
* requirements: ruby >= 2.2.2

## Build gem from source

* download the repo: `git clone https://github.com/stoffels-it/destatis_cli.git`
* `cd destatis_cli`
* `gem build destatis_cli.gemspec`
* become root in your system
* if you want to uninstall an older gem version of destatis_cli, check it with `gem list --local`
* and uninstall it with `gem uninstall destatis_cli`
* you will need ruby header files, so install e.g. in Debian: `apt-get install ruby-dev`
* install destatis_cli: `gem install destatis_cli-0.1.0.gem` (insert current version here)
* logout from root account
* create a conf directory in your code directory and copy `examples/conf/*` to it
* rename `conf/secrets_sample.yml` to `conf/secrets.yml` and insert your credentials there, adapt `conf/webs_custom.yml` if required
* start with an example like:
```ruby
#!/usr/bin/ruby

# optionally choose version
gem 'destatis_cli', '=0.1.0'
require 'destatis_cli'

conf_custom = 'conf/webs_custom.yml'
secrets = 'conf/secrets.yml'

des = DestatisCli::Client.new(conf_custom, secrets)

puts des.get_data('dl', 'tab', '61241-0002', 'GP09Y2')
```
