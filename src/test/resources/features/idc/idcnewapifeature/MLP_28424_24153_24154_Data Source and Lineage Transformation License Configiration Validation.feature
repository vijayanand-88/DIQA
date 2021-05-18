@MLPQA-18344
Feature:  MLP-28424 and MLP-24153_Configuration path definition for License and Get API for license management screen
  MLP-24154_As an IDA admin i need to have validation of datasource count if license entity is configured

    ### Before Going to run this feature file please follow the following steps ###
    ### 1.Please Take Build ####
    ### 2.Please upload Git,Oracle and Snowflake Bundles ####
    ### 3.Make sure there is no Data source configuration and Postprocessor Configurations avilable in the Docker ####
    ### 4.Once done the above steps we can ready to run this feature file ####

###########################################################################################################################

  ##7266983##MLPQA-3138##
  @TEST_MLPQA-3138 @MLPQA-18083
  @MLP-28424 @edibus @regression @positive @license
  Scenario Outline:SC1#_Set the DataSource for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusNodeDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusNodeDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusNodeDataSource |          |

  ##7266985##MLPQA-3136##
  @TEST_MLPQA-3136 @MLPQA-18083
  @MLP-28424 @edibus @regression @positive @license
  Scenario:SC2#_Verify EDIBus Plugin configuration is created with EDIDataSource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                       | body                                       | response code | response message | jsonPath |
      | application/json |       |       | Put          | settings/analyzers/EDIBus | idc/EdiBusPayloads/IDXTOEDINodeConfig.json | 204           |                  |          |

  ##7266984##7266990##MLPQA-3135##MLPQA-3137##
  @TEST_MLPQA-3135 @TEST_MLPQA-3137 @MLPQA-18083
  @MLP-28424 @edibus @regression @positive @license @webtest
  Scenario:SC3#_Verify EDIBus DataSource usage is not calculated and ignored even if we have valid DataSources
    Given Execute REST API with following parameters
      | Header            | Query | Param | type   | url              | body | response code | response message | jsonPath |
      | application/json  |       |       | Get    | settings/license |      | 200           |                  |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user "click" on "Admin Link" for "Manage Licenses" in "Landing page"
    Then user "verifies presence" of following "Licenses" in "Manage Licenses" page
      | Data sources  |
    When User performs following actions in the Manage Licenses Page
      | Actiontype     | ActionItem   |
      | Expand License | Data Sources |
    Then User performs following actions in the Manage Licenses Page
      | Actiontype         | ActionItem    | ItemName |
      | Verify Field Value | License Used  | 0        |


  Scenario:SC4#_Delete the plugin configuration and DataSource
    Given user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus/IDXtoEDINode"
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBusDataSource/EDIBusNodeDataSource"

###########################################################################################################################################
  # 7127915
  @MLP-24154 @regression @positive
  Scenario Outline:SC#1_Verify if user able to use PUT API "DD/services/settings/license" and append with name,type,limit and active=true and get the response code as 204
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url              | body                                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/license | payloads/idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |          |


 # 7127916
  @MLP-24154 @regression @positive
  Scenario:SC#2_Verify if user is able to add lineage configuration when configuration body has limit as any lineage plugin name and active= true
    Given user "update" the json file "idc/LicenseConfigurations/MLP_24154_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[0].active | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                                           | response code | response message      | jsonPath                    |
      | application/json |       |       | Put  | settings/license                         | idc/LicenseConfigurations/MLP_24154_License_Configuration.json | 204           |                       |                             |
      |                  |       |       | Put  | settings/analyzers/OracleDBPostProcessor | idc/LicenseConfigurations/OracleDBPP.json                      | 204           |                       |                             |
      |                  |       |       | Get  | settings/license                         |                                                                | 200           | OracleDBPostProcessor | $.entities[0]..currentUsage |


  # 7127920
  @MLP-24154 @regression @positive
  Scenario:SC#3_Verify if user can able to view same lineage plugin name should be available in the limit[] and currentUsage[] from the GET "DD/services/settings/license" response
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message      | jsonPath                    |
      | application/json |       |       | Get  | settings/license |      | 200           | OracleDBPostProcessor | $.entities[0]..currentUsage |
      |                  |       |       | Get  | settings/license |      | 200           | OracleDBPostProcessor | $.entities[0]..limit        |


   # 7127917
  @MLP-24154 @regression @positive
  Scenario:SC#4_Verify if user is able to add lineage configuration when configuration body has limit as empty and active= false
    Given user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json " file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[0].active | false      | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body                                                                   | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/OracleDBPostProcessor    |                                                                        | 204           |                  |          |
      |                  |       |       | Put    | settings/license                            | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |          |
      |                  |       |       | Put    | settings/analyzers/SnowflakeDBPostProcessor | idc/LicenseConfigurations/SnowFlakePP.json                             | 204           |                  |          |
      |                  |       |       | Get    | settings/license                            |                                                                        | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$.entities[0]..active"
      | jsonValues |
      | false      |
    And user verifies whether the value is present in response using json path "$.entities[0]..currentUsage"
      | jsonValues               |
      | SnowflakeDBPostProcessor |


  # 7127918
  @MLP-24154 @regression @positive @webtest
  Scenario:SC#5_Verify if user is unable to add lineage configuration and get Error message as "License for this product is not present for entity lineage" when configuration body has limit as empty and active= true
    Given user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[0].active | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body                                                                   | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/SnowflakeDBPostProcessor |                                                                        | 204           |                  |          |
      |                  |       |       | Put    | settings/license                            | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Lineage                  |
      | Plugin    | SnowflakeDBPostProcessor |
      | Plugin    | SnowflakeDBPostProcessor |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute   |
      | Name      | SnowflakeDB |
    And user "click" on "Save" button in "Add Configuration Sources Page"
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem         | ItemName                                                   |
      | Add PostProcessor Config | VerifyErrorMessage | License for this product is not present for entity lineage |


   # 7127919
  @MLP-24154 @regression @positive @webtest
  Scenario:SC#6_Verify if user is unable to add other plugin lineage configuration and get Error message as "License for this product is not present for entity lineage" when configuration body has limit as one plugin name and active= true
    Given user "update" the json file "idc/LicenseConfigurations/MLP_24154_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[0].active | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body                                                           | response code | response message      | jsonPath             |
      | application/json |       |       | Put  | settings/license | idc/LicenseConfigurations/MLP_24154_License_Configuration.json | 204           |                       |                      |
      |                  |       |       | Get  | settings/license |                                                                | 200           | OracleDBPostProcessor | $.entities[0]..limit |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Lineage                  |
      | Plugin    | SnowflakeDBPostProcessor |
      | Plugin    | SnowflakeDBPostProcessor |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute   |
      | Name      | SnowflakeDB |
    And user "click" on "Save" button in "Add Configuration Sources Page"
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem         | ItemName                                                   |
      | Add PostProcessor Config | VerifyErrorMessage | License for this product is not present for entity lineage |


   # 7127921
  @MLP-24154 @regression @positive
  Scenario:SC#7_Verify if user can able to view list of Lineage plugins name available in the UI same should be available in "allAvailableValues" in the GET "DD/services/settings/license" response
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/license |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$.entities[0]..allAvailableValues"
      | jsonValues               |
      | PythonSparkLineage       |
      | SnowflakeDBPostProcessor |
      | OracleDBPostProcessor    |


    # 7127922
  @MLP-24154 @regression @positive
  Scenario:SC#8_Verify if user is able to add datasource configuration when the data source count should be less than the limit mentioned in the license configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath             |
      | application/json |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..limit |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                            | body                                                                   | response code | response message | jsonPath                    |
      |        | raw   | false | Put  | settings/license                               | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |                             |
      |        |       |       | Put  | settings/credentials/ValidSnowflakeCredentials | idc/LicenseConfigurations/SnowflakeCred.json                           | 200           |                  |                             |
      |        |       |       | Get  | settings/credentials/ValidSnowflakeCredentials |                                                                        | 200           |                  |                             |
      |        |       |       | Put  | settings/analyzers/SnowflakeDBDataSource       | idc/LicenseConfigurations/SnowflakeDS.json                             | 204           |                  |                             |
      |        |       |       | Get  | settings/analyzers/SnowflakeDBDataSource       |                                                                        | 200           |                  |                             |
      |        |       |       | Get  | settings/license                               |                                                                        | 200           | 1                | $.entities[1]..currentUsage |


  # 7127925
  @MLP-24154 @regression @positive
  Scenario:SC#9_Verify if user is able to add datasource configuration when the data source count should be equal to the limit mentioned in the license configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath                    |
      | application/json |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..limit        |
      |                  |       |       | Get  | settings/license |      | 200           | 1                | $.entities[1]..currentUsage |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                    | body                                                                   | response code | response message | jsonPath                    |
      |        | raw   | false | Put  | settings/license                       | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |                             |
      |        |       |       | Put  | settings/credentials/OracleCredentials | idc/LicenseConfigurations/OracleCred.json                              | 200           |                  |                             |
      |        |       |       | Get  | settings/credentials/OracleCredentials |                                                                        | 200           |                  |                             |
      |        |       |       | Put  | settings/analyzers/OracleDBDataSource  | idc/LicenseConfigurations/OracleDS.json                                | 204           |                  |                             |
      |        |       |       | Get  | settings/analyzers/OracleDBDataSource  |                                                                        | 200           |                  |                             |
      |        |       |       | Get  | settings/license                       |                                                                        | 200           | 2                | $.entities[1]..currentUsage |


  # 7127923
  @MLP-24154 @regression @positive
  Scenario:SC#10_Verify if user get error message as "License limit has reached maximum for entity datasource" when the data source count greater than than the limit mentioned in the license configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath                    |
      | application/json |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..limit        |
      |                  |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..currentUsage |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                       | body                                   | response code | response message                                        | jsonPath       |
      |        |       |       | Put  | settings/credentials/GitCredentials       | idc/LicenseConfigurations/GitCred.json | 200           |                                                         |                |
      |        |       |       | Put  | settings/analyzers/GitCollectorDataSource | idc/LicenseConfigurations/GitDS.json   | 403           | License limit has reached maximum for entity datasource | $.errorMessage |


  # 7127927
  @MLP-24154 @regression @positive
  Scenario:SC#11_Verify if the entity has already 2 Datasource and set the DataSource limit as 1 and hit  PUT "DD/services/settings/license" then get error message  as "errorMessage": "Current usage of resource 2 exceeds new limit: 1" in the response body
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath             |
      | application/json |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..limit |
    And user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath            | jsonValues | type    |
      | $.entities[1].limit | 1          | Integer |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url              | body                                                                   | response code | response message                                 | jsonPath       |
      |        | raw   | false | Put  | settings/license | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 400           | Current usage of resource 2 exceeds new limit: 1 | $.errorMessage |


    # 7127929
  @MLP-24154 @regression @positive
  Scenario:SC#12_Verify if user able to set limit as 2 and add 2 Datasource in the entity after that update the limit as 3 then user can able to add the lineage configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath                    |
      | application/json |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..limit        |
      |                  |       |       | Get  | settings/license |      | 200           | 2                | $.entities[1]..currentUsage |
    And user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[1].limit  | 3          | Integer |
      | $.entities[1].active | true       | boolean |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                       | body                                                                   | response code | response message | jsonPath                    |
      |        |       |       | Put  | settings/license                          | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |                             |
      |        |       |       | Put  | settings/analyzers/GitCollectorDataSource | idc/LicenseConfigurations/GitDS.json                                   | 204           |                  |                             |
      |        |       |       | Get  | settings/license                          |                                                                        | 200           | 3                | $.entities[1]..limit        |
      |        |       |       | Get  | settings/license                          |                                                                        | 200           | 3                | $.entities[1]..currentUsage |


  # 7127928
  @MLP-24154 @regression @positive
  Scenario:SC#13_Verify if user is able to add datasource configuration when configuration body has limit as 0 and active= false and hit the GET "DD/services/settings/license" response body has currentUsage value should be greater than the limit value
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                            | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource          |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/SnowflakeDBDataSource       |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/OracleCredentials         |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/ValidSnowflakeCredentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/GitCredentials            |      | 200           |                  |          |
    And user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[1].limit  | 0          | Integer  |
      | $.entities[1].active | false      | boolean |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                    | body                                                                   | response code | response message | jsonPath                    |
      |        |       |       | Put  | settings/license                       | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |                             |
      |        |       |       | Put  | settings/credentials/OracleCredentials | idc/LicenseConfigurations/OracleCred.json                              | 200           |                  |                             |
      |        |       |       | Get  | settings/credentials/OracleCredentials |                                                                        | 200           |                  |                             |
      |        |       |       | Put  | settings/analyzers/OracleDBDataSource  | idc/LicenseConfigurations/OracleDS.json                                | 204           |                  |                             |
      |        |       |       | Get  | settings/analyzers/OracleDBDataSource  |                                                                        | 200           |                  |                             |
      |        |       |       | Get  | settings/license                       |                                                                        | 200           | 0                | $.entities[1]..limit        |
      |        |       |       | Get  | settings/license                       |                                                                        | 200           | 1                | $.entities[1]..currentUsage |


  # 7127932
  @MLP-24154 @regression @positive @webtest
  Scenario:SC#14_Verify if user get error message as "License limit has reached maximum for entity datasource" when the License configuration has limit as 0 and active =true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource |      | 204           |                  |          |
    And user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[1].limit  | 0          | Integer  |
      | $.entities[1].active | true       | boolean |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                   | body                                                                   | response code | response message                                        | jsonPath                    |
      |        |       |       | Put  | settings/license                      | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                                                         |                             |
      |        |       |       | Get  | settings/license                      |                                                                        | 200           | 0                                                       | $.entities[1]..limit        |
      |        |       |       | Get  | settings/license                      |                                                                        | 200           | 0                                                       | $.entities[1]..currentUsage |
      |        |       |       | Put  | settings/analyzers/OracleDBDataSource | idc/LicenseConfigurations/OracleDS.json                                | 403           | License limit has reached maximum for entity datasource | $.errorMessage              |


    # 7127933
  @MLP-24154 @regression @positive
  Scenario:SC#15_Verify if user able to datasource configuration when the License configuration has limit as 0 and active =false
    Given user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[1].limit  | 0          | Integer  |
      | $.entities[1].active | false      | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                                   | response code | response message | jsonPath                    |
      | application/json |       |       | Put  | settings/license                      | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |                             |
      |                  |       |       | Put  | settings/analyzers/OracleDBDataSource | idc/LicenseConfigurations/OracleDS.json                                | 204           |                  |                             |
      |                  |       |       | Get  | settings/license                      |                                                                        | 200           | 0                | $.entities[1]..limit        |
      |                  |       |       | Get  | settings/license                      |                                                                        | 200           | 1                | $.entities[1]..currentUsage |
    And user "update" the json file "idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json" file for following values
      | jsonPath             | jsonValues | type    |
      | $.entities[1].limit  | 2          | Integer  |
      | $.entities[1].active | true       | boolean |
    And Execute REST API with following parameters
      | Header | Query | Param | type   | url                                    | body                                                                   | response code | response message | jsonPath |
      |        |       |       | Put    | settings/license                       | idc/LicenseConfigurations/MLP_24154_Default_License_Configuration.json | 204           |                  |          |
      |        |       |       | Delete | settings/analyzers/OracleDBDataSource  |                                                                        | 204           |                  |          |
      |        |       |       | Delete | settings/credentials/OracleCredentials |                                                                        | 200           |                  |          |


  # 7117015
  @MLP-24153 @regression @positive
  Scenario Outline:SC#16_Verify if user able to use GET API "DD/services/settings/license" and get the response
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url              | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/license |      | 200           |                  |          |


 # 7117057
  @MLP-24153 @regression @positive
  Scenario Outline:SC#17_Verify if the GET response is 200 and the response body has DataSource Licence configuration
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url              | body | response code | response message | filePath                                                      | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | settings/license |      | 200           |                  | payloads/idc/LicenseConfigurations/License_Configuration.json |          |


  # 7117058
  @MLP-24153 @regression @positive
  Scenario:SC#18_Verify if datasource response body has the following labels "name","currentUsage","limit","active","localizedLabel"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/license |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$.entities[1]"
      | jsonValues     |
      | name           |
      | type           |
      | limit          |
      | active         |
      | currentUsage   |
      | localizedLabel |


  # 7117059
  @MLP-24153 @regression @positive
  Scenario:SC#19_Verify if Lineage Transformation response body has the following labels "name","type","currentUsage","limit","allAvailableValues","active","localizedLabel"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/license |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$.entities[0]"
      | jsonValues         |
      | name               |
      | type               |
      | limit              |
      | active             |
      | currentUsage       |
      | allAvailableValues |
      | localizedLabel     |


  # 7117060
  @MLP-24153 @regression @positive
  Scenario:SC#20_Verify if datasource response body has "name": "DATASOURCE", "type": "number" and "localizedLabel": "Data sources"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/license |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$.entities[1]"
      | jsonValues                  |
      | name=DATASOURCE             |
      | type=number                 |
      | localizedLabel=Data sources |


  # 7117061
  @MLP-24153 @regression @positive
  Scenario:SC#21_Verify if lineage transformation  response body has "name": "LINEAGE_PLUGINS", "type": "list" and "localizedLabel": "Lineage Transformations"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/license |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$.entities[0]"
      | jsonValues                             |
      | name=LINEAGE_PLUGINS                   |
      | type=list                              |
      | localizedLabel=Lineage Transformations |



  # 7117063
  @MLP-24153 @regression @positive
  Scenario:SC#22_Verify if user add one data source in entity and count 1 should be increased in currentUsage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                            | body                                         | response code | response message | jsonPath                    |
      | application/json |       |       | Get  | settings/license                               |                                              | 200           | 2                | $.entities[1]..limit        |
      |                  |       |       | Get  | settings/license                               |                                              | 200           | 0                | $.entities[1]..currentUsage |
      |                  |       |       | Put  | settings/credentials/ValidSnowflakeCredentials | idc/LicenseConfigurations/SnowflakeCred.json | 200           |                  |                             |
      |                  |       |       | Get  | settings/credentials/ValidSnowflakeCredentials |                                              | 200           |                  |                             |
      |                  |       |       | Put  | settings/analyzers/SnowflakeDBDataSource       | idc/LicenseConfigurations/SnowflakeDS.json   | 204           |                  |                             |
      |                  |       |       | Get  | settings/analyzers/SnowflakeDBDataSource       |                                              | 200           |                  |                             |
      |                  |       |       | Get  | settings/license                               |                                              | 200           | 1                | $.entities[1]..currentUsage |


  # 7117062 # 7117064
  @MLP-24153 @regression @positive
  Scenario:SC#23_Verify if user remove one data source in entity and count 1 should be decreased in currentUsage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                            | body | response code | response message | jsonPath                    |
      | application/json |       |       | Get    | settings/license                               |      | 200           | 1                | $.entities[1]..currentUsage |
      |                  | raw   | false | Delete | settings/credentials/ValidSnowflakeCredentials |      | 200           |                  |                             |
      |                  |       |       | Delete | settings/analyzers/SnowflakeDBDataSource       |      | 204           |                  |                             |
      |                  |       |       | Get    | settings/license                               |      | 200           | 0                | $.entities[1]..currentUsage |

