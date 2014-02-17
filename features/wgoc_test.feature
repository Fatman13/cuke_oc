Feature: Check Order 测试
  为了保证订单的准确性，在提交订单之前，对订单进行验对。

  Scenario: 验单逻辑 测试
    Given 我根据 <mprpc_data_file> 文件中的配置建立运费信息 测试
    And 我根据 <mock_data_file> 文件中的配置制造mock商品信息 测试
    And 我从 <request_data_file> 文件中读取某http请求 测试
    When 我用post方法发送该请求至oc的话 测试
    Then 我将得到与 <response_data_file> 文件中相同的json串 测试