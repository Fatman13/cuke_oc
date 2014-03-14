@run_test
Feature: Create Order
  保证下单的一些回归case

  Scenario Outline: 下单逻辑
    Given 我根据<mprpc_data_file>文件中的配置建立运费模板信息
    And 我根据<mock_data_file>文件中的配置在测试桩上制造mock商品
    When 我根据<request_data_file>文件中的配置用post方法发送该请求至oc的话
    Then 我应该得到与<response_data_file>文件中差不多的json串

  Examples: case_1: 下单成功（一个商品，校验最终价格）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | create_mock_1.yaml | create_request_1.yaml | create_response_1.json |

  Examples: case_2: 下单成功（多个商品，校验最终价格）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | create_mock_2.yaml | create_request_2.yaml | create_response_2.json |

  Examples: case_3: 下单失败（无district_id）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | create_mock_3.yaml | create_request_3.yaml | create_response_3.json |

  Examples: case_4: 下单失败（无address）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | create_mock_4.yaml | create_request_4.yaml | create_response_4.json |

  Examples: case_5: 下单成功（默认payStyle=2）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | create_mock_4.yaml | create_request_4.yaml | create_response_4.json |  