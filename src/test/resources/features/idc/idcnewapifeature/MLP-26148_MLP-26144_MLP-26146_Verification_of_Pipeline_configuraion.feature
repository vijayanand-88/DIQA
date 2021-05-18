@MLP-26148 @MLP-26144
Feature:MLP-26148 MLP-26144 : This feature is to verify the Manage Pipeline configuration page

  ##7178206##
  @MLP-26144 @regression @positive
  Scenario: SC1#:MLP-26144: Verify if user is able to add the new Pipeline configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                              | body                              | response code | response message | jsonPath    |
      | application/json |       |       | Put  | settings/pipelines/PipelineTest  | /idc/Pipeline/CreatePipeline.json | 200           | PipelineTest     | $..['name'] |
      |                  |       |       | Put  | settings/pipelines/PipelineTest1 | /idc/Pipeline/CreatePipeline.json | 200           | PipelineTest1    | $..['name'] |
    And user verifies whether the value is present in response using json path "$..['configuration']"
      | jsonValues                |
      | SimilarityLinkerTable     |
      | Demo Local Files          |
      | SimilarityLinkerHistogram |

##7178200##
  @MLP-26148 @regression @positive
  Scenario: SC2#:MLP-26148: Verify if user is able to get the added Pipeline configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                             | body | response code | response message | jsonPath    |
      | application/json |       |       | Get  | settings/pipelines/PipelineTest |      | 200           | PipelineTest     | $..['name'] |

       ##7178234##
  @MLP-26144 @regression @positive
  Scenario: SC3#:MLP-26144: Verify if user is able to Edit the added Pipeline configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                              | body                            | response code | response message | jsonPath    |
      | application/json |       |       | Put  | settings/pipelines/PipelineTest?allowUpdate=true | /idc/Pipeline/EditPipeline.json | 200           | PipelineTest     | $..['name'] |
    And user verifies whether the value is present in response using json path "$..['configuration']"
      | jsonValues            |
      | SimilarityLinkerTable |
      | Demo Local Files      |
    And user verifies whether the value is present in response using json path "$..['description']"
      | jsonValues                       |
      | TestPipeline to Describe to edit |


  ##7165791##
  @MLP-26148 @regression @positive
  Scenario: SC4#:MLP-26148: Verify if user is able to get all the Pipeline configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body | response code | response message | jsonPath    |
      | application/json |       |       | Get  | settings/pipelines |      | 200           | PipelineTest     | $..['name'] |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues    |
      | PipelineTest  |
      | PipelineTest1 |

  ##7178198##
  @MLP-26148 @regression @positive
  Scenario: SC5#:MLP-26148: Verify if user is able to get all the Pipeline configurations in sequential order
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                        | body | response code | response message | jsonPath    |
      | application/json |       |       | Get  | settings/pipelines/PipelineTest/sequential |      | 200           | PipelineTest     | $..['name'] |
    And user verifies whether the value is present in response using json path "$..['pluginName']"
      | jsonValues         |
      | SimilarityLinker   |
      | LocalFileCollector |


  ##7178248##
  @MLP-26144 @regression @positive
  Scenario: SC6#:MLP-26144: Verify if user is able to delete the Pipeline configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/pipelines/PipelineTest  |      | 200           |                  |          |
      |                  |       |       | Delete | settings/pipelines/PipelineTest1 |      | 200           |                  |          |