#@MLP-4673
#Feature: MLP-4673 - Verification of services for users and listing

#  @MLP-4673 @regression @positive#descoped
#  Scenario:MLP-4673 Verification of getting usergroups
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url        | body | response code | response message                             | jsonPath      |
#      | application/json |       |       | Get  | usergroups |      | 200           | Data Admins,Guest Users,Policy Admins,System | "$..['local'] |

#  @MLP-4673 @regression @positive#descoped
#  Scenario:MLP-4673 Verification of getting users for usergroups
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url              | body                            | response code | response message                                                                                                                                                | jsonPath     |
#      | application/json |       |       | Post | usergroups/users | idc/MLP_4673_UsergroupName.json | 200           | Saranya Sankar,Thirveni Moganlal,Sivanandam Meiyappaswamy,Divya Bharathi,Bharathi R,Raghavendiran A,Devi Niranjani,Siddharthan Gunaseelan,Sivaprakash Ramasethu | "$..['name'] |
#    And response message contains value ""email" :"
#    And response message contains value ""avatar" :"

#  @MLP-4673 @regression @positive#descoped
#  Scenario:MLP-4673 Verification of clearing the cache usergroups and fetching the usergroups
#    Given  Execute REST API with following parameters
#      | Header           | Query | Param | type   | url              | body | response code | response message                             | jsonPath     |
#      | application/json | raw   | false | Delete | usergroups/cache |      | 204           |                                              |              |
#      |                  |       |       | Get    | usergroups       |      | 200           | Data Admins,Guest Users,Policy Admins,System | $..['local'] |

#  @MLP-4673 @regression @positive#descoped
#  Scenario:MLP-4673 Verification of getting information associated to user groups
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url                           | body | response code | response message                   | jsonPath                        |
#      | application/json |       |       | Get  | usergroups/Development%20Dept |      | 200           | SYSTEM_ADMIN                       | $..[assignedRoles]..[name]      |
#      |                  |       |       | Get  | usergroups/Development%20Dept |      | 200           | DATA_ADMIN,GUEST_USER,SYSTEM_ADMIN | $..['availableRoles']..['name'] |
#
#

