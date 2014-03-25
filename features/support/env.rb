$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib/extractors')
require 'httparty'
require 'cgi'
require 'rest-client'
require 'yaml'
require 'json'
#require 'logger'
#require 'paramExtractor'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'myHelper')
require 'digest/md5'

# 验单api
CHECK_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/api/order/check.do'
CREATE_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/api/order/create.do'
LIST_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/api/order/list.do'
DETAIL_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/api/order/package/detail'
REFUND_APPLY_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/refund/apply.do'
REFUND_DETAIL_REQUEST_URI = 'http://db-rdqa-pool303.db01.baidu.com:8913/weigou-ordercenter/refund/detail.do'
GET_URL_REQUEST_URI = 'http://10.52.154.40:8891/weigou-paycenter/api/midpage/pay/getUrl'

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
JSONRPC_VANILLA_ORDERINNERAPI_QUERYORDERS_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryOrders'
JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDLIST_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryRefundList'
JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDDETAIL_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryRefundDetail'
JSONRPC_VANILLA_ORDERINNERAPI_QUERYORDERQUANTITYBYORDERSTATUS_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryOrderQuantityByOrderStatus'
JSONRPC_VANILLA_ORDERINNERAPI_QUERYREFUNDQUANTITYBYSTATUS_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryRefundQuantityByStatus'
JSONRPC_VANILLA_ORDERINNERAPI_QUERYPACKAGEIDSBYORDERID_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryPackageIdsByOrderId'
JSONRPC_VANILLA_ORDERINNERAPI_QUERYORDERIDBYPACKAGEID_URI = 'http://st01-ecom-jn2.st01.baidu.com:8890/jsonrpc/vanilla/OrderInnerAPI/queryOrderIdByPackageId'

YAML::ENGINE.yamler = 'syck'

module PromotionTime
  BEFORE_PROMOTION = 1
  DURING_PROMOTION = 2
  AFTER_PROMOTION = 4
end

# OrderInnerAPI_daigouCreateOrder
module Jsonrpc
  ORDERINNERAPI_DAIGOUCREATEORDER = 'OrderInnerAPI_daigouCreateOrder'
  ORDERINNERAPI_QUERYORDERS = 'OrderInnerAPI_queryOrders'
  ORDERINNERAPI_QUERYREFUNDLIST = 'OrderInnerAPI_queryRefundList'
end

World(MyHelper)

at_exit do 
  # RestClient.post JSONRPC_SEND_DELIVERYREGIONSAPI_UPDATEDELIVERYREGIONS_URI, "0"
end 