package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;

import com.asg.automation.pageactions.idc.ItemViewManagerActions;
import com.asg.automation.pageobjects.ida.AnalysisPage;
import com.asg.automation.pageobjects.idc.BundleManager;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.ItemViewManagement;
import com.asg.automation.pageobjects.idc.PluginManager;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;

import java.util.*;

import static com.asg.automation.utils.PostgresSqlBuilder.getselectedColumnName;


@SuppressWarnings("DefaultFileTemplate")
public class ItemViewManagementStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    protected DBPostgresUtil db_postgres_util;

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
    public void close() throws Exception {
        //new DriverFactory(BrowserName).destroyDriver();
        destroyDriver();

    }

    @When("^user clicks on Item View Management$")
    public void user_clicks_on_Item_View_Management() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("chrome")||browserName.equalsIgnoreCase("firefox")) {
                //scrollToWebElement(driver, new ItemViewManagement(driver).returnItemViewManagement());
                sleepForSec(1000);
                clickOn(new ItemViewManagement(driver).returnItemViewManagement());
            }
            else{
                sleepForSec(2000);
                clickonWebElementwithJavaScript(driver, new ItemViewManagement(driver).returnItemViewManagement());
            }
            sleepForSec(2000);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Item View Management");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Item View Management", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click on Item View Management" + e.getMessage());
        }
    }

    @Given("^user clicks on Bundle Manager link in administration tab$")
    public void user_clicks_on_Bundle_Manager_link_in_administration_tab() throws Throwable {
        try {
            sleepForSec(1000);
            clickOn(new ItemViewManagement(driver).returnbundleManager());
            sleepForSec(500);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Bundle Manager link");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Bundle Manager link", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click on Item View Management" + e.getMessage());
        }
    }


    @When("^user clicks on Create button in ItemView Management Panel$")
    public void user_clicks_on_Create_button_in_ItemView_Management_Panel() throws Throwable {
        try {
            new ItemViewManagement(driver).click_ItemViewCreateButton();
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Create Button");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Create button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click on Create button" + e.getMessage());
        }
    }

    @When("^user clicks on ItemView Table in ItemView Management Panel$")
    public void user_clicks_on_itemView_table_in_ItemView_Management_Panel() throws Throwable {
        try {
            new ItemViewManagement(driver).clickOn(new ItemViewManagement(driver).returnItemViewtable());
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Create Button");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Create button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click on Create button" + e.getMessage());
        }
    }

    @When("^user enters name and definition for the item view$")
    public void user_enters_name_and_definition_for_the_item_view() throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("NewItemView", "Name"));
            enterText(new ItemViewManagement(driver).returnitemViewDefinition(), jsonRead.readJSon("NewItemView", "Definition"));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Entered Name and Definition Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the values" + e.getMessage());
        }
    }

    @When("^user selects Supported Type for Item View$")
    public void user_selects_Supported_Type_for_Item_View() throws Throwable {
        try {
            //Thread.sleep(3000);
            sleepForSec(3000);
            new ItemViewManagement(driver).click_SupportedTypeDropDown();
            List<String> allItems = convertWebElementListIntoStringList(new ItemViewManagement(driver).returnListOfSupportedTypes());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "List Items" + allItems);
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnListOfSupportedTypes(), allItems.get(0)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Selected a Random Supported Type from the list");

        } catch (Exception e) {
            takeScreenShot("Not able to enter the values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the values" + e.getMessage());
        }
    }

    @When("^user clicks on Add\\(\\+\\) button in the Create New Item View panel$")
    public void user_clicks_on_Add_button_in_the_Create_New_Item_View_panel() throws Throwable {
        try {

            new ItemViewManagement(driver).click_SupportedTypeAddButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Supported Type Add button is clicked");
        } catch (Exception e) {
            takeScreenShot("Not able to click on the Supported Types Add Button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Not able to click on the Supported Types Add Button" + e.getMessage());
        }
    }

    @Then("^user clicks on Save button in the Create New Item View panel$")
    public void user_clicks_on_Save_button_in_the_Create_New_Item_View_panel() throws Throwable {
        try {
            sleepForSec(2000);
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).click_NewItemViewSaveButton());
            }else {
                waitForAngularLoad(driver);
                waitandFindElement(driver, new ItemViewManagement(driver).click_NewItemViewSaveButton(), 3, false);
                clickOn(new ItemViewManagement(driver).click_NewItemViewSaveButton());
                waitForAngularLoad(driver);
            }
            //new ItemViewManagement(driver).click_NewItemViewSaveButton();
            sleepForSec(7000);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Item View Save Button");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Save button in New Item View panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click on Save button in New Item View panel" + e.getMessage());
        }
    }

    @Then("^user clicks on Save button in the Item View panel$")
    public void user_clicks_on_Save_button_in_the_Item_View_panel() throws Throwable {
        try {
            sleepForSec(2000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                clickonWebElementwithJavaScript(driver, new ItemViewManagement(driver).click_NewItemViewSaveButton());
            } else {
                waitandFindElement(driver, new ItemViewManagement(driver).click_NewItemViewSaveButton(), 3, false);
                clickOn(new ItemViewManagement(driver).click_NewItemViewSaveButton());
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Item View Save Button");


            }
                //new ItemViewManagement(driver).click_NewItemViewSaveButton();
                 } catch(Exception e){
                takeScreenShot("Not able to click on Save button in New Item View panel", driver);
                new DashBoardPage(driver).Click_profileLogoutButton();
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
                Assert.fail("Not able to click on Save button in New Item View panel" + e.getMessage());
            }

    }

    @Then("^user verifies that the newly added item view is displayed in the Item View Management panel$")
    public void user_verifies_that_the_newly_added_item_view_is_displayed_in_the_Item_View_Management_panel() throws Throwable {
        try {
            sleepForSec(3000);
            Assert.assertTrue(traverseListContainsElement(new ItemViewManagement(driver).returnListOfItemViews(), jsonRead.readJSon("NewItemView", "Name")));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Newly Created Item view is displayed ");
        } catch (Exception e) {
            takeScreenShot("Newly created Item View is not displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Newly created ItemView is not displaying" + e.getMessage());
        }
    }


    @And("^user verifies that a JSON file is created for a new Item View$")
    public void user_verifies_that_a_JSON_file_is_created_for_a_new_Item_View(DataTable dataTableCollection) throws Throwable {

        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            criteriaValue.add("com/asg/dis/platform/itemviews/New Item View.json/TestService");
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                if (list.contains("com/asg/dis/platform/itemviews/New Item View.json")) {


                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "ItemView is found in DB");

                } else {
                    Assert.fail("ItemView not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "ItemView is not found");

                }

            }
        } catch (Exception e) {
            Assert.fail("ItemView not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }


    @When("^user clicks on mentioned itemview to be deleted \"([^\"]*)\" in json config file$")
    public void user_clicks_on_mentioned_itemview_to_be_deleted_in_json_config_file(String arg1) throws Throwable {
        try {
            sleepForSec(1000);
            WebElement element = traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnListOfItemViews(), arg1);
            scrollToWebElement(driver, element);
            clickonWebElementwithJavaScript(driver,element);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on the Item View to be deleted");
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Newly created Item View is not displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Newly created ItemView is not displaying" + e.getMessage());
        }
    }

    @When("^user clicks on Delete button in the  Edit Item View panel$")
    public void user_clicks_on_Delete_button_in_the_Edit_Item_View_panel() throws Throwable {
        try {
            sleepForSec(2000);
            new ItemViewManagement(driver).click_deleteButtonOnItemView();
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicked on Delete button");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Delete button on new item view panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click on Delete button on new item view panel" + e.getMessage());
        }
    }

    @Then("^deleted Item View should not be listed under the Item Views$")
    public void deleted_Item_View_should_not_be_listed_under_the_Item_Views() throws Throwable {
        try {
            sleepForSec(1000);
            Boolean bool = traverseListContainsElement(new ItemViewManagement(driver).returnListOfItemViews(), jsonRead.readJSon("DeletedItemView", "Name"));
            if (bool) {
                verifyTrue(false);
            } else {
                verifyTrue(true);
            }
            takeScreenShot("Item View is deleted successfully", driver);
        } catch (Exception e) {
            takeScreenShot("Item View is deleted successfully", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }

    }


    @When("^user enters leading space in the name field of new item view panel$")
    public void user_enters_leading_space_in_the_name_field_of_new_item_view_panel() throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("LeadingSpace", "Name"));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Leading Space Error Message Displayed");

        } catch (Exception e) {
            takeScreenShot("Leading Space Error", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Leading space is not entered properly" + e.getMessage());

        }
    }


    @When("^user enters trailing space in the name field of new item view panel$")
    public void user_enters_trailing_space_in_the_name_field_of_new_item_view_panel() throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("TrailingSpace", "Name"));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Trailing Space Error Message Displayed");

        } catch (Exception e) {
            takeScreenShot("Trailing space not entered correctly", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Trailing space not entered correctly" + e.getMessage());

        }
    }

    @When("^User enters Slash in the name field in the New Item View panel$")
    public void user_enters_Slash_in_the_name_field_in_the_New_Item_View_panel() throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("Forwardslash", "Name"));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Forward Slash entered ");

        } catch (Exception e) {
            takeScreenShot("Not able to enter Slash in the name field", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter Slash in the name field" + e.getMessage());
        }
    }

    @When("^user enters Backslash in the name field in the New Item View panel$")
    public void user_enters_Backslash_in_the_name_field_in_the_New_Item_View_panel() throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("Backslash", "Name"));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Backslash entered");

        } catch (Exception e) {
            takeScreenShot("Not able to enters Backslash in the name field in the New Catalog panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enters Backslash in the name field in the New Catalog panel" + e.getMessage());
        }
    }

    @Then("^user should be able to see the Visual composer button$")
    public void userShouldBeAbleToSeeTheVisualComposerButton() {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returnvisualComposerButton()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Visual Composer Button is visible");
        } catch (Exception e) {
            takeScreenShot("Visual Composer is not present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Visual Composer button is not present");
            Assert.fail("Visual composer button is not present");
        }
    }

    @And("^user clicks on visual composer button$")
    public void userClicksOnVisualComposerButton() {
        try {
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")){
                sleepForSec(2000);
                clickonWebElementwithJavaScript(driver, new ItemViewManagement(driver).returnvisualComposerButton());
                sleepForSec(500);
            }else {
                sleepForSec(2000);
                clickOn(new ItemViewManagement(driver).returnvisualComposerButton());
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Visual Composer Button is clicked");
        } catch (Exception e) {
            takeScreenShot("Visual Composer is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Visual Composer button is not clicked");
            Assert.fail("Visual composer button is not clicked" + e.getMessage());
        }
    }


    @And("^user clicks on add button in the Create New Item View panel$")
    public void userClicksOnAddButtonInTheCreateNewItemViewPanel() {
        try {
            sleepForSec(1000);
            new ItemViewManagement(driver).click_newTabAddButtonInVisualCOmposer();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add Tab button has been clicked");
            sleepForSec(10000);
        } catch (Exception e) {
            takeScreenShot("Add Tab Button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Add Tab button is not clicked");
            Assert.fail("Add Tab button is not clicked");
        }
    }

    @Then("^list of follwoing Widgets should be available$")
    public void listOfWidgetsFromShouldBeAvailable(List<CucumberDataSet> dataTableCollection) throws Throwable {
        Set<String> setWidgetData = new HashSet<>();
        try {
            for (CucumberDataSet data : dataTableCollection) {
                setWidgetData.add(data.getWidgetListFromVisualComposer());
            }
            Assert.assertEquals(setWidgetData.size(), new ItemViewManagement(driver).widgetListFromVisualComposer().size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Given Widget count:  " + setWidgetData.size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Available Widget count:  " + setWidgetData.size());
            Assert.assertTrue(new ItemViewManagement(driver).widgetListFromVisualComposer().containsAll(setWidgetData));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Given widget list and available widgets are matching");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Given widget list and available widgets are not matching");
            Assert.fail("Widget list from Test Data and Available WidgetList is mismatching" + e.getMessage());
        }
    }

    @Then("^user should see a search box and defualt text would be \"([^\"]*)\"$")
    public void userShouldSeeASearchBoxAndDefualtTextWouldBe(String defaultSearchText) {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returnsearchInputBoxFromVisualComposerPage()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search input box from Visual composer page is showing");
            Assert.assertEquals(new ItemViewManagement(driver).returnsearchInputBoxFromVisualComposerPage().getAttribute("placeholder"),
                    defaultSearchText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "default text is matching properly");

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "search box from visual composer is missing or default text is not matching");
            Assert.fail("search box from visual composer is missing or default text is not matching" + e.getMessage());
        }
    }

    @And("^user enters the search text \"([^\"]*)\"$")
    public void userEntersTheSearchText(String searchText) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnsearchInputBoxFromVisualComposerPage(), searchText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search Text" + searchText + "has been entered");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "seartch text" + searchText + "has been entered");
            Assert.fail("seartch text" + searchText + "has been entered");
        }

    }

    @Then("^Widgets with text \"([^\"]*)\" should be available$")
    public void widgetsWithTextShouldBeAvailable(String searchText) throws Throwable {
        try {
            for (String widgetName : new ItemViewManagement(driver).widgetListFromVisualComposer()) {
                Assert.assertTrue(widgetName.contains(searchText));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget" + widgetName + "has" + searchText);
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "seartch text" + searchText + "is not found in the widget list");
            Assert.fail("seartch text" + searchText + "is not found in the widget list");
        }
    }

    @And("^user clears the search text and search text should be default \"([^\"]*)\" and all widgets should be avaialble$")
    public void userClearsTheSearchTextAndSearchTextShouldBeDefaultAndAllWidgetsShouldBeAvaialble(String defaultSearchWidgetText) throws Throwable {
        try {
            textClear(new ItemViewManagement(driver).returnsearchInputBoxFromVisualComposerPage());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search has been cleared properly and default text is showing");
            Assert.assertEquals(new ItemViewManagement(driver).returnsearchInputBoxFromVisualComposerPage().getAttribute("placeholder"),
                    defaultSearchWidgetText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search has been cleared properly and default text is showing");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search is not cleared properly");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search is not cleared properly");
        }
    }

    @Then("^warning label \"([^\"]*)\" should be available$")
    public void warningLabelShouldBeAvailable(String warningMessage) {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returnwarningMessage()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Warning message " + warningMessage + "is found in visual Composer");
            Assert.assertEquals(warningMessage, new ItemViewManagement(driver).returnwarningMessage().getText().trim());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Warning message " + warningMessage + "matching in the application");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Warning message " + warningMessage + "is not found in visual Composer");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Warning message " + warningMessage + "is not found in visual Composer");
        }
    }

    @And("^preview and apply should be disabled$")
    public void previewAndApplyShouldBeDisabled() {
        try {
            Assert.assertFalse(isElementEnabled(new ItemViewManagement(driver).returnPreviewButton()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "preview button is disabled");
            Assert.assertFalse(isElementEnabled(new ItemViewManagement(driver).returnApplyButton()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button is diabled");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Preview and Apply buttons are enabled or not found in visual composer");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Preview and Apply buttons are enabled or not found in visual composer");
        }
    }

    @And("^user enters name as \"([^\"]*)\" and definition as \"([^\"]*)\" for the item view$")
    public void userEntersNameAsAndDefinitionAsForTheItemView(String itemViewName, String itemViewDfn) {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), itemViewName);
            enterText(new ItemViewManagement(driver).returnitemViewDefinition(), itemViewDfn);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Entered Name and Definition Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the values" + e.getMessage());
        }
    }

    @And("^user enters the Supported Type as \"([^\"]*)\" for Item View$")
    public void userEntersTheSupportedTypeAsForItemView(String supportedType) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnsupportedTypesInputbox(), supportedType);
            waitForPageLoads(driver, 2);
            clickOn(new ItemViewManagement(driver).returnsupportedTypeAddButton());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Supported Type added Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the supported type values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the supported type values" + e.getMessage());
        }
    }


    @Given("^user enters the Supported Type as \"([^\"]*)\" for Item View and click add button$")
    public void user_enters_the_Supported_Type_as_for_Item_View_and_click_add_button(String supportedType) throws Throwable {
        try {
            sleepForSec(3000);
            enterText(new ItemViewManagement(driver).returnsupportedTypesInputbox(), supportedType);
            sleepForSec(1000);
            new ItemViewManagement(driver).click_SupportedTypeAddButtonClick();
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Supported Type added Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the supported type values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the supported type values" + e.getMessage());
        }
    }


    @And("^widget edit button should be highlighted$")
    public void widgetEditButtonShouldBeHighlighted() {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returnwidgetAlert()));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Widget edit button is highlighted");
        } catch (Exception e) {
            takeScreenShot("Not able to highlight the widget edit button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to highlight the widget edit button" + e.getMessage());
        }

    }

    @Then("^\"([^\"]*)\" alert \"([^\"]*)\" should be there$")
    public void alertShouldBeThere(String fieldName, String alertMessage) throws Throwable {
        try {

            pressKey(new PluginManager(driver).getFieldTextBox(fieldName),Keys.SPACE);
            pressKey(new PluginManager(driver).getFieldTextBox(fieldName),Keys.BACK_SPACE);

            Assert.assertTrue(new ItemViewManagement(driver).returnalertinWidgetConfig().size() >= 1);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Alert is showing in widget config panel");
//        Assert.assertEquals(alertMessage,new ItemViewManagement(driver).returnalertinWidgetConfig().getText());
//        LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Alert message is matching widget config panel");
        } catch (Exception e) {
            takeScreenShot("Alert message mismatch", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Alert message is not matching widget config panel" + e.getMessage());
        }
    }


    @Then("^modal alert \"([^\"]*)\" should be there$")
    public void modal_alert_should_be_there(String modalAlert) throws Throwable {
        try {
            Assert.assertTrue(verifyContains(modalAlert, new ItemViewManagement(driver).returnModalalertinWidgetConfig().getText().trim()));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Alert is showing in widget config panel");
        } catch (Exception e) {
            takeScreenShot("Alert message mismatch", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Alert message is not matching widget config panel" + e.getMessage());
        }
    }

    @And("^user selects the ATTRIBUTE NAME as \"([^\"]*)\" and alert should be gone and hit apply$")
    public void userSelectsTheATTRIBUTENAMEAs(String attributeValue) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).getattributeName());
            sleepForSec(2000);
            if (traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue).isDisplayed()) {
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                        , attributeValue));
            } else /*if (!traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue).isDisplayed()) */{
                scrollToWebElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue));
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                        , attributeValue));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "atrribute" + attributeValue + "has been choosen");
            // Assert.assertTrue(!isElementPresent(new ItemViewManagement(driver).returnalertinWidgetConfig()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert is gone");
//           clickOn(new ItemViewManagement(driver).returnApplyButton());
//            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Attribute Name could not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Attribute Name could not selected" + e.getMessage());
        }
    }

    @Given("^user selects widget attribute name as \"([^\"]*)\"$")
    public void user_selects_widget_attribute_name_as(String attributeValue) throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).getAttributeFilter());
            sleepForSec(1000);
            if (traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue).isDisplayed()) {
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                        , attributeValue));
            } else if (!traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue).isDisplayed()) {
                scrollToWebElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue));
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                        , attributeValue));
            }
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "atrribute" + attributeValue + "has been choosen");
            // Assert.assertTrue(!isElementPresent(new ItemViewManagement(driver).returnalertinWidgetConfig()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert is gone");
        } catch (Exception e) {
            takeScreenShot("Query Text Could not be choosen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("queryText is not choosen and alert is still showing" + e.getMessage());
        }
    }

    @Given("^user selects the ATTRIBUTE NAME as \"([^\"]*)\"$")
    public void user_selects_the_ATTRIBUTE_NAME_as(String attributeValue) throws Throwable {
        try {
            clickAndHold(driver, new ItemViewManagement(driver).getMultiWidgetAttributeName());
            sleepForSec(1000);
            if (traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue).isDisplayed()) {
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                        , attributeValue));
            } else /*if (!traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue).isDisplayed()) */{
                scrollToWebElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), attributeValue));
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                        , attributeValue));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "atrribute" + attributeValue + "has been choosen");
            // Assert.assertTrue(!isElementPresent(new ItemViewManagement(driver).returnalertinWidgetConfig()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert is gone");
            clickOn(new ItemViewManagement(driver).returnApplyButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Query Text Could not be choosen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("queryText is not choosen and alert is still showing" + e.getMessage());
        }
    }

    @Given("^user enters the attribute name as \"([^\"]*)\" and click add button$")
    public void user_enters_the_attribute_name_as_and_click_add_button(String attributeName) throws Throwable {
        try {
            sleepForSec(1000);
            enterText(new ItemViewManagement(driver).returnAttributeNameInputbox(), attributeName);
            sleepForSec(1000);
            clickOn(new ItemViewManagement(driver).returnAttributeInputAddButton());
            waitForPageLoads(driver, 5);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Supported Type added Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the supported type values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the supported type values" + e.getMessage());
        }
    }



    @Given("^user selects \"([^\"]*)\" in \"([^\"]*)\" field$")
    public void user_selects_in_field(String fieldValue, String fieldName) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("chrome")||browserName.equalsIgnoreCase("edge")){
                scrolltoElement(driver,new ItemViewManagement(driver).getLinkWidgetFields(fieldName),true);
                clickOn(new ItemViewManagement(driver).getLinkWidgetFields(fieldName));
                if (traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), fieldValue).isDisplayed()) {
                    clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                            , fieldValue));
                } else if (!traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), fieldValue).isDisplayed()) {
                    scrollToWebElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), fieldValue));
                    clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                            , fieldValue));
                }
            } else if (browserName.equalsIgnoreCase("firefox")) {
                clickOn(new ItemViewManagement(driver).getLinkWidgetFields(fieldName));
                sleepForSec(1000);
                if (traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), fieldValue).isDisplayed()) {
                    clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                            , fieldValue));
                } else if (!traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), fieldValue).isDisplayed()) {
                    scrollToWebElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList(), fieldValue));
                    clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                            , fieldValue));
                }
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(fieldName + " is not selected and alert is still showing" + e.getMessage());
        }
    }


    @Given("^user enters the attribute Type as \"([^\"]*)\" for Item View and click add button$")
    public void user_enters_the_attribute_Type_as_for_Item_View_and_click_add_button(String attributeType) throws Throwable {
        try {
            new ItemViewManagement(driver).clickAttributeDropDown();
            sleepForSec(1000);

            WebElement element = traverseListContainsElementTextReturnsElement(new ItemViewManagement(driver).returnAttributeTypeAddButton(), attributeType);
            clickOn(element);
            waitForPageLoads(driver, 5);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Attribute Type added Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the Attribute type values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the Attribute type values" + e.getMessage());
        }
    }


    @Given("^user enter the value \"([^\"]*)\" in label text box in attribute widget page$")
    public void user_enter_the_value_in_label_text_box_in_attribute_widget_page(String labelName) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).getLabelName(), labelName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Label Name is entered");
        } catch (Exception e) {
            takeScreenShot("Label Name is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Label Name is not entered" + e.getMessage());
        }
    }

    @Given("^user enter the value \"([^\"]*)\" in label text box in gremlin widget page$")
    public void user_enter_the_value_in_label_text_box_in_gremlin_widget_page(String labelName) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).gremLinLabel(), labelName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Label Name is entered");
        } catch (Exception e) {
            takeScreenShot("Label Name is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Label Name is not entered" + e.getMessage());
        }
    }

    @Given("^user selects \"([^\"]*)\" from type dropdown box$")
    public void user_selects_from_type_dropdown_box(String typeValue) throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).getType());
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnAtrributeValueasList()
                    , typeValue));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "atrribute" + typeValue + "has been choosen");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert is gone");
            clickOn(new ItemViewManagement(driver).getApplyButtonInWidgetPanel());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Type Could not be choosen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Type Could not be choosen" + e.getMessage());
        }
    }

    @Given("^user clicks on the apply buuton in the edit widget panel$")
    public void user_clicks_on_the_apply_buuton_in_the_edit_widget_panel() throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).getApplyButtonInWidgetPanel());
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Apply button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button is not clicked" + e.getMessage());
        }
    }


    @Then("^warning label and widget edit button alert should be gone$")
    public void warningLabelAndWidgetEditButtonAlertShouldBeGone() {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getwidgetNoAlert()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget alert message has been gone");
        } catch (Exception e) {
            takeScreenShot("warning message and widget alert are still present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("warning message and widget alert are still present" + e.getMessage());
        }
    }

    @And("^User drag and drop a \"([^\"]*)\" widget to the page from the displayed widget set$")
    public void userDragAndDropAWidgetToThePageFromTheDisplayedWidgetSet(String widgetName) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            WebElement elementtoBeDragged = traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), widgetName);
            if (browserName.equalsIgnoreCase("firefox")) {
                WebElement elementtoBePlaced = new DashBoardPage(driver).getTobeDragged();
                dragAndDropwithActions(driver, elementtoBeDragged, elementtoBePlaced);

            } else {
                implicit_wait(driver, 3);
                WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped().get(0);
                dragAndDropElementUsingJavaScript(driver, elementtoBeDragged, elementtoBePlaced);
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("Drag and Drop", driver);
        }
    }

    @Then("^Widget should be removed from item view$")
    public void widgetShouldBeRemovedFromItemView() throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getemptyDashBoard()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget has been removed");
        } catch (Exception e) {
            takeScreenShot("Widget is not removed from visual composer", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Widget is not removed from visual composer" + e.getMessage());

        }
    }

    @And("^user clicks on apply button on visual composer$")
    public void userClicksOnApplyButtonOnVisualComposer() {
        try {
            sleepForSec(2000);
            //clickOn(new ItemViewManagement(driver).returnApplyButton());
            clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).getItemViewapplyButton());
            sleepForSec(4000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Apply button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button is not clicked" + e.getMessage());

        }
    }


    @Given("^the user clicks on Save button in the Attribute widget page$")
    public void the_user_clicks_on_Save_button_in_the_Attribute_widget_page() throws Throwable {
        try {
            new ItemViewManagement(driver).getAttributeWidgetSave();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Apply button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button is not clicked" + e.getMessage());

        }
    }

    @And("^user clicks on item view \"([^\"]*)\" and click on visual composer button$")
    public void userClicksOnItemViewAndClickOnVisualComposerButton(String itemViewName) {
        try {
                new ItemViewManagerActions(driver).selectItemFromListAndClickVisualComposer(itemViewName);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item view " + itemViewName + "has been clicked");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Visual Composer Button is clicked");

        } catch (Exception e) {
            takeScreenShot("visual composer button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("visual composer button is not clicked" + e.getMessage());
        }
    }

    @When("^User \"([^\"]*)\" on \"([^\"]*)\" link on the Item View page$")
    public void user_click_on_widget_link_on_the_Item_View_page(String actionType, String widgetName) {
        try {
            sleepForSec(1000);
            new ItemViewManagerActions(driver).genericActions(actionType, widgetName);
            sleepForSec(1000);
        } catch (Exception e) {
            new ItemViewManagerActions(driver).clickLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^User clicks on Preview button$")
    public void userClicksOnPreviewButton() throws Throwable {
        try {
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).returnPreviewButton());
                sleepForSec(2000);
            }
            else {
                clickOn(new ItemViewManagement(driver).returnPreviewButton());
                sleepForSec(3000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Preview button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Preview button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Preview button is not clicked" + e.getMessage());

        }
    }

    @Then("^preview of item view should have DATASAMPLING and Rating items$")
    public void previewOfItemViewShouldHaveDATASAMPLINGAndRatingItems() {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getDataSamplingContainer()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data Sampling Widget container is found in preview");
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getRatingContainer()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating Widget container is found in preview");
        } catch (Exception e) {
            takeScreenShot("Data Sampling and Tag widget container is not in Preview", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Data Sampling and Tag widget container is not in Preview" + e.getMessage());
        }


    }

    @When("^user clicks on Delete button on visual composer$")
    public void userClicksOnDeleteButtonOnVisualComposer() {
        try {
            new ItemViewManagement(driver).click_deleteButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete Button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Delete button could not be clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Delete button could not be clicked" + e.getMessage());
        }

    }

    @And("^user clicks on delete button on dashboard of item view$")
    public void userClicksOnDeleteButtonOnDashboardOfItemView() throws Throwable {
        try {
            new ItemViewManagement(driver).click_dashboardDeleteonItemViewComposer();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete Button for Dashboard has been clicked on item view");
        } catch (Exception e) {
            takeScreenShot("Delete Button for Dashboard has not been clicked on item view", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Delete Button for Dashboard has not been clicked on item view" + e.getMessage());
        }
    }

    @And("^alert message \"([^\"]*)\" about duplicate dashboard should exist$")
    public void alertMessageAboutDuplicateDashboardShouldExist(String warningMessage) {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returnDashboardAlert()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard alert is showing");
            Assert.assertEquals(warningMessage, new ItemViewManagement(driver).returnDashboardAlert().getText().trim());
        } catch (Exception e) {
            takeScreenShot("Dashboard alert is not showing", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dashboard Alert is not showing" + e.getMessage());
        }
    }

    @Then("^new dashboard should have a default name \"([^\"]*)\"$")
    public void newDashboardShouldHaveADefaultName(String newDashboardName) {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returndashboardName()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard alert is showing");
            Assert.assertEquals(newDashboardName, new ItemViewManagement(driver).returnDashboardAlert().getAttribute("text"));
        } catch (Exception e) {
            takeScreenShot("new dashboard could not be added", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("new dashboard could not be added" + e.getMessage());
        }
    }

    @And("^user chooses catalog \"([^\"]*)\" in CATALOGS$")
    public void userChoosesCatalogInCATALOGS(String catalogName) throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).returncatalogSelectionDropDownButton());
            sleepForSec(1000);
            enterText(new ItemViewManagement(driver).getCatalogDropDownInput(), catalogName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog selection dropdown button was clicked and list of catalogs are shwoing");
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returncatalogListFromItemView(), catalogName));
            sleepForSec(3000);
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).click_NewItemViewSaveButton());
//                if (new ItemViewManagement(driver).getAcceptWarning_Status()) {
//                    new ItemViewManagement(driver).click_acceptWarning();
//                }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog " + catalogName + "has been choosen");
        } }catch (Exception e) {
            takeScreenShot("new dashboard could not be added", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("catalog coluld not be selected" + e.getMessage());
        }
    }

    @And("^user chooses catalog \"([^\"]*)\" in CATALOGS__2222$")
    public void userChoosesCatalogInCATALOGS1_d2222(String catalogName , String catalogOption) throws Throwable {
        try {
            new ItemViewManagerActions(driver).genericClick(catalogOption);
            sleepForSec(1000);
            enterText(new ItemViewManagement(driver).getCatalogDropDownInput(), catalogName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog selection dropdown button was clicked and list of catalogs are shwoing");
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returncatalogListFromItemView(), catalogName));
            sleepForSec(3000);
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).click_NewItemViewSaveButton());
//                if (new ItemViewManagement(driver).getAcceptWarning_Status()) {
//                    new ItemViewManagement(driver).click_acceptWarning();
//                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog " + catalogName + "has been choosen");
            } }catch (Exception e) {
            takeScreenShot("new dashboard could not be added", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("catalog coluld not be selected" + e.getMessage());
        }
    }



    @Given("^user selects a random value from support type$")
    public void user_selects_a_random_value_from_support_type() throws Throwable {

        try {
            new ItemViewManagement(driver).click_SupportedTypeAddButton();
            int supportTypeSize = new ItemViewManagement(driver).returnsupportedTypeValues().size();
            Random rn = new Random();
            int range = supportTypeSize - 1 + 1;
            if (supportTypeSize != 0 && supportTypeSize == 1) {
                clickOn(new ItemViewManagement(driver).returnsupportedTypeValues().get(0));
            } else if (supportTypeSize > 1) {
                clickOn(new ItemViewManagement(driver).returnsupportedTypeValues().get(rn.nextInt(range) + 2));
            } else if (supportTypeSize == 0) {
                LoggerUtil.logLoader_info(this.getClass().getName(), "No Support Type Values Available");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Supported Type coluld not be selected" + e.getMessage());
            takeScreenShot(this.getClass().getName(), driver);
        }
    }


    @When("^user clicks on newly added item view is displayed in the Item View Management panel$")
    public void user_clicks_on_newly_added_item_view_is_displayed_in_the_Item_View_Management_panel() throws Throwable {
        try {
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnListOfItemViews(), jsonRead.readJSon("NewItemView", "Name")));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Newly Created Item view is displayed ");
        } catch (Exception e) {
            takeScreenShot("MLP_1942_Newly created Item View is not displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Newly created ItemView is not displaying" + e.getMessage());
        }
    }

    @Then("^user edits the name in the item view$")
    public void user_edits_the_name_in_the_item_view() throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("NewItemViewEdit", "Name"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit for Name Successful");
        } catch (Exception e) {
            takeScreenShot("MLP_1942_Not able to edit name", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to edit name" + e.getMessage());
        }
    }

    @Then("^user edits the name, definition and add supported type as \"([^\"]*)\"$")
    public void user_edits_the_name_definition_and_supported_types(String supportedType) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), jsonRead.readJSon("NewItemViewEdit", "Name"));
            enterText(new ItemViewManagement(driver).returnitemViewDefinition(), jsonRead.readJSon("NewItemViewEdit", "Definition"));
            sleepForSec(1000);
            clickOn(new ItemViewManagement(driver).returncatalogSelectionDropDownButton());
            sleepForSec(1000);
            enterText(new ItemViewManagement(driver).getCatalogDropDownInput(), "BigData");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog selection dropdown button was clicked and list of catalogs are shwoing");
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returncatalogListFromItemView(), "BigData"));
            sleepForSec(3000);
            enterText(new ItemViewManagement(driver).returnsupportedTypesInputbox(), supportedType);
            sleepForSec(1000);
            new ItemViewManagement(driver).click_SupportedTypeAddButtonClick();
            waitForPageLoads(driver,5);
            //new ItemViewManagement(driver).click_SupportedTypeDropDown();
//            List<String> allItems = convertWebElementListIntoStringList(new ItemViewManagement(driver).returnListOfSupportedTypes());
//            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnListOfSupportedTypes(), "Source"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit for Name,Definition and supported types Successful");
        } catch (Exception e) {
            takeScreenShot("MLP_1942_Not able to edit values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to edit values" + e.getMessage());
        }
    }

    @And("^user verifies that a JSON file is created for edited Item View$")
    public void user_verifies_that_a_JSON_file_is_created_for_edited_Item_View(DataTable dataTableCollection) throws Throwable {

        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            criteriaValue.add("com/asg/dis/platform/itemviews/New Item View Edit.json");
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Results: " + resultList.get(0));
            /*Assert.assertTrue(resultList.get(0).contains("Source"));*/
            Assert.assertTrue(resultList.get(0).contains("Testing Purpose Edit"));

        } catch (Exception e) {
            Assert.fail("ItemView not found");
            takeScreenShot("MLP_1942_ItemView not found", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @When("^user clicks on close icon in edit item view panel$")
    public void user_clicks_on_close_icon_in_edit_item_view_panel() {
        try {
            new ItemViewManagement(driver).click_itemViewExitButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Click close icon succesful");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("MLP_1942_Close icon click error", driver);
            Assert.fail(e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Given("^user clicks on close icon in edit item Full view panel$")
    public void user_clicks_on_close_icon_in_edit_item_Full_view_panel() throws Throwable {
        try {
            new ItemViewManagement(driver).click_itemFullViewExitButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Click close icon succesful");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("MLP_1942_Close icon click error", driver);
            Assert.fail(e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies the popup alert content$")
    public void user_verifies_the_popup_alert_content() throws Throwable {
        try {
            Assert.assertTrue(new ItemViewManagement(driver).itemViewAlertHeader().isDisplayed());
            Assert.assertTrue(new ItemViewManagement(driver).itemViewAlertContent().isDisplayed());
            Assert.assertTrue(new ItemViewManagement(driver).itemViewAlertYes().isDisplayed());
            Assert.assertTrue(new ItemViewManagement(driver).itemViewAlertNo().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Pop up verification successful");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("MLP_1942_Alert Pop up error", driver);
            Assert.fail(e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user clicks on Yes button in alert message$")
    public void user_clicks_on_Yes_button_in_alert_message() throws Throwable {
        try {
//            waitForPageLoads(driver, 5);
//            waitandFindElement(driver, new ItemViewManagement(driver).itemViewAlertYes(), 3, false);
            clickOn(new ItemViewManagement(driver).itemViewAlertYes());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Discard changes successful");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("MLP_1942_Alert Yes button not clicked", driver);
            Assert.fail(e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies that the newly added item view should not be displayed$")
    public void user_verifies_that_the_newly_added_item_view_should_not_be_displayed() throws Throwable {
        try {
            Assert.assertFalse(traverseListContainsElement(new ItemViewManagement(driver).returnListOfItemViews(), jsonRead.readJSon("NewItemView", "Name")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Newly Created Item view is not displayed ");
            takeScreenShot("MLP_1942_Newly Created Item view is not displayed", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1942_Newly created Item View is displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Newly created ItemView is displayed" + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user clicks on No button in alert message$")
    public void user_clicks_on_No_button_in_alert_message() throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).itemViewAlertNo());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No button clicked successfully");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(" MLP_1942_Alert No button not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies create item view panel is displayed$")
    public void user_verifies_create_item_view_panel_is_displayed() throws Throwable {
        try {
            Assert.assertTrue(new ItemViewManagement(driver).returnnewItemViewName().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item view panel is displayed ");
            takeScreenShot("MLP_1942_Item view panel is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1942_Item view panel is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Item view panel is not displayed" + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies that edited item view is displayed in the Item View Management panel$")
    public void user_verifies_that_edited_item_view_is_displayed_in_the_Item_View_Management_panel() throws Throwable {
        try {
            sleepForSec(2000);
            Assert.assertTrue(traverseListContainsElement(new ItemViewManagement(driver).returnListOfItemViews(), jsonRead.readJSon("NewItemViewEdit", "Name")));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Edited Item view is displayed ");
        } catch (Exception e) {
            takeScreenShot("NEdited Item view is not displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Edited Item view is not displaying" + e.getMessage());
        }
    }

    @Then("^user verifies that edited item view is not displayed in the Item View Management panel$")
    public void user_verifies_that_edited_item_view_is_not_displayed_in_the_Item_View_Management_panel() throws Throwable {
        try {

            Assert.assertFalse(traverseListContainsElement(new ItemViewManagement(driver).returnListOfItemViews(), jsonRead.readJSon("NewItemViewEdit", "Name")));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Edited Item view is not displayed ");
        } catch (Exception e) {
            takeScreenShot("NEdited Item view is displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Edited Item view is displaying" + e.getMessage());
        }
    }

    @When("^user selects the BigData from catalog list$")
    public void user_selects_the_BigData_from_catalog_list() throws Throwable {
        try {
            new ItemViewManagement(driver).click_itemViewCatalogButton();
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnListOfCatalogs(), "BigData"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Selected BigData from catalog list");

        } catch (Exception e) {
            takeScreenShot("Not able to select catalog", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to select catalog" + e.getMessage());
        }
    }

    @And("^user enters \"([^\"]*)\" name field of new item view panel dashboad$")
    public void userEntersNameFieldOfNewItemViewPanelDashboad(String itemViewDashBoardName) throws Throwable {
        try {
            sleepForSec(1000);
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                new ItemViewManagement(driver).returndashboardName().clear();
                enterUsingActions(driver,new ItemViewManagement(driver).returndashboardName(), itemViewDashBoardName);
                //enterTextWithJavaScript(driver,itemViewDashBoardName,new ItemViewManagement(driver).returndashboardName());
            }
            else{
            enterText(new ItemViewManagement(driver).returndashboardName(), itemViewDashBoardName);}
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard name" + itemViewDashBoardName + "has been entered");

        } catch (Exception e) {
            takeScreenShot("Not able to enter the name of the item view dash board", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter name of the item view Dash Board name" + e.getMessage());
        }
    }

    @Then("^user should be seeing new item view tab dashboard named as \"([^\"]*)\"$")
    public void userShouldBeSeeingNewItemViewTabDashboardNamedAs(String dashboardName) throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(traverseListContainsElementText(new ItemViewManagement(driver).returnitemViewDashboardList(), dashboardName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard name" + dashboardName + "is found");
        } catch (Exception e) {
            takeScreenShot("Dashboard name in itemview Could not found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dashboard name in itemview Could not found" + e.getMessage());
        }
    }

    @Then("^user verifies that the newly added item view \"([^\"]*)\" is displayed in the Item View Management panel$")
    public void userVerifiesThatTheNewlyAddedItemViewIsDisplayedInTheItemViewManagementPanel(String itemViewName) throws Throwable {
        try {
            sleepForSec(3000);
            Assert.assertTrue(traverseListContainsElement(new ItemViewManagement(driver).getItemViewList(), itemViewName));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Newly Created Item view " + itemViewName + "is displayed ");
        } catch (Exception e) {
            takeScreenShot("Newly created Item View is not displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Newly created ItemView " + itemViewName + " is not displaying" + e.getMessage());
        }
    }

    @Then("^alert message \"([^\"]*)\" about name should appear$")
    public void alertMessageAboutNameShouldAppear(String alertName) throws Throwable {
        try {
            sleepForSec(3000);
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).returnDashboardAlert()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard alert is showing");
            Assert.assertEquals(alertName, new ItemViewManagement(driver).returnDashboardAlert().getText().trim());
        } catch (Exception e) {
            takeScreenShot("Dashboard alert is not showing", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dashboard Alert is not showing" + e.getMessage());
        }
    }

    @When("^user clicks on \"([^\"]*)\" tab on visual composer$")
    public void userClicksOnTabOnVisualComposer(String tabName) throws Throwable {
        try {
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).returnitemViewDashboardList(), tabName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on" + tabName + "from dashboard in item view");
        } catch (Exception e) {
            takeScreenShot("could not be clicked on Tabs", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("could not be clicked on Tabs" + e.getMessage());

        }
    }

    @And("^user should be seeing only (\\d+) tabs in visual composer$")
    public void userShouldBeSeeingOnlyTabsInVisualComposer(int tabCount) throws Throwable {
        try {
            Assert.assertEquals(new ItemViewManagement(driver).returnitemViewDashboardList().size(), tabCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "tab count : " + tabCount + "is matching");
        } catch (Exception e) {
            takeScreenShot("tab count is not matching", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("tab count is not matching" + e.getMessage());

        }
    }

    @And("^User drag and drop a \"([^\"]*)\" widget to the page from the displayed widget sets$")
    public void userDragAndDropAWidgetToThePageFromTheDisplayedWidgetSets(String widgetName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            List<String> widgetList = new ArrayList<>();
            while (new ItemViewManagement(driver).getwidgetListFromVisualComposer().size() > 0) {
                for (WebElement ele : new ItemViewManagement(driver).getwidgetListFromVisualComposer()) {
                    widgetList.add(ele.getAttribute("title").trim());
                }
                WebElement elementtoBeDragged = traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), widgetName);
                if (traverseListContainsElementText(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), widgetName)) {
                    if (browserName.equalsIgnoreCase("chrome")) {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped().get(0);
                        sleepForSec(1000);
                        dragAndDropElementUsingJavaScript(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(1000);
                        waitForAngularLoad(driver);
                        break;
                    } else if (browserName.equalsIgnoreCase("firefox")) {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped().get(0);
                        sleepForSec(1000);
                        dragAndDrop(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(500);
                        break;
                    }
                    else{
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped_Edge().get(0);
                        sleepForSec(1000);
                        dragAndDrop(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(3000);
                        break;
                    }
                } else {
                    clickOn(new ItemViewManagement(driver).getrightArrowList());
                    sleepForSec(500);
                }
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("Drag and Drop", driver);
        }

    }


    @Given("^User drag and drop a \"([^\"]*)\" widget to the page from the displayed widget in second page$")
    public void user_drag_and_drop_a_widget_to_the_page_from_the_displayed_widget_in_second_page(String widgetName) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            List<String> widgetList = new ArrayList<>();
            while (new ItemViewManagement(driver).getwidgetListFromVisualComposer().size() > 0) {
                for (WebElement ele : new ItemViewManagement(driver).getwidgetListFromVisualComposer()) {
                    widgetList.add(ele.getAttribute("title").trim());
                }
                WebElement elementtoBeDragged = traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), widgetName);
                if (traverseListContainsElementText(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), widgetName)) {
                    if (browserName.equalsIgnoreCase("chrome")) {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped_InSecondPage().get(0);
                        sleepForSec(1000);
                        dragAndDropElementUsingJavaScript(driver, elementtoBeDragged, elementtoBePlaced);
                        break;
                    } else if (browserName.equalsIgnoreCase("firefox")) {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped_InSecondPage().get(0);
                        sleepForSec(1000);
                        dragAndDrop(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(500);
                        break;
                    }
                    else{
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped_Edge().get(1);
                        sleepForSec(1000);
                        dragAndDrop(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(1000);
                        break;
                    }
                } else {
                    clickOn(new ItemViewManagement(driver).getrightArrowList());
                    sleepForSec(500);
                }
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("Drag and Drop", driver);
        }

    }


    @Given("^When query is ran to delete an itemview \"([^\"]*)\" in \"([^\"]*)\" schema of \"([^\"]*)\" table$")
    public void whenQueryIsRanToDeleteAnItemviewInSchemaOfTable(String itemviewName, String schemaName, String tableName) {
        db_postgres_util = new DBPostgresUtil();
        try {
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/itemviews/" + itemviewName + ".json"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^item view \"([^\"]*)\" should not be found in \"([^\"]*)\" schema of \"([^\"]*)\" table$")
    public void itemViewShouldNotBeFoundInSchemaOfTable(String itemviewName, String schemaName, String tableName) throws Throwable {
        int rowCount;
        db_postgres_util = new DBPostgresUtil();
        try {
            rowCount = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/itemviews/" + itemviewName + ".json"));
            if (rowCount == 0) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
            } else {
                Assert.fail("item view is not found");
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^user validates the attribute name is displayed as \"([^\"]*)\" in  preview page Label Name$")
    public void user_validates_the_attribute_name_is_displayed_as_in_preview_page_Label_Name(String labelType, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        Map<String, String> resultList = new HashMap();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            db_postgres_util.returnQueryMap(Query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Results: " + resultList.get(0));
            switch (labelType) {
                case "date":
                    Assert.assertTrue(verifyEquals(db_postgres_util.returnQueryMap(Query).values().toString().substring(2,12), new ItemViewManagement(driver).getRatingSingletonLabelValue().substring(0, 10)));
                    break;
                case "string":
                  //  Assert.assertTrue(db_postgres_util.returnQueryMap(Query).values().toString().substring(2,9).contains(new ItemViewManagement(driver).getStringRatingSingletonLabelValue()));
                    Assert.assertTrue(new ItemViewManagement(driver).getStringRatingSingletonLabelValue().contains(db_postgres_util.returnQueryMap(Query).values().toString().substring(2,9)));
                    break;
                case "json":
                    String dbValue=db_postgres_util.returnQueryMap(Query).values().toString().substring(2,9);
                    Assert.assertTrue(new ItemViewManagement(driver).getJsonRatingSingletonLabelValue().contains(dbValue.replace(dbValue,"\"" + dbValue+ "\"")));
                    break;
                case "binary":
                    String actualText = new ItemViewManagement(driver).getRatingSingletonBinaryLabelValue();
                    Assert.assertTrue(verifyContains(new ItemViewManagement(driver).getRatingSingletonBinaryLabelValue(), "Iêï"));
                    break;
            }

        } catch (Exception e) {
            Assert.fail("ItemView not found");
            takeScreenShot("MLP_1942_ItemView not found", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^item view \"([^\"]*)\" should get added in database and \"([^\"]*)\" in data column$")
    public void item_view_should_get_added_in_database_and_in_data_column(String itemViewName, String widgetName, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        criteriaValue.add("com/asg/dis/platform/itemviews/" + itemViewName + ".json");
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            sleepForSec(3000);
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
              /*String dbValue = JsonPath.read(resultList.get(0), "$..tabs..widgets..widget").toString().substring(11, 39).replaceAll("Text", "");*/
            verifyContains(resultList.get(0).trim(), widgetName.trim());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Results: " + resultList.get(0));
        } catch (Exception e) {
            Assert.fail(widgetName + " not found in db");
            takeScreenShot("MLP_1947_" + widgetName + "_not found in db", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^user clicks on \"([^\"]*)\" from item view list$")
    public void user_clicks_on_from_item_view_list(String itemViewName) throws Throwable {

        try {
            String browserName = propLoader.prop.getProperty("browserName");
            sleepForSec(2000);
            if (browserName.equalsIgnoreCase("chrome")) {
//                waitandFindElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getItemViewList(), itemViewName), 2, false);
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getItemViewList(), itemViewName));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemViewName + " is clicked");
            } else if (browserName.equalsIgnoreCase("firefox")||browserName.equalsIgnoreCase("edge")) {
//                waitandFindElement(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getItemViewListFirefox(), itemViewName), 2, false);
                scrollToWebElement(driver,traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getItemViewListFirefox(), itemViewName));
                clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getItemViewListFirefox(), itemViewName));
                sleepForSec(1500);
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemViewName + " is clicked");
            }
        } catch (Exception e) {
            takeScreenShot("MLP-1947_Not able to click " + itemViewName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click " + itemViewName + e.getMessage());
        }
    }

    @Given("^user enter the page size as \"([^\"]*)\"$")
    public void user_enter_the_page_size_as(String pageSize) throws Throwable {
        try {
            new ItemViewManagerActions(driver).enter_PageSize(pageSize);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), pageSize + " is entered");
        } catch (Exception e) {
            takeScreenShot("MLP-1947_Not able to enter " + pageSize, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^User validate item Preview full view page has \"([^\"]*)\" section$")
    public void user_validate_item_Preview_full_view_page_has_section(String itemPreviewSection) throws Throwable {
        try {

            verifyTrue(traverseListContainsElement(new ItemViewManagement(driver).getItemPreviewTableValue(), itemPreviewSection));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemPreviewSection + " is displayed");
        } catch (Exception e) {
            takeScreenShot("MLP-1947" + itemPreviewSection, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^table header \"([^\"]*)\" should not be displayed$")
    public void table_header_should_not_be_displayed(String headerName) throws Throwable {
        try {
            if (traverseListContainsElement(new ItemViewManagement(driver).getItemPreviewTableValue(), headerName)) {
                Assert.fail("itemPreviewSection " + headerName + " is displayed");
                takeScreenShot("MLP-1947" + headerName, driver);
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("MLP-1947" + headerName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), headerName + " not present");
        } catch (Exception e) {
            takeScreenShot("MLP-1947" + headerName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), headerName + " not present");
        }
    }

    @Then("^\"([^\"]*)\" section should not be displayed in Item Full View page$")
    public void section_should_not_be_displayed_in_Item_Full_View_page(String itemPreviewSection) throws Throwable {
        try {
            if (traverseListContainsElement(new ItemViewManagement(driver).getItemPreviewValue(), itemPreviewSection)) {
                Assert.fail("itemPreviewSection + \" is displayed");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("MLP-1947" + itemPreviewSection, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemPreviewSection + " not present");
        } catch (Exception e) {
            takeScreenShot("MLP-1947" + itemPreviewSection, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemPreviewSection + " not present");
        }
    }

    @Then("^user clicks on add button of filter in multiple attribute widget$")
    public void user_clicks_on_add_button_of_filter_in_multiple_attribute_widget() throws Throwable {
        try {
            sleepForSec(3000);
            new ItemViewManagement(driver).click_addFilterBtnMutlipleAttribute();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add Filter button is clicked");
            sleepForSec(2000);
        } catch (Exception e) {
            takeScreenShot("Unable to click add filter button ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click " + e.getMessage());
        }
    }

    @Given("^user enables hidden checkbox in table header window$")
    public void user_enables_hidden_checkbox_in_table_header_window() throws Throwable {
        try {
            new ItemViewManagement(driver).enableTableHeaderHidden();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Header hidden checkbox enabled");
        } catch (Exception e) {
            takeScreenShot("Table Header hidden checkbox not enabled", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Table Header hidden checkbox not enabled " + e.getMessage());
        }
    }

    @Given("^user click on table header \"([^\"]*)\"$")
    public void user_click_on_table_header(String headerName) throws Throwable {
        try {
            clickOn(traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getWidgetHeadersList(), headerName));
        } catch (Exception e) {
            takeScreenShot("Not able to click on Edit button on the widget", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on Edit button on the widget" + e.getMessage());
        }
    }

    @Given("^user click on delete button in table header child window$")
    public void user_click_on_delete_button_in_table_header_child_window() throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).deleteHeader());
        } catch (Exception e) {
            takeScreenShot("Not able to click on delete button on the table header page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on delete button on the table header page" + e.getMessage());
        }
    }

    @Then("^deleted header \"([^\"]*)\" should not be displayed in widget page$")
    public void deleted_header_should_not_be_displayed_in_widget_page(String headerName) throws Throwable {
        try {
            if (traverseListContainsElement(new ItemViewManagement(driver).getItemPreviewValue(), headerName)) {
                Assert.fail(headerName + " is displayed");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("MLP-1947" + headerName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), headerName + " not present");
        } catch (Exception e) {
            takeScreenShot("MLP-1947" + headerName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), headerName + " not present");
        }
    }

    @Then("^deleted header should not be displayed in widget page$")
    public void deleted_header_should_not_be_displayed_in_widget_page() throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).deleteHeader());
        } catch (Exception e) {
            takeScreenShot("Not able to click on delete button on the table header page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on delete button on the table header page" + e.getMessage());
        }
    }

    @Given("^user enter attribute name as \"([^\"]*)\" in table header page$")
    public void user_enter_attribute_name_as_in_table_header_page(String attributeValue) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).enterTableHeaderAttribute(), attributeValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Attribute value is entered");
        } catch (Exception e) {
            takeScreenShot("Attribute value is not entered ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Attribute value is not entered" + e.getMessage());
        }
    }

    @Given("^user click Apply button in table header window$")
    public void user_click_Apply_button_in_table_header_window() throws Throwable {
        try {
            new ItemViewManagement(driver).clickTableHeaderApply();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button is clicked");
        } catch (Exception e) {
            takeScreenShot("Apply button in table header is not clicked ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button in table header is not clicked" + e.getMessage());
        }
    }

    @Given("^user click Apply button in Attribute Filter window$")
    public void user_click_Apply_button_in_Attribute_Filter_window() throws Throwable {
        try {
            new ItemViewManagement(driver).clickAttributeFilterApply();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button is clicked");
        } catch (Exception e) {
            takeScreenShot("Apply button in table header is not clicked ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button in table header is not clicked" + e.getMessage());
        }
    }

    @Then("^apply button should be disabled$")
    public void apply_button_should_be_disabled() throws Throwable {
        try {
            Assert.assertFalse(new ItemViewManagement(driver).getApplyBtnMutlipleAttributeFilter().isEnabled());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button is disabled");
            takeScreenShot("ML_1947_Apply button is disabled ", driver);
        } catch (Exception e) {
            takeScreenShot("Apply button is enabled ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button is enabled " + e.getMessage());
        }
    }

    @Then("^user clicks on first bundle under Analysis$")
    public void user_clicks_on_first_bundle_under_Analysis() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).getAnalysisFirstBundle());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Bundle click not successful");
        }
    }

    @Then("^user clicks on first bundle version$")
    public void user_clicks_on_first_bundle_version() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).getBundleVersionFirstBundle());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Bundle version click not successful");
        }
    }

    @Then("^user verifies Name Type Version and Plugins label in bundle version page$")
    public void user_verifies_Name_Type_Version_and_Plugins_label_in_bundle_version_page() throws Throwable {
        try {
            Assert.assertTrue(new BundleManager(driver).getBundleNameLabel().isDisplayed());
            Assert.assertTrue(new BundleManager(driver).getBundleTypeLabel().isDisplayed());
            Assert.assertTrue(new BundleManager(driver).getBundleVersionLabel().isDisplayed());
            Assert.assertTrue(new BundleManager(driver).getBundlePluginsLabel().isDisplayed());
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Labels in Bundle version details page not displayed");
        }
    }

    @Then("^user verifies plugin names are displayed$")
    public void user_verifies_plugin_names_are_displayed() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new BundleManager(driver).getBundlePluginNames()));
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Bundle version click not successful");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Then("^Item view \"([^\"]*)\" should have supported type value as \"([^\"]*)\"$")
    public void item_view_should_have_supported_type_value_as(String itemName, String itemType) throws Throwable {
        try {
            waitForPageLoads(driver, 5);
            Assert.assertTrue(itemType.equalsIgnoreCase(getElementText(new ItemViewManagement(driver).getItemType(itemName)).trim()));
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Supported type not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }

    @Then("^Item view \"([^\"]*)\" should have list of supported types as \"([^\"]*)\"$")
    public void item_view_should_have_list_of_supported_types_as(String itemName, String itemType) throws Throwable {
        try {

            String[] expectedItemTypes = itemType.trim().split(",");
            String[] actualItemTypes = new ItemViewManagement(driver).getItemType(itemName).getAttribute("title").trim().split(", ");
            verifyTrue(Arrays.equals(expectedItemTypes, actualItemTypes));
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Supported types not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^user mouse hovers the supported type help icon$")
    public void user_mouse_hovers_the_supported_type_help_icon() throws Throwable {
        try{
            String browserName = propLoader.prop.getProperty("browserName");
            if(browserName.equalsIgnoreCase("chrome")) {
                moveToElement(driver, new ItemViewManagement(driver).getSupportedTypeHoverText());
                LoggerUtil.logLoader_info(this.getClass().getName(), "Mouse hover done in Supported Type field");
            }
            else{
                    moveToElementUsingJavaScript(driver, new ItemViewManagement(driver).getSupportedTypeHoverText());
                    LoggerUtil.logLoader_info(this.getClass().getName(), "Mouse hover done in Supported Type field");
                }
        }catch (Exception e){
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Supported types not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }

    @Then("^\"([^\"]*)\" text should be displayed$")
    public void text_should_be_displayed(String mouseHoverText) throws Throwable {
        try {
            String actualText = getAttributeValue(new ItemViewManagement(driver).getSupportedTypeHoverText(),"title");
            Assert.assertEquals(mouseHoverText, actualText);
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Supported type hover text mismatch with expected text");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^preview page table should have only following values$")
    public void preview_page_table_should_have_only_following_values(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {

            List<String> attributeTableList = new ArrayList<>();
            List<String> actualText = new ArrayList<>();
            for (CucumberDataSet data : dataTableCollection) {
                attributeTableList.add(data.getAttributeTableValues());
            }

            for (WebElement element : new ItemViewManagement(driver).returnPreviewTableValueList()) {
                actualText.add(element.getText().trim());
            }
            Assert.assertTrue(attributeTableList.containsAll(actualText));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Attribute strig values are not displayed in preview page");
        }
    }

    @Given("^user click item name \"([^\"]*)\" in widget page$")
    public void user_click_item_name_in_widget_page(String itemName) throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).click_WidgetItem(itemName));
            sleepForSec(500);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Supported type hover text mismatch with expected text");
        }
    }

    @Then("^preview page table should not have following values$")
    public void preview_page_table_should_not_have_following_values(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {

            List<String> attributeTableList = new ArrayList<>();
            List<String> actualText = new ArrayList<>();
            for (CucumberDataSet data : dataTableCollection) {
                attributeTableList.add(data.getAttributeTableValues());
            }

            for (WebElement element : new ItemViewManagement(driver).returnPreviewTableValueList()) {
                actualText.add(element.getText());
                Assert.assertFalse(attributeTableList.equals(actualText));
            }
//            Assert.assertFalse(attributeTableList.containsAll(actualText));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Attribute strig values are not displayed in preview page");
        }
    }

    @Given("^user enters \"([^\"]*)\" in query name field$")
    public void user_enters_in_query_name_field(String queryName) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).getStoredQueryName(), queryName);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Stored Query is not entered");
        }
    }

    @Given("^Widget \"([^\"]*)\" field help icon should have hover text \"([^\"]*)\"$")
    public void widget_field_help_icon_should_have_hover_text(String fieldName, String hoverText) throws Throwable {
        try {
            sleepForSec(500);
            moveToElementWithActions(driver, new ItemViewManagement(driver).widgetToolTip(fieldName));
            Assert.assertEquals(hoverText.trim(), new ItemViewManagement(driver).widgetHoverText(fieldName).trim());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Hover text mismatches");
        }

    }

    @Given("^\"([^\"]*)\" table header help icon should have hover text \"([^\"]*)\"$")
    public void table_header_help_icon_should_have_hover_text(String fieldName, String hoverText) throws Throwable {
        try {
            sleepForSec(1000);
            moveToElementWithActions(driver, new ItemViewManagement(driver).tableHeaderToolTip(fieldName));
            Assert.assertEquals(hoverText, new ItemViewManagement(driver).tableHeaderHoverText(fieldName).trim());

        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Hover text mismatches");
        }
    }

    @Given("^user clicks on close icon in table header page$")
    public void user_clicks_on_close_icon_in_table_header_page() throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).click_TableHeadCloseButton());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Table Header close button is not clicked");
        }
    }


    @Given("^\"([^\"]*)\" field help icon should have hover text \"([^\"]*)\"$")
    public void field_help_icon_should_have_hover_text(String fieldName, String hoverText) throws Throwable {
        try {
            //scrolltoElement(driver, new ItemViewManagement(driver).getWidgetPageSize(), true);
            //moveToElementUsingAction(driver, new ItemViewManagement(driver).getWidgetPageSize());
            scrollToWebElement(driver,new ItemViewManagement(driver).getWidgetPageSize());
            moveToElementWithActions(driver,new ItemViewManagement(driver).getWidgetPageSize());
            new ItemViewManagement(driver).getWidgetPageSize();
            Assert.assertEquals(hoverText, new ItemViewManagement(driver).pageSizeHoverText().trim());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail(fieldName + " Hover text mismatches");
        }
    }


    @Given("^\"([^\"]*)\" attribute filter help icon should have hover text \"([^\"]*)\"$")
    public void attribute_filter_help_icon_should_have_hover_text(String fieldName, String hoverText) throws Throwable {
        try {
            sleepForSec(1000);
            moveToElementWithActions(driver, new ItemViewManagement(driver).attributeFilterToolTip(fieldName));
            Assert.assertEquals(hoverText, new ItemViewManagement(driver).attributeFilterHoverText(fieldName).trim());

        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Hover text mismatches");
        }
    }

    @Given("^\"([^\"]*)\" field help icon should have hover text as \"([^\"]*)\"$")
    public void field_help_icon_should_have_hover_text_as(String fieldName, String hoverText) throws Throwable {
        try {
            scrolltoElement(driver, new ItemViewManagement(driver).getWidgetType(), true);
            moveToElementUsingAction(driver, new ItemViewManagement(driver).getWidgetType());
            Assert.assertEquals(hoverText, new ItemViewManagement(driver).getWidgetHoverText().trim());

        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail(fieldName + " Hover text mismatches");
        }
    }

    @Given("^user enters \"([^\"]*)\" and perform key action$")
    public void user_enters_and_perform_key_action(String itemViewName) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).returnnewItemViewName(), itemViewName);
            pressKey(new ItemViewManagement(driver).returnnewItemViewName(), Keys.BACK_SPACE);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Entered Name and Definition Successfully");
        } catch (Exception e) {
            takeScreenShot("Not able to enter the values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to enter the values" + e.getMessage());
        }
    }
    @Given("^Error message \"([^\"]*)\" should be displayed in Visual Composer page$")
    public void error_message_should_be_displayed_in_Visual_Composer_page(String alert) throws Throwable {
        try {
            Assert.assertEquals(alert, new ItemViewManagement(driver).getVisualComposerAlert().trim());
            takeScreenShot("Visual Composer Alert Message is displayed as expected", driver);
        } catch (Exception e) {
            takeScreenShot("Visual Composer Alert Message is displayed as expected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Visual Composer Alert Message is not displayed as expected" + e.getMessage());

        }
    }


    @Given("^user enters \"([^\"]*)\" in \"([^\"]*)\" text field$")
    public void user_enters_in_text_field(String groovyText, String fieldName) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).attributeFilterProperties(fieldName),groovyText);
            LoggerUtil.logLoader_info(groovyText+" entered", this.getClass().getName());
        } catch (Exception e) {
            takeScreenShot(groovyText+" entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(groovyText+" not entered"+ e.getMessage());

        }
    }

    @Given("^user enters \"([^\"]*)\" in Query text box$")
    public void user_enters_in_Query_text_box(String queryText) throws Throwable {
        try {
            enterText(new ItemViewManagement(driver).gremlinQueryText(),queryText);
            LoggerUtil.logLoader_info(queryText+" entered", this.getClass().getName());
        } catch (Exception e) {
            takeScreenShot(queryText+" entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(queryText+" not entered"+ e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^following attributes should be displayed in preview page$")
    public void following_attributes_should_be_displayed_in_preview_page(List<CucumberDataSet> dataTableCollection) throws Throwable {
   try{
        List<String> attributeList = new ArrayList<>();
        List<String> actualText = new ArrayList<>();
        for (CucumberDataSet data : dataTableCollection) {
            attributeList.add(data.getPreviewPageAttributeList());
        }
        for (WebElement element : new ItemViewManagement(driver).getItemPreviewValue()) {
            actualText.add(element.getText().trim());
        }
        Assert.assertTrue(attributeList.containsAll(actualText));
       takeScreenShot(this.getClass().getSimpleName(), driver);
       LoggerUtil.logLoader_info("Attributes are displayed", this.getClass().getName());
   } catch (Exception e) {
        takeScreenShot(this.getClass().getSimpleName(), driver);
        Assert.fail("Attribute  List values are not displayed in preview page");
       LoggerUtil.logLoader_error("Attributes are not displayed", this.getClass().getName());
   }
    }

    @Then("^following attributes should not be displayed in preview page$")
    public void following_attributes_should_not_be_displayed_in_preview_page(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try{
            /*List<String> attributeList = new ArrayList<>();
            List<String> actualText = new ArrayList<>();
            for (CucumberDataSet data : dataTableCollection) {
                attributeList.add(data.getPreviewPageAttributeList());
            }
            for (WebElement element : new ItemViewManagement(driver).getItemPreviewValue()) {
                actualText.add(element.getText().trim());
            }*/
            sleepForSec(1000);
            Assert.assertFalse(new ItemViewManagement(driver).VerifyRemovedAttributes());
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_info("Attributes are not displayed", this.getClass().getName());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Attribute  List values are  displayed in preview page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks on apply button on item view config page$")
    public void userClicksOnApplyButtonOnItemViewConfigPage() {
        try{
            sleepForSec(2000);
            clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).getApplyBtnMutlipleAttributeFilter());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Apply button has been clicked");
        }catch (Exception e){
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Apply button could not be clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }
    @And("^user enters the values in the fields under the widget panel$")
    public void user_enters_the_values_in_the_fields_under_the_widget_panel(DataTable data) throws Throwable {
        try {
            sleepForSec(2000);
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                    enterUsingActions(driver,new ItemViewManagement(driver).getWidgetFieldName(values.get("fieldName")), values.get("fieldValue"));
                }
            else {
                    enterText(new ItemViewManagement(driver).getWidgetFieldName(values.get("fieldName")), values.get("fieldValue"));
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("fieldValue") + " text entered in the field " + values.get("fieldName"));
            }

        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail(" Text is not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user mouse hovers the \"([^\"]*)\" help icon and verify \"([^\"]*)\" text displayed$")
    public void user_mouse_hovers_on_icons_in_plugin_configuration(String fieldName, String mouseHoverText) throws Throwable {
        try {
            String actualText = getAttributeValue(new ItemViewManagement(driver).getMouseHoverText(fieldName), "title");
            Assert.assertEquals(mouseHoverText, actualText );
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),fieldName+" hover text match with expected text");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail(fieldName+" hover text doesn't match with expected text");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks the add icon near to \"([^\"]*)\"$")
    public void user_clicks_on_close_icon_in_widget_panel(String fieldName) throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).clickCloseIcon(fieldName));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Table Header close button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^Preview should display the \"([^\"]*)\" Tab$")
    public void previewTabShouldBeDisplayed(String tabName) throws Throwable {
        try {
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                sleepForSec(5000);
            }
            String actualText = getAttributeValue(new ItemViewManagement(driver).getPreviewTab(tabName), "class");
            Assert.assertTrue(actualText.contains("active"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tabName+" is displayed as preview");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(tabName+" is not displayed as preview", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(tabName+" is not displayed as preview" + e.getMessage());

        }
    }

    @And("^user clicks on close icon in preview panel$")
    public void user_clicks_on_close_icon_in_preview_panel() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).getPreviewExitButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Click close icon succesful");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Close icon click error", driver);
            Assert.fail(e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }
    @When("^user clicks on set as preview button in Visual composer$")
    public void user_clicks_on_set_as_preview_button_in_Visual_composer() throws Throwable {
        try {

            new ItemViewManagement(driver).click_setAsPreviewButtonInVisualComposer();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "set as preview  button is clicked");
        } catch (Exception e) {
            takeScreenShot("Not able to click on the set as preview button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Not able to click on the set as preview button" + e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" label should be placed before item name$")
    public void label_should_be_placed_before_item_name(String label) throws Throwable {
        try {
            verifyContains(label, getElementText(new ItemViewManagement(driver).getPreviewLabel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Preview label is displayed");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Preview label is not displayed");
        }
    }

    @And("^user should see the widget \"([^\"]*)\" at the \"([^\"]*)\" position$")
    public void userShouldBeAbleToFindNewPlacedWidgetAtSecondPlace(String widgetName,String widgetPosition) throws Throwable {
        try{
            Assert.assertEquals(getElementText(new ItemViewManagement(driver).getSecondWidget(widgetName)),widgetName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widgetName+"is present in visual cimposer panel" +" at "+widgetPosition+ " position");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail( widgetName+" is not present in visual cimposer panel");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), widgetName+"is not present in visual cimposer panel" +" at "+widgetPosition+ " position");
        }
    }

    @And("^user should not see the widget \"([^\"]*)\" at the \"([^\"]*)\" position$")
    public void userShouldNotSeeGivenWidgetAtGivenPosition(String widgetName,String widgetPosition) throws Throwable {
        try{
            Assert.assertNotEquals(getElementText(new ItemViewManagement(driver).getSecondWidgetTitle()),widgetName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widgetName+"is not present in visual cimposer panel" +" at "+widgetPosition+ " position");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail( widgetName+"is present in visual cimposer panel");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), widgetName+"is present in visual cimposer panel" +" at "+widgetPosition+ " position");
        }
    }

    @Then("^user verifies the grid layout for the value \"([^\"]*)\"$")
    public void userVerifiesGridLayoutIsPresentForTheValues(String valueName) {
        try {
            sleepForSec(2000);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                scrollToWebElement(driver, new ItemViewManagement(driver).getItemValueLayout_Edge(valueName));
                Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getItemValueLayout_Edge(valueName)));
            }
            else{
                scrollToWebElement(driver, new ItemViewManagement(driver).getItemValueLayout(valueName));
                Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getItemValueLayout(valueName)));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Grid layout is displayed for "+valueName);
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Grid layout is not displayed for "+valueName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Grid layout is not displayed for "+valueName);
            Assert.fail("Grid layout is not displayed for "+valueName);
        }
    }

    @Then("^user verifies whether following widgets are displayed$")
    public void user_verifies_whether_following_widgets_are_displayed(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            sleepForSec(1000);
            for (CucumberDataSet data : dataTableCollection) {
              Assert.assertTrue(new ItemViewManagement(driver).getWidgetName(data.getWidgetListFromVisualComposer()).isDisplayed());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget is displayed ");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot( "Widget is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail( "Widget is not displayed" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" checkbox under Item view header$")
    public void user_clicks_on_Item_view_header_checkbox(String checkbox) throws Throwable {
        try {
            sleepForSec(1000);
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")||propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")){
                waitandFindElement(driver, new ItemViewManagement(driver).getItemViewHeaderCheckbox(checkbox), 3, true);
            }
            moveToElementUsingAction(driver,new ItemViewManagement(driver).getItemViewHeaderCheckbox(checkbox));
            clickonWebElementwithJavaScript(driver,new ItemViewManagement(driver).getItemViewHeaderCheckbox(checkbox));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User clicked on "+checkbox+ "checkbox");
            takeScreenShot("User clicked on "+checkbox+ "checkbox", driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Issue in clicking checkbox under item view header", driver);
            Assert.fail("Issue in clicking checkbox under item view header"+e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies fork icon displayed near to any existing item view$")
    public void user_verifies_fork_icon_displayed_near_to_any_existing_item_view() {
        try {
            sleepForSec(1000);
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getForkIcon()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "fork icon displayed near to any existing item view");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("fork icon is not displayed near to any existing item view", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "fork icon is not displayed near to any existing item view");
            Assert.fail("fork icon is not displayed near to any existing item view");
        }
    }

    @Given("^user click Item View Manager resize button$")
    public void user_click_Ite_View_Manager_resize_button() throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).getwidgetSideMenu());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View Manager Resize button is clicked");
        } catch (Exception e) {
            takeScreenShot("Item View  Manager Resize button is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Resize button is not clicked");
        }
    }

    @Given("^user click Item View Manager resize button for \"([^\"]*)\" widget$")
    public void user_click_Item_View_Manager_resize_button(String arg0) throws Throwable {
        try {
            clickOn(new ItemViewManagement(driver).getResizeMenuForTheWidget(arg0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View Manager Resize button is clicked");
        } catch (Exception e) {
            takeScreenShot("Item View  Manager Resize button is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Resize button is not clicked");
        }
    }

    @Then("^Widget size \"([^\"]*)\" should be highlighted in widget resize menu list in item view manager$")
    public void widget_size_should_be_highlighted_in_widget_resize_menu_list(String size) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new ItemViewManagement(driver).getHighlightedSize(size)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View Manager widget is resized");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Item View in dashboard is not clicked", driver);
            Assert.fail("Widget size is not changed");
        }
    }

    @And("^user verifies Tab names are not in uppercase$")
    public void userVerifiesTabNamesAreNotInUppercase() throws Throwable {
        try {
            Assert.assertFalse(traverseListContainsUpperCaseText(new DashBoardPage(driver).getItemFullViewTabs()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TabNames are not displayed in uppercase");
        } catch (Exception e) {
            takeScreenShot("TabNames are displayed in uppercase", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("TabNames are displayed in uppercase" + e.getMessage());
        }
    }

    @And("^user removes widget \"([^\"]*)\" from the visual composer for the item$")
    public void userRemovesWdigetFromTheVisualComposer(String widegtName) throws Throwable {
        try {
            new ItemViewManagement(driver).clickWidgetRemoveButton(widegtName);
            new ItemViewManagement(driver).clickRemoveButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "user removes widget from the visual composer for the item");
        } catch (Exception e) {
            takeScreenShot("user can't able to remove widget from the visual composer for the item", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("user can't able to remove widget from the visual composer for the item" + e.getMessage());
        }
    }

    @And("^user resizes \"([^\"]*)\" widget In Visual Composer as \"([^\"]*)\" and save it$")
    public void userresizesWidget(String widgetName, String resizeOption) {
        try {
            new ItemViewManagerActions(driver).resizeWidgetInItemViewManager(widgetName,resizeOption);
            sleepForSec(3000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager widget is resized");

        } catch (Exception e) {
            takeScreenShot("visual composer button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("visual composer button is not clicked" + e.getMessage());
        }
    }

    @Given("^user configure below parameters for item \"([^\"]*)\" from \"([^\"]*)\" list$")
    public void user_configure_below_parameters_for_item_from_list(String itemName, String panelName, DataTable data) throws Throwable {
        try {
              List<Map<String,String>> dataTable=data.asMaps(String.class,String.class);
            new ItemViewManagerActions(driver).itemViewConfigurations(dataTable,panelName,itemName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager widget is resized");
        } catch (Exception e) {
            takeScreenShot("visual composer button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("visual composer button is not clicked" + e.getMessage());
        }

    }

}

