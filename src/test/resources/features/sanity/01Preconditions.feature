Feature:To run all the preconditions which are needed for demo data loading


  Scenario Outline:Explicit Tag Creation for all technology
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/sanityPayloads/explicittags.json | 200           |                  |          |


  Scenario Outline: Datasource license limit increase and enable lineage values for license
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url              | body                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/license | ida/sanityPayloads/licenseManager.json | 204           |                  |          |


  Scenario: CsvS3_:Create an EMR cluster in Amazon EMR service
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action        | clusterName                | filePath                            | jsonPath |
      | CreateCluster | asg-di-emrcluster-demodata | ida/sanityPayloads/clusterdata.json |          |

  Scenario: Retrieve emr cluster id and update it in analyzer configuration files for all S3 File analyzers
    Given user performs the below operation related to a cluster in Amazon EMR service
      | action                    | clusterName                | filePath                                | jsonPath                          |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-demodata | ida/sanityPayloads/AnalyzersConfig.json | $.csvS3Analyzer..emrClusterId     |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-demodata | ida/sanityPayloads/AnalyzersConfig.json | $.jsonS3Analyzer..emrClusterId    |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-demodata | ida/sanityPayloads/AnalyzersConfig.json | $.parquetS3Analyzer..emrClusterId |
      | GetClusterIDAndUpdateFile | asg-di-emrcluster-demodata | ida/sanityPayloads/AnalyzersConfig.json | $.avroS3Analyzer..emrClusterId    |


