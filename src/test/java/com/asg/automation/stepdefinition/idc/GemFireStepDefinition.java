package com.asg.automation.stepdefinition.idc;
/*
import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.LoginPage;
import com.asg.automation.pageobjects.idc.Plugin;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.DBPostgresUtil;
import com.asg.automation.utils.JsonFormater;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.jmxUtil.GemfireBase;
import com.asg.automation.utils.jmxUtil.GemfireCreateData;
import com.asg.automation.utils.jmxUtil.JmxBase;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;
import org.testng.*;

import javax.json.*;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;


public class GemFireStepDefinition extends DriverFactory  {

    private WebDriver driver;
    GemfireCreateData gfsh = new GemfireCreateData();
    GemfireBase gemfire = new GemfireBase();
    JmxBase jmx = new JmxBase();
    DBPostgresUtil db = new DBPostgresUtil();
    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            driver = getDriver();
            Assert.assertNotNull(driver);
           JmxBase.connectJMX(propLoader.prop.getProperty("gemFireHost") , propLoader.prop.getProperty("gemFirejmxPort"));
            propertyLoader();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }


    @After("@webtest")
    public void close() throws Exception {

        destroyDriver();
        db.disConnect();
        jmx.close();
    }

    @Given("^user searches for the \"([^\"]*)\" catalog$")
    public void user_searches_for_the_catalog(String catalogname) throws Throwable {
        try {
            new Plugin(driver).searchCatalog(catalogname);
            //  LoggerUtil.logLoader_info(this.getClass().getSimpleName(), value + " entered in" + name);
        } catch (Exception e) {
            System.out.println("exception :: " +e.toString());
            takeScreenShot(catalogname +" value  not entered", driver);
            Assert.fail(catalogname + " value not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^verify the search result has the \"([^\"]*)\" catalog$")
    public void verify_the_search_result_has_the_catalog(String catalogname) throws Throwable {
        try {
            sleepForSec(8000);
            new Plugin(driver).checkSearchCatalogIsPresent(catalogname);
            //  LoggerUtil.logLoader_info(this.getClass().getSimpleName(), value + " entered in" + name);
        } catch (Exception e) {
            takeScreenShot("result not found", driver);
            Assert.fail("result not found : " +e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }

    @When("^user clicks on cluster in the catalog$")
    public void user_clicks_on_cluster_in_the_catalog() throws Throwable {
        try {
            sleepForSec(1000);

            synchronizationVisibilityofElement(driver, new Plugin(driver).getCluster());
            clickOn(new Plugin(driver).getCluster());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TableLink is selected");
        } catch (Exception e) {
            takeScreenShot( " value  not entered", driver);
            Assert.fail( "value not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }

    @And("^user updates the Gemfire plugin configuration with new catalog \"([^\"]*)\"$")
    public void user_updates_the_Gemfire_plugin_configuration(String catalogName) throws Exception {

        try {
            sleepForSec(1000);
            synchronizationVisibilityofElement(driver , new Plugin(driver).getConfiguration());
            clickOn(new Plugin(driver).getConfiguration());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getConfigurationPage());
            synchronizationVisibilityofElement(driver, new Plugin(driver).getPluginName());
            enterText(new Plugin(driver).getPluginName() , "Gemfire");
            synchronizationVisibilityofElement(driver, new Plugin(driver).getPluginVersionDropdown());
            clickonWebElementwithJavaScript(driver,new Plugin(driver).getPluginVersionDropdown());
            clickonWebElementwithJavaScript(driver,new Plugin(driver).getGemFirePluginVersionSelect());
            enterText(new Plugin(driver).getCatalogNameField() , catalogName);
            enterText(new Plugin(driver).getHostName() , propLoader.prop.getProperty("gemFireHost"));
            enterText(new Plugin(driver).getLocatorPort() , "10334");
            enterText(new Plugin(driver).getJmxPort() , propLoader.prop.getProperty("gemFirejmxPort"));
            clickonWebElementwithJavaScript(driver,new Plugin(driver).getgemPluginApplyChild());
            clickonWebElementwithJavaScript(driver,new Plugin(driver).getPluginApplyParent());
            clickonWebElementwithJavaScript(driver,new Plugin(driver).getSaveButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Configuration is updated");
        } catch (Exception e) {
            takeScreenShot("Plugin Configuration is updated", driver);
            Assert.fail("Plugin Configuration is updated " +e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Then("^user gets the \"([^\"]*)\" cluster tech data and validates with db table \"([^\"]*)\"$")
    public void  user_gets_the_cluster_tech_data_validates_with_db(String catalogName , String tableName) throws Throwable {
        try
        {


            sleepForSec(1000);
            synchronizationVisibilityofElement(driver , new Plugin(driver).getClusterResult());
            synchronizationVisibilityofElement(driver , new Plugin(driver).getClusterLink());
            clickOn(new Plugin(driver).getClusterLink());
            synchronizationVisibilityofElement(driver , new Plugin(driver).getClusterPage());
            String techData = getElementText(new Plugin(driver).getTechData());
            String techdataFromDB = db.get_String_Value("select * from " +catalogName+ ".\"" +tableName+ "\""  , "techData");
               JsonObject clusterFromGemfire = JmxBase.getClusterTechData();
              if(new JSONObject(techData).toString().equalsIgnoreCase(new JSONObject(techdataFromDB.toString()).toString()))
            {
                Assert.assertTrue(true);
            }
            else {
                Assert.assertTrue(false);
            }

        }
        catch (Exception e)
        {
            takeScreenShot( " cluster data do not match with db", driver);
            Assert.fail( "cluster data do not match with db : " +e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @When("^user updates the plugin configuration and starts the analysis$")
    public void user_updates_the_plugin_configuration_starts_the_analysis() throws Throwable {
        try
        {
            String catalogName = new Plugin(driver).updatePluginConfig();
            new Plugin(driver).monitorPlugin();
            new Plugin(driver).searchCatalog(catalogName);
            new Plugin(driver).checkSearchCatalogIsPresent(catalogName);

        }
        catch (Exception e)
        {
            takeScreenShot( " value  not entered", driver);
            Assert.fail( "plugin not updated");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @When("^user clicks on host in the gemfire catalog$")
    public void user_clicks_on_host_in_the_gemfire_catalog() throws Exception {
        try {
            sleepForSec(1000);

            synchronizationVisibilityofElement(driver, new Plugin(driver).getHostLink());
            clickOn(new Plugin(driver).getHostLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TableLink is selected");
        } catch (Exception e) {
            takeScreenShot("TableLink is not Selected", driver);
            Assert.fail("TableLink not selected");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^User creates locator server and region in Gemfire$")
    public void user_creates_locator_server_and_region_in_gemfire() throws Throwable {
        try
        {
            Boolean result = gfsh.createData(propLoader.prop.getProperty("gemFireLocation") , propLoader.prop.getProperty("gemFireData"));
            Assert.assertEquals(result , Boolean.valueOf("true"));
        }
        catch (Exception e)
        {
            takeScreenShot( "Cluster not created in gemfire", driver);
            Assert.fail( "Cluster not created in gemfire " +e.toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

   @And("^user verifies the gemfire \"([^\"]*)\" catalog table techdata with the database table \"([^\"]*)\"$")
    public void user_verifies_the_gemfire_table_techdata_with_the_database_table(String catalogName , String tableName) throws Throwable {
        try
        {
               sleepForSec(1000);
               List<String> regions = jmx.getRegions();
               String totalTables = getElementText(new Plugin(driver).getResultItemCount());
               Assert.assertEquals(totalTables, String.valueOf(regions.size()));
               for (int i = 0 ; i < regions.size() ; i++)
               {
                   //JsonObject tableTechDataFromGemFire = JmxBase.getRegionTechData(regions.get(i) , propLoader.prop.getProperty("gemFireHost") , propLoader.prop.getProperty("gemFirejmxPort"));
                   clickOn(driver.findElement(By.xpath("//a[text()=' "+regions.get(i)+" ']")));
                   synchronizationVisibilityofElement(driver , driver.findElement(By.xpath("//b[text()=' "+regions.get(i)+" ']")));
                   synchronizationVisibilityofElement(driver , new Plugin(driver).getTechData());
                   String techData = getElementText(new Plugin(driver).getTechData());
                   System.out.println("techdata :: " +techData);
                   //System.out.println("techdata :: " +tableTechDataFromGemFire);
                   String techDataFromDb = db.get_String_Value("select * from " +catalogName+ ".\"" +tableName+ "\" where \""+tableName+ "\".name='"+regions.get(i)+"'" , "techData");
                   System.out.println("techdata :: " +techDataFromDb);
                   if(new JSONObject(techData).toString().equalsIgnoreCase(new JSONObject(techDataFromDb.toString()).toString()))
                   {
                       Assert.assertTrue(true);
                   }
                   else {
                       Assert.assertTrue(false);
                   }
                   clickOn(new Plugin(driver).getTableExitButton());
               }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table tech data is verified with DB");
        }

        catch (Exception e)
        {
            System.out.println("exception ::: "   +e.toString());
            takeScreenShot("Table tech data is not verified", driver);
            Assert.fail("Table tech data is not verified");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
   }

   @And("^user verifies the gemfire \"([^\"]*)\" catalog host techdata with the database table \"([^\"]*)\"$")
    public void user_verifies_the_gemfire_catalog_host_techdata_with_the_database_table(String catalogName ,  String tableName) throws Throwable {

      try {
       sleepForSec(1000);
       List<String> members = jmx.getMembers();
       String totalmembers = getElementText(new Plugin(driver).getResultItemCount());
       Assert.assertEquals(totalmembers, String.valueOf(members.size()));
       for (int i = 0 ; i < members.size() ; i++)
       {
           //JsonObject tableTechDataFromGemFire = JmxBase.getRegionTechData(regions.get(i) , propLoader.prop.getProperty("gemFireHost") , propLoader.prop.getProperty("gemFirejmxPort"));
           clickOn(driver.findElement(By.xpath("//a[text()=' "+members.get(i)+" ']")));
           synchronizationVisibilityofElement(driver , driver.findElement(By.xpath("//b[text()=' "+members.get(i)+" ']")));
           synchronizationVisibilityofElement(driver , new Plugin(driver).getTechData());
           String techData = getElementText(new Plugin(driver).getTechData());
           System.out.println("techdata :: " +techData);
           //System.out.println("techdata :: " +tableTechDataFromGemFire);
           String techDataFromDb = db.get_String_Value("select * from " +catalogName+ ".\"" +tableName+ "\" where \""+tableName+ "\".name='"+members.get(i)+"'" , "techData");
           System.out.println("techdata :: " +techDataFromDb);
           if(new JSONObject(techData).toString().equalsIgnoreCase(new JSONObject(techDataFromDb.toString()).toString()))
           {
               Assert.assertTrue(true);
           }
           else {
               Assert.assertTrue(false);
           }
           clickOn(new Plugin(driver).getHostExitButton());
       }
       LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Host tech data is verified with DB");
   }

        catch (Exception e)
    {
        System.out.println("exception ::: "   +e.toString());
        takeScreenShot("Host tech data is not verified", driver);
        Assert.fail("Host tech data is not verified");
        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
    }
   }

}
*/