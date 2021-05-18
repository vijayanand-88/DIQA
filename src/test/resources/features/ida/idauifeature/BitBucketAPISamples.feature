Feature: Bitbucket API Features

  @positive
  Scenario: User gets the details of the remote repository in Bitbucket
  Given configure a new REST API for the service "BitBucket"
    When User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/git-collector"
    Then the status code code is 200
    And response includes the following
    | slug  | git-collector |
    | id    | 834           |
    | name  | Git Collector |
    | scmId | git           |

  @positive
  Scenario: User creates a new repository in Bitbucket and collects it using IDA
    Given configure a new REST API for the service "BitBucket"
      And User can add a repository in QA Project space in BitBucket

