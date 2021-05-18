@MLP-7663
Feature: MLP-7663 JDBC Cataloger Support for Couchbase DB
  Description :To enable JDBC Cataloger for Couchbase

  #6615829#
  @sanity @positive @MLP-7663 @webtest @IDA-10.1
  Scenario: Verify captions and tool tip text in CouchbaseCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "CouchbaseCataloger" plugin config list in Plugin Manager page
    And user add button in "COUCHBASE CATALOGER" section
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | NAME           |
      | PLUGIN VERSION |
      | LABEL          |
      | CATALOG NAME   |
      | PROPERTIES     |
      | HOST           |
      | PORT           |
      | BUCKET FILTERS |
      | USER           |
      | PASSWORD       |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | NAME           | Plugin configuration name                           |
      | PLUGIN VERSION | Required plugin version                             |
      | LABEL          | Plugin configuration extended label and description |
      | CATALOG NAME   | Catalog name                                        |
      | PROPERTIES     | Database connection properties                      |
      | HOST           | Host name                                           |
      | PORT           | Couchbase N1QL port. Default is 8093                |
      | BUCKET FILTERS | Filter on Buckets                                   |
      | USER           | User name                                           |
      | PASSWORD       | User password                                       |



    #6615826#
  @sanity @positive @MLP-7663 @IDA-10.1 @webtest
  Scenario: SC1#MLP_7662_Cassandra db_Create a catalog for Couchbase Cataloger
    Given user connect to the Couch DB database and perform the following operation
      | dataBaseName | operation                 | bucketname   | Id  | queryPath                                    | userName    | passWord        |
      | ClusterName  | createClusterWithDocument | SampleBucket | Key | ida/CouchBasePayloads/multipleDataTypes.json | clusterUser | clusterPassword |
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/CouchBasePayloads/CreateCouchBaseCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "CouchBase" exists in database
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                       |
      |        |       |       | Put          | settings/analyzers/CouchbaseCataloger                                | ida/CouchBasePayloads/CouchbaseWithOutPort.json | 204           |                  |                                                |
      |        |       |       | Get          | settings/analyzers/CouchbaseCataloger                                |                                                 | 200           |                  | CouchBase                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CouchbaseCataloger/* |                                                 | 200           | IDLE             | $.[?(@.configurationName=='CouchBase')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CouchbaseCataloger/*  |                                                 | 200           |                  |                                                |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CouchbaseCataloger/* |                                                 | 200           | IDLE             | $.[?(@.configurationName=='CouchBase')].status |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "BasicFunctionality" catalog and search "" items at top end
    And user select "All" catalog and search "CouchBase" items at top end
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis |
      | Cluster  |
      | Database |
      | Host     |
      | Service  |



    #6615824#
  @sanity @positive @MLP-7663 @webtest @IDA-10.1
  Scenario: Verify the Technology tag appears properly for items collected by CouchbaseCataloger
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName | name     | facet | Tag                       |
#      | CouchBase   | Column     | Type  | Couchbase,NoSQL Databases |
#      | CouchBase   | Table      | Type  | Couchbase,NoSQL Databases |
      | CouchBase   | Cluster  | Type  | Couchbase,NoSQL Databases |
      | CouchBase   | Database | Type  | Couchbase,NoSQL Databases |
      | CouchBase   | Service  | Type  | Couchbase,NoSQL Databases |
#      | CouchBase   | Constraint | Type  | Couchbase,NoSQL Databases |
      | CouchBase   | Host     | Type  | Couchbase,NoSQL Databases |
      | CouchBase   | Analysis | Type  | Couchbase,NoSQL Databases |

#6615837#
  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: Verify CouchbaseCataloger plugin config throws error message in UI if mandatory fields are not passed as input.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "CouchbaseCataloger" plugin config list in Plugin Manager page
    And user add button in "COUCHBASECATALOGER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | CATALOG NAME         |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | HOST                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName     | errorMessage                            |
      | NAME          | Name field should not be empty          |
#      | HOST          | Host field should not be empty          |
#      | KEYSPACE NAME | Catalog name field should not be empty |


