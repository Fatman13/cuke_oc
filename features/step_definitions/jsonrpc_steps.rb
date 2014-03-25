# encoding: utf-8

# can't use helper in Around hooks; don't put these into myHelper
def set_orderId(id)
  @order_data = Hash.new
  @order_data['orderId'] = id
  File.open('./data/wgoc_jsonrpc_cases/order_dump.yaml', 'w') { |file|
    file.write @order_data.to_yaml
  }
end

def get_orderId
  File.open('./data/wgoc_jsonrpc_cases/order_dump.yaml', 'r') { |file|
    @order_data = YAML.load(file.read)
  }
  @order_data['orderId']
end

def set_pkgId(id)
  @order_data = Hash.new
  @order_data['packageId'] = id
  File.open('./data/wgoc_jsonrpc_cases/package_dump.yaml', 'w') { |file|
    file.write @order_data.to_yaml
  }
end

def get_pkgId
  File.open('./data/wgoc_jsonrpc_cases/package_dump.yaml', 'r') { |file|
    @order_data = YAML.load(file.read)
  }
  @order_data['packageId']
end

# ORDERINNERAPI_DAIGOUCREATEORDER ORDERINNERAPI_DAIGOUCREATEORDER ORDERINNERAPI_DAIGOUCREATEORDER ORDERINNERAPI_DAIGOUCREATEORDER ORDERINNERAPI_DAIGOUCREATEORDER 
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
  # File.open('./data/wgoc_jsonrpc_cases/' + arg1, 'r') { |file|
  #   # @dg_request_json = JSON.load(file)
  #   @dg_request_json = JSON.parse(file.)
  #   # puts @dg_request_json
  # }

  # 好像这个补丁不是很靠谱。。。
  @dg_request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))

  # puts @dg_request_json
  # puts JSONRPC_VANILLA_ORDERINNERAPI_DAIGOUCREATEORDER_URI
  @dg_request_data['daigouOrder']['daigouId'] = @dg_request_data['daigouOrder']['daigouId'] + 1
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_DAIGOUCREATEORDER_URI, @dg_request_data.to_json

  File.open('./data/wgoc_jsonrpc_cases/' + arg1, 'w') { |file|
    # puts @dg_request_json
    JSON.dump(@dg_request_data, file)
  }
end

Then /^我应该得到与(.*)文件中相同的json串壹$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = JSON.parse(File.read('./data/wgoc_jsonrpc_cases/' + arg1))

  # 这个case...when现在暂时有点鸡肋...
  case @expected_json['api_name']
  when Jsonrpc::ORDERINNERAPI_DAIGOUCREATEORDER
    # Time.now.to_i + 100000000
    @response_json['result']['success'].should == @expected_json['result']['success']
    @response_json['result']['code'].should == @expected_json['result']['code']

    # for @daigou_set
    set_orderId('-1')
    if @response_json['result']['success'].to_s == 'true'
      set_orderId(@response_json['result']['orderId'])
    end
  # when Jsonrpc::ORDERINNERAPI_QUERYORDERS
    # @response_json['result']['status'].should == @expected_json['result']['status']
  else 
    # default
  end 
end

# ORDERINNERAPI_QUERYORDERS ORDERINNERAPI_QUERYORDERS ORDERINNERAPI_QUERYORDERS ORDERINNERAPI_QUERYORDERS 
When /^我根据(.*)用post方法发送query请求至oc$/ do |arg1|
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['condition']['end_time'] = Time.now.to_i
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYORDERS_URI, @request_data.to_json
end

Then /^我应该得到与(.*)文件中相同的json串贰$/ do |arg1|
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)
  @response_json['result']['status'].should == @expected_json['result']['status']
end

# ORDERINNERAPI_queryRefundList # ORDERINNERAPI_queryRefundList # ORDERINNERAPI_queryRefundList # ORDERINNERAPI_queryRefundList 
When /^我根据(.*)用post方法让测试桩发送请求至oc叁$/ do |arg1|
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['endTime'] = Time.now.to_i
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDLIST_URI, @request_data.to_json
end

Then /^我应该得到与(.*)文件中相同的json串叁$/ do |arg1|
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)
  @response_json['result']['success'].should == @expected_json['result']['success']
  # puts @response_json
  # 给下一个case用。。。感觉可能不是太好。 refundDatas
  # puts @response_json['result']['refundDatas']
end

# queryRefundDetails queryRefundDetails queryRefundDetails queryRefundDetails queryRefundDetails queryRefundDetails
When /^我根据(.*)用post方法让测试桩发送请求至oc肆$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDDETAIL_URI, @request_data.to_json
end

Then /^我应该得到与(.*)文件中相同的json串肆$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)
  @response_json['result']['success'].should == @expected_json['result']['success']
end

# queryOrderQuantityByOrderStatus queryOrderQuantityByOrderStatus queryOrderQuantityByOrderStatus queryOrderQuantityByOrderStatus 
When /^我根据"(.*?)"和(.*)用post方法让测试桩发送请求至oc伍$/ do |arg1, arg2|
  # pending # express the regexp above with the code you wish you had
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['orderStatus'][0] = arg2
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYORDERQUANTITYBYORDERSTATUS_URI, @request_data.to_json
end

Then /^我应该得到与"(.*)"文件中相同的json串伍$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)
  @response_json['result']['success'].should == @expected_json['result']['success']
end

# queryRefundQuantityByStatus queryRefundQuantityByStatus queryRefundQuantityByStatus queryRefundQuantityByStatus
When /^我根据(.*)用post方法让测试桩发送请求至oc陆$/ do |arg1|
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDQUANTITYBYSTATUS_URI, @request_data.to_json
end

Then /^我应该得到与(.*)文件中相同的json串陆$/ do |arg1|
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)
  @response_json['result']['success'].should == @expected_json['result']['success']
end

# queryPackageIdsByOrderId queryPackageIdsByOrderId queryPackageIdsByOrderId queryPackageIdsByOrderId
Around('@after_daigou') do |scenario, block|
  # puts get_orderId.to_i
  if get_orderId.to_i > 0
    block.call
  end
  # block.call
end

When /^我根据(.*)用post方法让测试桩发送请求至oc柒$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # puts get_orderId
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['orderId'] = get_orderId
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYPACKAGEIDSBYORDERID_URI, @request_data.to_json
end

Then /^我应该得到与(.*)文件中相同的json柒$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  set_pkgId(-1)

  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)

  # puts @response_json
  # puts get_orderId
  @response_json['result']['status'].should == @expected_json['result']['status']
  set_pkgId(@response_json['result']['packageIds'][0])
end

# queryOrderIdByPackageId queryOrderIdByPackageId queryOrderIdByPackageId queryOrderIdByPackageId
Around('@after_queryPkgId') do |scenario, block|
  # puts get_orderId.to_i
  # set_pkgId(-1)
  if get_pkgId.to_i > 0
    block.call
  end
  # block.call
end

When /^我根据(.*)用post方法让测试桩发送请求至oc捌$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # puts get_orderId
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['packageId'] = get_pkgId
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYORDERIDBYPACKAGEID_URI, @request_data.to_json
end

Then /^我应该得到与(.*)文件中相同的json捌$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)

  # puts @response_json
  # puts get_orderId
  @response_json['result']['status'].should == @expected_json['result']['status']
end
