#@MLP-2019
#  Feature: MLP_2019_Export BigData Hive items that are tagged as PII
#
#    @positive @MLP-2019 @webtest
#    Scenario: MLP-2019 Verification Export BigData Hive items that are tagged as PII for POST service with no zoneId
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator" role
#      And login must be successful for all users
#      And user enters the search text "employees_full" and clicks on search
#      And user click on item "titleofcourtesy" in Tag Column and assign "Trustworthy" tag to the item.
#      And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#        | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#        | Content-Type  | application/octet-stream           |
#        | Accept        | application/octet-stream           |
#      And user makes a REST Call for POST request with url "export/hive/BigData?xmlFileOutput=PIIItems.xml"
#      And Status code 200 must be returned
#      And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "PIIItems.xml"
#      Then xml nodes in "exporthiveitemsPIItags\PIIItems.xml" file and "PIIItems.xml" should be same except "timestamp" node
#      And user enters the search text "employees_full" and clicks on search
#      And user click on item "titleofcourtesy" in Tag Column and assign "Social Security Number" tag to the item.
#      And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#        | Content-Type  | application/octet-stream           |
#        | Accept        | application/octet-stream           |
#      And user makes a REST Call for POST request with url "export/hive/BigData?xmlFileOutput=PIIItems.xml"
#      And Status code 200 must be returned
#      And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "PIIItems.xml"
#      Then xml nodes in "exporthiveitemsPIItags\PIIItemsWithoutZoneID.xml" file and "PIIItems.xml" should not be same
#      And user unassign "Social Security Number" tag from item "titleofcourtesy"
#      And user unassign "Trustworthy" tag from item "titleofcourtesy"
#
#    @positive @MLP-2019 @webtest
#    Scenario:  MLP-2019 Verification of Export BigData Hive items that are tagged as PII for POST service
#      Given User launch browser and traverse to login page
#      When user enter credentials for "System Administrator" role
#      And login must be successful for all users
#      And user enters the search text "employees_full" and clicks on search
#      And user click on item "titleofcourtesy" in Tag Column and assign "Trustworthy" tag to the item.
#      And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#        | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#        | Content-Type  | application/octet-stream           |
#        | Accept        | application/octet-stream           |
#      And user makes a REST Call for POST request with url "export/hive/BigData?zoneId=Asia%2FKolkata&xmlFileOutput=PIIItems.xml"
#      And Status code 200 must be returned
#      And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "PIIItems.xml"
#      Then xml nodes in "exporthiveitemsPIItags\PIIItems.xml" file and "PIIItems.xml" should be same except "timestamp" node
#      And user enters the search text "employees_full" and clicks on search
#      And user click on item "titleofcourtesy" in Tag Column and assign "Social Security Number" tag to the item.
#      And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#        | Content-Type  | application/octet-stream           |
#        | Accept        | application/octet-stream           |
#      And user makes a REST Call for POST request with url "export/hive/BigData?zoneId=Asia%2FKolkata&xmlFileOutput=PIIItems.xml"
#      And Status code 200 must be returned
#      And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "PIIItems.xml"
#      Then xml nodes in "exporthiveitemsPIItags\PIIItemsWithoutZoneID.xml" file and "PIIItems.xml" should not be same
#      And user unassign "Social Security Number" tag from item "titleofcourtesy"
#      And user unassign "Trustworthy" tag from item "titleofcourtesy"
#
#    @Negative @MLP-2019
#    Scenario:  MLP-2019 Verification of Export BigData Hive items that are tagged as PII for POST service with incorrect catalog name
#      Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#        | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#        | Content-Type  | application/octet-stream           |
#        | Accept        | application/octet-stream           |
#      And user makes a REST Call for POST request with url "export/hive/BigDatas?xmlFileOutput=PIIItems.xml"
#      Then Status code 404 must be returned
#
#    @Negative @MLP-2019
#    Scenario:  MLP-2019 Verification of Export BigData Hive items that are tagged as PII for POST service with incorrect catalog name
#      Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#        | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#        | Content-Type  | application/octet-stream           |
#        | Accept        | application/octet-stream           |
#      And user makes a REST Call for Get request with url "export/hive/BigDatas?xmlFileOutput=PIIItems.xml"
#      Then Status code 404 must be returned