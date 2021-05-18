package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.WebDataConnectorSimulator;
import com.asg.automation.utils.DBPostgresUtil;
import com.asg.automation.utils.JsonRead;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.PostgresSqlBuilder;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.Alert;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.interactions.Keyboard;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;


import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.*;
import java.util.List;

/**
 * Created by mohankumar.boopalan on 11/7/2017.
 */
public class WebDataConnectorStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;

    @Before("@webtest")
    public void beforeScenario() {
        try {

            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
            jsonRead = new JsonRead();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }


    @After("@webtest")
    public void close() {
        destroyDriver();
    }

    @Given("^User launch browser and traverse to Web Data Connector of tableau simulator$")
    public void user_launch_browser_and_traverse_to_Web_Data_Connector_of_tableau_simulator()  {
        try{
            launchBrowser(driver,propLoader.prop.getProperty("webDataConnector"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Web Data Connector simulator for tableau is started");
        }catch(Exception e){
            Assert.fail("Web Data Connector simulator for tableau is not started");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Web Data Connector simulator for tableau is not started" + e.getMessage());
        }

    }

    @When("^User enters the web data connector URL for tableau simulator$")
    public void user_enters_the_web_data_connector_tableau_simulator()  {
        try {
            enterText(new WebDataConnectorSimulator(driver).returnConnectorURLTextBox(), propLoader.prop.getProperty("connectorURL"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Web Data Connector URL has been entered successfully");
        } catch (Exception e) {
            Assert.fail("Web Data Connector URL colud not be entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Web Data Connector URL colud not be entered" +e.getMessage());
        }
    }

    @When("^User clicks on start interactive phase button$")
    public void user_clicks_on_start_interactive_phase_button()  {
        try{
            clickonWebElementwithJavaScript(driver,new WebDataConnectorSimulator(driver).returnStartInteractivePhaseButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Web connector interactive session button has been clicked");
        }catch (Exception e){
            Assert.fail("Web connector interactive session button coluld not be clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Web connector interactive session button coluld not be clicked" +e.getMessage());
        }

    }

    @Then("^User should be able to see the list of tables from postgres$")
    public void user_should_be_able_to_see_the_list_of_tables_from_postgres()  {
        try {
            sleepForSec(3000);
            switchToChildWindow(driver);
            isElementPresent(new WebDataConnectorSimulator(driver).retrunfirstTableFromResult());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"First table is present in the simulator");
            Assert.assertTrue((new WebDataConnectorSimulator(driver).returntablesListPreview().size() > 0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tables list preview is showing");
        }catch (Exception e){
            Assert.fail("Web Data connector could not connect to postgres. Simulation failed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Web Data connector could not connect to postgres. Simulation failed");
        }

    }


    @And("^user navigates to Authorization window and enters Admin credentials and catalog name$")
    public void userNavigatesToAuthorizationWindowAndEntersAdminCredentialsAndCatalogName()  {
        try {

            sleepForSec(5000);
            Robot r=new Robot();
            r.keyPress(KeyEvent.VK_ENTER);

            switchToChildWindow(driver);
            sleepForSec(3000);
//            pressEnterKey(driver);

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Switched to Authorization window");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert has been accepted");
            enterText(new WebDataConnectorSimulator(driver).returnSimulatorUserName(), "TestService");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User name is entered");
            enterText(new WebDataConnectorSimulator(driver).returnSimulatorPassword(), "Service");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Password is entered");
            enterTextWithJavaScript(driver,"BigData",new WebDataConnectorSimulator(driver).returnSimulatorCatalogName());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog is inputted properly");
            clickOn(new WebDataConnectorSimulator(driver).returnsimulatorGetDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Get Data button has been clicked");
            sleepForSec(5000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Switched to simulation window");
        }catch (Exception e){
            Assert.fail("Web Data connector Authorization is failed" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Web Data connector Authorization is failed" +e.getMessage());
        }

    }

    @And("^User clicks on fetch table data button for Database table$")
    public void userClicksOnFetchTableDataButtonForDatabaseTable()  {
        try{
            scrollToWebElement(driver,new WebDataConnectorSimulator(driver).returndatabaseTableFetchDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Broser has been scrolled to metioned webElement");
            clickOn(new WebDataConnectorSimulator(driver).returndatabaseTableFetchDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Fetch Table Data has been clicked");
            sleepForSec(5000);
        }catch (Exception e){
            Assert.fail("Browser colud not be scrolled or Fetch Table Data button could not be clicked" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Browser colud not be scrolled or Fetch Table Data button could not be clicked");
        }

    }

    @And("^User should be able to view the data items from the Database table$")
    public void userShouldBeAbleToViewTheDataItemsFromTheDatabaseTable()  {
        try{
            sleepForSec(20000);
            Assert.assertTrue(new WebDataConnectorSimulator(driver).returndatabaseTableContents().size() >= 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Database table contents have been loaded successfully");
        }catch(Exception e){
            Assert.fail("Database table contents could not loaded" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Database table contents could not loaded");
        }

    }

    @Then("^items data count from  simulator should match databases item count from postgres database$")
    public void itemsDataCountFromSimulatorShouldMatchDatabasesItemCountFromPostgresDatabase(DataTable dataTableCollection) {
           DBPostgresUtil db_postgres_util = new DBPostgresUtil();
           List<String> criteriaValue = new ArrayList<>();
           PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
           int rowCount = 0;
           try {
               String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
               LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Query is generated" +queryBuilder);
               rowCount = db_postgres_util.get_rowCount(queryBuilder);
               LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
               Assert.assertEquals(rowCount,new WebDataConnectorSimulator(driver).returnDatabaseList().size());
               LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Database count from postgres and simulator is matching as expected");
       }catch(Exception e){
               Assert.fail("Database count from postgres and simulator is not matching" +e.getMessage());
               LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Query could not be generated" +e.getMessage());
           }
    }

    @And("^User clicks on fetch table data button for Data Sample table$")
    public void userClicksOnFetchTableDataButtonForDataSampleTable()  {
        try{
            scrollToWebElement(driver,new WebDataConnectorSimulator(driver).returndatasampleTableFetchDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Browser has been scrolled to metioned webElement");
            clickOn(new WebDataConnectorSimulator(driver).returndatasampleTableFetchDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Fetch Table Data has been clicked");
            sleepForSec(5000);
        }catch (Exception e){
            Assert.fail("Browser colud not be scrolled or Fetch Table Data button could not be clicked" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Browser colud not be scrolled or Fetch Table Data button could not be clicked");
        }
    }

    @And("^User should be able to view the data items from the Data Sample table$")
    public void userShouldBeAbleToViewTheDataItemsFromTheDataSampleTable()  {
        try{
            Assert.assertTrue(new WebDataConnectorSimulator(driver).returndatasampleTableContents().size() >= 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"DataSample table contents have been loaded successfully");
        }catch(Exception e){
            Assert.fail("DataSample table contents could not be loaded" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"DataSample table contents could not be loaded");
        }

    }

    @Then("^items data count from  simulator should match Data Sample item count from postgres database$")
    public void itemsDataCountFromSimulatorShouldMatchDataSampleItemCountFromPostgresDatabase(DataTable dataTableCollection)  {
        DBPostgresUtil db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int rowCount = 0;
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Query is generated" +queryBuilder);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount,new WebDataConnectorSimulator(driver).returndatasampleList().size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"DataSample count from postgres and simulator is matching as expected");
        }catch(Exception e){
            Assert.fail("DataSample count from postgres and simulator is not matching" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Query could not be generated" +e.getMessage());
        }

    }

    @And("^User clicks on fetch table data button for Directory table$")
    public void userClicksOnFetchTableDataButtonForDirectoryTable()  {
        try{
            scrollToWebElement(driver,new WebDataConnectorSimulator(driver).returndirectoryTableFetchDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Browser has been scrolled to metioned webElement");
            clickOn(new WebDataConnectorSimulator(driver).returndirectoryTableFetchDataButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Fetch Table Data has been clicked");
            sleepForSec(5000);
        }catch (Exception e){
            Assert.fail("Browser colud not be scrolled or Fetch Table Data button could not be clicked" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Browser colud not be scrolled or Fetch Table Data button could not be clicked");
        }
    }

    @And("^User should be able to view the data items from the Directory table$")
    public void userShouldBeAbleToViewTheDataItemsFromTheDirectoryTable()  {
        try{
            Assert.assertTrue(new WebDataConnectorSimulator(driver).returndirectotyTableContents().size() >= 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Directories table contents have been loaded successfully");
        }catch(Exception e){
            Assert.fail("DataSample table contents could not be loaded" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Directories table contents could not be loaded");
        }
    }

    @Then("^items data count from  simulator should match Diretory item count from postgres database$")
    public void itemsDataCountFromSimulatorShouldMatchDiretoryItemCountFromPostgresDatabase(DataTable dataTableCollection)  {
        DBPostgresUtil db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int rowCount = 0;
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Query is generated" +queryBuilder);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount,new WebDataConnectorSimulator(driver).returndirectoriesList().size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Directories count from postgres and simulator is matching as expected");
        }catch(Exception e){
            Assert.fail("Directories count from postgres and simulator is not matching" +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Query could not be generated" +e.getMessage());
        }
    }

}
