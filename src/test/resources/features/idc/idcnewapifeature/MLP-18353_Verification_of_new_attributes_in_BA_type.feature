@MLP-18432
Feature:MLP-18432: This feature is to verify Add new attributes to business application item type

  ##6965667##
  @MLP-18432 @regression @positive
  Scenario: SC1#:MLP-18432: To Verify whether GET /settings/schemas/list
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "settings/schemas/list"
    And Status code 200 must be returned
    And response message contains value "http://www.asg.com/BusinessApplication/1.1.0"
