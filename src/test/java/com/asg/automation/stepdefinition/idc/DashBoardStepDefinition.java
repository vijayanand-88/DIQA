package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.*;
import com.asg.automation.pageobjects.ida.AnalysisPage;
import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.apache.solr.common.SolrDocument;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.*;
import org.openqa.selenium.support.Color;
import org.testng.Assert;

import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by muthuraja.ramakrishn on 4/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class DashBoardStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    private CommonUtil commonUtil;
    private RobotClassUtil robotUtil;
    private SolrUtil solr;

    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            jsonRead = new JsonRead();
            propertyLoader();
            solr = new SolrUtil();
            commonUtil = new CommonUtil();
            robotUtil = new RobotClassUtil();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());

        }
    }

    @After("@webtest")
    public void close() throws Exception {
        destroyDriver();

    }

    @When("^user click on Ingestion Configurations link$")
    public void user_click_on_Ingestion_Configurations_link() {
        // Write code here that turns the phrase above into concrete actions
        try {
            new DashBoardPage(driver).Click_ingestionConfiguration();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicking IngestionConfiguration link");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @When("^User click on Subject Area Manager link on the Dashboard page$")
    public void user_click_on_Subject_Area_Manager_link_on_the_Dashboard_page() {
        // Write code here that turns the phrase above into concrete actions
        try {
            if(new DashBoardPage(driver).getSubjectAreaManagerLink().isEmpty()){
                refresh(driver);
                waitForAngularLoad(driver);
            }
            sleepForSec(1000);
            new DashBoardPage(driver).Click_subjectAreaManager();
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Profile Settings button$")
    public void user_clicks_on_Profile_Settings_button() {
        try {
            new DashBoardPage(driver).Click_profileSettingsButton();
            sleepForSec(2000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^profile settings page should get displayed with details and preferences tabs$")
    public void profile_settings_page_should_get_displayed_with_details_and_preferences_tabs() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getdetailsTab().isDisplayed());
            Assert.assertTrue(new DashBoardPage(driver).getpreferencesTab().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("No such element exists");
        }

    }

    @Then("^profile picture name and role of the user \"([^\"]*)\" should get displayed in details tab$")
    public void profile_picture_name_and_role_of_the_user_should_get_displayed_in_details_tab(String role) {


        try {

            Assert.assertTrue(new DashBoardPage(driver).getprofileImage().isDisplayed());

            if (role.equalsIgnoreCase("Data Administrator")) {

                verifyEquals(new DashBoardPage(driver).getprofileName().getText(), propLoader.prop.getProperty("qaDataAdminUserName"));
                verifyEquals(new DashBoardPage(driver).getprofileRole().getText(), role);

            } else if (role.equalsIgnoreCase("System Administrator")) {
                verifyEquals(new DashBoardPage(driver).getprofileName().getText(), propLoader.prop.getProperty("qaSystemAdminUserName"));
                verifyEquals(new DashBoardPage(driver).getprofileRole().getText(), role);
            }
            takeScreenShot("MLP_524_Verification of name and role of user in profile settings", driver);

        } catch (Exception e) {
            takeScreenShot("MLP_524_Verification of name and role of user in profile settings", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Exception" + e.getMessage());
        }

    }

    @When("^user clicks on Profile Settings close button$")
    public void user_clicks_on_Profile_Settings_close_button() {
        try {
            new DashBoardPage(driver).Click_profileExitButton();
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^profile settings page should get closed$")
    public void profile_settings_page_should_get_closed() {
        try {
            Assert.assertFalse(new DashBoardPage(driver).getProfileSettingsTitle().isDisplayed());
            takeScreenShot("MLP_524_Verification of close of profile settings page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_524_Verification of close of profile settings page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on logout button$")
    public void user_clicks_on_logout_button() {
        try {
            waitForPageLoads(driver, 10);
            sleepForSec(1000);
            clickOn(new DashBoardPage(driver).getProfileImage());
            waitForAngularLoad(driver);
            new LoginActions(driver).clickLogOutButton();
//            if(new SubjectArea(driver).retrunAcceptWarning().isDisplayed()){
//                new SubjectArea(driver).click_acceptWarning();
//            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }


    }

    @When("^user clicks on notification icon in the left panel$")
    public void user_clicks_on_notification_icon_in_the_left_panel() {
        try {
            sleepForSec(2000);
            clickOn(new DashBoardPage(driver).Click_notificationsIcon());
            sleepForSec(1000);
//            new SubjectArea(driver).clickAlertsLink();
//            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel icon is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel icon is not clicked");
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on notification icon$")
    public void user_clicks_on_notification_icon() {
        try {
            new DashboardActions(driver).genericClick("notification_icon");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel icon is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel icon is not clicked");
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on mark all read button in the notifications tab$")
    public void user_clicks_on_mark_all_read_button_in_the_notifications_tab() {
        try {
            new DashBoardPage(driver).click_markAllReadNotificationsButton();
            fluentWait(driver, 30, 5);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on dismiss all button in the notifications tab$")
    public void user_clicks_on_dismiss_all_button_in_the_notifications_tab() {
        try {
            new DashBoardPage(driver).click_dismissAllNotificationsButton();
            clickOn(new SubjectArea(driver).returnAlertYes());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on ASG News link in the Dashboard page$")
    public void user_clicks_on_ASG_News_link_in_the_Dashboard_page() {
        try {
            new DashBoardPage(driver).Click_asgNews_WelcomeWidget();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on Documentation link in the Dashboard page$")
    public void user_clicks_on_Documentation_link_in_the_Dashboard_page() {
        try {
            implicit_wait(driver, 10);
            new DashBoardPage(driver).Click_asgDocumentation_WelcomeWidget();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on first open area link in all notification$")
    public void user_clicks_on_first_open_area_link_in_all_notification() {
        try {
//            new SubjectArea(driver).clickAlertsLink();
            waitForAngularLoad(driver);
            storeTemporaryText(new DashBoardPage(driver).returnFirstOpenAreaLinkInNotification().getText());
            new DashboardActions(driver).genericClick("openFirstNotification");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }

    }

    @Then("^subject area manager link should display on Dashboard page$")
    public void subject_area_manager_link_should_display_on_Dashboard_page() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getsubjectAreaManagerLink().isDisplayed());
        } catch (Exception e) {
            Assert.fail("No such element exists");
        } finally {
            takeScreenShot("MLP_259_Verification of Subject Area Manager Link", driver);

        }
    }

    @Then("^Subject Area created notification should get displyed in the notifications tab \"([^\"]*)\"$")
    public void subject_Area_created_notification_should_get_displyed_in_the_notifications_tab(String arg1) {
        try {
            sleepForSec(500);
            new SubjectArea(driver).clickAlertsLink();

            if (arg1.equalsIgnoreCase("Test Data3")) {
                new DashBoardPage(driver).returnNotificationLabel();
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    sleepForSec(2000);
                    verifyTrue(traverseListContainsElement(new DashBoardPage(driver).getnewNotificationsList(), "Catalog " + jsonRead.readJSon("createNewSubjectArea4", "Name") + " has been created"));
                } else {
                    String actalText = jsonRead.readJSon("createNewSubjectArea4", "Name");
                    verifyTrue(traverseListContainsText(new DashBoardPage(driver).getnewNotificationsList(), "Catalog " + actalText));
                }
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_259_Verification of notification for new Subject Area", driver);

        }

    }

    @Then("^notifications icon should display in the left panel$")
    public void notifications_icon_should_display_in_the_left_panel() {
        try {
            isElementPresent(new DashBoardPage(driver).getnotificationsIcon());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_650_Verification of notifications icon", driver);

        }
    }

    @Then("^notification list with newer and older notifications should get displayed$")
    public void notification_list_with_newer_and_older_notifications_should_get_displayed() {
        try {
            int newNotSize = new DashBoardPage(driver).getnewNotificationsList().size();
            int oldNotSize = new DashBoardPage(driver).getoldNotificationsList().size();
            //LoggerUtil.Log.info("New Notifications size is"+newNotSize);
            //LoggerUtil.Log.info("Old Notifications size is"+oldNotSize);

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_650_Verification of newer and older notifications lists", driver);

        }


    }

    @Then("^new notifications list should be empty$")
    public void new_notifications_list_should_be_empty() {
        try {
            if (new DashBoardPage(driver).getnewNotificationsList().size() == 0) {
                verifyTrue(true);
            } else {
                verifyTrue(false);
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_650_Verification of mark all read button functionality", driver);

        }
    }

    @Then("^new and old notifications list should be empty$")
    public void new_and_old_notifications_list_should_be_empty() {
        try {
            if (new DashBoardPage(driver).getnewNotificationsList().size() == 0 && new DashBoardPage(driver).getoldNotificationsList().size() == 0) {
                verifyTrue(true);
            } else {
                verifyTrue(false);
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_650_Verification of dismiss all button functionality", driver);

        }
    }

    @Then("^subject area structure page should get displayed$")
    public void subject_area_structure_page_should_get_displayed() {
        try {
            /*String text = getTemporaryText();
            String t1 = text.substring(9);
            String t2 = new DashBoardPage(driver).returnsubjectAreaTitleInStructurePage().getText();
            verifyTrue(verifyEquals(t2.replaceAll("\"", ""), "Subject Area" + t1));*/
            sleepForSec(1000);
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).getItemCount()));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_650_Verification of subject area structure page", driver);

        }

    }

    @Then("^notification list should get displayed with time stamp$")
    public void notification_list_should_get_displayed_with_time_stamp() {
        try {
            String text = new DashBoardPage(driver).returnfirstNotificationsTimeStamp().getText();
            verifyTrue(checkDateAndTimeFormat(text));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP_650_Verification of notification list with time stamp", driver);

        }

    }

    @Then("^User should traverse to ASG News page in another window$")
    public void user_should_traverse_to_ASG_News_page_in_another_window() {
        try {
            String Actual_WindowName = driver.getTitle();
            String Expected_WinodwName = "News Room - ASG Technologies | ASG.com";
            verifyTrue(verifyEquals(Expected_WinodwName, Actual_WindowName));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^User should traverse to Documentation page in another window$")
    public void user_should_traverse_to_Documentation_page_in_another_window() {
        try {
            switchToChildWindow(driver);
            //implicit_wait(driver, 20);
            String Actual_WindowName = driver.getTitle();
            //System.out.println(Actual_WindowName);
            verifyTrue(verifyEquals("ASG Online Documentation", Actual_WindowName));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^login must be success and ingestion configuration is found$")
    public void login_must_be_success_and_ingestion_configuration_is_found() {
        try {
            isElementPresent(new DashBoardPage(driver).getIngestionConfigurationField());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be seeing the Hive cataloger ingestion start and success notification$")
    public void user_should_be_seeing_the_Hive_cataloger_ingestion_start_and_success_notification() {
        try {
            implicit_wait(driver, 7);
            isElementPresent(new DashBoardPage(driver).getIngestionStartNotification());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be seeing the Hive cataloger ingestion start notification$")
    public void user_should_be_seeing_the_Hive_cataloger_ingestion_start_notification() {
        try {
            implicit_wait(driver, 7);
            isElementPresent(new DashBoardPage(driver).getIngestionStartNotification());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }


    @Then("^definition for WELCOME WIDGET should be displayed on the Dashboard$")
    public void definition_for_WELCOME_WIDGET_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWelcomeWidgetDefinition().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }


    @Then("^Quick links for WELCOME WIDGET should be displayed on the Dashboard$")
    public void quick_links_for_WELCOME_WIDGET_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWelcomeWidgetQuickLinks().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }


    @Then("^brand image for WELCOME WIDGET should be displayed on the Dashboard$")
    public void brand_image_for_WELCOME_WIDGET_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWelcomeWidgetImage().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^description for WELCOME WIDGET should be displayed on the Dashboard$")
    public void description_for_WELCOME_WIDGET_should_be_displayed_on_the_Dashboard() {
        String welcomeWidgetDescription = null;
        try {
            welcomeWidgetDescription = new DashBoardPage(driver).getWelcomeWidgetDescription().getText().trim();
            Assert.assertTrue(welcomeWidgetDescription.contains("Enable business users to quickly discover"));
            //Assert.assertTrue(new DashBoardPage(driver).getWelcomeWidgetDescription().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^title for WELCOME WIDGET should be displayed on the Dashboard$")
    public void title_for_WELCOME_WIDGET_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWelcomeWidgetTitle().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^widget for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void widget_for_INGETION_CONFIGURATION_should_be_dispalyed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionConfiguration().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^description for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void description_for_INGETION_CONFIGURATION_should_be_dispalyed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionDescription().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^image icon for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void image_icon_for_INGESTION_CONFIGURATION_should_be_dispalyed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionImageIcon().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Definition for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void definition_for_INGESTION_CONFIGURATION_should_be_dispalyed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionDefinition().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Quick Links for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void quick_Links_for_INGESTION_CONFIGURATION_should_be_dispalyed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionQuickLinks().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^RECENT label for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void recent_label_for_INGESTION_CONFIGURATION_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionRecentLabel().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Open management quick link for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void open_management_quick_link_for_INGESTION_CONFIGURATION_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getIngestionConfig_OpenManagement().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Create New Configuration quick link for INGESTION CONFIGURATION should be displayed on the Dashboard$")
    public void create_New_Configuration_quick_link_for_INGESTION_CONFIGURATION_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getIngestionConfig_OpenNewConfiguration().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^widget for Subject Area Manager should be displayed on the Dashboard$")
    public void widget_for_Subject_Area_Manager_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_SubjectAreaManager().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^description for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void description_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManager_Description().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^image icon for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void image_icon_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManager_Icon().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Definition for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void definition_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManager_Definition().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Quick Links for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void quick_Links_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManager_QuickLink().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^RECENT label for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void recent_label_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManagerRecentLabel().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Open management quick link for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void open_management_quick_link_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManager_OpenManagement().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Create New Area quick link for SUBJECT AREA MANAGER should be displayed on the Dashboard$")
    public void create_New_Area_quick_link_for_SUBJECT_AREA_MANAGER_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getSubjectAreaManager_CreateNewArea().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }


    }

    @When("^user clicks on Bigdata widget title link in the dashboard page$")
    public void user_clicks_on_Bigdata_widget_title_link_in_the_dashboard_page() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                scrollToWebElement(driver, new DashBoardPage(driver).getSubjectAreaTitle());
                new DashBoardPage(driver).click_subjectAreaTitle();
                sleepForSec(3000);
            } else {
                new DashBoardPage(driver).click_subjectAreaTitle();
                sleepForSec(1000);
            }
            waitForPageLoads(driver, 10);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Pagination feature should be displayed on the Dashboard$")
    public void pagination_feature_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getDashboard_PaginationFeature().isEnabled());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Pagination to last page should be successfull$")
    public void pagination_to_last_page_should_be_successfull() {
        try {
            new DashBoardPage(driver).Click_Dashboard_LastPage();
            Assert.assertTrue(new DashBoardPage(driver).getDashboard_PaginationFeature().isDisplayed());

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Pagination to first page should be successfull$")
    public void pagination_to_first_page_should_be_successfull() {
        try {
            new DashBoardPage(driver).Click_Dashboard_LastPage();
            new DashBoardPage(driver).click_Dashboard_FirstPage();
            Assert.assertTrue(new DashBoardPage(driver).getWelcomeWidgetDefinition().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on edit subject area icon$")
    public void user_clicks_on_edit_subject_area_icon() {
        try {
            String data = jsonRead.readJSon("createNewSubjectArea", "Name");
            new DashBoardPage(driver).click_editSubjectArea();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }

    }

    @When("^user edit the subject area name and click on save$")
    public void user_edit_the_subject_area_name_and_click_on_save() {

        try {
            new DashBoardPage(driver).edit_SubjectAreaName(jsonRead.readJSon("updateSubjectAreaName", "Name"));
            new DashBoardPage(driver).click_EditSubjectAreaSave();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }

    }

    @Then("^updated subject area name should be displayed on the Dashboard$")
    public void updated_subject_area_name_should_be_displayed_on_the_Dashboard() {

        try {
            verifyEquals(new DashBoardPage(driver).get_subjectAreaTitle().getText(), jsonRead.readJSon("updateSubjectAreaName", "Name"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Subject area displayed succesfully");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user edit the subject area description and click on save$")
    public void user_edit_the_subject_area_description_and_click_on_save() {
        try {
            new DashBoardPage(driver).edit_SubjectAreaName(jsonRead.readJSon("updateSubjectAreaName1", "Name"));//To revert name to BigData
            new DashBoardPage(driver).edit_SubjectAreaDescription(jsonRead.readJSon("updateSubjectAreaDesc", "Description"));
            new DashBoardPage(driver).click_EditSubjectAreaSave();
        } catch (Exception e) {

            Assert.fail(e.getMessage());
        }
    }

    @Then("^updated subject area description should be displayed on the Dashboard$")
    public void updated_subject_area_description_should_be_displayed_on_the_Dashboard() {
        verifyEquals(new DashBoardPage(driver).get_subjectAreaDescription().getText(), jsonRead.readJSon("updateSubjectAreaDesc", "Description"));
    }

    @When("^user edit the quick links and click on save$")
    public void user_edit_the_quick_links_and_click_on_save() {
        try {
            dropdownSelectbyIndex(1, new DashBoardPage(driver).get_editSubjectAreaQuicklinks());
            new DashBoardPage(driver).click_EditSubjectAreaSave();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());

        }
    }

    @Then("^updated quick links should be displayed on the Dashboard$")
    public void updated_quick_links_should_be_displayed_on_the_Dashboard() {
        try {
            verifyEquals(new DashBoardPage(driver).get_QuicklinksName().getText(), "Search for table");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Quick links of Subject Area should be displayed on the Dashboard$")
    public void quick_links_of_Subject_Area_should_be_displayed_on_the_Dashboard() {
        try {
            new DashBoardPage(driver).get_SubjectAreaQuicklinksLabel().isDisplayed();
            //new DashBoardPage(driver).get_SubjectAreaQuicklinksList().isDisplayed();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Recent label of Subject Area should be displayed on the Dashboard$")
    public void recent_label_of_Subject_Area_should_be_displayed_on_the_Dashboard() {
        try {
            new DashBoardPage(driver).get_SubjectAreaRecentLabel().isDisplayed();
            new DashBoardPage(driver).get_SubjectAreaRecentList().isDisplayed();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on search subject area icon$")
    public void user_clicks_on_search_subject_area_icon() {
        try {
            new DashBoardPage(driver).click_SubjectAreaSearchButton();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters the search text and clicks on search$")
    public void user_enters_the_search_text_and_clicks_on_search() {
        try {
            new DashBoardPage(driver).enter_SubjectAreaSearchText(jsonRead.readJSon("subjectAreaSearchText", "Name"));
            new DashBoardPage(driver).click_SubjectAreaSearch();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters the search text for table and clicks on search$")
    public void user_enters_the_search_text_for_table_and_clicks_on_search() throws Throwable {
        try {
            enterText(new DashBoardPage(driver).returntopSearchBox(), jsonRead.readJSon("TableName", "Table"));
            clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            waitForPageLoads(driver, 10);
            //new DashBoardPage(driver).enter_SubjectAreaSearchText(jsonRead.readJSon("TableName", "Table"));
            //new DashBoardPage(driver).click_SubjectAreaSearch();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on Add\\(\\+\\) button$")
    public void user_clicks_on_Add_button() {
        try {
            sleepForSec(1000);
            waitForPageLoads(driver, 10);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getdashboard_AddButton());

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User types title for the new dashboard$")
    public void user_types_title_for_the_new_dashboard() {
        try {
            fluentWait(driver, 3000, 3);
            new DashBoardPage(driver).enter_NewDashboardName(jsonRead.readJSon("createNewdashboard", "Name"));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on save button on the dashboard$")
    public void user_clicks_on_save_button_on_the_dashboard() {
        try {
            new DashBoardPage(driver).click_dashboardSaveButton();
            /*clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getdashboardSaveButton());*/
            sleepForSec(2000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Newly added Dashboard should be displayed on the application$")
    public void newly_added_Dashboard_should_be_displayed_on_the_Dashboard() {
        try {
            Thread.sleep(2000);
            verifyTrue(traverseListContainsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("createNewdashboard", "Name")));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on the dashboard name mentioned in the json config file twice$")
    public void user_clicks_on_the_dashboard_name_mentioned_in_the_json_config_file_twice() {

        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("createNewdashboard", "Name"));
                clickonWebElementwithJavaScript(driver, element);
                sleepForSec(1000);
                while (element.isDisplayed()) {
                    clickOn(element);
                    sleepForSec(1000);
                    if (new DashBoardPage(driver).getDashboardEditbutton().isDisplayed()) {
                        break;
                    }
                }
            } else {

                WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("createNewdashboard", "Name"));
                clickOn(element);
                sleepForSec(1000);
                while (element.isDisplayed()) {
                    clickOn(element);
                    sleepForSec(1000);
                    if (new DashBoardPage(driver).getDashboardEditbutton().isDisplayed()) {
                        break;
                    }

                }
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on Edit button$")
    public void user_clicks_on_Edit_button() {
        try {

            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getDashboardEditbutton());
            sleepForSec(1000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Delete button$")
    public void user_clicks_on_Delete_button() {
        try {
            waitForPageLoads(driver, 10);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getDashboardDeleteButton());
            } else {
                clickOn(new DashBoardPage(driver).getDashboardDeleteButton());
            }
            clickOn(new SubjectArea(driver).returnAlertYes());

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^deleted dashboard mentioned in json config file should not get listed$")
    public void deleted_dashboard_mentioned_in_json_config_file_should_not_get_listed() {
        try {
            sleepForSec(2000);
            Boolean bool = traverseListContainsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("deleteNewDashboard", "Name"));
            if (bool) {
                verifyTrue(false);
            } else {
                verifyTrue(true);
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User edits the title of the selected dashboard$")
    public void user_edits_the_title_of_the_selected_dashboard() {
        try {
            sleepForSec(2000);
            new DashBoardPage(driver).enter_NewDashboardName(jsonRead.readJSon("updateExistingDashboard", "Name"));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the edited value should be updated for the dashboard$")
    public void the_edited_value_should_be_updtaed_for_the_dashboard() {
        try {
            sleepForSec(2000);
            verifyTrue(traverseListContainsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("updateExistingDashboard", "Name")));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on the dashboard name to be deleted mentioned in the json config file twice$")
    public void user_clicks_on_the_dashboard_name_to_be_deleted_mentioned_in_the_json_config_file_twice() {
        try {
            sleepForSec(2000);
            WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("deleteNewDashboard", "Name"));
            //LoggerUtil.Log.info(element.getText());
            clickOn(element);
            sleepForSec(2000);
            clickOn(element);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should see the notification for Comment$")
    public void user_should_see_the_notification_for_Comment() {
        try {
            acceptAlert(driver);
            isElementPresent(new DashBoardPage(driver).getcommentsNotification());
        } catch (Exception e) {
            Assert.fail("Comment Notification is not found" + e.getMessage());
        } finally {
            takeScreenShot("MLP-1205 Comment Notifiication", driver);

        }
    }

    @When("^User clicks on active tab on the dashboard$")
    public void user_clicks_on_active_tab_on_the_dashboard_twice() {
        try {
            new DashBoardPage(driver).click_dashboardActiveTab();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User drag and drop a widget to the page from the displayed widget list$")
    public void user_drag_and_drop_a_widget_to_the_page_from_the_displayed_widget_list() {

        try {
            implicit_wait(driver, 3);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped_Edge().get(0);
                sleepForSec(1000);
                dragAndDrop(driver, new DashBoardPage(driver).getElementToBeDragged(), elementtoBePlaced);
                sleepForSec(500);
            } else {
                dragAndDropElementUsingJavaScript(driver, new DashBoardPage(driver).getElementToBeDragged(),
                        new DashBoardPage(driver).getPlaceToBeDropped());
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("Drag and Drop", driver);
        }


    }

    @Given("^User drag and drop a \"([^\"]*)\" widget to the page from the displayed widget list$")
    public void user_drag_and_drop_a_widget_to_the_page_from_the_displayed_widget_list(String arg1) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            WebElement elementtoBeDragged = traverseListContainsElementReturnsElement(new DashBoardPage(driver).geticonCaptionsList(), arg1);
            if (browserName.equalsIgnoreCase("firefox")) {
                WebElement elementtoBePlaced = new DashBoardPage(driver).getTobeDragged();
                dragAndDropwithActions(driver, elementtoBeDragged, elementtoBePlaced);

            } else {
                implicit_wait(driver, 3);
                WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped().get(0);
                dragAndDropElementUsingJavaScript(driver, elementtoBeDragged, elementtoBePlaced);
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("Drag and Drop", driver);
        }
    }


    //    @Then("^Newly added widget should be displayed on the dashboard$")
//    public void newly_added_widget_should_be_displayed_on_the_dashboard()  {
//       try{
//
//       }catch(Exception e){
//           Assert.fail(e.getMessage());
//       }
//    }
    @When("^User clicks on the drop down button in the widget$")
    public void user_clicks_on_the_drop_down_button_in_the_widget() {
        try {
            sleepForSec(1000);
            new DashBoardPage(driver).click_dropdownToggleDashboard();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on the Remove button$")
    public void user_clicks_on_the_Remove_button() {
        try {
            sleepForSec(2000);
            clickOn(new DashBoardPage(driver).getwidgetSideMenu());
            new DashBoardPage(driver).click_removeButton_dashboard();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^removed widget should not be displayed on the dashboard$")
    public void removed_widget_should_not_be_displayed_on_the_dashboard() {
        try {
            Assert.assertFalse(isElementPresent(new DashBoardPage(driver).get_subjectAreaTitle()), "Not Displayed on the screen");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            {
                takeScreenShot("MLP 1174-Remove Button", driver);


            }
        }
    }

    @Then("^Newly added widget should be displayed on the dashboard$")
    public void newly_added_widget_should_be_displayed_on_the_dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).get_subjectAreaTitle().isDisplayed());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
            takeScreenShot("MLP 1174-Drag and Drop a Widget", driver);

        }
    }

    @When("^User clicks on the plus button displayed below the page in the edit mode$")
    public void user_clicks_on_the_plus_button_displayed_below_the_page_in_the_edit_mode() {
        try {
            new DashBoardPage(driver).click_EditDashboardPlusButton();
            sleepForSec(2500);

            scrollToWebElement(driver, new DashBoardPage(driver).getNewDashboard());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Newly added page should be displayed$")
    public void newly_added_page_should_be_displayed() {
        try {
            System.out.println("Code for placeholder");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }

    }

    @When("^user edits the BigData Widget and search in quicklinks$")
    public void user_edits_the_BigData_Widget_and_search_in_quicklinks() {

        try {
            /*clickOn(new DashBoardPage(driver).getwelcomeWidgetSizeMenu());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getwidgetSizeOnebyTwo());*/
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnbigDataWidgetEditbutton());
            sleepForSec(1000);

            scrollToWebElement(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            clickOn(new DashBoardPage(driver).returnquicklinkFirstDropdown());
            //verifyTrue(traverseListContainsElement(new DashBoardPage(driver).returnquicklinkDropdown1(),jsonRead.readJSon("QuickLink","Search Name")));

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Then("^Quicklink of sales table should be available$")
    public void quicklink_of_sales_table_should_be_available() {
        try {
            sleepForSec(1000);
            verifyTrue(traverseListContainsElement(new DashBoardPage(driver).returnquicklinkDropdown1(), jsonRead.readJSon("QuickLink", "Search Name")));

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Quicklink of \"([^\"]*)\" should be available$")
    public void quicklink_of_should_be_available(String arg1) throws Throwable {
        try {

            verifyTrue(traverseListContainsElement(new DashBoardPage(driver).returnquicklinkDropdown1(), jsonRead.readJSon("QuickLink", "Random quick link name")));

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to choose the quicklink and save it$")
    public void user_should_be_able_to_choose_the_quicklink_and_save_it() {
        try {
            //clickOn(new DashBoardPage(driver).returnquickLink());
            //clickonWebElementwithJavaScript(driver,new DashBoardPage(driver).returnquickLinkDropdown());
            //dropdownSelectbyText(jsonRead.readJSon("QuickLink", "Random quick link name"), new DashBoardPage(driver).retrunquicklinkDropdownOne());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnquickLink());
            clickOn(new DashBoardPage(driver).returnWidgetSaveButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink dropdown colud not be selected" + e.getMessage());
        }

    }

    @Then("^Quicklink will be visible in Widget$")
    public void quicklink_will_be_visible_in_Widget() {
        try {
            isElementPresent(new DashBoardPage(driver).returnbigDataWidgetfirstQuicklink());
            takeScreenShot("MLP-1104 Verfication of Created quicklink in BigData Widget", driver);

        } catch (Exception e) {
            takeScreenShot("MLP-1104 Verfication of Created quicklink in BigData Widget", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink is not found in Big Data widget" + e.getMessage());
        }

    }

    @When("^user clicks on a sales fact quicklink$")
    public void user_clicks_on_a_sales_fact_quicklink() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                clickOn(new DashBoardPage(driver).returnbigDataWidgetfirstQuicklink());
                sleepForSec(1500);
            } else {
                clickOn(new DashBoardPage(driver).returnbigDataWidgetfirstQuicklink());
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink is not clickable from big data widget" + e.getMessage());
        }
    }

    @Given("^user creates a new catalog and adds new widget for it in Dashboard$")
    public void user_creates_a_new_catalog_and_adds_new_widget_for_it_in_Dashboard() {
        try {
            new DashBoardPage(driver).Click_subjectAreaManager();
            sleepForSec(500);
            new SubjectAreaManagement(driver).click_newSubjectAreaCreateButton();
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaName(), jsonRead.readJSon("QuickLink", "Catalog Name"));
            enterText(new SubjectAreaManagement(driver).returnnewSubjectAreaDescription(), jsonRead.readJSon("QuickLink", "Catalog Desctiption"));
            sleepForSec(500);
            new SubjectAreaManagement(driver).click_newSubjectAreaSaveButton();
            clickOn(new DashBoardPage(driver).getHomeButton());
            new DashBoardPage(driver).click_dashboardActiveTab();
            new DashBoardPage(driver).click_DashboardEditbutton();
            sleepForSec(5000);/*
            System.out.println("===============================");
            */
            List<String> widgetList = new ArrayList<>();
            WebElement arrow = driver.findElement(By.xpath("//div[@class='right-bottom-side']//div[@class='scroll right-scroll']/span[@class='glyphicon glyphicon-chevron-right']"));
            traverseListContainsElementText(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), "SEARCH CATALOG1");
            while (new ItemViewManagement(driver).getwidgetListFromVisualComposer().size() > 0) {
                for (WebElement ele : new ItemViewManagement(driver).getwidgetListFromVisualComposer()) {

                    widgetList.add(ele.getAttribute("title"));
                }
                if (traverseListContainsElementText(new ItemViewManagement(driver).getwidgetListFromVisualComposer(), "SEARCH CATALOG1")) {
                    dragAndDropElementUsingJavaScript(driver, new DashBoardPage(driver).returnsearchWidget(),
                            new DashBoardPage(driver).getPlaceToBeDropped());
                    new DashBoardPage(driver).click_dashboardSaveButton();
                    break;
                } else if (isElementPresent(new ItemViewManagement(driver).getrightArrowList())) {
                    clickOn(new ItemViewManagement(driver).getrightArrowList());
                    sleepForSec(2000);
                }
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink search is not showing the expected result" + e.getMessage());
        }
    }

    @Then("^BigData and Table facets should be checked and top search box should have a catalog as All$")
    public void bigdata_and_Table_facets_should_be_checked_and_top_search_box_should_have_a_catalog_as_All() {
        try {
            isElementPresent(new SubjectArea(driver).returnbigDataFacetCheckbox());
            isElementPresent(new SubjectArea(driver).returntableFacetCheckbox());
            //verifyEquals(new SubjectArea(driver).retrunsearchCatalogTopic().getText(), "All");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink search is not showing the expected result" + e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" and \"([^\"]*)\" facets should be checked and top search box should have a catalog as All$")
    public void and_facets_should_be_checked_and_top_search_box_should_have_a_catalog_as_All(String catalog, String type) throws Throwable {
        try {
            waitForPageLoads(driver, 5);
//            isElementPresent(new SubjectArea(driver).getFacetCheckbox(catalog));
            isElementPresent(new SubjectArea(driver).getFacetCheckbox(type));
            //verifyEquals(new SubjectArea(driver).retrunsearchCatalogTopic().getText(), "All");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink search is not showing the expected result" + e.getMessage());
        }
    }


    @When("^User searches database by entering a text and choosing the Database facet$")
    public void user_searches_database_by_entering_a_text_and_choosing_the_Database_facet() {
        try {
            enterText(new DashBoardPage(driver).returntopSearchBox(), new JsonRead().readJSon("QuickLink", "search text"));
            clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            sleepForSec(1500);
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returndatabaseFacetEmptyCheckBox());
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search could not be completed" + e.getMessage());
        }

    }

    @When("^User enters the search name, Description and choose the widget BigData and Search Catalog widget and click save$")
    public void user_enters_the_search_name_Description_and_choose_the_widget_BigData_and_Search_Catalog_widget_and_click_save() {
        try {

            sleepForSec(2000);
            while (new SubjectArea(driver).returnsaveSearchButton().isDisplayed()) {
                actionClick(driver, new SubjectArea(driver).returnsaveSearchButton());
                sleepForSec(2000);
                if (new SubjectArea(driver).returnsearchName().isDisplayed()) {
                    break;
                }
            }

            enterText(new SubjectArea(driver).returnsearchName(), new JsonRead().readJSon("QuickLink", "Database search"));
            sleepForSec(1000);
            enterText(new SubjectArea(driver).returnsearchDescription(), new JsonRead().readJSon("QuickLink", "DB search Desc"));
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnsearchWidgetCheckbox());
            waitForPageLoads(driver, 3);
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnquickLinkWidgetselectionCheckbox());
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getQuickLinkSave());
            sleepForSec(2000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Widget cannot be selected" + e.getMessage());

        }
    }

    @When("^User edits big data and Search catalog widget and choose the quick link in both widgets$")
    public void user_edits_big_data_and_Search_catalog_widget_and_choose_the_quick_link_in_both_widgets() {
        try {
            clickOn(new DashBoardPage(driver).getHomeButton());
            sleepForSec(2000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnbigDataWidgetEditbutton());
            actionClick(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            clickOn(new DashBoardPage(driver).returnmultiWidgetQuicklink());
            clickOn(new DashBoardPage(driver).returnWidgetSaveButton());
            clickOn(new DashBoardPage(driver).returnsearchCatalogWidgetEdit());

            actionClick(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            clickOn(new DashBoardPage(driver).returnmultiWidgetQuicklink());
            clickOn(new DashBoardPage(driver).returnWidgetSaveButton());


        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("quicklink cannot be selected" + e.getMessage());
        }

    }

    @Then("^user should be able to see the quicklink in both widgets$")
    public void user_should_be_able_to_see_the_quicklink_in_both_widgets() {

        try {
            sleepForSec(1500);
            verifyTrue(traverseListContainsElement(new DashBoardPage(driver).returnquicklinkList(), new JsonRead().readJSon("QuickLink", "Database search")));
            takeScreenShot("MLP-1104 Verification of adding a quickink to multiple Widget", driver);

        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink not found" + e.getMessage());

        }


    }

    @Then("^user clicks on quicklink should show same result from two widget$")
    public void user_clicks_on_quicklink_should_show_same_result_from_two_widget() {
        try {
            while (new DashBoardPage(driver).returnfirstwidegtquicklinkone().isDisplayed()) {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnfirstwidegtquicklinkone());
                sleepForSec(2000);
                if (new DashBoardPage(driver).getItemListCount().isDisplayed()) {
                    storeTemporaryText(new DashBoardPage(driver).getItemListCount().getText());
                    break;
                } else {
                    refresh(driver);
                    sleepForSec(500);
                }
            }

            sleepForSec(300);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getHomeButton());
            synchronizationVisibilityofElement(driver, new DashBoardPage(driver).returndashboardActiveTab());
            sleepForSec(300);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnsecondWidgetFirstlink());

            verifyEquals(getTemporaryText(), new DashBoardPage(driver).getItemListCount().getText());

        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklinks is not clickable" + e.getMessage());

        }

    }

    @When("^user moves the mouse cursor on quicklink$")
    public void user_moves_the_mouse_cursor_on_quicklink() {
        try {
            moveToElement(driver, new DashBoardPage(driver).returnfirstwidegtquicklinkone());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("mosue pointer coluld not be moved to quiklink" + e.getMessage());

        }

    }

    @Then("^Description of quicklink should be showing as tooltip$")
    public void description_of_quicklink_should_be_showing_as_tooltip() {
        try {
            moveToElement(driver, new DashBoardPage(driver).returnfirstwidegtquicklinkone());
            verifyEquals(new JsonRead().readJSon("QuickLink", "Database search"),
                    new DashBoardPage(driver).returnfirstwidegtquicklinkone().getText());
            takeScreenShot("MLP-1104 Verification of tooltip from quicklink", driver);
        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklinks tool tip is not matching" + e.getMessage());

        }

    }

    @Given("^user clicks on advanced tab and choose advanced solr syntax checkbox$")
    public void user_clicks_on_advanced_tab_and_choose_advanced_solr_syntax_checkbox() {

        try {
            synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getPreference(), 10);
            new DashBoardPage(driver).getpreferencesTab().click();
            synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getAdvanceSearch(), 10);
            new DashBoardPage(driver).getAdvanceSearch().click();
            //synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getExitButton(), 10);
            new DashBoardPage(driver).getExitButton().click();
        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Advanced solr syntax is not able to be checked" + e.getMessage());

        }


    }

    @When("^user enters the search solr syntaxed text for table and clicks on search$")
    public void user_enters_the_search_solr_syntaxed_text_for_table_and_clicks_on_search() {
        try {

            enterText(new DashBoardPage(driver).returntopSearchBox(), jsonRead.readJSon("QuickLink", "Solr"));
            clickOn(new DashBoardPage(driver).returngetTopSearchIcon());

        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search could not be completed" + e.getMessage());

        }
    }

    @Then("^Quicklink of Solar syntaxed search should be available$")
    public void quicklink_of_Solar_syntaxed_search_should_be_available() {

        try {

            clickOn(new DashBoardPage(driver).returnquicklinkFirstDropdown());
            Assert.assertTrue(traverseListContainsElement(new DashBoardPage(driver).returnquicklinkDropdown1(), jsonRead.readJSon("QuickLink", "Solr Name")));


        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("solr search link could not be found" + e.getMessage());

        }

    }

    @Then("^user should be able to choose the solr quicklink and save it$")
    public void user_should_be_able_to_choose_the_solr_quicklink_and_save_it() {

        try {

            clickOn(new DashBoardPage(driver).returnFirstQuicklink());

            clickOn(new DashBoardPage(driver).returnWidgetSaveButton());

        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("solr search link could not be selected" + e.getMessage());

        }

    }

    @When("^user clicks on a solr search databse link$")
    public void user_clicks_on_a_solr_search_databse_link() {
        try {

            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnbigDataWidgetfirstQuicklink());

        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("colud not click on the quicklink" + e.getMessage());

        }

    }

    @Then("^list of databases should be available$")
    public void list_of_databases_should_be_available() {

        try {
            if (new SubjectArea(driver).getDataBaseList().size() >= 1) {
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data base is listed in facets section");
            } else {
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data base is not listed in facets section");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search coluld not be returned" + e.getMessage());
        }

    }

    @When("^user chooses an empty link and save the widget$")
    public void user_chooses_an_empty_link_and_save_the_widget() {
        try {
            sleepForSec(200);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnemptyLink());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("empty link coluld not be assigned" + e.getMessage());
        }

    }

    @Then("^Empty link should be assigned$")
    public void empty_link_should_be_assigned() {
        try {
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnWidgetSaveButton());
            takeScreenShot("MLP-1104 Verification of assigning empty link", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("empty link is not assigned" + e.getMessage());
        }

    }

    @When("^user enters leading space in the name field in the New Dashboard panel$")
    public void user_enters_leading_space_in_the_name_field_in_the_New_Dashboard_panel() throws Throwable {
        try {
            fluentWait(driver, 3000, 3);
            new DashBoardPage(driver).enter_NewDashboardName(jsonRead.readJSon("LeadingSpace", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enter leading space", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter leading space" + e.getMessage());

        }
    }

    @When("^user enters trailing space in the name field in the New Dashboard panel$")
    public void user_enters_trailing_space_in_the_name_field_in_the_New_Dashboard_panel() throws Throwable {
        try {
            fluentWait(driver, 3000, 3);
            new DashBoardPage(driver).enter_NewDashboardName(jsonRead.readJSon("TrailingSpace", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enter trailing space", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter trailing space" + e.getMessage());

        }
    }

    @When("^user enters Slash in the name field in the New Dashboard panel$")
    public void user_enters_Slash_in_the_name_field_in_the_New_Dashboard_panel() throws Throwable {
        try {
            //fluentWait(driver, 3000, 3);
            new DashBoardPage(driver).enter_NewDashboardName(jsonRead.readJSon("Forwardslash", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enter Slash", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Slash" + e.getMessage());

        }
    }

    @When("^user enters Backslash in the name field in the New Dashboard panel$")
    public void user_enters_Backslash_in_the_name_field_in_the_New_Dashboard_panel() throws Throwable {
        try {
            //fluentWait(driver, 3000, 3);
            new DashBoardPage(driver).enter_NewDashboardName(jsonRead.readJSon("Backslash", "Name"));
        } catch (Exception e) {
            takeScreenShot("Not able to enter Backslash", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Backslash" + e.getMessage());

        }
    }

    @When("^user clicks on Preference Tab$")
    public void user_clicks_on_Preference_Tab() throws Throwable {

        try {
            sleepForSec(2000);
            Assert.assertTrue(new DashBoardPage(driver).getpreferencesTab().isDisplayed());
            new DashBoardPage(driver).getpreferencesTab().click();
            waitForPageLoads(driver, 2);
        } catch (Exception e) {
            takeScreenShot("Not able to click on Preference tab", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on Preference tab" + e.getMessage());
        }
    }

    @Then("^user verifies the advanced solr search option displayed as \"([^\"]*)\"$")
    public void user_verifies_the_advanced_solr_search_option_displayed_as(String arg1) throws Throwable {
        try {
            String actualResult = new DashBoardPage(driver).returnAdvanceSlorLabel().getText();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1);
            verifyEquals(arg1, actualResult);
            takeScreenShot("MLP-1711 Advance Solr Search Option", driver);
        } catch (Exception e) {
            takeScreenShot("Advanced Solr Search is not displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Advanced Solr Search is not displayed " + e.getMessage());

        }
    }

    @When("^user enters the search solr syntaxed text for exact match for name and clicks on search$")
    public void user_enters_the_search_solr_syntaxed_text_for_exact_match_for_name_and_clicks_on_search() throws Throwable {
        try {
            enterText(new DashBoardPage(driver).returntopSearchBox(), jsonRead.readJSon("UISolrSearch", "Search Query"));
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returngetTopSearchIcon());

        } catch (Exception e) {
            takeScreenShot("Not able to click on search button ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on search button " + e.getMessage());
        }
    }

    @When("^user enters the solr search query name and clicks on search$")
    public void user_enters_the_solr_search_query_name_and_clicks_on_search(DataTable table) throws Throwable {
        try {
            List<CucumberDataSet> search_dataTable = table.asList(CucumberDataSet.class);
            enterText(new DashBoardPage(driver).returntopSearchBox(), search_dataTable.get(0).getQueryName());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returngetTopSearchIcon());
            sleepForSec(2000);
        } catch (Exception e) {
            takeScreenShot("Not able to click on search button ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on search button " + e.getMessage());
        }
    }

    @When("^the search result matches with the search query$")
    public void the_search_result_matches_with_the_search_query() throws Throwable {
        try {
            String uiItemCount = new SubjectArea(driver).getItemCount().getText().trim();
            LoggerUtil.logLoader_info(uiItemCount, "Number of Items found In UI");
            storeTemporaryText(commonUtil.getNUMfromString(uiItemCount));
            if (Integer.parseInt(commonUtil.getNUMfromString(uiItemCount)) > 0) {
                List<String> itemNames = new ArrayList<String>();
                for (WebElement element : new SubjectArea(driver).getItemNames()) {
                    itemNames.add(element.getText().trim());
                    Assert.assertTrue(itemNames.contains(jsonRead.readJSon("UISolrSearch", "Exact Match")));

                }
                commonUtil.storeTemporaryList(itemNames);
            }

        } catch (Exception e) {
            takeScreenShot("Search Result is not matching ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search Result is not matching  " + e.getMessage());
        }
    }

    @Then("^Solr search count should me matched for exact name search$")
    public void solr_search_count_should_me_matched_for_exact_name_search() throws Throwable {
        try {
            long solrCount = solr.Solr_SearchCount(jsonRead.readJSon("UISolrSearch", "Search Query"), "", "/select");
            long count = Integer.parseInt(getTemporaryText());
            verifyEquals(count, solrCount);
        } catch (Exception e) {
            takeScreenShot("Search Result is not matching ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Result does not contain exact name match  " + e.getMessage());
        }

    }

    @Then("^item name should be matched$")
    public void item_name_should_be_matched() throws Throwable {
        try {
            List<SolrDocument> resultFromSolr = new ArrayList<>();
            resultFromSolr = solr.solrSearchResults(jsonRead.readJSon("UISolrSearch", "Search Query"), "", jsonRead.readJSon("UISolrSearch", "Field Query"), "/select", jsonRead.readJSon("UISolrSearch", "Exact Match"));

            List<SolrDocument> SolrItemNames = new ArrayList<>();
            for (SolrDocument SolrValue : resultFromSolr) {
                SolrItemNames.add(SolrValue);
                Assert.assertTrue(SolrValue.containsValue(jsonRead.readJSon("UISolrSearch", "Exact Match")));
            }

        } catch (Exception e) {
            takeScreenShot("Search Result is not matching ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search Results Matches" + e.getMessage());
        }
    }

    @Then("^Item created should be displayed in notifications$")
    public void item_created_should_be_displayed_in_notifications() throws Throwable {
        try {
            new DashBoardPage(driver).returnItemCreatedList().getText();
            verifyContains(commonUtil.getText(), commonUtil.getText());
            LoggerUtil.logLoader_info(this.getClass().getName(), "Item Created notification is displayed");
        } catch (Exception e) {
            takeScreenShot("Item Created Notification is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Item Created Notification is not displayed" + e.getMessage());
        }

    }

    @Then("^Notification should display \"([^\"]*)\" in IDC UI\\.$")
    public void notification_should_display_in_IDC_UI(String expectedText) throws Throwable {
        commonUtil.getText();
        Assert.assertEquals(expectedText, new DashBoardPage(driver).returnItemCreatedList().getText());
    }

    @When("^user clicks on Administration widget$")
    public void user_clicks_on_Administration_widget() throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(2000);
            }

            new DashBoardPage(driver).Click_administrationDashboard();
            sleepForSec(500);

            takeScreenShot("Clicked on Administration Dashboard", driver);
        } catch (Exception e) {
            takeScreenShot("Not clicked on Administration Dashboard", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not clicked on Administration Dashboard" + e.getMessage());
        }

    }

    @Then("^all available widgets should be displayed$")
    public void all_available_widgets_should_be_displayed() throws Throwable {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getsubjectAreaManagerLink().isDisplayed());
            Assert.assertTrue(new DashBoardPage(driver).getWidget_IngestionConfiguration().isDisplayed());
            Assert.assertTrue(new DashBoardPage(driver).returnItemViewManagement().isDisplayed());

        } catch (Exception e) {
            takeScreenShot("Available widgets are not displaying", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Available widgets are not displaying" + e.getMessage());
        }
    }

    @Then("^Administration dashboard is \"([^\"]*)\"$")
    public void administration_dashboard_display_status(String status) throws Throwable {
        try {
            if (status.equalsIgnoreCase("displayed")) {
                sleepForSec(300);
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnAdministration()));
            } else if (status.equalsIgnoreCase("not displayed")) {
                sleepForSec(300);
                Assert.assertFalse(isElementPresent(new DashBoardPage(driver).returnAdministration()));
            }
        } catch (Exception e) {
            takeScreenShot("Administration Widget is present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Administration Widget is present" + e.getMessage());
        }
    }

    @When("^the user clicks on edit button on the widget$")
    public void the_user_clicks_on_edit_button_on_the_widget() throws Throwable {
        try {
            new DataSetActions(driver).genericClick("widget edit button");
        } catch (Exception e) {
            takeScreenShot("Not able to click on Edit button on the widget", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on Edit button on the widget" + e.getMessage());
        }
    }

    @When("^the user enters description$")
    public void the_user_enters_description() throws Throwable {
        try {
            enterText(new DashBoardPage(driver).returnWidgetDescription(), jsonRead.readJSon("WidgetDescription", "Description"));
        } catch (Exception e) {
            takeScreenShot("Not able to enter the description", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter the description" + e.getMessage());
        }
    }

    @When("^the user clicks on Save button in the widget$")
    public void the_user_clicks_on_Save_button_in_the_widget() throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickOn(new DashBoardPage(driver).returnWidgetSaveButton());
                sleepForSec(1000);
            } else {
                clickOn(new DashBoardPage(driver).returnWidgetSaveButton());
                sleepForSec(1000);
            }
        } catch (Exception e) {
            takeScreenShot("Not able to click on Save button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to click on Save button" + e.getMessage());
        }
    }

    @Then("^the description should be displayed in the widget$")
    public void the_description_should_be_displayed_in_the_widget() throws Throwable {
        try {
            String Description = new DashBoardPage(driver).returnDescriptionPara().getText();
            LoggerUtil.logLoader_info(this.getClass().getName(), Description);
            verifyEquals(jsonRead.readJSon("WidgetDescription", "Description"), Description);
        } catch (Exception e) {
            takeScreenShot("Description is not displaying after the Save", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Description is not displaying after the Save" + e.getMessage());
        }
    }


    @When("^user edits the BigData Widget$")
    public void user_edits_the_BigData_Widget() {

        try {
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnbigDataWidgetEditbutton());

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Given("^user clicks on home button$")
    public void user_clicks_on_home_button() throws Throwable {
        try {
            sleepForSec(1000);
            new DashboardActions(driver).clickHomeButton();
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on home button");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Clicked on home button", driver);
        }

    }

    @Given("^user mouse hovers on the warning message icon$")
    public void user_mouse_hovers_on_the_warning_message_icon() throws Throwable {

        try {
            moveToElementUsingJavaScript(driver, new DashBoardPage(driver).returnwarningButton());
            storeTemporaryText(new DashBoardPage(driver).getToolTip().getText());
            System.out.println(getTemporaryText());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Toll tip of warning icon", driver);
        }

    }

    @Then("^\"([^\"]*)\" should get displayed as a tool tip$")
    public void should_get_displayed_as_a_tool_tip(String arg1) throws Throwable {
        try {
            Assert.assertEquals(getTemporaryText(), arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Tool tip", driver);
        }

    }

    @Then("^deleted subject area should not get listed in the serach catalog dropdown$")
    public void deleted_subject_area_should_not_get_listed_in_the_serach_catalog_dropdown() throws Throwable {

        try {
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getsearchCatalogDropDown());

            verifyFalse(traverseListContainsElementText(new DashBoardPage(driver).returnserachCatalogDropdownList(), jsonRead.readJSon("createNewSubjectArea", "Name")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog is not displayed in serach_catalog_dropdown");
            takeScreenShot("Deleted Subject Area is not in Catalog drop down", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Catalog is  displayed in serach_catalog_dropdown", driver);
        }
    }

    @When("^user clicks on search icon$")
    public void user_clicks_on_search_icon() throws Throwable {
        try {
            sleepForSec(2000);
            new DashboardActions(driver).genericClick("top Search Icon");
            sleepForSec(2000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());

        }
    }

    @When("^user searches for the big data catalog$")
    public void userSearchesForTheBigDataCatalog() throws Throwable {
        try {
            sleepForSec(3000);
            new SubjectArea(driver).retrunsearchButton().click();

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user selects the BigData catalog from catalog list$")
    public void user_selects_the_BigData_catalog_from_catalog_list() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getsearchCatalogDropDown());
            WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).returnserachCatalogDropdownList(), "BigData");
            clickOn(element);
            sleepForSec(1000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Quickstart Dashoboard$")
    public void user_clicks_on_Quickstart_Dashoboard() throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(2000);
            }
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getquickStartDashboard());
            sleepForSec(1000);
            if (new DashBoardPage(driver).getDashboardWidgetStatus()) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "QuickStart dashboard is displayed");
            } else {
                refresh(driver);
                sleepForSec(2000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quickstart dashboard is clicked");
        } catch (Exception e) {
            takeScreenShot("Quickstart dashboard is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^search widget box should get displayed with tooltip$")
    public void search_widget_box_should_get_displayed_with_tooltip() throws Throwable {
        try {
            verifyTrue(isElementPresent(new DashBoardPage(driver).getsearchWidgetBox()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search widget box is displayed");
            takeScreenShot("Search widget box is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Search widget box is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }


    }

    @When("^user enters the \"([^\"]*)\" text in the search widget box$")
    public void user_enters_the_text_in_the_search_widget_box(String arg1) throws Throwable {
        try {
            new DashBoardPage(driver).getsearchWidgetBox().sendKeys(arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^\"([^\"]*)\" alone shoud get displayed in the Widgets layout$")
    public void alone_shoud_get_displayed_in_the_Widgets_layout(String arg1) throws Throwable {
        try {
            Assert.assertEquals(new DashBoardPage(driver).geticonCaptionsList().size(), 1);
            verifyTrue(traverseListContainsElement(new DashBoardPage(driver).geticonCaptionsList(), arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on plus button for adding a new dashboard page$")
    public void user_clicks_on_plus_button_for_adding_a_new_dashboard_page() throws Throwable {
        try {
            clickOn(new DashBoardPage(driver).getplusButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "plus button is clicked for addind a new dashboard page");
        } catch (Exception e) {
            takeScreenShot("Plus button is not clicked for addind a new dashboard page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^User drag and drop a \"(.*)\" widget to the second page from the displayed widget list$")
    public void user_drag_and_drop_a_widget_to_the_second_page_from_the_displayed_widget_list(String arg1) throws Throwable {
        String browserName = propLoader.prop.getProperty("browserName");
        try {

            if (new DashBoardPage(driver).getDashboardWidgetStatus()) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "QuickStart dashboard is displayed");
            } else {
                refresh(driver);
                waitForPageLoads(driver, 4);
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getquickStartDashboard());
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getDashboardEditbutton());
                sleepForSec(4000);
            }
            List<String> widgetList = new ArrayList<>();
            while (new DashBoardPage(driver).geticonCaptionsList().size() > 0) {
                for (WebElement ele : new DashBoardPage(driver).geticonCaptionsList()) {
                    widgetList.add(ele.getAttribute("title"));
                }
                WebElement elementtoBeDragged = traverseListContainsElementReturnsElement(new DashBoardPage(driver).geticonCaptionsList(), arg1);
                if (traverseListContainsElementText(new DashBoardPage(driver).geticonCaptionsList(), arg1)) {
                    if (browserName.equalsIgnoreCase("chrome")) {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped().get(0);

                        sleepForSec(1000);
                        dragAndDropElementUsingJavaScript(driver, elementtoBeDragged, elementtoBePlaced);
                        break;
                    } else if (browserName.equalsIgnoreCase("firefox")) {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped().get(0);
                        sleepForSec(1000);
                        dragAndDrop(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(500);
                        break;
                    } else {
                        WebElement elementtoBePlaced = new AnalysisPage(driver).getPlaceToBeDropped_Edge().get(0);
                        sleepForSec(1000);
                        dragAndDrop(driver, elementtoBeDragged, elementtoBePlaced);
                        sleepForSec(500);
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

    @Given("^user navigates to the second page$")
    public void user_navigates_to_the_second_page() throws Throwable {
        try {
            if (new DashBoardPage(driver).getpaginationOfDashboard().get(1).isDisplayed()) {

                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getpaginationOfDashboard().get(1));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard second page is opened");

        } catch (Exception e) {
            takeScreenShot("Dashboard second page is not created", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user removes the \"([^\"]*)\" in the second page$")
    public void user_removes_the_in_the_second_page(String widgetName) throws Throwable {
        try {
            sleepForSec(1500);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getsecondPagewidgetVerticalOptionButton(widgetName));
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getwidgetRemoveOption());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widgetName + "Widget is removed");
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^the pagination of the dashboard should not display$")
    public void the_pagination_of_the_dashboard_should_not_display() throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertEquals(new DashBoardPage(driver).getpaginationOfDashboardWithoutSync().size(), 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget page is deleted");
            takeScreenShot("Widget page is deleted", driver);
        } catch (Exception e) {
            takeScreenShot("Widget page is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user clicks on delete in the confirm delete popup$")
    public void user_clicks_on_delete_in_the_confirm_delete_popup() throws Throwable {
        try {
            sleepForSec(2000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getconfirmDeleteYesButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard is deleted");
            takeScreenShot("Dashboard is deleted", driver);
        } catch (Exception e) {
            takeScreenShot("Dashboard is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on the dashboard name mentioned in the json config file once$")
    public void user_clicks_on_the_dashboard_name_mentioned_in_the_json_config_file_once() {
        try {
            sleepForSec(1000);
            WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).getDashboardList(), jsonRead.readJSon("createNewdashboard", "Name"));
            waitandFindElement(driver, element, 5, false);
            moveToElement(driver, element);
            clickonWebElementwithJavaScript(driver, element);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard in the json config is clicked");
        } catch (Exception e) {
            takeScreenShot("Dashboard is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @Given("^user clicks on dismiss link in the notification$")
    public void user_clicks_on_dismiss_link_in_the_notification() throws Throwable {
        try {
            new DashBoardPage(driver).clickDismissLink();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dissmiss link is clicked");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No notifications available");
            takeScreenShot("No notifications available", driver);
        }
    }

    @Given("^user clicks No on the alert window$")
    public void user_clicks_No_on_the_alert_window() throws Throwable {
        try {
            clickOn(new DashBoardPage(driver).notificationDismissNo());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification is not dismissed from notification list");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No button in alert is not clicked");
            takeScreenShot("No button in alert is not clicked", driver);
        }
    }

    @Given("^user clicks Yes on the alert window$")
    public void user_clicks_Yes_on_the_alert_window() throws Throwable {
        try {
            clickOn(new DashBoardPage(driver).notificationDismissYes());
            sleepForSec(500);
            waitForAngularLoad(driver);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification dismissed from notification list");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Yes button in alert is not clicked");
            takeScreenShot("Yes button in alert is not clicked", driver);
        }
    }

    @Then("^notification should be removed from notification list$")
    public void notification_should_be_removed_from_notification_list() throws Throwable {
        try {
            int notificationCount = Integer.parseInt(commonUtil.getTemporaryText());
            int currentnotificationsCount = Integer.parseInt(String.valueOf(new DashBoardPage(driver).getNotificationsListCount().size()));
            Assert.assertEquals(notificationCount, currentnotificationsCount);

        } catch (Exception e) {
            Assert.fail("Notification not removed from notifications list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification is not removed from the notification list");
            takeScreenShot("Notification is not removed from the notification list", driver);
        }
    }

    @Given("^user get the count of total notifications$")
    public void user_get_the_count_of_total_notifications() throws Throwable {
        try {
            int currentnotificationsCount = new DashBoardPage(driver).getNotificationsListCount().size();
            commonUtil.storeTemporaryText(String.valueOf(currentnotificationsCount));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification list count is stored in temporary variable");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification is not removed from the notification list");
            takeScreenShot("Notification is not removed from the notification list", driver);

        }
    }

    @Given("^notification count should not be reduced when user click No in dismiss alert$")
    public void notification_count_should_not_be_reduced_when_user_click_No_in_dismiss_alert() throws Throwable {
        try {
            int notificationCount = Integer.parseInt(commonUtil.getTemporaryText());
            int currentnotificationsCount = new DashBoardPage(driver).getNotificationsListCount().size();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification list count is retrieved from temporary variable and compared with actual count");
            Assert.assertEquals(notificationCount, currentnotificationsCount);

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notification count is changed when user click No in dismiss alert");
            takeScreenShot("Notification count is changed when user click No in dismiss alert", driver);

        }
    }

    @Given("^user enters the search text in top search text box$")
    public void user_enters_the_search_text_in_top_search_text_box() throws Throwable {
        try {
            new DashBoardPage(driver).enterTextToTopSearchBox(jsonRead.readJSon("updateSubjectAreaName1", "Name"));
            clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search text entered in text box");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
            takeScreenShot("Search text not entered in text box", driver);
        }
    }


    @When("^user minimizes the browser window$")
    public void user_minimizes_the_browser_window() throws Throwable {
        try {
            Dimension n = new Dimension(400, 600);
            driver.manage().window().setSize(n);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on navigation bar toggle  button$")
    public void user_clicks_on_navigation_bar_toggle_button() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getnavigationBarToggleButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "NavigationBar Toggle Button is clicked");
        } catch (Exception e) {
            takeScreenShot("NavigationBar Toggle Button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^all the widgets should get aligned properly for the minimized window$")
    public void all_the_widgets_should_get_aligned_properly_for_the_minimized_window() throws Throwable {
        try {
            verifyTrue(new DashBoardPage(driver).getProfileSettingsButton().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters the search text \"([^\"]*)\" in the Search Data Intelligence Suite area$")
    public void user_enters_the_search_text_in_the_Search_Data_Intelligence_Suite_area(String searchtext) throws Throwable {
        try {
            sleepForSec(1000);
            enterText(new DashBoardPage(driver).returntopSearchBox(), searchtext);
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search text is entered");
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Search text is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^cross button should get displayed in the Search Data Intelligence Suite area$")
    public void cross_button_should_get_displayed_in_the_Search_Data_Intelligence_Suite_area() throws Throwable {
        try {
            verifyTrue(isElementPresent(new DashBoardPage(driver).getremoveSearchTextButton()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Cross button is displayed in serach area");
            takeScreenShot("Cross button is displayed in serach area", driver);
        } catch (Exception e) {
            takeScreenShot("Cross button is not displayed in serachh area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clears the text in the Search Data Intelligence Suite area$")
    public void user_clears_the_text_in_the_Search_Data_Intelligence_Suite_area() throws Throwable {
        try {
            new DashBoardPage(driver).returntopSearchBox().sendKeys(Keys.BACK_SPACE, Keys.BACK_SPACE, Keys.BACK_SPACE, Keys.BACK_SPACE);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search text is cleared in the Search box");
        } catch (Exception e) {
            takeScreenShot("Search text is not cleared in the Search box", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^cross button should not get displayed in the Search Data Intelligence Suite area$")
    public void cross_button_should_not_get_displayed_in_the_Search_Data_Intelligence_Suite_area() throws Throwable {
        try {
            verifyFalse(isElementPresent(new DashBoardPage(driver).getremoveSearchTextButtonWithoutSync()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Cross button is not displayed in serach area");
            takeScreenShot("Cross button is not displayed in serach area", driver);
        } catch (Exception e) {
            takeScreenShot("Cross button is displayed in serach area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on cross button in the Search Data Intelligence Suite area$")
    public void user_clicks_on_cross_button_the_Search_Data_Intelligence_Suite_area() throws Throwable {
        try {
            new DashboardActions(driver).genericClick("remove Search Text Button");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Cross button is clicked in serach area");
            takeScreenShot("Cross button is clicked in serach area", driver);
        } catch (Exception e) {
            takeScreenShot("Cross button is not displayed in serach area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @When("^user clicks on dismiss for any notification$")
    public void user_clicks_on_dismiss_for_any_notification() throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                int count = new DashBoardPage(driver).getNotificationsListCount().size();
                storeTemporaryText(String.valueOf(count));
                clickOn(new DashBoardPage(driver).getfirstNotificationDismissButton());
                //storeTemporaryText(new DashBoardPage(driver).getfirstNotificationTimestamp().getText());
            } else {
                int count = new DashBoardPage(driver).getNotificationsListCount().size();
                storeTemporaryText(String.valueOf(count));
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getfirstNotificationDismissButton());

            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dismiss button is clicked for first notification");
            takeScreenShot("Dissmiss button popup is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the notification should not be present in new Notifications$")
    public void the_notification_should_not_be_present_in_new_Notifications() throws Throwable {
        try {
            Assert.assertNotEquals(getTemporaryText(), (new DashBoardPage(driver).getNotificationsListCount().size()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification is dismissed");
            takeScreenShot("Notification is dismissed", driver);
        } catch (Exception e) {
            takeScreenShot("Notification is not dismissed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user refreshes the application$")
    public void user_refreshes_the_application() throws Throwable {
        try {
            driver.navigate().refresh();
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(2500);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Application is refreshed");
            takeScreenShot("MLP-1592_Verification of refreshing the application", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1592_Verification of refreshing the application", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on any recent link in Catalog Manager widget$")
    public void user_clicks_on_any_recent_link_in_Catalog_Manager_widget() throws Throwable {
        try {
            waitandFindElement(driver, new DashBoardPage(driver).getcatalogManagerRecentLinksList().get(0), 3, false);
            clickOn(new DashBoardPage(driver).getcatalogManagerRecentLinksList().get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link is clicked");
        } catch (Exception e) {
            takeScreenShot("Verification of list of recent quick links for Subject Area Manager", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^edit catalog page should get displayed$")
    public void edit_catalog_page_should_get_displayed() throws Throwable {
        try {
            verifyTrue(isElementPresent(new DashBoardPage(driver).geteditCatalogPageTitle()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit catalog page is displayed");
            takeScreenShot("Verification of list of recent quick links for Subject Area Manager", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of list of recent quick links for Subject Area Manager", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user sets the size of the welcome widegt as two by two$")
    public void userSetsTheSizeOfTheWelcomeWidegtAsTwoByTwo() {
        try {

            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getwelcomeWidgetSizeMenu());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getwidgetsizeTwobyTwo());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getwelcomeWidgetSizeMenu());

        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }

    }

    @When("^user edits the BigData and search catalog Widget and search in quicklinks$")
    public void userEditsTheBigDataAndSearchCatalogWidgetAndSearchInQuicklinks() {
        try {
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnbigDataWidgetEditbutton());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnemptyLink());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user edits the search catalog and assigns empty links$")
    public void userEditsTheSearchCatalogAndAssignsEmptyLinks() {
        try {
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnWidgetSaveButton());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnsearchCatalogWidgetEdit());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnemptyLink());
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user selects \"(.*)\" catalog from catalog list$")
    public void user_selects_catalog_from_catalog_list(String catalogName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                clickOn(new SubjectArea(driver).getsearchCatalogDropDown());
                WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).returnserachCatalogDropdownList(), catalogName);
                clickOn(element);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Selection of catalog" + catalogName + "successful");
            } else {
                clickOn(new SubjectArea(driver).getsearchCatalogDropDown());
                WebElement element = traverseListContainsElementReturnsElement(new DashBoardPage(driver).returnserachCatalogDropdownList(), catalogName);
                scrolltoElement(driver,element,true);
                clickOn(driver,element);
                sleepForSec(1000);
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Selection of catalog" + catalogName + "successful");
            }
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Selection of catalog from catalog list", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Selection of catalog from catalog list not successful " + e.getMessage());
        }
    }

    @Then("^widget for Bundle Manager should be displayed on the Dashboard$")
    public void widget_for_Bundle_Manager_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getWidget_BundleManager().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Manager widget not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^definition for Bundle Manager should be displayed on the Dashboard$")
    public void definition_for_Bundle_Manager_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getBundleManagerDefinition().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Manager definition not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^description for Bundle Manager should be displayed on the Dashboard$")
    public void description_for_Bundle_Manager_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getBundleManagerDescription().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Manager description not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^recent label for Bundle Manager should be displayed on the Dashboard$")
    public void recent_label_for_Bundle_Manager_should_be_displayed_on_the_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getBundleManagerRecentLabel().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Manager description not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^quicklink label for Bundle Manager should be displayed on Dashboard$")
    public void quicklink_label_for_Bundle_Manager_should_be_displayed_on_Dashboard() {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getBundleManagerQuickLinksLabel().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Manager description not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on upload new bundle link in Bundle Manager widget$")
    public void user_clicks_on_upload_new_bundle_link_in_Bundle_Manager_widget() throws Throwable {
        try {
            new DashBoardPage(driver).click_bundleManagerUploadQuickLink();
        } catch (Exception e) {
            takeScreenShot("upload new bundle link not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @Then("^user clicks on recent bundle first link$")
    public void user_clicks_on_recent_bundle_first_link() throws Throwable {
        try {

            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).get_bundleManagerRecentFirstLink());

        } catch (Exception e) {
            takeScreenShot("recent bundle first link not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user enters \"([^\"]*)\" in the name field in the New Dashboard panel$")
    public void userEntersInTheNameFieldInTheNewDashboardPanel(String dashBoardName) {
        try {
            //fluentWait(driver, 3000, 3);
            new DashBoardPage(driver).enter_NewDashboardName(dashBoardName);
        } catch (Exception e) {
            takeScreenShot("Not able to enter Slash", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not able to enter Slash" + e.getMessage());

        }
    }

    @And("^user should be able to choose the \"([^\"]*)\" and save it$")
    public void userShouldBeAbleToChooseTheAndSaveIt(String quickLinkName) {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnQuickLink(quickLinkName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link" + quickLinkName + "has been choosen");
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnWidgetSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link has been assigned to Widget");
        } catch (Exception e) {
            takeScreenShot("quick link assignment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link could not be assigned to the widget" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link could not be assigned to the widget");
        }

    }

    @Then("^user should be able to see the quick link \"([^\"]*)\" in Quick link Widget$")
    public void userShouldBeAbleToSeeTheQuickLinkInQuickLinkWidget(String linkName) throws Throwable {
        try {
            isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName));
            LoggerUtil.logLoader_info(this.getClass().getName(), "Quick link " + linkName + "is visbble in Widget");
        } catch (Exception e) {
            takeScreenShot("quick link not available", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link is not visible in widget" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link could not be assigned to the widget");
        }
    }

    @And("^user edits \"([^\"]*)\" catalog widget and choose \"([^\"]*)\"$")
    public void userEditsCatalogWidgetAndChoose(String widgetName, String quickLinkName) {
        try {
            clickOn(new DashBoardPage(driver).getHomeButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Home Button is clicked");
            sleepForSec(2000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnWidgetEditButton(widgetName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget " + widgetName + "has been edited");
            actionClick(driver, new DashBoardPage(driver).returnquicklinkFirstDropdown());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget " + widgetName + "Dropdown is clicked");
            clickOn(new DashBoardPage(driver).returnQuickLink(quickLinkName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link " + quickLinkName + "has been assigned to Wisget " + widgetName + "");
            clickOn(new DashBoardPage(driver).returnWidgetSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Save button from Widget has been clicked");
        } catch (Exception e) {
            takeScreenShot("quick link is not assigned", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link is not asigned" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link could not be assigned to the widget");
        }
    }

    @And("^User enters the search name \"([^\"]*)\", Description \"([^\"]*)\" and choose the widget \"([^\"]*)\" and click save$")
    public void userEntersTheSearchNameDescriptionAndChooseTheWidgetAndClickSave(String linkName, String linkDesc, String widgetName) {
        try {
            enterText(new SubjectArea(driver).returnsearchName(), linkName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "serach name " + linkName + "entered successfully");
            sleepForSec(1000);
            enterText(new SubjectArea(driver).returnsearchDescription(), linkDesc);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "search description " + linkDesc + "has been enetred");
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunWidgetSelectionBox(widgetName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget has been");
            waitForPageLoads(driver, 3);
            clickOn(new SubjectArea(driver).getQuickLinkSave());
            sleepForSec(2000);
        } catch (Exception e) {
            takeScreenShot("quick link can't be created", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("quick link can't be created" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "quick link can't be created");
        }
    }

    @And("^user moves the cursor too link \"([^\"]*)\"$")
    public void userMovesTheCursorTooLink(String linkName) {
        try {
            moveToElement(driver, new DashBoardPage(driver).returnLinkElement(linkName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link is captured");
        } catch (Exception e) {
            takeScreenShot("Quick link is not found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("quick link is not found" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "quick link is not found");
        }
    }

    @Then("^Description \"([^\"]*)\" should be showing as tooltip for link \"([^\"]*)\"$")
    public void descriptionShouldBeShowingAsTooltipForLink(String linkDesc, String linkName) {
        try {
            verifyEquals(linkDesc,
                    new DashBoardPage(driver).returnLinkElement(linkName).getAttribute("title"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tool tip is showing as expected");
        } catch (Exception e) {
            takeScreenShot("tooltip is not matching", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("tool tip is not matching" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "tool tip is not macthing");
        }
    }

    @Then("^Dashboard \"([^\"]*)\" should be active$")
    public void dashboardShouldBeActive(String dashboardName) {
        try {
            isElementPresent(new SubjectArea(driver).retrunAcceptWarning());
            waitForPageLoads(driver, 10);
            clickOn(new SubjectArea(driver).retrunAcceptWarning());
            verifyEquals(dashboardName, new DashBoardPage(driver).returndashboardActiveTab().getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "current Active tab is " + dashboardName);
        } catch (Exception e) {
            takeScreenShot("Dashboard is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Dashboard is not deleted" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dashboard is not deleted");
        }
    }

    @Then("^Dashboard \"([^\"]*)\" should be active TAB$")
    public void dashboardShouldBeActiveTAB(String dashboardName) {
        try {
            sleepForSec(1000);
            verifyEquals(dashboardName, new DashBoardPage(driver).returndashboardActiveTab().getText().trim());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "current Active tab is " + dashboardName);
        } catch (Exception e) {
            takeScreenShot("Dashboard is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Dashboard is not deleted" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dashboard is not deleted");
        }
    }

    @And("^user validates the cluster name\"([^\"]*)\" from IDC UI$")
    public void userValidatesTheClusterNameFromIDCUI(String arg0) throws Throwable {
        try {
            List<WebElement> resultsTable = new DashBoardPage(driver).getResultsTable();
            for (WebElement webElement : resultsTable) {
                String tdValue = webElement.getText();
                if (tdValue.equals(arg0)) {
                    Assert.assertEquals(arg0, tdValue);
                    clickOn(webElement);
                    break;
                }
            }
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Unable to click on " + arg0 + " the cluster", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user validates the existence of \"([^\"]*)\" under \"([^\"]*)\" table$")
    public void userValidatesTheExistenceOfUnderTable(String searchContext, String searchInTheTable) throws Throwable {
        try {
            scrollToWebElement(driver, new DashBoardPage(driver).getWebTableWithDynamicValue(searchInTheTable));

            if (searchContext.contains("Query")) {
                searchContext = CommonUtil.getElementsInList().get(0);
            }
            for (int i = 1; i <= new DashBoardPage(driver).getWebTableSize(searchInTheTable).size(); i++) {
                String expectedSearchText = new DashBoardPage(driver).getDynamicSearchValue(searchInTheTable, String.valueOf(i), "1").getText();
                //*************** after the issue is communicated and fixed, below contains should be replaced with equal ignore case
                if (expectedSearchText.contains(searchContext)) {
                    Assert.assertTrue(true);
                    clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getDynamicSearchValue(searchInTheTable, String.valueOf(i), "2"));
                    break;
                }
            }

        } catch (Exception e) {
            takeScreenShot("Unable to click on " + searchContext + " under " + searchInTheTable, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user validates the List of \"([^\"]*)\" under \"([^\"]*)\"$")
    public void userValidatesTheListOfUnder(String validationList, String searchInTheTable) throws Throwable {
        List<String> expectedColumns = new ArrayList<>();
        try {
            scrollToWebElement(driver, new DashBoardPage(driver).getWebTableWithDynamicValue(searchInTheTable));
            for (int i = 1; i <= new DashBoardPage(driver).getWebTableSize(searchInTheTable).size(); i++) {
                expectedColumns.add(new DashBoardPage(driver).getDynamicSearchValue(searchInTheTable, String.valueOf(i), "1").getText());
            }
            Assert.assertTrue(CommonUtil.compareLists(Constant.hiveMetaStoreData(validationList), expectedColumns));
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Validation list " + expectedColumns + " did not match the list under" + searchInTheTable + " source", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user validates the \"([^\"]*)\" from postgres to IDC UI under \"([^\"]*)\" table$")
    public void userValidatesTheFromPostgresToIDCUIUnderTable(String arg0, String searchInTheTable) throws Throwable {
        List<String> expectedExecutionTime = new ArrayList<>();
        try {
            scrollToWebElement(driver, new DashBoardPage(driver).getWebTableWithDynamicValue(searchInTheTable));
            for (int i = 1; i <= new DashBoardPage(driver).getWebTableSize(searchInTheTable).size(); i++) {
                expectedExecutionTime.add(new DashBoardPage(driver).getDynamicSearchValue(searchInTheTable, String.valueOf(i), "1").getText());
            }
            Assert.assertTrue(CommonUtil.compareLists(expectedExecutionTime, CommonUtil.tempElementList));
            takeScreenShot(this.getClass().getSimpleName(), driver);
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            takeScreenShot("Execution List " + expectedExecutionTime + " Did not Match", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user validates \"([^\"]*)\" for the \"([^\"]*)\" source$")
    public void userValidatesForTheSource(String searchInTheTable, String source) throws Throwable {
        List<String> expectedSource = new ArrayList<>();
        try {
            scrollToWebElement(driver, new DashBoardPage(driver).getItemFullViewTable(searchInTheTable));
            for (int i = 1; i <= new DashBoardPage(driver).getItemFullViewTableSize(searchInTheTable).size(); i++) {
                expectedSource.add(new DashBoardPage(driver).getItemFullViewSearchValue(searchInTheTable, String.valueOf(i), "1").getText());
            }
            Assert.assertTrue(CommonUtil.compareLists(expectedSource, Constant.hiveMetaStoreData(source)));
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Unable to validate the" + Constant.hiveMetaStoreData(source) + " source", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user validates the Query\"([^\"]*)\" under metadata$")
    public void userValidatesTheQueryUnderMetadata(String QueryNo) throws Throwable {
        try {
            String actualQuery = new DashBoardPage(driver).getFileDataContent().getText();
            String expectedQuery = new JsonRead().readJSon("QueryParser", "QueryLog_Q" + QueryNo);
            Assert.assertEquals(actualQuery, expectedQuery);
            CommonUtil.tempElementList.clear();
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Unable to match the Query under Metadata", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on the \"(.*)\" widget$")
    public void user_clicks_on_the_widget(String widgetName) throws Throwable {
        try {
            if (new DashBoardPage(driver).getQuickstartPageWidget().size() == 0) {
                refresh(driver);
                sleepForSec(2000);
            }
            if (widgetName.equalsIgnoreCase("Testing'")) {
                widgetName = widgetName.replace("'", "");
            }
            sleepForSec(5000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).clickDashBoardWidget(widgetName.toUpperCase()));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widgetName + " widget link is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enable first item checkbox from item search results$")
    public void user_enable_first_item_checkbox_from_item_search_results() throws Throwable {
        try {
            new QuickStartActions(driver).clickFirstItemCheckbox();
            LoggerUtil.logLoader_info(this.getClass().getName(), "First item checkbox is not enabled");
        } catch (Exception e) {
            takeScreenShot("Item checkbox is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Item checkbox is not clickable" + e.getMessage());
        }
    }

    @And("^user selects the \"([^\"]*)\" from the Catalog$")
    public void user_selects_the_catalog_in_dashboard_page(String type) throws Throwable {
        try {
            if (new DashBoardPage(driver).getShowAllButtonForCatalogInDashboardPage()) {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getShowAllButtonForCatalog());
                sleepForSec(2000);
                String actualText = CommonUtil.getTextWithoutWhiteSpace(type);
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).clickType(actualText));
            } else {
                sleepForSec(500);
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).clickType(type));
            }
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), type + " checkbox is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks the recent link from the result$")
    public void user_clicks_the_recent_link_from_the_result_in_dashboard_page() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).get_CatalogRecentLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Recent link from the list is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies the following in the QuickStart dashboard$")
    public void user_verifies_the_values_in_QuickStart_Dashboard(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                if (values.get("action").equalsIgnoreCase("verify")) {
                    Assert.assertTrue(isElementPresent(new DashBoardPage(driver).getAnalysisRunResult(values.get("widget").toUpperCase(), values.get("plugin"))));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Run result displayed under the widget");
                } else if (values.get("action").equalsIgnoreCase("click")) {
                    clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getAnalysisRunResult(values.get("widget").toUpperCase(), values.get("plugin")));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Run result is clicked");
                    sleepForSec(1500);
                }
            }
            sleepForSec(500);
            takeScreenShot("Rrun result is  displayed under the widget", driver);
        } catch (Exception e) {
            takeScreenShot("Error is displaying in run result", driver);
            Assert.fail("Error is displaying in run result");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @And("^user edits \"([^\"]*)\" catalog widget and click on delete icon from \"([^\"]*)\" link item$")
    public void userEditsCatalogWidgetAndClickOnDeleteIconFromLinkItem(String widgetName, String linkName) {
        try {
            sleepForSec(5000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnWidgetEditButton(widgetName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget " + widgetName + "has been edited");
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnDeleteButtonForQuicklink(linkName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete button of link " + linkName + "has been clicked");
        } catch (Exception e) {
            takeScreenShot("Quicklink delete button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Dashboard is not deleted" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink delete button is not clicked");
        }
    }

    @Then("^Quick link should be deleted from Widget and empty link should be showing$")
    public void quickLinkShouldBeDeletedFromWidgetAndEmptyLinkShouldBeShowing() {
        try {
            Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnblankLink()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link is removed from Widget");
        } catch (Exception e) {
            takeScreenShot("Quicklink is not removed from Widget", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink is not removed from Widge" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not removed from Widge");

        }
    }

    @And("^user clicks on \"([^\"]*)\" button in profile settings panel$")
    public void userClicksOnDiscardButtonOnProfileSettingsPanel(String button) {
        try {
            clickOn(new DashBoardPage(driver).getProfileSettingsButton(button));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Discard button is clicked");
            sleepForSec(3000);
        } catch (Exception e) {
            takeScreenShot("Discard button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Discard button is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Discard button is not clicked");
        }
    }

    @Then("^Quick link should be deleted from Widget \"([^\"]*)\" and empty link should be showing$")
    public void quickLinkShouldBeDeletedFromWidgetAndEmptyLinkShouldBeShowing(String widgetName) {
        try {
            Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnQuicklinkbutton(widgetName)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link is removed from Widget");
            takeScreenShot("Link is removed from Widget", driver);
        } catch (Exception e) {
            takeScreenShot("Quicklink is not removed from Widget: " + widgetName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink is not removed from Widget" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not removed from Widget : " + widgetName);
        }
    }

    @And("^Quick link \"([^\"]*)\"should be present in Widget \"([^\"]*)\"$")
    public void quickLinkShouldBePresentInWidget(String linkName, String widgetName) {
        try {
            Assert.assertEquals(linkName, new DashBoardPage(driver).returnquicklinkfromwidget(linkName, widgetName).getText().trim());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link is present in another widget");
            takeScreenShot("Link is present in another widget", driver);
        } catch (Exception e) {
            takeScreenShot("Quicklink is not found in another widget: " + widgetName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink is not found in another widget:" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found in another widget: " + widgetName);
        }
    }

    @When("^user clicks on \"([^\"]*)\" dashboard$")
    public void user_clicks_on_dashboard(String dashboardName) throws Throwable {
        try {
            sleepForSec(1000);
            clickOn(new DashBoardPage(driver).returnDashboardLink(dashboardName));
            sleepForSec(3000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard " + dashboardName + " is clicked");


        } catch (Exception e) {
            takeScreenShot("Dashboard " + dashboardName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Dashboard " + dashboardName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dashboard " + dashboardName + " is not clicked");
        }
    }

    @Then("^user removes \"([^\"]*)\" widget from dashboard$")
    public void user_removes_widget_from_dashboard(String widgetName) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnVerticalWidgetButton(widgetName));
                clickOn(new DashBoardPage(driver).get_removeButton_dashboard());
            } else {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnVerticalWidgetButton(widgetName));
                new DashBoardPage(driver).click_removeButton_dashboard();
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget " + widgetName + " is removed");
            takeScreenShot("Widget" + widgetName + " is removed", driver);

        } catch (Exception e) {
            takeScreenShot("Widget" + widgetName + " is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Widget" + widgetName + " is not removed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Widget " + widgetName + " is not removed");
        }
    }

    @And("^\"([^\"]*)\" notification should have content \"([^\"]*)\" in the notifications tab$")
    public void notificationShouldHaveContentInTheNotificationsTab(String headerName, String headerContent) throws Throwable {
        try {
            waitandFindElement(driver, new DashBoardPage(driver).getnewNotificationsList().get(0), 5, false);
            Assert.assertTrue(new DashBoardPage(driver).returnNotificationContent(headerName, headerContent).isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " notification displayed");
            takeScreenShot(" notification displayed", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot(" notification not displayed", driver);
        }
    }

    @And("^user validate whether the child tag is listed under root tag in Tag facet$")
    public void user_verifies_whether_the_child_tag_is_presentunder_the_roottag(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                Assert.assertTrue((new DashBoardPage(driver).getRootAndChildTagText(values.get("childTag"), values.get("parentTag")).isDisplayed()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("parentTag") + " contains the child tag" + values.get("childTag"));
            }
        } catch (Exception e) {
            takeScreenShot("Child tag is not present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Child tag is not present" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" \"([^\"]*)\" link under deatils label under open notification panel$")
    public void userVerifiesDatasetNameIsShownAsLinkUnderDeatilsLabel(String action, String arg0) throws Throwable {
        try {
            if (action.equalsIgnoreCase("verifies")) {
                Assert.assertTrue(new DashBoardPage(driver).getLinkInNotificationPanel(arg0).isDisplayed());
            } else if (action.equalsIgnoreCase("click")) {
                new DashBoardPage(driver).clickLinkFromOpenNotificationPanel(arg0);
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg0 + " is displayed as a link under details label");
        } catch (Exception e) {
            takeScreenShot(arg0 + " is not displayed as a link under details label", driver);
            Assert.fail("Issue in identifying the link");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), arg0 + " is not displayed as a link under details label");
        }
    }

    @And("^user clicks on full size icon in the item full view$")
    public void user_clicks_on_full_size_icon_in_the_item_full_view() {
        try {
            sleepForSec(3000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                clickOn(new DashBoardPage(driver).getFullSizeIcon_Edge());
            } else {
                clickOn(new DashBoardPage(driver).getFullSizeIcon());
            }
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked full size icon");
        } catch (Exception e) {
            takeScreenShot("Can't able to Click full size icon ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies the full screen view$")
    public void user_verifies_the_full_screen_view() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).getCompressIconButton()));
            } else {
                Assert.assertTrue(new DashBoardPage(driver).getCompressIconButton().isDisplayed());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget is displayed in full screen view");
        } catch (Exception e) {
            takeScreenShot("Full screen view is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Full screen view is not displayed" + e.getMessage());
        }
    }

    @And("^user clicks on compress icon in the item full view$")
    public void user_clicks_on_compress_icon_in_the_item_full_view() {
        try {
            sleepForSec(3000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getCompressIconButton());
            } else {
                clickOn(new DashBoardPage(driver).getCompressIconButton());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked compress icon button");
        } catch (Exception e) {
            takeScreenShot("Can't able to Click compress icon ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Can't able to Click compress icon " + e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" tab is displayed and active in the item full view$")
    public void user_verifies_the_tab_is_diaplyed_and_active(String tab) {
        try {
            String actualText = getAttributeValue(new DashBoardPage(driver).getTabDisplayedAndActive(tab), "class");
            new DashboardActions(driver).verifyTrue(actualText.equalsIgnoreCase("active"));

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tab + " is Displayed and active");
        } catch (Exception e) {
            takeScreenShot(tab + " is not Displayed and active", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(tab + " is not Displayed and active" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" key$")
    public void user_clicks_on_key(String keyValue) {
        try {
            if (keyValue.equalsIgnoreCase("Escape"))
                keyPressEvent(driver, Keys.ESCAPE);
            else if (keyValue.equalsIgnoreCase("Enter"))
                keyPressEvent(driver, Keys.ENTER);
            else keyPressEvent(driver, Keys.TAB);
        } catch (Exception e) {
            takeScreenShot("Escape is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Escape is not clicked" + e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" label and its property container$")
    public void user_verifies_label_and_its_property_container(String tab) {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getItemLabelsWithContainer(tab).isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tab + " Label is displayed above its property container");
        } catch (Exception e) {
            takeScreenShot(tab + " Label is not displayed above its property container", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies the text \"([^\"]*)\" inside the Tag section$")
    public void user_verifies_the_text_inside_the_Tag_section(String tagText) {
        try {
            String actualText = getElementText(new DashBoardPage(driver).getTextInTagSection());
            Assert.assertEquals(tagText, actualText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tagText + " text is displayed under the tag section");
        } catch (Exception e) {
            takeScreenShot(tagText + " text is not displayed under the tag section", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user mouseover to \"([^\"]*)\" tab and verifies the underlined color$")
    public void user_mouseover_to_any_tab_and_verifies_the_underlined_color(String tab) throws Throwable {
        try {
            //waitandFindElement(driver, new DashBoardPage(driver).getItemFullViewTab(tab), 3, false);

            moveToElementUsingJavaScript(driver, new DashBoardPage(driver).getItemFullViewTab(tab));
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                Assert.assertEquals(new DashBoardPage(driver).getItemFullViewTab(tab).getCssValue("border-bottom-color"), "rgba(166, 166, 166, 1)");
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox") || propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                Assert.assertEquals(new DashBoardPage(driver).getItemFullViewTab(tab).getCssValue("border-bottom-color"), "rgb(166, 166, 166)");
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Background color is grey");
            takeScreenShot("MLP_1643_Verification of facet box background color", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1643_Verification of facet box background color", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies the tab height as \"([^\"]*)\"px$")
    public void user_verifies_the_tab_height(String height) {
        try {
            sleepForSec(1000);
            if (new DashBoardPage(driver).getTabHeightInItemFullView().isDisplayed()) {
                int actualHeight = new DashBoardPage(driver).getTabHeight();
                String actualTabHeight = String.valueOf(actualHeight);

                Assert.assertEquals(height, actualTabHeight);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The tab height is " + actualTabHeight);
            } else {
                int actualHeight = new DashBoardPage(driver).getTabHeight();
                String actualTabHeight = String.valueOf(actualHeight);
                Assert.assertEquals(height, actualTabHeight);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The tab height is " + actualTabHeight);

            }
        } catch (Exception e) {
            takeScreenShot("Error in fetching tab height", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }

    }

    @And("^user verifies whether the global search count and solr search count are same$")
    public void solr_search_count_should_me_matched_for_global_search_count() throws Throwable {
        try {
            String solrCount = commonUtil.getNUMfromString(new SubjectArea(driver).getItemCount().getText());
            int globalCount = Integer.parseInt(getTemporaryText().trim());
            verifyEquals(globalCount, Integer.parseInt(solrCount));
            LoggerUtil.logLoader_info(solrCount, "Number of Items found In Slor");
        } catch (Exception e) {
            takeScreenShot("Search Result is not matching ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Result does not contain exact name match  " + e.getMessage());
        }

    }

    @And("^user verifies Delete button is not present$")
    public void user_verifies_delete_button_is_not_present() {
        try {
            Assert.assertFalse(isElementPresent(new DashBoardPage(driver).getWidgetDeleteButton()));
            takeScreenShot("Widget Delete button is not present", driver);
        } catch (Exception e) {
            takeScreenShot("Widget Delete button is present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies whether the \"([^\"]*)\" widget is displayed in the current tab$")
    public void user_verifies_whether_widget_is_present(String widget) {
        try {
            sleepForSec(1000);
            widget = widget.toUpperCase();
            Assert.assertTrue(new DashBoardPage(driver).getWidgetName(widget).size() > 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widget + "  is displayed in the current tab");
            takeScreenShot(widget + "  is displayed in the current tab", driver);
        } catch (Exception e) {
            takeScreenShot(widget + "  is not displayed in the current tab", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies whether the \"([^\"]*)\" widget is not displayed in the QuickStart Dashboard$")
    public void user_verifies_whether_widget_is_not_present_in_the_quickstart_dashboard(String widget) {
        try {
            widget = widget.toUpperCase();
            verifyTrue(new DashBoardPage(driver).getWidgetName(widget).size() == 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widget + "  is not displayed in the QuickStart Dashboard");
        } catch (NoSuchElementException el) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), el.getMessage());
        } catch (Exception e) {
            takeScreenShot(widget + "  is displayed in the QuickStart Dashboard", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" tab displayed$")
    public void user_clicks_on_tab(String tab) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickOn(new DashBoardPage(driver).getItemFullViewTab(tab));
            } else {
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getItemFullViewTab(tab));
            }
            sleepForSec(4000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tab + " tab is clicked");
        } catch (Exception e) {
            takeScreenShot(tab + " tab is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Information icon should be displayed in the header$")
    public void information_icon_should_be_displayed_in_the_header() throws Throwable {
        try {
            new DashBoardPage(driver).click_InformationIcon().isDisplayed();
        } catch (Exception e) {
            takeScreenShot("Information Icon is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @Given("^User clicks on the information icon in the header$")
    public void user_clicks_on_the_information_icon_in_the_header() throws Throwable {
        try {
            new DashBoardPage(driver).click_InformationIcon().click();

        } catch (Exception e) {
            takeScreenShot("Information Icon is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^list of submenus should match with below values$")
    public void list_of_submenus_should_match_with_below_values(List<CucumberDataSet> subMenuList) throws Throwable {

        try {

            sleepForSec(5000);
            List<String> actualMenuList = new ArrayList<String>();
            List<String> expectedMenuList = new ArrayList<>();
            for (CucumberDataSet subMenu : subMenuList) {
                expectedMenuList.add(subMenu.getSubMenuList());
            }

            for (WebElement submenu : new DashBoardPage(driver).getSubmenus()
                    ) {
                actualMenuList.add(submenu.getText().trim());
            }
            Assert.assertTrue(CommonUtil.compareLists(expectedMenuList, actualMenuList));

        } catch (Exception e) {
            takeScreenShot("Submenus are not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Version number should be displayed in the pop up$")
    public void version_number_should_be_displayed_in_the_pop_up() throws Throwable {
        try {
            new DashBoardPage(driver).getversion_Label().isDisplayed();
            new DashBoardPage(driver).getversionNumber().isDisplayed();
        } catch (Exception e) {
            takeScreenShot("Version details are not displayed in the pop up", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^Build information should be displayed in the pop up$")
    public void build_information_should_be_displayed_in_the_pop_up() throws Throwable {
        try {
            new DashBoardPage(driver).getbuildLabel().isDisplayed();
            new DashBoardPage(driver).getbuildNumber().isDisplayed();
        } catch (Exception e) {
            takeScreenShot("Build details are not displayed in the pop up", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on \"([^\"]*)\" submenu$")
    public void user_clicks_on_submenu(String menuName) throws Throwable {
        try {
            switch(menuName) {
                case "About":
                clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).click_AboutmenuButtons(menuName));
                sleepForSec(3000);
                break;
                case "Documentation":
                    clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).click_SubmenuButtons(menuName));
                    sleepForSec(3000);
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("Documentation submenu is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @When("^User clicks on Privacy Policy link$")
    public void user_clicks_on_Privacy_Policy_link() throws Throwable {
        try {
            new DashBoardPage(driver).click_privacyplicy();
        } catch (Exception e) {
            takeScreenShot("Privacy Policy link is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^User should traverse to Privacy policy information page in another window$")
    public void user_should_traverse_to_Privacy_Policy_information_page_in_another_window() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("firefox") || (browserName.equalsIgnoreCase("edge"))) {
                sleepForSec(4000);
                switchToChildWindow(driver);
                String Actual_WindowName = driver.getTitle();
                verifyTrue(verifyEquals("Privacy Policy", Actual_WindowName));
            } else {
                switchToChildWindow(driver);
                String Actual_WindowName = driver.getTitle();
                verifyTrue(verifyEquals("Privacy Policy", Actual_WindowName));
            }
        } catch (Exception e) {
            takeScreenShot("Privacy Policy information page is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on Open Source Documents link$")
    public void user_clicks_on_Open_Source_Documents_link() throws Throwable {
        try {
            new DashBoardPage(driver).click_OpenSourceDocument();
        } catch (Exception e) {
            takeScreenShot("Open Source Documents link is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^User should traverse to Open Source Documents page in another window$")
    public void user_should_traverse_to_Open_Source_Documents_page_in_another_window() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("firefox") || (browserName.equalsIgnoreCase("edge"))) {
                sleepForSec(4000);
                switchToChildWindow(driver);
                String Actual_WindowName = driver.getTitle();
                verifyTrue(verifyEquals("Open Source Components", Actual_WindowName));
            } else {
                switchToChildWindow(driver);
                String Actual_WindowName = driver.getTitle();
                verifyTrue(verifyEquals("Open Source Components", Actual_WindowName));
            }
        } catch (Exception e) {
            takeScreenShot("Open Source Documents page is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^copyrights should be displayed in the popup$")
    public void copyrights_should_be_displayed_in_the_popup(DataTable table) throws Throwable {
        try {

            List<CucumberDataSet> yearValue = table.asList(CucumberDataSet.class);
            String copyrightText = new DashBoardPage(driver).getcopyrights().getText().replaceAll("©", "\u00a9");
            verifyTrue(verifyEquals("Copyright © " + yearValue.get(0).getYear() + " ASG Technologies. All rights reserved.", copyrightText));

        } catch (Exception e) {
            takeScreenShot("Copyright is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^User clicks on the Close button and pop up should be closed$")
    public void user_clicks_on_the_Close_button_and_pop_up_should_be_closed() throws Throwable {
        try {
            new DashBoardPage(driver).click_AboutClose();
        } catch (Exception e) {
            takeScreenShot("Open Source Documents page is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^User clicks on the Close button in the Alert box if present$")
    public void user_clicks_on_the_Close_button_in_alert_box() throws Throwable {
        try {
            if (isElementPresent(new DashBoardPage(driver).getAlertCloseButton())) {
                new DashBoardPage(driver).click_AlertCloseButton();
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Alert is not present");
            }

        } catch (Exception e) {
            takeScreenShot("Open Source Documents page is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user verifies \"([^\"]*)\" button is Dispalyed$")
    public void user_verifies_profile_settings_button(String button) throws Throwable {
        try {
            Assert.assertTrue(new DashBoardPage(driver).getProfileSettingsButton(button).isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), button + " is displayed");

        } catch (Exception e) {
            takeScreenShot(button + " is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(button + "is not displayed" + e.getMessage());
        }
    }

    @And("^user verifies auto suggest list should be displayed with no preselection value$")
    public void user_verifies_auto_suggest_list_should_be_displayed() {
        try {
            int size = new DashBoardPage(driver).getSearchDropDownList().size();
            Assert.assertTrue(new DashBoardPage(driver).getSearchDropDownList().size() > 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Auto suggest list is displayed");
            takeScreenShot("Auto suggest list is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Auto suggest list is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies the following actions in DashboardPage$")
    public void user_verifies_the_actions_in_Dashboard_search_page(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                if (values.get("action").equalsIgnoreCase("verify")) {
                    Assert.assertTrue(isElementPresent(new DashBoardPage(driver).getShowAllButton(values.get("button"))));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("button") + " is displayed");
                } else if (values.get("action").equalsIgnoreCase("click")) {
                    clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getShowAllButton(values.get("button")));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("button") + " is clicked");
                }
            }
            sleepForSec(500);
            takeScreenShot("Show All Button in facet is as per the visual design.", driver);
        } catch (Exception e) {
            takeScreenShot("Error is displaying in Button", driver);
            Assert.fail("Error is displaying in Button");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @And("^user verifies \"([^\"]*)\" pane is disaplayed$")
    public void user_verifies_total_panel_displayed(String count) throws Throwable {
        try {
            int paneCount = new DashBoardPage(driver).getTotalPanelDisplayed().size();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Total number of panels found in search Result page");

            Assert.assertTrue(Integer.toString(paneCount).equals(count));
        } catch (Exception e) {
            takeScreenShot("Total number of panel differs from expected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Total number of panel differs from expected" + e.getMessage());
            LoggerUtil.logLoader_error("Total number of panel differs from expected", e.getMessage());

        }
    }

    @And("^user verifies search result should be reduced to the middle panel$")
    public void user_verifies_search_result_should_be_reduced_to_middle_pane() throws Throwable {
        try {
            String searchPane = getElementText(new DashBoardPage(driver).getTotalPanelDisplayed().get(1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search result should be reduced to the middle panel");

            Assert.assertTrue(searchPane.contains("items were found"));
        } catch (Exception e) {
            takeScreenShot("Search result is not displayed in the middle panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search result is not displayed in the middle panel" + e.getMessage());
            LoggerUtil.logLoader_error("Search result is not displayed in the middle panel", e.getMessage());

        }
    }

    @When("^user verifies plus button for adding a new widget is not displayed$")
    public void user_verifies_plus_button_for_adding_new_widget_not_displayed() throws Throwable {
        try {
            Assert.assertFalse(new DashBoardPage(driver).getplusButtonStatus());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "plus button is clicked for addind a new dashboard page");
        } catch (Exception e) {
            takeScreenShot("Plus button is not clicked for addind a new dashboard page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user uses robotclass with the following options$")
    public void userUsesRobotclassWithTheFollowingOptions(DataTable data) throws Throwable {
        try {
            robotUtil.robotClassOperation(data);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Robot class action is performed");

        } catch (Exception e) {
            takeScreenShot("Robot class action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" tab not displayed in item full view$")
    public void userVerifiesTabNotDisplayedInItemFullView(String tabName) throws Throwable {
        try {
            Assert.assertFalse(traverseListContainsElementText(new DashBoardPage(driver).getItemFullViewTabs(), tabName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tab" + tabName + "is not displayed");
        } catch (Exception e) {
            takeScreenShot("Tab" + tabName + "is displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Tab" + tabName + "is displayed" + e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" Tab is highlighted$")
    public void userVerifiesTabIsHighlighted(String tab) throws Throwable {

        try {
            moveToElementUsingJavaScript(driver, new DashBoardPage(driver).getItemFullViewTab(tab));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Background" + new DashBoardPage(driver).getItemTabs(tab).getCssValue("border-bottom-style"));
            Assert.assertEquals(new DashBoardPage(driver).getItemTabs(tab).getCssValue("border-bottom-style"), "solid");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Background color is grey");
            takeScreenShot("MLP_1643_Verification of facet box background color", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1643_Verification of facet box background color", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @And("^two cross button should not be displayed in the Search area$")
    public void twoCrossButtonShouldNotBeDisplayedInTheSearchArea() throws Throwable {
        try {
            verifyTrue(new DashBoardPage(driver).getSearchIcon().size() == 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Cross button is displayed in serach area");
            takeScreenShot("Cross button is displayed in serach area", driver);
        } catch (Exception e) {
            takeScreenShot("Cross button is not displayed in serachh area", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies whether \"([^\"]*)\" is present under \"([^\"]*)\" container$")
    public void userVerifiesTheTypeOfthePluginUnderTheContainer(String type, String container) {
        try {
            if (type.isEmpty()) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Container is not present");
            } else {
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).getTypeUnderContainer(container, type)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is present under the " + container + " container");
            }
        } catch (Exception e) {
            takeScreenShot("Item is not present under the " + container + " container", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Item is not present under the " + container + " container" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is not present under the " + container + " container");

        }
    }

    @Given("^user enters the Analysis job name in Search text box and click Search$")
    public void user_enters_the_Analysis_job_name_in_Search_text_box_and_click_Search() throws Throwable {
        try {
            String actualText = CommonUtil.getText().replaceAll(":", "%3A");
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(1500);
                enterText(new DashBoardPage(driver).returntopSearchBox(), actualText);
                sleepForSec(1500);
                clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            } else {
                enterText(new DashBoardPage(driver).returntopSearchBox(), actualText);
                sleepForSec(1000);
                clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on minimize icon in the item full view$")
    public void user_clicks_on_minimize_icon_in_the_item_full_view() {
        try {
            sleepForSec(3000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge") || propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                new DashBoardPage(driver).clickMinimizeIcon();
            } else {
                new DashBoardPage(driver).clickMinimizeIcon_Firefox();
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked minimize icon button");
        } catch (Exception e) {
            takeScreenShot("Can't able to Click minimize icon ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Can't able to Click minimize icon " + e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" dashboard$")
    public void user_clicks_dashboard(String actionType, String dashboardName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, dashboardName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard " + dashboardName + " is clicked");
        } catch (Exception e) {
            takeScreenShot("Dashboard " + dashboardName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Dashboard " + dashboardName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dashboard " + dashboardName + " is not clicked");
        }
    }

    @When("^User \"([^\"]*)\" on \"([^\"]*)\" link on the Dashboard page$")
    public void user_click_on_widget_link_on_the_Dashboard_page(String actionType, String widgetName) {
        try {
            sleepForSec(1000);
            new DashboardActions(driver).genericActions(actionType, widgetName);
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }



    @When("^user clicks on notification icon and open first open area link in notifications panel$")
    public void user_clicks_notification_icon_and_open_first_link_in_notifications_panel() {
        try {
            sleepForSec(2000);
            new DashboardActions(driver).userOpensFirstNotificationFromTheList();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel icon is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel icon is not clicked");
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user search \"([^\"]*)\" items at top end$")
    public void user_search_items_at_top_end(String catalogName) throws Throwable {
        try {
            new DashboardActions(driver).selectCatalogAndClickSearch(catalogName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "");
            Assert.fail(e.getMessage());
        }
    }


    @When("^user verifies the Search text box placeholder$")
    public void user_verifies_the_search_text_box_placeholder(){
        try {
            sleepForSec(2000);
            new DashboardActions(driver).genericVerifyElementPresent("Search");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Placeholder text verified");
        }
        catch (Exception e){
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"placeholder text not found");
            Assert.fail(e.getMessage());
        }

    }

    @When("^user \"([^\"]*)\" on open statistic link for \"([^\"]*)\" in notifications panel")
    public void user_clicks_notification_panel(String actionType, String notificationHeader) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, notificationHeader);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard " + notificationHeader + " open statistic link is clicked");
        } catch (Exception e) {
            takeScreenShot("Dashboard " + notificationHeader + " open statistic link is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Dashboard " + notificationHeader + " open statistic link is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dashboard " + notificationHeader + " open statistic link is not clicked");
        }
    }

    @Given("^user verfies whether \"([^\"]*)\" notification panel contains the expected text for the \"([^\"]*)\" section for the \"([^\"]*)\"$")
    public void user_verifies_expectedText_in_MetaData(String panelName, String section, String notificationTitle, DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new DashboardActions(driver).verifyNotificationPropertiesContains(panelName, notificationTitle, section, values.get("notificationPropertyName"), values.get("notificationPropertyValue"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel contains the expected Values");
        } catch (Exception e) {
            takeScreenShot("Notification panel doesn't contain the expected Values", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel doesn't contain the expected Values");
            Assert.fail("Notification panel doesn't contain the expected Values");
        }
    }

    @Then("^user verifies \"([^\"]*)\" section in Notification panel has following values$")
    public void user_section_has_following_values(String section, DataTable data) throws Throwable {
        try {
            List<String> propertyList = data.asList(String.class);
            new DashboardActions(driver).verifyNotificationPanelProperty(section, propertyList);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification properties displayed in details page");
        } catch (Exception e) {
            takeScreenShot("Notification properties not displayed in notification details page", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification properties not displayed in notification details page");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }
  /*
   10.3 New UI Step Definitions

   */

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" button in \"([^\"]*)\"$")
    public void user_on_WelcomePage(String actionType, String buttonName,String PageName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            waitUntilAngularReady(driver);
            sleepForSec(1000);
            new DashboardActions(driver).genericActions(actionType, buttonName, PageName);
            waitForAngularLoad(driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot( buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  buttonName + " is not clicked");
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" for \"([^\"]*)\" in \"([^\"]*)\"$")
    public void user_on_Page(String actionType, String buttonName, String field, String PageName) throws Throwable {
        try {
            sleepForSec(500);
            waitUntilAngularReady(driver);
            new DashboardActions(driver).genericActions(actionType, buttonName, field);
            waitForAngularLoad(driver);
            waitUntilAngularReady(driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot( buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  buttonName + " is not clicked");
        }
    }

    @When("^user verifies \"([^\"]*)\" is \"([^\"]*)\"$")
    public void user_verifies_displayed(String elementName, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, elementName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  elementName + " is "+actionType);
        } catch (Exception e) {
            takeScreenShot( elementName + " is not "+actionType, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(elementName + " is not "+actionType + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  elementName + " is not "+actionType);
        }
    }

    @When("^user verifies \"([^\"]*)\" is \"([^\"]*)\" in \"([^\"]*)\"$")
    public void user_verifies_is_in(String buttonName, String actionType, String PageName) throws Throwable {
        try {
            sleepForSec(1000);
            new DashboardActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot( buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  buttonName + " is not clicked");
        }
    }


    @When("^user performs following actions in the header$")
    public void user_on_header(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                sleepForSec(1000);
                new DashboardActions(driver).genericActions(values.get("actionType"), values.get("actionItem"));
                sleepForSec(500);
                waitForAngularLoad(driver);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  "action in header is performed");
        } catch (Exception e) {
            takeScreenShot( "action in header is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("action in header is not performed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  "action in header is not performed");
        }
    }

    @When("^user performs following actions in the sidebar")
    public void user_on_sidebar(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new DashboardActions(driver).genericActions(values.get("actionType"), values.get("actionItem"));
                waitForAngularLoad(driver);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  "action in sidebar is performed");
        } catch (Exception e) {
            takeScreenShot( "action in sidebar is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  "action in sidebar is not performed");
            Assert.fail("action in sidebar is not performed" + e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" for the following submenus under \"([^\"]*)\" menu")
    public void user_verifies_submenu(String actionType, String parentMenu, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new DashboardActions(driver).verifyElementPresence(itemList, actionType, parentMenu);
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action in sidebar is performed");
        } catch (Exception e) {
            takeScreenShot("action in sidebar is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("action in sidebar is not performed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action in sidebar is not performed");
        }
    }

    @When("^user verifies the \"([^\"]*)\" for \"([^\"]*)\" in Add Data Sources Page")
    public void user_verifies_in_Manage_Data_Sources_Page(String actionType, String parentMenu, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new DashboardActions(driver).verifyElementPresence(itemList, actionType, parentMenu);
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action is performed on "+actionType+" in Manage Data Source page");
        } catch (Exception e) {
            takeScreenShot("action is not performed on "+actionType+" in Manage Data Source page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("action is not performed on "+actionType+" in Manage Data Source page" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action is not performed on "+actionType+" in Manage Data Source page");
        }
    }

    @And("^user \"([^\"]*)\" in \"([^\"]*)\"$")
    public void userEnterTextInManageConfigurationPanel(String actionType, String popUp, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(700);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).manageDataSourcePageConfigurations(actionType, values.get("fieldName"), values.get("actionItem"), values.get("itemName"));
            }
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+" action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+" action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+" action is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Add Data Source Page$")
    public void userSelectsFromAddDataSourcePage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).addDataSourcePageConfigurations(actionType, values.get("fieldName"), values.get("attribute"), values.get("pageName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+" action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+" action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+" action is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" for \"([^\"]*)\" in \"([^\"]*)\" Page$")
    public void userEntersCredentialInPage(String actionType, String actionItem, String pageName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            new DashboardActions(driver).enterPageConfigurations(actionType, actionItem);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + " action is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Add Credentials Page$")
    public void userSelectsFromAddCredentialsPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).addCredentialsPageConfigurations(actionType, values.get("fieldName"), values.get("attribute"), values.get("pageName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + " action is not performed" + e.getMessage());
        }
    }


    @And("^user \"([^\"]*)\" in \"([^\"]*)\" Page$")
    public void userSelectsFromProfileSettingPage(String actionType, String pageName, DataTable dataTable) throws Throwable {
        try {
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).addProfileSettingPageConfigurations(actionType, values.get("fieldName"), values.get("option"), values.get("attribute"));
            }
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dropdown option is selected");
        } catch (Exception e) {
            takeScreenShot("Dropdown option is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" the search results with \"([^\"]*)\" catalog in search reuslts page.")
        public void user_verifies_search_results(String elementName, String actionType) throws Throwable {
            try {
                waitForAngularLoad(driver);
                new DashboardActions(driver).genericActions(actionType, elementName);
                sleepForSec(500);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  elementName + " is "+actionType);
            } catch (Exception e) {
                takeScreenShot( elementName + " is not "+actionType, driver);
                new DashBoardPage(driver).Click_profileLogoutButton();
                Assert.fail(elementName + " is not "+actionType + e.getMessage());
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  elementName + " is not "+actionType);
            }
        }

    @When("^user \"([^\"]*)\" for the following filter in search results page")
    public void user_verifies_filters(String actionType, DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class))
                new DashboardActions(driver).verifySelects(actionType, values.get("FilterType"), values.get("FilterValues"));
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action in Facetfilter is performed");
        } catch (Exception e) {
            takeScreenShot("action in Facetfilter is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("action in Facetfilter is not performed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action in Facetfilter is not performed");
        }
    }

    @Then("^user \"([^\"]*)\" of following \"([^\"]*)\" in \"([^\"]*)\" page$")
    public void user_in_Manage_Data_Source_page(String actionType, String actionToBeVerified, String pageName, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(500);
            sleepForSec(2000);
            new DashboardActions(driver).validateElementsInManageDataSourcePage(actionType, actionToBeVerified, dataTable.asList(String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            takeScreenShot("Values does not match", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Values does not match" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values does not match");
        }
    }

    @When("^user \"([^\"]*)\" with count as \"([^\"]*)\" catalog \"([^\"]*)\" in Search results page")
    public void user_verifies_resultscount(String actionType, String Count,String catalog) throws Throwable {
        try {
            new DashboardActions(driver).genericActions(actionType, Count);
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action in searchpage is performed");
        } catch (Exception e) {
            takeScreenShot("action in searchpage is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("action in searchpage is not performed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action in searchpage is not performed");
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" icon from left panel$")
    public void user_clicks_report_icon(String actionType, String Report) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericClick(actionType, Report);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Report " + Report + " is clicked");
        } catch (Exception e) {
            takeScreenShot("Report " + Report + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Report " + Report + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Report " + Report + " is not clicked");
        }
    }

    @When("^user \"([^\"]*)\" the \"([^\"]*)\" menu get closed$")
    public void user_verifies_admin_closed(String actionType, String Admin) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, Admin);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "AdminMenu " + Admin + " is not visible");
        } catch (Exception e) {
            takeScreenShot("AdminMenu " + Admin + " is  visible", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("AdminMenu " + Admin + " is visible" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Report " + Admin + " is  visible");
        }
    }

    @When("^user \"([^\"]*)\" the \"([^\"]*)\" text is displayed in sort drop down$")
    public void user_verifies_none_text(String actionType, String None) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, None);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "None " + None + " is  visible");
        } catch (Exception e) {
            takeScreenShot("None " + None + " is not  visible", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("None " + None + " is  not visible" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "None " + None + " is not  visible");
        }
    }

    @Then("^user verifies the background color of the page$")
    public void user_verifies_the_color_code_for_any_displayed_node(DataTable data) throws Throwable {
        String expectedRGBCode ="";
        String actualRGBCode ="";
        try {

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                if(values.get("Page").startsWith("Manage")) {
                    actualRGBCode = new DashBoardPage(driver).getBackgroundcolor(values.get("Page")).getCssValue(values.get("StyleType"));
                    expectedRGBCode = values.get("ColorCode");
                }else if(values.get("Page").startsWith("Search Suggestions")){
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.ARROW_DOWN);
                    actualRGBCode = new DashBoardPage(driver).getSearchSuggestionText().getCssValue("color");
                    expectedRGBCode = values.get("ColorCode");
                }else if(values.get("Page").startsWith("Data Asset")){
                    keyPressEvent(driver, Keys.ARROW_DOWN);
                    actualRGBCode = new DashBoardPage(driver).getDataAssetBar(values.get("Page")).getCssValue(values.get("StyleType"));
                    expectedRGBCode = values.get("ColorCode");
                }else if(values.get("Page").startsWith("Color Icon")){
                    actualRGBCode = new DashBoardPage(driver).getRoundIcon().getCssValue(values.get("StyleType"));
                    expectedRGBCode = values.get("ColorCode");
                }else if(values.get("Page").startsWith("Tag Icon")){
                    actualRGBCode = new DashBoardPage(driver).getTagCategoryIcon().getCssValue(values.get("StyleType"));
                    expectedRGBCode = values.get("ColorCode");
                }else if(values.get("Page").startsWith("ColorTag")){
                    actualRGBCode = new DashBoardPage(driver).getTagCategoryColorIcon(values.get("Page")).getCssValue(values.get("StyleType"));
                    expectedRGBCode = values.get("ColorCode");
                }

                Assert.assertEquals(actualRGBCode, expectedRGBCode);
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Background color is verified");
            takeScreenShot("Background color gets mismatched", driver);
        } catch (Exception e) {
            takeScreenShot("Background color gets mismatched", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Background color gets mismatched" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" icon on password field$")
    public void userSelectsFromAddCredentialsPage(String actionType,String Icon) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
          {
                new DashboardActions(driver).genericActions(actionType,Icon);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + " action is not performed" + e.getMessage());
        }
    }

    @And("^user verifies whether following parameters is \"([^\"]*)\" in Run Search Page$")
    public void userVerifiesollowingInRunSearchPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).runSearchPageConfigurations(actionType, values.get("searchName"));
            }
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+ "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+ "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+ "is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in the \"([^\"]*)\" Page$")
    public void userInTheSaveSearchPage(String actionType, String pageName, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).enterDynamicTextInSaveSearchPage(actionType, values.get("fieldName"), values.get("attribute"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Entered text in Textbox");
            }
        } catch (Exception e) {
            takeScreenShot("Entered text in Textbox", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not Entered text in Textbox" + e.getMessage());
        }
    }

    @When("^user verifies the background color of the header$")
    public void user_verifies_the_background_color_of_the_header(DataTable dataTable) throws Throwable {
        try {

            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                String styleType = values.get("StyleType");
                String actualRGBCode = new DashBoardPage(driver).getTableHeadercolor().getCssValue(values.get("StyleType"));
                String expectedRGBCode = values.get("ColorCode");
                    Assert.assertEquals(actualRGBCode, expectedRGBCode);
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Header color is verified");
            takeScreenShot("Header color gets mismatched", driver);
        } catch (Exception e) {
            takeScreenShot("Header color gets mismatched", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Header color gets mismatched" + e.getMessage());
        }
    }

    @And("^user verifies whether \"([^\"]*)\" is \"([^\"]*)\" for \"([^\"]*)\" Item view page$")
    public void userVerifiesollowingInItemViewPage(String actionTobePresent, String actionType, String field) throws Throwable {
        try {
            new DashboardActions(driver).genericActions(actionType, actionTobePresent, field);
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + "is not performed" + e.getMessage());
        }
    }

    @Then("^user verifies \"([^\"]*)\" menu is \"([^\"]*)\" in the left menu\\.$")
    public void user_verifies_menu_is_in_the_left_menu(String elementName, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, elementName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  elementName + " is "+actionType);
        } catch (Exception e) {
            takeScreenShot( elementName + " is not "+actionType, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(elementName + " is not "+actionType + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  elementName + " is not "+actionType);
        }
    }

    @When("^user verifies \"([^\"]*)\" is \"([^\"]*)\" in Manage Bundles page$")
    public void user_verifies_in_AddConfiguration_Page(String buttonName, String actionType) throws Throwable {
        try {
            sleepForSec(1000);
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot(buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " is not clicked");
        }
    }

    @When("^user \"([^\"]*)\" the following \"([^\"]*)\" in Manage Bundle Page$")
    public void user_verifies_text_in_AddBundle_Page(String buttonName, String actionType) throws Throwable {
        try {
            sleepForSec(1000);
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot(buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " is not clicked");
        }
    }

    @And("^user verifies the \"([^\"]*)\" widget with count is \"([^\"]*)\" in Overview page$")
    public void userVerifiessimilarwidget(String widget, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, widget);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widget + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(widget + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(widget + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), widget + " is  not displayed");
        }
    }

    @And("^user verifies the \"([^\"]*)\" of similar table \"([^\"]*)\" in Overview page$")
    public void userVerifiessimilartable(String widget, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, widget);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widget + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(widget + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(widget + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), widget + " is  not displayed");
        }
    }

    @When("^user \"([^\"]*)\" on item from \"([^\"]*)\" table in Overview page$")
    public void user_clicks_item_similar(String actionType, String Report) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, Report);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Report " + Report + " is clicked");
        } catch (Exception e) {
            takeScreenShot("Report " + Report + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Report " + Report + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Report " + Report + " is not clicked");
        }

    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" widget in Overview page$")
    public void user_clicks_item_similaricon(String actionType, String Report) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DashboardActions(driver).genericActions(actionType, Report);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Report " + Report + " is clicked");
        } catch (Exception e) {
            takeScreenShot("Report " + Report + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Report " + Report + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Report " + Report + " is not clicked");
        }

    }

    @And("^user verifies the \"([^\"]*)\" of Most frequent values table \"([^\"]*)\" in Overview page$")
    public void userVerifiesMostFrequeentvaluewidget(String widget, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new CommonActions(driver).genericActions(actionType, widget);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widget + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(widget + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(widget + " is  not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), widget + " is  not displayed");
        }
    }

    @When("^user gets the items search count$")
    public void tuser_gets_the_items_search_count() throws Throwable {
        try {
            commonUtil.storeTemporaryText(new SubjectArea(driver).getItemCountInSearchResultsPage());
            LoggerUtil.logLoader_info(new SubjectArea(driver).getItemCountInSearchResultsPage(), "Number of Items found In UI");
        } catch (Exception e) {
            takeScreenShot("Search Result is not matching ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search Result is not matching  " + e.getMessage());
        }
    }

    @Given("^user gets the items count from json$")
    public void user_gets_the_items_count_from_json(DataTable arg1) throws Throwable {
        for (Map<String, String> data : arg1.asMaps(String.class, String.class)) {

            try {
                String filePath = Constant.REST_DIR + data.get("filePath");
                String jsonPath = data.get("jsonPath");
                new CommonUtil().storeTemporaryText(JsonRead.getJsonValue(filePath,jsonPath).replaceAll("[^0-9]", ""));
                LoggerUtil.logLoader_info( this.getClass().getSimpleName(), "Number of Items found In UI : " + CommonUtil.getTemporaryText());
            } catch (Exception e) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
                Assert.fail("Unable to retrieve the item count  " + e.getMessage());
            }
        }
    }


    @And("^user verifies \"([^\"]*)\" for \"([^\"]*)\" in Item view page$")
    public void userVerifiesWidgetIsForInItemViewPage(String actionType,String widgetName) throws Throwable {
        try {
            new DashboardActions(driver).validatePresense(actionType, widgetName);
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + "is not performed" + e.getMessage());
        }
    }

    @And("^user click on \"([^\"]*)\" in Item View page$")
    public void userClickOnWidgetBelonginingsInItemViewPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).genericClick(actionType, values.get("widgetName"), values.get("widgetBelonging"));
            }
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + "is not performed" + e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" should be \"([^\"]*)\" as \"([^\"]*)\" in \"([^\"]*)\"$")
    public void shouldBeAsIn(String elementName, String actionType, String value, String pageName) throws Throwable {
        try {
            new DashboardActions(driver).genericActions(actionType, elementName, value);
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + "is not performed" + e.getMessage());
        }
    }


    @And("^user performs \"([^\"]*)\" operation in Manage Bundles Panel")
    public void userPerformsFollowingInManageBundlesPanel(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).genericActions(actionType, values.get("button"), values.get("actionItem"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+ "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+ "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+ "is not performed" + e.getMessage());
        }
    }

    @And("^user verifies search catalog dropdown is removed$")
    public void userVerifiesSearchCatalogDropdownIsRemoved() {
        try {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  " Search Catalog dropdown is not Found");
            Assert.assertFalse(isElementPresent(new SubjectArea(driver).getsearchCatalogDropDown()));
        } catch (org.openqa.selenium.TimeoutException e) {
            takeScreenShot("Search Catalog dropdown button is  present", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user clicks on exit button in notifications panel$")
    public void user_clicks_on_exit_button_in_notifications_panel() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            new DashboardActions(driver).genericClick("close_notificationTab");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel is closed");
        } catch (Exception e) {
            takeScreenShot("Exit button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notification panel is not closed");
            Assert.fail(e.getMessage());
        }
    }

    @And("^User performs following actions in the Trust Policy Page$")
    public void userPerformsFollowingActionsInTheItemViewPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new DashboardActions(driver).TrustPolicypagevalidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Item View Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }
    @Then("^user creates a tag with the following parameters$")
    public void user_creates_a_tag(DataTable dataTable) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).createTag(values.get("CategoryName"), values.get("Definition"), values.get("Icon"), values.get("colorWidthHeight"), values.get("Protected"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is created");
        } catch (Exception e) {
            takeScreenShot("Issue in creating tag", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is not created");
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" of following \"([^\"]*)\" in \"([^\"]*)\" Page$")
    public void user_of_following_in_Item_View_Page(String actionType, String elementName, String pageName, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            waitForAngularLoad(driver);
            new DashboardActions(driver).verifyElementPresence(itemList, actionType, elementName);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are present in Item View Page tag section");
        } catch (Exception e) {
            takeScreenShot("Issue in verifying item presence", driver);
            Assert.fail("Element not present");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are not present in Item View Page tag section");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^User performs following actions in the Manage Tags Page$")
    public void userPerformsFollowingActionsInTheExcelImporterPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new DashboardActions(driver).ManageTagsPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"),values.get("Attribute"));
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Manage Tags Page");
            }
        } catch (Exception e) {
            takeScreenShot("action is Manage Tags Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Manage Tags Page is not performed ");
            Assert.fail("action in Manage Tags Page is not performed" + e.getMessage());
        }
    }

    @And("^user validtes widget present in DashBoard$")
    public void userValidtesWidgetPresentInDashBoard(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).DashBoardPageValidations(values.get("actionType"), values.get("elementName"), values.get("ItemName"));
            }
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DashBoard Validation is performed");
        } catch (Exception e) {
            takeScreenShot("DashBoard Validation is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("DashBoard Validation is not performed" + e.getMessage());
        }
    }

    @And("^user create a tag with name \"([^\"]*)\" in Manage Tags page$")
    public void userCreateATagWithNameInManageTagsPage(String name) throws Throwable {
        try {
            enterUsingActions(driver, new DashBoardPage(driver).getAddCategoryTextBox("tagName"), name);
            clickonWebElementwithJavaScript(driver,new DashBoardPage(driver).getAddCategorySaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is created");
        } catch (Exception e) {
            takeScreenShot("Issue in creating tag", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is not created");
            Assert.fail(e.getMessage());
        }
    }

    @And("^User performs following actions in the Tagging Policy Page$")
    public void userPerformsFollowingActionsInTheTaggingPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitUntilAngularReady(driver);
                new DashboardActions(driver).TaggingPolicypagevalidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                waitUntilAngularReady(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Tagging Policy Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Tagging Policy Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Tagging Policy Page is not performed ");
            Assert.fail("action in Tagging Policy Page is not performed" + e.getMessage());
        }
    }

    @And("^User performs following actions in the Manage Notifications Page$")
    public void userPerformsFollowingActionsInTheManageNotificationsPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).ManageNotificationsPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"),values.get("Attribute"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Manage Notifications Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Manage Notifications Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Manage Notifications Page is not performed ");
            Assert.fail("action in Manage Notifications Page is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Create new item page$")
    public void userInCreateNewItemPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).addcreatePageConfigurations(actionType, values.get("fieldName"), values.get("attribute"), values.get("option"),values.get("Message"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+" action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+" action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+" action is not performed" + e.getMessage());
        }
    }

    @Then("^user verifies the count from Data Asset and facets filters of tag \"([^\"]*)\" are same.$")
    public void userverifiesthecountfromData_Assetandfacets_filters_are_same(String TagName){
        try{
            String text=getElementText(new DashBoardPage(driver).getTagType(TagName));
            verifyEquals(text, commonUtil.getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Match Performed in search Page");
        }
        catch (Exception e){
            takeScreenShot("Match Performed in search Page",driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Match not Performed in search Page");
            Assert.fail("Match not Performed in search Page" + e.getMessage());
        }
    }
    @And("^user \"([^\"]*)\" in Add Pipelines Page$")
    public void userSelectsFromAddPipelinesPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).addPipelinesPageConfigurations(actionType, values.get("fieldName"), values.get("actionItem"), values.get("itemName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + " action is not performed" + e.getMessage());
        }
    }

    @And("^user Edit a Tag with following Parameter$")
    public void userEditATagWithFollowingParameter(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).editTag(values.get("actionType"), values.get("Definition"), values.get("Icon"), values.get("colorWidthHeight"), values.get("Protected"), values.get("colorWidthHeightslider"), values.get("editIcon"), values.get("Tempsavecolor"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is created");
        } catch (Exception e) {
            takeScreenShot("Issue in creating tag", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is not created");
            Assert.fail(e.getMessage());
        }
    }

    @And("^User performs following actions in the Manage Licenses Page$")
    public void userPerformsFollowingActionsInTheManageLicensesPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DashboardActions(driver).ManageLicensesPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"),values.get("Attribute"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Manage Licenses Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Manage Licenses Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Manage Licenses Page is not performed ");
            Assert.fail("action in Manage Licenses Page is not performed" + e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" of following \"([^\"]*)\" in Audit Log Page$")
    public void user_of_following_in_Audit_Log_Page(String actionType, String elementName, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new DashboardActions(driver).verifyElementPresence(itemList, actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Labels/Menu headers present in Audit Log Screen");
        } catch (Exception e) {
            Assert.fail("Element not present");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Labels/Menu headers are not present in Audit Log Screen");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^users performs following actions in Audit Log page$")
    public void usersPerformsFollowingActionsInAuditLogPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new DashBoardPage(driver).manageAuditLog(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Item View Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

    @And("^User performs following actions in the Manage Access Requests page$")
    public void userPerformsFollowingActionsInTheAccessRequestsPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                waitUntilAngularReady(driver);
                new DashBoardPage(driver).ManageAccessRequestsPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                waitUntilAngularReady(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Access Requests Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

}