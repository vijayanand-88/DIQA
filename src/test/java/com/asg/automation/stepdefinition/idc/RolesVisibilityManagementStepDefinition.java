package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.DashboardActions;
import com.asg.automation.pageactions.idc.RolesAndGroupManagerActions;
import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.utils.*;
import com.google.common.base.CharMatcher;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
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

import javax.management.relation.Role;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

import static com.asg.automation.utils.Constant.FEATURES;
import static com.asg.automation.utils.PostgresSqlBuilder.getselectedColumnName;

public class RolesVisibilityManagementStepDefinition extends DriverFactory {

    private WebDriver driver;
    private FileUtil fileUtil;

    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
            fileUtil = new FileUtil();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @After("@webtest")
    public void close() throws Exception {
        destroyDriver();

    }

    @Given("^user \"([^\"]*)\" the \"([^\"]*)\" in the Administration dashboard$")
    public void user_on_the_Administration_dashboard(String actionType, String elementName) throws Throwable {

        try {
            new RolesAndGroupManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getName(), actionType + " is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " is not performed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @When("^user resizes \"([^\"]*)\" widget \"([^\"]*)\" and save it$")
    public void user_resizes_widget_and_save_it(String widgetName, String resizeOption) throws Throwable {
        try {
            new RolesAndGroupManagerActions(driver).resizeWidgetRolesAndGroupManager(widgetName, resizeOption);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Roles And Group Manager resize button is clicked");
        } catch (Exception e) {
            takeScreenShot("Roles And Group Manager resize button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Roles And Group Manager resize button is not clicked" + e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" the widget \"([^\"]*)\"$")
    public void user_the_widget(String actionType, String widgetName) throws Throwable {
        try {
            new RolesAndGroupManagerActions(driver).genericActions(actionType, widgetName);
            LoggerUtil.logLoader_info(this.getClass().getName(), actionType + " is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " is not performed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @When("^user \"([^\"]*)\" the \"([^\"]*)\" in the new opening panel$")
    public void user_the_in_the_new_opening_panel(String actionType, String elementName) throws Throwable {
        try {
            new RolesAndGroupManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getName(), actionType + " is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " is not performed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Then("^user \"([^\"]*)\" the \"([^\"]*)\" list is displayed in the new opening panel$")
    public void user_the_list_is_displayed_in_the_new_opening_panel(String actionType, String values) throws Throwable {
        try {
            new RolesAndGroupManagerActions(driver).genericActions(actionType, values);
            LoggerUtil.logLoader_info(this.getClass().getName(), actionType + " is performed");

        } catch (Exception e) {
            takeScreenShot(actionType + " is not performed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

//10.3 New UI Step definitions

    @And("^user \"([^\"]*)\" of following \"([^\"]*)\" in Manage Access Page$")
    public void userOfFollowingInManageAccessPage(String actionType, String actionToBeVerified, DataTable dataTable) throws Throwable {
        try {
            new RolesAndGroupManagerActions(driver).validateElementsInManageAccessPage(actionType, actionToBeVerified, dataTable.asList(String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            takeScreenShot("Values does not match", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values does not match");
            Assert.fail("Values does not match" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in Manage Access page$")
    public void userOnTabInManageAccessPage(String actionType, String elementName) throws Throwable {
        try {
            new RolesAndGroupManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Menu or Button is clicked");
        } catch (Exception e) {
            takeScreenShot("Menu or Button is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Menu or Button is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Menu or Button is not clicked");
            Assert.fail("Menu or Button is not clicked" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Manage Access Role Page$")
    public void userInManageAccessRolePage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new RolesAndGroupManagerActions(driver).genericActions(actionType, values.get("fieldName"), values.get("option"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dropdown option is selected");
        } catch (Exception e) {
            takeScreenShot("Dropdown option is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in \"([^\"]*)\" Manage Access Page$")
    public void userInManageAccessPage(String actionType, String popUp, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new RolesAndGroupManagerActions(driver).manageAccessPageConfigurations(actionType, values.get("fieldName"), values.get("actionItem"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + " action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + " action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + " action is not performed" + e.getMessage());
        }

    }

    @And("^user verifies whether following parameters is \"([^\"]*)\" in Manage Access Roles page$")
    public void userVerifiesollowingInManageConfigurationPanel(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new RolesAndGroupManagerActions(driver).actionsInManageAccessRolesAndUsersPage(actionType, values.get("button"), values.get("roleName"));
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

    @And("^user performs \"([^\"]*)\" operation in Manage Access Roles and Users list$")
    public void userPerformsOperationInManageAccessRolesAndUsersList(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new RolesAndGroupManagerActions(driver).genericActions(actionType, values.get("button"), values.get("roleName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType + "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType + "is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Manage Access Page$")
    public void userInManageAccessPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new RolesAndGroupManagerActions(driver).manageAccessPageConfigurations(actionType, values.get("fieldName"), values.get("option"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dropdown option is selected");
        } catch (Exception e) {
            takeScreenShot("Dropdown option is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }

    @And("^user verifies the \"([^\"]*)\" table with count is \"([^\"]*)\" in Manage Access page$")
    public void userVerifiesTheTableWithCountIsInManageAccessPage(String actionType, String table) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new RolesAndGroupManagerActions(driver).genericActions(actionType, table);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), table + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(table + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), table + " is  not displayed");
            Assert.fail(table + " is  not displayed" + e.getMessage());
        }
    }

    @And("^user verifies the \"([^\"]*)\" of Roles table \"([^\"]*)\" in Manage Access page$")
    public void userVerifiesTheOfRolesTableInManageAccessPage(String actionType, String table) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new RolesAndGroupManagerActions(driver).genericActions(actionType, table);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), table + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(table + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), table + " is  not displayed");
            Assert.fail(table + " is  not displayed" + e.getMessage());
        }
    }


    @And("^users performs following actions in Manage access$")
    public void usersPerformsFollowingActionsInManageAccess(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new RolesAndGroupManager(driver).manageAccessValidation(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"), values.get("Attribute"));
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Item View Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }
}


