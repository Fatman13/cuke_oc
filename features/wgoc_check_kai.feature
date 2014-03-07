@checkorder @run_test
Feature: Check Order
  为了保证订单的准确性，在提交订单之前，对订单进行验对。

  Background:
    Given 我根据"./data/wgoc_cases/shipping_region.txt"设置配送范围

  Scenario Outline: 验单逻辑
    Given 我根据 <mprpc_data_file> 文件中的配置建立运费信息
    And 我根据 <mock_data_file> 文件中的配置制造mock商品信息
    And 我从 <request_data_file> 文件中读取某http请求
    When 我用post方法发送该请求至oc的话
    Then 我将得到与 <response_data_file> 文件中相同的json串

  Examples: case_1: 默认全国10块, 非促销商品验单成功（购买1件&支持配送<上海&北京&天津>&未绑定运费模板）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | check_mock_1.yaml | check_request_1.yaml | check_response_1.json |

  Examples: case_2: 验单——非促销商品验单成功（购买1件&支持配送&绑定运费模板&非上海地区使用默认运费），默认首件10块
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | check_mprpc_2.json | check_mock_2.yaml | check_request_2.yaml | check_response_2.json |

  Examples: case_3: 验单——非促销商品验单成功（购买1件&支持配送&绑定运费模板&上海地区使用指定运费），默认首件13块
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | check_mprpc_3.json | check_mock_3.yaml | check_request_3.yaml | check_response_3.json |

  Examples: case_4: 验单——非促销商品验单成功（购买2件&绑定运费模板&上海地区使用指定运费），默认首件13块，续件3块
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | check_mprpc_4.json | check_mock_4.yaml | check_request_4.yaml | check_response_4.json |

  Examples: case_5: 验单——非促销商品验单失败（库存不足）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | check_mock_5.yaml | check_request_5.yaml | check_response_5.json |

  Examples: case_6: 验单——非促销商品验单失败（不支持配送，非上海&北京&天津地区）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | check_mock_6.yaml | check_request_6.yaml | check_response_6.json |

  Examples: case_7: 验单——非促销商品验单失败（KV获取不到详情）
    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
    | empty.json | empty.yaml | check_request_7.yaml | check_response_7.json |

#  Examples: case_8: 验单——促销未开始<锁定库存>——商品库存&促销库存分别为51,50，购买1件，成交价为商品现价
#    | mprpc_data_file | mock_data_file | request_data_file | response_data_file |
#    | empty.json | empty.yaml | check_request_7.yaml | check_response_7.json |