Feature: 代客下单
  运营平台调用oc代客下单接口，以代替顾客下订单。

  Scenario: 代客下单，单个商品
    Given 我根据"./data/wgoc_daigou_cases/mock_product_1.yaml"制造mock商品
    When 我根据"./data/wgoc_daigou_cases/dg_request_1.json"发送代购jsonrpc请求至oc
    Then 我应该得到跟"./data/wgoc_daigou_cases/dg_response_1.json"相同的json串壹