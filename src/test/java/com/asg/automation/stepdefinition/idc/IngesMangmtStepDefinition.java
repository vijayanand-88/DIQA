package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.Ingestion_Management;
import com.asg.automation.pageobjects.idc.SubjectAreaManagement;
import com.asg.automation.utils.JsonRead;
import com.asg.automation.utils.LoggerUtil;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;

import java.util.List;

//import LoggerUtil;

/**
 * Created by muthuraja.ramakrishn on 4/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class IngesMangmtStepDefinition extends DriverFactory {
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
        //new DriverFactory(BrowserName).destroyDriver();
        destroyDriver();

    }

    @Then("^created configuration must be listed$")
    public void created_configuration_must_be_listed() {

        try {
            Assert.assertTrue(new Ingestion_Management(driver).returnClusterTest());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Created Configuration must be listed: " + new Ingestion_Management(driver).returnClusterTest());
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^created configuration must not be listed$")
    public void created_configuration_must_not_be_listed() {

        try {
            if (new Ingestion_Management(driver).returnClusterTest()) {
                Assert.fail(new Ingestion_Management(driver) + "Element still present in the page");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see Ingestion configuration$")
    public void user_should_be_able_to_see_Ingestion_configuration() {

        try {
            Assert.assertTrue(new Ingestion_Management(driver).getIngestionConfigurationFirstTitle().isDisplayed());
        } catch (Exception e) {
            //LoggerUtil.Log.warning("Not able to find the ingestion configurations");
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user click on Ingestion Configurations first cluster$")
    public void user_click_on_Ingestion_Configurations_first_cluster() {

        try {
            clickOn(new Ingestion_Management(driver).getIngestionConfigurationFirstTitle());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see the setting of Ingestion Configuration$")
    public void user_should_be_able_to_see_the_setting_of_Ingestion_Configuration() {

        try {
            Assert.assertTrue(new Ingestion_Management(driver).getIngestionScannerSettings().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.warning("Ingestion configuration settings are not visible");
            Assert.fail(e.getMessage());
        }
    }

    @When("^user click on create button$")
    public void user_click_on_create_button() {
        try {
            Assert.assertTrue(new Ingestion_Management(driver).getCreateIngestionButton().isDisplayed());
            sleepForSec(1000);
            clickOn(new Ingestion_Management(driver).getCreateIngestionButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.warning("Creation button is not visible");
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user should be seeing New Ingestion COnfiguration panel$")
    public void user_should_be_seeing_New_Ingestion_COnfiguration_panel() {
        try {
            Assert.assertTrue(new Ingestion_Management(driver).getNewIngestionConfigPanel().isDisplayed());
            verifyEquals(new Ingestion_Management(driver).getNewIngestionConfigPanel().getText(), "NEW INGESTION CONFIGURATION");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.warning("New Ingestion configutration is not visible");
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user should see lables of Name Type and Subject area$")
    public void user_should_see_lables_of_Name_Type_and_Subject_area() {
        try {
            Assert.assertTrue(new Ingestion_Management(driver).getLabelName().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.warning("Name label is not displaying");
            Assert.fail(e.getMessage());
        }
        try {
            Assert.assertTrue(new Ingestion_Management(driver).getLabelType().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.warning("Type label is not displaying");
            Assert.fail(e.getMessage());
        }
        try {
            Assert.assertTrue(new Ingestion_Management(driver).getLabelSubjectArea().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.warning("Subject Area label is not displaying");
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should see config type as Cataloger$")
    public void user_should_see_config_type_as_Cataloger() {
        try {
            dropdownOptionsCheck("Cataloger", new Ingestion_Management(driver).getingestionType());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should able to see list of available subject area in subject Area dropdown$")
    public void user_should_able_to_see_list_of_available_subject_area_in_subject_Area_dropdown() {
        int availablesubjectArea = 0;
        int countOfSubjectArea;
        try {
            clickOn(new Ingestion_Management(driver).getsubjectAreaDropDown());
            sleepForSec(1000);
            availablesubjectArea = new Ingestion_Management(driver).retruncatalogListFromIngestion().size();
            clickOn(new DashBoardPage(driver).getHomeButton());
            sleepForSec(1000);
            clickOn(new DashBoardPage(driver).getsubjectAreaManagerLink());

            countOfSubjectArea = new SubjectAreaManagement(driver).returnListOfSubjectAreas().size();
            //LoggerUtil.Log.info("Dropdown list size is"+availablesubjectArea);
            //LoggerUtil.Log.info("Count of Subject Area is"+countOfSubjectArea);
            Assert.assertEquals(availablesubjectArea, countOfSubjectArea);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user enters the new ingestion cataloger name$")
    public void user_enters_the_new_ingestion_cataloger_name() {
        try {
//            enterTextWithJavaScript(driver, new JsonRead().readJSon("HiveCatalogerCreation", "NewClusterName"),
//                    new Ingestion_Management(driver).getingestionName());
            enterText(new Ingestion_Management(driver).getingestionName(), jsonRead.readJSon("HiveCatalogerCreation", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enter the Name", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter the name " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter the Name" + e.getMessage());
        }
    }

    @When("^user selects the SubjectArea as BigData and click on link on cataloger$")
    public void user_selects_the_SubjectArea_as_BigData_and_click_on_link_on_cataloger() {
        try {
            //dropdownSelectbyText("BigData", new Ingestion_Management(driver).getsubjectAreaDropDown());
            clickOn(new Ingestion_Management(driver).getsubjectAreaDropDown());
            clickOn(new Ingestion_Management(driver).retrunBigDataDropDown());
            clickOn(new Ingestion_Management(driver).getaddLink());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user chooses cataloger type as Hive and add link for filter$")
    public void user_chooses_cataloger_type_as_Hive_and_add_link_for_filter() {
        try {
            //dropdownSelectbyText("Hive Cataloger", new Ingestion_Management(driver).getCatalogerDropDown());
            clickonWebElementwithJavaScript(driver, new Ingestion_Management(driver).getingTypeDropDown());
            clickOn(new Ingestion_Management(driver).gethiveOption());
            enterText(new Ingestion_Management(driver).getdeltaTime(),
                    new JsonRead().readJSon("HiveCatalogerCreation", "Delta Time"));
            clickOn(new Ingestion_Management(driver).getAddLinkinCataloger());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user enters the Filter name checks the Tag Big data and Data analytics$")
    public void user_enters_the_Filter_name_checks_the_Tag_Big_data_and_Data_analytics() {

        try {
            enterText(new Ingestion_Management(driver).getFiltername(),
                    new JsonRead().readJSon("HiveCatalogerCreation", "Filter Name"));
            /*clickOn(new Ingestion_Management(driver).getDataAnalyticsTag());
            clickOn(new Ingestion_Management(driver).getBigDataTag());*/
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }

    }

    @When("^user enters the Filter name checks the Tag Big data$")
    public void user_enters_the_Filter_name_checks_the_Tag_Big_data() {
        try {
            enterText(new Ingestion_Management(driver).getFiltername(),
                    new JsonRead().readJSon("HiveCatalogerCreation", "Filter Name"));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @When("^user clicks on save and clicks on add Filter to add HDFS cataloger$")
    public void user_clicks_on_save_and_clicks_on_add_Filter_to_add_HDFS_cataloger() {
        try {
            clickOn(new Ingestion_Management(driver).getSaveButtonAtFilter());
            // synchronizationVisibilityofElement(driver, new Ingestion_Management(driver).getSaveButtonAtCatalogers());
            sleepForSec(40);
            clickOn(new Ingestion_Management(driver).getSaveButtonAtFilter());
            // synchronizationVisibilityofElement(driver, new Ingestion_Management(driver).getaddLink());
            clickOn(new Ingestion_Management(driver).getaddLink());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user chooses cataloger type as HDFS and clicks on add link for filter$")
    public void user_chooses_cataloger_type_as_HDFS_and_clicks_on_add_link_for_filter() {
        try {
            //dropdownSelectbyText("Hdfs Cataloger", new Ingestion_Management(driver).getCatalogerDropDown());
            clickonWebElementwithJavaScript(driver, new Ingestion_Management(driver).getingTypeDropDown());
            clickOn(new Ingestion_Management(driver).gethdfsOption());
//            enterText(new Ingestion_Management(driver).getHDFSName(),
//                    new JsonRead().readJSon("HiveCatalogerCreation", "HDFSName"));
            clickOn(new Ingestion_Management(driver).getAddLinkinCataloger());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on save on all Scanner Configuration$")
    public void user_clicks_on_save_on_all_Scanner_Configuration() {
        try {
            clickOn(new Ingestion_Management(driver).getSaveButtonAtFilter());
            sleepForSec(30);
            clickOn(new Ingestion_Management(driver).getSaveButtonAtFilter());
            sleepForSec(300);
            clickOn(new Ingestion_Management(driver).getSaveButtonAtFilter());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see the new ingestion cataloger$")
    public void user_should_be_able_to_see_the_new_ingestion_cataloger() {

        try {
            isElementPresent(new Ingestion_Management(driver).getNewlyCreatedCatalogName());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on cataloger and clicks on Hive catalog and Filter link$")
    public void user_clicks_on_cataloger_and_clicks_on_Hive_catalog_and_Filter_link() {

        try {
            waitandFindElement(driver, new Ingestion_Management(driver).getNewlyCreatedCatalogName(), 4, false);
            clickOn(new Ingestion_Management(driver).getNewlyCreatedCatalogName());
            clickOn(new Ingestion_Management(driver).getHiveCatalogSetting());
            implicit_wait(driver, 5);
            isElementPresent(new Ingestion_Management(driver).getAddLinkinCataloger());
            clickOn(new Ingestion_Management(driver).getAddLinkinCataloger());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user should be able to close the Filter cataloger and Edit scanner settings panel$")
    public void user_should_be_able_to_close_the_Filter_cataloger_and_Edit_scanner_settings_panel() {
        try {
            synchronizationVisibilityofElement(driver, new Ingestion_Management(driver).getClosebutton());
            clickOn(new Ingestion_Management(driver).getClosebutton());
            implicit_wait(driver, 5);
            isElementPresent(new Ingestion_Management(driver).getClosebutton());
            clickOn(new Ingestion_Management(driver).getClosebutton());
            implicit_wait(driver, 5);
            isElementPresent(new Ingestion_Management(driver).getClosebutton());
            clickOn(new Ingestion_Management(driver).getClosebutton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user click on HiveCataloger to run the Hive ingestion$")
    public void user_click_on_HiveCataloger_to_run_the_Hive_ingestion() {
        try {
            synchronizationVisibilityofElement(driver, new Ingestion_Management(driver).getHiveCatalogerRunLink());
            clickOn(new Ingestion_Management(driver).getHiveCatalogerRunLink());
            implicit_wait(driver, 10);
            clickOn(new DashBoardPage(driver).getnotificationsIcon());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @When("^user click on HDFSCataloger to run the HDFS ingestion$")
    public void user_click_on_HDFSCataloger_to_run_the_HDFS_ingestion() {
        try {
            synchronizationVisibilityofElement(driver, new Ingestion_Management(driver).getHDFSCatalogerRunLink());
            clickOn(new Ingestion_Management(driver).getHDFSCatalogerRunLink());
            implicit_wait(driver, 10);
            clickOn(new DashBoardPage(driver).getnotificationsIcon());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters leading space in the name field in the New Ingestion Configuration panel$")
    public void user_enters_leading_space_in_the_name_field_in_the_New_Ingestion_Configuration_panel() {
        try {
            new Ingestion_Management(driver).getingestionName().sendKeys(new JsonRead().readJSon("LeadingSpace", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enters leading space", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters leading space" + e.getMessage());
        }
    }

    @When("^user enters trailing space in the name field in the New Ingestion Configuration panel$")
    public void user_enters_trailing_space_in_the_name_field_in_the_New_Ingestion_Configuration_panel() {
        try {
            enterText(new Ingestion_Management(driver).getingestionName(), new JsonRead().readJSon("TrailingSpace", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enters trailing space", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters trailing space" + e.getMessage());
        }
    }

    @When("^user enters Slash in the name field in the New Ingestion Configuration panel$")
    public void user_enters_Slash_in_the_name_field_in_the_New_Ingestion_Configuration_panel() {
        try {
            enterText(new Ingestion_Management(driver).getingestionName(), new JsonRead().readJSon("Forwardslash", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enters slash", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters slash" + e.getMessage());
        }
    }

    @When("^user enters Backslash in the name field in the New Ingestion Configuration panel$")
    public void user_enters_Backslash_in_the_name_field_in_the_New_Ingestion_Configuration_panel() {
        try {
            enterText(new Ingestion_Management(driver).getingestionName(), new JsonRead().readJSon("Backslash", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enters Backslash", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters Backslash" + e.getMessage());
        }
    }

    @Then("^all the ingestions under Cluster Demo should be in \"([^\"]*)\" status$")
    public void all_the_ingestions_under_Cluster_Demo_should_be_in_status(String arg1) {
        clickOn(new Ingestion_Management(driver).getingestionRefreshButton());
        fluentWait(driver, 3000, 3);
        List<WebElement> ingestionsStatus = new Ingestion_Management(driver).getclusterDemoIngestionStatus();
        for (WebElement ele : ingestionsStatus) {
            Assert.assertEquals(ele.getText(), arg1);
        }

    }

    @When("^user clicks on save button on the New Ingestion panel$")
    public void user_clicks_on_save_button_on_the_New_Ingestion_panel() {
        try {
            clickOn(new Ingestion_Management(driver).getSaveButtonAtIngestionConfig());
        } catch (Exception e) {
            takeScreenShot("Not able to click on save button", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to click on save button " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());

        }
    }

}
