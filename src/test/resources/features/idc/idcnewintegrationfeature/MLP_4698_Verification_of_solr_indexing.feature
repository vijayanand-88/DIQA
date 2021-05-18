#@MLP-4698
#Feature: MLP-4698: This feature is for verifying synchronisation of catalog
#
  #Descoped
#  @MLP-4698 @webtest @positive @regression @solrindexer
#  Scenario:MLP-4698:  Verification of synchronizing the specific catalog via API services
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/SolrCatalog"
#    And supply payload with file name "idc/MLP-4698_CreateCatalog.json"
#    And user makes a REST Call for POST request with url "settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                    |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And supply payload with file name "idc/MLP_4698_Sample.xml"
#    Then user makes a REST Call for POST request with url "import/SolrCatalog" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "SolrCatalog" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "30" items found
#    And user gets the count and item names from UI
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for POST request with url "searches/fulltext/synchronize/SolrCatalog?limit=0&maxSeconds=0&hoursUntilNext=48"
#    And Status code 200 must be returned
#    And user clicks on notification icon in the left panel
#    And "Solr documents are synchronized !" notification should have content "SolrCatalog catalog(s) documents are synchronized in Solr" in the notifications tab
#    And user clicks on logout button
#    Then compare the count between UI and solr
#      | queryName             | filterQuery |
#      | catalog_s:SolrCatalog |             |
#
#
#  @MLP-4698 @webtest @positive @regression @solrindexer
#  Scenario:MLP-4698:  Verification of clearing the synchronization in solr Via API services for specific Catalog
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "searches/fulltext/synchronize/SolrCatalog?limit=0&maxSeconds=0&hoursUntilNext=48"
#    And Status code 200 must be returned
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "SolrCatalog" catalog from catalog list
#    And user clicks on search icon
#    And user gets the count and item names from UI
#    Then configure a new REST API for the service "IDC"
#    And user clicks on notification icon in the left panel
#    And "Solr documents are cleared !" notification should have content "SolrCatalog catalog(s) documents are cleared in Solr" in the notifications tab
#    And user clicks on logout button
#    And compare the count between UI and solr
#      | queryName             | filterQuery |
#      | catalog_s:SolrCatalog |             |
#
#  @MLP-4698 @webtest @positive @regression @solrindexer
#  Scenario:MLP-4698:  Verification of clearing the synchronization in solr for all catalog via API Services
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "searches/fulltext/synchronize?doReset=false"
#    And Status code 200 must be returned
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on search icon
#    And user gets the count and item names from UI
#    And user clicks on notification icon in the left panel
#    And "Solr documents are cleared !" notification should have content "* catalog(s) documents are cleared in Solr" in the notifications tab
#    And user clicks on logout button
#    And compare the count between UI and solr
#      | queryName | filterQuery |
#      |           |             |
#
#
#  @MLP-4698 @webtest @positive @regression @solrindexer
#  Scenario:MLP-4698:  Verification of synchronizing the all catalog via API services
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for POST request with url "searches/fulltext/synchronize?limit=0&maxSeconds=0&hoursUntilNext=48"
#    And Status code 200 must be returned
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    And "Solr documents are synchronized !" notification should have content "* catalog(s) documents are synchronized in Solr" in the notifications tab
#    And user selects "All" catalog from catalog list
#    And user clicks on search icon
#    And user gets the count and item names from UI
#    And user clicks on logout button
#    And compare the count between UI and solr
#      | queryName         | filterQuery            |
#      | -catalog_s:"root" | -catalog_s:"sqlg_solr" |
#
#
#
#
#
