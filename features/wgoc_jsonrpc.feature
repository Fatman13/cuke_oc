@run_test
Feature: Json-rpc
  为了保证订单中心各个jsonrpc的准确性，以及提高覆盖率。对各个jsonrpc的api发送请求，并校验返回结果。

  Scenario Outline: Json-rpc发送请求
    Given 我根据<mock_data_file>文件中的配置
    When 我根据<request_data_file>用post方法发送jsonrpc请求至oc
    Then 我应该得到与<response_data_file>文件中相同的json串

  Examples: OrderInnerAPI/daigouCreateOrder 代购接口：给一个商品下单
  | mock_data_file | request_data_file | response_data_file |
  | mock_1.yaml | request_1.json | response_1.json |