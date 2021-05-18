@MLP-13685
Feature: MLP-13685: As an IDA Admin I want my password to have strength of password so that I have proper security to start

     ##6887768##6887777##
  @MLP-13685 @webtest @login @regression @positive @managedusers @users
  Scenario Outline: SC#1: MLP-13685_Verify if New User can be created using API POST security/managedusers/users and role mapped with API PUT /managedusers/groups
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Create_New_Users.json"
    When user makes a REST Call for POST request with url "/managedusers/users"
    And Status code 204 must be returned
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Map_User_To_Group.json"
    And user makes a REST Call for PUT request with url "/managedusers/groups"
    Then Status code 204 must be returned
    And User launch browser and traverse to login page
    When  User type username as "<username>" and Password as "<password>"
    And user clicks on logout button
    Examples:
      | username      | password     |
      | TestUserNew   | User1!@#$%&* |


     ##6887769##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#2: Verify if updating existing user password is not success for String less than 8 char
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_Less_Eight_Char.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 400 must be returned
    And response message contains value "Input data must contain at least 8 character(s)"
    Examples:
      | username      | password  |
      | TestUserNew   | User1!@   |


     ##6887770##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#3: Verify if updating existing user password is not success for String more than 16 char
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_More_Sixteen_Char.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 400 must be returned
    And response message contains value "Input data must not exceed 16 character(s)"
    Examples:
      | username      | password            |
      | TestUserNew   | UserPassword1!@%&*  |


     ##6887771##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#4: Verify if updating existing user password is not success for String without Capital letter but having >8 to <16 char
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_No_Capital_Char.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 400 must be returned
    And response message contains value "Input data must contain at least 1 upper case letter"
    Examples:
      | username      | password        |
      | TestUserNew   | userpassword1!@ |


     ##6887772##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#5: Verify if updating existing user password is not success for String without lower case letter but having >8 to <16 char
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_No_Lower_Char.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 400 must be returned
    And response message contains value "Input data must contain at least 1 upper case letter"
    Examples:
      | username      | password        |
      | TestUserNew   | USERPASSWORD1!@ |


     ##6887773##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#6: Verify if updating existing user password is not success for String without number but having >8 to <16 char
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_No_Numeric_Char.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 400 must be returned
    And response message contains value "Input data must contain at least 1 digit"
    Examples:
      | username      | password       |
      | TestUserNew   | UserPassword#@ |


     ##6887775##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#7: Verify if updating existing user password is not success for String without reserved special char but having >8 to <16 char
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_No_Special_Char.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 400 must be returned
    And response message contains value "Input data must contain at least 1 special character"
    Examples:
      | username      | password      |
      | TestUserNew   | UserPassword1 |


     ##6887776##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#8: Verify if updating existing user password is success for String with correct format
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Update_User_Password_Correct_Format.json"
    When user makes a REST Call for PUT request with url "managedusers/users/TestUserNew"
    And Status code 204 must be returned
    Examples:
      | username      | password    |
      | TestUserNew   | UserPass1%& |


         ##6887778##
  @MLP-13685 @login @regression @positive @managedusers @users
  Scenario Outline: SC#9: MLP-13685_Verify if New creation of user password is Not success for String with correct format
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDxPayloads/MLP_13685_Create_New_User_Wrong_Format.json"
    When user makes a REST Call for POST request with url "/managedusers/users"
    And Status code 400 must be returned
    And response message contains value "Bad Request"
    When user makes a REST Call for DELETE request with url "managedusers/users/TestUserNew"
    And Status code 204 must be returned
    Examples:
      | username      | password    |
      | TestUserNew   | USER~()++@^ |

