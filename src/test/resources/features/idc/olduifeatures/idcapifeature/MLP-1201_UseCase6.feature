@MLP-1201
Feature: MLP-1201: This feature is demo purpose for solr based search which is related to use case 6

  Description:
  To verify API response with Solr Search whether all value return correct or not.


  @severity=critical @positive
  Scenario:MLP-1201: To get List in Json Response
    Given A query param with "query" and "test&what=tagcount%2Cid%2Cname%2Ctype&advanced=true&limit=3&offset=0" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/searches/fulltext/BigData"
    Then Status code 200 must be returned
    And compare "result.id" between Json Response and Solr Response with Search Index ID is 2
    And compare "result.name" between Json Response and Solr Response with Search Index ID is 1


