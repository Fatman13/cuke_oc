# encoding: utf-8

Given /^我根据(.*)文件中的配置$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  File.open('./data/wgoc_jsonrpc_cases/' + arg1, 'r') { |file|
      @mock_params = YAML.load(file.read)
    }
  # puts @mock_params
  RestClient.get SCAFFOLDING_CREATE_KV_URI, :params => @mock_params['kv'] unless !@mock_params.key?('kv') || @mock_params['kv'].nil?
  RestClient.get SCAFFOLDING_CREATE_OLDKV_URI, :params => @mock_params['oldkv'] unless !@mock_params.key?('oldkv') || @mock_params['oldkv'].nil?
  RestClient.get SCAFFOLDING_CREATE_PRODUCTAPI_QUERYINFO_URI, :params => @mock_params['queryInfo'] unless !@mock_params.key?('queryInfo') || @mock_params['queryInfo'].nil?
end

When /^我根据(.*)用post方法发送jsonrpc请求至oc$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  File.open('./data/wgoc_jsonrpc_cases/' + arg1, 'r') { |file|
    @dg_request_json = JSON.load(file)
    # puts @dg_request_json
  }
  # puts @dg_request_json
  # puts JSONRPC_VANILLA_ORDERINNERAPI_DAIGOUCREATEORDER_URI
  @dg_request_json['daigouOrder']['daigouId'] = @dg_request_json['daigouOrder']['daigouId'] + 1
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_DAIGOUCREATEORDER_URI, @dg_request_json.to_json

  File.open('./data/wgoc_daigou_cases/' + arg1, 'w') { |file|
    # puts @dg_request_json
    JSON.dump(@dg_request_json, file)
  }
end

Then /^我应该得到与(.*)文件中相同的json串$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = JSON.parse(File.read('./data/wgoc_jsonrpc_cases/' + arg1))
  @response_json['result']['success'].should == @expected_json['result']['success']
  @response_json['result']['code'].should == @expected_json['result']['code']
end