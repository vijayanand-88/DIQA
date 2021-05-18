@MLP-6361
Feature: MLP-6361: Services for verifying responsed in PII and Glossary tag assignments

@regression @MLP-6361
Scenario Outline: MLP-6361: Verification of response in PII tag assignments
Given user get the column "PII Tag" id from the following query
| description | schemaName | tableName | columnName | criteriaName |
| SELECT      | BigData    | V_Tag     | ID         | type         |
And user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
Then Status code 200 must be returned
And user verifies whether the value is present in response using json path "$..['rootTagName']"
| jsonValues |
| PII        |
And user verifies whether the value is present in response using json path "$..['type']"
| jsonValues |
| PII Tag    |
And response body should have "image" message

Examples:
| contentType      | acceptType       | type | url                                        | endpoint | body |
| application/json | application/json | Get  | tags/BigData/tags/ids/BigData.Tag%3A%3A%3A |          |      |


@regression @MLP-6361
Scenario Outline: MLP-6361: Verification of response in Glossary tag assignments
Given user get the column "Glossary Tag" id from the following query
| description | schemaName | tableName | columnName | criteriaName |
| SELECT      | BigData    | V_Tag     | ID         | type         |
And user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestServiceUser" user
Then Status code 200 must be returned
And user verifies whether the value is present in response using json path "$..['rootTagName']"
| jsonValues |
| Glossary        |
And user verifies whether the value is present in response using json path "$..['type']"
| jsonValues   |
| Glossary Tag |
And response body should have "image" message

Examples:
| contentType      | acceptType       | type | url                                        | endpoint | body |
| application/json | application/json | Get  | tags/BigData/tags/ids/BigData.Tag%3A%3A%3A |          |      |
