Feature: Check Order 测试2
  为了保证订单的准确性，在提交订单之前，对订单进行验对。

  Scenario: 验单逻辑 测试2
    Given 我根据"1"文件中的配置建立运费信息 测试贰
    And 我根据"2"文件中的配置制造mock商品信息 测试贰
    And 我从"3"文件中读取某http请求 测试贰
    When 我用post方法发送该请求至oc的话 测试贰
    Then 我将得到与"4"文件中相同的json串 测试贰