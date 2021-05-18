Feature: MLP-25511_Dashboard widget for licensed entities
  MLP-26032_Used color code in Dashboard License chart widget


  ## 7149825 ##  ## 7149826 ## ## 7167797 ## # 7196313
  @MLP-25511 @MLP-27932 @positive @regression @webtest
  Scenario:MLP-25511:MLP-27932_SC#1_Verify User is able to view Licence Widget in the dashboard only for ADMIN_SECURITY permission.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "verifies widgets" in "Dashboard Page"
      | fieldName     |
      | License Usage |
    And user "Verify Label presence" in "Dashboard Page"
      | fieldName     | actionItem              | itemName           |
      | License Usage | Lineage Transformations |                    |
      | License Usage | Data sources            |                    |
      | License Usage | Limit                   |                    |
      | License Usage | Limit Color             | rgb(170, 2, 2)     |
      | License Usage | Used                    |                    |
      | License Usage | Used Color              | rgb(148, 217, 155) |


    ## 7149827 ## ## 7149828 ## ## 7167796
  @MLP-25511 @positive @regression
  Scenario:MLP-25511:SC#2_Verify user is able to view same limit should be displayed in both Lineage limit and Data Sources Limit in the License Usage chart
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body | response code | response message | jsonPath                              |
      | application/json |       |       | Get  | settings/license   |      | 200           |                  |                                       |
      |                  |       |       | Get  | settings/license   |      | 200           | 10               | $.entities[1]..limit                  |
      |                  |       |       | Get  | dashboards/widgets |      | 200           | 0                | $..widgetData.data[0].series[0].value |
      |                  |       |       | Get  | dashboards/widgets |      | 200           | 10               | $..widgetData.data[1].series[0].value |


  ## 7149832 ##  ## 7149829 ##
  @MLP-25511 @positive @regression
  Scenario:MLP-25511:SC#3_Verify if user add one data source configuration in entity and count 1 should be increased in the License Usage chart
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                                      | response code | response message | jsonPath                              |
      | application/json |       |       | Get  | settings/license                          |                                           | 200           | 0                | $.entities[1]..currentUsage           |
      |                  |       |       | Get  | dashboards/widgets                        |                                           | 200           | 0                | $..widgetData.data[1].series[1].value |
      |                  |       |       | Put  | settings/credentials/GitCredentials       | idc/LicenseConfigurations/GitCred.json    | 200           |                  |                                       |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource | idc/LicenseConfigurations/GitDS.json      | 204           |                  |                                       |
      |                  |       |       | Get  | dashboards/widgets                        |                                           | 200           | 1                | $..widgetData.data[1].series[1].value |
      |                  |       |       | Put  | settings/credentials/OracleCredentials    | idc/LicenseConfigurations/OracleCred.json | 200           |                  |                                       |
      |                  |       |       | Put  | settings/analyzers/OracleDBDataSource     | idc/LicenseConfigurations/OracleDS.json   | 204           |                  |                                       |
      |                  |       |       | Get  | settings/license                          |                                           | 200           | 2                | $.entities[1]..currentUsage           |
      |                  |       |       | Get  | dashboards/widgets                        |                                           | 200           | 2                | $..widgetData.data[1].series[1].value |


    ## 7149833 ##
  @MLP-25511 @positive @regression
  Scenario:MLP-25511:SC#4_Verify if user remove one data source configuration in entity and count 1 should be decreased in the License Usage chart
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                    | body | response code | response message | jsonPath                              |
      | application/json | raw   | false | Get    | settings/license                       |      | 200           | 2                | $.entities[1]..currentUsage           |
      |                  |       |       | Get    | dashboards/widgets                     |      | 200           | 2                | $..widgetData.data[1].series[1].value |
      |                  |       |       | Delete | settings/analyzers/OracleDBDataSource  |      | 204           |                  |                                       |
      |                  |       |       | Delete | settings/credentials/OracleCredentials |      | 200           |                  |                                       |
      |                  |       |       | Get    | settings/license                       |      | 200           | 1                | $.entities[1]..currentUsage           |
      |                  |       |       | Get    | dashboards/widgets                     |      | 200           | 1                | $..widgetData.data[1].series[1].value |


    ## 7149834 ##  ## 7149831 ##
  @MLP-25511 @positive @regression
  Scenario:MLP-25511:SC#5_Verify if user add one lineage configuration in entity and count 1 should be increased in the License Usage chart
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                    | response code | response message | jsonPath                              |
      | application/json |       |       | Put  | settings/license                      | idc/LicenseConfigurations/MLP-25511_License Config.json | 204           |                  |                                       |
      |                  |       |       | Get  | dashboards/widgets                    |                                                         | 200           | 2                | $..widgetData.data[0].series[0].value |
      |                  |       |       | Get  | dashboards/widgets                    |                                                         | 200           | 0                | $..widgetData.data[0].series[1].value |
      |                  |       |       | Put  | settings/analyzers/PythonSparkLineage | idc/LicenseConfigurations/PythonSparkLineage.json       | 204           |                  |                                       |
      |                  |       |       | Get  | dashboards/widgets                    |                                                         | 200           | 1                | $..widgetData.data[0].series[1].value |
      |                  |       |       | Put  | settings/analyzers/PythonSQLLineage   | idc/LicenseConfigurations/PythonSQLLineage.json         | 204           |                  |                                       |
      |                  |       |       | Get  | dashboards/widgets                    |                                                         | 200           | 2                | $..widgetData.data[0].series[1].value |


 ## 7149836 ##
  @MLP-25511 @positive @regression
  Scenario:MLP-25511:SC#6_Verify if user remove one lineage configuration in entity and count 1 should be decreased in the License Usage chart
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath                              |
      | application/json |       |       | Get    | dashboards/widgets                    |      | 200           | 2                | $..widgetData.data[0].series[0].value |
      |                  |       |       | Get    | dashboards/widgets                    |      | 200           | 2                | $..widgetData.data[0].series[1].value |
      |                  |       |       | Delete | settings/analyzers/PythonSparkLineage |      | 204           |                  |                                       |
      |                  |       |       | Get    | dashboards/widgets                    |      | 200           | 1                | $..widgetData.data[0].series[1].value |


  ## 7149839 ##
  @MLP-25511 @positive @regression
  Scenario:MLP-25511:SC#7_Verify if user increase the data source limit in the entity and limit should be increased in the License usage chart
    Given user "update" the json file "idc/LicenseConfigurations/MLP-25511_License Config.json" file for following values
      | jsonPath            | jsonValues | type    |
      | $.entities[1].limit | 15         | Integer |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                                    | response code | response message | jsonPath                              |
      | application/json |       |       | Put  | settings/license   | idc/LicenseConfigurations/MLP-25511_License Config.json | 204           |                  |                                       |
      |                  |       |       | Get  | settings/license   |                                                         | 200           | 15               | $.entities[1]..limit                  |
      |                  |       |       | Get  | dashboards/widgets |                                                         | 200           | 15               | $..widgetData.data[1].series[0].value |


    ## 7149840 ##
  @MLP-25511 @positive @regression @webtest
  Scenario:MLP-25511:SC#8_Verify if user increase the lineage plugin limit in the entity and limit should be increased in the License usage chart
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                                      | response code | response message | jsonPath                              |
      | application/json |       |       | Put  | settings/license   | idc/LicenseConfigurations/MLP-25511_License Config_2.json | 204           |                  |                                       |
      |                  |       |       | Get  | settings/license   |                                                           | 200           |                  |                                       |
      |                  |       |       | Get  | dashboards/widgets |                                                           | 200           | 3                | $..widgetData.data[0].series[0].value |


   ## 7155357 ## ## 7155358 ##  ## 7155359 ##
  @MLP-25511 @positive @regression @webtest
  Scenario:MLP-25511:SC#9_Verify if user can able to view Title and Description label in the Configure dashboard widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget settings Icon" for "License Usage" in "Dashboard page"
    And user "Verify Label presence" in "Dashboard Page"
      | fieldName   |
      | Title       |
      | Description |
    And user "Enter Value in Dashboard Config" in "Dashboard Page"
      | fieldName | actionItem |
      | Title     | L          |
    And user press "BACK_SPACE" key using key press event
    And user "Enter Value in Dashboard Config" in "Dashboard Page"
      | fieldName     | actionItem         |
      | Error Message | Title is mandatory |
    And user verifies "Save Button" is "disabled" in "Dashboard Page"
    And user "click" on "Cancel button" button in "Widget edit page"


  @MLP-26032 @positive @regression
  Scenario Outline:MLP-26032:SC#10_Create DataSources for Validation
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                               | bodyFile                                               | path       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource1 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_1 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource2 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_2 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource3 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_3 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource4 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_4 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource5 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_5 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource6 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_6 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource7 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_7 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource8 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_8 | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource9 | payloads/idc/LicenseConfigurations/GitBulkConfigs.json | $.Config_9 | 204           |                  |          |


     ## 7167800 ##
  @MLP-26032 @positive @regression @webtest
  Scenario:MLP-26032:SC#11_Verify if user is able to view Color code red if >99 percentage for Data Source Usage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body | response code | response message | jsonPath                              |
      | application/json |       |       | Get  | dashboards/widgets |      | 200           | 10               | $..widgetData.data[1].series[0].value |
      |                  |       |       | Get  | dashboards/widgets |      | 200           | 10               | $..widgetData.data[1].series[1].value |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "Verify License Widget" in "Dashboard Page"
      | fieldName     | actionItem            | itemName       |
      | License Usage | DataSource Color code | rgb(255, 0, 0) |


   ## 7167799 ##
  @MLP-26032 @positive @regression @webtest
  Scenario:MLP-26032:SC#12_Verify if user is able to view Color code yellow when >=90 <100 percentage for Data Source Usage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                               | body | response code | response message | jsonPath                              |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource9 |      | 204           |                  |                                       |
      |                  |       |       | Get    | dashboards/widgets                                                |      | 200           | 10               | $..widgetData.data[1].series[0].value |
      |                  |       |       | Get    | dashboards/widgets                                                |      | 200           | 9                | $..widgetData.data[1].series[1].value |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "Verify License Widget" in "Dashboard Page"
      | fieldName     | actionItem            | itemName          |
      | License Usage | DataSource Color code | rgb(232, 199, 40) |


    ## 7167798 ##
  @MLP-26032 @positive @regression @webtest
  Scenario:MLP-26032:SC#13_Verify if user is able to view Color code green when chart bar if < 90 percentage for Data Source Usage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                               | body | response code | response message | jsonPath                              |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource8 |      | 204           |                  |                                       |
      |                  |       |       | Get    | dashboards/widgets                                                |      | 200           | 10               | $..widgetData.data[1].series[0].value |
      |                  |       |       | Get    | dashboards/widgets                                                |      | 200           | 8                | $..widgetData.data[1].series[1].value |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "Verify License Widget" in "Dashboard Page"
      | fieldName     | actionItem            | itemName           |
      | License Usage | DataSource Color code | rgb(148, 217, 155) |


  @MLP-26032 @positive @regression
  Scenario Outline:MLP-26032:SC#14_Delete Created DataSources for Validation
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                               | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource1 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource2 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource3 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource4 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource5 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource6 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSource7 |          |      | 204           |                  |          |


   ## 7169326 ##
  @MLP-26032 @positive @regression @webtest
  Scenario:MLP-26032:SC#15_Verify if user is able to view Color code green when chart bar if < 90 percentage for Lineage Transformations Usage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body | response code | response message | jsonPath                              |
      | application/json |       |       | Get  | dashboards/widgets |      | 200           | 3                | $..widgetData.data[0].series[0].value |
      |                  |       |       | Get  | dashboards/widgets |      | 200           | 1                | $..widgetData.data[0].series[1].value |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "Verify License Widget" in "Dashboard Page"
      | fieldName     | actionItem         | itemName           |
      | License Usage | Lineage Color code | rgb(148, 217, 155) |


    ## 7169351 ##
  @MLP-26032 @positive @regression @webtest
  Scenario:MLP-26032:SC#16_Verify if user is able to view Color code red if >99 percentage for Lineage Transformations Usage
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                      | body                                              | response code | response message | jsonPath                              |
      | application/json |       |       | Put  | settings/analyzers/PythonSparkLineage    | idc/LicenseConfigurations/PythonSparkLineage.json | 204           |                  |                                       |
      |                  |       |       | Put  | settings/analyzers/OracleDBPostProcessor | idc/LicenseConfigurations/OracleDBPP.json         | 204           |                  |                                       |
      |                  |       |       | Get  | dashboards/widgets                       |                                                   | 200           | 3                | $..widgetData.data[0].series[0].value |
      |                  |       |       | Get  | dashboards/widgets                       |                                                   | 200           | 3                | $..widgetData.data[0].series[1].value |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "Verify License Widget" in "Dashboard Page"
      | fieldName     | actionItem         | itemName       |
      | License Usage | Lineage Color code | rgb(255, 0, 0) |


  ## 7155356 ##
  @MLP-25511 @positive @regression @webtest
  Scenario:MLP-25511:SC#17_Verify user can able to edit title and description of License Usage widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget settings Icon" for "License Usage" in "Dashboard page"
    And user "Enter Value in Dashboard Config" in "Dashboard Page"
      | fieldName   | actionItem                   |
      | Title       | License Chart                |
      | Description | To used for License entities |
    And user "click" on "SAVE" button in "Widget edit page"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user refreshes the application
    And user "verifies widgets" in "Dashboard Page"
      | fieldName     |
      | License Chart |


      ## 7155354 ##
  @MLP-25511 @positive @regression @webtest
  Scenario:MLP-25511:SC#18_Verify if user can able to delete License Usage widget
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" on "Widget Remove Icon" for "License Chart" in "Dashboard page"
    And user verifies the "Delete Widget" pop up is "displayed"
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user "verifies widgets absence" in "Dashboard Page"
      | fieldName     |
      | License Chart |


  ## 7155355 ##
  @MLP-25511 @positive @regression @webtest
  Scenario:MLP-25511:SC#19_Verify user can able to add the License Usage widget using dashboard settings
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Dashboard" in "Landing page"
    And user "click" on "Dashboard page Icons" for "Configure" in "Landing page"
    And user "click" in "Landing Page"
      | fieldName                   | actionItem         | itemName      |
      | Select preconfigured Widget | Target Bar Widgets | License Usage |
    And user "click" on "Dashboard toolbar Icon" for "Save Dashboard" in "Landing page"
    And user refreshes the application
    And user "verifies widgets" in "Dashboard Page"
      | fieldName     |
      | License Usage |


  @MLP-26032 @positive @regression
  Scenario Outline:MLP-26032:SC#20_Delete Created Lineage Configuartions for Validation
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                      | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSparkLineage    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PythonSQLLineage      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBPostProcessor |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/GitCredentials      |          |      | 200           |                  |          |
