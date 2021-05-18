package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.DBPostgresUtil;
import com.asg.automation.utils.JsonFormater;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.jmxUtil.JmxBase;
import com.asg.automation.utils.jmxUtil.Neo4jBase;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.json.JSONObject;
import org.neo4j.driver.v1.Driver;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import org.testng.*;
import org.json.JSONObject;

import javax.json.JsonObject;
import java.util.List;


public class Neo4jStepDefinition extends DriverFactory {


    private WebDriver driver;

    private Driver neoDriver;

    DBPostgresUtil db = new DBPostgresUtil();

    private Neo4jBase neo4j = new Neo4jBase();

    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
            //  neo4j.createDbConnection(propLoader.prop.getProperty("boltURL") , propLoader.prop.getProperty("neo4juser") , propLoader.prop.getProperty("neo4jpassword"));
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @Before("@datacreation")
    public void neo4jdataCreation() throws Exception {
        try {
            neo4j.createDbConnection(propLoader.prop.getProperty("boltURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @After("@webtest")
    public void close() throws Exception {
        //new Driv  erFactory(BrowserName).destroyDriver();
        destroyDriver();
        db.disConnect();
        //   neo4j.close();
    }

    @After("@datacreation")
    public void neo4jdClose() throws Exception {
        neo4j.close();
    }


    @Given("^user clicks on service in the catalog$")
    public void user_clicks_on_service_in_the_catalog() throws Exception {
        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getShowAll());
            clickOn(new Plugin(driver).getShowAll());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getServiceLink());
            clickOn(new Plugin(driver).getServiceLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "ServiceLink is selected");
        } catch (Exception e) {
            takeScreenShot("ServiceLink is not Selected", driver);
            Assert.fail("ServiceLink not selected");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^user connects to neoDB \"([^\"]*)\" gets the \"([^\"]*)\" service tech data and validates with db table \"([^\"]*)\"")
    public void user_connects_to_neoDB_gets_the_service_tech_data_and_validates_with_db(String arg, String catalogName, String TableName) throws Exception {

        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getServiceResult());
            clickOn(new Plugin(driver).getServiceResult());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getServicePage());
            String appVersion = getElementText(new Plugin(driver).getAppVersion());
            String description = getElementText(new Plugin(driver).getDescription());
            String appVersionFromDB = db.get_String_Value("select * from " + catalogName + ".\"" + TableName + "\"", "appVersion");
            String descriptionFromDB = db.get_String_Value("select * from " + catalogName + ".\"" + TableName + "\"", "description");
            if (arg.equalsIgnoreCase("Enterprise Edition")) {
                neo4j.createDbConnection(propLoader.prop.getProperty("boltURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            } else if (arg.equalsIgnoreCase("Community Edition")) {
                neo4j.createDbConnection(propLoader.prop.getProperty("boltCommunityURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            }
            List<String> serviceDataFromNeo4j = neo4j.readNeo4jComponents();
            Assert.assertEquals(serviceDataFromNeo4j.get(1).toString(), appVersion);
            Assert.assertEquals(serviceDataFromNeo4j.get(2).toString(), description);
            Assert.assertEquals(appVersion, appVersionFromDB);
            Assert.assertEquals(description, descriptionFromDB);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "ServiceResult is selected and verified with DB");
        } catch (Exception e) {
            takeScreenShot("ServiceResult is not Verified", driver);
            Assert.fail("ServiceResult is not Verified " + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }

    @When("^user clicks on database in the neo4j catalog$")
    public void user_clicks_on_database_in_the_neo4j_catalog() throws Exception {
        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getShowAll());
            clickOn(new Plugin(driver).getShowAll());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getDatabaseLink());
            clickOn(new Plugin(driver).getDatabaseLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DatabaseLink is selected");
        } catch (Exception e) {
            takeScreenShot("DatabaseLink is not Selected", driver);
            Assert.fail("DatabaseLink not selected");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^User connects to neo4j and creates data$")
    public void user_connects_to_neo4j_and_creates_data() throws Exception {
        try {

            String result = neo4j.createData(propLoader.prop.getProperty("neo4jdata"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data created in Neo4j DB");
        } catch (Exception e) {
            takeScreenShot("Data not created in Neo4j", driver);
            Assert.fail("Data not created in Neo4j : " + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^user verifies data is created in neo4j$")
    public void user_verifies_data_is_created_in_neo4j() throws Exception {
        try {
            List<String> labels = neo4j.getLabels();
            Assert.assertTrue(labels.size() > 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data is present in Neo4j DB");
        } catch (Exception e) {
            takeScreenShot("No data in Neo4j", driver);
            Assert.fail("No data in Neo4j : " + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        }

    }


    @Then("^user gets the \"([^\"]*)\" database tech data and validates with db table \"([^\"]*)\"$")
    public void user_gets_the_database_tech_data_and_validates_with_db(String catalogName, String TableName) throws Exception {

        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getDatabaseResult());
            clickOn(new Plugin(driver).getDatabaseResult());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getDatabasePage());
            String unformatedTechData = getElementText(new Plugin(driver).getTechData());
            String formattedTechData = CommonUtil.getTextWithoutNextLineInResponse(unformatedTechData).replaceAll("\\s","");
            String techdataFromDB = db.get_String_Value("select * from " + catalogName + ".\"" + TableName + "\"", "techData");
            String formattedTechdataFromDB = CommonUtil.getTextWithoutWhiteSpace(techdataFromDB);
            Assert.assertEquals(formattedTechData,formattedTechdataFromDB);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database TechData is selected and verified with DB");
        } catch (Exception e) {
            takeScreenShot("Database TechData is not verified", driver);
            Assert.fail("Database TechData is not verified :: " + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }


    @When("^user clicks on table in the gemfire catalog$")
    public void user_clicks_on_table_in_the_gemfire_catalog() throws Exception {
        try {
            sleepForSec(1000);

            synchronizationVisibilityofElement(driver, new Plugin(driver).getTableLink());
            clickOn(new Plugin(driver).getTableLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TableLink is selected");
        } catch (Exception e) {
            takeScreenShot("TableLink is not Selected", driver);
            Assert.fail("TableLink not selected");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @When("^user clicks on table in the neo4j catalog$")
    public void user_clicks_on_table_in_the_neo4j_catalog() throws Exception {
        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getShowAll());
            clickOn(new Plugin(driver).getShowAll());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getTableLink());
            clickOn(new Plugin(driver).getTableLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TableLink is selected");
        } catch (Exception e) {
            takeScreenShot("TableLink is not Selected", driver);
            Assert.fail("TableLink not selected");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^user connects to neoDB \"([^\"]*)\" gets the \"([^\"]*)\" table tech data and validates with db table \"([^\"]*)\"$")
    public void user_connects_to_neoDB_gets_the_table_tech_data_and_validates_with_db(String arg, String catalogName, String TableName) throws Exception {

        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getTableResult());
            if (arg.equalsIgnoreCase("Enterprise Edition")) {
                neo4j.createDbConnection(propLoader.prop.getProperty("boltURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            } else if (arg.equalsIgnoreCase("Community Edition")) {
                neo4j.createDbConnection(propLoader.prop.getProperty("boltCommunityURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            }
            List<String> labels = neo4j.getLabels();
            String totalTables = getElementText(new Plugin(driver).getResultItemCount());
            Assert.assertEquals(totalTables, String.valueOf(labels.size()));
            for (int i = 0; i < labels.size(); i++) {
                JsonObject tableTechDataFromNeo4j = neo4j.buildTableTechData(labels.get(i));
                new Plugin(driver).clickItemValue(labels.get(i).replaceAll("^\"|\"$", ""));
                synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//b[text()=' " + labels.get(i).replaceAll("^\"|\"$", "") + " ']")));
                synchronizationVisibilityofElement(driver, new Plugin(driver).getTechData());
                String techData = getElementText(new Plugin(driver).getTechData()).replaceAll("\\r|\\n", "").replaceAll("\\s","");;;
                if (new JSONObject(techData).toString().equalsIgnoreCase(new JSONObject(tableTechDataFromNeo4j.toString()).toString())) {
                    Assert.assertTrue(true);
                } else {
                    Assert.assertTrue(false);
                }
                clickOn(new Plugin(driver).getTableExitButton());
                clickOn(new Plugin(driver).getTableLink());
                waitForAngularLoad(driver);
                clickOn(new Plugin(driver).getTableLink());
                waitForAngularLoad(driver);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table tech data is verified with DB");
        } catch (Exception e) {
            takeScreenShot("Table tech data is not verified", driver);
            Assert.fail("Table tech data is not verified");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }finally {
            neo4j.close();
        }


    }


    @And("^user gets the table data sample and validates the columns in neoDB \"([^\"]*)\"$")
    public void user_gets_the_table_sample_data_and_validates_the_columns_in_neoDB(String arg) throws Exception {
        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getTableResult());
            if(arg.equalsIgnoreCase("Enterprise Edition")) {
                neo4j.createDbConnection(propLoader.prop.getProperty("boltURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            }else if(arg.equalsIgnoreCase("Community Edition")){
                neo4j.createDbConnection(propLoader.prop.getProperty("boltCommunityURL"), propLoader.prop.getProperty("neo4juser"), propLoader.prop.getProperty("neo4jpassword"));
            }
            List<String> labels = neo4j.getLabels();
            String totalTables = getElementText(new Plugin(driver).getResultItemCount());
            Assert.assertEquals(totalTables, String.valueOf(labels.size()));
            for (int i = 0; i < labels.size(); i++) {
                Long labelPropertiesCount = neo4j.readCountOfLabelProperties(labels.get(i).replaceAll("^\"|\"$", ""));
                new Plugin(driver).clickItemValue(labels.get(i).replaceAll("^\"|\"$", ""));
                synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//b[text()=' " + labels.get(i).replaceAll("^\"|\"$", "") + " ']")));
                clickOn(new Plugin(driver).getSampleDataLink());
                synchronizationVisibilityofElement(driver, new Plugin(driver).getSampleDataTitle());
                List<WebElement> columnTitles = new Plugin(driver).getSampleDataColumns();
                Assert.assertEquals(Long.valueOf(columnTitles.size()), labelPropertiesCount);
                clickOn(new Plugin(driver).getTableExitButton());
                synchronizationVisibilityofElement(driver, new Plugin(driver).getTableLink());
                clickOn(new Plugin(driver).getTableLink());
                waitForAngularLoad(driver);
                clickOn(new Plugin(driver).getTableLink());
                waitForAngularLoad(driver);
            }
        } catch (Exception e) {

            takeScreenShot("Sample columns are not correct", driver);
            Assert.fail("Sample columns are not correct " + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        finally {
            neo4j.close();
        }
    }


    @And("^user updates the Neo4j plugin configuration with new catalog \"([^\"]*)\"$")
    public void user_updates_the_Neo4j_plugin_configuration(String catalogName) throws Exception {

        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getConfiguration());
            clickOn(new Plugin(driver).getConfiguration());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getConfigurationPage());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getPluginName());
            enterText(new Plugin(driver).getPluginName(), "Neo4j");
            synchronizationVisibilityofElement(driver, new Plugin(driver).getPluginVersionDropdown());
            clickonWebElementwithJavaScript(driver, new Plugin(driver).getPluginVersionDropdown());
            clickonWebElementwithJavaScript(driver, new Plugin(driver).getPluginVersionSelect());
            clickOn(new Plugin(driver).getCatalogNameField());
            traverseListContainsElementAndClick(driver, new Plugin(driver).getDropdownValues(), catalogName);
            enterText(new Plugin(driver).getRepositoryUrl(), propLoader.prop.getProperty("boltURL"));
            enterText(new Plugin(driver).getRepositoryUser(), propLoader.prop.getProperty("neo4juser"));
            enterText(new Plugin(driver).getRepositoryPassword(), propLoader.prop.getProperty("neo4jpassword"));
            clickonWebElementwithJavaScript(driver, new Plugin(driver).getPluginApplyChild());
            clickonWebElementwithJavaScript(driver, new Plugin(driver).getPluginApplyParent());
            sleepForSec(5000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Configuration is updated");
        } catch (Exception e) {
            takeScreenShot("Plugin Configuration is updated", driver);
            Assert.fail("Plugin Configuration is updated " + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @And("^user monitors the \"([^\"]*)\" and starts the analysis on \"([^\"]*)\" plugin$")
    public void user_monitors_the_node_and_starts_the_analysis_on_plugin(String nodeName, String pluginName) throws Exception {
        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getLocalNodeActionButton());
            clickOn(new Plugin(driver).getLocalNodeActionButton());
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getMonitorLink(),10);
            clickonWebElementwithJavaScript(driver, new Plugin(driver).getMonitorLink());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getMonitorPane());
            sleepForSec(10000);
            synchronizationVisibilityofElement(driver, new Plugin(driver).getStatusIdleCheck(pluginName), 360);
            clickonWebElementwithJavaScript(driver, new Plugin(driver).getPluginStartButton(pluginName));
            synchronizationVisibilityofElement(driver, new Plugin(driver).getRunningStatusCheck(), 10);
            try {
                while (isElementPresent(new Plugin(driver).getStatusRunningCheck(pluginName)) == true)
                {
                    sleepForSec(1000);
                }
            }catch(Exception e)
            {
                e.printStackTrace();
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Configuration started");
        } catch (Exception e) {
            takeScreenShot("Plugin configuration cannot be started", driver);
            Assert.fail("Error is starting Plugin Configuration" + e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }


}
