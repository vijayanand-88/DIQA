package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.CommonActions;
import com.asg.automation.pageactions.idc.DashboardActions;
import com.asg.automation.pageobjects.idc.CommonPage;
import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.pageobjects.idc.DataSets;
import com.asg.automation.pageobjects.idc.PluginManager;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.testng.Assert;
import org.testng.asserts.SoftAssert;

import java.io.File;
import java.util.*;

public class CommonStepDefinition extends DriverFactory {

    private WebDriver driver;
    private DBPostgresUtil db_postgres_util;
    private FileUtil fileUtil;
    private CommonUtil commonUtil;
    private DBHelper dbHelper = new DBHelper();

    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
            fileUtil = new FileUtil();
            commonUtil = new CommonUtil();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @After("@webtest")
    public void close() throws Exception {
        destroyDriver();

    }

    @And("^user verifies whether the status text color and given color are same$")
    public void userVerifiesThatStatusIsDisplayedWithGivenColor(DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {

                String itemStatus = values.get("status");
                String statusColor = values.get("color");
                Assert.assertEquals(new DataSets(driver).getMyAccessStatusText(itemStatus).getCssValue("color"), statusColor);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Status text color is verified");
            takeScreenShot("Verification of status text background color", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of status text background color", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" of the drop down in the panel$")
    public void user_clicks_on_arrow_icon_in_open_notification_panel(String actionType, String iconName) throws Throwable {
        try {
            new CommonActions(driver).genericActions(actionType,iconName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Arrow icon in open notification panel is clicked");
        } catch (Exception e) {
            takeScreenShot("Arrow icon in open notification panel is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\"$")
    public void user_clicks_on_order_list(String actiontype, String buttonName) throws Throwable {
        try {
            new CommonActions(driver).genericActions(actiontype,buttonName);
            sleepForSec(1000);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Order List is clicked");
        } catch (Exception e) {
            takeScreenShot("Order List is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Given("^user clicks on the following data item checkbox from the list$")
    public void user_clicks_first_item_checkbox_from_item(List<CucumberDataSet> dataTableCollection) {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                waitForAngularLoad(driver);
                new CommonActions(driver).clickItemCheckBox(data.getDatasetItemsFromList());
            }
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "First item checkbox is clicked");
        } catch (Exception e) {
            takeScreenShot("Item checkbox is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Item checkbox is not clickable" + e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" button$")
    public void user_clicks_on_button(String actionType, String buttonName) throws Throwable {
        try {
            new CommonActions(driver).genericActions(actionType, buttonName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), actionType + " is performed on "+buttonName+" button");
        } catch (Exception e) {
            takeScreenShot(actionType + " is not performed on "+buttonName+" button", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Given("^user select \"([^\"]*)\" catalog and search \"([^\"]*)\" items at top end$")
    public void user_select_catalog_and_search_items_at_top_end(String catalogName, String itemName) throws Throwable {
        try {
            new CommonActions(driver).selectCatalogAndSearchItems(catalogName, itemName);
            LoggerUtil.logLoader_info(this.getClass().getName(), catalogName + " is selected "+itemName+" entered");
        } catch (Exception e) {
            takeScreenShot(catalogName + " is not selected "+itemName+" not entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user gets the version$")
    public void userGetsTheVersion() throws Throwable {
        try{
            String dh = new CommonPage(driver).getVersion().getText().replace("-",".");
            commonUtil.storeTemporaryText(new CommonPage(driver).getVersion().getText().replace("-","."));
        }catch(Exception e){
            takeScreenShot("Can't able to store version", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    //10.3 New UI
    @And("^user navigates to previous page$")
    public void userNavigatesToPreviousPage() throws Throwable {
        navigateToPreviousPage(driver);
        waitForAngularLoad(driver);
    }

    @And("^user verifies the \"([^\"]*)\" pop up is \"([^\"]*)\"$")
    public void userVerifiesThePopUpIs(String popUp, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, popUp);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), popUp + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(popUp + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(popUp + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), popUp + " is  not displayed");
        }
    }

    @And("^user \"([^\"]*)\" is \"([^\"]*)\" for \"([^\"]*)\"$")
    public void userVerifiesThePopUpIsDisplayed(String actionItem, String actionType, String popUp) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType,actionItem, popUp);
            sleepForSec(500);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), popUp + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(popUp + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(popUp + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), popUp + " is  not displayed");
        }
    }

    @And("^user verifies the \"([^\"]*)\" page is \"([^\"]*)\"$")
    public void userVerifiesThePageIs(String page, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, page);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), page + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(page + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(page + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), page + " is  not displayed");
        }
    }

    @And("^user verifies the \"([^\"]*)\" link is \"([^\"]*)\"$")
    public void userVerifiesTheLinkIs(String link, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, link);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), link + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(link + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(link + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), link + " is  not displayed");
        }
    }

    @And("^user clicks on \"([^\"]*)\" link in the \"([^\"]*)\"$")
    public void userClicksTheLinkIs(String link, String pageName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericClick(link);
            sleepForSec(500);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), link + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(link + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(link + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), link + " is  not displayed");
        }
    }

    @And("^user verifies \"([^\"]*)\" is displayed under the fields in \"([^\"]*)\" Popup$")
    public void user_verifies_validation_message_is_displayed_under_the_configuration_fields(String actionType, String PopupName, DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                String actualText = values.get("validationMessage");
                new CommonActions(driver).verifyPresence(actionType, values.get("fieldName"),actualText);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("fieldName") + " validation message is displayed under the field");
            }
        } catch (Exception e) {
            takeScreenShot("validation message is not displayed under the field", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("validation message is not displayed under the field" + e.getMessage());
        }
    }

    @When("^user closes the current window$")
    public void user_refreshes_the_application() throws Throwable {
        try {
            driver.close();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Current window is closed");
            takeScreenShot("Current window is closed", driver);
        } catch (Exception e) {
            takeScreenShot("Current window is not closed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user verifies copyrights in all java files from the following path$")
    public void userVerifiesCopyrightsInAllJavaFilesFromTheFollowingPath(DataTable dataTable) throws Throwable {
        SoftAssert softAssert= new SoftAssert();
        String localDir = null;
        String message=null;
        int level = 0;
        try {
            for (Map<String, String> data : dataTable.asMaps(String.class, String.class)) {
                localDir = data.get("directory").replace("SystemHomeDirectory", System.getProperty("user.home") + "\\" + "Documents");
                message = data.get("copyrightMessage");
            }
            File mainDirectory = new File(localDir);
            if (mainDirectory.exists() && mainDirectory.isDirectory())
            {
                File arr[] = mainDirectory.listFiles();
                softAssert.assertFalse(CommonUtil.traverseFilesAndVerifyContainsText(arr, level,message).contains("false"));
            }
            softAssert.assertAll();

        }
        catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());

        }
    }

    @And("^User performs following actions in the \"([^\"]*)\" popup$")
    public void userPerformsFollowingActionsInTheItemViewPage(String popupName, DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new CommonPage(driver).Popupvalidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Item View Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

    @And("^User performs following actions in search component in \"([^\"]*)\" page$")
    public void userPerformsFollowingActionsInSearchComponent(String pageName, DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new CommonPage(driver).searchComponentValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Item View Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

    @Then("^user press tab key and verifies the tab order$")
    public void user_press_tab_key_and_verifies_the_tab_order(DataTable arg1) throws Throwable {
        String labelName = null;
        String fieldPlaced = null;
        try {
            List<Map<String, String>> ls = arg1.asMaps(String.class, String.class);
            for (int i = 0; i < ls.size(); i++) {
                labelName = ls.get(i).get("label");
                keyPressEvent(driver, Keys.valueOf("TAB"));
                if (driver.switchTo().activeElement().getText().equals("×")) {
                    Assert.assertTrue(labelName.equalsIgnoreCase("×"));
                } else {
                    sleepForSec(500);
                    String a = driver.switchTo().activeElement().getTagName();
                    fieldPlaced = driver.findElement(By.xpath("//" + a + "//preceding::div[contains(.,'" + labelName + "')][1]")).getText();
                    LoggerUtil.logInfo("Expected field is " + labelName + " actual is " + fieldPlaced);
                    Assert.assertTrue(labelName.equalsIgnoreCase(fieldPlaced));
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    Actions actions = new Actions(driver);
                    actions.keyDown(Keys.SHIFT).build().perform();
                    sleepForSec(500);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    sleepForSec(500);
                    actions.keyUp(Keys.SHIFT).release().perform();
                    sleepForSec(500);
                    Assert.assertTrue(labelName.equalsIgnoreCase(fieldPlaced));

                }
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Default position is retrieved");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            takeScreenShot(this.getClass().getName(),driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tab press is not navigating in sequential order");
            Assert.fail("Tab press is not navigating in sequential order" + e.getMessage());
        }

    }

    @And("^user press Tab Key and verifies the focus of \"([^\"]*)\"$")
    public void userPressTabKeyAndVerifiesTheFocusOf(String actionType,DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                String actualText = values.get("validationMessage");
                new CommonActions(driver).verifyPresenceOfTabFocus(actionType,values.get("fieldName"),values.get("actionItem"),values.get("itemName"),values.get("section"),values.get("reverseTab"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("fieldName") + " Respetive field is selected and action is performed");
            }
        } catch (Exception e) {
            takeScreenShot("Respetive field is not selected and action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Respetive field is not selected and action is not performed" + e.getMessage());
        }
    }

    @Given("^Load the count of the type values to a Map$")
    public void load_the_count_of_the_type_values_to_a_Map(DataTable arg1) throws Throwable {
        new CucumberDataSet().clearProcessedItemMapValues();
        Map<String,String> tempMap = new TreeMap<>();
        for(Map<String,String> values : arg1.asMaps(String.class,String.class)){
            if(values.get("actualcount").equals("fromSource")){
                String dbQuery = new JsonRead().readJSonFromQuery(Constant.TEST_DATA_PATH + "json/IDA.json", values.get("queryPage"), values.get("queryName"));
                String dbCount = dbHelper.returnValue(values.get("DBName"), dbQuery);
                tempMap.put(values.get("type"),dbCount);
            }else{
                tempMap.put(values.get("type"),values.get("actualcount"));
            }
        }
        new CucumberDataSet().setProcessedItemMapValues(tempMap);
    }

}
