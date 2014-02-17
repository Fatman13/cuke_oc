# encoding: utf-8
After('@checkorder') do
  # puts 'after?'
  RestClient.post JSONRPC_SEND_POSTAGEAPI_DELETETEMPLATE_URI, @fid.to_s unless @fid == 0
end

# Background:
Given /^我根据"(.*?)"设置配送范围$/ do |config_file|
  RestClient.post JSONRPC_SEND_DELIVERYREGIONSAPI_UPDATEDELIVERYREGIONS_URI, File.read(config_file)
end

Given /^我根据 (.*) 文件中的配置建立运费信息$/ do |mprpc_data_file| 
  @fid = 0
  @mprpc_res = nil
  @mprpc_params = JSON.parse(File.read('./data/wgoc_cases/' + mprpc_data_file))
  # puts @mprpc_params
  # puts @mprpc_params.empty?  
  @mprpc_res = RestClient.post JSONRPC_SEND_POSTAGEAPI_ADDTEMPLATE_URI, @mprpc_params.to_json unless @mprpc_params.empty?
  
  if !@mprpc_res.nil? && @mprpc_res.code == 200
    @fid = (JSON.parse(@mprpc_res.body))['result']['result']
    # puts @fid
  end
end

Given /^我根据 (.*) 文件中的配置制造mock商品信息$/ do |mock_data_file| 
  #pending # express the regexp above with the code you wish you had
  File.open('./data/wgoc_cases/' + mock_data_file, 'r') { |file|
      @mock_params = YAML.load(file.read)
      # puts @mock_params
    }
  # 把前面mprpc返回的delivery_id设定为mock商品的fid
  @mock_params['queryInfo']['fid'] = @fid unless @fid == 0

  RestClient.get SCAFFOLDING_CREATE_KV_URI, :params => @mock_params['kv'] unless !@mock_params.key?('kv') || @mock_params['kv'].nil?
  RestClient.get SCAFFOLDING_CREATE_PRODUCTAPI_QUERYINFO_URI, :params => @mock_params['queryInfo'] unless !@mock_params.key?('queryInfo') || @mock_params['queryInfo'].nil?

  # mock促销时间的时候，还需要一定处理
  if @mock_params.key?('query') && !@mock_params['query'].nil?
    case @mock_params['query']['start_time']
    when PromotionTime::BEFORE_PROMOTION
      @mock_params['query']['start_time'] = Time.now.to_i + 100000000
      @mock_params['query']['end_time'] = @mock_params['query']['start_time'] + 100000000
    else 
      # default
    end 
    RestClient.get SCAFFOLDING_CREATE_PROMOTIONAPI_QUERY_URI, :params => @mock_params['query']
  end
end

Given /^我从 (.*) 文件中读取某http请求$/ do |request_data_file|
  #pending # express the regexp above with the code you wish you had
  File.open('./data/wgoc_cases/' + request_data_file, 'r') { |file|
      @request_params = YAML.load(file.read)
      # puts @request_params
    }
end

When /^我用post方法发送该请求至oc的话$/ do
  @last_response = RestClient.get CHECK_REQUEST_URI, :params => @request_params
end

Then /^我将得到与 (.*) 文件中相同的json串$/ do |response_data_file|
  JSON.parse(@last_response.body).should == JSON.parse(File.read('./data/wgoc_cases/' + response_data_file))
end 