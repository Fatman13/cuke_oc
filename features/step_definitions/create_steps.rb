# encoding: utf-8

Given /^我根据(.*)文件中的配置建立运费模板信息$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
end

Given /^我根据(.*)文件中的配置在测试桩上制造mock商品$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # File.open('./data/wgoc_create_cases/' + arg1, 'r') { |file|
  #     @mock_params = YAML.load(file.read)
  #     # puts @mock_params
  #   }

  # RestClient.get SCAFFOLDING_CREATE_KV_URI, :params => @mock_params['kv'] unless !@mock_params.key?('kv') || @mock_params['kv'].nil?
  # RestClient.get SCAFFOLDING_CREATE_OLDKV_URI, :params => @mock_params['oldkv'] unless !@mock_params.key?('oldkv') || @mock_params['oldkv'].nil?
  # RestClient.get SCAFFOLDING_CREATE_PRODUCTAPI_QUERYINFO_URI, :params => @mock_params['queryInfo'] unless !@mock_params.key?('queryInfo') || @mock_params['queryInfo'].nil?
  @mock_params = create_mock_product('./data/wgoc_create_cases/' + arg1)
end

When /^我根据(.*)文件中的配置用post方法发送该请求至oc的话$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # File.open('./data/wgoc_create_cases/' + arg1, 'r') { |file|
  #     @request_params = YAML.load(file.read)
  #     # puts @request_params
  #   }
  # @last_response = RestClient.get CREATE_REQUEST_URI, :params => @request_params
  # puts @last_response
  # puts @last_response.body
  @last_response = send_request_to('./data/wgoc_create_cases/' + arg1, CREATE_REQUEST_URI)
  puts @last_response
end

Then /^我应该得到与(.*)文件中差不多的json串$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@last_response.body)
  @expected_json = JSON.parse((File.read('./data/wgoc_create_cases/' + arg1)).to_s.encode('utf-8', {:invalid => :replace, :undef => :replace, :replace => '?'}))

  # @response_json['result'].should_not be_nil
  # return if @response_json['result'].nil?
  if @response_json['success'] == 'true'
    puts 'OrderId: ' + @response_json['result']['orderId'].to_s
    puts 'PayStyle: ' + @response_json['result']['payStyle'].to_s
    puts 'Price: ' + @response_json['result']['price'].to_s
    # puts @mock_params['queryInfo']['price'].to_f * @request_params['data']['items'][0]['count'].to_i + 10.0
    @response_json['result']['payStyle'].should eq(@expected_json['result']['payStyle'])
    # 比较最终价格，没有绑定运费模板，默认运费10块钱。
    # @mock_params['queryInfo']['price'].to_f * @request_params['data']['items'][0]['count'].to_i + 10.0
    @response_json['result']['price'].to_f.should eq(@expected_json['result']['price'].to_f)
  end
  @response_json['success'].should == @expected_json['success']
end