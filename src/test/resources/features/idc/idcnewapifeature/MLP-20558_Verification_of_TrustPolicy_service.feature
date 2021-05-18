@MLP-20558
Feature: MLP-20558: This feature is for verifying TrustPolicy service

    ##7034883##
  @MLP-20558  @regression @positive
  Scenario:SC1#:Verify the list for rules for BusinessApplication by passing itemtype as BusinessApplication with endpoint GET/policy/trust/rules using swaggger-ui
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | /policy/trust/rules?itemtype=BusinessApplication |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$..['label']"
      | jsonValues           |
      | Business Owner       |
      | Authoritative Source |
      | Business Criticality |
      | Data Classification  |
      | PII                  |
      | Linked Items         |
      | Data Quality         |
      | Capture              |
      | Lineage              |

    ##7034884##
  @MLP-20558  @regression @positive
  Scenario:SC2#:Verify the itemtypes for enabled itemtypes using GET/Policy/Trust/Itemtypes
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                    | body | response code | response message | jsonPath            |
      | application/json |       |       | Get  | policy/trust/itemtypes |      | 200           |                  | BusinessApplication |

    ##7034885##
  @MLP-20558  @regression @positive
  Scenario:SC3#: Verify the add rules for Table by passing itemtype as Table with endpoint PUT/policy/trust/rules using swaggger-ui with existing json
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                               | body                          | response code | response message | jsonPath       |
      | application/json |       |       | Put  | policy/trust/rules?itemtype=Table | idc\MLP-20558_TablesEdit.json | 204           |                  |                |
      |                  |       |       | Get  | policy/trust/rules?itemtype=Table |                               | 200           |                  | TechnologyTAGS |

    ##7034886##
  @MLP-20558  @regression @positive
  Scenario:SC4#: Verify the add rules for BusinessApplication by passing itemtype as BusinessApplication with endpoint PUT/policy/trust/rules using swaggger-ui with existing json
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                             | body                                       | response code | response message | jsonPath     |
      | application/json |       |       | Put  | policy/trust/rules?itemtype=BusinessApplication | idc\MLP-20558_BusinessApplicationEdit.json | 204           |                  |              |
      |                  |       |       | Get  | policy/trust/rules?itemtype=BusinessApplication |                                            | 200           |                  | Relationship |

      ##6778220##
  @MLP-20558  @regression @positive
  Scenario:SC5#: To Modify the existing json for table type using PUT/policy/Trust/rules using swagger-ui
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                               | body                          | response code | response message | jsonPath |
      | application/json |       |       | Put  | policy/trust/rules?itemtype=Table | idc\MLP-20558_TablesEdit.json | 204           |                  |          |
      |                  |       |       | Get  | policy/trust/rules?itemtype=Table |                               | 200           |                  |          |


        ##7034887##
  @MLP-20558  @regression @positive
  Scenario:SC6#:To Modify the existing json for  BusinessApplication type using PUT/policy/Trust/rules using swagger-ui
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                                             | body                                       | response code | response message | jsonPath |
      | application/json |       |       | Put  | policy/trust/rules?itemtype=BusinessApplication | idc\MLP-20558_BusinessApplicationEdit.json | 204           |                  |          |
      |                  |       |       | Get  | policy/trust/rules?itemtype=BusinessApplication |                                            | 200           |                  |          |


          ##7034888##
  @MLP-20558  @regression @positive
  Scenario:SC7#: Verify the list of Item types used for trust caluclations Factor by using GET/Policy/Trust/Scheme using swagger-ui
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                 | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | policy/trust/scheme |      | 200           |                  |          |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | itemtypes   |
      | factors     |
      | weight      |
      | filterValue |
      | dimensions  |

      ##7040036##
  @MLP-20558  @regression @positive
  Scenario:SC8#: Verify the DELETE request  of Item types not configured for Trust enabled itemtypes
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | policy/trust/itemtype?itemtype=Column |      | 400           |                  |          |


    ##7040037##
  @MLP-20558  @regression @positive
  Scenario: SC9#:Verify the DELETE request  of Item types for Table configured for Trust enabled itemtypes
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | policy/trust/itemtype?itemtype=Table |      | 204           |                  |          |


    ##7040041##
  @MLP-20558  @regression @positive
  Scenario:SC10#: Verify the DELETE request  of Item types for BusinessApplication configured for Trust enabled itemtypes
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | policy/trust/itemtype?itemtype=BusinessApplication |      | 204           |                  |          |

  ##7034886####7034886##
  Scenario:SC11#: Verify the add the default rules for BusinessApplication
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                             | body                                        | response code | response message | jsonPath |
      | application/json |       |       | Put  | policy/trust/rules?itemtype=BusinessApplication | idc\MLP-20558_BusinessApplicationTrust.json | 204           |                  |          |
      |                  |       |       | Get  | policy/trust/rules?itemtype=BusinessApplication |                                             | 200           |                  |          |