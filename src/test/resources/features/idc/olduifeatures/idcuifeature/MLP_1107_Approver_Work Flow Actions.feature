@MLP-1107
Feature:MLP-1107 As an approver I can open the appropriated panel and execute WF actions
  #Author: Venkata Sai

  @MLP-1107 @webtest @workflow @regression @positive
  Scenario:Verification of creating a tag as a Information user and approving as an Administrator and verifying the notification for Information user
    Given user deletes primary key constraint for deleting tag "QAAUTOMATION TAG"
    And user deletes the created tag "QAAUTOMATION TAG"
    And User launch browser and traverse to login page
    And  user enter credentials for "Information User" role
    And user selects "BigData" catalog from catalog list
    And  user enters the search text for adding a comment and clicks on search in Subject Area page
    And user clicks on search icon
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user click on create new tag in the Add tags panel
    And user enters tag details and click save
    And the newly created tag is displayed as "SUGGESTED" under Assigned tag section
    And user clicks on the Save button in the Assign/UnAssign panel
#    And user clicks on notification icon
#    Then "Tag QAAUTOMATION TAG suggested" notification should get displyed in the notifications tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And  user enter credentials for "System Administrator1" role
    And user clicks on notification icon
    And user opens the notification cotaining "Tag QAAUTOMATION TAG suggested"
    And Approval Required,Status information,Created by,Created at, Modified by, Modified at,There are no comments yet labels are is displayed
#    And user clicks on Add Comments button
#    And user should be able to add a comment
#    And comments should be added to the newly created tag
#    And user clicks on close button
    And user "APPROVE" the suggested tag
    And user clicks on home button
    And user clicks on notification icon in the left panel
    Then "Tag QAAUTOMATION TAG APPROVED!" notification should get displyed in the notifications tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And  user enter credentials for "Information User" role
    When user clicks on notification icon in the left panel
    Then "Tag QAAUTOMATION TAG APPROVED!" notification should get displyed in the notifications tab
    And user clicks on logout button

  @MLP-1107 @webtest @workflow @regression @positive
  Scenario:Verification of creating a tag as a Information user and rejecting as an Administrator and verifying the notification for Information user
    Given user deletes primary key constraint for deleting tag "QAAUTOMATION TAG"
    And user deletes the created tag "QAAUTOMATION TAG"
    And User launch browser and traverse to login page
    And  user enter credentials for "Information User" role
    And user selects "BigData" catalog from catalog list
    And  user enters the search text for adding a comment and clicks on search in Subject Area page
    And user clicks on search icon
    And user clicks on the number of tags displayed
   When user clicks on create button on the Assign/UnAssign panel
    And user click on create new tag in the Add tags panel
    And user enters tag details and click save
    And the newly created tag is displayed as "SUGGESTED" under Assigned tag section
    And user clicks on the Save button in the Assign/UnAssign panel
    And user clicks on notification icon
    Then "Tag QAAUTOMATION TAG suggested" notification should get displyed in the notifications tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And  user enter credentials for "System Administrator1" role
    And user clicks on notification icon
    And user opens the notification cotaining "Tag QAAUTOMATION TAG suggested"
    And Approval Required,Status information,Created by,Created at, Modified by, Modified at,There are no comments yet labels are is displayed
#    And user clicks on Add Comments button
#    And user should be able to add a comment
#    And comments should be added to the newly created tag
#    And user clicks on close button
    And user "REJECT" the suggested tag
    And user clicks on home button
    And user clicks on notification icon in the left panel
    Then "Tag QAAUTOMATION TAG DELETED!" notification should get displyed in the notifications tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And  user enter credentials for "Information User" role
    When user clicks on notification icon in the left panel
    Then "Tag QAAUTOMATION TAG DELETED!" notification should get displyed in the notifications tab
    And user clicks on logout button

  @MLP-1107 @webtest @workflow @regression  @positive
  Scenario:MLP-1107 Verification of approving option for second approver
    Given user deletes primary key constraint for deleting tag "QAAUTOMATION TAG"
    And user deletes the created tag "QAAUTOMATION TAG"
    And User launch browser and traverse to login page
    And  user enter credentials for "Information User" role
    And user selects "BigData" catalog from catalog list
    And  user enters the search text for adding a comment and clicks on search in Subject Area page
    And user clicks on search icon
    And user clicks on the number of tags displayed
   When user clicks on create button on the Assign/UnAssign panel
    And user click on create new tag in the Add tags panel
    And user enters tag details and click save
    And the newly created tag is displayed as "SUGGESTED" under Assigned tag section
    And user clicks on the Save button in the Assign/UnAssign panel
    And user clicks on notification icon
    Then "Tag QAAUTOMATION TAG suggested" notification should get displyed in the notifications tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    And  user enter credentials for "System Administrator1" role
    And user clicks on notification icon
    And user opens the notification cotaining "Tag QAAUTOMATION TAG suggested"
    And Approval Required,Status information,Created by,Created at, Modified by, Modified at,There are no comments yet labels are is displayed
#    And user clicks on Add Comments button
#    And user should be able to add a comment
#    And comments should be added to the newly created tag
#    And user clicks on close button
    And user "APPROVE" the suggested tag
    And user clicks on home button
    And user clicks on notification icon in the left panel
    Then "Tag QAAUTOMATION TAG APPROVED!" notification should get displyed in the notifications tab
    And user clicks on logout button
    And user clicks on sign in as a different user link
    Given User launch browser and traverse to login page
    And  user enter credentials for "Data Administrator" role
    And user clicks on notification icon in the left panel
    And user opens the notification cotaining "Tag QAAUTOMATION TAG Approved!"
    Then Accept/Reject button should not be displayed for already approved/rejected tags.
    And user clicks on logout button


