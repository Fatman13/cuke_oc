# encoding: utf-8

Given /^我从 (.*) 文件中提取某http请求$/ do |request_file|
  # @request = File.read('./data/' + request_file) 
  # @request_params = Extractor::ParamExtractor.get_params(request_file)
  File.open('./data/' + request_file, 'r') { |file|
      @request_params = YAML.load(file.read)
      # puts @request_params
    }
end

When /^我用post方法发送该请求至oc$/ do
  # debug_output $stderr	
  # @request = CGI::escape @request
  # @request += '&access_token=ac31d3a4723d4dd1eeeb37a9b2f8d763'
  # @request.insert(0, 'http://10.48.57.34:8912/weigou-ordercenter/api/order/check.do?')

  # puts(@request)

  # RestClient.get 'http://example.com/resource', :params => {:foo => 'bar', :baz => 'qux'}

  # manyu qa env
  # @last_response = RestClient.get 'http://10.48.57.34:8912/weigou-ordercenter/api/order/check.do',
  # 	:params => {:merchant_id => '298441',
  #  				:data => [{ 'id' => 600110680, 'name' => 'pname', 'count' => 1}],
  #  				:access_token => 'ac31d3a4723d4dd1eeeb37a9b2f8d763'}
  # manyu jn3 env
  @last_response = RestClient.get CHECK_REQUEST_URI, :params => @request_params
  	# :params => {:merchant_id => '298441',
   #        :district_id => 310115,
   # 				:data => [{ 'id' => 600110680, 'name' => 'pname', 'count' => 1}],
   # 				:access_token => 'ac31d3a4723d4dd1eeeb37a9b2f8d763'}
  # @last_response = HTTParty.get('http://10.48.57.34:8912/weigou-ordercenter/api/order/check.do', 
  # 	:query => { :merchant_id => '298441',
  # 				:data => { 'id' => 600110680, 'name' => 'pname', 'count' => 1},
  # 				:access_token => 'ac31d3a4723d4dd1eeeb37a9b2f8d763'})
#access_token=ac31d3a4723d4dd1eeeb37a9b2f8d763

  # @last_response = HTTParty.post(@request)

  # @last_response = HTTParty.post(@request,
  # 	:body => { :id => '600110680', 
  #              :name => '%E4%BA%A7%E5%93%81%E5%90%8D%E7%A7%B0', 
  #              :count => '1', 
  #            }.to_json,
  #   :headers => { 'Content-Type' => 'application/json' })
end

Then /^我会得到与 (.*) 文件中相同的json串$/ do |response_file|
  JSON.parse(@last_response.body).should == JSON.parse(File.read('./data/' + response_file))
end