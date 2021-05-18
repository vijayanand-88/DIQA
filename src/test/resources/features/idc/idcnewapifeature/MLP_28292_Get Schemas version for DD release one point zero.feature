@MLP-28292
Feature: MLP_28292 Get Schemas version for one point zero

  ##7207476##7207478##7207480##7207572##7207576##7207581##7207584
  @MLP-28292  @regression @positive
  Scenario:SC1#: Verify if user can Get the audit configuration from Swagger & view audit table in postgres
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                   | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/schemas/list |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                              |
      | http://www.asg.com/Analyzer/1.1.0            |
      | http://www.asg.com/BigData/1.1.0             |
      | http://www.asg.com/BusinessApplication/1.1.0 |
      | http://www.asg.com/Core/1.1.0                |
      | http://www.asg.com/ER-Modeling/1.1.0         |
      | http://www.asg.com/ORACLE/1.1.0              |
      | http://www.asg.com/Reporting/1.1.0           |
      | http://www.asg.com/SQLSERVER/1.1.0           |
      | http://www.asg.com/SourceCode/1.1.0          |
      | http://www.asg.com/TERADATA/1.1.0            |
      | http://www.asg.com/DB2/1.1.0                 |
    And response message not contains value "1.0.0"
    And configure a new REST API for the service "IDC"
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/catalogs/schemas |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage                              |
      | http://www.asg.com/Analyzer/1.1.0            |
      | http://www.asg.com/BigData/1.1.0             |
      | http://www.asg.com/BusinessApplication/1.1.0 |
      | http://www.asg.com/Core/1.1.0                |
      | http://www.asg.com/ER-Modeling/1.1.0         |
      | http://www.asg.com/ORACLE/1.1.0              |
      | http://www.asg.com/Reporting/1.1.0           |
      | http://www.asg.com/SQLSERVER/1.1.0           |
      | http://www.asg.com/SourceCode/1.1.0          |
      | http://www.asg.com/TERADATA/1.1.0            |
      | http://www.asg.com/DB2/1.1.0                 |
    And response message not contains value "1.0.0"


