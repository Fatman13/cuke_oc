$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib/extractors')
require 'httparty'
require 'cgi'
require 'rest-client'
require 'yaml'
require 'json'
#require 'logger'
#require 'paramExtractor'

# 验单api
CHECK_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/api/order/check.do'

SCAFFOLDING_CREATE_PRODUCTAPI_QUERYINFO_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/scaffolding/create/ProductAPI/queryInfo'
SCAFFOLDING_CREATE_KV_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/scaffolding/create/kv'
SCAFFOLDING_CREATE_OLDKV_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/scaffolding/create/oldkv'
SCAFFOLDING_CREATE_PROMOTIONAPI_QUERY_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/scaffolding/create/PromotionAPI/query'

JSONRPC_SEND_ORDERINNERAPI_DAIGOUCREATEORDER_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/send/OrderInnerAPI/daigouCreateOrder'
JSONRPC_SEND_POSTAGEAPI_ADDTEMPLATE_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/send/PostageAPI/addTemplate'
JSONRPC_SEND_POSTAGEAPI_DELETETEMPLATE_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/send/PostageAPI/deleteTemplate'
JSONRPC_SEND_DELIVERYREGIONSAPI_UPDATEDELIVERYREGIONS_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/send/DeliveryRegionsAPI/updateDeliveryRegions'
# 'http://st01-ecom-jn3.st01.baidu.com:8913/weigou-ordercenter/drapi/OrderInnerAPI'
# $ RESTCLIENT_LOG=stdout D:\Libs\cuke_oc
# debug_output $stderr
JSONRPC_VANILLA_ORDERINNERAPI_DAIGOUCREATEORDER_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/daigouCreateOrder'

module PromotionTime
  BEFORE_PROMOTION = 1
  DURING_PROMOTION = 2
  AFTER_PROMOTION = 4
end

at_exit do 
  RestClient.post JSONRPC_SEND_DELIVERYREGIONSAPI_UPDATEDELIVERYREGIONS_URI, "0"
end 