@new_feature
Feature: Create Order 教育知心用
  oc开放下单接口给教育知心。

  # @jiaoyu_create_set
  Background:
  	Given 根据"./data/wgoc_jiaoyu_cases/mock_1.yaml"制造教育商品

  @jiaoyu_create_set @debug_jiaoyu
  Scenario Outline: 下单逻辑（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至oc的话
    Then 我应该得到与<response_data_file>文件中大致相同的json串

  Examples: /api/order/create 下单
    | request_data_file | response_data_file |
    | request_1.yaml | response_1.json |

  @jiaoyu_create_set
  Scenario Outline: 订单列表（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至oc的话贰
    Then 我应该得到与<response_data_file>文件中大致相同的json串贰

  Examples: /api/order/list 订单列表
    | request_data_file | response_data_file |
    | request_2.yaml | response_2.json |

  @jiaoyu_create_set @after_create @debug_jiaoyu_3
  Scenario Outline: 订单详情（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至oc的话叁
    Then 我应该得到与<response_data_file>文件中大致相同的json串叁

  Examples: /api/order/package/detail 订单详情
    | request_data_file | response_data_file |
    | request_3.yaml | response_3.json |

  @jiaoyu_create_set @after_create
  Scenario Outline: 获取支付页面（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至oc的话伍
    Then 我应该得到与<response_data_file>文件中大致相同的json串伍

  Examples: /api/midpage/pay/getUrl 获取支付页面
    | request_data_file | response_data_file |
    | request_4.yaml | response_4.json |

  @jiaoyu_refund_set
  Scenario Outline: 申请退款（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至oc的话肆
    Then 我应该得到与<response_data_file>文件中大致相同的json串肆

  Examples: /refund/apply 申请退款
    | request_data_file | response_data_file |
    | request_5.yaml | response_5.json |

  @jiaoyu_refund_set @after_jiaoyu_refund_apply
  Scenario Outline: 退款详情（教育知心用）
    When 我根据<request_data_file>文件中教育知心的配置用get方法发送该请求至oc的话陆
    Then 我应该得到与<response_data_file>文件中大致相同的json串陆

  Examples: /refund/detail 退款详情
    | request_data_file | response_data_file |
    | request_6.yaml | response_6.json |