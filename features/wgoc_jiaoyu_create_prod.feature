@new_feature
Feature: Create Order 教育知心用（线上）
  oc开放下单接口给教育知心。

  # @jiaoyu_create_set
  Background:
  	Given 根据"./data/wgoc_jiaoyu_cases/mock_1.yaml"制造教育商品

  @jiaoyu_create_prod_set
  Scenario Outline: 下单逻辑（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至线上oc的话
    Then 我应该得到与<response_data_file>文件中大致相同的线上json串

  Examples: /api/order/create 下单
    | request_data_file | response_data_file |
    | request_7.yaml | response_7.json |

  @jiaoyu_create_prod_set
  Scenario Outline: 订单列表（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至线上oc的话贰
    Then 我应该得到与<response_data_file>文件中大致相同的线上json串贰

  Examples: /api/order/list 订单列表
    | request_data_file | response_data_file |
    | request_8.yaml | response_8.json |

  @jiaoyu_create_prod_set @after_create_prod
  Scenario Outline: 订单详情（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至线上oc的话叁
    Then 我应该得到与<response_data_file>文件中大致相同的线上json串叁

  Examples: /api/order/package/detail 订单详情
    | request_data_file | response_data_file |
    | request_9.yaml | response_9.json |

  @jiaoyu_create_prod_set @after_create_prod
  Scenario Outline: 获取支付页面（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至线上oc的话伍
    Then 我应该得到与<response_data_file>文件中大致相同的线上json串伍

  Examples: /api/midpage/pay/getUrl 获取支付页面
    | request_data_file | response_data_file |
    | request_10.yaml | response_10.json |

  @jiaoyu_refund_prod_set1
  Scenario Outline: 申请退款（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至线上oc的话肆
    Then 我应该得到与<response_data_file>文件中大致相同的线上json串肆

  Examples: /refund/apply 申请退款
    | request_data_file | response_data_file |
    | request_11.yaml | response_11.json |

  @jiaoyu_refund_prod_set1 @after_jiaoyu_refund_apply_prod
  Scenario Outline: 退款详情（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至线上oc的话陆
    Then 我应该得到与<response_data_file>文件中大致相同的线上json串陆

  Examples: /refund/detail 退款详情
    | request_data_file | response_data_file |
    | request_12.yaml | response_12.json |

  @jiaoyu_refund_prod_set2
  Scenario Outline: Json-rpc发送请求（教育）
    When 我根据<request_data_file>用post方法让测试桩发送请求至线上oc壹拾
    Then 我应该得到与<response_data_file>文件中相同的线上json壹拾

   Examples: OrderInnerAPI/queryRefundList 退款列表。
    | request_data_file | response_data_file |
    | edu_request_14.json | edu_response_14.json |

  # @new
  @jiaoyu_refund_prod_set2
  Scenario Outline: Json-rpc发送请求（教育）
    When 我根据<request_data_file>用post方法让测试桩发送请求至线上oc壹拾壹
    Then 我应该得到与<response_data_file>文件中相同的线上json壹拾壹

   Examples: OrderInnerAPI/queryRefundDetail 退款详情。
    | request_data_file | response_data_file |
    | edu_request_15.json | edu_response_15.json |

  @jiaoyu_refund_prod_set2
  Scenario Outline: Json-rpc发送请求（教育）
    When 我根据<request_data_file>用post方法让测试桩发送请求至线上oc壹拾贰
    Then 我应该得到与<response_data_file>文件中相同的线上json壹拾贰

   Examples: OrderInnerAPI/handleRefundApply 处理退款申请。
    | request_data_file | response_data_file |
    | edu_request_16.json | edu_response_16.json |