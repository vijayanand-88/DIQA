@MLP-18810
Feature:MLP-18810: This feature is to verify Add new attributes to business application item type

  ##6982674##
  @MLP-18810 @regression @positive
  Scenario: SC1#:MLP-18810: Verify if Data Admin User has the permissions "Data_Modify", "Data_Approve", "Data_Tag", "Tag_Create", "Tag_Delete", "Tag_Suggest", "Tag_Approve" and "Base Permission
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message                                           | jsonPath           |
      | application/json |       |       | Get  | roles/DATA_ADMIN |      | 200           | DATA_TAG,TAG_DELETE,BASE_PERMISSION,TAG_CREATE,DATA_MODIFY | $..['permissions'] |


  ##6982672##
  @MLP-18810 @regression @positive
  Scenario: SC2#:MLP-18810:  Verify if Guest User has only the "Base Permission" selected by default and no others permissions should be enabled
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url              | body | response code | response message | jsonPath           |
      | application/json |       |       | Get  | roles/GUEST_USER |      | 200           | BASE_PERMISSION  | $..['permissions'] |


         ##7115861##
  @MLP-24202 @regression @positive
  Scenario: SC3#:MLP-24202:  Verify the New roles listed under Roles sections
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url   | body | response code | response message                                                                                                      | jsonPath    |
      | application/json |       |       | Get  | roles |      | 200           | DATA_ADMIN,GUEST_USER,SYSTEM_ADMIN,BUSINESS_OWNER,TECHNOLOGY_OWNER,RELATIONSHIP_OWNER,SECURITY_OWNER,COMPLIANCE_OWNER | $..['name'] |


     ##7115864##
  @MLP-24202 @regression @positive
  Scenario: SC4#:MLP-24202:  Verify if Business Owner has only the "Base Permission and edit item" selected by default and no others permissions should be enabled
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                  | body | response code | response message                                           | jsonPath           |
      | application/json |       |       | Get  | roles/BUSINESS_OWNER |      | 200           | DATA_MODIFY,TAG_CREATE,BASE_PERMISSION,TAG_DELETE,DATA_TAG | $..['permissions'] |

  ##7115864##
  @MLP-24202 @regression @positive
  Scenario: SC5#:MLP-24202:  Verify if Security Owner has only the "Base Permission and edit item" selected by default and no others permissions should be enabled
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                  | body | response code | response message                                           | jsonPath           |
      | application/json |       |       | Get  | roles/SECURITY_OWNER |      | 200           | DATA_MODIFY,TAG_CREATE,BASE_PERMISSION,TAG_DELETE,DATA_TAG | $..['permissions'] |

    ##7115864##
  @MLP-24202 @regression @positive
  Scenario: SC6#:MLP-24202:  Verify if Technical Owner has only the "Base Permission and edit item" selected by default and no others permissions should be enabled
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                    | body | response code | response message                                           | jsonPath           |
      | application/json |       |       | Get  | roles/TECHNOLOGY_OWNER |      | 200           | DATA_MODIFY,TAG_CREATE,BASE_PERMISSION,TAG_DELETE,DATA_TAG | $..['permissions'] |

    ##7115864##
  @MLP-24202 @regression @positive
  Scenario: SC7#:MLP-24202:  Verify if Compliance Owner has only the "Base Permission and edit item" selected by default and no others permissions should be enabled
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                    | body | response code | response message                                           | jsonPath           |
      | application/json |       |       | Get  | roles/COMPLIANCE_OWNER |      | 200           | DATA_MODIFY,TAG_CREATE,BASE_PERMISSION,TAG_DELETE,DATA_TAG | $..['permissions'] |


    ##7115864##
  @MLP-24202 @regression @positive
  Scenario: SC8#:MLP-24202:  Verify if Relationship Owner has only the "Base Permission and edit item" selected by default and no others permissions should be enabled
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                      | body | response code | response message                                           | jsonPath           |
      | application/json |       |       | Get  | roles/RELATIONSHIP_OWNER |      | 200           | DATA_MODIFY,TAG_CREATE,BASE_PERMISSION,TAG_DELETE,DATA_TAG | $..['permissions'] |


      ##7115865##
  @MLP-24202 @regression @positive
  Scenario: SC9#:MLP-24202:  Verify if the description for the new roles is added or not.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                    | body | response code | response message                                                                                                                                      | jsonPath           |
      | application/json |       |       | Get  | roles/TECHNOLOGY_OWNER |      | 200           | Technology Owner consumes the data and also has contributor rights to give ratings, is able to create and assign tags and edit Business Applications. | $..['description'] |
    