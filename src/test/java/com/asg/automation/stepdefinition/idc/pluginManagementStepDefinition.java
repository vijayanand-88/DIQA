package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.DashboardActions;
import com.asg.automation.pageactions.idc.PluginManagerActions;
import com.asg.automation.pageactions.idc.SubjectAreaManagerActions;
import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.Plugin;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.support.Color;
import org.testng.Assert;
import ru.yandex.qatools.allure.model.LabelName;

import java.util.*;

/**
 * Created by Sivanandam.Meiya on 1/22/2018.
 */

public class pluginManagementStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    protected DBPostgresUtil db_postgres_util;
    private CommonUtil commonUtil;

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


    @Given("^user clicks on Plugin Manager in Administration dashboard$")
    public void user_clicks_on_Plugin_Manager_in_Administration_dashboard() throws Throwable {
        try {
            if(new PluginManager(driver).getPluginManagementLink().isEmpty()){
                refresh(driver);
                waitForAngularLoad(driver);
            }
            sleepForSec(2000);
            new PluginManager(driver).clickPluginManager();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager in Admin dashboard is clicked");
        } catch (Exception e) {
            takeScreenShot("Plugin Manager in Admin dashboard is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Plugin Manager in Admin dashboard is not clicked" + e.getMessage());
        }
    }

    @Given("^user validate Plugin Manager widget is displayed$")
    public void user_validate_Plugin_Manager_widget_is_displayed() throws Throwable {
        try {
            sleepForSec(1000);
            scrollToWebElement(driver, new PluginManager(driver).locatePluginManager());
            Assert.assertTrue(isElementPresent(new PluginManager(driver).locatePluginManager()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager widget is displayed");
        } catch (Exception e) {
            takeScreenShot("Plugin Manager widget is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Unable to locate Plugin Manager");
        }
    }

    @And("^user verifies Plugin Management panel is Displayed$")
    public void user_verifies_plugin_management_panel_is_displayed() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getPluginManagementPanel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin management panel is displayed");
        } catch (Exception e) {
            takeScreenShot("Plugin management panel is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^Definition \"([^\"]*)\" should be displayed in Plugin Manager$")
    public void definition_should_be_displayed_in_Plugin_Manager(String defintion) throws Throwable {
        try {
            Assert.assertEquals(defintion, new PluginManager(driver).getPluginManagerDefinition());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Defintion for Plugin manager is displayed");
        } catch (Exception e) {
            takeScreenShot("Defintion for Plugin manager is displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Definition for Plugin Manager is not displayed");
        }
    }

    @Given("^Description \"([^\"]*)\" should be displayed under Plugin Manager$")
    public void description_should_be_displayed_under_Plugin_Manager(String description) throws Throwable {
        try {
            Assert.assertEquals(description, new PluginManager(driver).getPluginManagerDesc());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description for Plugin manager is  displayed");
        } catch (Exception e) {
            takeScreenShot("Description for Plugin manager is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Description for Plugin Manager is not displayed");
        }
    }

    @Given("^Quick Links for Plugin Manager should be displayed on the Dashboard$")
    public void quick_Links_for_Plugin_Manager_should_be_displayed_on_the_Dashboard() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getPluginManagerQuickLinkLabel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager Quick Link label is displayed");
        } catch (Exception e) {
            takeScreenShot("Plugin Manager Quick Link label is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Quick Link label is not displayed");
        }
    }

    @Given("^RECENT label for Plugin Manager should be displayed on the Dashboard$")
    public void recent_label_for_Plugin_Manager_should_be_displayed_on_the_Dashboard() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getPluginManagerRecentLabel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager Recent label is displayed");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Plugin Manager Recent label is not displayed", driver);
            Assert.fail("Recent label is not displayed");
        }
    }

    @Given("^user click Plugin Manager resize button$")
    public void user_click_Plugin_Manager_resize_button() throws Throwable {
        try {
            clickOn(new PluginManager(driver).pluginManagerResizeMenu());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager Resize button is clicked");
        } catch (Exception e) {
            takeScreenShot("Plugin Manager Resize button is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Resize button is not clicked");
        }
    }

    @Then("^user select \"([^\"]*)\" from resize widget list$")
    public void user_select_from_resize_widget_list(String widgetSize) throws Throwable {
        try {
            waitForPageLoads(driver, 5);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(new PluginManager(driver).pluginManagerResizeMenuList(), widgetSize));
                sleepForSec(1000);
            } else {
                clickOn(traverseListContainsElementReturnsElement(new PluginManager(driver).pluginManagerResizeMenuList(), widgetSize));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager widget is resized");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Plugin Manager in Admin dashboard is not clicked", driver);
            Assert.fail("Plugin Manager widget is not resized");
        }
    }

    @Then("^Widget size \"([^\"]*)\" should be highlighted in widget resize menu list$")
    public void widget_size_should_be_highlighted_in_widget_resize_menu_list(String widgetSize) throws Throwable {
        try {
//            String browserName = propLoader.prop.getProperty("browserName");
//            if (browserName.equalsIgnoreCase("edge")) {
//                clickonWebElementwithJavaScript(driver,new PluginManager(driver).pluginManagerResizeMenu());
//                sleepForSec(1000);
//            }
//            else {
//                clickOn(new PluginManager(driver).pluginManagerResizeMenu());
//            }
            Assert.assertEquals(new PluginManager(driver).pluginManagerWidgetSize(), widgetSize);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin Manager widget is resized");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Plugin Manager in Admin dashboard is not clicked", driver);
            Assert.fail("Widget size is not changed");
        }
    }

    @Given("^user clicks Add New Node button in Plugin Management screen$")
    public void user_clicks_Add_New_Node_button_in_Plugin_Management_screen() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).addNewNode());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add new node button is clicked in Plugin Management");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Add new node button is not clicked in Plugin Management", driver);
        }
    }

    @Given("^user enter node name as \"([^\"]*)\"$")
    public void user_enter_node_name_as(String nodeName) throws Throwable {
        try {
            enterText(new PluginManager(driver).nodeName(), nodeName.replace(nodeName, propLoader.prop.getProperty("hostName")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "New node name is entered");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot("Node name is not entered", driver);
        }
    }

    @Given("^user select \"([^\"]*)\" from Catalog list$")
    public void user_select_from_Catalog_list(String catalogName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).catalogDropDown());
            WebElement catalogname = traverseListContainsElementReturnsElement(new PluginManager(driver).catalogList(), catalogName);
            clickOn(driver, catalogname);
            waitandFindElement(driver, new SubjectArea(driver).verifyStructure(),30,false);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog is selected");
        } catch (Exception e) {
            takeScreenShot("Catalog is not selected", driver);
            Assert.fail("catalog name not enabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enable \"([^\"]*)\" plugin check box and click Assign button$")
    public void user_enable_plugin_check_box_and_click_Assign_button(String pluginName) throws Throwable {
        try {
            sleepForSec(1000);
            scrollToWebElement(driver, new PluginManager(driver).pluginCheckBox(pluginName));
            clickOn(new PluginManager(driver).pluginCheckBox(pluginName));
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).assignButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin checkbox is selected");
        } catch (Exception e) {
            takeScreenShot("Plugin is not Selected and assigned", driver);
            Assert.fail("plugin not enabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Given("^user navigate to \"([^\"]*)\" plugin configuration page$")
    public void user_navigate_to_plugin_configuration_page(String pluginName) throws Throwable {
        try {
            WebElement assignedPlugin = traverseListContainsElementTextReturnsElement(new PluginManager(driver).assignedPluginList(), pluginName);
            scrollToWebElement(driver, assignedPlugin);
            sleepForSec(2000);
            clickOn(assignedPlugin);
            sleepForSec(8000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginName + " is displayed");
        } catch (Exception e) {
            takeScreenShot(pluginName + " is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("plugin config page is not displayed");
        }

    }

    @Given("^user enters the \"([^\"]*)\" as \"([^\"]*)\" in Plugin Configuration page$")
    public void user_enters_the_as_in_Plugin_Configuration_page(String name, String value) throws Throwable {
        try {
            enterText(new PluginManager(driver).pluginConfigurationInput(name), value);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), value + " entered in" + name);
        } catch (Exception e) {
            takeScreenShot(name + " value  not entered", driver);
            Assert.fail(name + " value not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enters \"([^\"]*)\" as \"([^\"]*)\"$")
    public void user_enters_as(String branch, String branchName) throws Throwable {
        try {
            enterText(new PluginManager(driver).filterPageAttributes(branch), branchName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), branchName + " entered in" + branch);
        } catch (Exception e) {
            takeScreenShot(branchName + " not entered in" + branch, driver);
            Assert.fail(branchName + " value not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user add button in \"([^\"]*)\" section$")
    public void user_add_button_in_section(String pageName) throws Throwable {
        try {
            new PluginManagerActions(driver).genericClick("add button", pageName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pageName + " add button is not clicked");
        } catch (Exception e) {
            takeScreenShot(pageName + " add button is not clicked", driver);
            Assert.fail(pageName + " add button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user click Apply button in \"([^\"]*)\" page$")
    public void user_click_Apply_button_in_page(String pageName) throws Throwable {
        try {
            sleepForSec(1000);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                WebElement element = new PluginManager(driver).childPageApplyButton(pageName);
                waitandFindElement(driver, element, 3, false);
                scrolltoElement(driver, element, true);
                clickEventonField(driver, element);
            } else {
                scrolltoElement(driver, new PluginManager(driver).childPageApplyButton(pageName), true);
                clickOn(new PluginManager(driver).childPageApplyButton(pageName));
            }
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pageName + " apply button is clicked");
        } catch (Exception e) {
            takeScreenShot(pageName + " apply button is not clicked", driver);
            Assert.fail(pageName + " apply button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^user enters repository username and password for \"([^\"]*)\"$")
    public void user_enters_repository_username_and_password_for(String plugin) throws Throwable {
        try {
            switch (plugin) {
                case "GitCollector":
                    enterText(new PluginManager(driver).pluginConfigurationInput("REPOSITORY USER"), propLoader.prop.getProperty("BITBUCKET_USERNAME"));
                    enterText(new PluginManager(driver).pluginConfigurationInput("REPOSITORY PASSWORD"), propLoader.prop.getProperty("BITBUCKET_PASSWORD"));
                    break;
                case "ClusterManager":
                    enterText(new PluginManager(driver).pluginConfigurationInput("CLUSTER MANAGER USER"), propLoader.prop.getProperty("ambariUsername"));
                    enterText(new PluginManager(driver).pluginConfigurationInput("CLUSTER MANAGER PASSWORD"), "rdX7heWAVn6gvz3PoOHHpw==");
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("Repository username and password not entered", driver);
            Assert.fail("Repository username and password not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user click save button in Create New Node page$")
    public void user_click_save_button_in_Create_New_Node_page() throws Throwable {
        try {
            sleepForSec(1000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                clickOn(new PluginManager(driver).createNodeSave());
            } else {
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).createNodeSave());
            }
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Save button is  clicked");
        } catch (Exception e) {
            takeScreenShot("Save button in Create Node is not clicked", driver);
            Assert.fail("Save button in Create Node is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user \"([^\"]*)\" on Add New Node button \"([^\"]*)\" page$")
    public void user_on_Add_New_Node_button_page(String action, String className) throws Throwable {
        /*int i = 1;
        Class noparams[] = {};
        Class clsName = Class.forName(className);
        Object obj = clsName.newInstance();
        Method method = clsName.getMethod("addNewNode", noparams);
        method.invoke(obj, null);*/


        //new PluginManager(driver).addNewNode();

    }

    @Given("^user enters the following values in Plugin Configuration fields$")
    public void user_enters_the_following_values_in_Plugin_Configuration_fields(DataTable data) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                if (browserName.equalsIgnoreCase("firefox")) {
                    scrollToWebElement(driver, new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")));
                    enterText(new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")), values.get("pluginConfigFieldValue"));
                    if (isElementPresent(new PluginManager(driver).pluginManagementPageTextAdd(values.get("pluginConfigFieldName"))) == true) {
                        clickOn(new PluginManager(driver).pluginManagementPageTextAdd(values.get("pluginConfigFieldName")));
                    }
                } else {
                    scrollToWebElement(driver, new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")));
                    sleepForSec(1000);
                    //enterTextWithJavaScript(driver, values.get("pluginConfigFieldValue"), new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")));
                    new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")).clear();
                    enterUsingActions(driver, new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")), values.get("pluginConfigFieldValue"));
                    //enterText(new PluginManager(driver).pluginConfigurationInput(values.get("pluginConfigFieldName")), values.get("pluginConfigFieldValue"));
                    sleepForSec(500);
                }
                try {
                    if (isElementPresent(new PluginManager(driver).pluginManagementPageTextAdd(values.get("pluginConfigFieldName"))) == true) {
                        clickonWebElementwithJavaScript(driver, new PluginManager(driver).pluginManagementPageTextAdd(values.get("pluginConfigFieldName")));
                        sleepForSec(1000);
                    }
                }catch (NoSuchElementException e){
                    e.getMessage();
                }
            }


            sleepForSec(500);
        } catch (Exception e) {
            takeScreenShot("Values not entered in configuration page", driver);
            Assert.fail("Values not entered in configuration page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Given("^user clicks on \"([^\"]*)\" from list of nodes$")
    public void user_clicks_on_from_list_of_nodes(String nodeName) throws Throwable {
        try {
            WebElement element = traverseListContainsElementReturnsElement(new PluginManager(driver).getNodeList(), nodeName.replace(nodeName, propLoader.prop.getProperty("hostName")));
            scrollToWebElement(driver, element);
            clickonWebElementwithJavaScript(driver, element);
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Values not entered in configuration page", driver);
            Assert.fail("Values not entered in configuration page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user \"([^\"]*)\" on \"([^\"]*)\" from \"([^\"]*)\"")
    public void user_clicks_on_from_list_of_plugins(String actionType, String pluginName, String list) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, list, pluginName);
        } catch (Exception e) {
            takeScreenShot("Plugin is not clicked from the plugin list", driver);
            Assert.fail("Plugin is not clicked from the plugin list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" node if it is present already$")
    public void user_clicks_on_from_node_if_it_is_present_already(String nodeName) throws Throwable {
        try {
            if (isElementPresent(traverseListContainsElementReturnsElement(new PluginManager(driver).getNodeList(), nodeName.replace(nodeName, propLoader.prop.getProperty("hostName"))))) {
                WebElement element = traverseListContainsElementReturnsElement(new PluginManager(driver).getNodeList(), nodeName.replace(nodeName, propLoader.prop.getProperty("hostName")));
                scrollToWebElement(driver, element);
                clickonWebElementwithJavaScript(driver, element);
            } else {
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).getAddNewNodeButton());
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add new node button is clicked");
            }
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Values not entered in configuration page", driver);
            Assert.fail("Values not entered in configuration page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" from nodes list$")
    public void user_clicks_on_from_nodes_list(String node) throws Throwable {
        try {
            WebElement element = traverseListContainsElementReturnsElement(new PluginManager(driver).getNodeList(), node);
            synchronizationVisibilityofElement(driver, element);
            clickonWebElementwithJavaScript(driver, element);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), node + " is clicked");
        } catch (Exception e) {
            takeScreenShot(node + " is not clicked", driver);
            Assert.fail(node + " is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user verifies whether \"([^\"]*)\" is present in the plugins list and unassigns it$")
    public void user_verifies_on_from_plugins_list(String plugin) throws Throwable {
        try {
            WebElement assignedPlugin = traverseListContainsElementTextReturnsElement(new PluginManager(driver).assignedPluginList(), plugin);
            if (isElementPresent(assignedPlugin)) {
                scrollToWebElement(driver, assignedPlugin);
                sleepForSec(1000);
                clickOn(assignedPlugin);
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickUnassignPluginButtton());
                sleepForSec(1000);
                clickOn(new SubjectArea(driver).returnAlertYes());
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The plugin is not present in the list");
            }
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), plugin + " is clicked");
        } catch (Exception e) {
            takeScreenShot(plugin + " is not clicked", driver);
            Assert.fail(plugin + " is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user clicks on Delete button in the Edit Node panel$")
    public void user_clicks_on_Delete_button_in_the_Edit_Node_panel() throws Throwable {
        try {
            sleepForSec(2000);
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).deleteNode());
            LoggerUtil.logLoader_info(this.getClass().getName(), "Delete Node button is clicked");
        } catch (Exception e) {
            takeScreenShot("Delete Node button is not clicked", driver);
            Assert.fail("Delete Node button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enables scan HDFS checkbox$")
    public void user_enables_scan_HDFS_checkbox() throws Throwable {
        try {
            clickOn(new PluginManager(driver).getScanHDFS());
            LoggerUtil.logLoader_info(this.getClass().getName(), "Scan HDFS checkbox is enabled");
        } catch (Exception e) {
            takeScreenShot("Scan HDFS checkbox is not enabled", driver);
            Assert.fail("Scan HDFS checkbox is not enabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enter the following values in filter page$")
    public void user_enter_the_following_values_in_filter_page(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                scrollToWebElement(driver, new PluginManager(driver).filterPageTextFields(values.get("filterPageFieldName")));
                enterText(new PluginManager(driver).filterPageTextFields(values.get("filterPageFieldName")), values.get("filterPageFieldValue"));
                if (isElementPresent(new PluginManager(driver).filterPageTextAdd(values.get("filterPageFieldName"))) == true) {
                    clickOn(new PluginManager(driver).filterPageTextAdd(values.get("filterPageFieldName")));
                }
            }
        } catch (Exception e) {
            takeScreenShot("Values not entered in Filter page", driver);
            Assert.fail("Values not entered in Filter page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Given("^user enables auto start checkbox in plugin configuration panel$")
    public void user_enables_auto_start_checkbox_in_plugin_configuration_panel() throws Throwable {
        try {
            sleepForSec(500);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                clickEventonField(driver, new PluginManager(driver).getAutoStartPlugin());
            } else {
                clickOn(new PluginManager(driver).getAutoStartPlugin());
            }
            LoggerUtil.logLoader_info(this.getClass().getName(), "Auto Start checkbox is enabled");
        } catch (Exception e) {
            takeScreenShot("Auto Start checkbox is not enabled", driver);
            Assert.fail("Auto Start checkbox is not enabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enables \"([^\"]*)\" checkbox in plugin configuration panel$")
    public void user_enables_new_auto_start_checkbox_in_plugin_configuration_panel(String arg1) throws Throwable {
        try {
            sleepForSec(500);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                clickEventonField(driver, new PluginManager(driver).getPluginConfigurationCheckbox(arg1));
            } else {
                new PluginManager(driver).clickPluginConfigurationCheckbox(arg1);
            }
            LoggerUtil.logLoader_info(this.getClass().getName(), "checkbox is enabled");
        } catch (Exception e) {
            takeScreenShot("checkbox is not enabled", driver);
            Assert.fail("checkbox is not enabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user enables Enable Query Parser checkbox$")
    public void user_enables_Enable_Query_Parser_checkbox() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                clickEventonField(driver, new PluginManager(driver).getEnableQueryParser());
            } else {
                clickOn(new PluginManager(driver).getEnableQueryParser());
            }
            LoggerUtil.logLoader_info(this.getClass().getName(), "Enable Query Parser checkbox is enabled");
        } catch (Exception e) {
            takeScreenShot("Enable Query Parser checkbox is not enabled", driver);
            Assert.fail("Enable Query Parser checkbox is not enabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^alert message \"([^\"]*)\" about name in plugin configurations should appear$")
    public void alert_message_about_name_in_plugin_configurations_should_appear(String alertName) throws Throwable {

        try {
            sleepForSec(3000);
            clickOn(new PluginManager(driver).getNameFieldAlertMessage());
            pressKey(new PluginManager(driver).getNameFieldAlertMessage(), Keys.BACK_SPACE);
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getNameFieldAlertMessage()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dashboard alert is showing");
            Assert.assertEquals(alertName, getElementText(new PluginManager(driver).getNameFieldAlertMessage()));
        } catch (Exception e) {
            takeScreenShot("Plugin Configuration page Alert is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Plugin Configuration page Alert is not displayed" + e.getMessage());
        }
    }

    @Given("^user select lineage as \"([^\"]*)\" in Lineage Direction dropdown$")
    public void user_select_lineage_as_in_Lineage_Direction_dropdown(String lineageDirection) throws Throwable {
        try {
            sleepForSec(1000);
            clickOn(new PluginManager(driver).getLineageDirectionDropDown());
            clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(new PluginManager(driver).getLineageDirectionList(), lineageDirection));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Lineage is selected in configuration page");
        } catch (Exception e) {
            takeScreenShot("Lineage direction not selected in Checks page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Lineage direction not selected in Checks page" + e.getMessage());
        }
    }

    @Given("^user select the class name \"([^\"]*)\" in checks page$")
    public void user_select_the_class_name_in_checks_page(String className) throws Throwable {
        try {
            clickOn(new PluginManager(driver).getChecksClassDropDown());
            clickOn(traverseListContainsElementReturnsElement(new PluginManager(driver).getChecksClassDropDownList(), className));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Class name is selected in checks page");
        } catch (Exception e) {
            takeScreenShot("Class Name not selected in Checks page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Class Name not selected in Checks page" + e.getMessage());
        }
    }

    @Given("^user enter the following values in checks page$")
    public void user_enter_the_following_values_in_checks_page(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                enterText(new PluginManager(driver).checkPageAttributes(values.get("checksPageFieldName")), values.get("checksPageFieldValue"));
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values are entered in configuration page");
        } catch (Exception e) {
            takeScreenShot("Values not entered in checks page", driver);
            Assert.fail("Values not entered in checks page");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Given("^user clicks Yes on the node delete alert window$")
    public void user_clicks_Yes_on_the_node_delete_alert_window() throws Throwable {
        try {
            clickOn(new PluginManager(driver).getDeleteNodeYes());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Yes button is clicked in alert");
        } catch (Exception e) {
            takeScreenShot("Yes button is not clicked in Delete Node pop up", driver);
            Assert.fail("Yes button is not clicked in Delete Node pop up");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @When("^user clicks the eye open icon displayed under actions in plugin manager panel$")
    public void user_clicks_On_eye_open_icon_displayed_under_actions_in_plugin_manager_panel() {
        try {
            clickOn(new PluginManager(driver).getEyeOpenIcon());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The eye open icon in plugin manager panel is clicked");
        } catch (Exception e) {
            takeScreenShot("The eye open icon in plugin manager panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The eye open icon in plugin manager panel is not clicked" + e.getMessage());
        }
    }

    @Then("^verify \"([^\"]*)\" label is displayed under Plugin controller panel$")
    public void verify_label_displayed_under_plugin_controller_panel(String labelName) {
        try {
            Assert.assertEquals(getElementText(new PluginManager(driver).getPluginConfigurationStatuslable()), labelName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is displayed under Plugin controller panel");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(labelName + " is not displayed under Plugin controller panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(labelName + " is not displayed under Plugin controller panel" + e.getMessage());
        }
    }

    @And("^click on any arrow to expand the plugins$")
    public void user_clicks_On_arrow_to_expand_the_plugins() {
        try {
            clickOn(new PluginManager(driver).getPluginsArrow());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The arrow in plugin configuration status panel is clicked");
        } catch (Exception e) {
            takeScreenShot("The arrow in plugin configuration status panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The arrow in plugin configuration status panel is not clicked" + e.getMessage());
        }
    }

    @And("^verify the Status and Actions are displayed for the plugin configurations$")
    public void verify_the_Status_and_Actions_are_displayed_for_the_plugin_configurations() {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getPluginConfigStatusAndActions()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Status and Actions are displayed for plugin configuration");
        } catch (Exception e) {
            takeScreenShot("Status and Actions are not displayed for plugin configuration", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Status and Actions are not displayed for plugin configuration" + e.getMessage());
        }
    }

    @When("^user clicks the \"([^\"]*)\" node in plugin manager panel$")
    public void user_clicks_the_node_in_plugin_manager_panel(String node) {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).getNode(node));
                sleepForSec(2000);
            } else {
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).getNode(node));
                sleepForSec(2000);
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), node + " is clicked under the plugin manager panel");

        } catch (Exception e) {
            takeScreenShot(node + " is not clicked under the plugin manager panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(node + " is not clicked under the plugin manager panel" + e.getMessage());
        }
    }

    @And("^user sees panel with \"([^\"]*)\" node name on header$")
    public void user_sees_panel_with_selected_node_name_on_header(String nodeName) {
        try {
            Assert.assertEquals(getElementText(new PluginManager(driver).getPanelHeaderName(nodeName)), nodeName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), nodeName + " is displayed on the header in the panel");
        } catch (Exception e) {
            takeScreenShot(nodeName + " is not displayed on the header in the panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(nodeName + " is not displayed on the header in the panel" + e.getMessage());
        }
    }

    @Then("^user clicks on Plugin controller button$")
    public void user_clicks_on_Plugin_controller_button() {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getPluginControllerButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin controller button is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Plugin controller button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Plugin controller button is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks on Add new node Button in Plugin Management page$")
    public void user_clicks_on_Add_new_button_in_Plugin_Management_page() {
        try {

            if (traverseListContainsElementText(new PluginManager(driver).getListOfNodes(), propLoader.prop.getProperty("hostName"))) {
                WebElement element = traverseListContainsElementTextReturnsElement(new PluginManager(driver).getListOfNodes(), propLoader.prop.getProperty("hostName"));
                clickOn(element);
            } else {
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).getAddNewNodeButton());
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add new node button is clicked");
        } catch (Exception e) {
            takeScreenShot("Add new node button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Add new node button is not clicked" + e.getMessage());
        }
    }

    @When("^user enters \"([^\"]*)\" in the name field in New node panel$")
    public void user_enters_text_in_the_name_field(String argu) throws Throwable {
        try {
            enterText(new PluginManager(driver).getNameField(), jsonRead.readJSon(argu, "Name"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), argu + "  entered correctly");
        } catch (Exception e) {
            takeScreenShot(argu + " not entered correctly", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(argu + " not entered correctly" + e.getMessage());

        }
    }

    @And("^user enters the node name \"([^\"]*)\" in the name field$")
    public void user_enters_node_name_in_the_name_field(String argu) throws Throwable {
        try {
            enterText(new PluginManager(driver).getNameField(), argu);
        } catch (Exception e) {
            takeScreenShot(argu + " not entered correctly", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(argu + " not entered correctly" + e.getMessage());

        }
    }

    @Then("^Error message should get displayed as \"([^\"]*)\"$")
    public void error_message_should_be_displayed_as(String arg1) throws Throwable {
        try {
            String actualResult = getElementText(new PluginManager(driver).getSpaceErrorMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1);
            verifyEquals(arg1, actualResult);
            takeScreenShot("Error Message for " + arg1, driver);
        } catch (Exception e) {
            takeScreenShot("Error Message for " + arg1, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Restricted characters Error Message" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Error Message is not found" + e.getMessage());

        }
    }

    @Then("^Error message should get displayed as \"([^\"]*)\" when duplicate node name is given")
    public void error_message_should_be_displayed_when_duplicate_node_name_is_given(String arg1) throws Throwable {
        try {
            String actualResult = getElementText(new PluginManager(driver).getDuplicateNodeNameErrorMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1);
            verifyEquals(arg1, actualResult);
            takeScreenShot("Error Message for Duplicate Node name", driver);
        } catch (Exception e) {
            takeScreenShot("Error Message for Duplicate Node name", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Duplicate Node name Error Message" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Error Message is not found" + e.getMessage());

        }
    }

    @And("^user clicks on save button in the new node panel$")
    public void user_clicks_on_save_button_in_the_new_node_panel() {
        try {
            clickOn(new PluginManager(driver).getNewNodePanelSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The Save button in the new node panel is clicked");
        } catch (Exception e) {
            takeScreenShot("The Save button in the new node panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The Save button in the new node panel is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks on close button in the panel$")
    public void user_clicks_on_close_button_in_the_panel() {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getNewNodePanelCloseButton());
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The Close button in the panel is clicked");
        } catch (Exception e) {
            takeScreenShot("The Close button in the panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The Close button in the panel is not clicked" + e.getMessage());
        }
    }

    @And("^user sees pop up content as \"([^\"]*)\"$")
    public void user_sees_pop_up_content(String popUpContent) {
        try {
            Assert.assertEquals(getElementText(new PluginManager(driver).getPopUpContent()), popUpContent);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), popUpContent + " is displayed");
        } catch (Exception e) {
            takeScreenShot(popUpContent + " is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(popUpContent + " is not displayed" + e.getMessage());
        }
    }

    @And("^user verifies new node panel is \"([^\"]*)\"$")
    public void user_verifies_new_node_panel_is_displayed_or_Not(String displayStatus) throws Throwable {
        try {
            if (displayStatus.equalsIgnoreCase("Displayed")) {
                Assert.assertTrue(new PluginManager(driver).getNewNodePanel().isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "New node panel is displayed");
                takeScreenShot("New node panel is displayed", driver);
            } else if (displayStatus.equalsIgnoreCase("Not Displayed")) {
                Assert.assertFalse(isElementPresent(new PluginManager(driver).getNewNodePanel()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "New node panel is not displayed");
                takeScreenShot("New node panel is not displayed", driver);
            }
        } catch (Exception e) {
            takeScreenShot("New node panel display error", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("New node panel display error" + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies node \"([^\"]*)\" is present in the panel without any change$")
    public void user_verifies_node_is_present_in_the_plugin_manager_panel(String nodeName) throws Throwable {
        try {
            String actualResult = getElementText(new PluginManager(driver).getNode(nodeName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), nodeName);
            verifyEquals(nodeName, actualResult);
            takeScreenShot(nodeName + " is displayed in the plugin manager panel without any change", driver);
        } catch (Exception e) {
            takeScreenShot(nodeName + " is displayed in the plugin manager panel with changes", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is displayed in the plugin manager panel with changes" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(nodeName + " is displayed in the plugin manager panel with changes" + e.getMessage());

        }
    }

    @Then("^user verifies \"([^\"]*)\" label with number of nodes displayed$")
    public void user_verifies_nodes_label_with_number_of_nodes(String nodeLabel) throws Throwable {
        try {
            String labelText = getElementText(new PluginManager(driver).getNodeLabelAndCount());
            Assert.assertTrue(labelText.contains(nodeLabel));
            /*String NodeCount = labelText.substring(labelText.indexOf("(")+1,labelText.indexOf(")"));
            if(Integer.parseInt(NodeCount)> 0)
            //Assert.assertTrue(Integer.parseInt(NodeCount)> 0);*/
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), nodeLabel);
            takeScreenShot(nodeLabel + " label with number of nodes is displayed", driver);
        } catch (Exception e) {
            takeScreenShot(nodeLabel + " label with number of nodes is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeLabel + " label with number of nodes is not displayed" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(nodeLabel + " label with number of nodes is not displayed\n" + e.getMessage());

        }
    }

    @Then("^user \"([^\"]*)\" on \"([^\"]*)\" in Plugin management panel$")
    public void user_clicks_on_plugins_label_in_plugin_management_panel(String actionType, String label) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, label);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clicks on Dataset plugin label in Plugin management panel");
            takeScreenShot("clicks on Dataset plugin label in Plugin management panel", driver);
        } catch (Exception e) {
            takeScreenShot("Not clicked on Dataset plugin label in Plugin management panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Not clicked on Dataset plugin label in Plugin management panel" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Not clicked on Dataset plugin label in Plugin management panel" + e.getMessage());

        }
    }

    @And("^user verifies the existing nodes are listed in Plugin Manager panel$")
    public void user_verifies_the_existing_nodes_are_displayed() throws Throwable {
        try {
            if (new PluginManager(driver).getNodeList().size() > '\0')
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The existing nodes are displayed in Plugin manager panel");
            else
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The nodes are not displayed in Plugin manager panel");
        } catch (Exception e) {
            takeScreenShot("The nodes are not displayed in Plugin manager panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("The nodes are not displayed in Plugin manager panel" + e.getMessage());

        }
    }

    @And("^verify the number of plugins for \"([^\"]*)\" is displayed$")
    public void user_verifies_the_number_of_plugins_displayed(String nodeName) throws Throwable {
        try {
            String pluginCount = getElementText(new PluginManager(driver).getPluginCountOfNode(nodeName));
            if (Integer.parseInt(pluginCount) >= 1)
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The plugins count for nodes are displayed in Plugin manager panel");
            else
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The plugins count for nodes are not displayed in Plugin manager panel");
        } catch (Exception e) {
            takeScreenShot("The plugins count for nodes are not displayed in Plugin manager panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("The plugins count for nodes are not displayed in Plugin manager panel" + e.getMessage());

        }
    }

    @And("^user select \"([^\"]*)\" from Available plugin list$")
    public void user_clicks_on_plugin_from_available_plugin_list(String pluginName) throws Throwable {
        try {
            if (new PluginManager(driver).getPluginsList(pluginName).isDisplayed()) {
                clickOn(new PluginManager(driver).getPluginsList(pluginName));
                sleepForSec(1000);
            } else if (!new PluginManager(driver).getPluginsList(pluginName).isDisplayed()) {
                scrollToWebElement(driver, new PluginManager(driver).getPluginsList(pluginName));
                clickOn(new PluginManager(driver).getPluginsList(pluginName));
            }
        } catch (Exception e) {
            takeScreenShot("Not able to click " + pluginName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not able to click " + pluginName + e.getMessage());
        }
    }

    @And("^user clicks on Assign Button$")
    public void user_clicks_on_Assign_Button() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickAssignButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Assign button is clicked");
        } catch (Exception e) {
            takeScreenShot("Assign button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Assign button is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" under Assigned plugins$")
    public void user_clicks_on_plugin_under_Assigned_Plugins(String plugin) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickPluginUnderAssignButton(plugin));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), plugin + " under Assigned plugin is clicked");
        } catch (Exception e) {
            takeScreenShot(plugin + " under Assigned plugin is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(plugin + " under Assigned plugin is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks on Add button in plugin panel$")
    public void user_clicks_on_Add_button_in_plugin_panel() throws Throwable {
        try {
            clickOn(new PluginManager(driver).clickAddButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add button in plugin panel is clicked");
        } catch (Exception e) {
            takeScreenShot("Add button in plugin panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Add button in plugin panel is not clicked" + e.getMessage());
        }
    }

    @And("^user mouse hovers on i icon near to QUERY field and verifies text \"([^\"]*)\"$")
    public void user_mouse_hovers_on_query_icon_in_plugin_configuration(String mouseHoverText) throws Throwable {
        try {
            scrollToWebElement(driver, new PluginManager(driver).LocateQueryFieldHoverText());
            String actualText = getAttributeValue(new PluginManager(driver).LocateQueryFieldHoverText(), "title");
            Assert.assertEquals(mouseHoverText, actualText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), mouseHoverText + " matched with expected text");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Query hover text doesn't match with expected text");
        }
    }

    @And("^user clicks on Add button near to field \"([^\"]*)\"$")
    public void user_clicks_on_Add_button_inside_Plugin_configuration_panel(String fieldName) throws Throwable {
        try {
            new PluginManagerActions(driver).genericClick("Add button near to field", fieldName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add button inside Plugin configuration panel is clicked");
        } catch (Exception e) {
            takeScreenShot("Add button inside Plugin configuration panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Add button inside Plugin configuration panel is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks the close button inside the field \"([^\"]*)\" panel$")
    public void user_clicks_on_close_button_inside_field_panel(String fieldName) throws Throwable {
        try {
            clickOn(new PluginManager(driver).clickAddButtonInsideFieldPanel(fieldName));
            sleepForSec(1000);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "close button inside Plugin configuration field panel is clicked");
        } catch (Exception e) {
            takeScreenShot("close button inside Plugin configuration field panel is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("close button inside Plugin configuration field panel is not clicked" + e.getMessage());
        }
    }

    @And("^user verifies the label \"([^\"]*)\" in New node panel$")
    public void verify_label_displayed_in_new_node_panel(String labelName) {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getNewNodePanelLabelName(labelName)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is displayed in new node panel");
        } catch (Exception e) {
            takeScreenShot(labelName + " lable is not displayed in new node panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(labelName + " lable is not displayed in new node panel" + e.getMessage());
        }
    }

    @And("^user verifies the catalog selection box is displayed with text \"([^\"]*)\"$")
    public void verify_catalog_selection_box_text_is_displayed(String selectionBoxText) {
        try {
            Assert.assertEquals(getElementText(new PluginManager(driver).getCatalogSelectionBoxText()).trim(), selectionBoxText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), selectionBoxText + " is displayed in the catalog selection box");
        } catch (Exception e) {
            takeScreenShot(selectionBoxText + " is not displayed in the catalog selection box", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(selectionBoxText + " is not displayed in the catalog selection box" + e.getMessage());
        }
    }

    @Then("^list of follwoing Plugins should be available$")
    public void listOfPluginsShouldBeAvailable(List<CucumberDataSet> dataTableCollection) throws Throwable {
        Set<String> setWidgetData = new HashSet<>();
        try {
            for (CucumberDataSet data : dataTableCollection) {
                setWidgetData.add(data.getPluginListFromAvailablePlugins());
            }
            //while (new PluginManager(driver).getPluginList().size() > 0) {
            for (String pluginList : setWidgetData) {
                Iterator setIterate = setWidgetData.iterator();
                String pluginName = setIterate.next().toString();
                traverseListContainsElementText(new PluginManager(driver).getPluginList(), pluginName);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Given Plugin count:  " + setWidgetData.size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All the plugins listed are present");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Given widget list and available widgets are not matching");
            Assert.fail("Widget list from Test Data and Available WidgetList is mismatching" + e.getMessage());
        }
    }

    @And("^user clicks on Plugin checkbox$")
    public void user_clicks_on_Plugin_checkbox() throws Throwable {
        try {
            clickOn(new PluginManager(driver).clickPluginCheckbox());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin checkbox is clicked");
        } catch (Exception e) {
            takeScreenShot("Plugin checkbox is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Plugin checkbox is not clicked" + e.getMessage());
        }
    }

    @Then("^user verifies whether all the checkboxes are selected under Plugins$")
    public void user_verifiea_whether_all_the_plugins_are_displayed() throws Throwable {
        try {
            for (WebElement checkbox : new PluginManager(driver).getAvailablePluginsCheckBox()) {
                checkbox.isSelected();
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All the plugin checkboxes are Selected");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Plugins checkboxes are not selected properly");
            Assert.fail("Plugins checkboxes are not selected properly" + e.getMessage());
        }
    }

    @And("^user verifies the available plugins table is empty$")
    public void user_verifies_that_available_plugins_table_is_empty() throws Throwable {
        try {
            Assert.assertFalse(isElementPresent(new PluginManager(driver).getEmptyPluginList()));
            takeScreenShot("Available plugins table is empty", driver);
        } catch (Exception e) {
            takeScreenShot("Available plugins table is not empty", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Available plugins table is not empty" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Available plugins table is not empty" + e.getMessage());

        }
    }

    @And("^verify all the plugins are displayed under assigned plugins$")
    public void verify_all_the_plugins_are_displayed_under_assigned_plugins() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getAssignedPluginList()));
            takeScreenShot("Plugins are displayed under assigned plugins", driver);
        } catch (Exception e) {
            takeScreenShot("Plugins are not displayed under assigned plugins", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Plugins are not displayed under assigned plugins" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Plugins are not displayed under assigned plugins" + e.getMessage());

        }
    }

    @And("^user verifies the plugin count for node \"([^\"]*)\" is displayed as \"([^\"]*)\"$")
    public void user_verifies_the_pluginC_count_displayed(String nodeName, String count) throws Throwable {
        try {
            String pluginCount = getElementText(new PluginManager(driver).getPluginCountOfNode(nodeName));
            if (pluginCount.equals(count))
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), count + " is disaplyed as the plugin count for the node " + nodeName);
        } catch (Exception e) {
            takeScreenShot(count + " is not disaplyed as the plugin count for the node " + nodeName, driver);
        }
    }

    @And("^user verifies the node \"([^\"]*)\" is displayed under NODES list$")
    public void user_verifies_the_node_from_list_of_nodes(String nodeName) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(traverseListContainsElementReturnsElement(new PluginManager(driver).getNodeList(), nodeName)));
        } catch (Exception e) {
            takeScreenShot(nodeName + " is not displayed under NODES list", driver);
            Assert.fail(nodeName + " is not displayed under NODES list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies Plugin Controller icon is not displayed for the node \"([^\"]*)\"$")
    public void user_verifies_that_the_plugin_controller_icon_not_displayed_for_the_Node(String nodeName) throws Throwable {
        try {
            Assert.assertFalse(isElementPresent(new PluginManager(driver).getPluginControllerIcon()));
            takeScreenShot("Plugin Controller icon is not displayed for the node " + nodeName, driver);
        } catch (Exception e) {
            takeScreenShot("Plugin Controller icon is displayed for the node " + nodeName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Plugin Controller icon is displayed for the node " + nodeName + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Plugin Controller icon is displayed for the node " + nodeName + e.getMessage());

        }
    }

    @Given("^user clicks on x button for any of the plugin under assigned plugins$")
    public void user_clicks_on_x_button_under_assigned_plugin() throws Throwable {
        try {
            clickOn(new PluginManager(driver).clickAssingedPluginCloseButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "x button under assigned plugins is clicked");
        } catch (Exception e) {
            takeScreenShot("x button under assigned plugins is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("x button under assigned plugins is not clicked" + e.getMessage());
        }
    }

    @And("^user verifies the node \"([^\"]*)\" is not displayed under NODES list$")
    public void user_verifies_the_node_is_not_displayed_from_list_of_nodes(String nodeName) throws Throwable {
        try {
            WebElement Nodename = traverseListContainsElementReturnsElement(new PluginManager(driver).getNodeList(), nodeName);
            sleepForSec(2000);
            Assert.assertFalse(isElementPresent(Nodename));
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot(nodeName + " is displayed under NODES list", driver);
            Assert.fail(nodeName + " is displayed under NODES list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks on Unassign Plugin Button$")
    public void user_clicks_on_Unassign_Button() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickUnassignPluginButtton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Unassign plugin button is clicked");
        } catch (Exception e) {
            takeScreenShot("Unassign plugin button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Unassign plugin button is not clicked" + e.getMessage());
        }
    }

    @And("^user verifies configuration panel is \"([^\"]*)\"$")
    public void user_verifies_configuration_panel_is_displayed_or_Not(String displayStatus) throws Throwable {
        try {
            if (displayStatus.equalsIgnoreCase("Displayed")) {
                Assert.assertTrue(new PluginManager(driver).getConfigurationPanel().isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Configuration panel is displayed");
                takeScreenShot("Configuration panel is displayed", driver);
            } else if (displayStatus.equalsIgnoreCase("Not Displayed")) {
                Assert.assertFalse(isElementPresent(new PluginManager(driver).getConfigurationPanel()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Configuration panel is not displayed");
                takeScreenShot("New node panel is not displayed", driver);
            }
        } catch (Exception e) {
            takeScreenShot("Configuration panel display error", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Configuration panel display error" + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user verifies that unassigned plugin \"([^\"]*)\" is not displayed in the Assigned plugins section")
    public void user_verifies_that_unassigned_plugin_is_not_displayed_under_Assigned_plugins(String pluginName) throws Throwable {
        try {
            Assert.assertFalse(traverseListContainsElement(new PluginManager(driver).assignedPluginList(), pluginName));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), pluginName + " plugin is not displayed under assigned plugin");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(pluginName + " plugin is displayed under assigned plugin", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(pluginName + " plugin is not displayed under assigned plugin" + e.getMessage());
        }
    }

    @And("^user verifies the plugin \"([^\"]*)\" is displayed under Available plugin list$")
    public void user_verifies_the_plugin_is_displayed_under_available_plugins(String pluginName) throws Throwable {
        try {
            WebElement plugin = traverseListContainsElementTextReturnsElement(new PluginManager(driver).getPluginList(), pluginName);
            Assert.assertTrue(isElementPresent(plugin));
        } catch (Exception e) {
            takeScreenShot(pluginName + " is not displayed under available plugins list", driver);
            Assert.fail(pluginName + " is not displayed under available plugins list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^user clicks on plugin monitor icon for Node \"([^\"]*)\"$")
    public void user_clicks_on_Plugin_controller_button(String nodeName) {
        try {
            if (nodeName.equalsIgnoreCase("hostName")) {
                clickOn(new PluginManager(driver).getpluginManagerHamburgerMenu(nodeName.replace(nodeName, propLoader.prop.getProperty("hostName"))));
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickPluginMonitorIcon(nodeName.replace(nodeName, propLoader.prop.getProperty("hostName"))));
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "plugin monitor icon is clicked");
                takeScreenShot(this.getClass().getSimpleName(), driver);
            } else {
                clickOn(new PluginManager(driver).getpluginManagerHamburgerMenu(nodeName));
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickPluginMonitorIcon(nodeName));
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "plugin monitor icon is clicked");
                takeScreenShot(this.getClass().getSimpleName(), driver);
            }
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("plugin monitor icon is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("plugin monitor icon is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" button for \"([^\"]*)\" Plugin$")
    public void user_clicks_on_button(String pluginMonitorStatus, String pluginName) {
        try {
            sleepForSec(5000);
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickStartButton(pluginName, pluginMonitorStatus.toUpperCase()));
            } else {
                clickOn(new PluginManager(driver).clickStartButton(pluginName, pluginMonitorStatus.toUpperCase()));
            }
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Start button is clicked");
        } catch (Exception e) {
            takeScreenShot("Start button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Start button is not clicked" + e.getMessage());
        }
    }

    @And("^user verifies the following in the Plugin monitor$")
    public void user_verifies_the_status_of_the_plugin(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                String pluginName = values.get("pluginName");
                String status = values.get("status");

                Thread.sleep(12000);
                scrollToWebElement(driver, new PluginManager(driver).getPluginMonitorStatus(pluginName, status));
                Assert.assertEquals(getElementText(new PluginManager(driver).getPluginMonitorStatus(pluginName, status)).trim(), values.get("status"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The status of the plugin is " + values.get("status"));
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Error in displaying the plugin status" + e.getMessage());
        }
    }

    @And("^user clicks on the first link from the \"([^\"]*)\" widget$")
    public void user_clicks_on_first_link_from_the_widget(String widgetName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickOnAnanlysisFirstLink(widgetName));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), widgetName + " first link is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(widgetName + " first link is not clicked" + e.getMessage());
        }
    }

    @And("^user verifies the METADATA errors is displayed as \"([^\"]*)\"$")
    public void user_verifies_the_METADATA_errors_is_displayed(String count) {
        try {
            sleepForSec(2000);
            synchronizationVisibilityofElement(driver, new PluginManager(driver).getMetadataErrorsCount());
            Assert.assertEquals(getElementText(new PluginManager(driver).getMetadataErrorsCount()).trim(), count);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The metadata error count is " + count);
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The metadata error count is " + count + e.getMessage());
        }
    }

    @And("^user clicks on the log under HAS_FILE$")
    public void user_clicks_on_the_log_under_HAS_FILE() throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                moveToElementUsingJavaScript(driver, new PluginManager(driver).clickLogLink());
            }
            sleepForSec(500);
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickLogLink());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Log link under HAS_FILE is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Log link under HAS_FILE is clicked" + e.getMessage());
        }
    }

    @And("^user clicks on the configuration Name \"([^\"]*)\"$")
    public void user_clicks_on_the_configuration_name(String pluginName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).clickConfigurationName(pluginName));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Configuration name is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Configuration name is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Configuration name is not clicked" + e.getMessage());
        }
    }

    @And("^user mouse hovers the help icon in plugin configuration fields$")
    public void user_mouse_hovers_on_help_icon_in_Plugin_Configuration_fields(DataTable data) throws Throwable {
        try {

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                scrolltoElement(driver,new ItemViewManagement(driver).widgetToolTip(values.get("pluginConfigFieldName")), true);
                moveToElementWithActions(driver, new ItemViewManagement(driver).widgetToolTip(values.get("pluginConfigFieldName")));

                String actualText = getElementText(new PluginManager(driver).getMouseHoverTextForPluginField(values.get("pluginConfigFieldName"))).trim();
                Assert.assertEquals(values.get("mouseHoverText").trim(), actualText);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("mouseHoverText") + " hover text matched with expected text");
                waitForAngularLoad(driver);
            }
        } catch (Exception e) {
            takeScreenShot("Hover text doesn't matched with expected text", driver);
            Assert.fail("Hover text doesn't matched with expected text");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @And("^user verifies the validation message is displayed under the Plugin configuration fields$")
    public void user_verifies_validation_message_is_displayed_under_the_Plugin_configuration_fields(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                scrollToWebElement(driver, new PluginManager(driver).getFieldTextBoxByPage(values.get("pluginConfigFieldName"), values.get("pageName")));
                sleepForSec(1000);

                enterText(new PluginManager(driver).getFieldTextBoxByPage(values.get("pluginConfigFieldName"), values.get("pageName")), "a");

                //enterTextWithJavaScript(driver, "a", new PluginManager(driver).getFieldTextBoxByPage(values.get("pluginConfigFieldName"),values.get("pageName")));
                pressKey(new PluginManager(driver).getFieldTextBoxByPage(values.get("pluginConfigFieldName"), values.get("pageName")), Keys.BACK_SPACE);
                sleepForSec(1000);
                scrollToWebElement(driver, new PluginManager(driver).getFieldValidationMesssageByPage(values.get("pluginConfigFieldName"), values.get("pageName")));


                String actualText = getElementText(new PluginManager(driver).getFieldValidationMesssageByPage(values.get("pluginConfigFieldName"), values.get("pageName")));
                //Assert.assertEquals(values.get("validationMessage").replaceAll("\\s",""),actualText.replaceAll("\\s",""));
                Assert.assertEquals(values.get("validationMessage").trim(), actualText.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("pluginConfigFieldName") + " validation message is displayed under the field");

            }
        } catch (Exception e) {
            takeScreenShot("validation message is not displayed under the field", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("validation message is not displayed under the field" + e.getMessage());
        }
    }

    @And("^user verifies the validation message is displayed under the Plugin configuration fields for duplicate node$")
    public void user_verifies_validation_message_is_displayed_under_the_Plugin_configuration_fields_for_Duplicate_node(DataTable data) {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                String actualText = getElementText(new PluginManager(driver).getFieldValidationMesssage(values.get("pluginConfigFieldName")));
                //Assert.assertEquals(values.get("validationMessage").replaceAll("\\s",""),actualText.replaceAll("\\s",""));
                Assert.assertEquals(values.get("validationMessage").trim(), actualText.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("pluginConfigFieldName") + " validation message is displayed under the field");

            }
        } catch (Exception e) {
            takeScreenShot("validation message is not displayed under the field", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("validation message is not displayed under the field" + e.getMessage());
        }
    }

//    @And("^user verifies the following in the QuickStart dashboard$")
//    public void user_verifies_the_values_in_QuickStart_Dashboard(DataTable data) throws Throwable {
//        try {
//            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
//
//                if(values.get("action").equalsIgnoreCase("verify")) {
//                    Assert.assertTrue(isElementPresent(new PluginManager(driver).getAnalysisRunResult(values.get("widget").toUpperCase(),values.get("plugin"))));
//                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Run result displayed under Analysis widget");
//                }else if(values.get("action").equalsIgnoreCase("click")) {
//                    clickonWebElementwithJavaScript(driver,new PluginManager(driver).getAnalysisRunResult(values.get("widget").toUpperCase(),values.get("plugin")));
//                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Run result displayed under Analysis widget is clicked");
//                }
//
//            }
//            sleepForSec(500);
//            takeScreenShot("Run result is  displayed under the widget", driver);
//        } catch (Exception e) {
//            takeScreenShot("Error is displaying run result under the widget", driver);
//            Assert.fail("Error is displaying run result under the widget");
//            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
//        }
//
//    }

    @And("^user clicks on \"([^\"]*)\" under Filters in Plugin configuration panel$")
    public void user_clicks_under_Filters_in_Plugin_configuration_panel(String filterName) throws Throwable {
        try {
            scrollToWebElement(driver, new PluginManager(driver).getFilters(filterName));
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getFilters(filterName));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), filterName + " filter is clicked");
        } catch (Exception e) {
            takeScreenShot(filterName + " filter is not clicked", driver);
            Assert.fail(filterName + " filter is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies whether the \"([^\"]*)\" button is \"([^\"]*)\" for \"([^\"]*)\" Plugin$")
    public void user_verifies_whether_the_button_is_enabled(String pluginMonitorStatus, String status, String plugin) {
        try {
            if (status.equalsIgnoreCase("enabled")) {
                sleepForSec(1000);
                waitandFindElement(driver, new PluginManager(driver).clickStartButton(plugin, pluginMonitorStatus.toUpperCase()), 3, true);
                Assert.assertTrue(new PluginManager(driver).clickStartButton(plugin, pluginMonitorStatus.toUpperCase()).isEnabled());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginMonitorStatus + " button is enabled");
                takeScreenShot(pluginMonitorStatus + " is enabled", driver);
            } else {
                sleepForSec(3000);
                Assert.assertFalse(isElementEnabled(new PluginManager(driver).clickStartButton(plugin, pluginMonitorStatus.toUpperCase())));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginMonitorStatus + " button is disabled");
                takeScreenShot(pluginMonitorStatus + " is disabled", driver);
            }
        } catch (Exception e) {
            takeScreenShot("Error in displaying the status of the plugin", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Error in displaying the status of the plugin" + e.getMessage());
        }
    }

    @And("^user clicks on home button from Plugin_Management$")
    public void user_clicks_on_home_button_from_plugin_mangement() throws Throwable {

        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getHomeButton());
            refresh(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on home button");
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(2000);
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Clicked on home button", driver);
        }

    }

    @And("^user removes the database in Filters page in Plugin configuration$")
    public void user_removes_the_database_in_Filters_page_in_Plugin_configuration() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getdataBaseInFiltersPage());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database is removed under filters page in Plugin configuration");
        } catch (Exception e) {
            takeScreenShot("Database is not removed", driver);
            Assert.fail("Database is not removed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks the catalog under the Filters and delete it$")
    public void user_clicks_the_catalog_under_the_Filters_and_delete_it() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getcatalogUnderFilters());
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new PluginManager(driver).getDeleteButtonInFiltersPage());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database is removed under filters page in Plugin configuration");
        } catch (Exception e) {
            takeScreenShot("Database is not removed", driver);
            Assert.fail("Database is not removed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user removes the database if already present in filters panel$")
    public void user_removes_the_database_if_already_present_in_filters_panel() throws Throwable {
        try {
            if (new PluginManager(driver).getDatabaseRemoveButton().isDisplayed()) {
                clickonWebElementwithJavaScript(driver, new PluginManager(driver).getDatabaseRemoveButton());
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database is removed");
            }
        } catch (Exception e) {
            takeScreenShot("Database is not removed", driver);
            Assert.fail("Database is not removed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user enters \"([^\"]*)\" text field as \"([^\"]*)\"$")
    public void user_enters_label_name_selects_expression_type_and_enters_expression(String fieldName, String fieldValue) throws Throwable {
        try {

            enterText(new PluginManager(driver).getFileFiltersInput(fieldName), fieldValue);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), fieldName + " is entered");

        } catch (Exception e) {
            takeScreenShot(fieldName + " is not entered", driver);
            Assert.fail(fieldName + " is not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user selects \"([^\"]*)\" from simple or regular expression$")
    public void user_selects_from_type_dropdown_box(String typeValue) throws Throwable {
        try {
            clickOn(new PluginManager(driver).getexpressionType());
            clickOn(traverseListContainsElementReturnsElement(new PluginManager(driver).getExpressionTypeList()
                    , typeValue));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), typeValue + "has been choosen");
        } catch (Exception e) {
            takeScreenShot("Query Text Could not be choosen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("queryText is not choosen and alert is still showing" + e.getMessage());
        }
    }

    @Then("^user validates the label in the node configuration panel$")
    public void label_should_be_displayed_under_node_configuration_panel(List<CucumberDataSet> dataTableCollection) {
        try {

            for (CucumberDataSet data : dataTableCollection) {
                Assert.assertTrue(isElementPresent(new PluginManager(driver).getLabelsInConfigurationPanel(data.getConfigurationPanelLabelList())));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Label is displayed under node configuration panel");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Label is not displayed under node configuration panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Label is not displayed under node configuration panel" + e.getMessage());
        }
    }

    @And("^user selects the following values in the Node monitor panel$")
    public void user_selects_the_following_values_in_the_Node_monitor_panel(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    sleepForSec(3000);
                    clickonWebElementwithJavaScript(driver, new PluginManager(driver).getConfigurationPanelDropDown(values.get("configurationPluginField")));
                    sleepForSec(3000);
                    clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(new PluginManager(driver).getConfigurationDropDownValue(), values.get("configurationFieldValue")));
                    sleepForSec(2000);

                } else if (values.get("configurationFieldValue").equalsIgnoreCase("IDLE")) {
                    clickonWebElementwithJavaScript(driver, new PluginManager(driver).getConfigurationPanelDropDown(values.get("configurationPluginField")));
                    clickOn(traverseListContainsElementReturnsElement(new PluginManager(driver).getConfigurationDropDownValue(), values.get("configurationFieldValue")));
                } else if (values.get("configurationFieldValue").equalsIgnoreCase("RUNNING")) {
                    clickonWebElementwithJavaScript(driver, new PluginManager(driver).getConfigurationPanelDropDown(values.get("configurationPluginField")));
                    clickOn(traverseListContainsElementReturnsElement(new PluginManager(driver).getConfigurationDropDownValueForStatus(), values.get("configurationFieldValue")));
                } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                    clickonWebElementwithJavaScript(driver, new PluginManager(driver).getConfigurationPanelDropDown(values.get("configurationPluginField")));
                    sleepForSec(1000);
                    clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(new PluginManager(driver).getConfigurationDropDownValue(), values.get("configurationFieldValue")));
                } else {
                    clickonWebElementwithJavaScript(driver, new PluginManager(driver).getConfigurationPanelDropDown(values.get("configurationPluginField")));
                    clickOn(traverseListContainsElementReturnsElement(new PluginManager(driver).getConfigurationDropDownValue(), values.get("configurationFieldValue")));
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), values.get("configurationPluginField") + " is selected from the drop down");
                takeScreenShot(this.getClass().getSimpleName(), driver);
            }
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Error in selecting the value", driver);
            Assert.fail("Error in selecting the value");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^verify \"([^\"]*)\" node name is displayed under node configuration panel$")
    public void node_name_should_be_displayed_under_node_configuration_panel(String nodeName) {
        try {
            String actualNodeName = getElementText(new PluginManager(driver).getConfigPanelNodeName());
            Assert.assertTrue(actualNodeName.equalsIgnoreCase(nodeName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), nodeName + " is displayed under node configuration panel");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(nodeName + " is not displayed under node configuration panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(nodeName + " is not displayed under node configuration panel" + e.getMessage());
        }
    }

    @And("^user verifies the displayed plugin list with \"([^\"]*)\" type$")
    public void user_verifies_the_displayed_plugin_with_type_selected(String typeName) throws Throwable {
        try {
            Assert.assertTrue(traverseListContainsElement(new PluginManager(driver).getDisplayedPluginList(), typeName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), typeName + " type with plugin name is displayed under node configuration panel");
            takeScreenShot(typeName + " type with plugin name is displayed under node configuration panel", driver);
        } catch (Exception e) {
            takeScreenShot("Error in displaying the type with plugin name", driver);
            Assert.fail("Error in displaying the type with plugin name");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies the displayed plugin list with \"([^\"]*)\" Status$")
    public void user_verifies_the_displayed_plugin_with_status_selected(String statusName) throws Throwable {
        try {
            for (WebElement element : new PluginManager(driver).getDisplayedPluginStatusList()) {
                Assert.assertTrue(getElementText(element).equalsIgnoreCase(statusName));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), statusName + " status with plugin is displayed under node configuration panel");
            takeScreenShot(statusName + " status with plugin is displayed under node configuration panel", driver);
        } catch (NoSuchElementException el) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), el.getMessage());
        } catch (Exception e) {
            takeScreenShot("Error in displaying the status with plugin", driver);
            Assert.fail("Error in displaying the status with plugin");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies the \"([^\"]*)\" field is read only$")
    public void user_verifies_the_fields_are_read_only(String fieldValue) throws Throwable {
        try {
            String actualText = getAttributeValue(new PluginManager(driver).getPluginNameAndPluginType(fieldValue), "class");
            Assert.assertTrue(actualText.contains("rea"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), fieldValue + " is disabled");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(fieldValue + " is not disabled", driver);
            Assert.fail(fieldValue + " is not disabled");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies the status \"([^\"]*)\" for the node \"([^\"]*)\"$")
    public void user_verifies_the_status_for_the_node(String status, String nodeName) throws Throwable {
        String actualText = "";
        try {
            if (nodeName.equalsIgnoreCase("hostName")) {
                actualText = getElementText(new PluginManager(driver).getNodeStatus(nodeName.replace(nodeName, propLoader.prop.getProperty("hostName"))));
            } else {
                actualText = getElementText(new PluginManager(driver).getNodeStatus(nodeName));
            }
            Assert.assertTrue(actualText.equalsIgnoreCase(status));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), status + " is displayed for the node " + nodeName);
            takeScreenShot(status + " is displayed for the node " + nodeName, driver);
        } catch (Exception e) {
            takeScreenShot("Error in displaying the status for the plugin", driver);
            Assert.fail("Error in displaying the status for the plugin");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verifies the count for the status \"([^\"]*)\"$")
    public void user_get_the_count_of_total_notifications(String statusName) throws Throwable {
        try {
            commonUtil.storeText(getElementText(new PluginManager(driver).getStatusCount(statusName)));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), statusName + " status count is stored in temporary variable");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), statusName + " status count is not displayed");
            takeScreenShot(statusName + " status count is not displayed", driver);

        }
    }

    @And("^Status for \"([^\"]*)\" count should be changed when plugin starts$")
    public void Status_for_count_should_be_changed_when_plugin_starts(String statusName) throws Throwable {
        try {
            int statusCount = Integer.parseInt(CommonUtil.getText());
            int currentStatusCount = Integer.parseInt(new PluginManager(driver).getStatusCount(statusName).getText());
            Assert.assertNotSame(statusCount, currentStatusCount);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "status count has changed");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "count doesn't changed for " + statusName);
            takeScreenShot("count doesn't changed for " + statusName, driver);

        }
    }

    @And("^user gets the plugin count from the node list for \"([^\"]*)\"$")
    public void user_gets_plugin_count_from_node_list_for_Node(String nodeName) throws Throwable {
        try {
            commonUtil.storeText(getElementText(new PluginManager(driver).getPluginCount(nodeName)));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " count is stored in temporary variable");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " status count is not displayed");
            takeScreenShot(nodeName + " count is not displayed", driver);
        }
    }

    @And("^user verifies that both the plugins count and displayed plugins in monitor panel are same$")
    public void user_verifies_that_both_the_plugins_count_and_displayed_plugins_in_monitor_panel_are_same() throws Throwable {
        try {
            Assert.assertEquals(new PluginManager(driver).getDisplayedPluginCount().size(), Integer.parseInt(CommonUtil.getText()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin count : " + CommonUtil.getText() + "are same");
            takeScreenShot("Plugin count is matching", driver);
        } catch (Exception e) {
            takeScreenShot("Plugin count is not matching", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Plugin count is not matching" + e.getMessage());

        }
    }

    @And("^user verifies that the monitor panel should be empty$")
    public void user_verifies_that_the_monitor_panel_should_be_empty() throws Throwable {
        try {
            Assert.assertEquals(new PluginManager(driver).getDisplayedPluginCount().size(), 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The monitor panel is empty");
            takeScreenShot("The monitor panel is empty", driver);
        } catch (Exception e) {
            takeScreenShot("The monitor panel is not empty", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The monitor panel is not empty" + e.getMessage());

        }
    }

    @And("^user clicks on the apply button$")
    public void userClicksOnTheApplyButton() throws Throwable {
        try {
            clickOn(new PluginManager(driver).getApplyButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Apply button has been clicked");
        } catch (Exception e) {
            takeScreenShot("Apply button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Apply button is not clicked" + e.getMessage());
        }
    }

    @Given("^user removes \"([^\"]*)\" plugin from node list$")
    public void user_removes_plugin_from_node_list(String pluginName) throws Throwable {
        try {
            clickOn(new PluginManager(driver).removePluginFromNode(pluginName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginName + " Plugin is removed");
        } catch (Exception e) {
            takeScreenShot(pluginName + " Plugin is not removed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(pluginName + " Plugin is not removed" + e.getMessage());
        }
    }

    @And("^user enters text in the dynamic field and verifies whether Horizontal scroll will be displayed$")
    public void userEntersTextInTheDynamicFieldAndVerifiesWhetherHorizontalScrollWillBeDisplayed() throws Throwable {
        try {
            new PluginManagerActions(driver).enterActions("dynamic field", Constant.DYNAMIC_FIELD_INPUT_TEXT);
            new PluginManagerActions(driver).genericVerifyElementPresent("dynamic scroll bar");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verified scroll bar display");
        } catch (Exception e) {
            takeScreenShot("Scroll bar is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Scroll bar is not displayed" + e.getMessage());
        }
    }

    @And("^user click on Analysis plugin label and navigate to \"([^\"]*)\" from the available plugin list in Plugin Manager$")
    public void userOnFromTheAvailableAnalysisPluginList(String pluginName) throws Throwable {
        try {
            new PluginManagerActions(driver).clickAnalysisPluginFromList(pluginName);
            sleepForSec(3000);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Navigated to the plugin");
        } catch (Exception e) {
            takeScreenShot("Issue in selecting the plugin", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Issue in selecting the plugin" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in Plugin Configuration panel in Plugin manger$")
    public void userOnInPluginConfigurationPanel(String actionType, String settingOption) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, settingOption);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "cliked on " + settingOption);
        } catch (Exception e) {
            takeScreenShot("Not cliked on " + settingOption, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not cliked on " + settingOption + e.getMessage());
        }
    }

    @And("^user selects \"([^\"]*)\" catalog from the dropdown in the Plugin configuration panel in Plugin manager$")
    public void userSelectsCatalogFromTheDropdownInThePluginConfigurationPanelInPluginManager(String catalogName) throws Throwable {
        try {
            new PluginManagerActions(driver).selectCatalogFromTheList(catalogName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clicked on " + catalogName);
        } catch (Exception e) {
            takeScreenShot("Not clicked on " + catalogName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not clicked on " + catalogName + e.getMessage());
        }
    }

    @Given("^user \"([^\"]*)\" on \"([^\"]*)\" tab in \"([^\"]*)\" page$")
    public void user_on_tab_in_page(String actionType, String elementName, String dynamicItem) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, elementName, dynamicItem);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), elementName + " is clicked");
        } catch (Exception e) {
            takeScreenShot("element name" + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("element name" + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), elementName + " is not clicked");
        }
    }

    @Given("^user \"([^\"]*)\" to \"([^\"]*)\" configuration for \"([^\"]*)\" Plugin in Plugin Manager page$")
    public void user_to_configuration_for_Plugin_in_Plugin_Manager_page(String actionType, String pluginConfig, String pluginName) throws Throwable {
        try {
            new PluginManagerActions(driver).navigateToPluginConfigPage(actionType, pluginName, pluginConfig);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginName + "page is displayed");
        } catch (Exception e) {
            takeScreenShot(pluginName + "page is displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(pluginName + "page is displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), pluginName + "page is displayed");
        }
    }


    @Then("^user \"([^\"]*)\" for below parameters in Plugin Configuration page$")
    public void user_for_below_parameters_in_Plugin_Configuration_page(String actionType, DataTable dataTable) throws Throwable {
        try {
            if (actionType.equals("Verify tool tip message presence")) {
                new PluginManagerActions(driver).validateValuesInMap(actionType, dataTable.asMap(String.class, String.class));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
            } else {
                new PluginManagerActions(driver).validatePluginConfigErrorMessage(actionType, dataTable.asMaps(String.class, String.class));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
            }
        } catch (Exception e) {
            takeScreenShot("Element not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Element not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Element not displayed");
        }
    }

    @Given("^user \"([^\"]*)\" on \"([^\"]*)\" plugin in Plugin Manager list page$")
    public void user_on_plugin_in_Plugin_Manager_list_page(String actionType, String pluginName) throws Throwable {
        try {
            new PluginManagerActions(driver).navigateToPluginConfigPage(actionType, pluginName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginName + "page is displayed");
        } catch (Exception e) {
            takeScreenShot(pluginName + "page is displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(pluginName + "page is displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), pluginName + "page is displayed");
        }
    }

    @Given("^user \"([^\"]*)\" to \"([^\"]*)\" plugin config list in Plugin Manager page$")
    public void user_to_plugin_config_list_in_Plugin_Manager_page(String actionType, String pluginName) throws Throwable {
        try {
            new PluginManagerActions(driver).navigateToPluginConfigListPage(actionType, pluginName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginName + "page is displayed");
        } catch (Exception e) {
            takeScreenShot(pluginName + "page is displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(pluginName + "page is displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), pluginName + "page is displayed");
        }
    }

    @And("^user click on Analysis plugin label and navigates to valdiate Show Advanced Settings option is present$")
    public void show_advanced_setting_validation_for_all_plugin() throws Throwable {
        try {
            new PluginManager(driver).advancedsettingvalidationforallplugin();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Node condition validation successful");
        } catch (Exception e) {
            takeScreenShot("Issue in selecting the plugin", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Issue in Node condition validation" + e.getMessage());
        }
    }


    @And("^user click on Analysis plugin label and navigates to valdiate Show Advanced Settings option is not present$")
    public void dontshow_advanced_setting_validation_for_all_plugin() throws Throwable {
        try {
            new PluginManager(driver).datasetvalidationforallplugin();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Node condition is not present");
        } catch (Exception e) {
            takeScreenShot("Issue in selecting the plugin", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Issue in Node condition validation" + e.getMessage());
        }
    }

    @And("^user verifies invalid \"([^\"]*)\" expresssion is not allowed$")
    public void invalid_expression_validation(String errorcondition) throws Throwable {
        try {
            new PluginManager(driver).nodeinvalidexpressionvalidation(errorcondition);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "invalid expression is present in Node field");
        } catch (Exception e) {
            takeScreenShot("Issue when validation invalid expression message", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Issue when validation invalid expression message" + e.getMessage());
        }
    }


    @Then("^user \"([^\"]*)\" in Plugin Configuration page$")
    public void user_in_Plugin_Configuration_page(String actionType, DataTable dataTable) throws Throwable {
        try {
            new PluginManagerActions(driver).validatePluginConfigCaptions(actionType, dataTable.asList(String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            takeScreenShot("Values does not match", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Values does not match" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values does not match");
        }
    }


    @And("^user \"([^\"]*)\" plugin \"([^\"]*)\" in \"([^\"]*)\" of Plugin Manager page$")
    public void userPluginInOfPluginManagerPage(String actionType, String pluginName, String elementName) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions("click","ANALYSIS PLUGINS");
          new PluginManagerActions(driver).genericActions(actionType,elementName,pluginName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Element is not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Element is not displayed");
        }
    }
   /*
    10.3 New UI step definitions
     */

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in Manage Configurations panel$")
    public void userOnInManageConfigurationPanel(String actionType, String settingOption) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, settingOption);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "cliked on " + settingOption);
        } catch (Exception e) {
            takeScreenShot("Not cliked on " + settingOption, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not cliked on " + settingOption + e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" is \"([^\"]*)\" in Manage Configurations panel$")
    public void userVerifiesInManageConfigurationPanel(String settingOption, String actionType) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, settingOption);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "cliked on " + settingOption);
        } catch (Exception e) {
            takeScreenShot("Not cliked on " + settingOption, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not cliked on " + settingOption + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Manage Configurations panel$")
    public void userEnterTextInManageConfigurationPanel(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).genericActions(actionType, values.get("TextBox"), values.get("Text"));
            }
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Entered text in textbox");
        } catch (Exception e) {
            takeScreenShot("Entered text in Textbox", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not entered text in textbox" + e.getMessage());
        }
    }

    @And("^user performs \"([^\"]*)\" operation in Manage Configurations panel$")
    public void userPerformsFollowingInManageConfigurationPanel(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).genericActions(actionType, values.get("button"), values.get("actionItem"), values.get("attribute"), values.get("itemName"));
            }
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+ "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+ "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+ "is not performed" + e.getMessage());
        }
    }

    @And("^user verifies whether following parameters is \"([^\"]*)\" in Manage Configurations panel$")
    public void userVerifiesollowingInManageConfigurationPanel(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).pluginConfigurationsPageConfigurations(actionType, values.get("button"), values.get("pluginName"));
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

    @Then("^user \"(.*)\" of following \"([^\"]*)\" in Manage Configurations Page$")
    public void user_in_Manage_Configurations_page(String actionType, String actionToBeVerified, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new PluginManagerActions(driver).validateElementsInManageConfigPage(actionType, actionToBeVerified, dataTable.asList(String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            takeScreenShot("Values does not match", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Values does not match" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values does not match");
        }
    }

    @And("^user selects dropdown in Manage Configurations panel$")
    public void userSelectsFromManageConfigurationPanel(DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).selectAttributeFromTheFilterDropdown(values.get("filterName"), values.get("attribute"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dropdown option is performed");
        } catch (Exception e) {
            takeScreenShot("Dropdown option is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }

    @And("^user verifies the status of the deployment in Manage Configurations panel$")
    public void userVerifiesStatusFromManageConfigurationPanel(DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).getPluginConfigurationStatusForDeployment(values.get("pluginName"), values.get("status"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "cliked operation is performed");
        } catch (Exception e) {
            takeScreenShot("cliked operation is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" button under \"([^\"]*)\" in Manage Configurations$")
    public void userAddConfigurationsInManageConfigurationPanel(String actionType, String buttonName, String nodeName) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, buttonName, nodeName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "cliked on " + buttonName + " under "+ nodeName);
        } catch (Exception e) {
            takeScreenShot("Not cliked on " + buttonName + " under "+ nodeName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not cliked on " + buttonName + " under "+ nodeName + e.getMessage());
        }
    }

    @And("^user click on \"([^\"]*)\" for \"([^\"]*)\" button under \"([^\"]*)\" in Manage Configurations$")
    public void userClickOnInManageConfigurationPanel(String actionType, String buttonName, String pluginName) throws Throwable {
        try {
            new PluginManagerActions(driver).genericClick(actionType, buttonName, pluginName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "cliked on " + buttonName + " under "+ pluginName);
        } catch (Exception e) {
            takeScreenShot("Not cliked on " + buttonName + " under "+ pluginName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not cliked on " + buttonName + " under "+ pluginName + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Add Configuration Page in Manage Configurations$")
    public void userSelectsFromAddConfigurationPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).addManageConfigurationsPageConfigurations(actionType, values.get("fieldName"), values.get("attribute"), values.get("pageName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dropdown option is selected");
        } catch (Exception e) {
            takeScreenShot("Dropdown option is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }

    @Then("^user verifies the status count for the deployment \"([^\"]*)\" in Manage Configurations page$")
    public void user_verifies_count_in_Manage_Configurations_page(String deployment, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
            new PluginManagerActions(driver).getPluginConfigurationStatusCountForDeployment(deployment, values.get("status"), values.get("count"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Count verified");
        } catch (Exception e) {
            takeScreenShot("Count is not verified", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Count is not verified" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Count is not verified");
        }
    }

    @When("^user verifies \"([^\"]*)\" is \"([^\"]*)\" in Add Configuration Page$")
    public void user_verifies_in_AddConfiguration_Page(String buttonName, String actionType) throws Throwable {
        try {
            sleepForSec(1000);
            waitForAngularLoad(driver);
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot( buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  buttonName + " is not clicked");
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" button in Add Configuration Page$")
    public void user_clicks_in_Add_Configuration_Page(String actionType, String buttonName) throws Throwable {
        try {
            sleepForSec(1000);
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot( buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  buttonName + " is not clicked");
        }
    }

    @And("^user verifies the \"([^\"]*)\" for \"([^\"]*)\" in Add Manage Configuration Page$")
    public void user_verifies_in_Add_Manage_Configuration_Page(String actionType, String parentMenu, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new PluginManagerActions(driver).validateElementsInAddConfigPage(itemList, actionType, parentMenu);
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action is performed on "+actionType+" in Manage Data Source page");
        } catch (Exception e) {
            takeScreenShot("action is not performed on "+actionType+" in Add  and Manage Configiration page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("action is not performed on "+actionType+" in Add  and Manage Configuration page" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action is not performed on "+actionType+" in Add  and Manage Configiration page");
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" button to save JDBC settings in \"([^\"]*)\"$")
    public void userOnButtonToSaveJDBCSettingsIn(String actionType, String buttonName, String arg2) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot( buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  buttonName + " is not clicked");
        }
    }

    @And("^user \"([^\"]*)\" in the Add Configuration Page$")
    public void userInTheAddConfigurationPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).addAndManageConfigurations(actionType, values.get("fieldName"), values.get("attribute"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dropdown option is selected");
            }
        } catch (Exception e) {
            takeScreenShot("Dropdown option is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Dropdown option is not selected" + e.getMessage());
        }
    }
    @When("^user performs \"([^\"]*)\" operation in Manage Credential page$")
    public void user_performs_operation_in_Manage_Credential_page(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).genericActions(actionType, values.get("button"), values.get("actionItem"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+ "is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+ "is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+ "is not performed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" in Log Viewer in Manage Configurations$")
    public void userInLogViewerConfigurationPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new PluginManagerActions(driver).addManageConfigurationsPageConfigurations(actionType, values.get("fieldName"), values.get("attribute"), values.get("pageName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType +" is performed");
        } catch (Exception e) {
            takeScreenShot(actionType +" is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType +" is not performed" + e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" in \"([^\"]*)\"$")
    public void user_on_Page(String actionType, String buttonName,String PageName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
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

    @And("^user verifies the Log Text is displayed according to \"([^\"]*)\" time selected in Configurations Log page$")
    public void user_verifies_in_Configuration_Log_Page(String timeSelected) throws Throwable {
        try {
            new PluginManager(driver).verifyLogTextDispalyedRegardsToTime(timeSelected);
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Log Text is displayed according to the time selected in Configurations Log page");
        } catch (Exception e) {
            takeScreenShot("Log Text is displayed according to the time selected in Configurations Log page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Log Text is not displayed according to the time selected in Configurations Log page" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Log Text is not displayed according to the time selected in Configurations Log page");
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" button in Manage Data Sources$")
    public void userAddDataSourceInManageDataSourcesPanel(String actionType, String buttonName) throws Throwable {
        try {
            new PluginManagerActions(driver).genericActions(actionType, buttonName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clicked on " + buttonName);
        } catch (Exception e) {
            takeScreenShot("Not cliked on " + buttonName, driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Not cliked on " + buttonName + "  " + e.getMessage());
        }
    }
    @Then("^user \"([^\"]*)\" in search items$")
    public void user_in_search_items(String actionType, DataTable dataTable) throws Throwable {
        try {
            new PluginManagerActions(driver).validateProjectItems(actionType, dataTable.asList(String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            takeScreenShot("Values does not match", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Values does not match" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values does not match");
        }
    }

    @And("^user verifies pluginconfiguration tooltip \"([^\"]*)\" and  \"([^\"]*)\" button$")
    public void userVerifiesPluginconfigurationTooltipAndButton(String pluginname, String button) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new PluginManager(driver).getpluginTooltip(pluginname, button)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is displayed");
        } catch (Exception e) {
            takeScreenShot("Values does not match", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Values does not match" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values does not match");
        }
    }
    @And("^User performs following actions in the Manage pipelines Page$")
    public void userPerformsFollowingActionsInTheManagePipelinePage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new PluginManagerActions(driver).managePipelinePageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Manage Pipelines Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Manage Pipelines Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Manage Pipelines Page is not performed ");
            Assert.fail("action in Manage Pipelines Page is not performed" + e.getMessage());
        }
    }

    @And("^user verifies the \"([^\"]*)\" for \"([^\"]*)\" in \"([^\"]*)\"$")
    public void user_verifies_in_Manage_Pipeline_Page(String actionType, String parentMenu, String pageName, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new PluginManagerActions(driver).validateElementsInAddConfigPage(itemList, actionType, parentMenu);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action is performed on "+actionType+" in "+pageName+"");
        } catch (Exception e) {
            takeScreenShot("action is performed on "+actionType+" in "+pageName+"", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action is performed on "+actionType+" in "+pageName+"");
            Assert.fail("action is performed on "+actionType+" in "+pageName+"" + e.getMessage());
        }
    }

    @And("^User performs following actions in the Pipeline Configurator Page$")
    public void userPerformsFollowingActionsInTheManageScreenPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new PluginManagerActions(driver).pipelineConfiguratorPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Pipeline Configurator  Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Pipeline Configurator  Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Pipeline Configurator  Page is not performed ");
            Assert.fail("action in Pipeline Configurator Page is not performed" + e.getMessage());
        }
    }


}