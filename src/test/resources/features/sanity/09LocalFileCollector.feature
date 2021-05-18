Feature: Local File Collector Sanity run scenarios


  @sanityrun
  Scenario Outline:LocalFileCollector_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                      | path                 | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector/LocalFileCollector                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.LFC.configurations | 204           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='LocalFileCollector')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/LocalFileCollector  |                                               |                      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='LocalFileCollector')].status |
