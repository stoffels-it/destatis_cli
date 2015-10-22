require 'savon'
require 'yaml'
require 'fixnum'

module DestatisCli
  class Client

    public
    # read custom config files specific for for class instance
    def initialize(filename_conf_cust, filename_conf_secrets)
      gem_root = File.expand_path("../..", __FILE__)
      # genereal class config file
      @@filename_conf = gem_root + '/conf/webservice.yml'
      # load config
      @ext_conf = YAML.load_file(@@filename_conf)
      @ext_conf_cust = YAML.load_file(filename_conf_cust)
      @ext_conf_secrets = YAML.load_file(filename_conf_secrets)
      @client = nil
      # validate and create local config files
      validate_config()
    end

    def get_data(service, method, sel_name, feature = '')
      @service_name = ''
      @method_name = ''
      # check and translate the service and method name if required
      if valid_request_method?(service, method)
        puts 'requesting with service_name: ' + @service_name + ' and method_name: ' + @method_name
        connect(@service_name)
        request(@method_name, sel_name, feature)
      end
    end

    def client
      @client
    end

    private
    def connect(service)
      url = @ext_conf['url'] + '/' + service + '?wsdl'
      begin
        @client = Savon.client(wsdl: url)
      rescue
        abort 'Could not connect to url: ' + url
      end
    end

    def request(method, sel_name, feature)
      if feature != ''
        @ext_conf_cust['feature'] = feature
      end
      params = {}
      @ext_conf['services'][@service_sh]['methods'][@method_sh]['params'].each do |value, key|
        params[key.to_sym] = @ext_conf_cust[value].to_s || ''
      end
      defaults = {
        :kennung => @ext_conf_secrets['user'],
        :passwort => @ext_conf_secrets['pass'],
        :name => sel_name,
        :bereich => @ext_conf_cust['area'],
      }
      locals = { :message => defaults.merge(params) }
      begin
        response = self.client.call(method.to_sym, locals)
      rescue
        abort 'could not request the data for method: ' + method
      end
      response.xml.force_encoding('UTF-8')
    end

    def valid_request_method?(service, method)
      valid = false
      @ext_conf['services'].each do |service_short, service_value|
        # find or assign service name
        if (service == service_short || service == service_value['realname'])
          @service_sh = service_short
          @service_name = service_value['realname']
          # find or assign method name
          service_value['methods'].each do |method_short, method_value|
            if (method == method_short || method == method_value['realname'])
              @method_sh = method_short
              @method_name = method_value['realname']
              valid = true
            end
          end
        end
      end
      valid
    end

    def valid_year?(year)
      if year.class == Fixnum
        if year.num_digits == 4
          valid = true unless year > Time.now.year || year < 1900
        end
      end
      valid
    end

    def validate_config()
      # get the start and end year and check for validity
      if !valid_year?(@ext_conf_cust['start'])
        @ext_conf_cust['start'] = Time.now.year
      end
      if !valid_year?(@ext_conf_cust['end']) || @ext_conf_cust['end'] < @ext_conf_cust['start']
        @ext_conf_cust['end'] = Time.now.year
      end
    end
  end
end
