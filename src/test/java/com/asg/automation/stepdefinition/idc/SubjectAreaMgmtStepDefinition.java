package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.CatalogManagerActions;
import com.asg.automation.pageactions.idc.SubjectAreaMgmtActions;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.pageobjects.idc.SubjectAreaManagement;
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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.asg.automation.utils.PostgresSqlBuilder.getselectedColumnName;

/**
 * Created by muthuraja.ramakrishn on 4/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class SubjectAreaMgmtStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    private DBPostgresUtil db_postgres_util;

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

    @Given("^User gets to see all the available Subject Areas$")
    public void user_gets_to_see_all_the_available_Subject_Areas() {
        try {
            new SubjectAreaManagement(driver).returnListOfSubjectAreas();
            clickOn(new DashBoardPage(driver).getHomeButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @When("^user click on any Subject Area in the list$")
    public void user_click_on_any_Subject_Area_in_the_list() {

        try {
            new SubjectAreaManagement(driver).clickFirstElementinSubjectAreapage();
            clickOn(new DashBoardPage(driver).getHomeButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user click on tags on Edit Subject Area$")
    public void user_click_on_tags_on_Edit_Subject_Area() {

        try {
            new SubjectAreaManagement(driver).clickeditsubjectAreaTagField();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user click on create new tag in edit tags page$")
    public void user_click_on_create_new_tag_in_edit_tags_page() {
        // Write code here that turns the phrase above into concrete actions
        try {
            new SubjectAreaManagement(driver).clickCreateNewTag();
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enter new tag details exists in json config$")
    public void user_enter_new_tag_details_exists_in_json_config() {

        try {
            Thread.sleep(1000);
            new SubjectAreaManagement(driver).enterCreateTagProperties();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on Create Button in Subject Area Management page$")
    public void user_clicks_on_Create_Button_in_Subject_Area_Management_page() {
        try {
            sleepForSec(500);
            new SubjectAreaManagement(driver).click_newSubjectAreaCreateButton();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters Name and Description of New Subject Area using json config \"([^\"]*)\"$")
    public void user_enters_Name_and_Description_of_New_Subject_Area_using_json_config(String arg1) {

        try {
            if (arg1.equalsIgnoreCase("Test Data1")) {
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("createNewSubjectArea", "Name"));
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription(), jsonRead.readJSon("createNewSubjectArea", "Description"));
            } else if (arg1.equalsIgnoreCase("Test Data2")) {
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("createNewSubjectArea2", "Name"));
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription(), jsonRead.readJSon("createNewSubjectArea2", "Description"));
            } else if (arg1.equalsIgnoreCase("Test Data3")) {
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("createNewSubjectArea4", "Name"));
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription(), jsonRead.readJSon("createNewSubjectArea4", "Description"));
            } else if (arg1.equalsIgnoreCase("Invalid Name")) {
                enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), "/");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on choose icon button in new Subject Area page$")
    public void user_clicks_on_choose_icon_button_in_new_Subject_Area_page() {
        try {
            new SubjectAreaManagement(driver).click_chooseIconButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Choose Icon button is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Choose Icon button is not clicked");
        }

    }

    @When("^user selects any icon for the subject area in Subject Area Icon page$")
    public void user_selects_any_icon_for_the_subject_area_in_Subject_Area_Icon_page() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getSubjectAreaIconImage());
            } else {
                clickOn(new SubjectAreaManagement(driver).getSubjectAreaIconImage());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon is selected");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon is not selected");
        }


    }

    @When("^user clicks on save button in New Subject Area page$")
    public void user_clicks_on_save_button_in_New_Subject_Area_page() {

        try {
            sleepForSec(500);
            new SubjectAreaManagement(driver).click_newSubjectAreaSaveButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "New Catalog is created and saved");
            sleepForSec(2000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @When("^user updates name and description in Edit Subject Area page from json config file$")
    public void user_updates_name_and_description_in_Edit_Subject_Area_page_from_json_config_file() {
        try {
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("updateExistingSubjectArea", "Name"));
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription(), jsonRead.readJSon("updateExistingSubjectArea", "Description"));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on mentioned Subject Area in json config file \"([^\"]*)\"$")
    public void user_clicks_on_mentioned_Subject_Area_in_json_config_file(String arg1) {
        try {
            sleepForSec(3000);
            new CatalogManagerActions(driver).selectCatalogFromList(arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User clicks");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Delete button in the New Subject Area page$")
    public void user_clicks_on_Delete_button_in_the_New_Subject_Area_page() {
        try {
            waitandFindElement(driver, new SubjectAreaManagement(driver).getdeleteSubjectAreaButton(), 3, false);
            sleepForSec(1000);
            new SubjectAreaManagement(driver).click_deleteSubjectAreaButton();
            sleepForSec(1500);
            clickOn(new SubjectArea(driver).returnAlertYes());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Yes is clicked in Delete Catalog confirmation popup");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on close button in the Subject Area Icon page$")
    public void user_clicks_on_close_button_in_the_Subject_Area_Icon_page() {
        try {
            new SubjectAreaManagement(driver).click_subjectAreaIconExitButton();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on close button in the New Subject Area page$")
    public void user_clicks_on_close_button_in_the_New_Subject_Area_page() {
        try {
            new SubjectAreaManagement(driver).click_newSubjectAreaPageExitButton();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on mentioned Subject Area to be deleted \"([^\"]*)\" in json config file$")
    public void user_clicks_on_mentioned_Subject_Area_to_be_deleted_in_json_config_file(String arg1) {

        try {
            WebElement element;
            if (arg1.equalsIgnoreCase("Test Data1")) {
                element = traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), jsonRead.readJSon("createNewSubjectArea", "Name"));
                scrollToWebElement(driver, element);
                clickonWebElementwithJavaScript(driver, element);
            } else if (arg1.equalsIgnoreCase("qatestupdated")) {
                element = traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), jsonRead.readJSon("updateExistingSubjectArea", "Name"));
                scrollToWebElement(driver, element);
                clickonWebElementwithJavaScript(driver, element);
            } else if (arg1.equalsIgnoreCase("qaTestTag")) {
                element = traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), jsonRead.readJSon("createNewSubjectArea4", "Name"));
                scrollToWebElement(driver, element);
                clickonWebElementwithJavaScript(driver, element);
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^new Subject Area page should be closed$")
    public void new_Subject_Area_page_should_be_closed() {
        try {
            verifyFalse(isElementPresent(new SubjectAreaManagement(driver).returnnewSubjectAreaPageTitleLabelWithNoSync()));
            takeScreenShot("MLP_259_Verification of close Subject Area page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_259_Verification of close Subject Area page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Subject Area Icon page should be closed$")
    public void subject_Area_Icon_page_should_be_closed() {
        try {
            verifyFalse(isElementPresent(new SubjectAreaManagement(driver).returnsubjectAreaIconPageTitleLabel()));
            takeScreenShot("MLP_259_Verification of close of Subject Area Icon Page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_259_Verification of close of Subject Area Icon Page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^created tag must be displayed in edit tags page$")
    public void created_tag_must_be_displayed_in_edit_tags_page() {
        // Write code here that turns the phrase above into concrete actions
        System.out.println("Placeholder for code");
    }

    @Then("^User traverse to Subject Area Management page$")
    public void user_traverse_to_Subject_Area_Management_page() {
        try {
            Assert.assertTrue(new SubjectAreaManagement(driver).returnSubjectAreaMgmtText().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Such element not found" + e.getMessage());
        }


    }

    @Then("^created subject area should get displayed under Subject Areas in the Subject Area Management page$")
    public void created_subject_area_should_get_displayed_under_Subject_Areas_in_the_Subject_Area_Management_page() {
        try {
            sleepForSec(500);
            verifyTrue(traverseListContainsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), jsonRead.readJSon("createNewSubjectArea", "Name")));
            takeScreenShot("MLP_259_Verification of display of new Subject Area", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_259_Verification of display of new Subject Area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Then("^user \"([^\"]*)\" on \"([^\"]*)\" from the edit catalog panel$")
    public void user_clicks_on_option_from_edit_catalog_panel(String actionType, String elementTobeClicked) {
        try {
            sleepForSec(500);
            new CatalogManagerActions(driver).genericActions(actionType, elementTobeClicked);
            takeScreenShot(elementTobeClicked + " is clicked from the edit catalog panel", driver);
        } catch (Exception e) {
            takeScreenShot(elementTobeClicked + " is not clicked from the edit catalog panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^name and description of the Edited Subject Area should get updated$")
    public void name_and_description_of_the_Edited_Subject_Area_should_get_updated() {
        try {
            verifyTrue(verifyContains(new SubjectAreaManagement(driver).returnnewSubjectAreaName().getAttribute("value"), jsonRead.readJSon("updateExistingSubjectArea", "Name")));
            verifyTrue(verifyContains(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription().getAttribute("value"), jsonRead.readJSon("updateExistingSubjectArea", "Description")));
            takeScreenShot("MLP_259_Verification of disply of edited Subject Area", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_259_Verification of disply of edited Subject Area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^select an icon from the list below label should get displayed$")
    public void select_an_icon_from_the_list_below_label_should_get_displayed() {
        try {
            verifyTrue(new SubjectAreaManagement(driver).returnselectIconFromListLabel().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Then("^could not find the icon you are looking for label should get displayed$")
    public void could_not_find_the_icon_you_are_looking_for_label_should_get_displayed() {
        System.out.println("Code is yet to nbe implemented");
    }

    @Then("^request an icon with the help icon\\(\\?\\) label should get displayed$")
    public void request_an_icon_with_the_help_icon_label_should_get_displayed() {
        System.out.println("Placeholder for code");
    }

    @Then("^deleted subject area mentioned in json config file should not get listed$")
    public void deleted_subject_area_mentioned_in_json_config_file_should_not_get_listed() {
        try {
            waitForPageLoads(driver, 5);
            sleepForSec(1000);
            Boolean bool = traverseListContainsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), jsonRead.readJSon("deleteNewSubjectArea", "Name"));
            if (bool) {
                verifyTrue(false);
            } else {
                verifyTrue(true);
            }
            takeScreenShot("MLP_259_Verification of delete of Subject Area", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_259_Verification of delete of Subject Area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^name,choose icon,quick links,description,users,views,tags field should get displayed in the New Subject Area Page$")
    public void name_choose_icon_quick_links_description_users_views_tags_field_should_get_displayed_in_the_New_Subject_Area_Page() {
        try {
            isElementPresent(new SubjectAreaManagement(driver).returnnewSubjectAreaName());
            isElementPresent(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription());
            isElementPresent(new SubjectAreaManagement(driver).returnchooseIconButton());
            // isElementPresent(new SubjectAreaManagement(driver).returnsubjectAreaQuickLinksLabel());
            // isElementPresent(new SubjectAreaManagement(driver).returnsubjectAreaQuickLinksDropDown1());
            // isElementPresent(new SubjectAreaManagement(driver).returnsubjectAreaQuickLinksDropDown2());
            //isElementPresent(new SubjectAreaManagement(driver).returnsubjectAreaQuickLinksDropDown3());
            isElementPresent(new SubjectAreaManagement(driver).returnSubjectAreaTagField());
            takeScreenShot("MLP_259_Verification of all fields in new Subject Area Manager page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_259_Verification of all fields in new Subject Area Manager page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @When("^user get views and clicks on edit views in Subject Area$")
    public void user_get_views_and_clicks_on_edit_views_in_Subject_Area() {
        try {
            String count = new SubjectAreaManagement(driver).get_subjectAreaViewCount();
            storeTemporaryText(count);
            new SubjectAreaManagement(driver).click_subjectAreaEdit();
            sleepForSec(2000);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit View is clicked");

        } catch (Exception e) {
            takeScreenShot("MLP-1039: Verify whether add item view in subject area is successful", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @When("^user add new item view and click on save button$")
    public void user_add_new_item_view_and_click_on_save_button() {
        try {
            sleepForSec(2000);
            new SubjectAreaManagement(driver).click_subjectAreaAddItemViews();
//            clickOn(traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).getexistingViewsInAssignViewsPage(), "Tag"));
//            List<String> allItems = convertWebElementListIntoStringList(new SubjectAreaManagement(driver).getallItemViewsInDropdown());
//            List<String> existingItems = convertWebElementListIntoStringList(new SubjectAreaManagement(driver).getexistingViewsInAssignViewsPage());
//            allItems.removeAll(existingItems);
//            clickOn(traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).getallItemViewsInDropdown(), allItems.get((int) (Math.random() * 10))));
            new SubjectAreaManagement(driver).click_subjectAreaItemViewsSave();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View is added");
        } catch (Exception e) {
            takeScreenShot("MLP-1039: Verify whether add item view in subject area is successful", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user add existing item view and click on save button$")
    public void user_add_existing_item_view_and_click_on_save_button() {
        try {
            new SubjectAreaManagement(driver).click_subjectAreaAddItemViews();
            clickOn(traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).getexistingViewsInAssignViewsPage(), "Tag"));
            clickOn(traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).getallItemViewsInDropdown(), new SubjectAreaManagement(driver).getexistingViewsInAssignViewsPage().get((int) (Math.random() * 5)).getText()));
            List<WebElement> list2 = new SubjectAreaManagement(driver).getexistingViewsInAssignViewsPage();
            clickOn(list2.get((int) (Math.random() * (list2.size() - 1))));
            new SubjectAreaManagement(driver).click_subjectAreaItemViewsSave();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View is added");
            waitForAngularLoad(driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1039: Verify whether add item view in subject area is successful", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user click on first Subject Area in the list$")
    public void user_click_on_first_Subject_Area_in_the_list() {
        try {
            new SubjectAreaManagement(driver).clickFirstElementinSubjectAreapage();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @Then("^itemviews should be added succesfully$")
    public void itemviews_should_be_added_succesfully() {
        try {
            sleepForSec(1000);
            new SubjectAreaManagement(driver).clickFirstElementinSubjectAreapage();
            int updatedcount = Integer.parseInt(new SubjectAreaManagement(driver).get_subjectAreaViewCount());
            int prevCount = Integer.parseInt(getTemporaryText());
            if ((prevCount + 1) == updatedcount) {
                verifyTrue(true);
            } else
                verifyTrue(false);
            takeScreenShot("Verification of AddItemViews", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of AddItemViews", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user create a new subject area$")
    public void user_create_a_new_subject_area() {
        try {

            new SubjectAreaManagement(driver).click_SubjectAreaManagercreateButton();
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("createNewSubjectArea3", "Name"));
            new SubjectAreaManagement(driver).click_newSubjectAreaSaveButton();
            clickOn(traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).get_subjectAreaNames(), jsonRead.readJSon("createNewSubjectArea3", "Name")));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^itemviews count is not increased$")
    public void itemviews_count_is_not_increased() {
        try {
            int viewsCount = Integer.parseInt(getTemporaryText());
            Assert.assertEquals(Integer.parseInt(new SubjectAreaManagement(driver).get_subjectAreaViewCount()), viewsCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View is added");
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user delete item view and click on save button$")
    public void user_delete_item_view_and_click_on_save_button() {
        try {
            new SubjectAreaManagement(driver).click_firstItemViewDeleteButton();
            new SubjectAreaManagement(driver).click_subjectAreaItemViewsSave();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^itemviews should be deleted succesfully$")
    public void itemviews_should_be_deleted_succesfully() {
        try {
            sleepForSec(1000);
            new SubjectAreaManagement(driver).clickFirstElementinSubjectAreapage();
            int updatedcount = Integer.parseInt(new SubjectAreaManagement(driver).get_subjectAreaViewCount());
            int prevCount = Integer.parseInt(getTemporaryText());
            if ((prevCount - 1) == updatedcount)
                verifyTrue(true);
            else
                verifyTrue(false);
            takeScreenShot("Verification of Delete ItemViews", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            takeScreenShot("Verification of Delete ItemViews", driver);
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Add tag in subject Area$")
    public void user_clicks_on_Add_tag_in_subject_Area() {
        try {
            new SubjectAreaManagement(driver).click_addTag();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters tag details and click save$")
    public void user_enters_tag_details_and_click_save() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                actionSendKeys(driver, new SubjectAreaManagement(driver).returnTagName(), jsonRead.readJSon("tagWorkFlow", "tagName"));
                actionSendKeys(driver, new SubjectAreaManagement(driver).returnTagDefinition(), "tagDefinition");
                new SubjectAreaManagement(driver).click_tagSave();
                sleepForSec(3000);

                //} else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
            } else {
                enterTextWithJavaScript(driver, "QAAUTOMATION TAGG", new SubjectAreaManagement(driver).returnTagName());
                enterTextWithJavaScript(driver, "QAAUTOMATION Tag definition", new SubjectAreaManagement(driver).returnTagDefinition());
                new SubjectAreaManagement(driver).returnTagName().sendKeys(Keys.BACK_SPACE);
                clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getTagSave());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag details are entered and save clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Tag details are not entered ", driver);
        }
    }

    @When("^user clicks on view tags in edit subject area$")
    public void user_clicks_on_view_tags_in_edit_subject_area() {
        try {
//            waitandFindElement(driver, new SubjectAreaManagement(driver).getTags(), 5, false);
            new SubjectAreaManagement(driver).click_tags();
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Then("^added tag should be displayed$")
    public void added_tag_should_be_displayed() {
        try {
            Assert.assertTrue(traverseListContainsElementText(new SubjectAreaManagement(driver).get_tagsList(), jsonRead.readJSon("createNewTag", "Name")));
            takeScreenShot("Verification of Tags added", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Tags added", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @When("^user enter new tag details \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\"$")
    public void user_enter_new_tag_details(String arg1, String arg2, String arg3) {
        try {
            actionSendKeys(driver, new SubjectAreaManagement(driver).enter_TagName(), arg1);
            actionSendKeys(driver, new SubjectAreaManagement(driver).returnTagDefinition(), "tagDefinition");
            new SubjectAreaManagement(driver).click_tagSave();
            sleepForSec(3000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on save button in the edit properties page$")
    public void user_clicks_opn_save_button_in_the_edit_properties_page() {
        try {
            sleepForSec(1000);
            //waitandFindElement(driver, new SubjectAreaManagement(driver).getTagSave(), 3, false);
            new SubjectAreaManagement(driver).click_tagSave();
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clicked on save button in the edit properties page");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "save button in the edit properties page is not clicked");
            takeScreenShot("", driver);
            Assert.fail("save button in the edit properties page is not clicked" + e.getMessage());
        }

    }

    @When("^user verifies save button is diabled in the edit properties page$")
    public void user_verifies_save_button_is_disabled_in_the_edit_properties_page() {
        try {
            sleepForSec(1000);
            Assert.assertFalse(new SubjectAreaManagement(driver).getTagSave().isEnabled());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "save button is diabled in the edit properties page");
            takeScreenShot("save button is diabled in the edit properties page", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("save button is not disabled in the edit properties page" + e.getMessage());
        }

    }

    @Then("^created tag \"([^\"]*)\" must be displayed under tag structure in edit tags page$")
    public void created_tag_must_be_displayed_under_tag_structure_in_edit_tags_page(String arg1) {
        System.out.println("Placeholder for code");
    }

    @When("^user enters leading space in the name field$")
    public void user_enters_space_in_the_name_field() throws Throwable {

        try {
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("LeadingSpace", "Name"));

        } catch (Exception e) {
            takeScreenShot("Leading Space Error", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Leading space is not entered properly" + e.getMessage());

        }
    }

    @Then("^Error message should be displayed as \"([^\"]*)\"$")
    public void error_message_should_be_displayed_as(String arg1) throws Throwable {
        try {
            String actualResult = new SubjectAreaManagement(driver).leadingTrailingError().getText().trim();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1);
            verifyEquals(arg1.trim(), actualResult.trim());
            takeScreenShot("Error Message for Trailing and leading Space", driver);
        } catch (Exception e) {
            takeScreenShot("Error Message for Trailing and leading Space", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Restricted characters Error Message" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Error Message is not found" + e.getMessage());

        }
    }

    @Then("^The user verifies the Save button is disabled on the New Catalog panel$")
    public void the_user_verifies_the_Save_button_is_disabled_on_the_New_Catalog_panel() throws Throwable {
        try {
            new SubjectAreaManagement(driver).newSubjectAreaSaveButtonEnable().isDisplayed();
        } catch (Exception e) {
            takeScreenShot("Save button is not Disabled", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Save button is not disabled" + e.getMessage());

        }
    }

    @When("^user enters trailing space in the name field$")
    public void user_enters_trailing_space_in_the_name_field() throws Throwable {
        try {
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("TrailingSpace", "Name"));

        } catch (Exception e) {
            takeScreenShot("Trailing space not entered correctly", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Trailing space not entered correctly" + e.getMessage());

        }
    }

    @When("^User clicks on the Add button in the Tag section$")
    public void user_clicks_on_the_Add_button_in_the_Tag_section() throws Throwable {
        try {
            new SubjectAreaManagement(driver).Click_AddTag();
        } catch (Exception e) {
            takeScreenShot("Not able to click on the Add button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on the Add button" + e.getMessage());

        }
    }

    @When("^user click on create new tag in the Add tags panel$")
    public void user_click_on_create_new_tag_in_the_Add_tags_panel() throws Throwable {
        try {
            new SubjectAreaManagement(driver).Click_CreateNewTagButton();
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Not able to click on the Create a tag button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on the Create a tag button" + e.getMessage());
        }

    }

    @When("^user enters trailing space in the name field in the New Tag panel$")
    public void user_enters_trailing_space_in_the_name_field_in_the_New_Tag_panel() throws Throwable {
        String browserName = propLoader.prop.getProperty("browserName");
        try {
            if (browserName.equalsIgnoreCase("firefox")) {
                enterText(new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("TrailingSpace", "Name"));
            } else {
                scrolltoElement(driver, new SubjectAreaManagement(driver).enter_TagName(), false);
                clickOn(new SubjectAreaManagement(driver).enter_TagName());
                actionSendKeys(driver, new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("TrailingSpace", "Name"));
            }
        } catch (Exception e) {
            takeScreenShot("Not able to enter trailing space in the New tag panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter the trailing space " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter trailing space in the New tag panel" + e.getMessage());
        }
    }

    @When("^User enters Slash in the name field in the New Catalog panel$")
    public void user_enters_Slash_in_the_name_field_in_the_New_Catalog_panel() throws Throwable {
        try {
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("Forwardslash", "Name"));

        } catch (Exception e) {
            takeScreenShot("Not able to enter Slash in the name field in the New Catalog panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Slash in the name field in the New Catalog panel" + e.getMessage());
        }
    }

    @When("^user enters Backslash in the name field in the New Catalog panel$")
    public void user_enters_Backslash_in_the_name_field_in_the_New_Catalog_panel() throws Throwable {
        try {
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("Backslash", "Name"));

        } catch (Exception e) {
            takeScreenShot("Not able to enters Backslash in the name field in the New Catalog panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters Backslash in the name field in the New Catalog panel" + e.getMessage());
        }
    }

    @When("^user enters leading space in the name field in the New Tag panel$")
    public void user_enters_leading_space_in_the_name_field_in_the_New_Tag_panel() throws Throwable {
        String browserName = propLoader.prop.getProperty("browserName");
        try {
            if (browserName.equalsIgnoreCase("firefox")) {
                enterText(new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("LeadingSpace", "Name"));
            } else {
                scrolltoElement(driver, new SubjectAreaManagement(driver).enter_TagName(), false);
                clickOn(new SubjectAreaManagement(driver).enter_TagName());
                actionSendKeys(driver, new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("LeadingSpace", "Name"));
            }

        } catch (Exception e) {
            takeScreenShot("Not able to enters leading space in the name field in the New Tag panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter the leading space " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters leading space in the name field in the New Tag panel" + e.getMessage());
        }
    }

    @And("^user clicks on BigData catalog and checks for the tag$")
    public void userClicksOnBigDataCatalogAndChecksForTheTag() throws Throwable {
        try {
            new SubjectAreaManagement(driver).click_bigDataSubjectArea();
            sleepForSec(200);
            new SubjectAreaManagement(driver).click_tags();
            sleepForSec(200);
            new SubjectAreaManagement(driver).returntagList();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enters leading space in the name field in the New Tag panel" + e.getMessage());
        }
    }

    @And("^user should find \"([^\"]*)\" tag template and other templates like \"([^\"]*)\" and \"([^\"]*)\"$")
    public void userShouldFindTestTagTemplateTagTemplateAndOtherTemplatesLikeDataAnalysisAndPII(String tagTemplate,
                                                                                                String dataAnlysis, String pii) {
        List<String> arrTagsList = new ArrayList<>();
        try {
            for (WebElement tags : new SubjectAreaManagement(driver).returntagList()) {
                arrTagsList.add(tags.getText());
            }
            Assert.assertTrue(arrTagsList.contains(tagTemplate));
            Assert.assertTrue(arrTagsList.contains(dataAnlysis));
            Assert.assertTrue(arrTagsList.contains(pii));
        } catch (Exception e) {
            Assert.fail("Tag template could not be found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag template could not be found in the catalog");
        }
    }

    @And("^user should find \"([^\"]*)\" tag template and other templates like \"([^\"]*)\" and \"([^\"]*)\" should not be there$")
    public void userShouldFindTagTemplateAndOtherTemplatesLikeAndShouldNotBeThere(String tagTemplate,
                                                                                  String dataAnlysis, String pii) {
        List<String> arrTagsList = new ArrayList<>();
        try {
            for (WebElement tags : new SubjectAreaManagement(driver).returntagList()) {
                arrTagsList.add(tags.getText());
            }
//            Assert.assertEquals(arrTagsList.size(),5);
            Assert.assertFalse(arrTagsList.contains(dataAnlysis));
            Assert.assertFalse(arrTagsList.contains(pii));
            Assert.assertTrue(arrTagsList.contains(tagTemplate));
//            Assert.assertFalse(arrTagsList.contains(dataAnlysis));
//            Assert.assertFalse(arrTagsList.contains(pii));
        } catch (Exception e) {
            Assert.fail("Tag template could not be found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag template could not be found in the catalog");
        }
    }

    @And("^user should find \"([^\"]*)\" tag template and other template \"([^\"]*)\"$")
    public void userShouldFindTagTemplateAndOtherTemplate(String dataAnlysis, String tagTemplate) throws Throwable {
        List<String> arrTagsList = new ArrayList<>();
        try {
            for (WebElement tags : new SubjectAreaManagement(driver).returntagList()) {
                arrTagsList.add(tags.getText());
            }
            Assert.assertTrue(arrTagsList.contains(dataAnlysis));
            Assert.assertTrue(arrTagsList.contains(tagTemplate));
        } catch (Exception e) {
            Assert.fail("Data Analsysis tag template could not be added to catalog");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data Analsysis tag template could not " +
                    "be added to catalog");
        }
    }

    @And("^user should be able to find newly added sub tag \"([^\"]*)\" and its subtag \"([^\"]*)\"$")
    public void userShouldBeAbleToFindNewlyAddedSubTagAndItsSubtag(String newTag, String subTag) throws Throwable {
        List<String> tagsList = new ArrayList<>();
        try {
            for (WebElement tags : new SubjectAreaManagement(driver).returntagList()) {
                tagsList.add(tags.getText());
            }
            Assert.assertTrue(tagsList.contains(newTag));
            Assert.assertTrue(tagsList.contains(subTag));
        } catch (Exception e) {
            Assert.fail(newTag + "could not be found Data Analsysis tag template");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), newTag + "could not be found " +
                    "Data Analsysis tag template");
        }
    }

    @Then("^description for new cataloger should be displayed$")
    public void description_for_new_cataloger_should_be_displayed() throws Throwable {
        try {
            verifyTrue(traverseListContainsElement(new SubjectAreaManagement(driver).returnListOfDescription(), jsonRead.readJSon("createNewSubjectArea", "Description")));
            takeScreenShot("MLP_871_Verification of display description for new subject area", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_871_Verification of display description for new subject area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user verifies views is disabled on  New Catalog panel$")
    public void user_verifies_views_is_disabled_on_New_Catalog_panel() throws Throwable {
        try {
            verifyTrue(new SubjectAreaManagement(driver).getViewsSectionDisable().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Views Section is not Disabled", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Views Section  is not disabled" + e.getMessage());

        }
    }

    @When("^user enters Slash in the name field in the New Tag panel$")
    public void user_enters_Slash_in_the_name_field_in_the_New_Tag_panel() throws Throwable {
        String browserName = propLoader.prop.getProperty("browserName");
        try {
            if (browserName.equalsIgnoreCase("firefox")) {
                enterText(new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("Forwardslash", "Name"));
            } else {
                sendKeysAction(driver, new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("Forwardslash", "Name"));
            }

        } catch (Exception e) {
            takeScreenShot("Not able to enter Slash in the name field in the tag panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter the forward slash " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Slash in the name field in the tag panel" + e.getMessage());
        }
    }

    @When("^user enters Backslash in the name field in the New Tag panel$")
    public void user_enters_Backslash_in_the_name_field_in_the_New_Tag_panel() throws Throwable {
        String browserName = propLoader.prop.getProperty("browserName");
        try {
            if (browserName.equalsIgnoreCase("firefox")) {
                enterText(new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("Forwardslash", "Name"));
            } else {
                scrolltoElement(driver, new SubjectAreaManagement(driver).enter_TagName(), false);
                clickOn(new SubjectAreaManagement(driver).enter_TagName());
                sendKeysAction(driver, new SubjectAreaManagement(driver).enter_TagName(), jsonRead.readJSon("Forwardslash", "Name"));
            }

        } catch (Exception e) {
            takeScreenShot("Not able to enter Backslash in the name field in the tag panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter the Backslash " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Backslash in the name tag panel" + e.getMessage());
        }
    }

    @Given("^user enter double quotes in the name field in the New Tag panel$")
    public void user_enter_double_quotes_in_the_name_field_in_the_New_Tag_panel() throws Throwable {
        String browserName = propLoader.prop.getProperty("browserName");
        try {
            if (browserName.equalsIgnoreCase("firefox")) {
                enterText(new SubjectAreaManagement(driver).enterCatalogName(), jsonRead.readJSon("DoubleQuotes", "Name"));
            } else {
                sendKeysAction(driver, new SubjectAreaManagement(driver).enterCatalogName(), jsonRead.readJSon("DoubleQuotes", "Name"));
            }

        } catch (Exception e) {
            takeScreenShot("Not able to enter Backslash in the name field in the tag panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter the Backslash " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Backslash in the name tag panel" + e.getMessage());
        }
    }

    @Given("^user enter special character \"([^\"]*)\" in the name field$")
    public void user_enter_special_character_in_the_name_field(String specialCharacter) throws Throwable {
        try {
            enterText(new SubjectAreaManagement(driver).enterCatalogName(), specialCharacter);
        } catch (Exception e) {
            takeScreenShot("Not able to enter specialCharacter in the name field in the tag panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not able to enter " + specialCharacter + " in the name field in the tag panel" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter " + specialCharacter + " in the name field in the tag panel" + e.getMessage());
        }
    }

    @When("^user clicks on add tag template button$")
    public void user_clicks_on_add_tag_template_button() throws Throwable {
        try {
            waitandFindElement(driver, new SubjectAreaManagement(driver).getaddTagTemplateButton(), 3, false);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getaddTagTemplateButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add tag template is clicked");
        } catch (Exception e) {
            takeScreenShot("Add tag template is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user selects \"([^\"]*)\" template in the list of tag templates$")
    public void user_selects_template_in_the_list_of_tag_templates(String arg1) throws Throwable {
        try {
            verifyTrue(isElementPresent(new SubjectAreaManagement(driver).gettagTemplatePageCaption()));
            WebElement element = traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).getlistOfTagTemplates(), arg1);
            waitandFindElement(driver, element, 3, false);
            //clickonWebElementwithJavaScript(driver, element);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                clickonWebElementwithJavaScript(driver, element);
            } else {
                clickOn(element);
            }
            clickOn(element);
            sleepForSec(2500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Tag template is selected");
        } catch (Exception e) {
            takeScreenShot(arg1 + "Tag template is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the \"([^\"]*)\" template should get displayed in the Add Tags page$")
    public void the_template_should_get_displayed_in_the_Add_Tags_page(String arg1) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                Assert.assertTrue(isElementPresent(new SubjectAreaManagement(driver).getDynamicParentTag(arg1)));
            } else {
                verifyTrue(new SubjectAreaManagement(driver).getDynamicParentTag(arg1).isDisplayed());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Tag template is displayed in Add Tags page");
            takeScreenShot(arg1 + "Tag template is displayed in Add Tags page", driver);
        } catch (Exception e) {
            takeScreenShot(arg1 + "Tag template is not displayed in Add Tags page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the \"([^\"]*)\" child tag should get displayed in the Add Tags page$")
    public void the_child_tag_should_get_displayed_in_the_Add_Tags_page(String arg1) throws Throwable {
        try {
            verifyTrue(isElementPresent(new SubjectAreaManagement(driver).getDynamicChildTag(arg1)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Child tag is displayed in Add Tags page");
            takeScreenShot(arg1 + "Child tag  is displayed in Add Tags page", driver);
        } catch (Exception e) {
            takeScreenShot(arg1 + "Child tag is not displayed in Add Tags page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on remove button near parent tag$")
    public void user_clicks_on_remove_button_near_parent_tag() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getfirsttagTemplateParenttagRemoveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "First tag Template Parent tag is Removeed");
            takeScreenShot("First tag Template Parent tag is Removeed", driver);
        } catch (Exception e) {
            takeScreenShot("First tag Template Parent tag is not Removeed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^entire tag template should get removed$")
    public void entire_tag_template_should_get_removed() throws Throwable {
        try {
            verifyFalse(isElementPresent(new SubjectAreaManagement(driver).getfirsttagTemplateParenttagNameWithoutSync()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag template is removed");
        } catch (Exception e) {
            takeScreenShot("Tag template is removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on active panel save button$")
    public void user_clicks_on_active_panel_save_button() throws Throwable {
        try {
            waitandFindElement(driver, new SubjectAreaManagement(driver).getactivePanelSaveButton(), 3, false);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getactivePanelSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Save button is clicked");
        } catch (Exception e) {
            takeScreenShot("Save button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on remove button near child tag \"([^\"]*)\"$")
    public void user_clicks_on_remove_button_near_child_tag(String arg1) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getDynamicChildTagRemoveButton(arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Child Tag is removed");
        } catch (Exception e) {
            takeScreenShot("MLP_1736:Child Tag is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^removed child tag should not get added to the new catalog$")
    public void removed_child_tag_should_not_get_added_to_the_new_catalog() throws Throwable {
        try {

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the tags count in the New Subject Area page should be \"([^\"]*)\"$")
    public void the_tags_count_in_the_New_Subject_Area_page_should_be(String arg1) throws Throwable {
        try {
            Assert.assertEquals(new SubjectAreaManagement(driver).gettagsCount().getText(), arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags count is " + arg1);
            takeScreenShot("Tags count is " + arg1, driver);
        } catch (Exception e) {
            takeScreenShot("Tags count is " + arg1, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the removed \"([^\"]*)\" tag should not be present in the Tag Structure$")
    public void the_removed_tag_should_not_be_present_in_the_Tag_Structure(String arg1) throws Throwable {
        try {
            verifyFalse(traverseListContainsElement(new SubjectAreaManagement(driver).getlistOfChildTags(), arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Child Tag is removed from the tag structure");
            takeScreenShot(arg1 + "Child Tag is removed", driver);
        } catch (Exception e) {
            takeScreenShot(arg1 + "Child Tag is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on edit button near the parent tag \"([^\"]*)\"$")
    public void user_clicks_on_edit_button_near_the_parent_tag(String arg1) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getDynamicParentTagEditButton(arg1));
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1500);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Child Tag is removed from the tag structure");
            takeScreenShot(arg1 + "Child Tag is removed", driver);
        } catch (Exception e) {
            takeScreenShot(arg1 + "Child Tag is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user clicks on edit button near the child tag \"([^\"]*)\"$")
    public void user_clicks_on_edit_button_near_the_child_tag(String arg1) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getDynamicChildTagEditButton(arg1));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Child Tag is edited");
        } catch (Exception e) {
            takeScreenShot(arg1 + "Child Tag is not edited", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user enters the new tag name as \"([^\"]*)\"$")
    public void user_enters_the_new_tag_name_as(String arg1) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("firefox")) {
                enterTextWithoutClear(new SubjectAreaManagement(driver).returnTagName(), arg1);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "New Tag name is edited");
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                enterUsingActions(driver, new SubjectAreaManagement(driver).returnTagName(), arg1);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "New Tag name is edited");
                takeScreenShot(arg1 + "Tag is edited", driver);
            } else {
                //enterTextWithJavaScript(driver, arg1, new SubjectAreaManagement(driver).returnTagName());
                sleepForSec(1000);
                enterTextWithoutClear(new SubjectAreaManagement(driver).returnTagName(), arg1);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "New Tag name is edited");
            }

        } catch (Exception e) {
            takeScreenShot(arg1 + "Child Tag is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user enters the tag name as \"([^\"]*)\"$")
    public void user_enters_the_tag_name_as(String arg1) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("firefox") || browserName.equalsIgnoreCase("edge")) {
                enterText(new SubjectAreaManagement(driver).returnTagName(), arg1);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "New Tag name is edited");
                takeScreenShot(arg1 + "Tag name is entered", driver);
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                enterTextWithJavaScript(driver, arg1, new SubjectAreaManagement(driver).returnTagName());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "New Tag nname is edited");
                takeScreenShot(arg1 + "Tag name is not entered", driver);
            }

        } catch (Exception e) {
            takeScreenShot(arg1 + "Tag name is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the \"([^\"]*)\" modified template should get displayed in the Add Tags page$")
    public void the_modified_template_should_get_displayed_in_the_Add_Tags_page(String arg1) throws Throwable {
        try {
            String actualText = getElementText(new SubjectAreaManagement(driver).getDynamicTagInTagStructurePage(arg1)).trim();
            String text = arg1;
            Assert.assertEquals(new SubjectAreaManagement(driver).getDynamicTagInTagStructurePage(arg1).getText().trim(), arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Edited tag is present");
            takeScreenShot(arg1 + "Edited tag is present", driver);
        } catch (Exception e) {
            takeScreenShot(arg1 + "Edited tag is not present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the \"([^\"]*)\" modified template should get displayed in the Add child Tags page$")
    public void the_modified_template_should_get_displayed_in_the_Add_child_Tags_page(String arg1) throws Throwable {
        try {
            verifyTrue(isElementPresent(new SubjectAreaManagement(driver).getDynamicChildTag(arg1)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Edited tag is present");
            takeScreenShot(arg1 + "Edited tag is present", driver);
        } catch (Exception e) {
            takeScreenShot(arg1 + "Edited tag is not present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on close button in the Edit Tags page$")
    public void user_clicks_on_close_button_in_the_Edit_Tags_page() throws Throwable {
        try {
            new CatalogManagerActions(driver).genericClick("edit Tags Page Exit Button");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit tags page is closed");
        } catch (Exception e) {
            takeScreenShot("Edit tags page is not closed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on minus button near the parent tag$")
    public void user_clicks_on_minus_button_near_the_parent_tag() throws Throwable {
        try {
            waitandFindElement(driver, new SubjectAreaManagement(driver).getparentTagMinusButton(), 3, false);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getparentTagMinusButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Parent tag minus button is clicked");
        } catch (Exception e) {
            takeScreenShot("Parent tag minus button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on plus button near the parent tag$")
    public void user_clicks_on_plus_button_near_the_parent_tag() throws Throwable {
        try {
            waitandFindElement(driver, new SubjectAreaManagement(driver).getparentTagPlusButton(), 3, false);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getparentTagPlusButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Parent tag minus button is clicked");
        } catch (Exception e) {
            takeScreenShot("Parent tag minus button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^all the child tags should be hidden$")
    public void all_the_child_tags_should_be_hidden() throws Throwable {
        try {
            verifyTrue(isElementsListPresent(new SubjectAreaManagement(driver).getlistOfhiddenChildTags()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Child tags are not present");
            takeScreenShot("MLP-1120_Collapsing a super tag", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1120_Collapsing a super tag error", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^all the child tags should be shown$")
    public void all_the_child_tags_should_be_shown() throws Throwable {
        try {
            verifyTrue(isElementsListPresent(new SubjectAreaManagement(driver).getlistOfChildTags()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Child tags are present");
            takeScreenShot("MLP-1120_UnCollapsing a super tag", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1120_UnCollapsing a super tag error", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on left triangle button for the child tag \"([^\"]*)\"$")
    public void user_clicks_on_left_triangle_button_for_the_child_tag(String arg1) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getDynamicChildTagLeftTriangleButton(arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Child tag left triangle button is clicked");
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user drag and drops \"([^\"]*)\" parent tag to top$")
    public void user_drag_and_drops_parent_tag_to_top(String arg1) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                dragAndDrop(driver, new SubjectAreaManagement(driver).getDynamicParentTag(arg1), new SubjectAreaManagement(driver).getfirsttagTemplateParenttagName());
                sleepForSec(1000);
            } else {
                dragAndDropElementUsingJavaScript(driver, new SubjectAreaManagement(driver).getDynamicParentTag(arg1), new SubjectAreaManagement(driver).getfirsttagTemplateParenttagName());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "is dragged and dropped to top");
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" parent tag should be in top of the list$")
    public void parent_tag_should_be_in_top_of_the_list(String arg1) throws Throwable {
        try {
            verifyTrue(new SubjectAreaManagement(driver).getfirsttagTemplateParenttagName().getText().trim().equals(arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "is dragged and dropped to top");
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user drag and drops \"([^\"]*)\" child tag to top$")
    public void user_drag_and_drops_child_tag_to_top(String arg1) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                dragAndDrop(driver, new SubjectAreaManagement(driver).getDynamicChildTag(arg1), new SubjectAreaManagement(driver).getlistOfChildTags().get(1));
                sleepForSec(1000);
            } else {
                dragAndDropElementUsingJavaScript(driver, new SubjectAreaManagement(driver).getDynamicChildTag(arg1), new SubjectAreaManagement(driver).getlistOfChildTags().get(1));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "is dragged and dropped to top");
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user drag and drops \"([^\"]*)\" child tag from the parent tag \"([^\"]*)\" to the parent tag \"([^\"]*)\"$")
    public void user_drag_and_drops_child_tag_to_top(String child, String parent, String parent1) throws Throwable {
        try {
            dragAndDropElementUsingJavaScript(driver, new SubjectAreaManagement(driver).getDynamicParentAndChildTag(parent, child), new SubjectAreaManagement(driver).getDynamicParentTag(parent1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), child + "is dragged and dropped");
        } catch (Exception e) {
            takeScreenShot(child + "is not dragged and dropped", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(child + "is not dragged and dropped" + e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" child tag should be in top of the list$")
    public void child_tag_should_be_in_top_of_the_list(String arg1) throws Throwable {
        try {
            verifyTrue(new SubjectAreaManagement(driver).getlistOfChildTags().get(1).getText().trim().equals(arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "is dragged and dropped to top");
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on mentioned Catalog Manager to be deleted \"([^\"]*)\" in json config file$")
    public void user_clicks_on_mentioned_Catalog_Manager_to_be_deleted_in_json_config_file(String arg1) throws Throwable {

        if (arg1.equalsIgnoreCase("Test Data3")) {
            try {
                new SubjectAreaManagement(driver).clickCatalogManager(jsonRead.readJSon("createNewSubjectArea4", "Name"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " catalog is clicked");
            } catch (Exception e) {
                takeScreenShot(arg1 + " catalog is not opened", driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "catalog is not opened");
            }

        }
    }

    @Then("^itemviews count should get increased$")
    public void itemviews_count_should_get_increased() throws Throwable {
        try {
            int viewsCount = Integer.parseInt(getTemporaryText());
            Assert.assertEquals(Integer.parseInt(new SubjectAreaManagement(driver).get_subjectAreaViewCount()), viewsCount + 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View is added");
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^itemviews count should get decreased$")
    public void itemviews_count_should_get_decreased() throws Throwable {
        try {
            int viewsCount = Integer.parseInt(getTemporaryText());
            Assert.assertEquals(Integer.parseInt(new SubjectAreaManagement(driver).get_subjectAreaViewCount()), viewsCount - 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item View is added");
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-981_moving a super tag to a new location", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on Catalog manager$")
    public void user_clicks_on_catalog_manager() throws Throwable {
        try {
            sleepForSec(500);
            new DashBoardPage(driver).Click_subjectAreaManager();
            sleepForSec(500);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user clicks on BigData catalog and checks for the view$")
    public void userClicksOnBigDataCatalogAndChecksForTheView() throws Throwable {
        try {
            new SubjectAreaManagement(driver).click_bigDataSubjectArea();
            sleepForSec(1000);
            new SubjectAreaManagement(driver).click_views();
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user should see the created Item In The Selected Type \"([^\"]*)\"$")
    public void userShouldBeAbleToFindNewlyCreatedItemInTheSelectedType(String type) throws Throwable {
        sleepForSec(3000);
        List<String> itemViews;
        int count = 0;
        String ViewItemText = "";
        try {
            for (WebElement viewsType : new SubjectAreaManagement(driver).getexistingViewsInAssignViewsPage()) {
                if (!getElementText(viewsType).equals(type)) {
                    count++;
                } else {
                    break;
                }
            }
            itemViews = convertWebElementListIntoStringList(new SubjectAreaManagement(driver).getexistingItemViewsInAssignViewsPage());
            ViewItemText = itemViews.get(count).trim();
            Assert.assertEquals(ViewItemText, jsonRead.readJSon("NewItemView", "Name"));

        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail(jsonRead.readJSon("NewItemView", "Name") + "could not be found in Selected type");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), jsonRead.readJSon("NewItemView", "Name") + "could not be found " +
                    "in Selected type");
        }
    }

    @And("^user clicks on save button in the subject area item view page$")
    public void user_clicks_on_save_button_in_Subject_Area_Item_View_page() {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getSubjectAreaItemViewsSaveButton());
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "subject area item view page is saved");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks on save button in the Edit Catalog page$")
    public void user_clicks_on_save_button_in_Edit_Subject_Area_page() {

        try {
            new SubjectAreaManagement(driver).click_editsubjectAreaSave();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit Catalog is and saved");
            sleepForSec(2000);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" catalog and checks for the view$")
    public void userClicksOnCatalogAndChecksForTheView(String catalogName) throws Throwable {
        try {
            new SubjectAreaManagement(driver).click_SubjectArea(catalogName);
            sleepForSec(2000);
            new SubjectAreaManagement(driver).click_views();
            sleepForSec(3000);
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @When("^user enters Name \"(.*)\" and Description of New Subject Area$")
    public void user_enters_Name_and_Description_of_New_Subject_Area(String arg1) {

        try {
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), arg1);
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription(), jsonRead.readJSon("createNewSubjectArea", "Description"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "new subject area name and description is entered");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }

    }

    @And("^user clicks on mentioned catalog \"(.*)\" to be deleted$")
    public void user_clicks_on_mentioned_catalog_to_be_deleted(String arg1) {

        try {
            WebElement element = traverseListContainsElementReturnsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), arg1);
            scrollToWebElement(driver, element);
            clickonWebElementwithJavaScript(driver, element);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "user clicks on the mentioned catalog");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }


    @And("^user clicks on home button from Catalog_Management$")
    public void user_clicks_on_home_button_from_catalog_management() throws Throwable {

        try {
            refresh(driver);
            waitForPageLoads(driver, 5);
            clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getHomeButton());
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on home button");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Clicked on home button", driver);
        }

    }

    @And("^user verifies whether the child tag is present under the root tag$")
    public void user_verifies_whether_the_child_tag_is_presentunder_the_roottag(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                Assert.assertTrue(isElementPresent(new SubjectAreaManagement(driver).getParentAndChildTag(values.get("childTag"), values.get("parentTag"))));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("parentTag") + " contains the child tag" + values.get("childTag"));
            }
        } catch (Exception e) {
            takeScreenShot("Child tag is not present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Child tag is not present" + e.getMessage());
        }
    }

    @And("^user verifies whether the child tag is not present under the root tag$")
    public void user_verifies_whether_the_child_tag_is_not_present_under_the_roottag(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                Assert.assertFalse(new SubjectAreaManagement(driver).getParentAndChildTag(values.get("childTag"), values.get("parentTag")).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("parentTag") + " doesn't contain the child tag" + values.get("childTag"));
            }
        } catch (org.openqa.selenium.NoSuchElementException el) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), el.getMessage());
        } catch (Exception e) {
            takeScreenShot("Child tag is present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Child tag is present" + e.getMessage());
        }
    }

    @And("^user deletes the child tag from the root tag$")
    public void user_deletes_the_child_tag_from_the_root_tag(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                clickonWebElementwithJavaScript(driver, new SubjectAreaManagement(driver).getChildTagRemoveButton(values.get("parentTag"), values.get("childTag")));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("childTag") + " is removed from " + values.get("parentTag"));
            }
        } catch (Exception e) {
            takeScreenShot("Child tag is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Child tag is not removed" + e.getMessage());
        }
    }

    @And("^user verifies the alert message is displayed under the fields in Edit properties panel$")
    public void user_verifies_alert_message_is_displayed_under_the_Edit_properties_panel_field(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                String browserName = propLoader.prop.getProperty("browserName");
                if (browserName.equalsIgnoreCase("firefox") || browserName.equalsIgnoreCase("edge")) {
                    enterTextWithoutClear(new SubjectAreaManagement(driver).returnTagName(), " ");
                    pressKey(new SubjectAreaManagement(driver).returnTagName(), Keys.BACK_SPACE);
                } else {
                    enterUsingActions(driver, new SubjectAreaManagement(driver).returnTagName(), " ");
                    keysOperationUsingActions(driver, new SubjectAreaManagement(driver).returnTagName(), Keys.BACK_SPACE);
                }

                String actualText = getElementText(new SubjectAreaManagement(driver).getFieldAlertMesssage(values.get("fieldName")));
                //actualText = actualText.trim();
                Assert.assertEquals(values.get("validationMessage"), actualText.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("fieldName") + " alert message is displayed under the field");

            }
        } catch (Exception e) {
            takeScreenShot("alert message is not displayed under the field", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("alert message is not displayed under the field" + e.getMessage());
        }
    }

    @And("^user verifies current add tag template panel is not closed$")
    public void user_verifies_current_add_tag_template_panel_is_not_closed() throws Throwable {
        try {
            verifyTrue(isElementPresent(new SubjectAreaManagement(driver).getAddTagTemplatePanel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add tag template panel is not closed");
        } catch (Exception e) {
            takeScreenShot("Tag is added to the list", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^subject area \"([^\"]*)\" should be available in SubjectArea management$")
    public void subject_area_should_be_available_in_SubjectArea_management(String subjectAreaName) throws Throwable {
        try {
            Assert.assertTrue(traverseListContainsElement(new SubjectAreaManagement(driver).get_subjectAreaNames(), subjectAreaName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Subject area is displayed");
            takeScreenShot("Subject area is displayed", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Subject area is not displayed");
            Assert.fail(e.getMessage());
            takeScreenShot("Subject area is not displayed", driver);
        }

    }

    @Then("^user validates the itemviews in subject area$")
    public void user_validates_the_itemviews_in_subject_area(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                Assert.assertTrue(traverseListContainsElement(new SubjectAreaManagement(driver).getexistingItemViewsInAssignViewsPage(), data.getItemViewNames()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet item view is displayed ");
            takeScreenShot("DataSet item view is displayed ", driver);
        } catch (Exception e) {
            takeScreenShot("DataSet item view is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("DataSet item view is not displayed" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" catalog in catalog management$")
    public void userClicksOnCatalogInCatalogmanagement(String catalogName) throws Throwable {
        try {
            new SubjectAreaManagement(driver).click_SubjectArea(catalogName);
            sleepForSec(1000);
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();

        }
    }

    @Then("^Delete button should be disabled$")
    public void delete_button_should_be_disabled() throws Throwable {
        try {
            Assert.assertFalse(new SubjectAreaManagement(driver).getDeleteButton().isEnabled());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete button is disabled");
            takeScreenShot("Delete button is disabled ", driver);
        } catch (Exception e) {
            takeScreenShot("Delete button is enabled ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Delete button is enabled " + e.getMessage());
        }
    }

    @And("^user verifies create item panel is displayed$")
    public void userVerifiesCreateItemPanelIsDisplayed() {
        try {
            Assert.assertTrue(new SubjectAreaManagement(driver).getCreateItemPanelText().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Create Item panel is displayed");
            takeScreenShot("Create Item panel is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Create Item panel is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Create Item panel is not displayed" + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^deleted subject area \"([^\"]*)\" should not be displayed in subject area management page$")
    public void deletedSubjectAreaShouldNotBeDisplayedInSubjectAreaManagementPage(String catalogName) throws Throwable {
        try {
            waitForPageLoads(driver, 5);
            sleepForSec(1000);
            Boolean bool = traverseListContainsElement(new SubjectAreaManagement(driver).returnListOfSubjectAreas(), catalogName);
            if (bool) {
                verifyTrue(false);
            } else {
                verifyTrue(true);
            }

            takeScreenShot("Deleted subject area not found", driver);
        } catch (Exception e) {
            takeScreenShot("Deleted subject area found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" on the dropdown and select the menu for \"([^\"]*)\" and selects \"([^\"]*)\" in catalog advance options panel$")
    public void user_clicks_on_the_dropdown_and_select_option(String actionType, String arg0, String arg1) {
        try {
            new CatalogManagerActions(driver).genericActions(actionType, arg0, arg1);
            sleepForSec(1000);
            if (arg0.equalsIgnoreCase("Schemas")) {
                sleepForSec(15000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Options from the dropdown are clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Options from the dropdown are clicked");
        }

    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" button in the panel$")
    public void user_clicks_on_save_button_in_panel(String actionType, String buttonName) {
        try {
            sleepForSec(1000);
            new CatalogManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "subject area item view page is saved");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" from global header$")
    public void user_clicks_create_button(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaMgmtActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), elementName + " button is clicked");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in create item panel$")
    public void user_clicks_buttons_in_create_panel(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaMgmtActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " is performed on Create Panel " + elementName);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user selects catalog \"([^\"]*)\" and type \"([^\"]*)\" in create item panel$")
    public void userSelectsCatalogAndTypeInCreateItemPanel(String catalogName, String typeName) throws Throwable {
        try {
            sleepForSec(1000);
            new SubjectAreaMgmtActions(driver).userSelectsCatalogAndTypeFromCreateItemPanel(catalogName, typeName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), catalogName + typeName + " is selected from list");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user creates a catalog with name \"([^\"]*)\" and save it in Catalog manager page$")
    public void userCreatesACatalogWithNameAndSaveIt(String catalogName) throws Throwable {
        try{
        new CatalogManagerActions(driver).createCatalog(catalogName);
        sleepForSec(2000);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "catalog is created");
    } catch (Exception e) {
        takeScreenShot(this.getClass().getSimpleName(), driver);
        new DashBoardPage(driver).Click_profileLogoutButton();
        Assert.fail(e.getMessage()+" Issue in creating catalog");
        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
    }
}

    @And("^user selects root type \"([^\"]*)\" and name \"([^\"]*)\" in create item panel$")
    public void userSelectsRootTypeAndNameInCreateItemPanel(String rootType, String itemName) throws Throwable {
        try {
            sleepForSec(1000);
            new SubjectAreaMgmtActions(driver).userSelectsRootTypeAndItemNameFromCreateItemPanel(rootType, itemName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), rootType + itemName + " is selected from list");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @And("^user enters the following values in create item panel fields$")
    public void user_enters_the_following_values_in_create_item_fields(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                scrollToWebElement(driver, new SubjectAreaManagement(driver).getTextFieldElements(values.get("createItemFieldName")));
                sleepForSec(1000);
                enterUsingActions(driver, new SubjectAreaManagement(driver).getTextFieldElements(values.get("createItemFieldName")), values.get("createItemFieldValue"));
                sleepForSec(1000);
            }
        } catch (Exception e) {
            takeScreenShot("Values not entered in configuration page", driver);
            Assert.fail("Values not entered in configuration page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" \"([^\"]*)\" for item in search results page$")
    public void userForItemInSearchResultsPage(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaMgmtActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " is performed on widget Panel " + elementName);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @Given("^user get the ID for item \"([^\"]*)\" from below query for create item page$")
    public void user_get_the_ID_for_field_from_below_query(String FieldName, DataTable dataTableCollection) throws Throwable {
        try {
            List<String> criteriaValue = new ArrayList<>();
            List<String> resultList = new ArrayList<>();
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            db_postgres_util = new DBPostgresUtil();
            criteriaValue.add(FieldName);

            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);

            CommonUtil.storeText(resultList.get(0));
        } catch (Exception e) {
            Assert.fail(" not found in db");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally

        {
            db_postgres_util.disConnect();
        }
    }

    @And("^user \"([^\"]*)\" alert for \"([^\"]*)\" as \"([^\"]*)\"$")
    public void user_verifies_the_alert_message_for_name_field(String elementName, String actionType, String arg) throws Throwable {
        try {
            new CatalogManagerActions(driver).genericActions(actionType, elementName, arg);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "alert is present");
        } catch (Exception e) {
            takeScreenShot("Icon is not present", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert is not present");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }
}