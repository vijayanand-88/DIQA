package com.asg.automation.stepdefinition.ida;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.utils.*;
import com.asg.automation.utils.jmxUtil.GemfireCreateData;
import com.asg.automation.utils.jmxUtil.Neo4jBase;
import com.asg.utils.databaseutils.CassandraDBUtil;
import com.asg.utils.databaseutils.CouchBaseUtil;
import com.asg.utils.databaseutils.MongoDBUtil;
import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import gherkin.lexer.Ru;
import org.bson.Document;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.*;

public class jdbcAnalyzerStepDefinition extends DriverFactory {
    private CommonUtil commonUtil;
    protected DBPostgresUtil db_postgres_util;
    private WebDriver driver;
    private MongoDBUtil mongoDBUtil;
    private DBHelper dbHelper = new DBHelper();
    private JsonRead jsonRead = new JsonRead();
    private CassandraDBUtil cassandraDBUtil;
    private Neo4jBase neo4j = new Neo4jBase();
    private CouchBaseUtil couchBaseUtil;


    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
//            jsonRead = new JsonRead();
            propertyLoader();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }

    }

    @After("@webtest")
    public void close() {
        destroyDriver();
    }


    @Given("^user connect to the Mongo DB database and execute query for the below parameters$")
    public void user_connect_to_the_Mongo_DB_database_and_execute_query_for_the_below_parameters(DataTable data) throws Throwable {
        Document document = null;
        try {
            for (Map<String, String> dataList : data.asMaps(String.class, String.class)) {
                String dbName = dataList.get("dataBaseName");
                String jsonPath = dataList.get("queryPath");
                String queryPage = dataList.get("queryPage");
                String dataBase = dataList.get("mongoDBName");
                String operation = dataList.get("operation");
                switch (dataList.get("columnCount")) {
                    case "3":
                        document = new Document(dataList.get("column1"), jsonRead.readJSonFromQuery(Constant.TEST_DATA_PATH + jsonPath, queryPage, dataList.get("column1")))
                                .append(dataList.get("column2"), jsonRead.readJSonFromQuery(Constant.TEST_DATA_PATH + jsonPath, queryPage, dataList.get("column2")))
                                .append(dataList.get("column3"), Integer.valueOf(jsonRead.readJSonFromQuery(Constant.TEST_DATA_PATH + jsonPath, queryPage, dataList.get("column3"))));
                        break;
                }

                dbHelper.executeNoSQL(document, dbName, operation, dataList.get("tableName"), dataBase);
            }
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Mongo DB connnection is not established");
        }
    }

    @Given("^user connect to the Cassandra DB database and execute query for the below parameters$")
    public void user_connect_to_the_Cassandra_DB_database_and_execute_query_for_the_below_parameters(DataTable data) throws Throwable {
        try {
            for (Map<String, String> dataList : data.asMaps(String.class, String.class)) {
                String keySpaceName = dataList.get("keySpaceName");
                String cqlQuery = jsonRead.readJSonFromQuery(Constant.TEST_DATA_PATH + dataList.get("queryPath"), dataList.get("queryPage"), dataList.get("queryField"));
                switch (dataList.get("dataTypeAction")) {
                    case "createKeySpace":
                        dbHelper.executeCassandra(dataList.get("dataBaseName"), dataList.get("dataTypeAction"), dataList.get("operation"), keySpaceName, cqlQuery.replace("keyspacename", keySpaceName));
                        break;
                    case "dropKeySpace":
                        dbHelper.executeCassandra(dataList.get("dataBaseName"), dataList.get("dataTypeAction"), dataList.get("operation"), keySpaceName, cqlQuery.replace("keyspacename", keySpaceName));
                        break;
                    case "createTable":
                        dbHelper.executeCassandra(dataList.get("dataBaseName"), dataList.get("dataTypeAction"), dataList.get("operation"), dataList.get("tableName"), cqlQuery);
                        break;
                    case "dropTable":
                        dbHelper.executeCassandra(dataList.get("dataBaseName"), dataList.get("dataTypeAction"), dataList.get("operation"), dataList.get("tableName"), cqlQuery);
                        break;
                    case "insertData":
                        dbHelper.executeCassandra(dataList.get("dataBaseName"), dataList.get("dataTypeAction"), dataList.get("operation"), dataList.get("tableName"), cqlQuery);
                        break;
                    case "alterTable":
                        dbHelper.executeCassandra(dataList.get("dataBaseName"), dataList.get("dataTypeAction"), dataList.get("operation"), dataList.get("tableName"), cqlQuery);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("DB Action failed while executing in cassandra");
        }
    }

    @Given("^user validate if the table \"([^\"]*)\" exists in \"([^\"]*)\"$")
    public void user_validate_if_the_table_exists_in(String tableName, String keySpace) throws Throwable {
        try{
            while(true){
                for(String value:new CassandraDBUtil(propLoader.prop.getProperty("cassandraIP")).connectDatabase().getListofTableName(keySpace)){
                    if(value.equals(tableName)){
                        break;
                    }else{
                        sleepForSec(5000);
                    }
                }
                break;
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Given("^User connects to neoDB \"([^\"]*)\" and \"([^\"]*)\" data$")
    public void user_connects_to_neoDB_and_data(String arg1, String arg2) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        Neo4jBase graphDB = new Neo4jBase();
        try {
            if (arg1.equalsIgnoreCase("enterprise edition")) {
                graphDB.createDbConnection(propLoader.prop.getProperty("boltURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            } else if (arg1.equalsIgnoreCase("community edition")) {
                graphDB.createDbConnection(propLoader.prop.getProperty("boltCommunityURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            }
            if (arg2.equalsIgnoreCase("create")) {
                graphDB.createData(Constant.TEST_DATA_PATH + "neo4j/data.txt");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query execution successful");
            } else if (arg2.equalsIgnoreCase("delete")) {
                List<String> deleteCode = new LinkedList<>();
                try (BufferedReader br = new BufferedReader(new FileReader(Constant.TEST_DATA_PATH+"neo4j/deleteData.txt"))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        deleteCode.add(line);
                    }
                    for(String test: deleteCode) {
                        graphDB.delete(test);
                    }
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query execution successful");
            }else if (arg2.equalsIgnoreCase("update")){
                graphDB.createData(Constant.TEST_DATA_PATH + "neo4j/nodecreation.txt");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query execution successful");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Query from the file cannot be executed in Neo4j ");
        }finally {
            graphDB.close();
        }


    }

    @Then("^user \"([^\"]*)\" of following labels in neoDB \"([^\"]*)\"$")
    public void user_of_following_labels_in_neoDB(String actionType,String arg, DataTable data) throws Throwable {
        List<String> expected = data.asList(String.class);
        Neo4jBase graphDB = new Neo4jBase();
        try{
            switch(actionType){
                case "verify presence":
                    if(arg.equalsIgnoreCase("enterprise edition")) {
                        graphDB.createDbConnection(propLoader.prop.getProperty("boltURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
                    }else if(arg.equalsIgnoreCase("community edition")){
                        graphDB.createDbConnection(propLoader.prop.getProperty("boltCommunityURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
                    }
                    List<String> actual = graphDB.getLabels();
                    actual.retainAll(expected);
                    if(actual.size()!= expected.size()) {
                        throw new Exception();
                    }
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected label are present");
            }
        }catch(Exception e){
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Expected Labels are not present List");
        }
        finally {
            graphDB.close();
        }
    }

    @Given("^User connects to cmd and \"([^\"]*)\" data for gemfire$")
    public void user_connects_to_cmd_and_data_for_gemfire(String arg1) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        boolean dataCreated = new GemfireCreateData().createData(propLoader.prop.getProperty("gemFireLocation"),propLoader.prop.getProperty("gemFireData"));
        if(dataCreated == true)
        {
            boolean created = dataCreated;
        }
        else {
            boolean notcreated = dataCreated;
        }
    }

    @Given("^user connect to the Couch DB database and perform the following operation$")
    public void user_connect_to_the_Couch_DB_database_and_perform_the_following_operation(DataTable arg1) throws Throwable {
        String host = null;
        String username = null;
        String password = null;
        String operation = null;
        String bucketName = null;
        String documentId = null;
        String documentPath = null;
        try {
            for (Map<String, String> dataList : arg1.asMaps(String.class, String.class)) {
                host = propLoader.prop.getProperty(dataList.get("dataBaseName"));
                username = propLoader.prop.getProperty(dataList.get("userName"));
                password = propLoader.prop.getProperty(dataList.get("passWord"));
                bucketName = dataList.get("bucketname");
                documentPath = Constant.REST_PAYLOAD + dataList.get("queryPath");
                operation = dataList.get("operation");
                documentId = dataList.get("Id");
            }
            switch (operation) {
                case "createClusterWithDocument":
                    new CouchBaseUtil(host, username, password).createBucket(bucketName).insertJsonobjectDocument(bucketName, documentId, documentPath);
            }

        } catch (Exception e) {

        }
    }
}
