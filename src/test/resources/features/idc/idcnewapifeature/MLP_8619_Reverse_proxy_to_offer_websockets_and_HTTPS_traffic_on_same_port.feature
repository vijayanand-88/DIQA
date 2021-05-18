@MLP-8619
Feature: MLP-8619: Investigate NGINX as a reverse proxy to offer websockets and HTTPS traffic on same port

  ##6781560## ##6781561## ##6781562##
  @positive @sanity @URLValidation
  Scenario:MLP-8619: Investigate NGINX as a reverse proxy to offer websockets and HTTPS traffic on same port
    Given configure a new REST API for the service "IDC URI"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/IDP/health"
    Then Status code 200 must be returned
    And user makes a REST Call for Get request with url "/IDP/logs"
    Then Status code 200 must be returned
    And user makes a REST Call for Get request with url "/IDA/health"
    Then Status code 200 must be returned
    And user makes a REST Call for Get request with url "/IDN/health"
    Then Status code 200 must be returned