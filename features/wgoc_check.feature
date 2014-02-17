Feature: Check Order
  为了保证订单的准确性，在提交订单之前，对订单进行验对。

  Scenario Outline: 验单逻辑
    Given 我从 <request_file> 文件中提取某http请求
    When 我用post方法发送该请求至oc
    Then 我会得到与 <response_file> 文件中相同的json串

  Examples: 验单成功case
    | request_file | response_file |
    | check_request_1.yaml | check_response_1.json |
    | check_request_2.yaml | check_response_2.json |

