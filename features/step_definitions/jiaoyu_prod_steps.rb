# encoding: utf-8

def set_orderId_edu_prod(id)
  @order_data = Hash.new
  @order_data['orderId'] = id
  File.open('./data/wgoc_jiaoyu_cases/order_dump_prod.yaml', 'w') { |file|
    file.write @order_data.to_yaml
  }
end

def get_orderId_edu_prod
  File.open('./data/wgoc_jiaoyu_cases/order_dump_prod.yaml', 'r') { |file|
    @order_data = YAML.load(file.read)
  }
  @order_data['orderId']
end

def set_refundId_edu_prod(id)
  @order_data = Hash.new
  @order_data['refundId'] = id
  File.open('./data/wgoc_jiaoyu_cases/refund_dump_prod.yaml', 'w') { |file|
    file.write @order_data.to_yaml
  }
end

def get_refundId_edu_prod
  File.open('./data/wgoc_jiaoyu_cases/refund_dump_prod.yaml', 'r') { |file|
    @order_data = YAML.load(file.read)
  }
  @order_data['refundId']
end

When /^我根据(.*)文件中教育知心的配置用get方法发送该请求至线上oc的话$/ do |arg1|
  set_orderId_edu_prod(-1)
  # set_orderId(1103242)
  # set_orderId(1103243)
  # pending # express the regexp above with the code you wish you had
  # File.open('./data/wgoc_jiaoyu_cases/' + arg1, 'r') { |file|
  #     @request_params = YAML.load(file.read)
  #     # puts @request_params
  #   }
  #   @last_response = RestClient.get CREATE_REQUEST_URI, :params => @request_params
  @last_response = bidu_get CREATE_REQUEST_PROD_URI, :yaml => ('./data/wgoc_jiaoyu_cases/' + arg1)
  puts @last_response
end

Then /^我应该得到与(.*)文件中大致相同的线上json串$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@last_response.body)
  @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', {:invalid => :replace, :undef => :replace, :replace => '?'}))

  @response_json['success'].should == @expected_json['success']
  set_orderId_edu_prod(@response_json['result']['orderId'])
end

# list list list list list list list list list list list list list list list list list list list list list list list list list list 
When /^我根据(.*)文件中教育知心的配置用get方法发送该请求至线上oc的话贰$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # File.open('./data/wgoc_jiaoyu_cases/' + arg1, 'r') { |file|
  #     @request_params = YAML.load(file.read)
  #     # puts @request_params
  #   }
  #   @last_response = RestClient.get CREATE_REQUEST_URI, :params => @request_params
  f_path = './data/wgoc_jiaoyu_cases/' + arg1
  @last_response = bidu_get LIST_REQUEST_PROD_URI, :yaml => f_path
  puts @last_response
end

Then /^我应该得到与(.*)文件中大致相同的线上json串贰$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  # puts "ca1"
  @response_json = JSON.parse(@last_response.body)
  # puts "ca2"
  # @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', "binary", :undef => :replace))
  # puts "ca3"
  @response_json['success'].should == @expected_json['success']
end

# detail  detail  detail  detail  detail  detail  detail  detail  detail  detail  detail  detail  detail 
Around('@after_create_prod') do |scenario, block|
  if get_orderId_edu_prod.to_i > 0
    block.call
  end
end

When /^我根据(.*)文件中教育知心的配置用get方法发送该请求至线上oc的话叁$/ do |arg1|
  File.open('./data/wgoc_jiaoyu_cases/' + arg1, 'r') { |file|
    @request_params = YAML.load(file.read)
  }
  # 修改order_id
  @request_params['order_id'] = get_orderId_edu_prod
  @last_response = RestClient.get DETAIL_REQUEST_PROD_URI, :params => @request_params
  puts @request_params['order_id']
  puts @last_response
end

Then /^我应该得到与(.*)文件中大致相同的线上json串叁$/ do |arg1|
  @response_json = JSON.parse(@last_response.body)
  @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', "binary", :undef => :replace))

  @response_json['success'].should == @expected_json['success']
end

# getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl getUrl
When /^我根据(.*)文件中教育知心的配置用get方法发送该请求至线上oc的话伍$/ do |arg1|
  File.open('./data/wgoc_jiaoyu_cases/' + arg1, 'r') { |file|
    @request_params = YAML.load(file.read)
  }
  # 修改order_id
  @request_params['orderId'] = get_orderId_edu_prod
  # 计算md5
  @request_params['md5'] = Digest::MD5.hexdigest('weigou_^&%$#' + @request_params['order_id'].to_s)
  # @request_params['md5'] = Digest::MD5.digest('weigou_^&%$#' + @request_params['order_id'].to_s)

  # puts @request_params['md5']
  @last_response = RestClient.get GET_URL_REQUEST_PROD_URI, :params => @request_params
  puts @request_params
  puts @last_response
end

Then /^我应该得到与(.*)文件中大致相同的线上json串伍$/ do |arg1|
  @response_json = JSON.parse(@last_response.body)
  @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', "binary", :undef => :replace))

  @response_json['success'].should == @expected_json['success']
end

# refund refund refund refund refund refund refund refund refund refund refund refund refund refund refund refund 
When /^我根据(.*)文件中教育知心的配置用get方法发送该请求至线上oc的话肆$/ do |arg1|
  # cc
  # set_refundId_edu_prod(100)
  set_refundId_edu_prod(-1)
  File.open('./data/wgoc_jiaoyu_cases/' + arg1, 'r') { |file|
    @request_params = YAML.load(file.read)
  }
  # 修改order_id
  @request_params['order_id'] = get_orderId_edu_prod
  @last_response = RestClient.get REFUND_APPLY_REQUEST_PROD_URI, :params => @request_params
  puts @last_response
end

Then /^我应该得到与(.*)文件中大致相同的线上json串肆$/ do |arg1|
  @response_json = JSON.parse(@last_response.body)
  @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', "binary", :undef => :replace))

  @response_json['success'].should == @expected_json['success']
  set_refundId_edu_prod(@response_json['result']['refundId'])
end

# refund detail refund detail refund detail refund detail refund detail refund detail refund detail
Around('@after_jiaoyu_refund_apply_prod') do |scenario, block|
  if get_refundId_edu_prod.to_i > 0
    block.call
  end
end

When /^我根据(.*)文件中教育知心的配置用get方法发送该请求至线上oc的话陆$/ do |arg1|
  File.open('./data/wgoc_jiaoyu_cases/' + arg1, 'r') { |file|
    @request_params = YAML.load(file.read)
  }
  # 修改order_id
  @request_params['refund_id'] = get_refundId_edu_prod
  @last_response = RestClient.get REFUND_DETAIL_REQUEST_PROD_URI, :params => @request_params
  puts @request_params
  puts @last_response
end

Then /^我应该得到与(.*)文件中大致相同的线上json串陆$/ do |arg1|
  @response_json = JSON.parse(@last_response.body)
  @expected_json = JSON.parse((File.read('./data/wgoc_jiaoyu_cases/' + arg1)).to_s.encode('utf-8', "binary", :undef => :replace))

  @response_json['success'].should == @expected_json['success']
end

# Set2 Set2 Set2 Set2 Set2
# queryRefundList queryRefundList queryRefundList queryRefundList queryRefundList
When /^我根据(.*)用post方法让测试桩发送请求至线上oc壹拾$/ do |arg1|
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDLIST_URI, @request_data.to_json

  puts @request_data.to_json
  puts @response
end

Then /^我应该得到与(.*)文件中相同的线上json壹拾$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)

  # puts @response_json
  # puts get_orderId
  @response_json['result']['success'].should == @expected_json['result']['success']
end

# queryRefundDetail queryRefundDetail queryRefundDetail queryRefundDetail queryRefundDetail
When /^我根据(.*)用post方法让测试桩发送请求至线上oc壹拾壹$/ do |arg1|
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['refundApplyId'] = get_refundId_edu
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDDETAIL_URI, @request_data.to_json

  puts @request_data['refundApplyId']
  puts @response
end

Then /^我应该得到与(.*)文件中相同的线上json壹拾壹$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)

  # puts @response_json
  # puts get_orderId
  @response_json['result']['success'].should == @expected_json['result']['success']
end

# handleRefundApply handleRefundApply handleRefundApply handleRefundApply handleRefundApply
When /^我根据(.*)用post方法让测试桩发送请求至线上oc壹拾贰$/ do |arg1|
  @request_data = JSON.parse((File.read('./data/wgoc_jsonrpc_cases/' + arg1)).to_s.encode('ascii', {:invalid => :replace, :undef => :replace, :replace => '?'}))
  @request_data['refundId'] = get_refundId_edu
  @request_data['orderId'] = get_orderId_edu
  @response = RestClient.post JSONRPC_VANILLA_ORDERINNERAPI_HANDLEREFUNDAPPLY_URI, @request_data.to_json

  puts @request_data['orderId']
  puts @request_data['refundId']
  puts @response
end

Then /^我应该得到与(.*)文件中相同的线上json壹拾贰$/ do |arg1|
  # pending # express the regexp above with the code you wish you had
  @response_json = JSON.parse(@response.body)
  @expected_json = parse_json('./data/wgoc_jsonrpc_cases/' + arg1)

  # puts @response_json
  # puts get_orderId
  @response_json['result']['success'].should == @expected_json['result']['success']
end