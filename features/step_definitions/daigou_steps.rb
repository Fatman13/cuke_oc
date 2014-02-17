# encoding: utf-8

Given /^我根据"(.*?)"制造mock商品$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  File.open(arg1, 'r') { |file|
      @mock_params = YAML.load(file.read)
      # puts @mock_params
    }
  # RestClient.get SCAFFOLDING_CREATE_PRODUCTAPI_QUERYINFO_URI, :params => {:product_id => 656525250}
  @mprpc_response = RestClient.get SCAFFOLDING_CREATE_KV_URI, :params => @mock_params
end

When /^我根据"(.*?)"发送代购jsonrpc请求至oc$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  File.open(arg1, 'r') { |file|
    @dg_request_json = JSON.load(file)
    # puts @dg_request_json
  }
  # puts @dg_request_json

  @dg_request_json['daigouOrder']['daigouId'] = @dg_request_json['daigouOrder']['daigouId'] + 1
  @response = RestClient.post JSONRPC_SEND_ORDERINNERAPI_DAIGOUCREATEORDER_URI, @dg_request_json.to_json
  
  File.open(arg1, 'w') { |file|
    JSON.dump(@dg_request_json, file)
  }

  # puts @response
end

Then /^我应该得到跟"(.*?)"相同的json串壹$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # puts JSON.parse(File.read(arg1))
  # puts JSON.parse(@response.body)
  JSON.parse(@response.body).should == JSON.parse(File.read(arg1))
end