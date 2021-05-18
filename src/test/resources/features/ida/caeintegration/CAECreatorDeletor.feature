@MLP-26968
Feature:To validate the CAE Entry point Creation/Deletion scenarios


  Scenario Outline:SC1#Verify user is able to create an Entry point using CAE Creator plugin in DD with overwrite option disabled in configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile                                         | path                                      | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/EntryPointServerCredential                            | payloads/ida/CAECreatorDeletor/credentials.json  | $.CAEServer                               | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/EntryPointServerCredential                            |                                                  |                                           | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDataSource                                           | payloads/ida/CAECreatorDeletor/datasource.json   | $.CAEDataSource                           | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDataSource                                           |                                                  |                                           | 200           | CreatorDS        |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreator/CreateEntryPoint                             | payloads/ida/CAECreatorDeletor/pluginconfig.json | $.caeCreatorOverWriteFalse.configurations | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreator/CreateEntryPoint                             |                                                  |                                           | 200           | CreateEntryPoint |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/Headless-EDI                                   |                                                  |                                           | 200           | UP               | $.nodeStatus                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreator/CreateEntryPoint |                                                  |                                           | 200           | IDLE             | $.[?(@.configurationName=='CreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreator/CreateEntryPoint  |                                                  |                                           | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreator/CreateEntryPoint |                                                  |                                           | 200           | IDLE             | $.[?(@.configurationName=='CreateEntryPoint')].status |


  Scenario:SC1#Verify CAE Creator analysis log info when parameter overwrite is false in configuration
    Given Analysis log "other/CAECreator/CreateEntryPoint%" should display below info/error/warning
      | type | logValue                                                                                                                        | logCode       | pluginName | removableText |
      | INFO | Entry point successfully created                                                                                                |               |            |               |
      | INFO | Plugin CAECreator Start Time:2020-08-26 03:18:15.784, End Time:2020-08-26 03:20:59.420, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAECreator |               |

  Scenario Outline:SC2#Verify error message is thrown when user creates duplicate entry point name with overwrite as false in plugin config
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile | path | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreator/CreateEntryPoint |          |      | 200           | IDLE             | $.[?(@.configurationName=='CreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreator/CreateEntryPoint  |          |      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreator/CreateEntryPoint |          |      | 200           | IDLE             | $.[?(@.configurationName=='CreateEntryPoint')].status |


  Scenario:SC2#Verify the duplicate message is captured in CAE Creator analysis log when creating existing entry point
    Given Analysis log "other/CAECreator/CreateEntryPoint%" should display below info/error/warning
      | type | logValue                                                                                                                         | logCode       | pluginName | removableText |
      | INFO | ORA-01920: user name 'CAECREATOR' conflicts with another user or role name                                                       |               |            |               |
      | INFO | Plugin CAECreator Start Time:2020-08-26 04:22:08.677, End Time:2020-08-26 04:22:17.153, Processed Count:0, Errors:20, Warnings:0 | ANALYSIS-0072 | CAECreator |               |

  Scenario Outline:SC3#Verify user is able to overwrite existing CAE repository with Overwrite option enabled in CAE Creator config
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile                                         | path                                     | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAECreator/CreateEntryPoint                             | payloads/ida/CAECreatorDeletor/pluginconfig.json | $.caeCreatorOverWriteTrue.configurations | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAECreator/CreateEntryPoint                             |                                                  |                                          | 200           | CreateEntryPoint |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/Headless-EDI                                   |                                                  |                                          | 200           | UP               | $.nodeStatus                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreator/CreateEntryPoint |                                                  |                                          | 200           | IDLE             | $.[?(@.configurationName=='CreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreator/CreateEntryPoint  |                                                  |                                          | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreator/CreateEntryPoint |                                                  |                                          | 200           | IDLE             | $.[?(@.configurationName=='CreateEntryPoint')].status |

  Scenario:SC3#Verify CAE Creator analysis log info when parameter overwrite is true in configuration
    Given Analysis log "other/CAECreator/CreateEntryPoint%" should display below info/error/warning
      | type | logValue                                                                                                                        | logCode       | pluginName | removableText |
      | INFO | Entry point successfully created                                                                                                |               |            |               |
      | INFO | Plugin CAECreator Start Time:2020-08-26 03:18:15.784, End Time:2020-08-26 03:20:59.420, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAECreator |               |


  Scenario Outline:SC4#Verify user is able to delete the entry point created using CAE Deletor
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile                                         | path                        | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CAEDeletor/EntryPointDelete                             | payloads/ida/CAECreatorDeletor/pluginconfig.json | $.caeDeletor.configurations | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CAEDeletor/EntryPointDelete                             |                                                  |                             | 200           | EntryPointDelete |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/Headless-EDI                                   |                                                  |                             | 200           | UP               | $.nodeStatus                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeletor/EntryPointDelete |                                                  |                             | 200           | IDLE             | $.[?(@.configurationName=='EntryPointDelete')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeletor/EntryPointDelete  |                                                  |                             | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeletor/EntryPointDelete |                                                  |                             | 200           | IDLE             | $.[?(@.configurationName=='EntryPointDelete')].status |

  Scenario:SC4#Verify CAE Entry point deleted and info is written in log
    Given Analysis log "other/CAEDeletor/EntryPointDelete%" should display below info/error/warning
      | type | logValue                                                                                                                        | logCode       | pluginName | removableText |
      | INFO | Entry point deleted.                                                                                                            |               |            |               |
      | INFO | Plugin CAEDeletor Start Time:2020-08-26 04:42:37.023, End Time:2020-08-26 04:43:09.966, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDeletor |               |


  Scenario Outline:SC5#Configure and run plugin for deleting non existing CAE Entry point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                        | bodyFile | path | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/Headless-EDI                                   |          |      | 200           | UP               | $.nodeStatus                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeletor/EntryPointDelete |          |      | 200           | IDLE             | $.[?(@.configurationName=='EntryPointDelete')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeletor/EntryPointDelete  |          |      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeletor/EntryPointDelete |          |      | 200           | IDLE             | $.[?(@.configurationName=='EntryPointDelete')].status |

  Scenario:SC5#Verify CAE Entry point doesn't exist info is written in log
    Given Analysis log "other/CAEDeletor/EntryPointDelete%" should display below info/error/warning
      | type | logValue                                                                                                                        | logCode       | pluginName | removableText |
      | INFO | Entry point CAECREATOR does not exist                                                                                           |               |            |               |
      | INFO | Plugin CAEDeletor Start Time:2020-08-26 04:43:57.870, End Time:2020-08-26 04:44:03.225, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDeletor |               |

  Scenario Outline:SC5#Delete all
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDataSource/CreatorDS      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAECreator/CreateEntryPoint  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CAEDeletor/EntryPointDelete  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EntryPointServerCredential |          |      | 200           |                  |          |
