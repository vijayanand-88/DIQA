Feature: Escrow Validation

  @escrow @positive
  Scenario: To verify whether copyrights in java files
    Given user connects to the FTP server and download the files with below parameters
      | hostName | userName | passWord    | ftpPath          | downloadDirectory            | fileToDownload |
      | ftpHost  | ftpUser  | ftpPassword | /IDC/100/escrow/ | SystemHomeDirectory\\escrow\ | .zip           |
    Given user performs "unzip directory" functions with following parameters
      | downloadDirectory           | fileExtension |
      | SystemHomeDirectory\\escrow | .zip          |
    Given user verifies copyrights in all java files from the following path
      | directory                   | copyrightMessage                                                                                                          |
      | SystemHomeDirectory\\escrow | Copyright (c) 1983-2020 ASG GmbH & Co. KG, a wholly owned subsidiary of ASG Technologies Group, Inc. All rights reserved. |
