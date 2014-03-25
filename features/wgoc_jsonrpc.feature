@run_test
Feature: Json-rpc
  为了保证订单中心各个jsonrpc的准确性，以及提高覆盖率。对各个jsonrpc的api发送请求，并校验返回结果。

  @daigou_set @daigou
  Scenario Outline: Json-rpc发送请求
    Given 我根据<mock_data_file>文件中的配置
    When 我根据<request_data_file>用post方法发送jsonrpc请求至oc
    Then 我应该得到与<response_data_file>文件中相同的json串壹

  Examples: OrderInnerAPI/daigouCreateOrder 代购接口：给一个商品下单
  	| mock_data_file | request_data_file | response_data_file |
  	| mock_1.yaml | request_1.json | response_1.json |

  # @new_feature
  Scenario Outline: Json-rpc发送请求
    When 我根据<request_data_file>用post方法发送query请求至oc
    Then 我应该得到与<response_data_file>文件中相同的json串贰

  Examples: OrderInnerAPI/queryOrders 订单列表接口：列出商家订单
  	| request_data_file | response_data_file |
  	| request_2.json | response_2.json |

  # @new_feature
  Scenario Outline: Json-rpc发送请求
    When 我根据<request_data_file>用post方法让测试桩发送请求至oc叁
    Then 我应该得到与<response_data_file>文件中相同的json串叁

  Examples: OrderInnerAPI/queryRefundList 退款列表接口：列出商家的退款
  	| request_data_file | response_data_file |
  	| request_3.json | response_3.json |

  # @new_feature
  Scenario Outline: Json-rpc发送请求
    When 我根据<request_data_file>用post方法让测试桩发送请求至oc肆
    Then 我应该得到与<response_data_file>文件中相同的json串肆

  Examples: OrderInnerAPI/queryRefundDetails 退款详情接口：退款详情
  	| request_data_file | response_data_file |
  	| request_4.json | response_4.json |

  # @new_feature
  Scenario Outline: Json-rpc发送请求
    When 我根据"request_5.json"和<status>用post方法让测试桩发送请求至oc伍
    Then 我应该得到与"response_5.json"文件中相同的json串伍

   Examples: OrderInnerAPI/queryOrderQuantityByOrderStatus 数订单接口：数一数
  	| status |
  	| CONFIRM |
  	| NEW |
  	| FAILED |

  # @new_feature
  Scenario Outline: Json-rpc发送请求
    When 我根据<request_data_file>用post方法让测试桩发送请求至oc陆
    Then 我应该得到与<response_data_file>文件中相同的json串陆

  Examples: OrderInnerAPI/queryOrderQuantityByOrderStatus 数退款单接口：数一数
  	| request_data_file | response_data_file |
  	| request_6.json | response_6.json |

  @daigou_set @after_daigou
  Scenario Outline: Json-rpc发送请求
    When 我根据<request_data_file>用post方法让测试桩发送请求至oc柒
    Then 我应该得到与<response_data_file>文件中相同的json柒

   Examples: OrderInnerAPI/queryPackageIdsByOrderId 代购接口测试成功后这个才会跑。
  	| request_data_file | response_data_file |
  	| request_7.json | response_7.json |

  @daigou_set @after_queryPkgId
  Scenario Outline: Json-rpc发送请求
    When 我根据<request_data_file>用post方法让测试桩发送请求至oc捌
    Then 我应该得到与<response_data_file>文件中相同的json捌

   Examples: OrderInnerAPI/queryOrderIdByPackageId queryPackageIdsByOrderId接口测试成功后这个才会跑。
  	| request_data_file | response_data_file |
  	| request_8.json | response_8.json |
