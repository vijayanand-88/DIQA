package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.CommonActions;
import com.asg.automation.pageactions.idc.DashboardActions;
import com.asg.automation.pageactions.idc.DiagrammingActions;
import com.asg.automation.pageactions.idc.SubjectAreaManagerActions;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.DiagrammingPage;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.Color;
import org.testng.Assert;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static java.awt.SystemColor.menu;

/**
 * Created by Divya.Bharathi on 5/30/2018.
 */

@SuppressWarnings("DefaultFileTemplate")
public class DiagrammingStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    protected DBPostgresUtil db_postgres_util;
    private SikuliUtil sikuliUtil = new SikuliUtil();
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

    @And("^user verifies the diagram menu is open by default$")
    public void user_verifies_diagram_menu_is_opened_by_default() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getDiagrammingMenu()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The diagram menu is open by default");
        } catch (Exception e) {
            takeScreenShot("Diagramming menu is not shown", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Diagramming menu is not shown" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" full view icon in the Diagramming page$")
    public void user_verifies_or_clicks_full_view_icon(String action) throws Throwable {
        try {
            if (action.equalsIgnoreCase("verify")) {
                Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getFullViewIcon()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The Full view icon is displayed");
            } else if (action.equalsIgnoreCase("click")) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getFullViewIcon());
                } else {
                    clickOn(new DiagrammingPage(driver).getFullViewIcon());
                }
            }
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on Full view icon");
        } catch (Exception e) {
            takeScreenShot(action + " is not performed for full view icon ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(action + " is not performed for full view icon " + e.getMessage());
        }
    }

    @And("^user set the details view as high$")
    public void user_set_the_details_view_as_high() throws Throwable {
        try {
            mouseDragAndDrop(driver, new DiagrammingPage(driver).getZoomSlider(), new DiagrammingPage(driver).getScrolltoHighdetails());
            //clickOn(new DiagrammingPage(driver).getScrolltoHighdetails());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The Diagram should be opened in full view");
        } catch (Exception e) {
            takeScreenShot("Diagramming is not shown in full view", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Diagramming is not shown in full view" + e.getMessage());
        }
    }


    @And("^user verifies diagram is opened in full view$")
    public void user_verifies_diagram_is_opened_in_full_view() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getDiagrammingFullView()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The Diagram should be opened in full view");
        } catch (Exception e) {
            takeScreenShot("Diagramming is not shown in full view", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Diagramming is not shown in full view"+e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" normal size icon in the Diagramming full view$")
    public void user_verifies_or_clicks_normal_view_icon(String action) throws Throwable {
        try {
            if(action.equalsIgnoreCase("verify")){
                Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getNormalSizeIcon()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The normal view icon is displayed");
            }
            else if(action.equalsIgnoreCase("click")){
                clickonWebElementwithJavaScript(driver,new DiagrammingPage(driver).getNormalSizeIcon());
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on normal view icon");
            }
        } catch (Exception e) {
            takeScreenShot(action+ " is not performed for normal view icon ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(action+ " is not performed for normal view icon "+e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" node in the diagramming page$")
    public void user_clicks_on_any_of_the_displayed_node_in_the_diagramming_page(String nodeName) throws Throwable {
        try {
            moveToElement(driver, new DiagrammingPage(driver).getAnyDisplayedNode(nodeName));
            sleepForSec(100);
            actionClick(driver, new DiagrammingPage(driver).getAnyDisplayedNode(nodeName));
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Displayed node is clicked");
        } catch (Exception e) {
            takeScreenShot("None of the node is clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("None of the node is clicked" + e.getMessage());
        }
    }

    @And("^user mouse hovers on \"([^\"]*)\" node in the diagramming page$")
    public void user_mouse_hovers_on_any_of_the_displayed_node_in_the_diagramming_page(String nodeName) throws Throwable {
        try {
            moveToElement(driver, new DiagrammingPage(driver).getAnyDisplayedNode(nodeName));
            sleepForSec(100);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Mouse hoverd on displayed node");
        } catch (Exception e) {
            takeScreenShot("Can't able to hover on displayed node", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Can't able to hover on displayed node" + e.getMessage());
        }
    }

    @Then("^user verifies the following color code in diagramming page$")
    public void user_verifies_the_color_code_for_any_displayed_node(DataTable data) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                String actualRGBCode = new DiagrammingPage(driver).getAnyDisplayedNode(values.get("Node")).getCssValue(values.get("StyleType"));
                String expectedRGBCode = values.get("ColorCode");
                if (browserName.equalsIgnoreCase("chrome") || browserName.equalsIgnoreCase("firefox")) {
                    Assert.assertEquals(actualRGBCode, expectedRGBCode);
                } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    String actualRGBCode_Edge = Color.fromString(actualRGBCode).asRgb();
                    Assert.assertEquals(actualRGBCode_Edge, expectedRGBCode);
                }
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

    @And("^user clicks on close button in the diagramming page$")
    public void user_clicks_on_close_button_in_the_diagramming_page() throws Throwable {
        try {
            clickOn(new DiagrammingPage(driver).getCloseButton());
            sleepForSec(4000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Close Button is clicked");
        } catch (Exception e) {
            takeScreenShot("Close Button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Close Button is not clicked" + e.getMessage());
        }
    }

    @And("^user selects \"([^\"]*)\" from view selection dropdown$")
    public void user_selects_option_from_view_selection_dropdown(String dropDownOption) throws Throwable {
        try {
            clickOn(new DiagrammingPage(driver).getViewSelectionDropDown());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dropDownOption + " is selected from the view selection dropdown list");
            sleepForSec(500);
            clickOn(traverseListContainsElementReturnsElement(new DiagrammingPage(driver).getViewSelectionDropdownList(), dropDownOption));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dropDownOption + " is selected");
        } catch (Exception e) {
            takeScreenShot(dropDownOption + " is not selected from the view selection dropdown list", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(dropDownOption + " is not selected from the view selection dropdown list" + e.getMessage());
        }
    }

    @And("^user clicks on zoom out icon in diagram$")
    public void userClicksOnZoomOutIconInDiagram() throws Throwable {
        try {
            clickOn(new DiagrammingPage(driver).getZoomOutIcon());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Zoom in icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Icon for zoom out is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is not clicked");
            Assert.fail("Icon for zoom out is not clicked " + e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" tab in item full view page$")
    public void user_clicks_on_tab_in_item_full_view_page(String tabName) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
            }
            clickOn(traverseListContainsElementReturnsElement(new DiagrammingPage(driver).getSubjectAreatabList(), tabName));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), tabName + " is clicked");
        } catch (Exception e) {
            takeScreenShot(tabName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is not clicked");
            Assert.fail(tabName + " is not clicked" + e.getMessage());
        }
    }

    @Given("^user \"([^\"]*)\" the Lineage diagram for \"([^\"]*)\" times$")
    public void user_the_Lineage_diagram_for_times(String action, String noOfScrolls) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge") || propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                for (int i = 0; i < Integer.parseInt(noOfScrolls); i++) {
                    clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getZoomInIcon());
                    sleepForSec(2000);
                }
            } else {
                scrollUsingSendKeys(new DiagrammingPage(driver).getLineageDiagramContainer(), action, noOfScrolls);
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is done using mouse");

            }
        } catch (Exception e) {
            takeScreenShot("Mouse zoom in is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is not clicked");
            Assert.fail("Mouse zoom in is not performed " + e.getMessage());
        }

    }

    @Then("^Item type should \"([^\"]*)\" displayed beside the item name for following values$")
    public void item_type_should_displayed_beside_the_item_name_for_following_values(String action, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            switch (action) {
                case "get":
                    for (CucumberDataSet data : dataTableCollection) {
                        switch (data.getlineageNodeType()) {
                            case "Service":
                                sleepForSec(500);
                                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                } else {
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).get(0).getText().contains(data.getlineageNodeType()));
                                }
                                break;
                            case "Database":
                                sleepForSec(500);
                                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                    Assert.assertTrue(new DiagrammingPage(driver).getDBItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                } else {
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).get(0).getText().contains(data.getlineageNodeType()));
                                }
                                break;
                            case "Table":
                                sleepForSec(500);
                                Assert.assertTrue(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                break;
                            case "Column":
                                sleepForSec(500);
                                Assert.assertTrue(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                break;
                        }
                    }
                    break;
                case "not get":
                    for (CucumberDataSet data : dataTableCollection) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            switch (data.getlineageNodeType()) {
                                case "Service":
                                    sleepForSec(500);
                                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                        Assert.assertFalse(new DiagrammingPage(driver).getParentItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                    } else {
                                        Assert.assertFalse(new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).get(0).getText().contains(data.getlineageNodeType()));
                                    }
                                    break;
                                case "Database":
                                    sleepForSec(500);
                                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                        Assert.assertFalse(new DiagrammingPage(driver).getDBItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                    } else {
                                        Assert.assertFalse(new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).get(0).getText().contains(data.getlineageNodeType()));
                                    }
                                    break;
                                case "Table":
                                    sleepForSec(500);
                                    Assert.assertFalse(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                    break;
                                case "Column":
                                    sleepForSec(500);
                                    Assert.assertFalse(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                    break;
                            }
                        }

                    }
            }

        } catch (Exception e) {
            takeScreenShot("Item type is not displayed beside Item Name", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item type is not displayed beside Item Name");
            Assert.fail("Item type is not displayed beside Item Name" + e.getMessage());
        }

    }

    @Given("^user clicks on node \"([^\"]*)\" and type \"([^\"]*)\" in Lineage tab$")
    public void user_clicks_on_node_and_type_in_Lineage_tab(String nodeName, String nodeType) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                sleepForSec(1500);
                clickOn(new DiagrammingPage(driver).getItemName(nodeType, nodeName));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(2000);
                clickOn(new DiagrammingPage(driver).getItemEdge(nodeType, nodeName));
                sleepForSec(1000);
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
            } else {
                clickOn(new DiagrammingPage(driver).getItemName(nodeType, nodeName));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
            }
        } catch (Exception e) {
            takeScreenShot("Item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Itemis not clicked");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" menu and \"([^\"]*)\" submenu$")
    public void user_clicks_on_menu_and_submenu(String menu, String subMenu) throws Throwable {
        try {
            sleepForSec(1000);
            clickOn(new DiagrammingPage(driver).getToolBar(menu));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + " is clicked");
            clickOn(new DiagrammingPage(driver).getToolBarSubMenu(subMenu));
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), subMenu + " is clicked");
        } catch (Exception e) {
            takeScreenShot("Item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Itemis not clicked");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }


    @Then("^following nodes should \"([^\"]*)\" displayed in Lineage Diagram$")
    public void following_nodes_should_displayed_in_Lineage_Diagram(String action, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            switch (action) {
                case "get":
                    for (CucumberDataSet data : dataTableCollection) {
                        switch (data.getlineageNodeType()) {
                            case "Service":
                                sleepForSec(500);
                                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                } else {
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).get(0).getText().contains(data.getlineageNodeType()));
                                }
                                break;
                            case "Database":
                                sleepForSec(500);
                                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                    Assert.assertTrue(new DiagrammingPage(driver).getDBItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                } else {
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).get(0).getText().contains(data.getlineageNodeType()));
                                }
                                break;
                            case "Table":
                                sleepForSec(500);
                                Assert.assertTrue(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                break;
                            case "Column":
                                sleepForSec(500);
                                Assert.assertTrue(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                break;
                        }
                    }
                    break;
                case "not get":
                    for (CucumberDataSet data : dataTableCollection) {
                        switch (data.getlineageNodeType()) {
                            case "Service":
                                sleepForSec(500);
                                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                    if (new DiagrammingPage(driver).getParentItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).isDisplayed() == true) {
                                        Assert.fail(data.getlineageNodeType() + data.getLineageNodeName() + " is visible");
                                    }
                                } else {
                                    if (new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).size()!=0) {
                                        Assert.fail(data.getlineageNodeType() + data.getLineageNodeName() + " is visible");
                                    }
                                }
                                break;
                            case "Database":
                                sleepForSec(500);
                                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                                    if (new DiagrammingPage(driver).getParentItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).isDisplayed() == true) {
                                        Assert.fail(data.getlineageNodeType() + data.getLineageNodeName() + " is visible");
                                    }
                                } else {
                                    if (new DiagrammingPage(driver).getParentItemName(data.getlineageNodeType(), data.getLineageNodeName()).size()!=0) {
                                        Assert.fail(data.getlineageNodeType() + data.getLineageNodeName() + " is visible");
                                    }
                                }
                                break;
                            case "Table":
                                sleepForSec(500);
                                Assert.assertFalse(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                break;
                            case "Column":
                                sleepForSec(500);
                                Assert.assertFalse(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                break;
                        }
                    }

            }
        } catch (Exception e) {
            takeScreenShot("Item type is not displayed beside Item Name", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item type is not displayed beside Item Name");
        }

    }

    @Then("^node \"([^\"]*)\" with type \"([^\"]*)\" should \"([^\"]*)\" displayed in Lineage diagram$")
    public void node_with_type_should_displayed_in_Lineage_diagram(String nodeName, String nodeType, String condn) throws Throwable {
        try {
            switch (condn) {
                case "not get":
                    if (new DiagrammingPage(driver).getItemName(nodeType, nodeName).isDisplayed() == true) {
                        Assert.fail(nodeName + nodeType + " is not hidden");
                        takeScreenShot(nodeName + nodeType + " is not hidden", driver);
                    }
                case "get":
                    if (new DiagrammingPage(driver).getItemName(nodeType, nodeName).isDisplayed() == false) {
                        Assert.fail(nodeName + nodeType + " is not hidden");
                        takeScreenShot(nodeName + nodeType + " is not hidden", driver);
                    }
            }

        } catch (NoSuchElementException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + nodeType + " is  hidden");
            takeScreenShot(nodeName + nodeType + " is hidden", driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeType + nodeName + " is not hidden");
            Assert.fail(nodeType + nodeName + " is not hidden" + e.getMessage());
        }
    }

    @Given("^user select the following items by pressing \"([^\"]*)\"$")
    public void user_select_the_following_items_by_pressing(String keyPress, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            Actions actions = new Actions(driver);
            actions.keyDown(Keys.valueOf(keyPress)).build().perform();
            for (CucumberDataSet data : dataTableCollection) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                    sleepForSec(1000);
                    actionClick(driver, new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName()));
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
                } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    sleepForSec(1000);
                    clickOn(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()));
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
                } else {
                    sleepForSec(1000);
                    clickOn(new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName()));
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
                }
            }
            actions.keyDown(Keys.CONTROL).build().perform();
        } catch (Exception e) {
            takeScreenShot("Stroke Width is not increased", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Stroke Width is not increased");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }

    @Then("^following item should \"([^\"]*)\" highlighted and width should be \"([^\"]*)\"$")
    public void following_item_should_highlighted_and_width_should_be(String highlighted, String expectedWidth, List<CucumberDataSet> dataTableCollection) throws Throwable {
        List<String> widh = new ArrayList();
        String[] widthList;
        try {
            sleepForSec(1000);
            switch (highlighted) {
                case "be":
                    for (CucumberDataSet data : dataTableCollection) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            widthList = CommonUtil.splittedText(new DiagrammingPage(driver).getTableItemWidthEdge(data.getlineageNodeType(), data.getLineageNodeName()).getAttribute("style"), ";");
                        } else {
                            widthList = CommonUtil.splittedText(new DiagrammingPage(driver).getTableItemWidth(data.getLineageNodeName()).getAttribute("style"), ";");
                        }

                        for (String actualWidth : widthList) {
                            widh.add(actualWidth.trim());
                        }
                        Assert.assertTrue(widh.contains(expectedWidth));
                    }
                    break;
                case "not be":
                    sleepForSec(500);
                    for (CucumberDataSet data : dataTableCollection) {

                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            widthList = CommonUtil.splittedText(new DiagrammingPage(driver).getTableItemWidthEdge(data.getlineageNodeType(), data.getLineageNodeName()).getAttribute("style"), ";");
                        } else {
                            widthList = CommonUtil.splittedText(new DiagrammingPage(driver).getTableItemWidth(data.getLineageNodeName()).getAttribute("style"), ";");
                        }

                        for (String actualWidth : widthList) {
                            widh.add(actualWidth.trim());
                        }
                        Assert.assertFalse(widh.contains(expectedWidth));
                    }
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("Stroke Width is  increased", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Stroke Width is  increased");
            Assert.fail("Stroke Width is  increased" + e.getMessage());
        }
    }

    @Given("^user unselect the following items by pressing \"([^\"]*)\"$")
    public void user_unselect_the_following_items_by_pressing(String keyPress, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            Actions actions = new Actions(driver);
            actions.keyDown(Keys.CONTROL).build().perform();
            for (CucumberDataSet data : dataTableCollection) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                    sleepForSec(1000);
                    actionClick(driver, new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName()));
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
                } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    clickOn(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()));
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
                } else {
                    clickOn(new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName()));
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item is clicked");
                }
            }
        } catch (Exception e) {
            takeScreenShot("Stroke Width is not increased", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Stroke Width is not increased");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }

    @Given("^user mouse hovers below item in Lineage tab and verifies following type is displayed$")
    public void user_mouse_hovers_below_item_in_Lineage_tab_and_verifies_following_type_is_displayed(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                    sleepForSec(2000);
                    moveToElement(driver, new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()));
                    Assert.assertTrue(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().trim().equals(
                            data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                } else {
                    sleepForSec(1000);
                    moveToElement(driver, new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName()));
                    Assert.assertTrue(new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName()).getText().trim().equals(
                            data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                }
            }
        } catch (Exception e) {
            takeScreenShot("Stroke Width is not increased", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Stroke Width is not increased");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }

    @Given("^user \"([^\"]*)\" the Lineage diagram for \"([^\"]*)\" times using \\+ icon$")
    public void user_the_Lineage_diagram_for_times_using_icon(String action, String noOfScrolls) throws Throwable {
        try {
            switch (action) {
                case "zoomIn":
                    for (int i = 0; i < Integer.parseInt(noOfScrolls); i++) {
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getZoomInIcon());
                        sleepForSec(1500);
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram zoom in is performed");
                    }
                    break;
                case "zoomOut":
                    for (int i = 0; i < Integer.parseInt(noOfScrolls); i++) {
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getZoomOutIcon());
                        sleepForSec(1500);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Diagram zoom out is performed");
                    }
                    break;
            }

        } catch (Exception e) {
            takeScreenShot("Mouse zoom in is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is not clicked");
            Assert.fail("Mouse zoom in is not performed " + e.getMessage());
        }
    }

    @Given("^user click on \"([^\"]*)\" tool bar menu$")
    public void user_click_on_tool_bar_menu(String action) throws Throwable {
        try {
            switch (action) {
                case "Expand All":
                    sleepForSec(1000);
                    clickOn(new DiagrammingPage(driver).getExpandAll());
                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                        sleepForSec(2000);
                    }
                    break;
                case "Collapse All":
                    sleepForSec(500);
                    clickOn(new DiagrammingPage(driver).getCollapseAll());
                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                        sleepForSec(1000);
                        break;
                    }
            }
        } catch (Exception e) {
            takeScreenShot("Mouse zoom in is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is not clicked");
            Assert.fail("Mouse zoom in is not performed " + e.getMessage());
        }
    }



    @Then("^following items should \"([^\"]*)\" displayed in Lineage Diagram$")
    public void following_items_should_displayed_in_Lineage_Diagram(String action, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            switch (action) {
                case "get":
                    for (CucumberDataSet data : dataTableCollection) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            switch (data.getlineageNodeType()) {
                                case "Service":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getParentItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Database":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getDBItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getlineageNodeType()));
                                    break;
                                case "Table":
                                    sleepForSec(500);
                                    Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getTableList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                                    break;
                                case "Column":
                                    sleepForSec(500);
                                    Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getColumnList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                                    break;
                                case "Cluster":
                                    sleepForSec(500);
                                    Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getClusterList(), data.getLineageNodeName()));
                                    break;
                            }

                        } else {
                            sleepForSec(1500);
                            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getItemName(data.getlineageNodeType(), data.getLineageNodeName())));
                        }
                    }
                    break;
                case "not get":

                    for (CucumberDataSet data : dataTableCollection) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            switch (data.getlineageNodeType()) {
                                case "Service":
                                    sleepForSec(500);
                                    Assert.assertFalse(new DiagrammingPage(driver).getItemEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Database":
                                    sleepForSec(500);
                                    Assert.assertFalse(new DiagrammingPage(driver).getDBItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Table":
                                    sleepForSec(500);
                                    Assert.assertFalse(traverseListContainsElementText(new DiagrammingPage(driver).getTableList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                                    break;
                                case "Column":
                                    sleepForSec(500);
                                    Assert.assertFalse(traverseListContainsElementText(new DiagrammingPage(driver).getColumnList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                                    break;
                                case "Cluster":
                                    sleepForSec(500);
                                    Assert.assertFalse(traverseListContainsElementText(new DiagrammingPage(driver).getClusterList(), data.getLineageNodeName()));
                                    break;
                            }
                        } else {
                            sleepForSec(1500);
                            Assert.assertFalse(traverseListContainsElementText(new DiagrammingPage(driver).getColumnList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                        }
                    }
                    break;
                case "check":
                    for (CucumberDataSet data : dataTableCollection) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                            switch (data.getlineageNodeType()) {
                                case "Service":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Database":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getDBItemNameEdge(data.getlineageNodeType(), data.getLineageNodeName()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Table":
                                    sleepForSec(500);
                                    Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getTableList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                                    break;
                                case "Operation":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Column":
                                    sleepForSec(500);
                                    Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getColumnList(), data.getLineageNodeName() + " [" + data.getlineageNodeType() + "]"));
                                    break;
                                case "Cluster":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "File":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Project":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                                    break;
                                case "Directory":
                                    sleepForSec(500);
                                    Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                                    break;


                            }

                        } else {
                            sleepForSec(1500);
                            Assert.assertTrue(new DiagrammingPage(driver).getLineageTextofAllItems(data.getLineageNodeName(), data.getlineageNodeType()).getText().contains(data.getLineageNodeName()));
                        }
                    }
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("Item type is  displayed beside Item Name", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item type is  displayed beside Item Name");
            Assert.fail("Item type is  displayed beside Item Name" + e.getMessage());
        }
    }

    @Given("^user click on Cluster drill icon for item \"([^\"]*)\"$")
    public void user_click_on_Cluster_drill_icon_for_item(String clusterName) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                actionClick(driver, new DiagrammingPage(driver).getClusterDrillIcon(clusterName));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Cluster drill icon is clicked");
            } else {
                clickOn(new DiagrammingPage(driver).getClusterDrillIcon(clusterName));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Cluster drill icon is clicked");
            }
        } catch (Exception e) {
            takeScreenShot("Drill Icon is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Drill Icon is not clicked");
            Assert.fail("Drill Icon is not clicked" + e.getMessage());
        }
    }

    @Given("^user move the diagram to other location with following co-ordinates$")
    public void user_move_the_diagram_to_other_location_with_following_co_ordinates(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            storeTemporaryText(new DiagrammingPage(driver).getNodes().getSize().toString());
            for (CucumberDataSet data : dataTableCollection) {
                switch (data.getAction()) {
                    case "moveByOffset":
                        moveToCoordinates(driver, new DiagrammingPage(driver).getNodes(), data.getWidth(), data.getHeight());
                        break;
                }
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Element is moved to new position");
        } catch (Exception e) {
            takeScreenShot("Drill Icon is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Drill Icon is not clicked");
            Assert.fail("Drill Icon is not clicked" + e.getMessage());
        }
    }

    @Then("^diagram position should get realigned to default position$")
    public void diagram_position_should_get_realigned_to_default_position() throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(getTemporaryText().equals(new DiagrammingPage(driver).getNodes().getSize().toString().trim()));
        } catch (Exception e) {
            takeScreenShot("Item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Itemis not clicked");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }

    @Given("^user get the default diagram position$")
    public void user_get_the_default_diagram_position() throws Throwable {
        try {
            storeTemporaryText(new DiagrammingPage(driver).getNodes().getSize().toString());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Default position is retrieved");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Default position is not retrieved");
            Assert.fail("Diagram Default position is not retrieved" + e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" icon in Relationship tab$")
    public void user_clicks_on_icon_in_Relationship_tab(String icon) throws Throwable {
        try {
            switch (icon) {
                case "onetoone":
                    clickOn(new DiagrammingPage(driver).getOneIsToOne());
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "One is to One is clicked");
                    break;
                case "fullView":
                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                        sleepForSec(1000);
                        clickOn(new DiagrammingPage(driver).getDiagramFullView());
                        sleepForSec(1000);
                        break;
                    } else {
                        sleepForSec(1000);
                        clickOn(new DiagrammingPage(driver).getDiagramFullView());
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "One is to One is clicked");
                        break;
                    }

                case "normalView":
                    clickOn(new DiagrammingPage(driver).getDiagramNormalView());
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Normal View Icon is clicked");
                    break;
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), icon + " is not clicked");
            Assert.fail(icon + " is not clicked" + e.getMessage());
        }
    }


    @Then("^action menu popup for node should be displayed$")
    public void action_menu_popup_for_node_should_be_displayed() throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getActionMenuPopUp().get(0)));
        } catch (Exception e) {
            takeScreenShot("Action Menu popup is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action Menu popup is not displayed");
            Assert.fail("Diagram Default position is not retrieved" + e.getMessage());
        }
    }

    @Then("^action menu popup for node should not be displayed$")
    public void action_menu_popup_for_node_should_not_be_displayed() throws Throwable {

        try {
//            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox") || propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                keyPressEvent(driver, Keys.ESCAPE);
//            }
            if (new DiagrammingPage(driver).getActionMenuPopUp().get(0).isDisplayed() == true)
                Assert.fail("Action menu popup is displayed");
        } catch (NoSuchElementException e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Menu popup is not displayed");
        } catch (Exception e) {
            takeScreenShot("Action Menu popup is  displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action Menu popup is displayed");
        }
    }

    @Then("^user press \"([^\"]*)\" key using key press event$")
    public void user_press_key_using_key_press_event(String key) throws Throwable {
        try {
            keyPressEvent(driver, Keys.valueOf(key));
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Default position is retrieved");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Default position is not retrieved");
            Assert.fail("Diagram Default position is not retrieved" + e.getMessage());
        }
    }

    @Then("^user press the \"([^\"]*)\" key  for \"([^\"]*)\" times using key press event")
    public void user_press_key_using_key_press_event_with_times(String key, String noOftimes) throws Throwable {
        try {
            for (int i = 0; i <= Integer.parseInt(noOftimes); i++) {
            keyPressEvent(driver, Keys.valueOf(key));
            sleepForSec(2000);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Key is  Pressed");}
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Key is not Pressed");
            Assert.fail("Key is not Pressed" + e.getMessage());
        }
    }

    @Given("^user clicks on diagram in item view page$")
    public void user_clicks_on_diagram_in_item_view_page() throws Throwable {
        try {
            clickOn(new DiagrammingPage(driver).getDiagram());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram is clicked");
            Assert.fail("Diagram is clicked" + e.getMessage());
        }
    }


    @Then("^user validate new Lineage options are available in Relationship and Lineage tab$")
    public void user_validate_new_Lineage_options_are_available_in_Relationship_and_Lineage_tab() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getToolBarCloseArrow()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getViewLabel()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getDetailsLabel()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getSettingMenu()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getZoomSlider()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getExpandAll()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getCollapseAll()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getLineageSelectOptions()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getToolBar("More Actions")));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getToolBar("Reload")));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getSearchField()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getOneIsToOne()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getZoomOutIcon()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getZoomInIcon()));
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getFullViewIcon()));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Lineage Options not displayed in Relation Ship / Lineage Tab");
            Assert.fail("Diagram is clicked" + e.getMessage());
        }
    }

    @Then("^Relationship/Lineage tab should have following submenu options under \"([^\"]*)\" menu$")
    public void relationship_Lineage_tab_should_have_following_submenu_options_under_menu(String menu, List<CucumberDataSet> dataTableList) throws Throwable {
        try {
            switch (menu) {
                case "VIEW":
                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                        sleepForSec(500);
                    }
                    clickOn(new DiagrammingPage(driver).getViewMenu());
                    for (CucumberDataSet data : dataTableList) {
                        Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getViewSubMenuList(), data.getLineageSubMenuOptions()));
                    }
                    break;
                case "SETTINGS":
                    clickOn(new DiagrammingPage(driver).getSettingMenu());
                    sleepForSec(1000);
                    for (CucumberDataSet data : dataTableList) {

                        Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getSettingMenuList(), data.getLineageSubMenuOptions()));
                    }
                    break;
                case "SELECT":
                    clickOn(new DiagrammingPage(driver).getLineageSelectOptions());
                    for (CucumberDataSet data : dataTableList) {
                        Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getLineageSelectSubMenuList(), data.getLineageSubMenuOptions()));
                    }
                    break;
                case "MORE ACTIONS":
                    clickOn(new DiagrammingPage(driver).getMoreActionsMenu());
                    for (CucumberDataSet data : dataTableList) {
                        Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getMoreActionsSubMenuList(), data.getLineageSubMenuOptions()));
                    }
                    break;
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "SubMenu list is not matched with actual list");
            takeScreenShot("SubMenu list is not matched with actual list", driver);
            Assert.fail("SubMenu list is not matched with actual list" + e.getMessage());
        }
    }

    @Given("^user clicks \"([^\"]*)\" menu and following subMenu in Relationship/Lineage tab$")
    public void user_clicks_menu_and_following_subMenu_in_Relationship_Lineage_tab(String menu, List<CucumberDataSet> dataTableList) throws Throwable {
        try {
            switch (menu) {
                case "SETTINGS":
                    sleepForSec(1000);
                    clickOn(new DiagrammingPage(driver).getSettingMenu());
                    for (CucumberDataSet data : dataTableList) {
                        clickOn(new DiagrammingPage(driver).getSettingsCheckBox(data.getLineageSubMenuOptions()));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), data.getLineageSubMenuOptions() + " is clicked");
                    }
                    break;
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + "is not clicked");
            Assert.fail("Diagram is clicked" + e.getMessage());
        }
    }

    @Then("^following edge text should \"([^\"]*)\" displayed in diagram$")
    public void following_edge_text_should_displayed_in_diagram(String expectedResult, List<CucumberDataSet> dataTableList) throws Throwable {
        try {
            switch (expectedResult) {
                case "not be":
                    for (CucumberDataSet data : dataTableList) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            if (isElementPresent(new DiagrammingPage(driver).getItemEdgeBrowserText(data.getDiagramEdgeText())) == true) {
                                Assert.fail(data.getDiagramEdgeText() + " is displayed");
                            }
                        } else {
                            if (isElementPresent(new DiagrammingPage(driver).getItemEdgeText(data.getDiagramEdgeText())) == true) {
                                Assert.fail(data.getDiagramEdgeText() + " is displayed");
                            }
                        }

                    }
                    break;

                case "be":
                    for (CucumberDataSet data : dataTableList) {
                        if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getItemEdgeBrowserText(data.getDiagramEdgeText())));

                        } else {
                            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getItemEdgeText(data.getDiagramEdgeText())));
                        }
                    }
                    break;
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Edge Text" + expectedResult + " displayed");
        }
    }


    @Then("^item icon popup \"([^\"]*)\" have following values in popup$")
    public void item_icon_popup_have_following_values_in_popup(String expectedResult, List<CucumberDataSet> dataTableList) throws Throwable {
        try {
            switch (expectedResult) {
                case "should not":
                    for (CucumberDataSet data : dataTableList) {
                        if (traverseListContainsElementText(new DiagrammingPage(driver).getMoreActionsSubMenuList(), data.getLineageSubMenuOptions())) {
                            Assert.fail(data.getLineageSubMenuOptions() + " is displayed");
                        }
                    }
                    break;
                case "should":
                    for (CucumberDataSet data : dataTableList) {
                        sleepForSec(2000);
                        Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getMoreActionsSubMenuList(), data.getLineageSubMenuOptions()));
                    }
                    break;
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Edge Text" + expectedResult + " displayed");
        }
    }


    @Given("^user click on drill icon for item \"([^\"]*)\" and type \"([^\"]*)\"$")
    public void user_click_on_drill_icon_for_item_and_type(String nodeName, String nodeType) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                moveToElement(driver, new DiagrammingPage(driver).getItemDrillIcon(nodeName, nodeType));
                actionClick(driver, new DiagrammingPage(driver).getItemDrillIcon(nodeName, nodeType));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1500);
                moveToElement(driver, new DiagrammingPage(driver).getItemNameDrillIconEdge(nodeName, nodeType));
                clickOn(new DiagrammingPage(driver).getItemNameDrillIconEdge(nodeName, nodeType));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
            } else {
                clickOn(new DiagrammingPage(driver).getItemDrillIcon(nodeName, nodeType));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + "is not clicked");
            Assert.fail("Diagram is clicked" + e.getMessage());
        }
    }

    @Given("^user click on collapse icon for item \"([^\"]*)\" and type \"([^\"]*)\"$")
    public void user_click_on_collapse_icon_for_item_and_type(String nodeName, String nodeType) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                moveToElement(driver, new DiagrammingPage(driver).getDrillDownIconCollapse(nodeName, nodeType));
                actionClick(driver, new DiagrammingPage(driver).getDrillDownIconCollapse(nodeName, nodeType));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                moveToElement(driver, new DiagrammingPage(driver).getItemNameDrillIconEdge(nodeName, nodeType));
                clickOn(new DiagrammingPage(driver).getItemNameDrillIconEdge(nodeName, nodeType));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
            } else {
                sleepForSec(500);
                moveToElement(driver, new DiagrammingPage(driver).getDrillDownIconCollapse(nodeName, nodeType));
                clickOn(new DiagrammingPage(driver).getDrillDownIconCollapse(nodeName, nodeType));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Collapse icon is not clicked");
            Assert.fail("Collapse icon is not clicked" + e.getMessage());
        }
    }

    @Given("^user clicks on item icon in \"([^\"]*)\" table and type \"([^\"]*)\"$")
    public void user_clicks_on_item_icon_in_table_and_type(String nodeName, String nodeType) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            switch (nodeType) {
                case "Database":
                    if (browserName.equalsIgnoreCase("edge")) {
                        sleepForSec(1500);
                        moveToElement(driver, new DiagrammingPage(driver).getParentItemNameEdge(nodeType, nodeName));
                        sleepForSec(1000);
                        clickOn(new DiagrammingPage(driver).getParentItemIconEdge(nodeType, nodeName));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    } else if (browserName.equalsIgnoreCase("firefox")) {
                        sleepForSec(1500);
                        moveToElement(driver, new DiagrammingPage(driver).getParentItemIcon(nodeType, nodeName));
                        sleepForSec(1000);
                        actionClick(driver, new DiagrammingPage(driver).getParentItemIcon(nodeType, nodeName));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    } else {
                        moveToElement(driver, new DiagrammingPage(driver).getParentItemName(nodeType, nodeName).get(0));
                        clickOn(new DiagrammingPage(driver).getParentItemIcon(nodeType, nodeName));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    }
                    break;
                case "Table":
                    if (browserName.equalsIgnoreCase("edge")) {
                        sleepForSec(2000);
                        moveToElement(driver, new DiagrammingPage(driver).getItemNameDrillIconEdge(nodeName, nodeType));
                        sleepForSec(2000);
                        clickOn(new DiagrammingPage(driver).getItemIconEdge(nodeName, nodeType));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    } else if (browserName.equalsIgnoreCase("firefox")) {
                        sleepForSec(1000);
                        moveToElementUsingAction(driver, new DiagrammingPage(driver).getItemIcon(nodeName, nodeType));
                        sleepForSec(1000);
                        actionClick(driver, new DiagrammingPage(driver).getItemIcon(nodeName, nodeType));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    } else {
                        moveToElement(driver, new DiagrammingPage(driver).getItemIconEdge(nodeName, nodeType));
                        clickOn(new DiagrammingPage(driver).getItemIconEdge(nodeName, nodeType));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    }
                    break;
                case "Column":
                    if (browserName.equalsIgnoreCase("edge")) {
                        sleepForSec(2000);
                        moveToElement(driver, new DiagrammingPage(driver).getItemEdge(nodeType, nodeName));
                        clickOn(new DiagrammingPage(driver).getItemIconEdge(nodeName, nodeType));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");
                    } else if (browserName.equalsIgnoreCase("firefox")) {
                        sleepForSec(500);
                        moveToElement(driver, new DiagrammingPage(driver).getItemIcon(nodeName, nodeType));
                        actionClick(driver, new DiagrammingPage(driver).getItemIcon(nodeName, nodeType));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");

                    } else {
                        moveToElement(driver, new DiagrammingPage(driver).getItemIconEdge(nodeName, nodeType));
                        clickOn(new DiagrammingPage(driver).getItemIconEdge(nodeName, nodeType));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), nodeName + " is clicked");

                    }
                    break;
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item icon is clicked");
        } catch (
                Exception e)

        {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item icon is not clicked");
            Assert.fail("Item icon is not clicked" + e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" option from item icon popup$")
    public void user_clicks_on_option_from_item_icon_popup(String menu) throws Throwable {
        try {
            switch (menu) {
                case "Open Item":
                    if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                        sleepForSec(1000);
                    }
                    clickOn(new DiagrammingPage(driver).getOpenItem());
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + " is clicked");
                    break;
                case "Drilldown / Expand":
                    clickOn(new DiagrammingPage(driver).getItemDrillDownExpandIcon());
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + " is clicked");
                    break;
                case "Drillup":
                    clickOn(new DiagrammingPage(driver).getDrillUpIcon());
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + " is clicked");
                    break;
                case "Collapse":
                    clickOn(new DiagrammingPage(driver).getItemDrillDownCollapseIcon());
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + " is clicked");
                    break;
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + "is not clicked");
            Assert.fail("Diagram is clicked" + e.getMessage());
        }
    }

    @Then("^Item Name \"([^\"]*)\" with type \"([^\"]*)\" should be opened in \"([^\"]*)\" panel$")
    public void item_Name_with_type_should_be_opened_in_panel(String itemName, String itemType, String panelView) throws Throwable {
        try {
            switch (panelView) {
                case "Item Panel View":
                    sleepForSec(1000);
                    Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getItemInPanelView(itemName, itemType)));
                    break;
                case "Item Full View":
                    Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getItemInFullView(itemName, itemType)));
                    break;
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemName + "is not displayed in " + panelView);
            Assert.fail(itemName + "is not displayed in " + panelView + e.getMessage());
        }
    }

    @Given("^user mouse hover on \"([^\"]*)\" edge icon and click lineage hop info icon$")
    public void user_mouse_hover_edge_icon_and_click_lineage_hop_info_icon(String lineageIcon) throws Throwable {
        try {
            sleepForSec(1000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                sleepForSec(2000);
                moveToElementUsingAction(driver, new DiagrammingPage(driver).getEdgeIconFirefox());
                sleepForSec(1000);
                actionClick(driver, new DiagrammingPage(driver).getEdgeIconFirefox());
                sleepForSec(1000);
                Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getLineageHopInfoIcon()));
            } else {
                if(lineageIcon.equalsIgnoreCase("Copy Lineage Icon")) {
                    moveToElement(driver, new DiagrammingPage(driver).getCopyLineageEdgeIcon());
                    actionClick(driver, new DiagrammingPage(driver).getCopyLineageEdgeIcon());
                    Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getLineageHopInfoIcon()));
                }else if(lineageIcon.equalsIgnoreCase("Stich Lineage Icon")){
                    moveToElement(driver, new DiagrammingPage(driver).getStichLineageEdgeIcon());
                    actionClick(driver, new DiagrammingPage(driver).getStichLineageEdgeIcon());
                    Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getLineageHopInfoIcon()));
                }else if(lineageIcon.equalsIgnoreCase("Stich File Lineage Icon")){
                    moveToElement(driver, new DiagrammingPage(driver).getStichFileLineageEdgeIcon());
                    actionClick(driver, new DiagrammingPage(driver).getStichFileLineageEdgeIcon());
                    Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getLineageHopInfoIcon()));
                }
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + "is not clicked");
            Assert.fail("Diagram is not clicked" + e.getMessage());
        }
    }


    @Then("^user verifies the following in diagram$")
    public void userVerifiesTheFollowingInDiagram(DataTable data) throws Throwable {
        try {

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getItemIcon(values.get("itemName"), values.get("icon"))));

            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item icon is displayed");
            takeScreenShot("Item icon is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Item icon is not displayed", driver);
            Assert.fail("Item icon is not displayed");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item icon is not displayed");
        }
    }

    @And("^user verifies icon for end to end lineage is displayed$")
    public void userVerifiesIconForEndToEndLineageIsDisplayed() throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getLineageDropdownButton());
            } else {
                clickOn(new DiagrammingPage(driver).getLineageDropdownButton());
            }
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getEndToEndLineageIcon()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon for end to end lineage is displayed");
        } catch (Exception e) {
            takeScreenShot("Icon for end to end lineage is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for end to end lineage is not displayed");
            Assert.fail("Icon for end to end lineage is not displayed"+e.getMessage());
        }
    }

    @And("^user clicks on zoom in icon in diagram$")
    public void userClicksOnZoomInIconInDiagram() throws Throwable {
        try {
            new DiagrammingPage(driver).clickZoomInIcon();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Zoom in icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Icon for zoom in is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom in is not clicked");
            Assert.fail("Icon for zoom in is not clicked "+e.getMessage());
        }
    }


    @And("^user verifies diagram is displayed in diagramming page$")
    public void userVerifiesDiagramIsDisplayedInDiagrammingPage() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DiagrammingPage(driver).getDiagramImage()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Diagram is displayed");
        } catch (Exception e) {
            takeScreenShot("Diagramming is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Diagramming is not displayed"+e.getMessage());
        }
    }

    @And("^user verifies the following in Theme dropdown$")
    public void userVerifiesTheFollowingInThemeDropdown(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
             new DiagrammingPage(driver).clickThemeDropdownButton();
            for (CucumberDataSet data : dataTableCollection) {

                Assert.assertTrue(traverseListContainsElementText(new DiagrammingPage(driver).getThemeDropdownList(),data.getThemeListInDiagram()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values in Theme dropdown is displayed ");

        } catch (Exception e) {
            takeScreenShot( "Values in Theme dropdown is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail( "Values in Theme dropdown is not displayed" + e.getMessage());
        }
    }

    @And("^user verifies the following options in lineage not displayed$")
    public void userVerifiesTheFollowingOptionsInLineageNotDisplayed(DataTable data) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getRelationshipsDropDown());
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                Assert.assertFalse(traverseListContainsElementText(new DiagrammingPage(driver).getLineageDropDownList(), values.get("Options")));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Option is not displayed in the dropdown list");
        } catch (Exception e) {
            takeScreenShot("Option is  displayed in the dropdown list", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Option is  displayed in the dropdown list" + e.getMessage());
        }
    }

    @And("^user clicks the item info icon for the following item$")
    public void userClicksTheItemInfoIconForTheFollowingItem(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {

                    moveToElement(driver, new DiagrammingPage(driver).getItemInfoIcon(data.getLineageItemTypes(), data.getLineageItemNames()));
                    actionClick(driver, new DiagrammingPage(driver).getItemInfoIcon(data.getLineageItemTypes(), data.getLineageItemNames()));
                    waitForAngularLoad(driver);
                } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {

                    moveToElement(driver, new DiagrammingPage(driver).getItemInfoIcon(data.getLineageItemTypes(), data.getLineageItemNames()));
                    clickOn(new DiagrammingPage(driver).getItemInfoIcon(data.getLineageItemTypes(), data.getLineageItemNames()));
                    waitForAngularLoad(driver);

                } else if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge"))
                {
                    clickOn(new DiagrammingPage(driver).getItemEdge(data.getLineageItemNames()));
                    //  moveToElementUsingJavaScript(driver, new DiagrammingPage(driver).getItemInfoIconEdge(data.getLineageItemTypes(), data.getLineageItemNames()));
                    clickOn(new DiagrammingPage(driver).getItemInfoIconEdge(data.getLineageItemTypes(), data.getLineageItemNames()));

                }
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Option is not displayed in the dropdown list");
        } catch (Exception e) {
            takeScreenShot("Option is  displayed in the dropdown list", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Option is  displayed in the dropdown list" + e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" menu bar in hamburger menu$")
    public void user_clicks_on_menu_bar_in_hamburger_menu(String menu) throws Throwable {
        try {
            clickOn(new DiagrammingPage(driver).getToolBar(menu));
            sleepForSec(1000);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), menu + " is clicked");
        } catch (Exception e) {
            takeScreenShot("Item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Itemis not clicked");
            Assert.fail("Item is not clicked" + e.getMessage());
        }
    }

    @Given("^user clicks on reload button in hamburger menu$")
    public void user_clicks_on_reload_button_in_hamburger_menu() throws Throwable {
        try {
            clickOn(new DiagrammingPage(driver).getReloadButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Reload Button is clicked");
        } catch (Exception e) {
            takeScreenShot("Reload Button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Reload Button is not clicked");
            Assert.fail("Reload Button is not clicked" + e.getMessage());
        }
    }

    @And("^user selects the value from the dropdown for various operations in Diagramming page$")
    public void userSelectsFromTheDropdown(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                switch (values.get("dropdown")) {
                    case "relationships":
                        clickonWebElementwithJavaScript(driver,new DiagrammingPage(driver).getRelationshipsDropDown());
                        break;
                    case "select":
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getSelectDropDown());
                        break;
                    case "MoreActions":
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getMoreActionsDropDown());
                        break;
                    case "Lineage":
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getLineageDropdownButton());
                        break;
                }

                sleepForSec(500);
                WebElement element = traverseListContainsElementReturnsElement(new DiagrammingPage(driver).getDropDownList(values.get("option")), values.get("option"));
                clickonWebElementwithJavaScript(driver, element);
                sleepForSec(1000);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "option is selected from the dropdown list");
        } catch (Exception e) {
            takeScreenShot("Option is not selected from the dropdown list", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Option is not selected from the dropdown list" + e.getMessage());
        }
    }


    @And("^user selects the node with the node type and the node name$")
    public void userSelectsTheNodeWithTheNodeTypeAndTheNodeName(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                sleepForSec(1000);
                clickOn(new DiagrammingPage(driver).getNode(values.get("nodeType"), values.get("nodeName")));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "user clicks on the node with specified type");
        } catch (Exception e) {
            takeScreenShot("Node is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Node is not selected" + e.getMessage());
        }
    }


    @And("^user verifies whether the following image is present$")
    public void userVerifiesImageIsPresent(DataTable data) throws Throwable {
        try {
            Assert.assertTrue(sikuliUtil.sikuliOperation(data));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action performed in the screen");
        } catch (Exception e) {
            takeScreenShot("Action performed in the screen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Action performed in the screen" + e.getMessage());
        }
    }

    @And("^user performs click operation using sikuli$")
    public void userPerformsClickOperation(DataTable data) throws Throwable {
        try {
            Assert.assertTrue(sikuliUtil.sikuliOperation(data));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action performed in the screen");
        } catch (Exception e) {
            takeScreenShot("Action performed in the screen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Action performed in the screen" + e.getMessage());
        }
    }


    @And("^user clicks the hamburger menu and selects the option$")
    public void userClicksTheHamburgerMenuAndSelectsTheOption(List<CucumberDataSet> data) throws Throwable {
        try {
            for (CucumberDataSet values : data) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                    moveToElement(driver, new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                    actionClick(driver, new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                    sleepForSec(500);
                    actionClick(driver, traverseListContainsElementTextReturnsElement(new DiagrammingPage(driver).getHamburgerMenuList(), values.getHamburgerMenuList()));
                    sleepForSec(500);
                } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                    actionClick(driver, new DiagrammingPage(driver).getAnyDisplayedNode(values.getLineageItemTypes()));
                    moveToElement(driver, new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                    actionClick(driver,new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                    sleepForSec(500);
                    clickOn(traverseListContainsElementTextReturnsElement(new DiagrammingPage(driver).getHamburgerMenuList(), values.getHamburgerMenuList()));
                    sleepForSec(500);
                } else {
                    clickOn(new DiagrammingPage(driver).getItemEdge(values.getLineageItemTypes(), values.getLineageItemNames()));
                    sleepForSec(500);
                    clickOn(new DiagrammingPage(driver).getHamburgerIconEdgeFullSize(values.getLineageItemTypes(), values.getLineageItemNames()));
                    sleepForSec(500);
                    clickOn(traverseListContainsElementTextReturnsElement(new DiagrammingPage(driver).getHamburgerMenuList(), values.getHamburgerMenuList()));
                }
            }
            sleepForSec(3000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Selected the option from hamburger menu list");

        } catch (Exception e) {
            takeScreenShot("Option is not selected from the hamburger menu", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Option is not selected from the hamburger menu");
            Assert.fail("Option is not selected from the hamburger menu" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" icon in diagram$")
    public void userClicksOnZoomOutIconInDiagram(String zoom) throws Throwable {
        try {
            if (zoom.equalsIgnoreCase("zoom in")) {
                clickOn(new DiagrammingPage(driver).getZoomInIcon());
            } else {
                clickOn(new DiagrammingPage(driver).getZoomOutIcon());
            }
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Zoom icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Icon for zoom is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Icon for zoom out is not clicked");
            Assert.fail("Icon for zoom is not clicked " + e.getMessage());
        }
    }

    @And("^user enters \"([^\"]*)\" in the search box and clicks search icon in the Diagramming Page$")
    public void userEntersTextAndClicksOnSearchIcon(String text) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                enterText(new DiagrammingPage(driver).getDiagrammingSearchBox_Edge(), text);
            } else {
                enterText(new DiagrammingPage(driver).getDiagrammingSearchBox(), text);
            }
            clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getDiagrammingSearchIcon());
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "serach text is entered and search icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Search operation is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Search operation is not performed");
            Assert.fail("Search operation is not performed" + e.getMessage());
        }
    }

    @And("^exported file should be moved to the destination location$")
    public void userShouldAbleToDownloadTheFileInAndSaveIt(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            FileUtil.exportFile(dataTableCollection);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File got exported");
        } catch (Exception e) {
            takeScreenShot("File is not exported", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File is not exported");
            Assert.fail("File is not exported" + e.getMessage());
        }
    }

    @And("^user deletes the file \"([^\"]*)\" from \"([^\"]*)\"$")
    public void userDeletesTheSVGFile(String fileName, String filePath) throws Throwable {
        try {
            String path = propLoader.prop.getProperty(filePath);
            FileUtil.deleteFile(path, fileName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File got deleted");
        } catch (Exception e) {
            takeScreenShot("File is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File is not deleted");
            Assert.fail("File is not deleted" + e.getMessage());
        }
    }

    @And("^user clicks the hamburger menu for the node$")
    public void userClicksTheHamburgerMenuForTheNode(List<CucumberDataSet> data) throws Throwable {
        try {
            for (CucumberDataSet values : data) {
                if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                    moveToElement(driver, new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                    actionClick(driver, new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                } else {
                    actionClick(driver, new DiagrammingPage(driver).getAnyDisplayedNode(values.getLineageItemTypes()));
                    moveToElement(driver, new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                    clickOn(new DiagrammingPage(driver).getHamburgericon(values.getLineageItemTypes(), values.getLineageItemNames()));
                }
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on Hamburger menu");
        } catch (Exception e) {
            takeScreenShot("Hamburger menu is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Option is not selected from the hamburger menu");
            Assert.fail("Hamburger menu is not clicked" + e.getMessage());
        }
    }

    @And("^user hovers on diamond icon and click the info label icon$")
    public void userHoversOnDiamondIconAndClickInfoIcon() throws Throwable {
        try {
            moveToElement(driver, new DiagrammingPage(driver).getDiamondicon());
            clickOn(new DiagrammingPage(driver).getEdgeInfoIcon());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on edge info icon");
        } catch (Exception e) {
            takeScreenShot("Edge info icon is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Search operation is not performed");
            Assert.fail("Edge info icon is not clicked" + e.getMessage());
        }
    }

    @And("^user clicks on the icon in the diagramming page$")
    public void userClicksOntheIconInDiagrammingPage(List<CucumberDataSet> data) throws Throwable {
        try {
            for (CucumberDataSet values : data) {
                switch (values.getIconName()) {
                    case "ExpandAll":
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getExpandAllutton());
                        break;
                    case "CollapseAll":
                        clickonWebElementwithJavaScript(driver, new DiagrammingPage(driver).getCollapseAllButton());
                        break;
                    case "CollapseExpandButton":
                        clickOn(new DiagrammingPage(driver).getCollapseExpandButton());
                        break;
                }
                sleepForSec(1500);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User clicked on the icon from the tool bar");
        } catch (Exception e) {
            takeScreenShot("Icon is not slected from the tool bar", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Icon is not slected from the tool bar" + e.getMessage());
        }
    }

    @And("^user clicks on expand button for \"([^\"]*)\" node$")
    public void userClicksOnExpandButtonForTheNode(String nodeName) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                //moveToElement(driver, new DiagrammingPage(driver).getExpandButton(nodeName));
                actionClick(driver, new DiagrammingPage(driver).getExpandButton(nodeName));
                sleepForSec(500);
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                moveToElement(driver, new DiagrammingPage(driver).getExpandButtonEdge(nodeName));
                clickOn(new DiagrammingPage(driver).getExpandButtonEdge(nodeName));
            } else {
                moveToElement(driver, new DiagrammingPage(driver).getExpandButton(nodeName));
                clickOn(new DiagrammingPage(driver).getExpandButton(nodeName));
            }
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on expand button for the node");
        } catch (Exception e) {
            takeScreenShot("Can't able to click on the expand button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Search operation is not performed");
            Assert.fail("Can't able to click on the expand button" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" the slider to \"([^\"]*)\" in \"([^\"]*)\" section in diagramming page$")
    public void userTheSliderToInSectionInDiagrammingPage(String actionType, String elementName, String widgetName) throws Throwable {
        try {

            new DiagrammingActions(driver).genericActions(actionType,widgetName,elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName()," Item Name is present");

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName()," Item Name is not present");
            Assert.fail( "Item name not displayed" + e.getMessage());
        }
    }
    @And("^user \"([^\"]*)\" on \"([^\"]*)\" icon in LineageDiagramming page$")
    public void user_click_on_lineage_in_LineageDiagramming_page(String actionType, String elementName) throws Throwable {
        try {
            new DiagrammingActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Delete icon  is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon  is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();

        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" tab in Overview page$")
    public void user_click_on_lineage_tab_in_Overview_page(String actionType, String elementName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DiagrammingActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tab is clicked");
        } catch (Exception e) {
            takeScreenShot("Delete icon  is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tab  is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();

        }
    }

    @And("^user \"([^\"]*)\" in Diagramming Page$")
    public void userSelectsFromDiagrammingPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            waitForAngularLoad(driver);
            sleepForSec(2500);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new DiagrammingActions(driver).LineageDiagrammingpage(actionType, values.get("fieldName"), values.get("attribute"), values.get("pageName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType+" action is performed");
        } catch (Exception e) {
            takeScreenShot(actionType+" action is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(actionType+" action is not performed" + e.getMessage());
        }
    }

    @And("^user verifies the \"([^\"]*)\" operation is \"([^\"]*)\"$")
    public void userVerifiesDiagrammingoptions(String options, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DiagrammingActions(driver).genericActions(actionType, options);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), options + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(options + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), options + " is  not displayed");
            Assert.fail(options + " is  not displayed" + e.getMessage());
        }
    }


    @And("^user verifies the \"([^\"]*)\" is \"([^\"]*)\"$")
    public void userVerifiesItemViewpopupDiagrammingoptions(String options, String actionType) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new DiagrammingActions(driver).genericActions(actionType, options);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), options + " is  displayed");
        } catch (Exception e) {
            takeScreenShot(options + " is  not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), options + " is  not displayed");
            Assert.fail(options + " is  not displayed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" for \"([^\"]*)\" in LineageDiagramming page$")
    public void user_click_on_lineage_for_in_LineageDiagramming_page(String actionType, String elementName, String actionItem) throws Throwable {
        try {
            new DiagrammingActions(driver).genericActions(actionType, elementName, actionItem);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Delete icon  is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon  is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();

        }
    }

}