package com.asg.automation.stepdefinition.ida;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.QuickStartActions;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.*;
import com.asg.utils.AWSutil.AWSEmr;
import com.asg.utils.AWSutil.AWSGlueUtil;
import com.asg.utils.AWSutil.DynamoDBUtil;
import com.asg.utils.AWSutil.S3Util;
import com.asg.utils.azureutils.AzureCosmosMongoDBUtil;
import com.asg.utils.azureutils.AzureCosmosSQLUtil;
import com.asg.utils.commonutils.FtpUtil;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.apache.commons.net.ftp.FTP;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.io.*;
import java.util.*;

import static com.asg.automation.utils.Constant.FEATURES;
import static com.asg.automation.utils.Constant.REST_PAYLOAD;

public class ExternalSourceStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    private S3Util s3Util;
    private AzureCosmosMongoDBUtil azureCosmosMongoUtil;
    private FtpUtil ftpUtil;

    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            jsonRead = new JsonRead();
            propertyLoader();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }

    }

    @After("@webtest")
    public void close() {
        destroyDriver();
    }


    @Given("^user \"([^\"]*)\" a bucket \"([^\"]*)\" in amazon storage service$")
    public void user_a_bucket_in_amazon_storage_service(String action, String bucketName) throws Throwable {
        String accessKey = propLoader.prop.getProperty("s3AccessKey");
        String secretKey = propLoader.prop.getProperty("s3SecretKey");
        String region = propLoader.prop.getProperty("s3Region");
        try {
            switch (action) {
                case "Create":
                    new S3Util(accessKey, secretKey, Regions.valueOf(region)).createS3Bucket(bucketName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), bucketName + " is created in amazon s3");
                    break;

                case "Delete":
                    new S3Util(accessKey, secretKey, Regions.valueOf(region)).deleteBucket(bucketName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), bucketName + " is deleted in amazon s3");
                    break;
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user performs following actions in amazon storage service$")
    public void user_performs_following_actions_in_amazon_storage_service(DataTable dataTable) throws Throwable {
        String accessKey = propLoader.prop.getProperty("s3AccessKey");
        String secretKey = propLoader.prop.getProperty("s3SecretKey");
        String action = null;
        String bucketName = null;
        String AWSRegion = null;
        String key = null;

        for (Map<String, String> hm : dataTable.asMaps(String.class, String.class)) {

            action = hm.get("action");
            bucketName = hm.get("bucketName");
            AWSRegion = hm.get("AWSRegion");
            //directoryName - Name of the directory to be deleted from S3 Bucket
            if(hm.containsKey("directoryName")) {
                key = hm.get("directoryName");
            }

            try {
                switch (action) {
                    case "Create bucket":
                        new S3Util(accessKey, secretKey, Regions.valueOf(AWSRegion)).createS3Bucket(bucketName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), bucketName + " is created in amazon s3 region " + AWSRegion);
                        break;

                    case "Delete bucket":
                        new S3Util(accessKey, secretKey, Regions.valueOf(AWSRegion)).deleteBucket(bucketName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), bucketName + " is deleted in amazon s3 region " + AWSRegion);
                        break;

                    case "Delete objects":
                        new S3Util(accessKey, secretKey, Regions.valueOf(AWSRegion)).deleteObjects(bucketName, key);
                        break;
                }

            } catch (Exception e) {
                Assert.fail(e.getMessage());
            }


        }


    }


    @Given("^user performs \"([^\"]*)\" in amazon storage service with below parameters$")
    public void user_performs_in_amazon_storage_service_with_below_parameters(String action, DataTable data) throws Throwable {
        String accessKey = propLoader.prop.getProperty("s3AccessKey");
        String secretKey = propLoader.prop.getProperty("s3SecretKey");
        String region = propLoader.prop.getProperty("s3Region");
        List<Map<String, String>> mp = data.asMaps(String.class, String.class);
        try {
            switch (action) {
                case "single upload":
                    for (Map<String, String> hm : mp) {

                        new S3Util(accessKey, secretKey, Regions.valueOf(region)).uploadSingleFileinS3Bucket(hm.get("bucketName"), hm.get("keyPrefix"), Constant.REST_PAYLOAD + hm.get("dirPath"));
                    }
                    break;

                case "multiple upload":
                    for (Map<String, String> hm : mp) {
                        if (hm.containsKey("AWSRegion")) {
                            region = hm.get("AWSRegion");
                        }
                        new S3Util(accessKey, secretKey, Regions.valueOf(region)).MultiFileUpload(hm.get("bucketName"), hm.get("keyPrefix"), new File(Constant.REST_PAYLOAD + hm.get("dirPath")), Boolean.parseBoolean(hm.get("recursive")));
                    }
                    break;

                case "empty folder creation":
                    for (Map<String, String> hm : mp) {
                        new S3Util(accessKey, secretKey, Regions.valueOf(region)).createEmptyFolder(hm.get("bucketName"), hm.get("keyPrefix"));
                    }
                    break;

                case "version option enable":
                    for (Map<String, String> hm : mp) {
                        new S3Util(accessKey, secretKey, Regions.valueOf(region)).enableVersion(hm.get("bucketName"), hm.get("status"));
                    }
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user \"([^\"]*)\" objects in amazon directory \"([^\"]*)\" in bucket \"([^\"]*)\"$")
    public void user_objects_in_amazon_directory_in_bucket(String action, String key, String bucketName) throws Throwable {
        try {
            String accessKey = propLoader.prop.getProperty("s3AccessKey");
            String secretKey = propLoader.prop.getProperty("s3SecretKey");
            String region = propLoader.prop.getProperty("s3Region");
            switch (action) {
                case "Delete":
                    new S3Util(accessKey, secretKey, Regions.valueOf(region)).deleteObjects(bucketName, key);
                    break;

                case "Delete Version":
                    new S3Util(accessKey, secretKey, Regions.valueOf(region)).deleteVersionObjects(bucketName);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Then("^user get objects list from \"([^\"]*)\" in bucket \"([^\"]*)\" with maximum count of \"([^\"]*)\"$")
    public void user_get_objects_list_from_in_bucket_with_maximum_count_of(String key, String bucketName, String maxResults) throws Throwable {
        try {
            String accessKey = propLoader.prop.getProperty("s3AccessKey");
            String secretKey = propLoader.prop.getProperty("s3SecretKey");
            String region = propLoader.prop.getProperty("s3Region");
            CommonUtil.storeText(String.valueOf(new S3Util(accessKey, secretKey, Regions.valueOf(region)).getFileListFromDirectory(bucketName, key, maxResults).size()));
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());

        }
    }

    @Given("^user get \"([^\"]*)\" from \"([^\"]*)\" in bucket \"([^\"]*)\" with maximum count of \"([^\"]*)\"$")
    public void user_get_from_in_bucket_with_maximum_count_of(String function, String key, String bucketName, String maxResults) throws Throwable {
        try {
            String accessKey = propLoader.prop.getProperty("s3AccessKey");
            String secretKey = propLoader.prop.getProperty("s3SecretKey");
            String region = propLoader.prop.getProperty("s3Region");
            switch (function) {
                case "File count with version":
                    new CommonUtil().storeText(String.valueOf(new S3Util(accessKey, secretKey, Regions.valueOf(region)).getFileListFromDirectory(bucketName, key, maxResults).size()));
                    break;
                case "File count without version":
                    new CommonUtil().storeText(String.valueOf(new S3Util(accessKey, secretKey, Regions.valueOf(region)).getBucketDirectoryFilesWithoutVersion(bucketName, key, maxResults).size()));
                    break;
                case "rule count":
                    new CommonUtil().storeText(String.valueOf(new S3Util(accessKey, secretKey, Regions.valueOf(region)).getRuleCount(bucketName)));
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }

    }


    @Given("^user \"([^\"]*)\" a \"([^\"]*)\" under the Azure Cosmos Account using MongoAPI$")
    public void user_a_under_the_Azure_Cosmos_Account_using_MongoAPI(String action, String type, DataTable data) throws Throwable {
        String masterKey = propLoader.prop.getProperty("Azure_MasterKey_Mongo");
        String host = propLoader.prop.getProperty("Azure_Hostname_Mongo");
        try {
            for (Map<String, String> dataList : data.asMaps(String.class, String.class)) {
                String dbName = dataList.get("dataBaseName").trim();
                String collectionName = dataList.get("collectionName").trim();
                String dirPath = dataList.get("dirPath").trim();
                String documentName = dataList.get("documentName").trim();

                switch (action) {
                    case "Create":
                        switch (type) {
                            case "Database":
                                new AzureCosmosMongoDBUtil(host, masterKey).createDatabase(dbName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dbName + " database is created under Azure Cosmos Account using MongoAPI");
                                break;
                            case "Collection":
                                new AzureCosmosMongoDBUtil(host, masterKey).createContainer(dbName, collectionName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), collectionName + " collection is created under DB " + dbName);
                                break;
                            case "Document":
                                new AzureCosmosMongoDBUtil(host, masterKey).createDocument(dbName, collectionName, Constant.REST_PAYLOAD + dirPath + documentName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), documentName + " document is created under the collection " + collectionName);
                                break;
                        }
                        break;
                    case "Delete":
                        switch (type) {
                            case "Database":
                                new AzureCosmosMongoDBUtil(host, masterKey).deleteDatabase(dbName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dbName + " database is deleted under Azure Cosmos Account using MongoAPI");
                                break;
                        }
                        break;
                }
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Azure DB connnection is not established");
        }
    }


    @Given("^user \"([^\"]*)\" a \"([^\"]*)\" under the Azure Cosmos Account using SQL API$")
    public void user_a_under_the_Azure_Cosmos_Account_using_SQL_API(String action, String type, DataTable data) throws Throwable {
        String masterKey = propLoader.prop.getProperty("Azure_MasterKey_SQL");
        String host = propLoader.prop.getProperty("Azure_Hostname_SQL");
        try {
            for (Map<String, String> dataList : data.asMaps(String.class, String.class)) {
                String dbName = dataList.get("dataBaseName").trim();
                String tableName = dataList.get("tableName").trim();
                String dirPath = dataList.get("dirPath").trim();
                String documentName = dataList.get("documentName").trim();

                switch (action) {
                    case "Create":
                        switch (type) {
                            case "Database":
                                new AzureCosmosSQLUtil(host, masterKey).createDatabase(dbName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dbName + " database is created under Azure Cosmos Account using SQL API");
                                break;
                            case "Table":
                                new AzureCosmosSQLUtil(host, masterKey).createContainer(dbName, tableName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tableName + " table is created under DB " + dbName);
                                break;
                            case "Document":
                                new AzureCosmosSQLUtil(host, masterKey).createDocument(dbName, tableName, Constant.REST_PAYLOAD + dirPath + documentName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), documentName + " document is created under the table " + tableName);
                                break;
                        }
                        break;
                    case "Delete":
                        switch (type) {
                            case "Database":
                                new AzureCosmosSQLUtil(host, masterKey).deleteDatabase(dbName);
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dbName + " database is deleted under Azure Cosmos Account using SQL API");
                                break;
                        }
                        break;
                }
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Azure DB connnection is not established");
        }
    }

    @Given("^user connects to the FTP server and download the files with below parameters$")
    public void user_connects_to_the_FTP_server_and_download_the_files_with_below_parameters(DataTable dataTable) throws Throwable {
        String ftpHost = null;
        String ftpUser = null;
        String ftpPassword = null;
        String ftpPath = null;
        String localDir = null;
        String fileExtn = null;
        try {
            for (Map<String, String> data : dataTable.asMaps(String.class, String.class)) {
                ftpHost = propLoader.prop.getProperty("ftpHost");
                ftpUser = propLoader.prop.getProperty("ftpUser");
                ftpPassword = propLoader.prop.getProperty("ftpPassword");
                ftpPath = data.get("ftpPath");
                localDir = data.get("downloadDirectory").replace("SystemHomeDirectory", System.getProperty("user.home") + "\\" + "Documents");
                fileExtn = data.get("fileToDownload");
            }
            new FtpUtil(ftpHost, ftpUser, ftpPassword).downloadFilesFromFtp(ftpPath, localDir, fileExtn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Given("^user performs \"([^\"]*)\" functions with following parameters$")
    public void user_performs_functions_with_following_parameters(String arg1, DataTable arg2) throws Throwable {
        String localDir = null;
        String fileExtn = null;
        try {
            for (Map<String, String> data : arg2.asMaps(String.class, String.class)) {
                localDir = data.get("downloadDirectory").replace("SystemHomeDirectory", System.getProperty("user.home") + "\\" + "Documents");
                fileExtn = data.get("fileExtension");
            }
            switch (arg1) {
                case "unzip":
                    FtpUtil.unZipFiles(FtpUtil.getZipFiles(localDir, fileExtn), localDir);
                    break;
                case "delete":
                    FtpUtil.deleteUnwantedFiles(localDir, fileExtn);
                    break;
            }

        } catch (Exception e) {

        }
    }

    @Given("^User update the below \"([^\"]*)\" in following files using json path$")
    public void user_update_the_below_in_following_files_using_json_path(String source, DataTable values) throws Throwable {
        try {
            try {
                switch (source) {
                    case "aws credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("accessKeyPath"), propLoader.prop.getProperty("s3AccessKey"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("secretKeyPath"), propLoader.prop.getProperty("s3SecretKey"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "S3 Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("accessKeyPath"), propLoader.prop.getProperty("s3AccessKeyReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("secretKeyPath"), propLoader.prop.getProperty("s3SecretKeyReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "DynamoDB Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("accessKeyPath"), propLoader.prop.getProperty("DynamoAccessKeyReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("secretKeyPath"), propLoader.prop.getProperty("DynamoSecretKeyReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Git Credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("BITBUCKET_USERNAME"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("BITBUCKET_PASSWORD"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Postgres Credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("qauser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("qapassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "redshift credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("redshiftDBuser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("redshiftDBpassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Redshift ReadOnly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("redshiftReadOnlyDBuser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("redshiftReadonlyDBpassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "snowflake credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("snowflakeuser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("snowflakepassword"));
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle12c credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c"));
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Postgres AWS Credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("postgressAWSUser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("postgressAWSPassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "SqlServer Credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("sqlServerDBuser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("sqlServerDBpassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "ediBus credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("edibusUser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("edibusPassword"));
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "ediBus host":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("EDIHostName"));
                            JsonBuildUpdateUtil.updateJsonNodeWithInteger(REST_PAYLOAD + data.get("filePath"), data.get("password"), Integer.parseInt(propLoader.prop.getProperty("EDIPortNumber")));
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle11g credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle12cCDB credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c_CDB"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c_CDB"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle12cCDB Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c_CDB"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c_CDB"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle12cPDB credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle12cPDB Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c_PDB_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c_PDB_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle12cRDS credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c_RDS"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c_RDS"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle12cRDS Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_12c_RDS_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_12c_RDS_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle19cPDB credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_19c_PDB"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_19c_PDB"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle19cPDB ReadOnly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_19c_PDB_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_19c_PDB_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "oracle19cCDB credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_19c_CDB"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_19c_CDB"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle19cCDB Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_19c_CDB_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_19c_CDB_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle19cRDS credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_19c_RDS"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_19c_RDS"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle19cRDS Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_19c_RDS_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_19c_RDS_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle18cPDB credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_18c_PDB"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_18c_PDB"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle18cPDB Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_18c_PDB_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_18c_PDB_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle18cCDB credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_18c_CDB"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_18c_CDB"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle18cCDB Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_18c_CDB_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_18c_CDB_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle18cRDS credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_18c_RDS"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_18c_RDS"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Oracle18cRDS Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("oracleuser_18c_RDS_ReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("oraclepassword_18c_RDS_ReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Glue Readonly credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("accessKeyPath"), propLoader.prop.getProperty("glueAccessKeyReadOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("secretKeyPath"), propLoader.prop.getProperty("glueSecretKeyReadOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "Teradata16 credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("teradatauser"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("teradatapassword"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;


                    case "RDS SqlServer Credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("sqlServerDBuser_RDS"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("sqlServerDBpassword_RDS"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;

                    case "OnPrem SqlServer Credentials":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("sqlServerDBuser_OnPrem"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("sqlServerDBpassword_OnPrem"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                    case "RDS SqlServer Credentials readOnly":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("sqlServerDBuser_RDS_readOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("sqlServerDBpassword_RDS_readOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;

                    case "OnPrem SqlServer Credentials readOnly":
                        for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("username"), propLoader.prop.getProperty("sqlServerDBuser_OnPrem_readOnly"));
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("password"), propLoader.prop.getProperty("sqlServerDBpassword_OnPrem_readOnly"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), source + " values updated in file" + data.get("filePath"));
                        }
                        break;
                }
            } catch (Exception e) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
                Assert.fail("Values not updated in file");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user \"([^\"]*)\" value from file \"([^\"]*)\" and write to file \"([^\"]*)\"$")
    public void user_value_from_file_and_write_to_file(String function, String sourcePath, String destnPath) throws Throwable {
        try {
            switch (function) {
                case "encodePolicyEngine":
                    FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + destnPath, CommonUtil.stringEncoder(propLoader.prop.getProperty("policyUsername") + ":" + FileUtil.readAllBytesInFile(Constant.REST_PAYLOAD + sourcePath)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user connects to AWS Dynamo database and perform the following operation$")
    public void user_connects_to_AWS_Dynamo_database_and_perform_the_following_operation(DataTable dataTable) throws Throwable {
        String accessKey = propLoader.prop.getProperty("s3AccessKey");
        String secretKey = propLoader.prop.getProperty("s3SecretKey");
        String region = propLoader.prop.getProperty("s3Region");
        String region1 = propLoader.prop.getProperty("s3Region1");
        String region2 = propLoader.prop.getProperty("s3Region2");
        String jsonPath = null;
        String action = null;
        String tableName = null;
        Integer tableCount = 0;
        String deleteTable1 = null;
        String deleteTable2 = null;
        String path = null;
        for (Map<String, String> hm : dataTable.asMaps(String.class, String.class)) {
            action = hm.get("action");
            jsonPath = Constant.REST_PAYLOAD + hm.get("jsonPath");
            deleteTable1 = hm.get("Table1");
            deleteTable2 = hm.get("Table2");
            tableName = hm.get("tableName");
            path = hm.get("path");
        }

        try {
            switch (action) {
                case "createTable":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).createTable(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table is created in amazon s3");
                    break;
                case "createItem":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).createItem(tableName, jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records are inserted into Dynamo DB table ");
                    break;
                case "deleteTable":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).deleteTable(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table is deleted in amazon s3");
                    break;
                case "verifyTableSize":
                    String uiCount = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    tableCount = new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).getTableSize();
                    Assert.assertEquals(String.valueOf(tableCount.intValue()), uiCount);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table count is retrieved from amazon s3");
                    break;
                case "getTableList":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).getTableList();
                    CommonUtil.storeTemporaryList(new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).getTableList());
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table list is retrieved from amazon s3");
                    break;
                case "createGlobalTable":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region1), Regions.valueOf(region2)).createGlobalTable(jsonPath, region1, region2);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB Global table is created in amazon s3");
                    break;
                case "deleteGlobalTable":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region1), Regions.valueOf(region2)).deleteTableFromBucket(deleteTable1, deleteTable2);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB Global table is deleted in amazon s3");
                    break;

                case "getTableARNAndUpdateToFile":
                    JsonBuildUpdateUtil.updateJsonNode(jsonPath, path, new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).getARNForTable(tableName));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB Global table is deleted in amazon s3");
                    break;
                case "getColumnList":
                    new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).getColumnNames(tableName);
                    CommonUtil.storeTemporaryList(new DynamoDBUtil(accessKey, secretKey, Regions.valueOf(region)).getColumnNames(tableName));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table list is retrieved from amazon s3");
                    break;
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user connects to AWS Glue database and perform the following operation$")
    public void user_connects_to_AWS_Glue_database_and_perform_the_following_operation(DataTable dataTable) throws Throwable {
        String accessKey = propLoader.prop.getProperty("s3AccessKey");
        String secretKey = propLoader.prop.getProperty("s3SecretKey");
        String region = propLoader.prop.getProperty("s3Region");
        String region1 = propLoader.prop.getProperty("s3Region1");
        String region2 = propLoader.prop.getProperty("s3Region2");
        String jsonPath = null;
        String action = null;
        String tableName = null;
        String jobName = null;
        String connectionName = null;
//        String awsRegion = null;
        Integer databaseCount = 0;
        Integer tableCount = 0;
        Integer jobCount = 0;
        Integer columnCount = 0;
        Integer connectionCount = 0;
        Integer partitionCount = 0;
        Integer tablesCountInMultipleDB = 0;
        Integer columnCountInMultipleDB = 0;
        String deleteTable1 = null;
        String deleteTable2 = null;
        String databaseName = null;
        String crawlerName = null;
        List<String> databaseList = new ArrayList<>();
        for (Map<String, String> hm : dataTable.asMaps(String.class, String.class)) {
            action = hm.get("action");
            jsonPath = Constant.REST_PAYLOAD + hm.get("jsonPath");
            deleteTable1 = hm.get("Table1");
            deleteTable2 = hm.get("Table2");
            tableName = hm.get("tableName");
            databaseName = hm.get("databaseName");
            jobName = hm.get("jobName");
            connectionName = hm.get("connectionName");
            crawlerName = hm.get("crawlerName");
            databaseList.add(hm.get("databaseList"));
            if (hm.containsKey("AWSRegion")) {
                region = hm.get("AWSRegion");
            }
        }

        try {
            switch (action) {
                case "createDatabase":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createDataBase(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue DB Database is created in region "+region);
                    break;
                case "createTable":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createTable(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue DB table is created in region "+region);
                    break;
                case "createTableWithPartition":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createTableWithPartition(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue DB table with Partition is created in amazon s3");
                    break;
                case "createPartition":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createPartition(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Partition for Glue table is created in region "+region);
                    break;
                case "createJob":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createGlueJob(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue DB table is created in region "+region);
                    break;
                case "createUDF":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createUserDefinedFunction(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue UDF  is created in amazon s3");
                    break;
                case "createConnection":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createConnection(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue DB Connection created in amazon s3");
                    break;
                case "createCrawler":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).createCrawler(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue Crawler is created in amazon s3");
                    break;
                case "runCrawlerOnDemand":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).runCrawlerOnDemand(jsonPath, tableName, crawlerName);
                    break;
                case "deleteDatabase":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).deleteDatabase(databaseName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue Database "+ databaseName+" is deleted from region "+region);
                    break;
                case "deleteTable":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).deleteTable(databaseName, tableName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue table "+ tableName+" is deleted from region "+region);
                    break;
                case "deleteJob":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).deleteGlueJob(jobName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Glue Job "+ jobName+" is deleted from region "+region);
                    break;
                case "deleteUDF":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).deleteUserDefinedFunction(jsonPath);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table is deleted in amazon s3");
                    break;
                case "deleteConnection":
                    new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).deleteConnection(connectionName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table is deleted in amazon s3");
                    break;
                case "verifyDatabaseSize":
                    String uiCount = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    databaseCount = new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getListOfDatabases().size();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table count is retrieved from amazon s3");
                    Assert.assertEquals(String.valueOf(databaseCount.intValue()), uiCount);
                    break;
                case "verifyJobSize":
                    String uiCount1 = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    jobCount = new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getGlueJobList().size();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table count is retrieved from amazon s3");
                    Assert.assertEquals(String.valueOf(jobCount.intValue()), uiCount1);
                    break;
                case "verifyTableSize":
                    String uiCount2 = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    tableCount = new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getTablesCount(databaseName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table list is retrieved from amazon s3");
                    Assert.assertEquals(String.valueOf(tableCount.intValue()), uiCount2);
                    break;
                case "verifyColumnSize":
                    String uiCount3 = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    columnCount = new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getColumnCount(databaseName, tableName);
                    LoggerUtil.logInfo("UI" + uiCount3);
                    LoggerUtil.logInfo("Util" + columnCount);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table list is retrieved from amazon s3");
                    Assert.assertEquals(String.valueOf(columnCount.intValue()), uiCount3);
                    break;
                case "verifyConnectionSize":
                    String uiCount4 = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    connectionCount = new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getCountOfConnection();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table list is retrieved from amazon s3");
                    Assert.assertEquals(String.valueOf(connectionCount.intValue()), uiCount4);
                    break;
                case "verifyPartitionSize":
                    String uiCount5 = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    partitionCount = new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getCountOfPartitionKeys(databaseName, tableName);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamo DB table list is retrieved from amazon s3");
                    Assert.assertEquals(String.valueOf(partitionCount.intValue()), uiCount5);
                    break;
                case "verifyMutlipleDBTableSize":
                    String uiTablesCount = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "UI Count for list of glue tables is retrieved");
                    Assert.assertEquals(uiTablesCount, String.valueOf(new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getListOfTables(databaseList).size()));
                    break;
                case "verifyMutlipleDBColumnSize":
                    String uiColumnCount = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText().trim());
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "UI Count for list of glue tables is retrieved");
                    Assert.assertEquals(uiColumnCount, String.valueOf(new AWSGlueUtil(accessKey, secretKey, Regions.valueOf(region)).getMultipleDatabaseColumns(databaseList).size()));
                    break;
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getName(), "Expected and actual value mismatch");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user delete \"([^\"]*)\" in json file \"([^\"]*)\" for below param$")
    public void user_delete_in_json_file_for_below_param(String key, String fileName, DataTable dataTable) throws Throwable {
        FileWriter fileWriter = null;
        JSONParser jsonParser = new JSONParser();
        try {
            switch (key) {
                case "json array":
                    for (String data : dataTable.asList(String.class)) {
                        if (fileName.contains("Constant.REST_DIR")) {
                            fileName = fileName.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                        }
                        JSONObject jsonObject = (JSONObject) jsonParser.parse(new FileReader(fileName));
                        if (jsonObject.containsKey(data)) {
                            jsonObject.remove(data);
                        } else {
                            Assert.fail(data + " not found in file " + fileName);
                        }

                        if (jsonObject.containsKey(data)) {
                            Assert.fail(data + " not deleted from file " + fileName);
                        }
                        fileWriter = new FileWriter(fileName);
                        fileWriter.write(jsonObject.toJSONString());
                        fileWriter.flush();
                    }
                    break;

            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getName(), " values not deleted from json file");
            e.printStackTrace();
        } finally {
            fileWriter.close();
        }
    }

    @Given("^user performs the below operation related to a cluster in Amazon EMR service$")
    public void userPerformsTheBelowOperationRelatedToAClusterInAmazonEMRService(DataTable dataTable) throws Throwable {
        String accessKey = propLoader.prop.getProperty("s3AccessKey");
        String secretKey = propLoader.prop.getProperty("s3SecretKey");
        String region = propLoader.prop.getProperty("s3Region");

        try {
            for (Map<String, String> data : dataTable.asMaps(String.class, String.class)) {
                String action = data.get("action");
                String clusterName = data.get("clusterName");
                switch (action) {
                    case "CreateCluster":
                        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), "$.clusterName", clusterName);
                        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), "$.Tag.Name", clusterName);
                        new AWSEmr(accessKey, secretKey, Regions.valueOf(region)).createCluster(REST_PAYLOAD + data.get("filePath"));
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EMR Cluster: " + clusterName + " is created in amazon EMR");
                        break;
                    case "TerminateCluster":
                        new AWSEmr(accessKey, secretKey, Regions.valueOf(region)).terminateCluster(clusterName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EMR Cluster: " + clusterName + " is terminated in amazon EMR");
                        break;
                    case "GetClusterIDAndUpdateFile":
                        String clusterID = new AWSEmr(accessKey, secretKey, Regions.valueOf(region)).getEMRClusterID(clusterName);
                        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("jsonPath"), clusterID);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterID : " + clusterID + " values updated in file" + data.get("filePath"));
                        break;
                }

            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }
}

