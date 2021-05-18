#Feature: MLP-1101 - Inform about deleted data
#
#  @webtest
#  Scenario: Verification of Item Created Notification
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_Verification_of_Item_Created_Notification.json"
#    And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemCreatedEvent"
#    When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_Item_Creation.json"
#    And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    Then user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    Then Item created should be displayed in notifications
#    And user makes a REST Call for DELETE request for the catalogid.
#
#    @webtest
#    Scenario: Verification of Item Updated Notification
#      Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#      And supply payload with file name "idc/MLP-1101_ItemUpdateEvent.json"
#      And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemUpdatedEvent"
#      When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#      And Status code 204 must be returned
#      And configure a new REST API for the service "IDC"
#      And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#      And supply payload with file name "idc/MLP-1101_Item_Updation.json"
#      And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#      And user makes a REST Call for PUT request with update url
#      And User launch browser and traverse to login page
#      Then user enter credentials for "System Administrator" role
#      And user clicks on notification icon in the left panel
#      Then Item created should be displayed in notifications
#      And user makes a REST Call for DELETE request for the catalogid.
#
#  @webtest
#  Scenario: Verification of Item Deleted Notification
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_Item-Deleted_Event.json"
#    And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemDeletedEvent"
#    When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_Item_Creation.json"
#    And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#    And user makes a REST call for DELETE to delete the catalog created.
#    And User launch browser and traverse to login page
#    Then user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    Then Item created should be displayed in notifications
#    And user makes a REST Call for DELETE request for the catalogid.
#
#  @webtest
#  Scenario: Verification of multiple Item Created Notification
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_MultipleItemCreatedEvent.json"
#    And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemsCreatedEvent"
#    When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_MultipleItemCreation.json"
#    And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    Then user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    Then Notification should display "2 items has been created in area" in IDC UI.
#    And user makes a REST Call for DELETE request for the catalogid.
#
#  @webtest
#  Scenario: Verification of Mutliple Items Updated Notification
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_MultipleItemUpdatedEvent.json"
#    And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemsUpdatedEvent"
#    When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_MultipleItemUpdation.json"
#    And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#    And user makes a REST Call for PUT request with update url
#    And User launch browser and traverse to login page
#    Then user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    Then Item created should be displayed in notifications
#    And user makes a REST Call for DELETE request for the catalogid.
#
#  @webtest
#  Scenario: Verification of Multiple Item Deleted Notification
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemsDeletedEvent"
#    And supply payload with file name "idc/MLP-1101_Multiple_Item_Deleted_Event.json"
#    When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_MultipleItemCreation.json"
#    And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_Multiple_Item_Deleted_Event.json"
#    And user makes a REST call for POST with url "items/BigData/delete" and body to delete the catalog created.
#    And User launch browser and traverse to login page
#    Then user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    Then Notification should display "2 items has been deleted in area" in IDC UI.
#
#  @webtest
#  Scenario: Verification of Items Deleted Notification with childitem count
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/notifications/definitions/ItemsDeletedEvent"
#    And supply payload with file name "idc/MLP-1101_MultipleItemDeletedEventwithChildItemCount.json"
#    When user makes a REST Call for PUT request with url "settings/notifications/definitions"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1101_Item_Creation.json"
#    And user makes a REST Call for POST request with url "items/BigData/root" and store the response
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP-1101_MultipleItemCreation.json"
#    And user makes a REST Call for POST request with url "items/BigData/" and add the scope id to path
#    And supply payload with file name "idc/MLP-1101_MultipleItemDeletedEventwithChildItemCount.json"
#    And user makes a REST call for POST with url "items/BigData/delete" and body to delete the catalog created.
#    And User launch browser and traverse to login page
#    Then user enter credentials for "System Administrator" role
#    And user clicks on notification icon in the left panel
#    Then Notification should display "1 item and 2 child items has been deleted in area" in IDC UI.