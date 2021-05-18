@amazonSpectrum
Feature:AmazonSpectrum: Verification of AmazonSpectrum Cataloger, Analyzer and Linker Incremental cases

  Scenario Outline:SC#1_1_Run the Plugin configurations for Spectrum Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Spectrum_Credentials   | ida/AmazonSpectrumIncrementalPayloads/CredentialsSuccess.json    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/AWS_Amazon_Credentials | ida/AmazonRedshiftPostProcessorPayloads/Amazons3Credentials.json | 200           |                  |          |

   #7081549
  Scenario:SC#1_2_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumLinker.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |


  Scenario Outline: SC#1_3_Run the Plugin configurations of AmazonRedshiftDataSource,AmazonSpectrumDataSource,AmazonRedshiftCataloger,AmazonSpectrumCataloger,AmazonSpectrumAnalyzer and AmazonSpectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonSpectrumIncrementalPayloads/AmazonRedshiftDataSource.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                       | 200           | RedshiftDataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumDataSource                                               | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumDataSource.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumDataSource                                               |                                                                       | 200           | SpectrumDataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/RedshiftCataloger_filter.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                       | 200           | RedShiftCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RedShiftCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedshiftPostProcessorPayloads/empty.json                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RedShiftCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                       | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                   | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumLinker.json       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                   |                                                                       | 200           | AmazonSpectrumLinker   |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumLinker')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                        | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumLinker')].status   |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#1_4_Verify Incremental collection for Spectrum Plugins(Run cataloger/analyzer/linker with Incremental false as Run cataloger/analyzer/linker with incremental true)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypesparquet.Last_Cataloged_at                                               |
    And user enters the search text "txtdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "txtdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.txtdatatypes.Last_Cataloged_at                                                           |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#1_5_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumLinker.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#1_6_Run the Plugin configurations of AmazonRedshiftCataloger,AmazonSpectrumCataloger,AmazonSpectrumAnalyzer and AmazonSpectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/RedshiftCataloger_filter.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                       | 200           | RedShiftCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RedShiftCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedshiftPostProcessorPayloads/empty.json                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='RedShiftCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                       | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                   | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumLinker.json       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                   |                                                                       | 200           | AmazonSpectrumLinker   |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumLinker')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                        | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumLinker')].status   |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#1_7_Verify RedshiftSpectrumCataloger/linker Incremental Collection(Set Incremental false in spectrum cataloger and collect tables.In the second run,set incremental collection:true in linker and add schema/table filter in cataloger-Exclude Mode).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                                   | AttributeName      |
      | Equals | $.userdiffdatatypesparquet.Last_Cataloged_at | Last catalogued at |
    And user enters the search text "txtdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "txtdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                       | AttributeName      |
      | Equals | $.txtdatatypes.Last_Cataloged_at | Last catalogued at |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#1_8_Delete Cluster and Analysis files
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedshiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/AmazonSpectrumLinker%                | Analysis |       |       |


    ################################################################################################################################################################

    #7081551
  @RedShift @positve @regression @sanity
  Scenario:SC#2_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline: SC#2_1_Run the Plugin configurations of AmazonSpectrumCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#2_3_Verify RedshiftSpectrumCataloger Incremental Collection(Set Incremental false in cataloger and collect tables.In the second run,set incremental collection:true and add schema/table filter in cataloger).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Cataloged_at                                                      |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#2_4_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_Filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#2_5_Run the Plugin configurations of AmazonSpectrumCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                 | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_Filter1.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                      | 200           | SpectrumCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                      | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                      | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#2_6_Verify RedshiftSpectrumCataloger Incremental Collection(Set Incremental false in cataloger and collect tables.In the second run,set incremental collection:true and add schema/table filter in cataloger).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                            | AttributeName      |
      | Equals | $.userdiffdatatypes.Last_Cataloged_at | Last catalogued at |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#2_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |

    ################################################################################################################################################################

  #7081552
  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#3_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline: SC#3_2_Run the Plugin configurations of AmazonSpectrumCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#3_3_Verify RedshiftSpectrumCataloger works fine with Incremental Collection set as true(Set Incremental false in first run and Incremental true in second run add tables in spectrum)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Cataloged_at                                                      |
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 505   |
      | Table     | 55    |
      | Schema    | 1     |

  Scenario:SC#3_4_Create table in spectrum for Cataloger incremental and Update incremental values in Configuration file
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField          |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | createExternalTable |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline: SC#3_5_Run the Plugin configurations of AmazonSpectrumCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='SpectrumCataloger')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#3_6_Verify RedshiftSpectrumCataloger works fine with Incremental Collection set as true(Set Incremental false in first run and Incremental true in second run)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                            | AttributeName      |
      | Equals | $.userdiffdatatypes.Last_Cataloged_at | Last catalogued at |
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 515   |
      | Table     | 56    |
      | Schema    | 1     |
    And user enters the search text "autodiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "autodiffdatatypes" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | salesid    |
      | listid     |
      | sellerid   |
      | buyerid    |
      | eventid    |
      | dateid     |
      | qtysold    |
      | pricepaid  |
      | commission |
      | saletime   |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#3_7_Delete Cluster and Analysis files
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | dropTable  |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |

    ################################################################################################################################################################

  #7081554
  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#4_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumLinker.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#4_2_Run the Plugin configurations of AmazonRedshiftDataSource,AmazonRedshiftCataloger,AmazonSpectrumCataloger and AmazonSpectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonSpectrumIncrementalPayloads/AmazonRedshiftDataSource.json   | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                       | 200           | RedshiftDataSource   |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/RedshiftCataloger_filter.json   | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                       | 200           | RedShiftCataloger    |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='RedShiftCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedshiftPostProcessorPayloads/empty.json                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='RedShiftCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger    |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SpectrumCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SpectrumCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                   | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumLinker.json       | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                   |                                                                       | 200           | AmazonSpectrumLinker |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='AmazonSpectrumLinker')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                        | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='AmazonSpectrumLinker')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#4_3_Verify RedshiftSpectrumCataloger/linker Incremental Collection(Set Incremental false in spectrum cataloger and collect tables.In the second run,set incremental collection:true in linker and add schema/table filter in cataloger-Exclude Mode).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypesparquet.Last_Cataloged_at                                               |
    And user enters the search text "txtdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "txtdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.txtdatatypes.Last_Cataloged_at                                                           |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#4_4_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumLinker_Exclude.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#4_5_Run the Plugin configurations of AmazonRedshiftDataSource,AmazonRedshiftCataloger,AmazonSpectrumCataloger and AmazonSpectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonSpectrumIncrementalPayloads/AmazonRedshiftDataSource.json   | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                       | 200           | RedshiftDataSource   |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/RedshiftCataloger_filter.json   | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                       | 200           | RedShiftCataloger    |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='RedShiftCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedshiftPostProcessorPayloads/empty.json                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='RedShiftCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger    |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SpectrumCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='SpectrumCataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumLinker                                                   | ida/AmazonSpectrumIncrementalPayloads/SpectrumLinker_Exclude.json     | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumLinker                                                   |                                                                       | 200           | AmazonSpectrumLinker |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='AmazonSpectrumLinker')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/*                        | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/*                       |                                                                       | 200           | IDLE                 | $.[?(@.configurationName=='AmazonSpectrumLinker')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#4_6_Verify RedshiftSpectrumCataloger/linker Incremental Collection(Set Incremental false in spectrum cataloger and collect tables.In the second run,set incremental collection:true in linker and add schema/table filter in cataloger-Exclude Mode).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action    | jsonObject                                   | AttributeName      |
      | NotEquals | $.userdiffdatatypesparquet.Last_Cataloged_at | Last catalogued at |
    And user enters the search text "txtdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "txtdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action    | jsonObject                       | AttributeName      |
      | NotEquals | $.txtdatatypes.Last_Cataloged_at | Last catalogued at |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#4_7_Delete Cluster and Analysis files
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedshiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AmazonSpectrumLinker/AmazonSpectrumLinker%                | Analysis |       |       |

    ###############################################################################################################################################################################################################################

  #7081550
  Scenario:SC#5_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#5_2_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                     | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                          | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                          | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#5_3_Verify Incremental collection with Filters works fine in RedshiftSpectrumAnalyzer(In cataloger set Incremental run:false and in analyzer set Incremental run:true and add schema/table filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Cataloged_at                                                      |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                                           |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Analyzed_at                                                       |
    And user enters the search text "txtdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "txtdatatypes" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |

  Scenario:SC#5_4_Update incremental values in Configuration file
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#5_5_Run the Plugin configurations of AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | body                                                                      | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                   | ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter1.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                   |                                                                           | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/* |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*  | ida/AmazonSpectrumIncrementalPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/* |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#5_6_Verify Incremental collection with Filters works fine in RedshiftSpectrumAnalyzer(In cataloger set Incremental run:false and in analyzer set Incremental run:true and add schema/table filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                            | AttributeName      |
      | Equals | $.userdiffdatatypes.Last_Cataloged_at | Last catalogued at |
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                           | AttributeName    |
      | Equals | $.userdiffdatatypes.Last_Analyzed_at | Last analyzed at |
    And user enters the search text "txtdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "txtdatatypes" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#5_7_Delete Cluster and Analysis files
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer%      | Analysis |       |       |

    ###############################################################################################################################################################################################################################

   #7081555
  Scenario:SC#6_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#6_2_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                       | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#6_3_Verify the Redshift Spectrum Analyzer Incremental Mode works when the no filter are used for the Cataloger and the Analyser has schema Level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 505   |
      | Table     | 55    |
      | Schema    | 1     |
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Cataloged_at                                                      |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                                           |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Analyzed_at                                                       |
    And user enters the search text "spectrum_demo" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 24    |
      | Table     | 3     |
      | Schema    | 1     |
    And user enters the search text "artists_spectrum" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "artists_spectrum" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.artists_spectrum.Last_Cataloged_at                                                       |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                                           |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.artists_spectrum.Last_Analyzed_at                                                        |

  @jdbc
  Scenario:SC#6_4_Create table for Cataloger Incremental and Update incremental values in Configuration file
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField          |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | createExternalTable |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField           |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | createExternalTable1 |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#6_5_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_NoFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                       | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                       | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#6_6_Verify the Redshift Spectrum Analyzer Incremental Mode works when the no filter are used for the Cataloger and the Analyser has schema Level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                            | AttributeName      |
      | Equals | $.userdiffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.userdiffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "artists_spectrum" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "artists_spectrum" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                           | AttributeName      |
      | Equals | $.artists_spectrum.Last_Cataloged_at | Last catalogued at |
      | Equals | $.artists_spectrum.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 515   |
      | Table     | 56    |
      | Schema    | 1     |
    And user enters the search text "autodiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "autodiffdatatypes" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | salesid    |
      | listid     |
      | sellerid   |
      | buyerid    |
      | eventid    |
      | dateid     |
      | qtysold    |
      | pricepaid  |
      | commission |
      | saletime   |
    And user enters the search text "spectrum_demo" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 29    |
      | Table     | 4     |
      | Schema    | 1     |
    And user enters the search text "artists_demo" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "artists_demo" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | salesid    |
      | listid     |
      | pricepaid  |
      | commission |
      | saletime   |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#6_7_Delete Cluster and Analysis files
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | dropTable  |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | dropTable1 |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |

    ################################################################################################################################################################

  #7081556
  Scenario:SC#7_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_SchemaTableFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline: SC#7_2_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                           | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_SchemaTableFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                                | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                               | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json              | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                                | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                               | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#7_3_Verify the Redshift Spectrum  Analyzer Incremental Mode works when the no filter is used for the Analyser and cataloger has schema and table level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 7     |
      | Table     | 1     |
      | Schema    | 1     |
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Cataloged_at                                                      |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                                           |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Analyzed_at                                                       |

  @jdbc
  Scenario:SC#7_4_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_SchemaTableFilter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline: SC#7_5_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                            | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_SchemaTableFilter1.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                                 | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                                | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/AmazonSpectrumAnalyzer.json               | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                                 | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                                | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#7_6_Verify the Redshift Spectrum  Analyzer Incremental Mode works when the no filter is used for the Analyser and cataloger has schema and table level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                            | AttributeName      |
      | Equals | $.userdiffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.userdiffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 15    |
      | Table     | 2     |
      | Schema    | 1     |
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | age        |
      | bytetype   |
      | doubletype |
      | floattype  |
      | incity     |
      | longtype   |
      | phone      |
      | username   |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#7_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |

    ####################################################################################################################################################################################

  #7081558
  Scenario:SC#8_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_Filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#8_2_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                     | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_Filter1.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                          | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                          | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#8_3_Verify the Redshift Spectrum  Analyzer Incremental Mode works when the schema level filter in Cataloger and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 505   |
      | Table     | 55    |
      | Schema    | 1     |
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypesparquet.Last_Cataloged_at                                               |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                                           |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypesparquet.Last_Analyzed_at                                                |

  @jdbc
  Scenario:SC#8_4_Create table for Cataloger Incremental and Update incremental values in Configuration file
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField          |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | createExternalTable |
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_Filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#8_5_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                     | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_Filter1.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                          | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                          | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                         | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                          | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#8_6_Verify the Redshift Spectrum  Analyzer Incremental Mode works when the schema level filter in Cataloger and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypesparquet" and clicks on search
    And user performs "item click" on "userdiffdatatypesparquet" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                                   | AttributeName      |
      | Equals | $.userdiffdatatypesparquet.Last_Cataloged_at | Last catalogued at |
      | Equals | $.userdiffdatatypesparquet.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "spectrumtest" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 515   |
      | Table     | 56    |
      | Schema    | 1     |
    And user enters the search text "autodiffdatatypes" and clicks on search
    And user performs "item click" on "autodiffdatatypes" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | salesid    |
      | listid     |
      | sellerid   |
      | buyerid    |
      | eventid    |
      | dateid     |
      | qtysold    |
      | pricepaid  |
      | commission |
      | saletime   |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#8_7_Delete Cluster and Analysis files
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage                      | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | AmazonSpectrumCatalogerQueries | dropTable  |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |

    ###########################################################################################################################################################################################################################

    #7081557
  Scenario:SC#9_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_IncludeExclude.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#9_2_Run the Plugin configurations of AmazonSpectrumCataloger and AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                        | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumCataloger                                                | ida/AmazonSpectrumIncrementalPayloads/SpectrumCataloger_IncludeExclude.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumCataloger                                                |                                                                             | 200           | SpectrumCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                             | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger  | ida/AmazonSpectrumIncrementalPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SpectrumCataloger |                                                                             | 200           | IDLE                   | $.[?(@.configurationName=='SpectrumCataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                                 | ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_SchemaFilter.json    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                                 |                                                                             | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                             | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*                | ida/AmazonSpectrumIncrementalPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*               |                                                                             | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#9_3_Verify the Redshift Spectrum  Analyzer Incremental Mode works when the Analyzer filter has Schema and Table filer with mode include and Exclude, while the cataloger has a schema level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                                         |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Cataloged_at                                                      |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                                           |
      | actualFilePath | payloads/ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json |
      | jsonpath       | $.userdiffdatatypes.Last_Analyzed_at                                                       |
    And user enters the search text "artists_spectrum" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "artists_spectrum" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |

  Scenario:SC#9_4_Update incremental values in Configuration file
    And user "update" the json file "ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_IncludeExclude.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#9_5_Run the Plugin configurations of AmazonSpectrumAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | body                                                                       | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonSpectrumAnalyzer                                   | ida/AmazonSpectrumIncrementalPayloads/SpectrumAnalyzer_IncludeExclude.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonSpectrumAnalyzer                                   |                                                                            | 200           | AmazonSpectrumAnalyzer |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/* |                                                                            | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/*  | ida/AmazonSpectrumIncrementalPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/* |                                                                            | 200           | IDLE                   | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status |

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#9_6_Verify the Redshift Spectrum  Analyzer Incremental Mode works when the Analyzer filter has Schema and Table filer with mode include and Exclude, while the cataloger has a schema level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdiffdatatypes" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "userdiffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                            | AttributeName      |
      | Equals | $.userdiffdatatypes.Last_Cataloged_at | Last catalogued at |
    And user "Get" the json file value from "ida/AmazonSpectrumIncrementalPayloads/Metadata_JsonFiles/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                           | AttributeName    |
      | Equals | $.userdiffdatatypes.Last_Analyzed_at | Last analyzed at |
    And user enters the search text "artists_spectrum" and clicks on search
    And user performs "facet selection" in "Spectrum_Incremental" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "artists_spectrum" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |

  @amazonSpectrum @positve @regression @sanity
  Scenario:SC#9_7_Delete Cluster and Analysis files
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonSpectrumCataloger/SpectrumCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer%      | Analysis |       |       |

    ###############################################################################################################################################################################################################################


  @regression @positiveRedshiftDataSource
  Scenario Outline:SC#10_Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spectrum_Credentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Amazon_Credentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonRedshiftCataloger  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumCataloger  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumLinker     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonSpectrumAnalyzer   |      | 204           |                  |          |
