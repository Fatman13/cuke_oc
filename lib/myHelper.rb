module MyHelper
  # 制造mock商品，封装了一下。
  def create_mock_product(conf_path)
    File.open(conf_path, 'r') { |file|
      @mock_params = YAML.load(file.read)
      # puts @mock_params
    }

    RestClient.get SCAFFOLDING_CREATE_KV_URI, :params => @mock_params['kv'] unless !@mock_params.key?('kv') || @mock_params['kv'].nil?
    RestClient.get SCAFFOLDING_CREATE_OLDKV_URI, :params => @mock_params['oldkv'] unless !@mock_params.key?('oldkv') || @mock_params['oldkv'].nil?
    RestClient.get SCAFFOLDING_CREATE_PRODUCTAPI_QUERYINFO_URI, :params => @mock_params['queryInfo'] unless !@mock_params.key?('queryInfo') || @mock_params['queryInfo'].nil?
  
    @mock_params  
  end

  def send_request_to(conf_path, url)
    File.open(conf_path, 'r') { |file|
      @request_params = YAML.load(file.read)
      # puts @request_params
    }
    @last_response = RestClient.get url, :params => @request_params
  end

  def bidu_get(url, options={})
    # puts options[:yaml].nil?
    # puts 'yaml: ' + options[:yaml]
    File.open(options[:yaml], 'r') { |file|
      @request_params = YAML.load(file.read)
      # puts @request_params
    }
    @last_response = RestClient.get url, :params => @request_params
  end

  # force ignore unicode characters
  # http://stackoverflow.com/questions/13003287/encodingundefinedconversionerror
  def parse_json(path)
    JSON.parse((File.read(path)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  end
end