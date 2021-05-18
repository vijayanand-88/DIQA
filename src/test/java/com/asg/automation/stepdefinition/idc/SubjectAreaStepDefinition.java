package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.*;
import com.asg.automation.pageobjects.ida.AnalysisPage;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.DataSets;
import com.asg.automation.pageobjects.idc.RolesAndGroupManager;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.stepdefinition.restapi.RESTAPIDefinition;
import com.asg.automation.utils.*;
import com.asg.automation.wrapper.RestAPIWrapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import jnr.ffi.annotations.In;
import org.json.simple.parser.JSONParser;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.Point;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
import org.skyscreamer.jsonassert.JSONAssert;
import org.skyscreamer.jsonassert.JSONCompareMode;
import org.testng.Assert;

import java.io.FileReader;
import java.io.FileWriter;
import java.util.*;

import static com.asg.automation.utils.Constant.REST_DIR;
import static com.asg.automation.utils.Constant.REST_PAYLOAD;


/**
 * Created by thirveni.moganlal on 5/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class SubjectAreaStepDefinition extends DriverFactory {
    protected DBPostgresUtil db_postgres_util;
    public JsonRead jsonRead;
    private SolrUtil solr;
    private WebDriver driver;
    private CommonUtil commonUtil;
    private DBHelper dbHelper = new DBHelper();

    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            jsonRead = new JsonRead();
            solr = new SolrUtil();
            commonUtil = new CommonUtil();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }


    @After("@webtest")
    public void close() throws Exception {
        //new DriverFactory(BrowserName).destroyDriver();
        destroyDriver();

    }

    @When("^user checks the BigData checkbox in the BigData Subject Area Structure page$")
    public void user_checks_the_BigData_checkbox_in_the_BigData_Subject_Area_Structure_page() {
        try {
            scrollToWebElement(driver, new SubjectArea(driver).returntableFacetSelectionCheckbox());
            clickOn(new SubjectArea(driver).returntableFacetSelectionCheckbox());
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on first item tag in item list view$")
    public void user_clicks_on_first_item_tag_in_item_list_view() {
        try {
            sleepForSec(2000);
            new SubjectArea(driver).click_firstItemListTag();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on any page in the pagination tab$")
    public void user_clicks_on_any_page_in_the_pagination_tab() {
        try {
            int size = new SubjectArea(driver).returnitemListPagination().size();
            if (size != 0 && size >= 4) {
                new SubjectArea(driver).returnitemListPagination().get(size - 4).click();
            } else if (size == 0) {
                //LoggerUtil.Log.info("0 items on page");
            }

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on \"([^\"]*)\" button in the pagination$")
    public void user_clicks_on_button_in_the_pagination(String arg1) {
        try {
            if (new SubjectArea(driver).returnitemListPagination().size() != 0 && new SubjectArea(driver).returnitemListPagination().size() >= 4) {

                if (arg1.equalsIgnoreCase("next")) {
                    new SubjectArea(driver).click_paginationNextButton();
                    sleepForSec(1000);
                } else if (arg1.equalsIgnoreCase("previous")) {
                    new SubjectArea(driver).click_paginationPreviousButton();
                    sleepForSec(1000);
                } else if (arg1.equalsIgnoreCase("first")) {
                    new SubjectArea(driver).click_paginationFirstButton();
                    sleepForSec(1000);
                } else if (arg1.equalsIgnoreCase("last")) {
                    clickOn(new SubjectArea(driver).click_paginationLastButton());
                    sleepForSec(1000);
                }


            } else {
                //LoggerUtil.Log.info("Pagination does not exists");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user checks the Data Analysis checkbox in the BigData Subject Area Structure page$")
    public void user_checks_the_Data_Analysis_checkbox_in_the_BigData_Subject_Area_Structure_page() {
        try {
            new SubjectArea(driver).click_clusterDemoCheckbox();
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on next button in the pagination$")
    public void user_clicks_on_button_in_the_pagination() {
        try {
            new SubjectArea(driver).click_paginationNextButton();
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^warning message for multiple panels should be displayed$")
    public void warning_message_for_multiple_panels_should_be_displayed() {
        try {
            Assert.assertTrue(new SubjectArea(driver).verifyWarningMessage().isDisplayed());
            Assert.assertTrue(new SubjectArea(driver).verifyWarningMessageForClosePanel().isDisplayed());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Yes button in warning message$")
    public void user_clicks_on_Yes_button_in_warning_message() {
        try {
            new SubjectArea(driver).click_acceptWarning();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on Cancel button in warning message$")
    public void user_clicks_on_Cancel_button_in_warning_message() {
        try {
            new SubjectArea(driver).click_dismissWarning();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks \"([^\"]*)\" page in the pagination tab$")
    public void user_clicks_page_in_the_pagination_tab(String arg1) {
        try {
            List<WebElement> list = new SubjectArea(driver).returnitemListPagination();
            WebElement ele = traverseListContainsElementReturnsElement(list, arg1);
            clickOn(ele);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on \"([^\"]*)\" tagExpandingTriangleButton$")
    public void user_clicks_on_tagExpandingTriangleButton(String arg1) {
        try {
            if (arg1.equalsIgnoreCase("Data Analysis")) {

                new SubjectArea(driver).click_dataAnalysisTagCollapsingTriangleButton();
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on \"([^\"]*)\" tagCollapsingTriangleButton$")
    public void user_clicks_on_tagCollapsingTriangleButton(String arg1) {
        try {
            new SubjectArea(driver).click_dataAnalysisTagCollapsingTriangleButton();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on first item name link on the item list page$")
    public void user_clicks_on_first_item_name_link_on_the_item_list_page() {
        try {
            //storeTemporaryText(new SubjectArea(driver).returnfirstItemListName().getText());
            // tried with rest of the waits and since they did not work, so used thread.sleep
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1500);
            }
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound().get(0));
            sleepForSec(1000);
            waitForAngularLoad(driver);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on randon item name link on the item list page$")
    public void user_clicks_on_randon_item_name_link_on_the_item_list_page() throws Throwable {
        try {
            //storeTemporaryText(new SubjectArea(driver).returnfirstItemListName().getText());
            // tried with rest of the waits and since they did not work, so used thread.sleep
            sleepForSec(1000);
            Random random = new Random();
            int max = 5;
            int min = 1;
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getItemNames().get(random.nextInt(max - min + 1) + min));
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on second item on the item list page$")
    public void user_clicks_on_second_item_on_the_item_list_page() {
        try {
            clickOn(new SubjectArea(driver).returnfirstItemIntableOfItemsFound().get(1));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be in Subject Area page$")
    public void user_should_be_in_Subject_Area_page() {
        try {
            new SubjectArea(driver).verifyStructure().isDisplayed();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^items list page should open with pagination$")
    public void items_list_page_should_open_with_pagination() {
        try {
            isElementPresent(new SubjectArea(driver).returnitemListPageTitle());
            synchronizationVisibilityofElementsList(driver, new SubjectArea(driver).returnitemListPagination());
            takeScreenShot("MLP_814_975_836_Verification of item list with pagination", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_814_975_836_Verification of item list with pagination", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the clicked page should get highlighted$")
    public void the_clicked_page_should_get_highlighted() {
        try {
            waitForPageLoads(driver, 5);
            int size = new SubjectArea(driver).returnitemListPagination().size();
            if (size != 0 && size >= 4) {
                verifyTrue(verifyContains(new SubjectArea(driver).returnitemListPaginationClassNames().get(4).getAttribute("class"), "active"));
            } else if (size == 1) {
                verifyTrue(verifyContains(new SubjectArea(driver).returnitemListPaginationClassNames().get(2).getAttribute("class"), "active"));
            } else {
                //LoggerUtil.Log.info("0 items on page");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^item list with search text should be displayed$")
    public void item_list_with_search_text_should_be_displayed() {

        try {
            new SubjectArea(driver).getSearchItemList().get(0).isDisplayed();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search list is displayed");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^subject Area tag structure should be displayed$")
    public void subject_Area_tag_structure_should_be_displayed() {
        try {
            new SubjectArea(driver).returnTagStructure().isDisplayed();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the \"([^\"]*)\" page should get highlighted and displayed$")
    public void the_page_should_get_highlighted_and_displayed(String arg1) {
        int paginationSize = new SubjectArea(driver).returnitemListPagination().size();
        try {
            if (arg1.equalsIgnoreCase("next")) {
                verifyTrue(verifyContains(getAttributeValue(new SubjectArea(driver).returnitemListPaginationClassNames().get(3), ("class")), "active"));
            } else if (arg1.equalsIgnoreCase("previous")) {
                verifyTrue(verifyContains(new SubjectArea(driver).returnitemListPaginationClassNames().get(paginationSize - 4).getAttribute("class"), "active"));
            } else if (arg1.equalsIgnoreCase("first")) {
                verifyTrue(verifyContains(new SubjectArea(driver).returnitemListPaginationClassNames().get(2).getAttribute("class"), "active"));
            } else if (arg1.equalsIgnoreCase("last")) {
                verifyTrue(verifyContains(new SubjectArea(driver).returnitemListPaginationClassNames().get(paginationSize - 3).getAttribute("class"), "active"));
            }
            takeScreenShot("MLP_975_Verification of pagination functionality", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_975_Verification of pagination functionality", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Then("^tag expanding and collapsing triangle buttons should display$")
    public void tag_expanding_and_collapsing_triangle_buttons_should_display() {
        try {
            isElementPresent(new SubjectArea(driver).returndataAnalysisTagCollapsingTriangleButton());
            takeScreenShot("MLP_971_Verification of collapsing buttons", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_971_Verification of collapsing buttons", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^subtags of the \"([^\"]*)\" tag should get displayed$")
    public void subtags_of_the_tag_should_get_displayed(String arg1) {
        try {
            verifyTrue(isElementsListPresent(new SubjectArea(driver).returndataAnalysisSubTags()));
            takeScreenShot("MLP_971_Verification of expanding of tag structure", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_971_Verification of expanding of tag structure", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^subtags of the \"([^\"]*)\" tag should not get displayed$")
    public void subtags_of_the_tag_should_not_get_displayed(String arg1) {
        try {
            verifyTrue(isElementsListPresent(new SubjectArea(driver).returndataAnalysisSubTagsWithNoSync()));
            takeScreenShot("MLP_971_Verification of collapsing of tag structure", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_971_Verification of collapsing of tag structure", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on first item Name in item list view from search result$")
    public void user_clicks_on_first_item_Name_in_item_list_view_from_search_result() {
        try {
            clickOn(new SubjectArea(driver).returnfirstItemListName());
            waitForAngularLoad(driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user enters the search text and clicks on search on Subject Area page$")
    public void user_enters_the_search_text_and_clicks_on_search_on_Subject_Area_page() {

        try {
            new SubjectArea(driver).enterTextAndClickSearch();
            sleepForSec(500);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user enters the search text for adding a comment and clicks on search on Subject Area page$")
    public void user_enters_the_search_text_for_adding_a_comment_and_clicks_on_search_on_Subject_Area_page() {
        try {
            //enterText(new DashBoardPage(driver).returntopSearchBox(), new JsonRead().readJSon("subjectAreaSearchText", "SearchTextForComment"));
            enterText(new DashBoardPage(driver).returntopSearchBox(), new JsonRead().readJSon("updateSubjectAreaName1", "Name"));
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(2000);
                clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
                sleepForSec(1000);
            } else {
                clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            }
            sleepForSec(200);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Could not find the search box/ Enter the search text" + e.getMessage());
        }
    }

    @Given("^user enters the search text for adding a comment and clicks on search in Subject Area page$")
    public void user_enters_the_search_text_for_adding_a_comment_and_clicks_on_search_in_Subject_Area_page() {
        try {
            enterText(new DashBoardPage(driver).returntopSearchBox(), new JsonRead().readJSon("subjectAreaSearchText", "SearchTextForComment"));
            //enterText(new DashBoardPage(driver).returntopSearchBox(), new JsonRead().readJSon("updateSubjectAreaName1", "Name"));
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(2000);
                clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
                sleepForSec(1000);
            } else {
                clickOn(new DashBoardPage(driver).returngetTopSearchIcon());
            }
            sleepForSec(200);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Could not find the search box/ Enter the search text" + e.getMessage());
        }
    }

    @Then("^user should be able to see quality label$")
    public void user_should_be_able_to_see_quality_label() {
        try {
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            //LoggerUtil.Log.info("Quality label is not visible" + e.getMessage());
        }
    }


    @Then("^preview page of that item should get displayed$")
    public void preview_page_of_that_item_should_get_displayed() {
        try {
            waitandFindElement(driver, new SubjectArea(driver).returnitemPreviewPage(), 4, false);
            isElementPresent(new SubjectArea(driver).returnitemPreviewPage());
            takeScreenShot("MLP_814_Verification of display of preview page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_814_Verification of display of preview page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^full view page of that item should get displayed$")
    public void full_view_page_of_that_item_should_get_displayed() {
        try {
            new SearchDefinitionActions(driver).genericVerifyElementPresent("Item Full view page");
            takeScreenShot("MLP_814_Verification of display of fullview page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_814_Verification of display of fullview page", driver);
            Assert.fail(e.getMessage());
        }
    }

    @Then("^access points should get displayed in the item full view page$")
    public void access_points_should_get_displayed_in_the_item_ull_view_page() {
        try {
            isElementPresent(new SubjectArea(driver).returnitemOverviewAccessPoint());
            //isElementPresent(new SubjectArea(driver).returnitemDataSamplingAccessPoint());
            //isElementPresent(new SubjectArea(driver).returnitemLineageAccessPoint());
//            isElementPresent(new SubjectArea(driver).returnitemCommentsAccessPoint());
            takeScreenShot("MLP_836_Verification of access points", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_836_Verification of access points", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on first item's type$")
    public void user_clicks_on_first_item_s_type() {
        try {
            sleepForSec(1000);
            //clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnfirstItemType());
            clickOn(new SubjectArea(driver).returnfirstItemType());
            sleepForSec(500);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see quality label in preview page$")
    public void user_should_be_able_to_see_quality_label_in_preview_page() {
        try {
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
            takeScreenShot("Verification of Quality label is present or not in preview item page", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Quality label is present or not in preview item page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quality label not present" + e.getMessage());
        }
    }

    @When("^user enters the search text for bad quality and clicks on search on Subject Area page$")
    public void user_enters_the_search_text_for_bad_quality_and_clicks_on_search_on_Subject_Area_page() {
        try {
            enterText(new SubjectArea(driver).retrunsearchBox(),
                    new JsonRead().readJSon("subjectAreaSearchText", "BadQuality"));
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunsearchButton());
            sleepForSec(500);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user enters the search text for good quality and clicks on search on Subject Area page$")
    public void user_enters_the_search_text_for_good_quality_and_clicks_on_search_on_Subject_Area_page() {
        try {
            enterText(new SubjectArea(driver).retrunsearchBox(),
                    new JsonRead().readJSon("subjectAreaSearchText", "GoodQuality"));
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunsearchButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see quality label in preview page as Red and Quality control as Bad$")
    public void user_should_be_able_to_see_quality_label_in_preview_page_as_Red_and_Quality_control_as_Bad() {
        try {
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
            isElementPresent(new SubjectArea(driver).returnqualityColorRed());
            clickOn(new SubjectArea(driver).getCompressScreenButton());
            sleepForSec(1000);
            isElementPresent(new SubjectArea(driver).returnqualityColorRed());
            //verifyEquals("Bad", new SubjectArea(driver).returnqulityLabelDescription().getText());
            takeScreenShot("Verification of Quality Bad", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Quality Bad", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quality label not present" + e.getMessage());
        }
    }

    @Then("^user should be able to see quality label in preview page as Yellow and Quality label as Good$")
    public void user_should_be_able_to_see_quality_label_in_preview_page_as_Yellow_and_Quality_label_as_Good() {
        try {
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
            isElementPresent(new SubjectArea(driver).returnqualityColorYellow());
            clickOn(new SubjectArea(driver).getCompressScreenButton());
            isElementPresent(new SubjectArea(driver).returnqualityColorYellow());
            //verifyEquals("Good", new SubjectArea(driver).returnqulityLabelDescription().getText());
            takeScreenShot("Verification of Quality Good", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Quality Good", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quality label not present" + e.getMessage());
        }
    }

    @When("^user enters the search text for Excellent quality and clicks on search on Subject Area page$")
    public void user_enters_the_search_text_for_Excellent_quality_and_clicks_on_search_on_Subject_Area_page() {
        try {
            enterText(new SubjectArea(driver).retrunsearchBox(),
                    new JsonRead().readJSon("subjectAreaSearchText", "ExcellentQuality"));
            clickOn(new SubjectArea(driver).retrunsearchButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see quality label in preview page as Green and Quality label as Excellent$")
    public void user_should_be_able_to_see_quality_label_in_preview_page_as_Green_and_Quality_label_as_Excellent() {
        try {
            waitandFindElement(driver, new SubjectArea(driver).returnqualityLabel(), 6, false);
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
            //sleepForSec(300);
            isElementPresent(new SubjectArea(driver).returnqualityColorGreen());
            clickOn(new SubjectArea(driver).getCompressScreenButton());
            isElementPresent(new SubjectArea(driver).returnqualityColorGreen());
            //verifyEquals("Excellent", new SubjectArea(driver).returnqulityLabelDescription().getText());
            takeScreenShot("Verification of Quality Excellent", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Quality Excellent", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quality label not present" + e.getMessage());
        }
    }

    @Then("^user verifies quality label is not present$")
    public void user_verifies_quality_label_not_present() {
        try {
            Assert.assertFalse(isElementPresent(new SubjectArea(driver).returnqualityLabelInCurrentpanel()));
            takeScreenShot("Verification of Quality Excellent", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Quality Excellent", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quality label not present" + e.getMessage());
        }
    }

    @When("^user enters the search text for Not Applicable quality and clicks on search on Subject Area page$")
    public void user_enters_the_search_text_for_Not_Applicable_quality_and_clicks_on_search_on_Subject_Area_page() {
        try {
            enterText(new SubjectArea(driver).retrunsearchBox(),
                    new JsonRead().readJSon("subjectAreaSearchText", "NotApplicable"));

            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunsearchButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see quality label in preview page as Green and Quality label as Not Applicable$")
    public void user_should_be_able_to_see_quality_label_in_preview_page_as_Green_and_Quality_label_as_Not_Applicable() {
        try {
            isElementPresent(new SubjectArea(driver).returnqualityLabel());
            isElementPresent(new SubjectArea(driver).returnqualityColorNotApply());
            clickOn(new SubjectArea(driver).returnfullScreenButton());
            isElementPresent(new SubjectArea(driver).returnqualityColorNotApply());
            //verifyEquals("Not Applicable", new SubjectArea(driver).returnqulityLabelDescription().getText());
            takeScreenShot("Verification of Quality Excellent", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Quality Excellent", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quality label not present" + e.getMessage());
        }
    }

    @Then("^user should be seeing Comments and no comments Label$")
    public void user_should_be_seeing_Comments_and_no_comments_Label() {
        try {
            sleepForSec(1000);
            isElementPresent(new SubjectArea(driver).returncommentLabel());
//            isElementPresent(new SubjectArea(driver).returnnoCommentsLabel());
            takeScreenShot("MLP-1205 Verification of Comment section for an item with default text message", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of Comment section for an item with default text message", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Comments label not present" + e.getMessage());
        }
    }

    @When("^user clicks on Leave comment link and give empty comment$")
    public void user_clicks_on_Leave_comment_link_and_give_empty_comment() {
        try {
//            waitandFindElement(driver, new SubjectArea(driver).returnleaveCommentButton(), 6, false);
//            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnleaveCommentButton());
            sleepForSec(1500);
            enterText(new SubjectArea(driver).returncommentTextBox(), "      ");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("could not click on leave comment button or text box is not found");
        }
    }

    @Then("^user should not be able to add a comment$")
    public void user_should_not_be_able_to_add_a_comment() {
        try {
            verifyFalse(new SubjectArea(driver).returnpostCommentButtom().isEnabled());
            takeScreenShot("MLP-1205 Verification of Comment section for an empty comment", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of Comment section for an empty comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("post comment button is enabled for null comment" + e.getMessage());
        }
    }

    @When("^user clicks on Leave comment link and give some text comment$")
    public void user_clicks_on_Leave_comment_link_and_give_some_text_comment() {
        try {
//            waitandFindElement(driver, new SubjectArea(driver).returnleaveCommentButton(), 6, false);
//            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnleaveCommentButton());
            enterText(new SubjectArea(driver).returncommentTextBox(), "Testing the comment");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Comment could not be added" + e.getMessage());
        }
    }

    @Then("^user should be able to add a comment$")
    public void user_should_be_able_to_add_a_comment() {
        try {
            clickOn(new SubjectArea(driver).returnpostCommentButtom());
        } catch (Exception e) {
            takeScreenShot("Verification of Comment section for text comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Comment could not posted" + e.getMessage());
        }
    }


    @When("^user checks comment section with count is displayed$")
    public void user_checks_comment_section_with_count_is_displayed() {
        try {
            new SubjectArea(driver).itemComments().isDisplayed();
            if (isElementPresent(new SubjectArea(driver).itemCommentsCount())) {
                Assert.assertTrue(true);
            } else {
                new SubjectArea(driver).click_leaveCommentButton();
                new SubjectArea(driver).enter_comments(new JsonRead().readJSon("subjectAreaComments", "Name"));
                new SubjectArea(driver).click_postComments();
                new SubjectArea(driver).itemCommentsCount().isDisplayed();
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on view all comments$")
    public void user_clicks_on_view_all_comments() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                new SubjectArea(driver).click_viewAllComments();
            }
            // waitandFindElement(driver,new SubjectArea(driver).click_viewAllComments(),6,false);
            new SubjectArea(driver).click_viewAllComments();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on view all comments and add admin comments$")
    public void user_clicks_on_view_all_comments_and_add_admin_comments() {
        try {
            //new SubjectArea(driver).click_commentsSection();
            sleepForSec(1000);
            new SubjectArea(driver).click_viewAllComments();
            new SubjectArea(driver).enter_comments(new JsonRead().readJSon("subjectAreaComments1", "Name"));
            new SubjectArea(driver).click_postComments();
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on view all comments and add user comments$")
    public void user_clicks_on_view_all_comments_and_user_admin_comments() {
        try {
            sleepForSec(1000);
            new SubjectArea(driver).click_viewAllComments();
            new SubjectArea(driver).enter_comments(new JsonRead().readJSon("subjectAreaComments2", "Name"));
            new SubjectArea(driver).click_postComments();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^all comments assigned to a data element should be displayed$")
    public void all_comments_assigned_to_a_data_element_should_be_displayed() {
        try {
            new SubjectArea(driver).click_viewAllComments();
            Assert.assertTrue(new SubjectArea(driver).get_commentsContainer().isDisplayed());

        } catch (Exception e) {
            takeScreenShot("Listing of all comments", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user check show comments and selects all user dropdown$")
    public void user_check_show_comments_and_selects_all_user_dropdown() {
        try {
            new SubjectArea(driver).get_showComments().isDisplayed();
            new SubjectArea(driver).click_commentsDropdownButton();
            sleepForSec(1000);
            WebElement dropdown = traverseListContainsElementReturnsElement(new SubjectArea(driver).get_CommentsDropdown(), "All");
            clickOn(dropdown);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user check show comments and selects info user dropdown$")
    public void user_check_show_comments_and_selects_info_user_dropdown() {
        try {
            isElementPresent(new SubjectArea(driver).get_showComments());
            sleepForSec(1000);
            new SubjectArea(driver).click_commentsDropdownButton();
            WebElement dropdown = traverseListContainsElementReturnsElement(new SubjectArea(driver).get_CommentsDropdown(), "TestInfo");
            clickOn(dropdown);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^comments related to all users should be displayed$")
    public void comments_related_to_all_users_should_be_displayed() {
        try {
//            verifyTrue(traverseListContainsElement(new SubjectArea(driver).get_commentsList(), new JsonRead().readJSon("subjectAreaComments1", "Name")));
            verifyTrue(traverseListContainsElement(new SubjectArea(driver).get_commentsList(), new JsonRead().readJSon("subjectAreaComments2", "Name")));
        } catch (Exception e) {
            takeScreenShot("Filtering Comments for all users", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^comments related to info user should be displayed$")
    public void comments_related_to_info_user_should_be_displayed() {
        try {
            verifyTrue(traverseListContainsElement(new SubjectArea(driver).get_commentsList(), new JsonRead().readJSon("subjectAreaComments2", "Name")));
        } catch (Exception e) {
            takeScreenShot("Filtering Comments for Info users", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^full qualified name of the item should get displayed in the item preview page$")
    public void full_qualified_name_of_the_item_should_get_displayed_in_the_item_preview_page() {

        try {

            verifyTrue(traverseListContainsElement(new SubjectArea(driver).returnpreviewPageItemFullQualifiedName(), CommonUtil.getText().trim()));
        } catch (Exception e) {
            takeScreenShot("MLP_919_Verification of Full Qualified Name of Preview Page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^full qualified name of the item should get displayed in the item full view page$")
    public void full_qualified_name_of_the_item_should_get_displayed_in_the_item_full_view_page() {
        try {
            verifyTrue(traverseListContainsElement(new SubjectArea(driver).returnfullviewPageItemFullQualifiedName(), CommonUtil.getText().trim()));
        } catch (Exception e) {
            takeScreenShot("MLP_919_Verification of Full Qualified Name of Fullview Page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^set of properties of the item should get displayed in the item preview page$")
    public void set_of_properties_of_the_item_should_get_displayed_in_the_item_preview_page() {
        try {
            isElementPresent(new SubjectArea(driver).returnpreviewPageItemPropertiesTitle());
            isElementsListPresent(new SubjectArea(driver).returnpreviewPageItemPropertiesList());
        } catch (Exception e) {
            takeScreenShot("MLP_917_Verification of item properties in Preview page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^set of properties of the item should get displayed in the item full view page$")
    public void set_of_properties_of_the_item_should_get_displayed_in_the_item_full_view_page() {
        try {
            sleepForSec(1000);
            //waitandFindElement(driver,new SubjectArea(driver).returnfullviewPageItemPropertiesTitle(),3,false);
            isElementPresent(new SubjectArea(driver).returnfullviewPageItemPropertiesTitle());
            isElementsListPresent(new SubjectArea(driver).returnfullviewPageItemPropertiesList());
            takeScreenShot("MLP_917_Verification of item properties in Fullview page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_917_Verification of item properties in Fullview page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @Then("^item header and its type should be displayed in the item preview page$")
    public void item_header_and_its_type_should_be_displayed_in_the_item_preview_page() {


    }

    @Then("^items list page should open with out pagination if there is only one page$")
    public void items_list_page_should_open_with_out_pagination_if_there_is_only_one_page() {
        try {
            int size = new SubjectArea(driver).returnitemListPagination().size();
            if (size != 0 && size > 1) {
                //LoggerUtil.Log.info("Pagination exists");
            } else if (size != 0 && size == 1) {
                Boolean flag = isElementPresent(new SubjectArea(driver).returnpaginationNextButton());
                verifyFalse(flag);
                //LoggerUtil.Log.info("Pagination does not exists");
            } else {
                //LoggerUtil.Log.info("0 item found for the selected tags");
            }
            takeScreenShot("MLP_1035_Verification of pagination for one page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1035_Verification of pagination for one page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }


    }

    @Then("^the one page without pagination should be highlighted$")
    public void the_one_page_without_pagination_should_be_highlighted() {
        try {
            int size = new SubjectArea(driver).returnitemListPagination().size();
            if (size != 0 && size > 1) {
                //LoggerUtil.Log.info("Pagination exists");
            } else if (size != 0 && size == 1) {
                //LoggerUtil.Log.info("Pagination does not exists");
                verifyTrue(verifyContains(new SubjectArea(driver).returnitemListPaginationClassNames().get(0).getAttribute("class"), "active"));
            } else {
                //LoggerUtil.Log.info("0 items found for the selected tags");
            }
            takeScreenShot("MLP_1035_Verification of page highlight if only one page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1035_Verification of page highlight if only one page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should not be able to see Delete the button for Comment$")
    public void user_should_not_be_able_to_see_Delete_the_button_for_Comment() {
        try {
            Assert.assertFalse(isElementPresent(new SubjectArea(driver).returncommentDeleteButtonWithNoSync()));
            takeScreenShot("Verification of Delete button in Comment section in other user profiles than a user created profile", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Delete button in Comment section in other user profiles than a user created profile", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Delete button for Comment is available for other user profiles as well " + e.getMessage());
        }
    }

    @When("^user edits the posted comment and clicks on post comment$")
    public void user_edits_the_posted_comment_and_clicks_on_post_comment() {
        try {
            sleepForSec(1000);
            //clickOn(new SubjectArea(driver).returnEditCommentButton());
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnEditCommentButton());
            enterText(new SubjectArea(driver).returneditCommentTextBox(), new JsonRead().readJSon("subjectAreaSearchText", "Comment"));
            clickOn(new SubjectArea(driver).returnsaveButtonofeditCommentTextox());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Coluld not edit the comment" + e.getMessage());

        }

    }

    @Then("^comment should be saved$")
    public void comment_should_be_saved() {
        // Write code here that turns the phrase above into concrete actions
        try {
            verifyEquals(new SubjectArea(driver).returnfirstCommentText().getText(),
                    new JsonRead().readJSon("subjectAreaSearchText", "Comment"));
            takeScreenShot("MLP-1205 Verification of Editing an Existing Comment", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of Editing an Existing Comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Editted comment is not matching with a newly added comment" + e.getMessage());
        }
    }

    @When("^user Clicks on reply button and writes a reply and click on Send button$")
    public void user_Clicks_on_reply_button_and_writes_a_reply_and_click_on_Send_button() {
        try {
            //clickOn(new SubjectArea(driver).returnfirstCommentReplyButton());
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnfirstCommentReplyButton());
            enterText(new SubjectArea(driver).returnreplyToConmmentBox(),
                    new JsonRead().readJSon("subjectAreaSearchText", "ReplyToComment"));
            clickOn(new SubjectArea(driver).returnsendButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Colud not add a reply to a comment" + e.getMessage());
        }
    }

    @Then("^Reply should be saved and visible in the comments page$")
    public void reply_should_be_saved_and_visible_in_the_comments_page() {
        try {
            verifyEquals(new SubjectArea(driver).returntextOfFirstReplyOfComment().getText(),
                    new JsonRead().readJSon("subjectAreaSearchText", "ReplyToComment"));
            takeScreenShot("Verification of Giving reply to existing an Comment", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Giving reply to existing an Comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Added reply is mismatching" + e.getMessage());
        }
    }

    @Then("^user should not be able to see Edit button for Comment$")
    public void user_should_not_be_able_to_see_Edit_button_for_Comment() {

        try {
            Assert.assertFalse(isElementPresent(new SubjectArea(driver).returnEditCommentButtonwithoutSync()));
            takeScreenShot("Verification of Edit button in Comment section in other user profiles than a user created profile", driver);
        } catch (Exception e) {
            takeScreenShot("Verification of Edit button in Comment section in other user profiles than a user created profile", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Edit Comment button is present in the other user profile");
        }

    }

    @Then("^Reply should be saved and visble in the comments page$")
    public void reply_should_be_saved_and_visble_in_the_comments_page() {
        try {
            verifyEquals(new SubjectArea(driver).returntextOfFirstReplyOfComment().getText(),
                    new JsonRead().readJSon("subjectAreaSearchText", "ReplyToComment"));
            takeScreenShot("MLP-1205 Verification of Giving reply to existing an Comment", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of Giving reply to existing an Comment", driver);
            Assert.fail("Added reply is mismatching" + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user should be able to see the Date and time of the comment$")
    public void user_should_be_able_to_see_the_Date_and_time_of_the_comment() {
        try {
            isElementPresent(new SubjectArea(driver).returntimeStampOfComment());
            takeScreenShot("MLP-1205 Verification of Timestamp of a Comment", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of Timestamp of a Comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Timestamp of comment is missing" + e.getMessage());

        }
    }

    @Then("^User should see the image icon in comments$")
    public void user_should_see_the_image_icon_in_comments() {
        try {
            sleepForSec(1000);
            isElementPresent(new SubjectArea(driver).returnimgaeIconOfComment());
            takeScreenShot("MLP-1205 Verification of image icon of Comment", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of image icon of Comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Image icon of comment is missing" + e.getMessage());
        }
    }

    @When("^user clicks on Delete button on comment$")
    public void user_clicks_on_Delete_button_on_comment() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickOn(new SubjectArea(driver).returncommentDeleteButton());
            } else {
//                implicit_wait(driver, 5);
                clickOn(new SubjectArea(driver).returncommentDeleteButton());
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Comment Delete Button could not be found " + e.getMessage());
        }
    }

    @When("^user accepts the alerts$")
    public void user_accepts_the_alerts() {

        try {
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnAlertYes());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Alert button colud not be clicked " + e.getMessage());
        }

    }

    @Then("^comment should be deleted$")
    public void comment_should_be_deleted() {
        try {

            clickOn(new SubjectArea(driver).returncloseButton());
            Assert.assertFalse(new SubjectArea(driver).returnnoCommentsLabel());
            takeScreenShot("MLP-1205 Verification of Deleting a Comment", driver);

        } catch (Exception e) {
            takeScreenShot("MLP-1205 Verification of Deleting a Comment", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("First Comment is not deleted yet" + e.getMessage());
        }
    }

    @When("^user checks the facets of BigData catalog and Type as Table$")
    public void user_checks_the_facets_of_BigData_catalog_and_Type_as_Table() {

        try {
            clickOn(new SubjectArea(driver).returnTableemptyCheckbox());
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Facet search coluld not be selected" + e.getMessage());
        }

    }

    @When("^user clicks the save search button$")
    public void user_clicks_the_save_search_button() {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnsaveSearchButton());
                sleepForSec(1000);
                storeTemporaryText(new SubjectArea(driver).getItemCount().getText());
            } else {
//                scrollToWebElement(driver, new SubjectArea(driver).returnsaveSearchButton());
                clickOn(driver, new SubjectArea(driver).returnsaveSearchButton());
                sleepForSec(2000);
                storeTemporaryText(new SubjectArea(driver).getItemCount().getText());
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search save button could not be clicked" + e.getMessage());
        }
    }

    @When("^User enters the search name, Description and choose the widget BigData$")
    public void user_enters_the_search_name_Description_and_choose_the_widget_BigData() {
        try {
            waitandFindElement(driver, new SubjectArea(driver).returnsearchName(), 3, false);
            enterText(new SubjectArea(driver).returnsearchName(), jsonRead.readJSon("QuickLink", "Search Name"));
            sleepForSec(500);
            enterText(new SubjectArea(driver).returnsearchDescription(), jsonRead.readJSon("QuickLink", "Search Description"));
            clickOn(new SubjectArea(driver).returnbigDataWidgetselectionCheckbox());
            clickOn(new SubjectArea(driver).returnSearchSaveButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search name and description could not be entered" + e.getMessage());
        }
    }

    @Then("^Search quick link should be created in Big Data widget$")
    public void search_quick_link_should_be_created_in_Big_Data_widget() {

        try {
            clickOn(new SubjectArea(driver).returnSearchSaveButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search coluld not be saved" + e.getMessage());
        }

    }

    @Then("^search should be retruing only one table result$")
    public void search_should_be_retruing_only_one_table_result() {
        try {

            Assert.assertEquals(new SubjectArea(driver).retrunsearchItemResults().size(), 1);
            takeScreenShot("MLP-1104 Verification of Quicklink click operation", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search is having multiple results" + e.getMessage());
        }
    }

    @When("^user saves the search using duplicate name and description$")
    public void user_saves_the_search_using_duplicate_name_and_description() {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnsaveSearchButton());
            enterText(new SubjectArea(driver).returnsearchName(), jsonRead.readJSon("QuickLink", "Database search"));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search is having multiple results" + e.getMessage());

        }

    }

    @Then("^user should be seeing a alert saying that duplicate link exist$")
    public void user_should_be_seeing_a_alert_saying_that_duplicate_link_exist() {

        try {
            isElementPresent(new SubjectArea(driver).returnduplicateLink());
            takeScreenShot("MLP-1104 Verification of Duplicate quicklink", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search is not duplicate link" + e.getMessage());
        }

    }

    @When("^user should be seeing the search result and saves the solr search in BigData Widget$")
    public void user_should_be_seeing_the_search_result_and_saves_the_solr_search_in_BigData_Widget() {

        try {

            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnsaveSearchButton());
            enterText(new SubjectArea(driver).returnsearchName(), jsonRead.readJSon("QuickLink", "Solr Name"));
            enterText(new SubjectArea(driver).returnsearchDescription(), jsonRead.readJSon("QuickLink", "Solr Description"));
            clickOn(new SubjectArea(driver).returnquickLinkWidgetselectionCheckbox());

        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("solr search could not be saved" + e.getMessage());

        }

    }

    @Then("^user should be able to save the search$")
    public void user_should_be_able_to_save_the_search() {
        try {
            clickOn(new SubjectArea(driver).returnSearchSaveButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search coluld not be saved" + e.getMessage());
        }

    }


    @Then("^rating facet for five stars and count should be displayed$")
    public void rating_facet_for_five_stars_and_count_should_be_displayed() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).getRatingFacet()));
            verifyEquals(new SubjectArea(driver).getRatingFacetList().size(), 5);
            verifyEquals(new SubjectArea(driver).getRatingFacetCountList().size(), 5);
            takeScreenShot("MLP-1507 Verification of Rating facet", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Rating facet is not displayed" + e.getMessage());
        }
    }

    @When("^user clicks on rating (\\d+) checkbox and get item count$")
    public void user_clicks_on_rating_checkbox_and_get_item_count(int rating) throws Throwable {
        try {
            waitForAngularLoad(driver);
            switch (rating) {
                case 1:
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).ratingOneCheckbox());
                    break;
                case 2:
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).ratingTwoCheckbox());
                    break;
                case 3:
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).ratingThreeCheckbox());
                    break;
                case 4:
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).ratingFourCheckbox());
                    break;
                case 5:
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).ratingFiveCheckbox());
                    break;
            }

            sleepForSec(1000);
            String itemsCount = new SubjectArea(driver).getItemCount().getText();
            storeTemporaryText(commonUtil.getNUMfromString(itemsCount));
            if (Integer.parseInt(commonUtil.getNUMfromString(itemsCount)) > 0) {
                List<String> itemNames = new ArrayList<String>();
                for (WebElement ele : new SubjectArea(driver).getItemNames()) {

                    itemNames.add(ele.getText());
                }
                commonUtil.storeTemporaryList(itemNames);
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Checkbox for rating is not displayed" + e.getMessage());
        }
    }

    @Then("^solr search count should be matched for rating (\\d+)$")
    public void solr_search_count_should_be_matched_for_rating(int rating) throws Throwable {
        try {
            String query = null;
            switch (rating) {
                case 1:
                    query = "asg.ratingAvg_d:[1.0 TO 1.9]";
                    break;
                case 2:
                    query = "asg.ratingAvg_d:[2.0 TO 2.9]";
                    break;
                case 3:
                    query = "asg.ratingAvg_d:[3.0 TO 3.9]";
                    break;
                case 4:
                    query = "asg.ratingAvg_d:[4.0 TO 4.9]";
                    break;
                case 5:
                    query = "asg.ratingAvg_d:5.0";
                    break;
            }

            long solrCount = solr.Solr_SearchCount(query, "schema_s=BigData", "/select");
            long count = Integer.parseInt(getTemporaryText());
            verifyEquals(count, solrCount);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Count mismatch" + e.getMessage());
        }
    }

    @Then("^solr item names should be matched for rating (\\d+)$")
    public void solr_item_names_should_be_matched_for_rating(int rating) throws Throwable {
        try {
            String query = null;
            switch (rating) {
                case 1:
                    query = "asg.ratingAvg_d:[1.0 TO 1.9]";
                    break;
                case 2:
                    query = "asg.ratingAvg_d:[2.0 TO 2.9]";
                    break;
                case 3:
                    query = "asg.ratingAvg_d:[3.0 TO 3.9]";
                    break;
                case 4:
                    query = "asg.ratingAvg_d:[4.0 TO 4.9]";
                    break;
                case 5:
                    query = "asg.ratingAvg_d:5.0";
                    break;
            }
            long count = Integer.parseInt(getTemporaryText());
            if (count > 0) {
                Assert.assertTrue(solr.solrSearch(query, "schema_s=BigData", "/select", commonUtil.getTemporaryList().get(0).trim(), 0));

                if (commonUtil.getTemporaryList().size() > 1) {
                    int indexNumber = commonUtil.getTemporaryList().size() - 1;
                    Assert.assertTrue(solr.solrSearchRows(query, "schema_s=BigData", "/select", "", commonUtil.getTemporaryList().get(indexNumber).trim(), indexNumber, commonUtil.getTemporaryList().size()));
                    int indexNo = commonUtil.getTemporaryList().size() / 2;
                    Assert.assertTrue(solr.solrSearchRows(query, "schema_s=BigData", "/select", "", commonUtil.getTemporaryList().get(indexNo).trim(), indexNo, commonUtil.getTemporaryList().size()));
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Only one item found");
                }

            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No items found");
            }
            takeScreenShot("MLP-1507 Verification of rating count", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Item names mismatch" + e.getMessage());
        }

    }

    @When("^user clicks on rating five checkbox and rating four checkbox$")
    public void user_clicks_on_rating_five_checkbox_and_rating_four_checkbox() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).ratingFiveCheckbox());
            sleepForSec(2000);
            clickOn(new SubjectArea(driver).ratingFourCheckbox());
            sleepForSec(1000);
            String itemsCount = new SubjectArea(driver).getItemCount().getText();
            storeTemporaryText(commonUtil.getNUMfromString(itemsCount));
        } catch (Exception e) {

            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Checkbox for rating five and four is not displayed" + e.getMessage());
        }

    }

    @Then("^search count and facet list count should be matched$")
    public void search_count_and_facet_list_count_should_be_matched() throws Throwable {
        try {
            int count = 0;
            for (int i = 0; i < new SubjectArea(driver).getCheckedRatingFacetCountList().size(); i++) {
                count = count + Integer.parseInt(new SubjectArea(driver).getCheckedRatingFacetCountList().get(i).getText().trim());
            }
            verifyEquals(Integer.parseInt(getTemporaryText().trim()), count);
            takeScreenShot("MLP-1507 Verification of facet search result with OR condition", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Count mismatch" + e.getMessage());
        }
    }

    @Then("^error message for invalid solr search should be displayed as \"([^\"]*)\"$")
    public void error_message_for_invalid_solr_search_should_be_displayed_as(String errorMessage) throws Throwable {
        try {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Error from UI " + new SubjectArea(driver).getInvalidSolrError().getText());
            new SubjectArea(driver).getInvalidSolrError().getText().contains(errorMessage);
            takeScreenShot("MLP-1711 Error Message for invalid search", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1711 Error Message for invalid search", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error message for invalid solr search is not displayed" + e.toString());
            Assert.fail("Error message for invalid solr search is not displayed" + e.getMessage());
        }
    }

    @When("^user gets the count and item names from UI$")
    public void user_gets_the_count_and_item_names_from_UI() throws Throwable {
        try {
            String uiItemCount = new SubjectArea(driver).getItemCount().getText().trim();
            LoggerUtil.logLoader_info(uiItemCount, "Number of Items found In UI");
            storeTemporaryText(commonUtil.getNUMfromString(uiItemCount));
            if (Integer.parseInt(commonUtil.getNUMfromString(uiItemCount)) > 0) {
                List<String> itemNames = new ArrayList<String>();
                itemNames.add(new SubjectArea(driver).getItemNames().get(0).getText().trim());
                sleepForSec(3000);
                if (Integer.parseInt(commonUtil.getNUMfromString(uiItemCount)) > 9) {
                    if (isElementPresent(new SubjectArea(driver).click_paginationLastButton())) {
                        clickOn(new SubjectArea(driver).click_paginationLastButton());
                    } else {
                        new SubjectArea(driver).click_paginationNextButton();
                    }
                    //synchronizationVisibilityofElement(driver,new SubjectArea(driver).returnsaveSearchButton(),5);
                    sleepForSec(3000);
                    int count = new SubjectArea(driver).getItemNames().size();
                    itemNames.add(new SubjectArea(driver).getItemNames().get(count - 1).getText());
                } else {
                    int size = new SubjectArea(driver).getItemNames().size();
                    itemNames.add(new SubjectArea(driver).getItemNames().get(size - 1).getText());
                }
                commonUtil.storeTemporaryList(itemNames);
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while getting item count and item names" + e.toString());
            Assert.fail("Error while getting item count and item names" + e.getMessage());
        }
    }

    @Then("^compare the count between UI and solr$")
    public void compare_the_count_between_UI_and_solr(DataTable table) throws Throwable {
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            long solrCount = solr.Solr_SearchCount(solr_dataTable.get(0).getQueryName(), solr_dataTable.get(0).getFilterQuery(), "/select");
            long count = Long.parseLong(getTemporaryText());
            Assert.assertEquals(count, solrCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "UI count is successfully compared with Solr Search Results: " + count);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Count comparison between UI and solr" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^compare the item names between UI and solr$")
    public void compare_the_item_names_between_UI_and_solr(DataTable table) throws Throwable {
        try {
            List<CucumberDataSet> dataTable = table.asList(CucumberDataSet.class);
            int count = Integer.parseInt(getTemporaryText());
            if (count > 0) {


                Assert.assertTrue(solr.solrSearch(dataTable.get(0).getQueryName(), dataTable.get(0).getFilterQuery(), "/select", commonUtil.getTemporaryList().get(0).trim(), 0));

                if (commonUtil.getTemporaryList().size() > 1) {
                    int indexNumber = (int) count - 1;
                    Assert.assertTrue(solr.solrSearchRows(dataTable.get(0).getQueryName(), dataTable.get(0).getFilterQuery(), "/select", "", commonUtil.getTemporaryList().get(1).trim(), indexNumber, (int) count));

                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Only one item found");
                }

            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No items found");
            }

        } catch (Exception e) {
            takeScreenShot("Item names comparison between UI and solr", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Item names comparison between UI and solr" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Item names mismatch" + e.getMessage());
        }
    }


    @Then("^\"([^\"]*)\" should be displayed in the serach catalog dropdown$")
    public void should_be_displayed_in_the_serach_catalog_dropdown(String arg1) throws Throwable {
        try {
            Assert.assertEquals(new SubjectArea(driver).getsearchCatalogDropDown().getText(), arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "displayed in serach_catalog_dropdown");
            takeScreenShot(arg1 + "displayed in serach_catalog_dropdown", driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot(arg1 + "not displayed in serach_catalog_dropdown", driver);
        }


    }

    @Then("^user clicks on the breadcrumb link$")
    public void user_clicks_on_the_breadcrumb_link() throws Throwable {
        try {
            new SubjectArea(driver).click_breadcrumbLink();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Breadcrumb link click successful");


        } catch (Exception e) {
            takeScreenShot("Breadcrumb link click not successful", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Breadcrumb link click not successful" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Click on breadcrumb not successful" + e.getMessage());

        }
    }


    @Then("^user verifies breadcrumb list contains search text \"([^\"]*)\"$")
    public void user_verifies_breadcrumb_list_contains_search_text(String searchText) throws Throwable {
        String firstTableData;
        try {
            /*new SubjectArea(driver).getFileCheckBox().click();*/
            //waitandFindElement(driver,new SubjectArea(driver).getFirstTableData(),3,false);
            sleepForSec(1000);
            new SubjectArea(driver).getFirstTableData().click();
            sleepForSec(3000);
            waitForPageLoads(driver, 10);
            String itemattribute = new SubjectArea(driver).getGetBreadcrumbItems(searchText).getText();
            verifyContains(itemattribute, searchText);
            takeScreenShot("Breadcrumb list contain search Text", driver);
            //===============================================================================
            /*firstTableData= new SubjectArea(driver).getFirstTableData().getText();
            new SubjectArea(driver).getFirstTableData().click();
            waitForPageLoads(driver,10);
            String itemattribute =new SubjectArea(driver).getDynamicAttributeRetrival(firstTableData).getAttribute("title");
            System.out.println(itemattribute);
            int firstIndex=itemattribute.indexOf('=');
            int lastIndex=itemattribute.indexOf('[');
            String expectedItemValue =itemattribute.substring(firstIndex+1,lastIndex-1);
            System.out.println(expectedItemValue);
            Assert.assertEquals(expectedItemValue,searchText);
            takeScreenShot("Breadcrumb list contain search Text", driver);*/
        } catch (Exception e) {
            takeScreenShot("Breadcrumb list doesnt contain search Text", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Breadcrumb list doesnt contain search Text" + e.getMessage());
        }
    }


    @When("^user verifies rating section in item preview panel$")
    public void user_verifies_rating_section_in_item_preview_panel() throws Throwable {
        try {
            Assert.assertTrue(traverseListContainsElementText(new SubjectArea(driver).getRatingHeadingList(), "AVERAGE"));
            verifyTrue(getElementText(new SubjectArea(driver).getMyRatingHeading()).contains("MY"));
            verifyTrue(new SubjectArea(driver).getRatingHeading().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating Section: " + new SubjectArea(driver).getRatingHeadingList());
        } catch (Exception e) {
            takeScreenShot("Rating Section is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Rating Section is not displayed " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Breadcrumb list doesnt contain search Text" + e.getMessage());
        }
    }

    @Then("^user verifies the facet panel and result panel title$")
    public void user_verifies_the_facet_panel_and_result_panel_title() throws Throwable {
        try {
            //waitandFindElement(driver,new SubjectArea(driver).getTitleList().get(0),3,false);
            sleepForSec(2000);
            Assert.assertTrue(new SubjectArea(driver).getTitleList().get(0).getText().trim().equals("SEARCH IN \"ALL\""));
            Assert.assertTrue(new SubjectArea(driver).getTitleList().get(1).getText().trim().equals("RESULTS"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Panel Heading List" + new SubjectArea(driver).getTitleList());
            takeScreenShot("MLP-1521 Facet panel and result panel title", driver);

        } catch (Exception e) {
            takeScreenShot("MLP-1521 Facet panel and result panel title mismatched", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "MLP-1521 Facet panel and result panel title mismatched " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Default search text is not matching" + e.getMessage());
        }
    }

    @Then("^user verifies the default search text$")
    public void user_verifies_the_default_search_text() throws Throwable {
        try {
            Assert.assertEquals(new SubjectArea(driver).getSearchText().getAttribute("placeholder"), "Search...");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Default Search Text in UI" + new SubjectArea(driver).getSearchText().getText());
            takeScreenShot("Default search Text matched", driver);
        } catch (Exception e) {
            takeScreenShot("Default search Text mismatched", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Default search Text mismatched " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Default search text is not matching" + e.getMessage());
        }
    }

    @Then("^facet header catalog should be displayed$")
    public void facet_header_catalog_should_be_displayed() throws Throwable {
        try {
            Assert.assertTrue(traverseListContainsElementText(new SubjectArea(driver).getFacetHeaderList(), "Catalog"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Facet Header List in UI" + new SubjectArea(driver).getFacetHeaderList());
        } catch (Exception e) {
            takeScreenShot("Facet header catalog is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Facet header catalog is not displayed " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Facet header Catalog displayed" + e.getMessage());
        }
    }

    @Then("^facet header catalog should not be displayed$")
    public void facet_header_catalog_should_not_be_displayed() throws Throwable {
        try {
            Assert.assertFalse(traverseListContainsElementText(new SubjectArea(driver).getFacetHeaderList(), "Catalog"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Facet Header List in UI" + new SubjectArea(driver).getFacetHeaderList());
            takeScreenShot("MLP_1501_Verification of catalog facet", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1501 Facet header catalog is displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "MLP_1501 Facet header catalog is displayed " + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("facet header catalog is displayed" + e.getMessage());
        }
    }

    @Then("^user clicks on first item on the item list page and verifies its type in the preview page$")
    public void userClicksOnFirstItemOnTheItemListPageAndVerifiesItsTypeInThePreviewPage() throws Throwable {
        String firstTableData = null, textValue = null;
        try {
            sleepForSec(2000);
            textValue = new SubjectArea(driver).returnfirstItemIntableOfItems().getText().trim();
            //This is get table data at first index
            firstTableData = new SubjectArea(driver).getFirstTableData().getText().trim();

            clickOn(new SubjectArea(driver).returnfirstItemIntableOfItems());
            waitForPageLoads(driver, 4);

            //this is to maximize the window
            new SubjectArea(driver).getWindowMaximize().click();
            //waitForPageLoads(driver, 5);
            sleepForSec(1000);

            String itemattribute = new SubjectArea(driver).getItemAttributeRetrivel(firstTableData).getAttribute("title").trim();

            int firstIndex = itemattribute.indexOf('[');
            int lastIndex = itemattribute.indexOf(']');
            String expectedItemValue = itemattribute.substring(firstIndex + 1, lastIndex);

            Assert.assertEquals(textValue, expectedItemValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Actual Value" + textValue + "Matched with expected value" + expectedItemValue);
            takeScreenShot("MLP_913_Verification of item header and type in preview page", driver);

        } catch (Exception e) {
            takeScreenShot("MLP_913_Verification of item header and type in preview page", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Actual Value and Expected value did not Match");
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^breadcrumb items ahould get displayed$")
    public void breadcrumb_items_ahould_get_displayed() throws Throwable {

        try {
            verifyTrue(isElementsListPresent(new SubjectArea(driver).getbreadcrumbItems()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Breadcrumb items displayed");
            takeScreenShot("Breadcrumb items displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Then("^three dots and maximum entries are displayed$")
    public void three_dots_and_maximum_enntries_are_displayed() throws Throwable {
        try {
            verifyTrue(new SubjectArea(driver).getbreadcrumbHiddenItemsOptions().isDisplayed());
            verifyTrue(isElementsListPresent(new SubjectArea(driver).getbreadcrumbItems()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Three dots and bread crunbs are displayed for preview page");
            takeScreenShot("Bread Crumbs of Preview Page", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items of preview page is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @When("^user clicks on enlarge button in the preview page$")
    public void user_clicks_on_enlarge_button_in_the_preview_page() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getitemViewResizeButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Resize Button is clicked");
        } catch (Exception e) {
            takeScreenShot("Resize Button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user clicks on any item in the breadcrumb hidden items$")
    public void user_clicks_on_any_item_in_the_breadcrumb_hidden_items() throws Throwable {

        try {
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getbreadcrumbHiddenItemsOptions());
            sleepForSec(500);
            storeTemporaryText(new SubjectArea(driver).getbreadcrumbHiddenItemsDropdownMenu().get(1).getText());
            clickOn(new SubjectArea(driver).getbreadcrumbHiddenItemsDropdownMenu().get(1));
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Resize Button is clicked");
        } catch (Exception e) {
            takeScreenShot("Resize Button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^corresponding item should open in a preview page$")
    public void corresponding_item_should_open_in_a_preview_page() throws Throwable {
        try {
            storeTemporaryValue(new SubjectArea(driver).getnamesOfBreadcrumbsOpened().size());
            isElementPresent(new SubjectArea(driver).getdynamicItemName(getTemporaryText().split("\\[")[0].trim()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Opened item got displayed");
            takeScreenShot("Opened item got displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Opened item is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @When("^user clicks on any item in the breadcrumb items$")
    public void user_clicks_on_any_item_in_the_breadcrumb_items() throws Throwable {
        try {
            storeTemporaryText(new SubjectArea(driver).getbreadcrumbItems().get(1).getText());
            clickOn(new SubjectArea(driver).getbreadcrumbItems().get(1));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Breadcrumb item is clicked");
        } catch (Exception e) {
            takeScreenShot("Breadcrumb item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should not able to open the same item again$")
    public void user_should_not_able_to_open_the_same_item_again() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getbreadcrumbHiddenItemsOptions());
            sleepForSec(500);
            clickOn(new SubjectArea(driver).getbreadcrumbHiddenItemsDropdownMenu().get(1));
            sleepForSec(500);
            Assert.assertEquals(new SubjectArea(driver).getnamesOfBreadcrumbsOpened().size(), getTemporaryValue());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Already opened item is not opened again");
            takeScreenShot("Already opened item is not opened again", driver);
        } catch (Exception e) {
            takeScreenShot("Already opened item is opened again", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @Then("^user checks column checkbox and validates only item with type \"([^\"]*)\" alone is displayed$")
    public void user_checks_column_checkbox_and_validates_only_item_with_type_alone_is_displayed(String type) throws Throwable {
        try {
            waitandFindElement(driver, new SubjectArea(driver).clickTypeAsColumn(), 5, false);
            Thread.sleep(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), type + " type  is selected");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), type + " type  is not selected");
            takeScreenShot("Type" + type + " is not selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }

    }

    @Given("^user check any one facet of foodmart DB from hive warehouse$")
    public void user_check_any_one_facet_of_foodmart_DB_from_hive_warehouse() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).clickFoodMartFacet());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "FoodMart facet is selected");

        } catch (Exception e) {
            takeScreenShot("FoodMart facet is not selected", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Type column and table is not selected" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }


    @Then("^search result table should have only column and table values in type column$")
    public void search_result_table_should_have_only_column_and_table_values_in_type_column() throws Throwable {
        waitandFindElement(driver, new SubjectArea(driver).getTypeColumnValues().get(0), 5, false);
        List<WebElement> columnValues = new SubjectArea(driver).getTypeColumnValues();
        for (WebElement typeValues : columnValues) {
            if (typeValues.getText().trim().equalsIgnoreCase("Column")) {
                LoggerUtil.logLoader_info(this.getClass().getName(), "Only Column and Table is displayed in type column");
            } else if (typeValues.getText().trim().equalsIgnoreCase("Column")) {
                takeScreenShot("Search result type has other than  columns", driver);
                Assert.fail("Search result type has other than  columns");
            }
        }
    }


    @Given("^user click on any of the item and assign \"([^\"]*)\" tag to the item\\.$")
    public void user_click_on_any_of_the_item_and_assign_tag_to_the_item(String tagName) throws Throwable {
        try {
            clickOn(new SubjectArea(driver).clickItemTagCountFromList());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Opening tag page");
            enterText(new SubjectArea(driver).enterTagName(), tagName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is entered");
            clickOn(new SubjectArea(driver).selectTagName(tagName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is Selected");
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getAssignTagSaveButton());
            sleepForSec(3000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is tagged and saved");
        } catch (Exception e) {
            takeScreenShot("Tag is not assigned to an item", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is not tagged");
        }
    }

    @Then("^user validate whether the \"([^\"]*)\" tag is listed in Tag facet$")
    public void user_validate_whether_the_tag_is_listed_in_Tag_facet(String tagText) throws Throwable {
        try {
            //clickOn(new SubjectArea(driver).clickFacetMenu());
            sleepForSec(2000);
            verifyTrue(isElementPresent(new SubjectArea(driver).getTagText(tagText)));
        } catch (Exception e) {
            takeScreenShot(tagText + " tag is not displayed in tag facet", driver);
            Assert.fail(tagText + " tag is not displayed in tag facet");
        }


    }

    @Then("^user validate whether the \"([^\"]*)\" tag is removed from Tag facet$")
    public void user_validate_whether_the_tag_is_removed_from_Tag_facet(String tagText) throws Throwable {
        sleepForSec(2000);
        try {
            verifyFalse(new SubjectArea(driver).checkTagPresence());
            LoggerUtil.logLoader_info(this.getClass().getName(), tagText + " facet is removed");

        } catch (Exception e) {
            Assert.fail(tagText + " tag facet is not removed from tag facet");
            takeScreenShot(tagText + " tag facet is not removed from tag facet", driver);

        }
    }

    @Given("^user enables tag facet checkbox$")
    public void user_enables_tag_facet_checkbox() throws Throwable {
        try {
            //actionClick(driver, new SubjectArea(driver).clickFacetTag());
            clickOn(new SubjectArea(driver).clickFacetTag());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Facet checkbox is enabled");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Facet checkbox is not enabled");
            takeScreenShot("Tag facet checkbox is not enabled", driver);
        }
    }

    @Given("^user click on item and unassign the tag from item$")
    public void user_click_on_item_and_unassign_the_tag_from_item() throws Throwable {
        try {

            sleepForSec(1000);
            /*for (WebElement itemList : new SubjectArea(driver).getItemList()) {
                for (WebElement item : new SubjectArea(driver).getItemList()) {
                    if (item.isDisplayed()) {
                        actionClick(driver, item);
                    } else
                        actionClick(driver, itemList);
                }*/

            clickOn(new SubjectArea(driver).clickItemTagCountFromList());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Opening tag page");

            clickOn(new SubjectArea(driver).unAssignTag());
            clickOn(new SubjectArea(driver).getAssignTagSaveButton());
            sleepForSec(2000);

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is unassigned and tag facet is refreshed");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is not  unassigned and tag facet is refreshed");
        }
    }

    @Then("^user validates the title text in left panel is \"(.*)\"$")
    public void user_validates_the_title_text_in_left_panel_is(String panelText) throws Throwable {
        try {
            traverseListContainsElementText(new SubjectArea(driver).getPaneltitle(), panelText);
//            verifyContains(panelText, new SubjectArea(driver).getPaneltitle().getText().replace("\"", ""));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Paneltext is displayed as expected inside catalog");
        } catch (Exception e) {
            Assert.fail("Paneltext is not displayed as expected inside catalog");
            takeScreenShot("Paneltext is not displayed as expected inside catalog", driver);
        }

    }


    @Then("^\"([^\"]*)\" facet should be displayed in search result facet header list$")
    public void facet_should_be_displayed_in_search_result_facet_header_list(String facetHeaderList) throws Throwable {
        List<WebElement> facetHeaderListValues = new SubjectArea(driver).getFacetHeaderList();
        for (WebElement facetHeadertext : facetHeaderListValues) {
            if (facetHeadertext.getText().contains(facetHeaderList)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog facet is displayed in facet header list");
                break;
            } else {
                Assert.fail("Catalog is not displayed in facet header list");
                takeScreenShot("Catalog is not displayed in facet header list", driver);

            }
        }
    }

    @Then("^\"([^\"]*)\" facet should not be displayed in search result facet header list$")
    public void facet_should_not_be_displayed_in_search_result_facet_header_list(String facetHeaderList) throws Throwable {
        List<WebElement> facetHeaderListValues = new SubjectArea(driver).getFacetHeaderList();
        for (WebElement facetHeadertext : facetHeaderListValues) {
            if (!facetHeadertext.getText().contains(facetHeaderList)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catalog facet is not displayed in facet header list");

            } else {
                Assert.fail("Catalog is  displayed in facet header list");
                takeScreenShot("Catalog is displayed in facet header list", driver);

            }
        }
    }


    @When("^user clicks on anywhere in the comments block$")
    public void user_clicks_on_anywhere_in_the_comments_block() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getcommentsBlockOfItem());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Comments block of an item is clicked");
        } catch (Exception e) {
            takeScreenShot("Comments block of an item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^comments section should get displayed$")
    public void comments_section_should_get_displayed() throws Throwable {
        try {
            verifyTrue(isElementPresent(new SubjectArea(driver).getEnterCommentsSection()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Enter Comments section is displayed");
            takeScreenShot("Enter Comments section is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Enter Comments section is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the fields NAME,TYPE and TAGS should be in capitals$")
    public void the_fields_NAME_TYPE_and_TAGS_should_be_in_capitals() throws Throwable {

        try {
            waitandFindElement(driver, new SubjectArea(driver).getdataoftypeName(), 4, false);
            CommonUtil.isAllUppercase(new SubjectArea(driver).getdataoftypeName().getText());
            CommonUtil.isAllUppercase(new SubjectArea(driver).getdataoftypeType().getText());
            CommonUtil.isAllUppercase(new SubjectArea(driver).gettagsOfItemsLabel().getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All labels are displayed in caps");
            takeScreenShot("Labels are displayed in caps", driver);
        } catch (Exception e) {
            takeScreenShot("All labels are not displayed in caps", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }


    }

    @When("^user checks the checkbox for \"([^\"]*)\" in Parent hierarchy$")
    public void user_checks_the_checkbox_for_in_Parent_hierarchy(String arg1) throws Throwable {
        try {
            sleepForSec(2000);
            clickOn(new SubjectArea(driver).getFacetCheckbox(arg1));
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "is checked");
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Then("^title attribute of the items displayed should contain \"([^\"]*)\" and \"([^\"]*)\"$")
    public void title_attribute_of_the_items_displayed_should_contain_and(String databaseName, String tableName) throws Throwable {
        try {

//            sleepForSec(1000);
//            String text = new SubjectArea(driver).returnfirstItemListName().getText().trim();
//            String text1 = new SubjectArea(driver).returnfirstItemType().getText().trim();
//            String name = " => " + tableName;
            String qualifiedName = new SubjectArea(driver).getFullQualifiedName(databaseName, tableName);
            moveToElement(driver, new SubjectArea(driver).getItemNames().get(0));
            String actualText = new SubjectArea(driver).getItemNames().get(0).getAttribute("title").trim();
            Assert.assertEquals(qualifiedName, actualText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tiltle of the item matches the full qualified name");
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @When("^user stores the title attribute of first item in temporary text$")
    public void user_stores_the_title_attribute_of_first_item_in_temporary_text() throws Throwable {
        try {
            String text = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound().get(0).getText();
            storeTemporaryText(text);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tiltle of the item matches the full qualified name");
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @When("^user checks the checkbox for \"([^\"]*)\" in Type$")
    public void user_checks_the_checkbox_for_in_Type(String arg1) throws Throwable {
        try {
            sleepForSec(2000);
            if (new SubjectArea(driver).getDynamicCheckBoxInCatalog(arg1).isDisplayed()) {
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getDynamicCheckBoxInCatalog(arg1));
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "type is checked");
            } else {
                clickOn(new SubjectArea(driver).getTypeFacetShowAll());
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getDynamicCheckBoxInCatalog(arg1));
                sleepForSec(1000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "type is checked");
            }
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Then("^title of the items displayed under Has Column section should be their full qualified name$")
    public void title_of_the_items_displayed_under_Has_Column_section_should_be_their_full_qualified_name() throws Throwable {

        try {
            String expected = getTemporaryText() + " => " + new SubjectArea(driver).getlistOfItemsInHasColumnsSection().get(0).getText().trim() + " [Column]";
            moveToElementUsingJavaScript(driver, new SubjectArea(driver).getlistOfItemsInHasColumnsSection().get(0));
            String actual = new SubjectArea(driver).getlistOfItemsInHasColumnsSection().get(0).getAttribute("title").trim();
            Assert.assertEquals(actual, expected);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tiltle of the HAS_COLUMN item matches the full qualified name");
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Given("^user verifies if similiar section is available$")
    public void user_verifies_if_similiar_section_is_available() throws Throwable {
        try {
            if (isElementPresent(new SubjectArea(driver).similiarSection())) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Similiar section is available");
            } else if (isNotElementPresent(new SubjectArea(driver).similiarSection())) {
                new SubjectArea(driver).click_itemFullViewPageCloseButton();
                sleepForSec(1000);
                Random random = new Random();
                int max = 9;
                int min = 1;
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getItemNames().get(random.nextInt(max - min + 1) + min));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Similiar section is not available");
            }

            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Then("^title of the items displayed under SIMILAR section contain \"([^\"]*)\" and corresponding table name$")
    public void title_of_the_items_displayed_under_SIMILAR_section_contain_and_corresponding_table_name(String arg1) throws Throwable {

        try {
            String expected = new SubjectArea(driver).getFullQualifiedName(arg1, new SubjectArea(driver).getlistOfItemsInSimilarSection().get(0).getText().trim() + " [Table]");
            moveToElementUsingJavaScript(driver, new SubjectArea(driver).getlistOfItemsInSimilarSection().get(0));
            String actual = new SubjectArea(driver).getlistOfItemsInSimilarSection().get(0).getAttribute("title").trim();
            verifyContains(expected, actual);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tiltle of the SIMILAR item matches the full qualified name");
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for SIMILAR values", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for SIMILAR values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }


    @Then("^title of the items displayed should contain the title \"([^\"]*)\"$")
    public void title_of_the_items_displayed_should_contain_the_title(String arg1) throws Throwable {
        try {
            verifyContains(arg1, new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound().get(0).getAttribute("title"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tiltle of the HAS_COLUMN item matches the full qualified name");
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1852_Verification of full qualified name as tool tip for HAS_COLUMN values", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Given("^user clicks on \"([^\"]*)\" in the items listed$")
    public void user_clicks_on_in_the_items_listed(String arg1) throws Throwable {
        try {
            if (isElementPresent(new SubjectArea(driver).getpaginationNextButtonWithoutSync())) {
                trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), arg1, new SubjectArea(driver).getpaginationNextButton());
            } else {
                WebElement element = traverseListContainsElementReturnsElement(new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), arg1);
                waitandFindElement(driver, element, 3, true);
                clickonWebElementwithJavaScript(driver, element);
                sleepForSec(1000);
                waitForAngularLoad(driver);
            }

        } catch (Exception e) {
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user verifies sourceTreename withAPI$")
    public void
    user_verifies_sourceTreename_withAPI(DataTable parameters) throws Throwable {

        try {
            for (Map<String, String> data : parameters.asMaps(String.class, String.class)) {

                String FileName = data.get("FileName");
                String[] Functionname = data.get("functionname").split(",");
                int FunctionsSize = Integer.parseInt(data.get("functionsSize"));
                String[] LineageHopSize = data.get("lineageHopSize").split(",");
                String Classpresence = data.get("withClassinfile");
                String Lineagesourceid;
                String LineageTargetid;
                String FromLocationpath;
                String ToLocationpath;
                String[] HDFSfileLocation = data.get("HDFSfileLocation").split(",");
                List<String> Function = new ArrayList<>();
                List<String> LineageName = new ArrayList<>();
                List<String> Lineageid = new ArrayList<>();
                List<String> FunctionName = new ArrayList<>();
                try {
                    switch (Classpresence) {
                        case "No":
                            if (traverseListContainsString(CucumberDataSet.searchList(), FileName)) {
                                //assert the UI source treename and rest API sourceTree name
                                try {
                                    Assert.assertTrue(CommonUtil.IsListNull(CucumberDataSet.searchList()) == false);
                                    for (int i = 0; i < CucumberDataSet.SourcetreeName().size(); i++) {
                                        if (traverseListContainsString(CucumberDataSet.searchList(), CucumberDataSet.SourcetreeName().get(i))) {
                                        } else {
                                            Assert.fail("SourceTreeName" + CucumberDataSet.SourcetreeName().get(i) + "didn't matched with the UI list" + CucumberDataSet.searchList() + "");
                                        }
                                    }
                                } catch (Exception e) {
                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                    Assert.fail(e.getMessage());
                                }
                                //Click twice to go with finding elements by scrolling
                                new SearchDefinitionActions(driver).selectType("SourceTree");
                                waitForAngularLoad(driver);
                                new SearchDefinitionActions(driver).selectType("SourceTree");
                                //scroll and click on the item listed
                                try {
                                    new SubjectArea(driver).genericClick("item click", FileName);
                                } catch (Exception e) {
                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                    Assert.fail(e.getMessage() + "Failed to click the element, may the fileName provided " + FileName + "can be wrong");
                                }
                                //get function name from UI
                                try {
                                    FunctionName = new SubjectArea(driver).returnListTextfromSection("returnListText", "FUNCTIONS");

                                } catch (Exception e) {
                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                    Assert.fail(e.getMessage() + "Failed to return the text may the TabName is wrong");
                                }
                                //Assert funtionsize from feature and our retrieved size
                                Assert.assertEquals(FunctionsSize, FunctionName.size(), "Function size from feature file : " + FunctionsSize + "and the UI List Size :" + FunctionName.size() + " didn't matched");
                                //verify the Function name from UI and json API matches
                                try {
                                    for (int j = 0; j < FunctionName.size(); j++) {
                                        if (traverseListContainsString(CucumberDataSet.FunctionName(), FunctionName.get(j))) {
                                        } else {
                                            Assert.fail("FunctionName JSON List" + CucumberDataSet.FunctionName() + "didn't matched with the UI FunctionName list" + FunctionName + ". Kindly check the SourceTreeName " + FileName + "");
                                        }
                                    }
                                } catch (Exception e) {
                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                    Assert.fail(e.getMessage());
                                }
                                //get functions from JSOn with file name
                                String[] Fucntionnamefromjson = CucumberDataSet.FilenameTofunctionid().get(FileName).split(",");
                                try {
                                    for (int c = 0; c < Functionname.length; c++) {
                                        try {
                                            //verify the functionname from feature file and UI matches
                                            if (traverseListContainsString(FunctionName, Functionname[c])) {
                                                //traverse and click the functions if needed
                                                new SubjectArea(driver).clickElementonanyPageination(new SubjectArea(driver).FunctionList(), Functionname[c]);
                                                //get the function id
                                                String Fucntionid = getElementText(new SubjectArea(driver).functionid());
                                                try {
                                                    //assert if the function id from UI and json file matches
                                                    if (Fucntionid.equalsIgnoreCase(Fucntionnamefromjson[c])) {
                                                        //get all the values of lineages from UI
                                                        LineageName = new SubjectArea(driver).returnListTextfromSection("returnListText", "LINEAGE HOPS");
                                                    } else {
                                                        Assert.fail("WeblementText" + Fucntionid + "and JSON response string" + Fucntionnamefromjson[c] + "didn't matched");
                                                    }
                                                } catch (Exception e) {
                                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                    Assert.fail(e.getMessage());
                                                }
                                                //assert lineage name from UI and Json is correct
                                                String[] splitlineagename = CucumberDataSet.functionidToLineageHopName().get(Fucntionid).split(",");
                                                // verify the lineage name with UI and JSON
                                                try {
                                                    for (int d = 0; d < splitlineagename.length; d++) {
                                                        if (traverseListContainsString(LineageName, splitlineagename[d])) {
                                                        } else {
                                                            Assert.fail("WeblementString" + LineageName + "and JSON response string" + splitlineagename[d] + "didn't matched");
                                                        }
                                                    }
                                                } catch (Exception e) {
                                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                    Assert.fail(e.getMessage());
                                                }
                                                //assert the user provided size of lineage from UI
                                                Assert.assertEquals(Integer.parseInt(LineageHopSize[c]), LineageName.size(), "Lineage Size from Feature file : " + Integer.parseInt(LineageHopSize[c]) + " didn't matched with Lineage size from " + LineageName.size() + "");
                                                try {
                                                    //split with respect to lineagename size
                                                    for (int b = 0; b < LineageName.size(); b++) {
                                                        //click on each lineage displayed in UI
                                                        waitForAngularLoad(driver);
                                                        //click on lineage HOP ID
                                                        new SubjectArea(driver).clickElementonanyPageination(new SubjectArea(driver).lineageName(), splitlineagename[b]);
                                                        //store lineage id is string
                                                        waitForAngularLoad(driver);
                                                        String LineageHopID = getElementText(new SubjectArea(driver).lineageid());
//
                                                        //get the lineage id from JSON and save split it
                                                        String[] splitlineageid = CucumberDataSet.functionidToLineageHopID().getOrDefault(Fucntionid, LineageHopID).split(",");
                                                        //add the list of linage HOP as split
                                                        for (int e = 0; e != splitlineageid.length; e++) {
                                                            Lineageid.add(splitlineageid[e]);
                                                        }
                                                        //assert lineageid from Json to UI
                                                        if (traverseListContainsString(Lineageid, LineageHopID)) {

                                                        } else {
                                                            Assert.fail(LineageHopID + "from UI didn't matched with Lineage Hop ID from JSON List" + Lineageid + "");
                                                        }
                                                        //click lineage source
                                                        waitForAngularLoad(driver);
                                                        new SubjectArea(driver).click_lineageSource();

                                                        //get value for source Location from UI
                                                        if (new SubjectArea(driver).LineageNameisDisplayed()) {
                                                            waitForAngularLoad(driver);
                                                            FromLocationpath = getElementText(new SubjectArea(driver).lineagesourcelocationname());
                                                            //assert value from UI to Feature file
                                                            Assert.assertEquals(FromLocationpath, HDFSfileLocation[b], "Metadata File location path : " + FromLocationpath + "didnt matched with the value passed from Feature file " + HDFSfileLocation[b] + "");
                                                            //get value of lineage source
                                                            waitForAngularLoad(driver);
                                                            Lineagesourceid = new SubjectArea(driver).lineagesourceid();
                                                            //assert UI lineageFromID to JSON lineage from ID
                                                            Assert.assertEquals(Lineagesourceid, CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From"), "Metadata LINEAGE SOURCE ID from UI :" + Lineagesourceid + " didn't mathed with the LINEAGE SOURCE ID from JSON Response" + CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From") + "");
                                                            //click close button
                                                            new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                                            //click lineage target
                                                            waitForAngularLoad(driver);
                                                            new SubjectArea(driver).click_lineagetarget();

                                                        } else {
                                                            new SubjectArea(driver).dismissWarning_ifdisplayed();
                                                            //get value of lineage source
                                                            waitForAngularLoad(driver);
                                                            Lineagesourceid = new SubjectArea(driver).lineagesourceid();
                                                            //assert UI lineageFromID to JSON lineage from ID
                                                            Assert.assertEquals(Lineagesourceid, CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From"), "Metadata LINEAGE SOURCE ID from UI :" + Lineagesourceid + " didn't mathed with the LINEAGE SOURCE ID from JSON Response" + CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From") + "");
                                                            //click close button
                                                            new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                                            //click lineage target
                                                            waitForAngularLoad(driver);
                                                            new SubjectArea(driver).click_lineagetarget();
                                                        }
                                                        if (new SubjectArea(driver).LineageNameisDisplayed()) {
                                                            //get value of source Location from UI
                                                            waitForAngularLoad(driver);
                                                            ToLocationpath = getElementText(new SubjectArea(driver).lineagetargetlocationname());
                                                            //Assert the value from feature file to UI
                                                            Assert.assertEquals(ToLocationpath, HDFSfileLocation[b], "Metadata File location path : " + ToLocationpath + "didnt matched with the value passed from Feature file " + HDFSfileLocation[b] + "");
                                                            //get value of lineage target
                                                            waitForAngularLoad(driver);
                                                            LineageTargetid = new SubjectArea(driver).lineagetargetid();
                                                            //assert UI lineageFromID to JSON lineage from ID
                                                            Assert.assertEquals(LineageTargetid, CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_To"), "Metadata LINEAGE SOURCE ID from UI :" + LineageTargetid + " didn't mathed with the LINEAGE SOURCE ID from JSON Response" + CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_To") + "");

                                                        } else {
                                                            new SubjectArea(driver).dismissWarning_ifdisplayed();
                                                            //get value of lineage target
                                                            waitForAngularLoad(driver);
                                                            LineageTargetid = new SubjectArea(driver).lineagetargetid();
                                                            //assert UI lineageFromID to JSON lineage from ID
                                                            Assert.assertEquals(LineageTargetid, CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_To"), "Metadata LINEAGE SOURCE ID from UI :" + LineageTargetid + " didn't mathed with the LINEAGE SOURCE ID from JSON Response" + CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_To") + "");
                                                            //click close button
                                                        }
                                                        //click close button
                                                        waitForAngularLoad(driver);
                                                        new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                                        waitForAngularLoad(driver);
                                                        new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                                    }

                                                } catch (Exception e) {
                                                    takeScreenShot(this.getClass().getSimpleName(), driver);
                                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                                    Assert.fail(e.getMessage());
                                                }
                                                waitForAngularLoad(driver);
                                                new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                            } else {
                                                Assert.fail("FunctionName" + Functionname[c] + "didn't matched with the UI list" + FunctionName + "");
                                            }
                                        } catch (Exception e) {
                                            takeScreenShot(this.getClass().getSimpleName(), driver);
                                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                            new DashBoardPage(driver).Click_profileLogoutButton();
                                            Assert.fail(e.getMessage());
                                        }
                                    }

                                } catch (Exception e) {
                                    takeScreenShot(this.getClass().getSimpleName(), driver);
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                    new DashBoardPage(driver).Click_profileLogoutButton();
                                    Assert.fail(e.getMessage());
                                }
                                waitForAngularLoad(driver);
                                new SubjectArea(driver).click_itemFullViewPageCloseButton();

                            }
                            break;
                    }
                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage() + "Particular File has a problem " + FileName + "");
                }

            }

        } catch (
                Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @And("user provides the UI HopeLineage List,JSONList and HOPLineageFromandTo Mapvalue to perform validations")
    public void user_provides_the_UI_HopeLineage_List_and_JSONList_and_HOPLineageFromandTo_Mapvalue_to_perform_validations(List<String> LineageNameList, String LineageNameText, String Fucntionid, String HDFSfileLocation) {
        String Lineagesourceid;
        String LineageTargetid;
        String FromLocationpath;
        String ToLocationpath;
        List<String> Lineageid = new ArrayList<>();

        try {
            //click on each lineage displayed in UI
            waitForAngularLoad(driver);
            //click on lineage HOP ID
            new SubjectArea(driver).clickElementonanyPageination(new SubjectArea(driver).lineageName(), LineageNameText);
            //store lineage id is string
            waitForAngularLoad(driver);
            String LineageHopID = getElementText(new SubjectArea(driver).lineageid());
//
            //get the lineage id from JSON and save split it
            String[] splitlineageid = CucumberDataSet.functionidToLineageHopID().getOrDefault(Fucntionid, LineageHopID).split(",");
            //add the list of linage HOP as split
            for (int e = 0; e != splitlineageid.length; e++) {
                Lineageid.add(splitlineageid[e]);
            }
            //assert lineageid from Json to UI
            if (traverseListContainsString(Lineageid, LineageHopID)) {

            } else {
                Assert.fail(LineageHopID + "from UI didn't matched with Lineage Hop ID from JSON List" + Lineageid + "");
            }
            //click lineage source
            waitForAngularLoad(driver);
            new SubjectArea(driver).click_lineageSource();

            //get value for source Location from UI
            if (new SubjectArea(driver).LineageNameisDisplayed()) {
                waitForAngularLoad(driver);
                FromLocationpath = getElementText(new SubjectArea(driver).lineagesourcelocationname());
                //assert value from UI to Feature file
                Assert.assertEquals(FromLocationpath, HDFSfileLocation, "Metadata File location path : " + FromLocationpath + "didnt matched with the value passed from Feature file " + HDFSfileLocation + "");
            } else {
                new SubjectArea(driver).dismissWarning_ifdisplayed();
                //get value of lineage source
                waitForAngularLoad(driver);
                Lineagesourceid = new SubjectArea(driver).lineagesourceid();
                //assert UI lineageFromID to JSON lineage from ID
                Assert.assertEquals(Lineagesourceid, CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From"), "Metadata LINEAGE SOURCE ID from UI :" + Lineagesourceid + " didn't mathed with the LINEAGE SOURCE ID from JSON Response" + CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From") + "");
                //click close button
                new SubjectArea(driver).click_itemFullViewPageCloseButton();
                //click lineage target
                waitForAngularLoad(driver);
                new SubjectArea(driver).click_lineagetarget();
            }
            if (new SubjectArea(driver).LineageNameisDisplayed()) {
                //get value of source Location from UI
                waitForAngularLoad(driver);
                ToLocationpath = getElementText(new SubjectArea(driver).lineagetargetlocationname());
                //Assert the value from feature file to UI
                Assert.assertEquals(ToLocationpath, HDFSfileLocation, "Metadata File location path : " + ToLocationpath + "didnt matched with the value passed from Feature file " + HDFSfileLocation + "");
            } else {
                new SubjectArea(driver).dismissWarning_ifdisplayed();
                //get value of lineage target
                waitForAngularLoad(driver);
                LineageTargetid = new SubjectArea(driver).lineagetargetid();
                //assert UI lineageFromID to JSON lineage from ID
                Assert.assertEquals(LineageTargetid, CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_To"), "Metadata LINEAGE SOURCE ID from UI :" + LineageTargetid + " didn't mathed with the LINEAGE SOURCE ID from JSON Response" + CucumberDataSet.HopID_LienFromandLTo().get(LineageHopID + "_From") + "");
                //click close button
            }
            waitForAngularLoad(driver);
            new SubjectArea(driver).click_itemFullViewPageCloseButton();
            waitForAngularLoad(driver);
            new SubjectArea(driver).click_itemFullViewPageCloseButton();


        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on the items listed contains \"([^\"]*)\"$")
    public void user_clicks_on_from_the_items_listed(String arg1) throws Throwable {
        try {
            if (isElementPresent(new SubjectArea(driver).getpaginationNextButtonWithoutSync())) {
                trversePaginationAndClickOnDynamicItemContainsText(driver, new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), arg1, new SubjectArea(driver).getpaginationNextButton());
            } else {
                WebElement element = traverseListContainsElementTextReturnsElementText(new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), arg1);
                waitandFindElement(driver, element, 3, true);
                clickonWebElementwithJavaScript(driver, element);
                waitForAngularLoad(driver);
                sleepForSec(1000);
            }

        } catch (Exception e) {
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }


    @Given("^user clicks on \"([^\"]*)\" in the columns listed$")
    public void user_clicks_on_in_the_columns_listed(String arg1) throws Throwable {
        try {

//            WebElement element=traverseListContainsElementReturnsElement(new SubjectArea(driver).getlistOfItemsInHasFieldSection(),arg1);
//            waitandFindElement(driver,element,3,false);
//            clickOn(element);
            while (true) {
                if (traverseListContainsElement(new SubjectArea(driver).getlistOfItemsInHasFieldSection(), arg1)) {
                    WebElement element = traverseListContainsElementReturnsElement(new SubjectArea(driver).getlistOfItemsInHasFieldSection(), arg1);
                    waitandFindElement(driver, element, 3, false);
                    clickOn(element);
                    break;
                } else {
                    new SubjectArea(driver).click_paginationNextButton();
                    sleepForSec(1000);
                }

            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " is clicked");
        } catch (Exception e) {
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^the metadata should get displayed with \"([^\"]*)\" and \"([^\"]*)\" attributes$")
    public void the_metadata_should_get_displayed_with_and_attributes(String arg1, String arg2) throws Throwable {
        try {
            verifyTrue(traverseListContainsElementText(new SubjectArea(driver).getlistOfMetadata(), arg1));
            verifyTrue(traverseListContainsElementText(new SubjectArea(driver).getlistOfMetadata(), arg2));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " is clicked");
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the metadata should get displayed without \"([^\"]*)\" and \"([^\"]*)\" attributes$")
    public void the_metadata_should_get_displayed_without_and_attributes(String arg1, String arg2) throws Throwable {
        try {
            verifyFalse(traverseListContainsElementText(new SubjectArea(driver).getlistOfMetadata(), arg1));
            verifyFalse(traverseListContainsElementText(new SubjectArea(driver).getlistOfMetadata(), arg2));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " is clicked");
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1836_Verification of Minvalue and MaxValue meta data for numeric fields", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^item counters should be present for each facet$")
    public void item_counters_should_be_present_for_each_facet() throws Throwable {
        try {
            isElementsListPresent(new SubjectArea(driver).getfacetItemCountList());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Item counters are present for all facets");
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^User sort the result by name$")
    public void User_sort_the_result_by_name() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).clickSortbyName());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Item counters are present for all facets");
        } catch (Exception e) {
            takeScreenShot(" Operation Screenshot", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @When("^user checks the child checkbox \"([^\"]*)\" in Tags$")
    public void user_checks_the_child_checkbox_in_Tags(String arg1) throws Throwable {
        try {
            sleepForSec(2000);
            waitForAngularLoad(driver);
            clickOn(new SubjectArea(driver).getFacetCheckbox(arg1));
            sleepForSec(800);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " is checked");
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user unchecks the child checkbox \"([^\"]*)\" in Tags$")
    public void user_unchecks_the_child_checkbox_in_Tags(String arg1) throws Throwable {
        try {
            sleepForSec(2000);
            clickOn(new SubjectArea(driver).getDynamicCheckedChildCheckBoxInTags(arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " is unchecked");
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user checks the checkbox for \"([^\"]*)\" in Catalog$")
    public void user_checks_the_checkbox_for_in_Catalog(String arg1) throws Throwable {
        try {
            sleepForSec(1000);
            waitandFindElement(driver, new SubjectArea(driver).getFacetCheckbox(arg1), 5, false);
            clickOn(new SubjectArea(driver).getFacetCheckbox(arg1));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " is checked");
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" facet should not be present$")
    public void facet_should_not_be_present(String arg1) throws Throwable {
        try {
            verifyFalse(traverseListContainsElement(new SubjectArea(driver).getfacetHeadersList(), arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " facet is not present");
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" facet should be present$")
    public void facet_should_be_present(String arg1) throws Throwable {
        try {
            verifyTrue(traverseListContainsElement(new SubjectArea(driver).getfacetHeadersList(), arg1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " facet is present");
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user gives \"([^\"]*)\" rating to the clicked item$")
    public void user_gives_rating_to_the_clicked_item(String arg1) throws Throwable {
        try {
            sleepForSec(1000);
//            waitandFindElement(driver, new SubjectArea(driver).rateDynamically(arg1), 3, true);
            int rating = Integer.parseInt(arg1) * 2;
            clickOn(new SubjectArea(driver).rateDynamically(Integer.toString(rating)));
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " facet is not present");
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1984_Verification of item counters in facet", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the color of BigData should get changed to grey$")
    public void the_color_of_BigData_should_get_changed_to_grey() throws Throwable {
        try {
            waitandFindElement(driver, new SubjectArea(driver).getDynamicElementInFacet("Catalog", "BigData"), 3, false);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome")) {
                Assert.assertEquals(new SubjectArea(driver).getDynamicElementInFacet("Catalog", "BigData").getCssValue("color"), "rgba(33, 37, 41, 1)");
            } else if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                Assert.assertEquals(new SubjectArea(driver).getDynamicElementInFacet("Catalog", "BigData").getCssValue("color"), "rgb(33, 37, 41)");
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

    @Then("^the background color of BigData should be white$")
    public void the_background_color_of_BigData_should_be_white() throws Throwable {
        try {
            sleepForSec(1000);
            waitandFindElement(driver, new SubjectArea(driver).getDynamicElementInFacet("Catalog", "BigData"), 3, false);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                Assert.assertEquals(new SubjectArea(driver).getDynamicElementInFacet("Catalog", "BigData").getCssValue("background-color"), "transparent");
            } else {
                Assert.assertEquals(new SubjectArea(driver).getDynamicElementInFacet("Catalog", "BigData").getCssValue("background-color"), "rgba(0, 0, 0, 0)");
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Background color is white");
            takeScreenShot("MLP_1643_Verification of facet box background color", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_1643_Verification of facet box background color", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on the number of tags displayed$")
    public void user_clicks_on_the_number_of_tags_displayed() throws Throwable {
        try {
            while (new SubjectArea(driver).getlistOfTagsInItemList().size() > 0) {
                clickOn(new SubjectArea(driver).getlistOfTagsInItemList().get(0));
                if (new SubjectArea(driver).getcreateNewTagButton().isDisplayed()) {
                    break;
                }
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags is clicked on first item");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Tags is not clicked on first item", driver);
        }
    }

    @When("^user clicks on create button on the Assign/UnAssign panel$")
    public void user_clicks_on_create_button_on_the_Assign_UnAssign_panel() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getcreateNewTagButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Create new tag is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Create new tag is not clicked", driver);
        }
    }

    @When("^the newly created tag is displayed as \"([^\"]*)\" under Assigned tag section$")
    public void the_newly_created_tag_is_displayed_as_under_Assigned_tag_section(String arg1) throws Throwable {
        try {

            HashMap<WebElement, WebElement> hmap = CommonUtil.loadTwoElementsListsIntoMap(new SubjectArea(driver).getassignedTagsList(), new SubjectArea(driver).getassignedTagsStatusList());
            if (hmap.containsKey(jsonRead.readJSon("tagWorkFlow", "tagName"))) {
                Assert.assertEquals(hmap.get(jsonRead.readJSon("tagWorkFlow", "tagName")), "SUGGESTED");
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "displayed in serach_catalog_dropdown");
            takeScreenShot("Tool tip", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Tool tip", driver);
        }

    }

    @When("^user clicks on the Save button in the Assign/UnAssign panel$")
    public void user_clicks_on_the_Save_button_in_the_Assign_UnAssign_panel() throws Throwable {
        try {
            waitandFindElement(driver, new SubjectArea(driver).getassignUnassignTagsSaveButton(), 5, false);
            clickOn(new SubjectArea(driver).getassignUnassignTagsSaveButton());
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "assignUnassignTagsSaveButton is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("assignUnassignTagsSaveButton is not clicked", driver);
        }

    }

    @Then("^\"([^\"]*)\" notification should get displyed in the notifications tab$")
    public void notification_should_get_displyed_in_the_notifications_tab(String arg1) throws Throwable {

        try {
            sleepForSec(3000);
            waitandFindElement(driver, new DashBoardPage(driver).getnewNotificationsList().get(0), 5, true);
            if (traverseListContainsElementText(new DashBoardPage(driver).getnewNotificationsList(), arg1)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " notification displayed in Requests Tab");
                takeScreenShot(arg1 + " notification displayed in Requests Tab", driver);
            } else {
                waitandFindElement(driver, new DashBoardPage(driver).getActiveUnreadNotificationList().get(0), 5, true);
                verifyTrue(traverseListContainsElementText(new DashBoardPage(driver).getActiveUnreadNotificationList(), arg1));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " notification displayed in Alerts Tab");
                takeScreenShot(arg1 + " notification displayed in Alerts Tab", driver);
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot(arg1 + " notification not displayed", driver);
        }
    }

    @Then("^\"([^\"]*)\" notification content should get displayed in the requests tab$")
    public void notification_content_should_get_displyed_in_the_notifications_tab(String arg1) throws Throwable {

        try {
            new DashboardActions(driver).genericVerifyEquals(arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " notification content displayed");
            takeScreenShot(arg1 + " notification content displayed", driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot(arg1 + " notification content not displayed", driver);
        }
    }

    @Given("^user opens the notification cotaining \"([^\"]*)\"$")
    public void user_opens_the_notification_cotaining(String arg1) throws Throwable {

        try {
            if (new SubjectArea(driver).getNewNotificationOpenLink(arg1).isDisplayed()) {
                fluentWait(driver, 30, 5);
                clickOn(new SubjectArea(driver).getNewNotificationOpenLink(arg1));
            } else if (new SubjectArea(driver).getOlderNotificationOpenLink(arg1).isDisplayed()) {
                fluentWait(driver, 30, 5);
                clickOn(new SubjectArea(driver).getOlderNotificationOpenLink(arg1));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Notification is opened");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot(arg1 + "Notification is not opened", driver);
        }


    }

    @Given("^Approval Required,Status information,Created by,Created at, Modified by, Modified at,There are no comments yet labels are is displayed$")
    public void approval_Required_Status_information_Created_by_Created_at_Modified_by_Modified_at_There_are_no_comments_yet_labels_are_is_displayed() throws Throwable {
        try {
            verifyTrue(new SubjectArea(driver).getapprovalRequiredTextElement().isDisplayed());
            verifyTrue(new SubjectArea(driver).gettagStatus().isDisplayed());
            verifyTrue(new SubjectArea(driver).gettagName().isDisplayed());
            verifyTrue(new SubjectArea(driver).gettagDefinition().isDisplayed());
//            verifyTrue(new SubjectArea(driver).gettagCreatedBy().isDisplayed());
//            verifyTrue(new SubjectArea(driver).gettagCreatedAt().isDisplayed());
//            verifyTrue(new SubjectArea(driver).gettagModifiedBy().isDisplayed());
//            verifyTrue(new SubjectArea(driver).gettagModifiedAt().isDisplayed());
            //verifyTrue(new SubjectArea(driver).gettagNoCommentsText().isDisplayed());
//            Assert.assertEquals(new  SubjectArea(driver).gettagStatus().getText(),"SUGGESTED");
//            Assert.assertEquals(new  SubjectArea(driver).gettagCreatedBy().getText(),"Testinfo");
//            new SubjectArea(driver).gettagCreatedAt().getText().contains(localDateFormatter("MMM dd,yyyy"));
//            Assert.assertEquals(new  SubjectArea(driver).gettagModifiedBy().getText(),"Testinfo");
//            new SubjectArea(driver).gettagModifiedAt().getText().contains(localDateFormatter("MMM dd,yyyy"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All the tag properties has been verified");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Tag properties", driver);
        }
    }


    @Given("^user clicks on ok to Multiple open panels pop up$")
    public void user_clicks_on_ok_to_Multiple_open_panels_pop_up() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getmultiplePanelPopUpOk());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Multiple panels pop up is handled");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Multiple panels pop up is not handled", driver);
        }
    }


    @Given("^user clicks on Add Comments button$")
    public void user_clicks_on_Add_Comments_button() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getaddCommentButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Add comments button is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Add comments button is not clicked", driver);
        }


    }

    @Given("^comments should be added to the newly created tag$")
    public void comments_should_be_added_to_the_newly_created_tag() throws Throwable {
        try {
            verifyTrue(traverseListContainsElementText(new SubjectArea(driver).getlistOfCommentsAdded(), jsonRead.readJSon("tagWorkFlow", "CommentsAdded")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Comment has been added");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Comment is not added", driver);
        }


    }

    @Given("^user \"([^\"]*)\" the suggested tag$")
    public void user_the_suggested_tag(String arg1) throws Throwable {
        try {
            new DashboardActions(driver).genericClick(arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag has been approved");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Tag is not approved", driver);
        }

    }

    @Then("^notification should be displayed as Tag followed by newly created tag name with label \"([^\"]*)\"$")
    public void notification_should_be_displayed_as_Tag_followed_by_newly_created_tag_name_with_label(String arg1) throws Throwable {


    }

    @Given("^user clicks on close button$")
    public void user_clicks_on_close_button() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getpanelExitButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Panel is closed");
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Panel is not closed", driver);
        }
    }

    @Given("^user clicks on close button in the item preview page$")
    public void user_clicks_on_close_button_in_preview_page() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getpanelCloseButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Panel is closed");
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Panel is not closed", driver);
        }
    }

    @Given("^user deletes primary key constraint for deleting tag \"([^\"]*)\"$")
    public void user_deletes_primary_key_constraint_for_deleting_tag(String arg1) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        try {
            db_postgres_util.executeQuery("delete from \"BigData\".\"E_tag\" where \"BigData.Tag__O\" = (select \"ID\" from \"BigData\".\"V_Tag\" where \"name\"='" + arg1 + "');");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + "Tag Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^Accept/Reject button should not be displayed for already approved/rejected tags\\.$")
    public void accept_Reject_button_should_not_be_displayed_for_already_approved_rejected_tags() throws Throwable {
        try {
            verifyFalse(isElementPresent(new SubjectArea(driver).getworkflowpossibleActionsButtonWitoutSync()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Approved/rejected options are not present");
            takeScreenShot("MLP-1107 Verification of approving option for second approver", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1107 Verification of approving option for second approver", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Panel is not closed", driver);
        }
    }


    @Then("^user should not see the horizantal scroll bar$")
    public void userShouldSeeTheVerticalScrollBar() throws Throwable {
        try {

            Boolean horzscrollStatus = horizantalScrollBarCheck(driver);
            Assert.assertFalse(horzscrollStatus);
            takeScreenShot("MLP_957_Scroll bar are displayed", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_957_Verification of scroll bar when more panels are displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user should scroll to the left of the screen$")
    public void userShouldScrollToTheLeftOfTheScreen() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getLeftScrollClick());
        } catch (Exception e) {
            takeScreenShot("MLP_957_Unable to click on the left scroll button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user should scroll to the right of the screen$")
    public void userShouldScrollToTheRightOfTheScreen() throws Throwable {
        try {
            sleepForSec(1000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getClickOnRightSideScroll());
            } else {
                clickOn(new SubjectArea(driver).getClickOnRightSideScroll());
            }
        } catch (Exception e) {
            takeScreenShot("MLP_957_Unable to click on the left scroll button", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should see the Results Pane in the scroll bar$")
    public void userShouldSeeTheResultsPaneInTheScrollBar() throws Throwable {
        try {
            String footerText = new SubjectArea(driver).getDynamicAttributeRetrival("RESULTS").getText().trim();
            Assert.assertEquals("RESULTS", footerText);
            takeScreenShot("MLP_957_user able to view the name of the item in the scroll bar", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_957_user unable to view the name of the item in the scroll bar", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on column type in the \"([^\"]*)\" table$")
    public void userClicksOnColumnTypeInTheTable(String arg0) throws Throwable {
        try {
            storeTemporaryText(new SubjectArea(driver).getHeaderName().getText().trim());
            clickOn(new SubjectArea(driver).getDataTableElement());
        } catch (Exception e) {
            takeScreenShot("MLP_957_Unable to click on cloumn type", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should see the Item's Name from the previous results in the scroll bar$")
    public void userShouldSeeTheItemSNameFromThePreviousResultsInTheScrollBar() throws Throwable {
        try {
            String footerText = new SubjectArea(driver).getDynamicAttributeRetrival(getTemporaryText()).getText().trim();
            Assert.assertEquals(getTemporaryText(), footerText);
            takeScreenShot("MLP_957_user able to view the name of the item in the scroll bar", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_957_user unable to view the name of the item in the scroll bar", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user click Show All button in type facets$")
    public void user_click_Show_All_button_in_type_facets() throws Throwable {
        try {
            sleepForSec(1000);
//            scrollToWebElement(driver,new SubjectArea(driver).getTypeFacet());
            if (isElementPresent(new SubjectArea(driver).getTypeFacetShowAll())) {
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getTypeFacetShowAll());
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "All Items expanded in Type Facets");
            } else {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Show All button is not present");
            }
        } catch (Exception e) {
            takeScreenShot("Show All button not clicked in Type Facets", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());

        }
    }

    @Given("^user click Show All button in Tag facets$")
    public void user_click_Show_All_button_in_Tag_facets() throws Throwable {
        try {
            if (isElementPresent(new SubjectArea(driver).getTagFacetShowAll())) {
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getTagFacetShowAll());
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "All Items expanded in Tag Facets");
            } else {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Show All button is not present");
            }
        } catch (Exception e) {
            takeScreenShot("Show All button not clicked in Tag Facets", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());

        }
    }


    @Then("^user verifies \"([^\"]*)\" items found$")
    public void user_verifies_items_found(String itemCount) throws Throwable {
        try {
            String uiItemCount = commonUtil.getNUMfromString(new SubjectArea(driver).getItemCount().getText());
            LoggerUtil.logLoader_info(uiItemCount, "Number of Items found In UI" + uiItemCount);
            Assert.assertEquals((commonUtil.getNUMfromString(uiItemCount)), itemCount);
            takeScreenShot("MLP-1114 Items found", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1114 Items found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user clicks on \"([^\"]*)\" item name link$")
    public void user_clicks_on_item_name_link(String itemName) throws Throwable {
        try {
            clickOn(traverseListContainsElementReturnsElement(new SubjectArea(driver).getlistOfItemNameLink(), itemName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item name " + itemName + "click successful");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user verifies tags \"([^\"]*)\" and \"([^\"]*)\" are displayed$")
    public void user_verifies_tags_and_are_displayed(String tagName1, String tagName2) throws Throwable {
        try {
            Assert.assertTrue(traverseListContainsElementText(new SubjectArea(driver).getlistOfTagNames(), tagName1));
            Assert.assertTrue(traverseListContainsElementText(new SubjectArea(driver).getlistOfTagNames(), tagName2));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags" + tagName1 + "and" + tagName2 + "is displayed");
            takeScreenShot("MLP-1114 Tags verified", driver);
        } catch (Exception e) {
            takeScreenShot("MLP-1114 Tags verified", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on resize button in item full view page$")
    public void user_clicks_on_resize_button_in_item_full_view_page() throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getItemPreviewResizeIcon());
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Resize icon clicked in Item preview page");
        } catch (Exception e) {
            takeScreenShot("Resize icon not clicked in Item preview page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user gets the firt item title$")
    public void user_gets_the_firt_item_title() throws Throwable {
        try {
            CommonUtil.storeText(new SubjectArea(driver).returnfirstItemListName().getText());
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "First item name has been stored");
        } catch (Exception e) {
            takeScreenShot("First item name is not stored", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user click on item type \"([^\"]*)\" from item list$")
    public void user_click_on_item_type_from_item_list(String itemNumber) throws Throwable {
        try {
            clickOn(new SubjectArea(driver).getItemNames().get(Integer.parseInt(itemNumber)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item Type is clicked");
            waitForAngularLoad(driver);
        } catch (Exception e) {
            takeScreenShot("Item Type is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^User enters the search name, Description and choose the widget QUICK LINK$")
    public void userEntersTheSearchNameDescriptionAndChooseTheWidgetQUICKLINK() {
        try {
            waitandFindElement(driver, new SubjectArea(driver).returnsearchName(), 3, false);
            enterText(new SubjectArea(driver).returnsearchName(), jsonRead.readJSon("QuickLink", "Search Name"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link name has been entered");
            sleepForSec(500);
            enterText(new SubjectArea(driver).returnsearchDescription(), jsonRead.readJSon("QuickLink", "Search Description"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link Description has been entered");
            clickOn(new SubjectArea(driver).returnquickLinkWidgetselectionCheckbox());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link widget has been checked");
            clickOn(new SubjectArea(driver).returnSearchSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Save button has been clicked and Quick link has been created");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search name and description could not be entered" + e.getMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link could not created");
        }

    }

    @And("^user clicks on home button and clicks on QUICK LINK dashboard$")
    public void userClicksOnHomeButtonAndClicksOnQUICKLINKDashboard() throws Throwable {
        try {
            waitForAngularLoad(driver);
            clickOn(new DashBoardPage(driver).getHomeButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on home button");
            sleepForSec(2000);
            waitForAngularLoad(driver);
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnquickLinkDashboard());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick Link Dashboard has been clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Clicked on home button", driver);
        }
    }

    @And("^user edits the \"([^\"]*)\" Widget and search in quicklinks$")
    public void userEditsTheWidgetAndSearchInQuicklinks(String widgetName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnWidgetEditButton(widgetName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget " + widgetName + "has been Clicked");
            sleepForSec(1000);
            clickOn(new DashBoardPage(driver).returnquicklinkFirstDropdown());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "First drop down from widget" + widgetName + "has been Clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^search should be opening and search should be same$")
    public void searchShouldBeOpeningAndSearchShouldBeSame() throws Throwable {
        String itemCount = null;
        String quickLinkItemCount = null;
        try {
            itemCount = getTemporaryText();
            storeTemporaryText(new SubjectArea(driver).getItemCount().getText());
            quickLinkItemCount = getTemporaryText();
            Assert.assertEquals(itemCount, quickLinkItemCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search from saved Quick link is showing correctly");
            takeScreenShot("Search from saved Quick link is showing correctly", driver);
        } catch (Exception e) {
            takeScreenShot("Search result count is mismatching", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search result count is mismatching" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Search result count is mismatching");
        }
    }

    @Then("^user should be seeing the quick link \"([^\"]*)\" and \"([^\"]*)\" in My Search panel$")
    public void userShouldBeSeeingTheQuickLinkAndInMySearchPanel(String linkName1, String linkName2) {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(500);
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName1)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName1 + "is found in My search panel");
                sleepForSec(500);
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName2)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName2 + "is found in My search panel");
            } else {
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName1)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName1 + "is found in My search panel");
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName2)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName2 + "is found in My search panel");
                takeScreenShot("Quick links is found in My Search panel", driver);
            }

        } catch (Exception e) {
            takeScreenShot("Quick links is not found in My Search panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick links is not found in My Search panel" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick links is not found in My Search panel");
        }
    }

    @And("^user clicks on \"([^\"]*)\" icon for quick link \"([^\"]*)\"$")
    public void userClicksOnIconForQuickLink(String editDeleteIcon, String quickLinkName) {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnEditDeleteButtonForQuickLink(editDeleteIcon, quickLinkName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link icon" + editDeleteIcon + "is clicked");
            } else {
                clickOn(new SubjectArea(driver).returnEditDeleteButtonForQuickLink(editDeleteIcon, quickLinkName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link icon" + editDeleteIcon + "is clicked");
            }

        } catch (Exception e) {
            takeScreenShot("Quick link is not edited or deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link is not edited or deleted" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link is not edited or deleted");
        }
    }

    @Then("^user should be seeing the quick link \"([^\"]*)\" in My Search panel$")
    public void userShouldBeSeeingTheQuickLinkInMySearchPanel(String linkName) {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(1500);
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName + "is found in My search panel");
            } else {
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName + "is found in My search panel");
                takeScreenShot("Quick link " + linkName + "is found in My Search panel", driver);
            }
        } catch (Exception e) {
            takeScreenShot("Quick link " + linkName + "is not found in My Search panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link " + linkName + "is not found in My Search panel" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link " + linkName + "is not found in My Search panel");
        }
    }

    @Then("^user should be seeing the quick link \"([^\"]*)\" not present in My Search panel$")
    public void userShouldBeSeeingTheQuickLinkNotPresentInMySearchPanel(String linkName) {
        sleepForSec(3000);
        List<String> quickLinkListFromMySearch = new ArrayList<>();
        try {
            for (WebElement ele : new SubjectArea(driver).retrunQuickLinkListFromMySearchPanel()) {
                quickLinkListFromMySearch.add(ele.getText());
            }
            Assert.assertFalse(quickLinkListFromMySearch.contains(linkName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link " + linkName + "is deleted from My search panel");
            takeScreenShot("Link " + linkName + "is deleted from My search panel", driver);
        } catch (Exception e) {
            takeScreenShot("Quick link " + linkName + "is not deleted from My Search panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link " + linkName + "is not deleted from My Search panel" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link " + linkName + "is not deleted from My Search panel");
        }
    }

    @And("^user clicks on Delete button on Quick link edit page$")
    public void userClicksOnDeleteButtonOnQuickLinkEditPage() throws Throwable {
        try {
            waitForPageLoads(driver, 10);
            clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).returnquickLinkDeleteButton());
        } catch (Exception e) {
            takeScreenShot("Quick link is not deleted from My Search panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link is not deleted from My Search panel" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link is not deleted from My S");
        }
    }

    @And("^User enters quicklink search name, Description and choose the widget and click save$")
    public void userEntersQuicklinkSearchNameDescriptionAndChooseTheWidgetAndClickSave(DataTable searchItems) {
        try {
            textClear(new SubjectArea(driver).returnsearchName());
            sleepForSec(1000);
            enterText(new SubjectArea(driver).returnsearchName(), new DataSetHandler().getValue(searchItems,
                    "searchName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "serach name " + new DataSetHandler().getValue(searchItems,
                    "searchName") + "entered successfully");
            sleepForSec(1000);
            enterText(new SubjectArea(driver).returnsearchDescription(), new DataSetHandler().getValue(searchItems, "searchDesc"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "search description " + new DataSetHandler().getValue(searchItems, "searchDesc") + "has been enetred");
            sleepForSec(1000);
            scrollToWebElement(driver, new SubjectArea(driver).retrunWidgetSelectionBox(new DataSetHandler().getValue(searchItems, "widgetOne")));
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunWidgetSelectionBox(new DataSetHandler().getValue(searchItems, "widgetOne")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget has been choosen");
            sleepForSec(1500);
            clickOn(new SubjectArea(driver).getQuickLinkSave());
            sleepForSec(3000);

        } catch (Exception e) {
            takeScreenShot("Quick link is not created", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link is not created" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link is not created");
        }
    }

    @And("^User enters quicklink search name, Description and choose the widgets and click save$")
    public void userEntersQuicklinkSearchNameDescriptionAndChooseTheWidgetsAndClickSave(DataTable searchItems) {
        try {
            enterText(new SubjectArea(driver).returnsearchName(), new DataSetHandler().getValue(searchItems,
                    "searchName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "serach name " + new DataSetHandler().getValue(searchItems,
                    "searchName") + "entered successfully");
            sleepForSec(1000);
            enterText(new SubjectArea(driver).returnsearchDescription(), new DataSetHandler().getValue(searchItems, "searchDesc"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "search description " + new DataSetHandler().getValue(searchItems, "searchDesc") + "has been enetred");
            sleepForSec(1000);

            scrollToWebElement(driver, new SubjectArea(driver).retrunWidgetSelectionBox(new DataSetHandler().getValue(searchItems, "widgetOne")));

            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunWidgetSelectionBox(new DataSetHandler().getValue(searchItems, "widgetOne")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget has been choosen");
            sleepForSec(1000);

            scrollToWebElement(driver, new SubjectArea(driver).retrunWidgetSelectionBox(new DataSetHandler().getValue(searchItems, "widgetTwo")));

            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).retrunWidgetSelectionBox(new DataSetHandler().getValue(searchItems, "widgetTwo")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget has been choosen");
            waitForPageLoads(driver, 3);
            clickOn(new SubjectArea(driver).getQuickLinkSave());
            sleepForSec(2000);

        } catch (Exception e) {
            takeScreenShot("Quick link is not created with multi widget selection", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quick link is not created with multi widget selection" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quick link is not created with multi widget selection");
        }
    }

    @And("^user clicks on join the discussion button$")
    public void user_click_on_join_the_discussion_button() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getJoinTheDiscussionButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Join the discussion button is clicked");
        } catch (Exception e) {
            takeScreenShot("Join the discussion button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user adds comments and post it$")
    public void user_adds_user_admin_comments() {
        try {
            new SubjectArea(driver).enter_comments(new JsonRead().readJSon("subjectAreaComments2", "Name"));
            new SubjectArea(driver).click_postComments();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user click on tag item \"([^\"]*)\" from item list$")
    public void user_click_on_tag_item_from_item_list(String itemName) throws Throwable {
        try {
            if (traverseListContainsElement(new SubjectArea(driver).clickTagWithItemName(itemName), itemName)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is present");
            } else {
                new SubjectArea(driver).click_paginationNextButton();
            }
            clickOn(new SubjectArea(driver).clickTagWithItemName(itemName).get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is clicked");
        } catch (Exception e) {
            takeScreenShot("Tag is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Tag is not clicked" + e.getMessage());
        }
    }

    @Then("^user verifies whether the iframe widget is loaded with swagger login page and it is accessible$")
    public void user_verifies_whether_the_iframe_widget_is_loaded_with_swagger_login_page_and_it_is_accessible() {
        try {
            sleepForSec(5000);
            new SubjectArea(driver).switchToFrame(driver, new SubjectArea(driver).getSwaggerIframeWidget());
            sleepForSec(2000);
            Assert.assertTrue(new SubjectArea(driver).getSwaggerIAuthorizeButton().isEnabled());
            driver.switchTo().defaultContent();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Iframe widget is loaded with swagger login page and it is accessible");
            takeScreenShot("Iframe widget is loaded with swagger login page and it is accessible", driver);
        } catch (Exception e) {
            takeScreenShot("Iframe widget is not loaded with swagger login page and it is not accessible", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Iframe widget is not loaded with swagger login page and it is not accessible" + e.getMessage());
        }
    }

    @And("^User verifies breadcrumb items are not displayed$")
    public void breadcrumb_items_are_not_displayed() throws Throwable {
        try {
            Assert.assertFalse(isElementsListPresent(new SubjectArea(driver).getbreadcrumbItems()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Breadcrumb items are not displayed");
            takeScreenShot("Breadcrumb items are notdisplayed", driver);
        } catch (Exception e) {
            takeScreenShot("Breadcrumb items is displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Breadcrumb items are displayed" + e.getMessage());

        }
    }

    @Then("^user verifies \"([^\"]*)\" value is displayed in most frequent values")
    public void user_verifies_value_in_mostFrequentValues(String value) {
        try {
            List<String> expectedText = new ArrayList<>();

            List<WebElement> list = new SubjectArea(driver).getMostFrequentValues();
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                for (WebElement element : new SubjectArea(driver).getMostFrequentValues()) {
                    expectedText.add(getElementText(element).trim());
                }
                verifyTrue(traverseListContainsString(expectedText, value));
            } else {
                verifyTrue(traverseListContainsElementText(list, value));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The value " + value + " is displayed in most frequent values");
            takeScreenShot("The value " + value + " is displayed in most frequent values", driver);
        } catch (Exception e) {
            takeScreenShot("The value " + value + " is not displayed in most frequent values", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("The value " + value + " is not displayed in most frequent values" + e.getMessage());
        }
    }

    @Then("^user verifies either \"([^\"]*)\" or \"([^\"]*)\" value should be displayed in most frequent values")
    public void user_verifies_OR_scenario_value_in_mostFrequentValues(String value, String value1) {
        try {

            List<String> expectedText = new ArrayList<>();

            List<WebElement> list = new SubjectArea(driver).getMostFrequentValues();
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                for (WebElement element : new SubjectArea(driver).getMostFrequentValues()) {
                    expectedText.add(getElementText(element).trim());
                }
                verifyTrue(traverseListContainsString(expectedText, value) || traverseListContainsString(expectedText, value1));
            } else {
                verifyTrue(traverseListContainsElementText(list, value) || traverseListContainsElementText(list, value1));
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Both the values " + value + " and " + value1 + " are displayed in most frequent values");
            takeScreenShot("Both the values " + value + " and " + value1 + " are displayed in most frequent values", driver);
        } catch (Exception e) {
            takeScreenShot("Both the values " + value + " and " + value1 + " are not displayed in most frequent values", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Both the values " + value + " and " + value1 + " are not displayed in most frequent values" + e.getMessage());
        }
    }

    @Then("^user verifies whether \"([^\"]*)\" is not displayed in most frequent values")
    public void user_verifies_NOR_scenario_value_in_mostFrequentValues(String value) {
        try {
            List<String> expectedText = new ArrayList<>();

            List<WebElement> list = new SubjectArea(driver).getMostFrequentValues();
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                for (WebElement element : new SubjectArea(driver).getMostFrequentValues()) {
                    expectedText.add(getElementText(element).trim());
                }
                verifyFalse(traverseListContainsString(expectedText, value));
            } else {
                verifyFalse(traverseListContainsElementText(list, value));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The value " + value + " is not displayed in most frequent values");
            takeScreenShot("The value " + value + " is not displayed in most frequent values", driver);
        } catch (Exception e) {
            takeScreenShot("The value " + value + " is displayed in most frequent values", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("The value " + value + " is displayed in most frequent values" + e.getMessage());
        }
    }

    @Given("^user assigns \"([^\"]*)\" tag to the item$")
    public void user_assigns_tag_to_the_item(String tagName) throws Throwable {
        try {
            enterText(new SubjectArea(driver).enterTagName(), tagName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is entered");
//            clickOn(new SubjectArea(driver).selectTagName(tagName));
//            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is Selected");
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getAssignTagSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is tagged and saved");
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Tag is not assigned to an item", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is not tagged");
        }
    }

    @Given("^user click on item \"([^\"]*)\" in Tag Column and assign \"([^\"]*)\" tag to the item\\.$")
    public void user_click_on_item_in_Tag_Column_and_assign_tag_to_the_item(String itemName, String tagName) throws Throwable {
        try {
            while (new SubjectArea(driver).returnitemListPagination().size() > 0) {
                if (traverseListContainsElement(new SubjectArea(driver).getlistOfItemNameLink(), itemName)) {
                    clickOn(new SubjectArea(driver).getTagLinkForItem(itemName));
                    break;
                } else {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                }
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Opening tag page");
            enterText(new SubjectArea(driver).enterTagName(), tagName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is entered");
            clickOn(new SubjectArea(driver).selectTagName(tagName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is Selected");
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getAssignTagSaveButton());
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is tagged and saved");
        } catch (Exception e) {
            takeScreenShot("Tag is not assigned to an item", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is not tagged");
        }
    }

    @Then("^user unassign \"([^\"]*)\" tag from item \"([^\"]*)\"$")
    public void user_unassign_tag_from_item(String tagName, String itemName) throws Throwable {
        try {
            while (new SubjectArea(driver).returnitemListPagination().size() > 0) {
                if (traverseListContainsElement(new SubjectArea(driver).getlistOfItemNameLink(), itemName)) {
                    clickOn(new SubjectArea(driver).getTagLinkForItem(itemName));
                    break;
                } else {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                }
            }

            clickOn(new SubjectArea(driver).getUnassignTag(tagName));
            clickOn(new SubjectArea(driver).getAssignTagSaveButton());
            sleepForSec(2000);
        } catch (Exception e) {
            takeScreenShot("Tag is not assigned to an item", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is not tagged");
        }
    }

    @And("^user verifies whether the \"([^\"]*)\" pane is displayed$")
    public void pane_should_be_displayed(String paneHeader) throws Throwable {
        try {
            Assert.assertTrue(new SubjectArea(driver).returnItemNameHeader().getText().contains(paneHeader));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), paneHeader + "pane is displayed");
            takeScreenShot("Breadcrumb items are notdisplayed", driver);
        } catch (Exception e) {
            takeScreenShot(paneHeader + "pane is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(paneHeader + "pane is not displayed" + e.getMessage());

        }
    }

    @Given("^user iterate and click exact Analysis log from search results$")
    public void user_iterate_and_click_exact_Analysis_log_from_search_results() throws Throwable {
        try {
            sleepForSec(2000);
            clickOn(new DataSets(driver).clickItemFromResults(CommonUtil.getText().replaceAll("\\\\", "")));
        } catch (Exception e) {
            takeScreenShot(CommonUtil.getText() + "is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Item " + CommonUtil.getText() + " is not clicked");
        }
    }

    @Then("^Log text in UI and decoded text should be same$")
    public void log_text_in_UI_and_decoded_text_should_be_same() throws Throwable {
        try {
            Assert.assertTrue(new AnalysisPage(driver).logtext().replaceAll("\\s+", "").equals(CommonUtil.getText().replaceAll("\\s+", "")));
        } catch (Exception e) {
            takeScreenShot("Tag is not assigned to an item", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is not tagged");
        }
    }

    @When("^user clicks on \"([^\"]*)\" item in the breadcrumb items$")
    public void user_clicks_on_any_item_in_the_breadcrumb_items(String itemName) throws Throwable {
        try {
            List<WebElement> list = new SubjectArea(driver).getbreadcrumbItems();
            WebElement ele = traverseListContainsElementReturnsElement(list, itemName);
            clickOn(ele);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Breadcrumb item is clicked");
        } catch (Exception e) {
            takeScreenShot("Breadcrumb item is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user hovers on first item in the item list page$")
    public void user_hovers_on_first_item_in_the_item_list_page() {
        try {
            moveToElement(driver, new SubjectArea(driver).returnfirstItemIntableOfItemsFound().get(0));
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @When("^user verifies whether tooltip displayed with the item name at last with type \"([^\"]*)\"$")
    public void user_verifies_whether_tooltip_displayed_with_item_name(String typeName) {
        try {
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).getItemTooltip(typeName)));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tool tip is displayed");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tool tip is not displayed");
            Assert.fail("Tooltip is not displayed" + e.getMessage());
        }

    }

    @Then("^Analysis job \"([^\"]*)\" should \"([^\"]*)\" displayed in Subject Area Search list$")
    public void analysis_job_should_displayed_in_Subject_Area_Search_list(String itemName, String condition) throws Throwable {
        try {
            switch (condition) {
                case "not be":
                    if (itemName.equals("storedText")) {
                        while (new SubjectArea(driver).returnitemListPagination().size() > 1) {
                            if (traverseListContainsElementText(new SubjectArea(driver).getlistOfItemNameLink(), CommonUtil.getText())) {
                                Assert.fail(CommonUtil.getText() + " is not deleted");
                                break;
                            } else if (new SubjectArea(driver).getpaginationNextButton().isEnabled()) {
                                clickOn(new SubjectArea(driver).getpaginationNextButton());
                                sleepForSec(1500);
                            } else {
                                Assert.assertFalse(traverseListContainsElementText(new SubjectArea(driver).getlistOfItemNameLink(), CommonUtil.getText()));
                            }
                            break;
                        }
                    } else {
                        while (new SubjectArea(driver).returnitemListPagination().size() > 1) {
                            if (traverseListContainsElementText(new SubjectArea(driver).getlistOfItemNameLink(), itemName)) {
                                Assert.fail(itemName + " is displayed");
                            } else if (new SubjectArea(driver).getpaginationNextButton().isEnabled()) {
                                clickOn(new SubjectArea(driver).getpaginationNextButton());
                            } else {
                                Assert.assertFalse(traverseListContainsElementText(new SubjectArea(driver).getlistOfItemNameLink(), itemName));
                            }
                        }
                        break;
                    }
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), itemName + " is not displayed");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Analysis log is deleted");
        }
    }

    @Then("^following item\\(s\\) should get displayed in item search results in Subject area page$")
    public void following_item_s_should_get_displayed_in_item_search_results_in_Subject_area_page(DataTable arg1) throws Throwable {
        try {
            for (Map<String, String> itemName : arg1.asMaps(String.class, String.class)) {
                Assert.assertTrue(isElementPresent(new SubjectArea(driver).getItemName(itemName.get("itemName"))));
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tool tip is displayed");
        } catch (Exception e) {
            takeScreenShot("Item not displayed in item search results page", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tool tip is not displayed");
            Assert.fail("Tooltip is not displayed" + e.getMessage());
        }
    }

    @Given("^user clicks the show all button for the \"([^\"]*)\" facet$")
    public void user_clicks_the_show_all_button_for_the_facet(String facet) throws Throwable {
        try {
            new SubjectArea(driver).clickShowAllButton(facet);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Show All button in " + facet + " is clicked");
        } catch (NoSuchElementException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Show All button in " + facet + " is not clicked");
            Assert.fail("Show All button in " + facet + " is not clicked" + e.getMessage());
        }
    }


    @Given("^user checks the checkbox for \"([^\"]*)\" in facet \"([^\"]*)\"$")
    public void user_checks_the_checkbox_for_in_facet(String value, String facet) throws Throwable {
        try {
            new SubjectArea(driver).enableFilterBy(facet, value);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), value + " is enabled in " + facet);
        } catch (Exception e) {
            takeScreenShot("Not able to Select the item from the list", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Type column and table is not selected" + e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), value + " is enabled in " + facet);
            Assert.fail(value + " is enabled in " + facet + e.getMessage());
        }
    }

    @And("^user verifies Header menu button is disabled$")
    public void userVerifiesAssignUnassignTagsButtonIsDisabled(DataTable arg1) throws Throwable {
        try {
            for (Map<String, String> itemName : arg1.asMaps(String.class, String.class)) {
                Assert.assertFalse(isElementEnabled(new SubjectArea(driver).getHeaderOptions(itemName.get("buttonName"))));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg1 + " Button is disabled");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), arg1 + " Button is enabled");
            Assert.fail(arg1 + " Button is enabled" + e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" \"([^\"]*)\" displayed for item widgets$")
    public void userVerifiesEditOptionDisplayedForPIIItemWidgets(String actionType, String editButton) throws Throwable {
        try {
            new SubjectAreaMgmtActions(driver).genericActions(actionType, editButton);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), editButton + " has been found");
            takeScreenShot("Label info text has bee entered", driver);
        } catch (Exception e) {
            takeScreenShot("Issue in entering form fields", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @When("^user clicks on Requests tab$")
    public void user_clicks_on_requests_tab() throws Throwable {
        try {
            new SubjectArea(driver).clickonRequestLink();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Request Link is clicked");
        } catch (Exception e) {
            takeScreenShot("Request Link is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Given("^user creates a catalog with \"([^\"]*)\" and \"([^\"]*)\"  on catalog page$")
    public void userCreatesACatalog(String CatalogName, String CatalogDescription) {
        try {
            new CatalogManagerActions(driver).userCreatesACatalog(CatalogName, CatalogDescription);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User created catalog");
            takeScreenShot("User created catalog", driver);
        } catch (Exception e) {
            takeScreenShot("Issue in creating catalog", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user select \"([^\"]*)\" icon from list on catalog page$")
    public void selectIconfromList(String Icon) {
        try {
            new CatalogManagerActions(driver).selectIconfromList(Icon);
            loggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon selected");
            takeScreenShot("Icon Selected", driver);
        } catch (Exception e) {
            takeScreenShot("Icon not Selected", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on catalog \"([^\"]*)\" in Edit catalog page$")
    public void User_click_on_catalog_icon(String actionType, String elementName) throws Throwable {
        try {
            new CatalogManagerActions(driver).genericActions(actionType, elementName);
            loggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon clicked");
            takeScreenShot("Icon clicked", driver);
        } catch (Exception e) {
            takeScreenShot("Icon not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }


    @And("^user \"([^\"]*)\" on \"([^\"]*)\" containing \"([^\"]*)\"$")
    public void userOnContaining(String actionType, String elementType, String itemName) throws Throwable {
        try {
            new CatalogManagerActions(driver).genericActions(actionType, elementType, itemName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), itemName + "  is clicked");

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), itemName + "  is not clicked");
            Assert.fail(itemName + "  is not clicked" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" item \"([^\"]*)\" under \"([^\"]*)\" widget$")
    public void userItemUnderWidget(String actionType, String elementName, String widgetName) throws Throwable {
        try {

            new SearchDefinitionActions(driver).genericActions(actionType, widgetName, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Item Name is present");

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Item Name is not present");
            Assert.fail("Item name not displayed" + e.getMessage());
        }
    }

    @And("^user selects the \"([^\"]*)\" from the Type$")
    public void user_selects_the_type_in_dashboard_page(String type) throws Throwable {
        try {
            new SearchDefinitionActions(driver).selectType(type);
            sleepForSec(1500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), type + " checkbox is clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user get the count of the search list$")
    public void user_get_the_count_of_the_search_list() throws Throwable {
        try {
            List<WebElement> getScrollItemList = driver.findElements(By.xpath("//a[@href[contains(.,'/DD/item-view')]]"));
            Set<String> currentpage = new HashSet<String>();
            currentpage.addAll(getStringListFromElementsList(getScrollItemList));

            String a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
            String b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
            List<String> listValue = new ArrayList<>();
            List<WebElement> elements = new SubjectArea(driver).getScrollItemList();
            int y1 = 0;
            int y2 = 0;
            while (true) {
                a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                y1 = Integer.parseInt(commonUtil.getNUMfromString(a));
                scrollDownUsingJS(driver, elements, 1);
                waitForAngularLoad(driver);
                sleepForSec(2000);
                currentpage.addAll(getStringListFromElementsList(getScrollItemList));
                b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                y2 = Integer.parseInt(commonUtil.getNUMfromString(b));

                if (y1 == y2) {
                    List<WebElement> getScrollItemList1 = driver.findElements(By.xpath("//a[@href[contains(.,'/DD/item-view')]]"));
                    currentpage.addAll(getStringListFromElementsList(getScrollItemList1));
                    break;
                }
            }
            listValue.addAll(currentpage);
            new CucumberDataSet().setsearchList(listValue);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail(e.getMessage());
        }
    }

    @And("^verify the count of search list and the Expected count \"([^\"]*)\" matches$")
    public void verify_the_count_of_search_list_and_the_Expected_count_matches(int count) throws Throwable {
        try {
            Assert.assertEquals(count, Integer.parseInt(new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText())), "Count from feature file is " + count + " and the Source Tree UI count" + new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText()) + ", Please Enter the correct Count in Feature File or Check the parsed Count from the Python Parser Plugin. If found no issues with parser plugin check the files count from Git collector plugin.");

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @When("^user \"([^\"]*)\" for \"([^\"]*)\" in search view$")
    public void user_verify_Header_element_presence(String actionType, String elementName) throws Throwable {
        try {
            new SearchDefinitionActions(driver).genericActions(actionType, elementName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), actionType + " is performed on " + elementName + " button");
        } catch (Exception e) {
            takeScreenShot(actionType + " is not performed on " + elementName + " button", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

//    @And("^user assigns new tag to the selected Item$")
//    public void user_assigns_tag() throws Throwable {
//        try {
//            new SearchDefinitionActions(driver).userAssignsTagAnsSaveit();
//            sleepForSec(1000);
//            LoggerUtil.logLoader_info(this.getClass().getName(), "New tag is assigned and the panel is saved");
//        } catch (Exception e) {
//            takeScreenShot("Issue in assigning the tag to the item", driver);
//            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
//        }
//    }

    @Then("^results panel \"([^\"]*)\" should be displayed as \"(.*)\" in Item Search results page$")
    public void results_panel_should_be_displayed_as_in_Item_Search_results_page(String elementName, String expectedValue) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).verifyCount(elementName, expectedValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), elementName + " is matching with" + expectedValue);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), elementName + " is not matching with" + expectedValue);
            Assert.fail(e.getMessage());
        }
    }


    @Then("^Postgres item count for \"([^\"]*)\" attribute should be \"([^\"]*)\"$")
    public void postgres_item_count_for_attribute_should_be(String attribute, String expectedValue) throws Throwable {
        try {
            switch (attribute) {
                case "Field":
                    Assert.assertEquals(expectedValue, CommonUtil.getText());
                    break;
                case "columnList":
                    Assert.assertEquals(expectedValue, CommonUtil.getElementsInList());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database value matches with" + expectedValue);
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database value doesn't matches with" + expectedValue);
        }
    }

    @Then("^Postgres item list should be matched with UI$")
    public void postgres_item_count_for_attribute_should_be(List<CucumberDataSet> dataTableCollection) throws Throwable {
        List<String> itemList = new ArrayList<>();
        try {
            for (CucumberDataSet data : dataTableCollection) {
                itemList.add(data.getItemName());
            }
            Assert.assertTrue(CommonUtil.getElementsInList().containsAll(itemList));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database values are matched");
        } catch (
                Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database values doesn't matches");
        }
    }

    @Then("^UI item count should be matched with DB count$")
    public void UI_item_count_for_attribute_should_be() throws Throwable {
        List<String> itemList = new ArrayList<>();
        try {
            new SubjectAreaManagerActions(driver).getItemCountInSearchView();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database values are matched");
        } catch (
                Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database values doesn't matches");
        }
    }


    @Then("^user \"([^\"]*)\" section has following values$")
    public void user_section_has_following_values(String actionType, DataTable data) throws Throwable {
        try {
            for (Map<String, String> dataMap : data.asMaps(String.class, String.class)) {
                if (dataMap.get("widgetName").isEmpty()) {
                    List<String> propertyList = data.asList(String.class);
                    new SubjectAreaManagerActions(driver).verifyMetadataProperties(actionType, propertyList);
                } else {
                    new SubjectAreaManagerActions(driver).verifyMetadataPropertyValues(actionType, "", data.asMaps(String.class, String.class));
                }
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties displayed in item page");
        } catch (Exception e) {
            takeScreenShot("Metadata properties not displayed in item page", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties not displayed in item page");
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Metadata values are incorrect");
        }
    }

    @Given("^user perfroms \"([^\"]*)\" on  item \"([^\"]*)\" in Item View Page \"([^\"]*)\" section$")
    public void user_perfroms_on_item_in_Item_View_Page_section(String actionType, String itemName, String dataType) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, itemName, dataType);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties displayed in item page");
        } catch (Exception e) {
            takeScreenShot("Metadata properties not displayed in item page", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties not displayed in item page");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user \"([^\"]*)\" with following expected parameters for item \"([^\"]*)\"$")
    public void user_with_following_expected_parameters_for_item(String actionType, String itemName, DataTable data) throws Throwable {
        try {
            List<Map<String, String>> metadata = data.asMaps(String.class, String.class);
            new SubjectAreaManagerActions(driver).verifyMetadataPropertyValues(actionType, itemName, metadata);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties displayed in item page");
        } catch (Exception e) {
            takeScreenShot("Metadata properties not displayed in item page", driver);
            Assert.fail("Error occured : " + e.getMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties not displayed in item page");
        }
    }


    @Given("^user clicks on \"([^\"]*)\" icon in item full view page$")
    public void user_clicks_on_icon_in_item_full_view_page(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Item full view close icon is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is not clicked");
        }
    }

    @Then("^user verify \"([^\"]*)\" any \"([^\"]*)\" attribute under \"([^\"]*)\" facets$")
    public void user_verify_any_attribute_under_facets(String actionType, String attribute, String facetName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, attribute, facetName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Item full view close icon is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is not clicked");
            Assert.fail("Test failed due to error");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Given("^user \"([^\"]*)\" name \"([^\"]*)\" in item view page$")
    public void user_name_in_item_view_page(String actionType, String itemName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, itemName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Item full view close icon is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^following \"([^\"]*)\" values should get displayed in item view page$")
    public void following_values_should_get_displayed_in_item_view_page(String itemName, DataTable data) throws Throwable {
        try {
            List<Map<String, String>> dataTable = data.asMaps(String.class, String.class);
            new SubjectAreaManagerActions(driver).verifyDataSampleValuesPresence(itemName, dataTable);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), itemName + " verification passed");
        } catch (Exception e) {
            takeScreenShot("Item full view close icon is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), itemName + " verification failed: " + e.getMessage());
            Assert.fail(itemName + " verification failed due to : " + e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user \"([^\"]*)\" of following \"([^\"]*)\" in Item View Page$")
    public void user_of_following_in_Item_View_Page(String actionType, String elementName, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new SubjectAreaManagerActions(driver).verifyElementPresence(itemList, actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are present in Item View Page tag section");
        } catch (Exception e) {
            Assert.fail("Element not present");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are not present in Item View Page tag section");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user \"([^\"]*)\" of following \"([^\"]*)\" in Item Search Results Page$")
    public void user_of_following_in_Item_Search_Results_Page(String actionType, String elementName, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new SubjectAreaManagerActions(driver).verifyElementPresence(itemList, actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are present in Item View Page tag section");
        } catch (Exception e) {
            takeScreenShot("Tags are not present in Item View Page tag section", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are not present in Item View Page tag section");
            Assert.fail("Element not present");
        }
    }

    @Then("^user \"([^\"]*)\" of following \"([^\"]*)\" in Search Results Page$")
    public void user_of_following_in_Search_Results_Page(String actionType, String elementName, DataTable data) throws Throwable {
        try {
            if (elementName.equals("Empty Values")) {
                Map<String, String> hm = data.asMap(String.class, String.class);
                Assert.assertFalse(new SubjectAreaManagerActions(driver).verifyElementNonPresence(hm, actionType, elementName));
            } else {
                List<String> itemList = data.asList(String.class);
                new SubjectAreaManagerActions(driver).verifyElementPresence(itemList, actionType, elementName);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are present in Item View Page tag section");
            }
        } catch (Exception e) {
            takeScreenShot("Tags are not present in Item View Page tag section", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are not present in Item View Page tag section");
            Assert.fail("Element present in Item List");
        }
    }

    @Then("^postgres database query result stored in \"([^\"]*)\" should have following values listed$")
    public void postgres_database_query_result_stored_in_should_have_following_values_listed(String value, DataTable dataTable) throws Throwable {
        List<String> ls = new ArrayList<>(dataTable.asList(String.class));
        try {
            switch (value) {
                case "hashSet":
                    List<Map<String, String>> hm = dataTable.asMaps(String.class, String.class);
                    HashSet<String> hs = new HashSet<>();
                    for (Map<String, String> map : hm) {
                        for (Map.Entry<String, String> map1 : map.entrySet()) {
                            hs.addAll(CommonUtil.gettempSingleKeyMultipleValueList().get(map1.getKey()));
                        }
                        Assert.assertEquals(map.values(), hs);
                    }
                    break;
                case "list":
                    Assert.assertTrue(CommonUtil.compareLists(ls, CommonUtil.getElementsInList()));
                    break;

                case "linkedhashset":
                    List<Map<String, String>> hml = dataTable.asMaps(String.class, String.class);
                    LinkedHashSet<String> hsl = new LinkedHashSet<>();
                    for (Map<String, String> map : hml) {
                        for (Map.Entry<String, String> map1 : map.entrySet()) {
                            hsl.addAll(CommonUtil.gettempSingleKeyMultipleValueList().get(map1.getKey()));
                        }
                        Assert.assertEquals(map.values(), hsl);
                    }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database value listed is not correct");
        } finally {
            CommonUtil.gettempSingleKeyMultipleValueList().clear();
        }
    }

    @Then("^user verify \"([^\"]*)\" with following values under \"([^\"]*)\" section in item search results page$")
    public void user_verify_with_following_values_under_section_in_item_search_results_page(String actionType, String facetSection, DataTable attributeList) throws Throwable {
        try {
            List<String> attrList = attributeList.asList(String.class);
            new SubjectAreaManagerActions(driver).verifyElementPresence(attrList, actionType, facetSection);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is clicked");
        } catch (Exception e) {
            takeScreenShot("facets results are incorrect", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item full view close icon is not clicked");
            Assert.fail("facets results are incorrect");
        }
    }

    @And("^user \"([^\"]*)\" icon is \"([^\"]*)\" with tooltip name as \"([^\"]*)\"$")
    public void user_verifies_displayed_icon(String actionType, String elementName, String arg) throws Throwable {
        try {
            new CatalogManagerActions(driver).genericActions(actionType, elementName, arg);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon is present");
        } catch (Exception e) {
            takeScreenShot("Icon is not present", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Icon is not present");
            new DashBoardPage(driver).Click_profileLogoutButton();


        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in Item view page$")
    public void user_click_on_delete_in_item_view_panel(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Delete icon  is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete icon  is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();

        }
    }


    @Given("^user connects to the database and performs the following operation$")
    public void user_connects_to_the_database_and_performs_the_following_operation(DataTable data) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // List<YourType>, List<List<E>>, List<Map<K,V>> or Map<K,V>.
        // E,K,V must be a scalar (String, Integer, Date, enum etc)
        try {
            for (Map<String, String> datatable : data.asMaps(String.class, String.class)) {
                String dbConnection = datatable.get("databaseConnection");
                String operation = datatable.get("Operation");
                String jsonPath = datatable.get("queryPath");
                String queryPage = datatable.get("queryPage");
                String queryField = datatable.get("queryField");
                String schemaName = datatable.get("Schema");
                String tableName = datatable.get("Table");
                String databaseName = datatable.get("Database");
                String query = new JsonRead().readJSon(Constant.TEST_DATA_PATH + jsonPath, queryPage, queryField);
                if (datatable.containsKey("Operation")) {
                    if (operation.contains("EXECUTEQUERY")) {
                        dbHelper.executeSQL(dbConnection, operation, query);
                    } else if (operation.contains("DROP")) {
                        dbHelper.executeSQL(dbConnection, operation, "", schemaName, tableName, "", "", databaseName);
                    }
                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());

        }
    }

    @Then("^user \"([^\"]*)\" the Item search result \"([^\"]*)\" value with Postgres DB$")
    public void user_the_Item_search_result_value_with_Postgres_DB(String actionType, String elementName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            new SubjectAreaManagerActions(driver).verifyValuesfromUIandDB(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values from UI and DB matches");
        } catch (Exception e) {
            takeScreenShot("Item Search result page", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Value from UI and DB doesn't match");
        }
    }

    @Then("^user \"([^\"]*)\" presence of \"([^\"]*)\" in Analysis Log of IDC UI$")
    public void user_presence_of_in_Analysis_Log_of_IDC_UI(String actionType, String value) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).verifyElementPresence(actionType, value);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verify successful");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Verification failed: " + e.getMessage());
        }
    }


    @Given("^user \"([^\"]*)\" on \"([^\"]*)\" pagination link in Item Search Results page$")
    public void user_on_pagination_link_in_Item_Search_Results_page(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values from UI and DB matches");
        } catch (Exception e) {
            takeScreenShot("Item Search result page", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Value from UI and DB doesn't match");
        }
    }

    @Then("^user clicks on to sort the latest result$")
    public void user_clicks_on_sort_list() {
        try {
            clickOn(new SubjectArea(driver).returnsort());
            sleepForSec(2000);
            clickOn(new SubjectArea(driver).returnsort());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }


    @Given("^user gets amazon bucket \"([^\"]*)\" file count in \"([^\"]*)\" directory and store in temp variable$")
    public void user_gets_amazon_bucket_file_count_in_directory_and_store_in_temp_variable(String bucketName, String dirPath) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).getS3FileCount(bucketName, dirPath);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Count is equal");
        } catch (Exception e) {
            takeScreenShot("Tags are not present in Item View Page tag section", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File count is not equal");
            Assert.fail("File Count is not equal");
        }
    }

    @Given("^user copy metadata value from Item View Page and write to file using below parameters$")
    public void user_copy_metadata_value_from_Item_View_Page_and_write_to_file_using_below_parameters(DataTable data) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).writeMetaDataContentToFile(data.asMap(String.class, String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content copied to file");
        } catch (Exception e) {
            takeScreenShot("Content not written to file", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content not written to file");
            Assert.fail("Content not written to file");
        }
    }

    @And("^Delete multiple values in IDC UI with below parameters$")
    public void Delete_multiple_values_in_IDC_UI_with_below_parameters(DataTable parameters) throws Throwable {
        try {
            for (Map<String, String> data : parameters.asMaps(String.class, String.class)) {
                String query = data.get("query");
                String param = data.get("query");
                String type = data.get("type");
                String name = data.get("name");
                String catalogName = data.get("catalog");
                String action = data.get("deleteAction");
                new SubjectAreaManagerActions(driver).deleteMultipleItemsinUI(action, type, catalogName, name, query, param);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "check the feature file for null values");
            takeScreenShot("Items not deleted", driver);
            Assert.fail("items not deleted");

        }

    }

    @Then("^file content in \"([^\"]*)\" should be same as the content in \"([^\"]*)\"$")
    public void file_content_in_should_be_same_as_the_content_in(String srcFile, String destFile) throws Throwable {
        try {
            Assert.assertTrue(CommonUtil.compareTwoJsonFiles(Constant.REST_PAYLOAD + srcFile, Constant.REST_PAYLOAD + destFile));

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content in both the files are same");
        } catch (Exception e) {
            takeScreenShot("Content in both the files are not same", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content in both the files are not same");
            Assert.fail("Content in both the files are not same");
        }
    }

    @Given("^user remove the json attribute from file for following parameters$")
    public void user_remove_the_json_attribute_from_file_for_following_parameters(DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> map : dataTable.asMaps(String.class, String.class)) {
                JsonBuildUpdateUtil.removeJsonNodeUsingKey(Constant.REST_PAYLOAD + map.get("filePath"), map.get("attributeName"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "attribute removed from json file");
        } catch (Exception e) {
            takeScreenShot("attribute removed from json file", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "attribute removed from json file");
            Assert.fail("attribute removed from json file");
        }
    }

    @Given("^user remove the json attribute from json file using json path$")
    public void user_remove_the_json_attribute_from_json_file_using_json_path(DataTable dataTable) throws Throwable {
        FileWriter fileWriter = null;
        try {
            for (Map<String, String> map : dataTable.asMaps(String.class, String.class)) {
                org.json.simple.parser.JSONParser jsonParser = new JSONParser();
                org.json.simple.JSONObject jsonObject = new org.json.simple.JSONObject();
                Object obj = jsonParser.parse(new FileReader(Constant.REST_PAYLOAD + map.get("filePath")));
                jsonObject = (org.json.simple.JSONObject) obj;
                ObjectNode value = JsonBuildUpdateUtil.removeJsonNode(jsonObject.toJSONString(), map.get("jsonpath"));
                fileWriter = new FileWriter(Constant.REST_PAYLOAD + map.get("filePath"));
                fileWriter.write(value.toString());
                fileWriter.flush();
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "attribute removed from json file");


        } catch (Exception e) {
            takeScreenShot("attribute removed from json file", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "attribute not removed from json file");
            Assert.fail("attribute not removed from json file");
        } finally {
            fileWriter.close();
        }
    }


    @Then("^user \"([^\"]*)\" of technology tags for the following parameters$")
    public void user_of_technology_tags_in_for_the_following_parameters(String actionType, DataTable arg3) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // List<YourType>, List<List<E>>, List<Map<K,V>> or Map<K,V>.
        // E,K,V must be a scalar (String, Integer, Date, enum etc)
        for (Map<String, String> data : arg3.asMaps(String.class, String.class)) {
            String catalogName = data.get("catalogName");
            String name = data.get("name");
            String Tag = data.get("Tag");
            String facet = data.get("facet");
            try {
                switch (actionType.toLowerCase()) {
                    case "verifies presence":
                        if (new SubjectAreaManagerActions(driver).verifyTag(catalogName, name, Tag, facet) == false) {
                            throw new Exception();
                        }
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is Verified with UI");
                        break;
                }
            } catch (Exception e) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag Verification failed in UI for " + name);
                Assert.fail("Technology tag is not matching with the expected values for " + name);
            }
        }
    }


    @Then("^user \"([^\"]*)\" of technology tags for the below Type and file names$")
    public void userOfTechnologyTagsForTheBelowTypeAndFileNames(String actionType, DataTable arg3) throws Throwable {
        for (Map<String, String> data : arg3.asMaps(String.class, String.class)) {
            String catalogName = data.get("catalogName");
            String name = data.get("name");
            String Tag = data.get("Tag");
            String facet = data.get("facet");
            String fileName = data.get("fileName");
            String userTag = data.get("userTag");
            try {
                switch (actionType.toLowerCase()) {
                    case "verifies presence":
                        if (new SubjectAreaManagerActions(driver).verifyTagWithFileName(catalogName, name, Tag, facet, fileName) == false) {
                            throw new Exception();
                        }
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is Verified with UI");
                        break;
                    case "verify tag item presence":
                        if (new SubjectAreaManagerActions(driver).verifyTagInSearchResult(catalogName, name, Tag, facet, fileName, userTag) == false) {
                            throw new Exception();
                        }
                        break;

                    case "verify tag item non presence":
                        if (new SubjectAreaManagerActions(driver).verifyTagNotInSearchResult(catalogName, name, Tag, facet, fileName, userTag) == true) {
                            throw new Exception();
                        }
                        break;
                }
            } catch (Exception e) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag Verification failed in UI for " + name);
                Assert.fail("Technology tag is not matching with the expected values for " + name);
            }
        }

    }

    @Then("^user confirm \"([^\"]*)\" for the below item types$")
    public void userConfirmForTheBelowItemTypes(String actionType, DataTable arg3) throws Throwable {
        for (Map<String, String> data : arg3.asMaps(String.class, String.class)) {
            String catalogName = data.get("catalogName");
            String facetName = data.get("facetName");
            String facet = data.get("facet");
            String itemName = data.get("itemName");
            String windowName = data.get("windowName");
            String metaDataAttribute = data.get("metaDataAttribute");
            String widgetName = data.get("widgetName");
            try {
                switch (actionType.toLowerCase()) {
                    case "non presence of window":
                        if (new SubjectAreaManagerActions(driver).verifyWindowNotAvailable(catalogName, facetName, facet, itemName, windowName) == false) {
                            throw new Exception();
                        }
                        break;
                    case "non presence of metadata properties":
                        if (new SubjectAreaManagerActions(driver).verifyMetadataAttributesNotAvailable(metaDataAttribute, widgetName) == false) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "MetadataAttribute: " +metaDataAttribute+ " is not Available under widget: " + widgetName);
                        } else {
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "MetadataAttribute: " +metaDataAttribute+ " is Available under widget: " + widgetName);
                            Assert.fail("MetadataAttribute: " +metaDataAttribute+ " is Available under widget: " + widgetName);
                        }
                        break;
                }
            } catch (Exception e) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Window availability check failed for : " + itemName);
                Assert.fail("Window availability check failed for : " + itemName);
            }
        }
    }

    @Then("^verify \"([^\"]*)\" of technology tags in navigated items$")
    public void verify_uses_of_technology_tags_in_navigated_items(String actionType, DataTable arg3) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // List<YourType>, List<List<E>>, List<Map<K,V>> or Map<K,V>.
        // E,K,V must be a scalar (String, Integer, Date, enum etc)
        Map<String, String> data = arg3.asMap(String.class, String.class);
        {
            String Tag = data.get("Tag");
            String item = data.get("item");
            try {
                switch (actionType.toLowerCase()) {
                    case "verifies presence":
                        if (new SubjectAreaManagerActions(driver).verifyTag_navigatedItems(Tag, item) == false) {
                            throw new Exception();
                        }
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is Verified with UI");
                        break;
                }
            } catch (Exception e) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag is Verification failed in UI");
                Assert.fail("Technology tag is not matching with the expected values");
            }
        }
    }


    @Then("^user \"([^\"]*)\" the presence of the Values in \"([^\"]*)\" json using the Jsonpath \"([^\"]*)\"$")
    public void user_the_presence_of_the_Values_in_json_using_the_Jsonpath(String actionType, String jsonFile, String jsonPath, DataTable arg4) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // List<YourType>, List<List<E>>, List<Map<K,V>> or Map<K,V>.
        // E,K,V must be a scalar (String, Integer, Date, enum etc)
        try {
            Map<String, String> data = arg4.asMap(String.class, String.class);
            Assert.assertTrue(data.equals(new SubjectAreaManagerActions(driver).MapValuefromJson(actionType, jsonFile, jsonPath)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values are present in Json");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values in datatable doesn't match with the Json");
            Assert.fail("Failed due to match error between Json and Datatable");
        }
    }

    @Then("^user verifies the presence of json \"([^\"]*)\" in the json file$")
    public void user_verifies_the_presence_of_json_in_the_json_file(String actionType, DataTable data) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        // For automatic transformation, change DataTable to one of
        // List<YourType>, List<List<E>>, List<Map<K,V>> or Map<K,V>.
        // E,K,V must be a scalar (String, Integer, Date, enum etc)
        try {
            for (Map<String, String> dataList : data.asMaps(String.class, String.class)) {
                String filePath = dataList.get("actualFilePath");
                String jsonPath = dataList.get("jsonPath");
                String expectedvalue = dataList.get("jsonValue");
                String expectedfilePath = dataList.get("expectedFilePath");
                new SubjectAreaManagerActions(driver).verifyJsonValue(actionType, filePath, jsonPath, expectedvalue, expectedfilePath);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "expected value matches in the Json");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "expected value does not match with json");
            Assert.fail("expected value does not match in Json");
        }
    }

    @Given("^user \"([^\"]*)\" section does not have the following values$")
    public void user_section_does_not_have_the_following_values(String actionType, DataTable data) throws Throwable {
        try {
            List<Map<String, String>> propertyList = data.asMaps(String.class, String.class);
            new SubjectAreaManagerActions(driver).verifyMetadataAttributesNotContains(actionType, propertyList);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties are not displayed in item page");
        } catch (Exception e) {
            takeScreenShot("Metadata properties are displayed in item page", driver);
            Assert.fail("Metadata properties are displayed in item page");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties are displayed in item page");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Given("^user verfies whether metadata property value contains the expected text for the respective property$")
    public void user_verifies_expectedText_in_MetaData(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new SubjectAreaManagerActions(driver).verifyMetadataPropertiesContains(values.get("metaDataPropertyName"), values.get("metaDataPropertyValue"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content copied to file");
        } catch (Exception e) {
            takeScreenShot("Content not written to file", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content not written to file");
            Assert.fail("Content not written to file");
        }
    }

    @Then("^json assert in expected file \"([^\"]*)\" and actual file \"([^\"]*)\" should be \"([^\"]*)\"$")
    public void json_assert_in_expected_file_and_actual_file_should_be(String srcFile, String destFile, String arg3) throws Throwable {
        try {
            switch (arg3) {
                case "equal excluding order":
                    JSONAssert.assertEquals(jsonRead.readFile(Constant.REST_PAYLOAD + srcFile), jsonRead.readFile(Constant.REST_PAYLOAD + destFile), JSONCompareMode.LENIENT);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content in both the files are same");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content in both the files are not same");
            Assert.fail("Content in both the files are not same");
        }
    }

    @Given("^user performs \"([^\"]*)\" sort in Item Results page$")
    public void user_performs_sort_in_Item_Results_page(String arg1) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            new SubjectAreaManagerActions(driver).verifyItemResultsSort(arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Sort operation performed in Item results page");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Exception : " + e.getMessage());
            Assert.fail("Sort operation cannot be performed");
        }
    }

    @And("^user removes following items from the \"([^\"]*)\" panel$")
    public void userRemovesFollowingItemsFromThePanel(String arg0, DataTable data) throws Throwable {
        try {
            List<String> propertyList = data.asList(String.class);
            new SubjectAreaManagerActions(driver).removeAttributesFromThePanel(arg0, propertyList);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Sort operation performed in Item results page");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Exception : " + e.getMessage());
            Assert.fail("Sort operation cannot be performed");
        }
    }

    @Then("^user verify whether \"([^\"]*)\" for below parameters$")
    public void user_verify_whether_for_below_parameters(String arg1, DataTable arg2) throws Throwable {
        try {
            Assert.assertFalse(new SubjectAreaManagerActions(driver).verifyElementNonPresence(arg2.asMaps(String.class, String.class), arg1));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Exception : " + e.getMessage());
            Assert.fail("Password value is not encrypted");
        }
    }

//10.3 New UI Step definitions

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" tab in Item view page$")
    public void user_click_on_dataaSampling_in_item_view_panel(String actionType, String elementName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete icon is clicked");
        } catch (Exception e) {
            takeScreenShot("Delete icon  is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete icon  is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();

        }
    }

    @Then("^user verifies the background color of the Item view page$")
    public void user_verifies_the_color_code_for_any_displayed_node(DataTable data) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                String actualRGBCode = new DashBoardPage(driver).getTableBackgroundcolor(values.get("Page")).getCssValue(values.get("StyleType"));
                String expectedRGBCode = values.get("ColorCode");

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

    @Given("^user performs \"([^\"]*)\" on \"([^\"]*)\" item from search results$")
    public void user_performs_on_item_from_search_results(String actionType, String itemName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, itemName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), itemName + " is clicked");
        } catch (Exception e) {
            Assert.fail(itemName + " is not clicked");
            takeScreenShot(itemName + " is not clicked", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), itemName + " is not clicked");
        }
    }

    @When("^user clicks on first item on the item list page$")
    public void user_clicks_on_first_item_on_the_item_list_page() {
        try {
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).returnfirstItemIntableOfItemsFound().get(0));
            sleepForSec(1000);
            waitForAngularLoad(driver);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }


    @Given("^user performs \"([^\"]*)\" in \"([^\"]*)\" attribute under \"([^\"]*)\" facets in Item Search results page$")
    public void user_performs_in_attribute_under_facets_in_Item_Search_results_page(String actionType, String attributeName, String facet) throws Throwable {
        try {
            implicit_wait(driver,3);
            new SubjectAreaManagerActions(driver).genericActions(actionType, attributeName, facet);
            implicit_wait(driver,3);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), attributeName + " selected in" + facet);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), attributeName + " not selected in" + facet);
            Assert.fail(attributeName + " not found");
        }
    }


    @Given("^user connect to the database and execute query for the following parameters$")
    public void user_connect_to_the_database_and_execute_query_for_the_following_parameters(DataTable data) throws Throwable {
        String query = null;
        try {
            for (Map<String, String> dataList : data.asMaps(String.class, String.class)) {
                String dataBaseName = dataList.get("dataBaseName");
                String dataBaseType = dataList.get("dataBaseType");
                String jsonPath = dataList.get("queryPath");
                String queryPage = dataList.get("queryPage");
                String queryField = dataList.get("queryField");
                String queryOperation = dataList.get("queryOperation");
                String columnName = dataList.get("columnName");
                query = new JsonRead().readJSonFromQuery(Constant.TEST_DATA_PATH + jsonPath, queryPage, queryField);
                if (dataList.containsKey("storeResults")) {
                    if (dataList.get("storeResults").equals("rowCount")) {
                        CommonUtil.storeText(String.valueOf(dbHelper.getRecordCount(dataBaseType, dataBaseName, query)));
                    } else if (dataList.get("storeResults").equals("rowValue")) {
                        CommonUtil.storeText(String.valueOf(dbHelper.returnValue(dataBaseName, query)));
                    } else if (dataList.get("storeResults").equals("rowStringValue")) {
                        CommonUtil.storeText(String.valueOf(dbHelper.returnStringValue(dataBaseName, query, columnName)));
                    } else if (dataList.get("storeResults").equals("resultsInMap")) {
                        for (Map.Entry<String, List<String>> dbEntry : dbHelper.returnQueryMap(dataBaseName, query).entrySet()) {
                            CommonUtil.addToTemporaryHashMap(dbEntry.getKey(), dbEntry.getValue());
                        }
                    } else if (dataList.get("storeResults").equals("rowList")) {
                        List<String> dbList = dbHelper.returnRecordInlist(dataBaseType, dataBaseName, query, dataList.get("columnName"));
                        for (String listValue : dbList) {
                            CommonUtil.addElementsInList(listValue);
                        }

                    } else if (dataList.get("storeResults").equals("resultsInList")) {
                        CommonUtil.storeTemporaryList(dbHelper.returnQueryInList(dataBaseName, queryOperation, query, "", "", columnName));
                    }
                }
            }

        } catch (Exception e) {
            Assert.fail(" not found in db");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^following \"([^\"]*)\" for item \"([^\"]*)\" should match with postgres values stored in \"([^\"]*)\"$")
    public void following_for_item_should_match_with_postgres_values_stored_in(String actionType, String itemName, String dbValues, DataTable data) throws Throwable {
        try {
            List<String> metadata = data.asList(String.class);
            new SubjectAreaManagerActions(driver).verifyDBValuesAndUIValues(metadata, actionType, itemName, dbValues);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties displayed in item page");
        } catch (Exception e) {
            Assert.fail("Metadata properties not correct in item page");
            takeScreenShot("Metadata properties not correct in item page", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties not displayed in item page");
            Assert.fail("Metadata properties not correct in item page");
        } finally {
            {
                CommonUtil.gettempSingleKeyMultipleValueList().clear();
            }
        }
    }

    @Then("^user \"([^\"]*)\" the \"([^\"]*)\" Item view page result \"([^\"]*)\" value with Postgres DB$")
    public void user_the_Item_view_page_result_value_with_Postgres_DB(String actionType, String tabName, String elementName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            new SubjectAreaManagerActions(driver).verifyValuesfromUIandDB(actionType, tabName, elementName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values from UI and DB matches");
        } catch (Exception e) {
            takeScreenShot("Item Search result page", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Value from UI and DB doesn't match");
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" for \"([^\"]*)\" in \"([^\"]*)\" page$")
    public void user_on_Page(String actionType, String buttonName, String field, String PageName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new SubjectAreaManagerActions(driver).genericActions(actionType, buttonName, field);
            waitForAngularLoad(driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot(buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " is not clicked");
        }
    }

    @When("^user clicks on close button in the item full view page$")
    public void user_clicks_on_close_button_in_the_item_full_view_page() {
        try {
            new SubjectArea(driver).click_itemFullViewPageCloseButton();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user verify Facet type and counts with following values under \"([^\"]*)\" section in item search results page$")
    public void userVerifyFacetTypeAndCountsWithFollowingValuesUnderSectionInItemSearchResultsPage(String sectionName, DataTable arg0) throws Throwable {

        try {
            waitForAngularLoad(driver);
            for (Map<String, String> items : arg0.asMaps(String.class, String.class)) {
                String facetType = items.get("facetType");
                String count = items.get("count");
                new SubjectAreaManagerActions(driver).verifyFacetTypeAndCounts(facetType, count, sectionName);
            }
        } catch (Exception e) {
            Assert.fail("Metadata widget item values are not correct");
            takeScreenShot("Metadata item values are not correct", driver);
        }

    }

    @And("^user \"([^\"]*)\" in item view Page$")
    public void userInItemViewPage(String actionType, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                sleepForSec(1500);
                new SubjectAreaMgmtActions(driver).genericActions(actionType, values.get("fieldName"), values.get("value"));
                sleepForSec(500);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action in item View page is performed");
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "action in item View page is not performed");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }


    @Then("^user performs click and verify in new window$")
    public void user_performs_click_and_verify_in_new_window(DataTable data) throws Throwable {

        for (Map<String, String> values : data.asMaps(String.class, String.class)) {
            String hasTableName = values.get("Table");
            String itemName = values.get("value");
            String action = values.get("Action");
            String retainWin = values.get("RetainPrevwindow");
            String indexNum = values.get("indexSwitch");
            switch (action) {
                case "click and switch tab":
                    new SubjectAreaManagerActions(driver).genericActions(action, hasTableName, itemName, retainWin);
                    break;
                case "verify widget contains":
                    waitForAngularLoad(driver);
                    if (indexNum.isEmpty()) {
                        new SubjectAreaManagerActions(driver).verifyElementPresence(action, hasTableName, itemName);
                    } else {
//                        int winindex = Integer.parseInt(indexNum);
//                        new SubjectAreaManagerActions(driver).verifyElementPresence(action, hasTableName, itemName);
//                        switchToWindowIndex(driver, winindex);
                        new SubjectAreaManagerActions(driver).verifyElementPresence(action, hasTableName, itemName);
                        user_navigates_to_the_index_to_perform_actions(Integer.parseInt(indexNum));
                    }
                    break;
                case "click and verify lineagehops":
                    if (indexNum.isEmpty()) {
                        System.out.println("hi");
                        String filePath = values.get("filePath");
                        String jsonPath = values.get("jsonPath");
                        new SubjectAreaManagerActions(driver).genericActions("click and switch tab", hasTableName, itemName, retainWin);
                        new SubjectAreaManagerActions(driver).verifyLineageHopValues(filePath, jsonPath);
                        break;
                    } else {
                        int winindex = Integer.parseInt(indexNum);
                        String filePath = values.get("filePath");
                        String jsonPath = values.get("jsonPath");
                        new SubjectAreaManagerActions(driver).genericActions("click and switch tab", hasTableName, itemName, retainWin);
                        new SubjectAreaManagerActions(driver).verifyLineageHopValues(filePath, jsonPath);
                        //switching back to the previous page using breadcrumb
                        List<WebElement> breadcrumpsList = new LinkedList<>();
                        breadcrumpsList.addAll(new SubjectArea(driver).getTopBreadCrumbLinkList());
                        Collections.reverse(breadcrumpsList);
                        clickOnWithJavascript(driver,breadcrumpsList.get(winindex));
                        waitForAngularLoad(driver);
                        break;
                    }
                case "click and verify metadat":
                    String metadataSection;
                    if (values.get("metadataSection") == null || values.get("metadataSection").isEmpty()) {
                        metadataSection = "Metadata";
                    } else {
                        metadataSection = values.get("metadataSection");
                    }
                    if (indexNum.isEmpty()) {
                        String filePath = values.get("filePath");
                        String jsonPath = values.get("jsonPath");
                        new SubjectAreaManagerActions(driver).genericActions("click and switch tab", hasTableName, itemName, retainWin);
                        new SubjectAreaManagerActions(driver).verifymetaDataValues(filePath, jsonPath, metadataSection);
                        break;
                    } else {
                        String filePath = values.get("filePath");
                        String jsonPath = values.get("jsonPath");
                        new SubjectAreaManagerActions(driver).genericActions("click and switch tab", hasTableName, itemName, retainWin);
                        waitForAngularLoad(driver);
                        new SubjectAreaManagerActions(driver).verifymetaDataValues(filePath, jsonPath, metadataSection);
                        //switching back to the previous page using breadcrumb
                        user_navigates_to_the_index_to_perform_actions(Integer.parseInt(indexNum));
                        break;

                    }

                case "click and verify tag":
                    if (indexNum.isEmpty()) {
                        String actionType = values.get("verify");
                        String tagValue = values.get("tag");
                        new SubjectAreaManagerActions(driver).genericActions("click and switch tab", hasTableName, itemName, retainWin);
                        new SubjectAreaManagerActions(driver).tagVerification(actionType,tagValue);
                        break;
                    } else {
                        int winindex = Integer.parseInt(indexNum);
                        String actionType = values.get("verify");
                        String tagValue = values.get("tag");
                        new SubjectAreaManagerActions(driver).genericActions("click and switch tab", hasTableName, itemName, retainWin);
                        waitForAngularLoad(driver);
                        new SubjectAreaManagerActions(driver).tagVerification(actionType,tagValue);
                        //switching back to the previous page using breadcrumb
                        List<WebElement> breadcrumpsList = new LinkedList<>();
                        breadcrumpsList.addAll(new SubjectArea(driver).getTopBreadCrumbLinkList());
                        Collections.reverse(breadcrumpsList);
                        breadcrumpsList.get(winindex).click();
                        waitForAngularLoad(driver);
                        break;

                    }
            }
        }
    }

    @And("^user switches to the browser window of index \"([^\"]*)\"$")
    public void user_switches_to_the_browser_window_of_index(String winindex) {
        try {
            switchToWindowIndex(driver, Integer.parseInt(winindex));
        } catch (Exception e) {
            e.printStackTrace();
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Window did not switch to the index" + Integer.parseInt(winindex));
        }
    }


    @Given("^user connects \"([^\"]*)\" with \"([^\"]*)\" and get \"([^\"]*)\" from \"([^\"]*)\" using \"([^\"]*)\"and store the item id result in \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_connects_with_and_get_from_using_and_store_the_item_id_result_in_using(String database, String databaseType, String dbQuery, String queryFile, String queryPath, String targetFile, String jsonpath) throws Throwable {
        try {
            String query = JsonRead.getJsonValue(Constant.TEST_DATA_PATH + queryFile, queryPath).replace("[", "").replace("]", "").replace("\"", "");
            JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + targetFile, jsonpath, dbHelper.returnValue(database, query));

        } catch (Exception e) {

        }

    }

    @Given("^user connects \"([^\"]*)\" and run query using \"([^\"]*)\" with \"([^\"]*)\" and \"([^\"]*)\" and store the item id results in \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_connects_and_run_query_using_with_and_and_store_the_item_id_results_in_using(String database, String catalog, String name, String type, String targetFile, String jsonpath) throws Throwable {
        try {
            if (type.isEmpty()) {
                if (name.contains("DYN")) {
                    name = name.replace("DYN", "");
                    String query = "SELECT * from public.items where  catalog='" + catalog + "' and name like'" + name + "' ORDER By  asg_modifiedat DESC LIMIT 1;";
                    JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + targetFile, jsonpath, dbHelper.returnValue(database, query));

                } else {
                    String query = "SELECT * from public.items where  catalog='" + catalog + "' and name='" + name + "'";
                    JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + targetFile, jsonpath, dbHelper.returnValue(database, query));
                }
            } else {
                String query = "SELECT * from public.items where  catalog='" + catalog + "' and name='" + name + "' and type='" + type + "'";
                JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + targetFile, jsonpath, dbHelper.returnValue(database, query));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user connects \"([^\"]*)\" and run query using \"([^\"]*)\" with \"([^\"]*)\" for \"([^\"]*)\"and store the item id results in temp text$")
    public void user_connects_and_run_query_using_with_for_and_store_the_item_id_results_in_temp_text(String database, String catalog, String name, String column) throws Throwable {
        try {
            if (name.contains("DYN")) {
                name = name.replace("DYN", "");
                String query = "SELECT " + column + " from public.items where  catalog='" + catalog + "' and name like'" + name + "' ORDER By  asg_modifiedat DESC LIMIT 1;";
                String val1 = dbHelper.returnStringValue(database, query, column);
                CommonUtil.storeText(val1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    @And("^user \"([^\"]*)\" for listed \"([^\"]*)\" facet in Search results page$")
    public void userForListedFacetInSearchResultsPage(String actionType, String elementName, DataTable data) throws Throwable {
        try {
            List<String> itemList = data.asList(String.class);
            new SearchDefinitionActions(driver).validatePresence(actionType, elementName, itemList);
            waitForAngularLoad(driver);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "action in sidebar is performed");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Item Type List could not be retrieved");
            Assert.fail("Item type not displayed" + e.getMessage());
        }
    }

    //method from QADev
    @Given("^user \"([^\"]*)\" has the following values in \"([^\"]*)\" Tab in Item View page$")
    public void user_has_the_following_values_in_Tab_in_Item_View_page(String arg1, String arg2, DataTable arg3) throws Throwable {
        // Write code here that turns the phrase above into concrete actions12
        try {
            String actionType = arg1;
            String tabValue = arg2;
            List<String> values = arg3.asList(String.class);
            new SubjectAreaManagerActions(driver).verifyTabSectionValues(actionType, tabValue, values);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values matched in UI");
        } catch (Exception e) {
            takeScreenShot("Mentioned table is not present in item View page", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Mentioned table is not present in item View page");
            Assert.fail(e.getMessage());
        }

    }

    @And("^User compares the file count from Bitbucket and search list$")
    public void user_compares_the_file_count_from_Bitbucket_and_search_list() throws Throwable {

        try {
            waitForAngularLoad(driver);
            String fileCountFromAPI = DataLoader.getDataLoaderInstance().getRepoData().getRepoFileCount().toString();
            String val = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
            LoggerUtil.logLoader_info(val, "Number of Items found In UI");
            //Assert.assertEquals(getTemporaryText(), fileCountFromAPI);
            Assert.assertEquals(val, fileCountFromAPI);
        } catch (Exception e) {
            Assert.fail("Search Result and Bitbucket count is not matching  " + e.getMessage());
        }
    }

    @And("^user verifies the Relationship of \"([^\"]*)\" and Table for the following values in \"([^\"]*)\"$")
    public void userVerifiesTheRelationshipOfAndTableForTheFollowingValuesIn(String arg1, String arg2, DataTable arg3) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).verifyTableRelationship(arg1, arg2, arg3.asMaps(String.class, String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Relation ship for " + arg1 + " verified");
        } catch (Exception e) {
            takeScreenShot("Relation ship for " + arg1 + " failed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Relation ship for " + arg1 + " failed");
            Assert.fail(e.getMessage() + "Relation ship for " + arg1 + " failed");
        }
    }


    @Given("^user connects \"([^\"]*)\" and \"([^\"]*)\" by running query with \"([^\"]*)\"\"([^\"]*)\"\"([^\"]*)\"\"([^\"]*)\" and store the item id results in \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_connects_and_by_running_query_with_and_store_the_item_id_results_in_using(String database, String retrieve, String catalog, String type, String name, String scope, String jsonFile, String jsonPath) throws Throwable {
        FileWriter fileWriter = null;
        try {
            switch (retrieve) {
                case "ClassID":
                    String query = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'";
                    FileUtil.createFileAndWriteData(Constant.REST_DIR + jsonFile, "{}");
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, "classID", Integer.parseInt(dbHelper.returnValue(database, query)));
                    break;
                case "FunctionID":
                    String classID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, "$.classID");
                    String funcQuery = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and asg_scopeid ='" + classID + "'";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, "functionID", Integer.parseInt(dbHelper.returnValue(database, funcQuery)));
                    break;
                case "LineageID":
                    String functID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, jsonPath);
                    String lineageHops = "Select id,name from public.items where catalog='" + catalog + "' and type='" + type + "' and asg_scopeid='" + functID + "'";
                    dbHelper.returnQueryMap(database, lineageHops);
                    Map<String, Integer> newMap = new HashMap<>();
                    List<String> key = new ArrayList<String>();
                    newMap = dbHelper.returnDBRowValuesInMap(dbHelper.returnQueryMap(database, lineageHops), "name", "id");
                    key = dbHelper.returnRowValuesInList(dbHelper.returnQueryMap(database, lineageHops), "name");
                    JsonBuildUpdateUtil.addListAndMapValuesToJSONFile(Constant.REST_DIR + jsonFile, "hopsList", key, "hopsID", newMap);
                    break;
                case "TableIDinsideFunction":
                    String functionID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, jsonPath);
                    String tableQuery = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and asg_scopeid ='" + functionID + "'";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, "tableIDinsideFunction", Integer.parseInt(dbHelper.returnValue(database, tableQuery)));
                    break;
                case "LineageIDinsideTable":
                    String tableID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, jsonPath);
                    String lineageHopsInsideTable = "Select id,name from public.items where catalog='" + catalog + "' and type='" + type + "' and asg_scopeid='" + tableID + "'";
                    dbHelper.returnQueryMap(database, lineageHopsInsideTable);
                    Map<String, Integer> hopsMap = new HashMap<>();
                    List<String> hopsKey = new ArrayList<String>();
                    hopsMap = dbHelper.returnDBRowValuesInMap(dbHelper.returnQueryMap(database, lineageHopsInsideTable), "name", "id");
                    hopsKey = dbHelper.returnRowValuesInList(dbHelper.returnQueryMap(database, lineageHopsInsideTable), "name");
                    JsonBuildUpdateUtil.addListAndMapValuesToJSONFile(Constant.REST_DIR + jsonFile, "hopsList", hopsKey, "hopsID", hopsMap);
                    break;
                case "FileID":
                    String fileQuery = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'";
                    FileUtil.createFileAndWriteData(Constant.REST_DIR + jsonFile, "{}");
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, "fileID", Integer.parseInt(dbHelper.returnValue(database, fileQuery)));
                    break;
                case "FieldID":
                    String fileID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, "$.fileID");
                    String fieldQuery = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "' and asg_scopeid='" + fileID + "'";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, "fieldID", Integer.parseInt(dbHelper.returnValue(database, fieldQuery)));
                    break;

                case "FieldIDList":
                    String fileIDs = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, "$.fileID");
                    String fieldIdName = "Select id,name from public.items where catalog='" + catalog + "' and type='" + type + "' and asg_scopeid='" + fileIDs + "'";
                    dbHelper.returnQueryMap(database, fieldIdName);
                    Map<String, Integer> newMap1 = new HashMap<>();
                    List<String> key1 = new ArrayList<String>();
                    newMap1 = dbHelper.returnDBRowValuesInMap(dbHelper.returnQueryMap(database, fieldIdName), "name", "id");
                    key1 = dbHelper.returnRowValuesInList(dbHelper.returnQueryMap(database, fieldIdName), "name");
                    JsonBuildUpdateUtil.addListAndMapValuesToJSONFile(Constant.REST_DIR + jsonFile, "FieldIdList", key1, "fieldNameId", newMap1);
                    break;
                case "ID":
                    String queryID = "SELECT ID from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'  ORDER By  asg_modifiedat DESC LIMIT 1;";
                    JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + jsonFile, jsonPath, dbHelper.returnValue(database, queryID));
                    break;
                case "AsgScope_ID":
                    String idQuery = "SELECT ID from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'  ORDER By  asg_modifiedat DESC LIMIT 1;";
                    String ID = dbHelper.returnValue(database, idQuery);
                    String asgScopeidQuery = "Select id,name from public.items where catalog='" + catalog + "' and name='" + scope + "' and asg_scopeid='" + ID + "'";
                    JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + jsonFile, jsonPath, dbHelper.returnValue(database, asgScopeidQuery));
                    break;
                case "Unique_ID":
                    String[] types = type.split(",");
                    String[] names = name.split(",");
                    String uniqueID_query = null;
                    if (types.length == 3) {
                        uniqueID_query = "select * from public.items where name ='" + names[2] + "' and type ='" + types[2] + "' and asg_scopeid IN (select id from public.items where name ='" + names[1] + "' and type='" + types[1] + "'  and asg_scopeid IN(select id from public.items where name like '%" + names[0] + "%' and type='" + types[0] + "'));";
                    }
                    if (types.length == 5) {
                        uniqueID_query = "select id from public.items where name ='" + names[4] + "' and type='" + types[4] + "' and asg_scopeid IN (select id from public.items where name ='" + names[3] + "' and type='" + types[3] + "' and asg_scopeid IN (select id from public.items where name ='" + names[2] + "' and type='" + types[2] + "' and asg_scopeid IN (select id from public.items where name ='" + names[1] + "' and type='" + types[1] + "'  and asg_scopeid IN(select id from public.items where name like '%" + names[0] + "%' and type='" + types[0] + "'))));";
                    }
                    if (types.length == 6) {
                        uniqueID_query = "select * from public.items where  catalog='Default' and name = '" + names[5] + "' and type='" + types[5] + "' and asg_scopeid IN (select id from public.items where name ='" + names[4] + "' and type='" + types[4] + "' and asg_scopeid IN (select id from public.items where name ='" + names[3] + "' and type='" + types[3] + "' and asg_scopeid IN (select id from public.items where name ='" + names[2] + "' and type='" + types[2] + "' and asg_scopeid IN (select id from public.items where name ='" + names[1] + "' and type='" + types[1] + "'  and asg_scopeid IN(select id from public.items where name like '%" + names[0] + "%' and type='" + types[0] + "')))));";
                    }
                    JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + jsonFile, jsonPath, dbHelper.returnStringValue(database, uniqueID_query, "id"));
                    break;
                case "OperationID":
                    String query1 = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'";
                    FileUtil.createFileAndWriteData(Constant.REST_DIR + jsonFile, "{}");
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, "OperationID", Integer.parseInt(dbHelper.returnValue(database, query1)));
                    break;
                case "deletedID":
                    String nullID = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'";
                    Assert.assertEquals(dbHelper.returnStringValue(database, nullID, "ID"), null);
                    break;

                case "multipleIDs":
                    String likeQuery = "SELECT  id from public.items where type='" + type + "' and name like '" + name + "'";
                    List<String> valueList = new ArrayList<String>();
                    Map<String, Integer> dbValues = new HashMap<>();
                    List<String> idValues = new ArrayList<>();
                    idValues = dbHelper.returnRowValuesInList(dbHelper.returnQueryMap(database, likeQuery), "id");
                    for (int i = 0; i < idValues.size(); i++) {
                        dbValues.put(jsonPath + i, Integer.valueOf(idValues.get(i)));
                    }
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, jsonPath, dbValues);

                case "NameSpaceID":
                    String nameSpace = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, jsonPath.substring(2), Integer.parseInt(dbHelper.returnValue(database, nameSpace)));
                    break;
                case "AnalysisID":
                    String analysis = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name like ('" + name + "')";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, jsonPath.substring(2), Integer.parseInt(dbHelper.returnValue(database, analysis)));
                    break;
                case "SourceTreeID":
                    String sourcetreequery = "SELECT * from public.items where  catalog='" + catalog + "' and type='" + type + "' and name='" + name + "'";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, jsonPath.substring(2), Integer.parseInt(dbHelper.returnValue(database, sourcetreequery)));
                    break;
                case "ClassinClass":
                    String mainClassID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, "classID");
                    String ChildClass = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and asg_scopeid ='" + mainClassID + "'";
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + jsonFile, jsonPath.substring(2), Integer.parseInt(dbHelper.returnValue(database, ChildClass)));
                    break;
                case "JsonIDUpdate":
                    if (type.contains("File")) {
                        String scopeID = JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, scope);
                        String importID = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and asg_scopeid ='" + scopeID + "'";
                        JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + jsonFile, jsonPath, dbHelper.returnValue(database, importID));
                        CommonUtil.storeText(JsonRead.getJsonValue(Constant.REST_DIR + jsonFile, jsonPath));
                    } else if (type.contains("SourceTree")) {
                        String importID = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and asg_scopeid ='" + CommonUtil.getText() + "'";
                        JsonBuildUpdateUtil.updateArrayValue(Constant.REST_DIR + jsonFile, jsonPath, "Default.SourceTree:::" + Integer.parseInt(dbHelper.returnValue(database, importID)));
                    } else {
                        String importID = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and type='" + type + "'";
                        JsonBuildUpdateUtil.updateArrayValue(Constant.REST_DIR + jsonFile, jsonPath, "Default." + type + ":::" + Integer.parseInt(dbHelper.returnValue(database, importID)));
                    }
                    break;
                case "ORIGINID":
                    String originqueryID = "SELECT originid from public.item_origins where  type='" + type + "' and originds='" + name + "';";
                    JsonBuildUpdateUtil.addListValuesToJSONFile(Constant.REST_DIR + jsonFile, name, dbHelper.returnQueryInList(database, "returnstringlist", originqueryID,"","","originid"));
                    break;
                case "ItemIDFormat":
                    String importID = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and type='" + type + "'";
                    JsonBuildUpdateUtil.updateArrayValue(Constant.REST_DIR + jsonFile, jsonPath, "Default." + type + ":::" + Integer.parseInt(dbHelper.returnValue(database, importID)));
                    break;
                case "ItemIDNodeUpdate":
                    String newID = "Select * from public.items where catalog='" + catalog + "' and name='" + name + "' and type='" + type + "'";
                    JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + jsonFile, jsonPath, "Default." + type + ":::" + Integer.parseInt(dbHelper.returnValue(database, newID)));
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());

        }
    }

    @And("^User performs following actions in the Item view Page$")
    public void userPerformsFollowingActionsInTheItemViewPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                waitUntilAngularReady(driver);
                new SubjectAreaManagerActions(driver).Itemviewpagevalidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                waitUntilAngularReady(driver);
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


    @And("^user clicks on first item in Business Owner list$")
    public void userClicksOnFirstItemInBusinessOwnerList() {
        try {
            clickOn(new SubjectArea(driver).getWidgetBusinessOwnerDetails().get(0));
        } catch (Exception e) {
            takeScreenShot("userClicksOnFirstItemInBusinessOwnerList", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Business Owner List NotFound");
            Assert.fail("userClicksOnFirstItemInBusinessOwnerList" + e.getMessage());
        }


    }

    @And("^User removes Business Owner from list$")
    public void userRemovesBusinessOwnerFromList() {
        try {
            clickOn(driver, new SubjectArea(driver).getBusinesOwnerFirstItem());
            synchronizationofElementTobeClickable(driver, new SubjectArea(driver).getRemoveBusinesOwner());
            moveToElementUsingAction(driver, new SubjectArea(driver).getRemoveBusinesOwner());
            clickOn(new SubjectArea(driver).getRemoveBusinesOwner());
        } catch (Exception e) {
            takeScreenShot("userRemovesBusinessOwnerFromList is not performed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Business Owner is not removed from list");
            Assert.fail("userRemovesBusinessOwnerFromList is not performed" + e.getMessage());
        }
    }

    @Given("^user connects \"([^\"]*)\" and run query using \"([^\"]*)\" with \"([^\"]*)\" and \"([^\"]*)\" and store the item id results in \"([^\"]*)\"$")
    public void user_connects_and_run_query_using_with_and_and_store_the_item_id_results_in(String database, String catalog, String name, String type, String targetFile) throws Throwable {
        try {
            if (targetFile.contains("Constant.REST_DIR")) {
                targetFile = targetFile.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
            }
            String query = "SELECT ID from public.items where name='" + name + "' and type='" + type + "'";
            JsonBuildUpdateUtil.addJsonObjectToJSONFile(targetFile, name, dbHelper.returnValue(database, query));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Given("^user copy the id from \"([^\"]*)\" to \"([^\"]*)\" with \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_copy_the_id_from_to_with_using(String sourceFile, String payLoadFile, String type, String jsonPath) throws Throwable {
        try {
            if (sourceFile.contains("Constant.REST_DIR") || payLoadFile.contains("Constant.REST_DIR")) {
                sourceFile = sourceFile.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                payLoadFile = payLoadFile.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
            }
            int id = Integer.valueOf(JsonRead.getJsonValue(sourceFile, jsonPath).replace("[", "").replace("]", "").replace("\"", ""));
            String payLoad = "Default." + type + ":::" + id;
            JsonBuildUpdateUtil.addJsonArrayValueToFile(payLoadFile, 0, payLoad);
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(sourceFile + " values not copied " + payLoadFile);
        }
    }

    @Given("^user hits \"([^\"]*)\" with \"([^\"]*)\" \"([^\"]*)\" for id from \"([^\"]*)\" \"([^\"]*)\" using \"([^\"]*)\" and verify \"([^\"]*)\" and store response of \"([^\"]*)\" in \"([^\"]*)\" for \"([^\"]*)\"$")
    public void user_hits_with_for_id_from_using_and_verify_and_store_response_of_in_for(String request, String url, String body, String file, String type, String path, String statusCode, String jsonPath, String targetFile, String name) throws Throwable {
        RestAPIWrapper restAPIWrapper = new RestAPIWrapper();
        try {
            switch (request) {
                case "Post":
                    if (file.contains("Constant.REST_DIR") || body.contains("Constant.REST_DIR") || targetFile.contains("Constant.REST_DIR")) {
                        file = file.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                        body = body.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                        targetFile = targetFile.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            restAPIWrapper.initializeRestAPI("IDC");
                            restAPIWrapper.setBodyFile(body);
                            restAPIWrapper.setAcceptFormat(propLoader.prop.getProperty("TestSystemUser"), "application/json");
                            restAPIWrapper.setContentType("application/json");
                            restAPIWrapper.invokePostRequest(url);
                            restAPIWrapper.returnRestResponse();
                            JsonBuildUpdateUtil.addJsonObjectToJSONFile(targetFile, name, restAPIWrapper.getJsonResponseValuesInList(jsonPath));
                        }
                    }

            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Values not retrieved");
        }
    }

    @Given("^user gets the name for each id stored in \"([^\"]*)\" under \"([^\"]*)\" and replace the id with name$")
    public void user_gets_the_name_for_each_id_stored_in_under_and_replace_the_id_with_name(String filePath, String tableName) throws Throwable {
        try {
            if (filePath.contains("Constant.REST_DIR")) {
                filePath = filePath.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
            }
            JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".*");
            List<String> ls = new ArrayList<>();
            ls = JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".*");
            for (int i = 0; i < ls.size(); i++) {

                String sourceJsonPath = JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".[" + i + "].source").get(0);
                String targetJsonPath = JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".[" + i + "].target").get(0);
                String sourceQuery = "select name from public.items where id=" + sourceJsonPath.substring(sourceJsonPath.lastIndexOf(":") + 1) + "";
                String targetQuery = "select name from public.items where id=" + targetJsonPath.substring(targetJsonPath.lastIndexOf(":") + 1) + "";
                String sourceName = dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery, "name");
                String targetName = dbHelper.returnStringValue("APPDBPOSTGRES", targetQuery, "name");
                if (sourceJsonPath.contains(":::")) {
                    JsonBuildUpdateUtil.updateJsonNode(filePath, "$.." + tableName + ".[" + i + "].source", sourceName);
                }
                if (targetJsonPath.contains(":::")) {
                    JsonBuildUpdateUtil.updateJsonNode(filePath, "$.." + tableName + ".[" + i + "].target", targetName);
                }


            }


        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Names are not retrieved for IDs");
        }
    }

    @And("^user verifies rating facet in item view$")
    public void userVerifiesRatingFacetInItemView() {
        try {
            Assert.assertTrue(new SubjectArea(driver).getRatingfacetitemview().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating Widget Found ");
        } catch (Exception e) {
            takeScreenShot("Rating Widget is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Rating Section is not displayed " + e.toString());
            Assert.fail("Rating Widget Not Found" + e.getMessage());
        }
    }


    @And("^user gives \"([^\"]*)\" rating in item view page$")
    public void userGivesRatingInItemViewPage(String arg0) throws Throwable {
        try {
            sleepForSec(1000);
            int rating = Integer.parseInt(arg0) * 2;
            clickOn(new SubjectArea(driver).rateDynamicallyItemviewpage(Integer.toString(rating)));
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg0 + " facet is not present");
            takeScreenShot("MLP_19181_Verification of Rating Business Application", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_19181_Verification of Rating Business Application failed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @And("^user verifies first item \"([^\"]*)\"in item list page$")
    public void userVerifiesFirstItemInItemListPage(String arg0) throws Throwable {
        try {

            String firitemtxt = getElementText(new SubjectArea(driver).getfirstItemName(arg0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "data available");
            Assert.assertEquals(arg0, firitemtxt.trim());
        } catch (Exception e) {
            takeScreenShot("MLP_19181_Verification of Rating Business Application failed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @And("^user clears and enters the text\"([^\"]*)\" in search text area$")
    public void userClearsAndEntersTheTextInSearchTextArea(String arg0) throws Throwable {
        try {
            clickOn(new SubjectArea(driver).retrunsearchBox());
            textClear(new SubjectArea(driver).retrunsearchBox());
            enterText(new SubjectArea(driver).retrunsearchBox(), arg0);
        } catch (Exception e) {
            takeScreenShot("MLP_19181_Verification of Rating Business Application failed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies average rating <numbr> in business application$")
    public void userVerifiesAverageRatingNumbrInBusinessApplication(int numbr) {
        try {
            int rating = numbr;
            waitForAngularLoad(driver);
            switch (numbr) {
                case 1:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getonearavgRatingitemview()));
                    break;
                case 2:
                    verifyTrue(isElementSelected(new SubjectArea(driver).ratingTwoCheckbox()));
                    break;
                case 3:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getthreetaravgRatingitemview()));
                    break;
                case 4:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getfouraravgRatingitemview()));
                    break;
                case 5:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getfivearavgRatingitemview()));
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("MLP_19181_Verification of Rating Business Application failed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies average rating \"([^\"]*)\" in business application$")
    public void userVerifiesAverageRatingInBusinessApplication(String arg0) throws Throwable {
        try {
            int avgrating = Integer.parseInt(arg0) * 1;
            waitForAngularLoad(driver);
            switch (avgrating) {
                case 1:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getonearavgRatingitemview()));
                    break;
                case 2:
                    verifyTrue(isElementSelected(new SubjectArea(driver).gettwotaravgRatingitemview()));
                    break;
                case 3:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getthreetaravgRatingitemview()));
                    break;
                case 4:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getfouraravgRatingitemview()));
                    break;
                case 5:
                    verifyTrue(isElementSelected(new SubjectArea(driver).getfivearavgRatingitemview()));
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("MLP_19181_Verification of Rating Business Application failed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


//10.3 New UI Implementations

    @Then("^user verifies imported items are matching with xml \"([^\"]*)\"$")
    public void user_verifies_imported_items_are_matching_with_xml(String xmlPath) throws Throwable {
        List<String> listofitemNames = new ArrayList<>();
        try {
            String localXmlPath = Constant.REST_PAYLOAD + xmlPath;
            List<String> listofXmlNames = XMLReaderUtil.readAnAttributeFromFile(localXmlPath, "ITEM", "itemName");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " XML Results: " + listofXmlNames);

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "API Results: " + CommonUtil.getTemporaryList());
            Assert.assertEquals(CommonUtil.getTemporaryList().size(), listofXmlNames.size());
            for (String name : listofXmlNames) {
                Assert.assertTrue(CommonUtil.getTemporaryList().contains(name));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item names are matching");

        } catch (Exception e) {
            takeScreenShot("Item names are not matching", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^User performs following actions in the Excel Importer Page$")
    public void userPerformsFollowingActionsInTheExcelImporterPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new SubjectAreaManagerActions(driver).ExcelImporterPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"),values.get("Attribute"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Excel Importer Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Excel Importer Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Excel Importer Page is not performed ");
            Assert.fail("action in Excel Importer Page is not performed" + e.getMessage());
        }
    }

    @And("^User Compare Imported Excel Items with UI Items$")
    public void userCompareImportedExcelItemsWithUIItems(DataTable dataTable) {
        try {
            for (Map<String, String> Values : dataTable.asMaps(String.class, String.class)) {
                new SubjectAreaManagerActions(driver).ExcelUIComparison(Values.get("FileName"), Values.get("WithColumnName"), Values.get("SheetNumber"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Excel Importer Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Excel Importer Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Excel Importer Page is not performed ");
            Assert.fail("action in Excel Importer Page is not performed" + e.getMessage());
        }
    }


    @Given("^user performs \"([^\"]*)\" in Item Results page for \"([^\"]*)\"$")
    public void user_performs_in_Item_Results_page_for(String actionType, String element) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).genericActions(actionType, element);
        } catch (Exception e) {
            e.printStackTrace();
            takeScreenShot(this.getClass().getName(), driver);
        }
    }

    @When("^user enters name as \"([^\"]*)\" and password as \"([^\"]*)\" for created Test User Login$")
    public void userEntersNameAsAndPasswordAsForCreatedTestUserLogin(String arg0, String arg1) throws Throwable {
        try {
            new DashBoardPage(driver).Click_profileLogoutButton();
            new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty(arg0), propLoader.prop.getProperty(arg1));
        } catch (Exception e) {
            takeScreenShot("action in Login page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @And("^user enters name as \"([^\"]*)\" and password as\"([^\"]*)\" for test User Login$")
    public void userEntersNameAsAndPasswordAsForTestUserLogin(String arg0, String arg1) throws Throwable {
        try {
            new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty(arg0), propLoader.prop.getProperty(arg1));
        } catch (Exception e) {
            takeScreenShot("action in Login page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @And("^verify save button is not enabled under manage access$")
    public void verifySaveButtonIsNotEnabledUnderManageAccess() {
        try {
            Assert.assertFalse(isElementEnabled(new AnalysisPage(driver).getCreateTestUserSave()));
        } catch (Exception e) {
            takeScreenShot("Save Button is Enabled", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @Then("^user verifies the \"([^\"]*)\" in the \"([^\"]*)\"")
    public void user_verifies_the_color_code_for_any_displayed_node(String actionType, String pageName, DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new SubjectAreaManagerActions(driver).validateElementInSearchResultPage(actionType, values.get("StyleType"), values.get("ColorNameCode"), values.get("item"));
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

    @When("^user \"([^\"]*)\" on \"(.*)\" button in \"([^\"]*)\" page$")
    public void user_on_WelcomePage(String actionType, String buttonName, String PageName) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new SubjectAreaManagerActions(driver).genericActions(actionType, buttonName);
            waitForAngularLoad(driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot(buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " is not clicked");
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
        }
    }

    @When("^user verifies \"([^\"]*)\" is \"([^\"]*)\" in \"([^\"]*)\" page$")
    public void user_verifies_is_in(String buttonName, String actionType, String PageName) throws Throwable {
        try {
            sleepForSec(1000);
            new SubjectAreaManagerActions(driver).genericActions(actionType, buttonName);
            sleepForSec(500);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " is clicked");
        } catch (Exception e) {
            takeScreenShot(buttonName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " is not clicked");
            Assert.fail(buttonName + " is not clicked" + e.getMessage());
        }
    }

    @Given("^user retrieves all lineage hops values for below parameters$")
    public void user_retrieves_all_lineage_hops_values_for_below_parameters(DataTable arg1) throws Throwable {
        List<Map<String, String>> ls = arg1.asMaps(String.class, String.class);
        Map<String, Integer> idMap = new HashMap<>();
        Map<String, Integer> functionMap = new HashMap<>();
        Map<Integer, String> classLineageHops = new HashMap<>();
        Map<Integer, String> tableLineageHops = new HashMap<>();
        FileWriter fileWriter = null;
        String filePath = null;
        org.json.simple.JSONObject js = new org.json.simple.JSONObject();
        String database = null;
        String type = null;
        String lineageFlow = null;
        List<Long> funcIDS = null;
        try {
            for (int i = 0; i < ls.size(); i++) {
                lineageFlow = ls.get(i).get("lineageFlow");
            }
            switch (lineageFlow) {
                case "functions-->hops":
                    for (int i = 0; i < ls.size(); i++) {
                        type = ls.get(i).get("type");
                        database = ls.get(i).get("database");
                        String getClassID = "SELECT id from public.items where   name='" + ls.get(i).get("name") + "'and type='" + type + "'";
                        idMap.put(ls.get(i).get("name"), Integer.parseInt(dbHelper.returnStringValue(database, getClassID, "id")));
                        filePath = ls.get(i).get("targetFile");
                        //get all function ids for class id stored above
                        String getFunctions = "Select * from public.items where  type='Function'and asg_scopeid=" + idMap.get(ls.get(i).get("name")) + "";
                        functionMap.putAll(dbHelper.returnDBRowValuesInMap(dbHelper.returnQueryMap(database, getFunctions), "name", "id"));

                    }
                    //store function id's in a list
                    funcIDS = new ArrayList<>();
                    for (Map.Entry<String, Integer> mp : functionMap.entrySet()) {
                        funcIDS.add(Long.valueOf(mp.getValue()));
                    }
                    //retrieve the lineage hops id for the function list
                    for (Long linScopeID : funcIDS) {
                        String lineageHops2 = "Select id,name from public.items where  type='LineageHop' and asg_scopeid='" + linScopeID + "'";
                        LoggerUtil.logInfo("Retrieving lineage hops for " + linScopeID + ".............");
                        if (dbHelper.returnQueryMap(database, lineageHops2) == null) {
                            LoggerUtil.logInfo("No values for function id " + linScopeID);
                        }
                        classLineageHops.putAll(dbHelper.returnDBRowValuesInMap1(dbHelper.returnQueryMap(database, lineageHops2), "id", "name"));
                    }
                    //write the map to object and in file
                    js.put("classIDs", idMap);
                    js.put("functionIDs", functionMap);
                    js.put("LineageHops", classLineageHops);
                    break;
                case "Table-->hops":
                    for (int i = 0; i < ls.size(); i++) {
                        type = ls.get(i).get("type");
                        database = ls.get(i).get("database");
                        String getTableID = "SELECT id from public.items where   name='" + ls.get(i).get("name") + "'and type='" + type + "'";
                        idMap.put(ls.get(i).get("name"), Integer.parseInt(dbHelper.returnStringValue(database, getTableID, "id")));
                        filePath = ls.get(i).get("targetFile");
                        //get all function ids for class id stored above
                        String getLineage = "Select id,name from public.items where  type='LineageHop'and asg_scopeid=" + idMap.get(ls.get(i).get("name")) + "";
                        tableLineageHops.putAll(dbHelper.returnDBRowValuesInMap1(dbHelper.returnQueryMap(database, getLineage), "id", "name"));
                    }

                    Map<String, String> lineagePayload = new HashMap<>();

                    for (Map.Entry<String, Integer> ids : idMap.entrySet()) {
                        if (type.equals("Routine")) {
                            lineagePayload.put(ids.getKey(), "[\"Default.Routine:::" + ids.getValue() + "\"]");
                        } else if (type.equals("Operation")) {
                            lineagePayload.put(ids.getKey(), "[\"Default.Operation:::" + ids.getValue() + "\"]");
                        } else {
                            lineagePayload.put(ids.getKey(), "[\"Default.Table:::" + ids.getValue() + "\"]");
                        }
                    }

                    //write the map to object and in file
                    js.put("lineagePayLoads", lineagePayload);
                    js.put("tableIDs", idMap);
                    js.put("LineageHops", tableLineageHops);
                    break;
            }

            fileWriter = new FileWriter(Constant.REST_DIR + filePath);
            fileWriter.write(js.toJSONString());
            fileWriter.flush();
            fileWriter.close();
        } catch (
                Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" Tag not present$")
    public void userVerifiesTagNotPresent(String arg0) throws Throwable {
        try {
            Assert.assertFalse((new SubjectArea(driver).getChildTag(arg0)));
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());


        }
    }


    @And("^user verifies the background color of the BA Header \"([^\"]*)\"$")
    public void userVerifiesTheBackgroundColorOfTheBAHeader(String arg0) throws Throwable {
        try {
            String actualBackgroundColor = new SubjectArea(driver).getBackgroundColorBA().getCssValue("background-color");
            String hexColor = Color.fromString(actualBackgroundColor).asHex().trim();
            Assert.assertEquals(hexColor.trim(), arg0.trim());
        } catch (Exception e) {
            takeScreenShot("Background color gets mismatched", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Background color gets mismatched" + e.getMessage());


        }
    }

    @And("^User Verifies Trust Score for BA Item$")
    public void userVerifiesTrustScoreForBAItem() {
        try {
            waitForAngularLoad(driver);
            String TrueScore = getElementText(new SubjectArea(driver).getTrustScore()).trim();
            String GovrernaceTrustScore = getElementText(new SubjectArea(driver).getGovernaceChartLegendTrustScore()).replace("%", "");
            String TechnicalTrustScore = getElementText(new SubjectArea(driver).getTechnicalChartLegendTrustScore()).replace("%", "");
            String IntelligenceTrustScore = getElementText(new SubjectArea(driver).getIntelligenceChartLegendTrustScore()).replace("%", "");
            float TrustScore = Float.parseFloat(TrueScore);
            float Governancescore = Float.parseFloat(GovrernaceTrustScore);
            float Technicalscore = Float.parseFloat(TechnicalTrustScore);
            float Intelligencescore = Float.parseFloat(IntelligenceTrustScore);
            float totalscore = Governancescore + Technicalscore + Intelligencescore;
            int trustscr = StrictMath.round(TrustScore);
            int Trust_Score = StrictMath.round(totalscore);
            Assert.assertEquals(trustscr, Trust_Score);
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

    @And("^user verifies alignment of Rating After TrustScore Expand$")
    public void userVerifiesAlignmentOfRatingAfterTrustScoreExpand() {
        try {
            Point location = new SubjectArea(driver).getRatingfacetitemview().getLocation();
            int x = location.getX();
            clickOn(new SubjectArea(driver).getTrustScoreDown());
            waitForAngularLoad(driver);
            Point location1 = new SubjectArea(driver).getRatingfacetitemview().getLocation();
            int y = location1.getY();
            Assert.assertNotEquals((long) x, (long) y);

        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" Tag present under \"([^\"]*)\" Tag$")
    public void userVerifiesTagPresentUnderTag(String arg0, String arg1) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).getParentAndChildTag(arg1, arg0)));
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());


        }
    }

    @And("^user rename \"([^\"]*)\" BA Item in Itemview page and click \"([^\"]*)\" Button$")
    public void userRenameBAItemInItemviewPageAndClickButton(String arg0, String arg1) throws Throwable {
        try {
            moveToElement(driver, new SubjectArea(driver).getItemAction());
            clickOn(new SubjectArea(driver).getItemAction());
            moveToElement(driver, new SubjectArea(driver).getBARename());
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getBARename());
            clickOn(new SubjectArea(driver).getBAItemText());
            textClear(new SubjectArea(driver).getBAItemText());
            enterText(new SubjectArea(driver).getBAItemText(), arg0);
            if (arg1.equalsIgnoreCase("Save")) {
                waitForAngularLoad(driver);
                clickOn(new SubjectArea(driver).getBAItemRenameSave());
            } else if (arg1.equalsIgnoreCase("Cancel")) {
                waitForAngularLoad(driver);
                clickOn(new SubjectArea(driver).getBAItemRenameCancel());
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in item View page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());


        }
    }

    @And("^user validates the change in width percentage after removing \"([^\"]*)\" parameter under \"([^\"]*)\" section in \"([^\"]*)\" tab$")
    public void userValidatesTheChangeInWidthPercentageAfterRemovingParameterUnderSectionInTab(String fieldName, String header, String eleName) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).validateProgressBarWidthPercentage(fieldName, header, eleName);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Validation on change in width percentage failed");
            Assert.fail("Validation on change in width percentage failed" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" BA Item \"([^\"]*)\" in Item View Page$")
    public void userBAItemInItemViewPage(String arg0, String arg1) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new SubjectArea(driver).getItemAction().isDisplayed();
            moveToElement(driver, new SubjectArea(driver).getItemAction());
            clickOn(new SubjectArea(driver).getItemAction());
            moveToElement(driver, new SubjectArea(driver).getBADelete());
            clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getBADelete());
        } catch (Exception e) {
            takeScreenShot("BA Item not Deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "BA Item not Deleted ");
            Assert.fail("BA Item not Deleted" + e.getMessage());

        }
    }


    @Then("^user navigates to the index \"([^\"]*)\" to perform actions$")
    public void user_navigates_to_the_index_to_perform_actions(int index) throws Throwable {
        {
            try {
//                switchToWindowIndex(driver, index);
                List<WebElement> breadcrumpsList = new LinkedList<>();
                breadcrumpsList.addAll(new SubjectArea(driver).getBreadCrumbLinkList());
                Collections.reverse(breadcrumpsList);
                breadcrumpsList.get(index).click();
                waitForAngularLoad(driver);

            } catch (Exception e) {
                takeScreenShot("Window switch didn't work", driver);
                LoggerUtil.logLoader_error(this.getClass().getName(), e.getMessage());
                Assert.fail(e.getMessage());
            }
        }
    }

    @Then("^user navigates to the index \"([^\"]*)\" using TopBreadCrumblist to perform actions$")
    public void user_navigates_to_the_index_using_TopBreadCrumblist_to_perform_actions(int index) throws Throwable {
        {
            try {
                List<WebElement> breadcrumpsList = new LinkedList<>();
                breadcrumpsList.addAll(new SubjectArea(driver).getTopBreadCrumbLinkList());
                Collections.reverse(breadcrumpsList);
                breadcrumpsList.get(index).click();
                waitForAngularLoad(driver);

            } catch (Exception e) {
                takeScreenShot("Unable to Navigate to index "+index, driver);
                LoggerUtil.logLoader_error(this.getClass().getName(), e.getMessage());
                Assert.fail(e.getMessage());
            }
        }
    }


    @And("^user create and Edit Trust Policy Rules$")
    public void userCreateAndEditTrustPolicyRules(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new SubjectAreaManagerActions(driver).ValidateTrustPolicyRules(values.get("actionType"), values.get("ItemName"), values.get("actionItem"), values.get("section"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TrustPolicy Validated");
            takeScreenShot("TrustPolicy Validated", driver);
        } catch (Exception e) {
            takeScreenShot("TrustPolicy is not Validated", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("TrustPolicy is not Validated" + e.getMessage());

        }
    }

    @And("^user clicks \"([^\"]*)\" Trust Policy Rules in Administration page$")
    public void userClicksTrustPolicyRulesInAdministrationPage(String arg0) throws Throwable {
        try {
            waitForAngularLoad(driver);
            clickOn(new SubjectAreaManagerActions(driver).getBusinessApplicationPolicyRules(arg0));
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on BusinessApplication Rules");
            takeScreenShot("Clicked on BusinessApplication Rules", driver);
        } catch (Exception e) {
            takeScreenShot("BusinessApplication Rules is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("BusinessApplication Rules is not clicked" + e.getMessage());
        }
    }

    @Given("^user connects to data base and get count of below fields and compare with platform analysis count$")
    public void user_connects_to_data_base_and_get_count_of_below_fields_and_compare_with_platform_analysis_count(DataTable arg1) throws Throwable {
        String count = null;
        try {
            for (Map<String, String> dataList : arg1.asMaps(String.class, String.class)) {
                String dataBaseName = dataList.get("dataBaseName");
                String dataBaseType = dataList.get("dataBaseType");
                String jsonPath = dataList.get("queryPath");
                String queryPage = dataList.get("queryPage");
                String queryField = dataList.get("queryField");
                String queryOperation = dataList.get("queryOperation");
                String columnName = dataList.get("columnName");
                String facet = dataList.get("facet");
                String facetValue = dataList.get("facetValue");
                String query = new JsonRead().readJSonFromQuery(Constant.TEST_DATA_PATH + jsonPath, queryPage, queryField);
                count = dataList.get("count");
                if (!count.equals("fromSource")) {
                    new SubjectAreaManagerActions(driver).verifyFacetTypeAndCounts(facetValue, String.valueOf(count), facet);
                } else {
                    if (queryOperation.equals("returnValue")) {
                        count = dbHelper.returnValue(dataBaseName, query);
                        new SubjectAreaManagerActions(driver).verifyFacetTypeAndCounts(facetValue, String.valueOf(count), facet);
                    }
                }


            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(" Values between source and platform analysis is incorrect");
        }
    }

    @And("^User Clicks TrustScore Expand in Item View page$")
    public void userClicksTrustScoreExpandInItemViewPage() {
        try {
            waitForAngularLoad(driver);
            clickOn(new SubjectAreaManagerActions(driver).getTrustScoreExpand());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on Add new Rules");
            takeScreenShot("Clicked on Add new  Rules", driver);
        } catch (Exception e) {
            takeScreenShot("Add new  Rules is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Add new  Rules is not clicked" + e.getMessage());
        }
    }

    @And("^user copy metadata value from Item View Page and write to file$")
    public void userCopyMetadataValueFromItemViewPageAndWriteToFile(DataTable data) throws Throwable {
        try {
            new SubjectAreaManagerActions(driver).writeMetaDataToFile(data.asMap(String.class, String.class));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content copied to file");
        } catch (Exception e) {
            takeScreenShot("Content not written to file", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content not written to file");
            Assert.fail("Content not written to file");
        }
    }

    @Given("^user \"([^\"]*)\" the json file value from \"([^\"]*)\" and Compare With UI Values$")
    public void userTheJsonFileValueFromAndCompareWithUIValues(String actionType, String fileName,DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new SubjectAreaManagerActions(driver).getValueFromJsonFile(actionType, fileName,values.get("Action"), values.get("jsonObject"),values.get("AttributeName"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content get from file");
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
            Assert.fail(" values not Available in json file");
        }
    }

    @Then("^user should be able to see the \"([^\"]*)\" Date and time of the \"([^\"]*)\" excel import$")
    public void user_should_be_able_to_see_the_Date_and_time_of_the_excel_import(String condition, String ImportName) {
        try {
            switch (condition) {
                case "Created":
                    String text = getElementText(new SubjectArea(driver).returnTimeStampOfExcelImport(ImportName));
                    verifyTrue(checkDateTimeFormat(text,"MMM dd, yyyy, HH:mm:ss a"));
                    Assert.assertEquals(commonUtil.getCurrentDate("MMM dd, yyyy"), commonUtil.dataFormater(text,"MMM dd, yyyy, HH:mm:ss a", "MMM dd, yyyy"));
                    CommonUtil.storeText(text);
                    break;
                case "Modified":
                    String text1= getElementText(new SubjectArea(driver).returnTimeStampOfExcelImport(ImportName));
                    verifyTrue(checkDateTimeFormat(text1,"MMM dd, yyyy, HH:mm:ss a"));
                    Assert.assertFalse(Objects.equals(text1, CommonUtil.getText()));
            }
        } catch (Exception e) {
            takeScreenShot("MLP_23718_Verification of Excel Import with time stamp", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No change in Created and Modified Date & Time");
            Assert.fail(e.getMessage());
        }

    }

    @And("^user \"([^\"]*)\" the value of item \"([^\"]*)\" of attribute \"([^\"]*)\" with temporary text$")
    public void userTheValueOfItemOfAttributeWithTemporaryText(String arg0, String arg1, String arg2) throws Throwable {
        try {
            //List<String> dataPassed = data.asList(String.class);
            new SubjectAreaManagerActions(driver).storeMetadataValueAction(arg0,arg1,arg2);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties displayed in item page");
        } catch (Exception e) {
            Assert.fail("Metadata properties not correct in item page");
            takeScreenShot("Metadata properties not correct in item page", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata properties not displayed in item page");
            Assert.fail("Metadata properties not correct in item page");
        } finally {
            {
                CommonUtil.gettempSingleKeyMultipleValueList().clear();
            }
        }
    }

    @Then("^user compare list of Search results present in Search page and List present in CloudEra API$")
    public void user_compare_list_of_cloudera_present_in_Search_page_and_List_present_in_CloudEra_API(DataTable data) throws Throwable {
        String restAPIEP = null;
        String feature, jsonPath;
        List<String> actualItemTypeList = new ArrayList<>();
        RestAPIWrapper restAPI = new RestAPIWrapper();
        RESTAPIDefinition restAPIDef = new RESTAPIDefinition();
        try {

            for (Map<String, String> value : data.asMaps(String.class, String.class)) {
                restAPIEP = value.get("RESTAPI Endpoint");
                feature = value.get("Feature");
                jsonPath = value.get("jsonPath");
                restAPI.initializeRestAPI(feature);
                restAPI.invokeGetRequest(restAPIEP);
                Assert.assertEquals(restAPI.returnStatusCode(), 200);
                List<String> jsonList = restAPI.getJsonResponseValuesInList(jsonPath);
                CommonUtil.storeTemporaryList(jsonList);

            }
            List<String> actualList = new ArrayList<String>();
            user_get_the_count_of_the_search_list();

            for (String itemNames : CucumberDataSet.searchList()) {
                if (itemNames.contains("_") || (restAPIEP.contains("sqoop") || restAPIEP.contains("pig") || restAPIEP.contains("mapreduce") || restAPIEP.contains("spark") || restAPIEP.contains("yarn") || restAPIEP.contains("impala"))) {
                    if (itemNames.contains("_")) {

                        actualList.add(itemNames.substring(0, itemNames.lastIndexOf("_")));
                    } else {
                        actualList.add(itemNames);
                    }
                } else {
                    actualList.add(itemNames);
                }

            }
            Collections.sort(CommonUtil.getTemporaryList());
            Collections.sort(actualList);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "UI names" + actualList);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "API names" + commonUtil.getTemporaryList());
            Assert.assertTrue(commonUtil.compareLists(CommonUtil.getTemporaryList(), actualList));
            Assert.assertEquals(actualList.size(), CommonUtil.getTemporaryList().size());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while getting item count and item names" + e.toString());
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Error while getting item count and item names" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" the \"([^\"]*)\" Item search result \"([^\"]*)\" value with CloudEra API$")
    public void userTheItemSearchResultValueWithCloudEraAPI(String actionType, String elementType, String valueName, DataTable data) throws Throwable {
        String restAPIEP, feature, jsonPath;
        List<String> actualItemTypeList = new ArrayList<>();
        RestAPIWrapper restAPI = new RestAPIWrapper();
        RESTAPIDefinition restAPIDef = new RESTAPIDefinition();
        String[] tempItem = new String[10];
        restAPIEP = null;

        try {

            for (Map<String, String> value : data.asMaps(String.class, String.class)) {
                restAPIEP = value.get("RESTAPI Endpoint");
                feature = value.get("Feature");
                jsonPath = value.get("jsonPath");
                restAPI.initializeRestAPI(feature);
                restAPI.invokeGetRequest(restAPIEP);
                Assert.assertEquals(restAPI.returnStatusCode(), 200);
                List<String> jsonList = restAPI.getJsonResponseValuesInList(jsonPath);
                commonUtil.storeTemporaryList(jsonList);

            }
            List<String> itemNames = new ArrayList<String>();
//            sleepForSec(5000);
//            itemNames = new SubjectArea(driver).getUIItemList();
            itemNames = new SubjectArea(driver).getItemNamesInUI(valueName, elementType);
            for (String dbItem : itemNames) {
                if (dbItem.contains("_") && (restAPIEP.contains("sqoop") || restAPIEP.contains("pig") || restAPIEP.contains("impala"))) {
                    int i = dbItem.lastIndexOf("_");
                    actualItemTypeList.add(dbItem.substring(0, i));
                } else {
                    actualItemTypeList.add(dbItem);
                }

            }

            if (actionType.equalsIgnoreCase("verifies")) {

                Assert.assertTrue(commonUtil.compareLists(commonUtil.getTemporaryList(), itemNames));
            } else {
                for (String itemName : actualItemTypeList) {
                    Assert.assertTrue(commonUtil.getTemporaryList().contains(itemName));
                }
            }


        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while getting item count and item names" + e.toString());
            Assert.fail("Error while getting item count and item names" + e.getMessage());
        }
    }

    @Then("^user finds search result does not contain \"([^\"]*)\" item name link$")
    public void user_finds_search_result_does_not_contain_item_name_link(String itemName) throws Throwable {
        List<WebElement> itemNamesElements;
        List<String> itemNames = new ArrayList<String>();
        try {
            while (true) {
                sleepForSec(2000);
                for (WebElement item : new SubjectArea(driver).getItemNames()) {
                    itemNames.add(item.getText());

                }
                sleepForSec(2000);
                if (new SubjectArea(driver).getActivepaginationNextButton_Status()) {
                    waitandFindElement(driver, new SubjectArea(driver).getActivepaginationNextButton(), 5, true);
                    clickOn(new SubjectArea(driver).getActivepaginationNextButton());

                } else {
                    break;
                }
            }

            for (int i = 0; i < itemNames.size(); i++)
                Assert.assertFalse(itemNames.get(i).contains(itemName));

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item name " + itemName + "click successful");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies List present in CloudEra API list contains Search results present in UI$")
    public void userVerifiesListPresentInCloudEraAPIListContainsSearchResultsPresentInUI(DataTable data) throws Throwable {
        String restAPIEP, feature, jsonPath;
        List<String> actualItemTypeList = new ArrayList<>();
        RestAPIWrapper restAPI = new RestAPIWrapper();
        RESTAPIDefinition restAPIDef = new RESTAPIDefinition();
        String[] tempItem = new String[10];
        restAPIEP = null;

        try {

            for (Map<String, String> value : data.asMaps(String.class, String.class)) {
                restAPIEP = value.get("RESTAPI Endpoint");
                feature = value.get("Feature");
                jsonPath = value.get("jsonPath");
                restAPI.initializeRestAPI(feature);
                restAPI.invokeGetRequest(restAPIEP);
                Assert.assertEquals(restAPI.returnStatusCode(), 200);
                List<String> jsonList = restAPI.getJsonResponseValuesInList(jsonPath);
                commonUtil.storeTemporaryList(jsonList);

            }
            List<String> itemNames = new ArrayList<String>();
            sleepForSec(5000);
            user_get_the_count_of_the_search_list();

            for (String dbItem : CucumberDataSet.searchList()) {
                if (dbItem.contains("_") && (restAPIEP.contains("sqoop") || restAPIEP.contains("pig") || restAPIEP.contains("mapreduce") || restAPIEP.contains("spark") || restAPIEP.contains("yarn") || restAPIEP.contains("impala"))) {
                    int i = dbItem.lastIndexOf("_");
                    actualItemTypeList.add(dbItem.substring(0, i));
                } else {
                    actualItemTypeList.add(dbItem);
                }

            }

            Collections.sort(CommonUtil.getTemporaryList());
            Collections.sort(actualItemTypeList);
            Assert.assertTrue(commonUtil.compareLists(CommonUtil.getTemporaryList(), actualItemTypeList));
            Assert.assertEquals(actualItemTypeList.size(), CommonUtil.getTemporaryList().size());

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while getting item count and item names" + e.toString());
            Assert.fail("Error while getting item count and item names" + e.getMessage());
        }
    }

    @And("^compare item names list in UI not starts with \"([^\"]*)\"$")
    public void compareItemNamesListInUINotStartsWith(String elementName) throws Throwable {
        List<String> itemNames = new ArrayList<String>();
        try {
            user_get_the_count_of_the_search_list();
            for (String dbItem : CucumberDataSet.searchList()) {
                Assert.assertFalse(dbItem.startsWith(elementName));
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while getting item count and item names" + e.toString());
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Error while getting item count and item names" + e.getMessage());
        }
    }

    @And("^User validates URL of Demo Data contains \"([^\"]*)\"$")
    public void userValidatesURLOfDemoDataContains(String catalog) throws Throwable {
        try {
            waitForAngularLoad(driver);
            String Url = driver.getCurrentUrl();
            boolean status = Url.contains(catalog);
            Assert.assertTrue(status);
        } catch (Exception e) {
            takeScreenShot("Default Catalog not found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "BA Item not Deleted ");
            Assert.fail("Default Catalog not found" + e.getMessage());
        }
    }

    @And("^User performs following actions in the Facets in Search Results Page$")
    public void userPerformsFollowingActionsInTheFacetsInSearchResultsPage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                new SubjectAreaManagerActions(driver).FacetsActionsInSearchResultsPage(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"),values.get("Attribute"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Manage Notifications Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in Manage Notifications Page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Manage Notifications Page is not performed ");
            Assert.fail("action in Manage Notifications Page is not performed" + e.getMessage());
        }
    }

    @And("^user verifies breadcrumb link \"([^\"]*)\" and click on it$")
    public void userVerifiesBreadcrumbLinkAndClickOnIt(String BreadcrumbLink) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).getBreadcrumbLinkText(BreadcrumbLink)));
            actionClick(driver, new SubjectArea(driver).getBreadcrumbLinkText(BreadcrumbLink));
        } catch (Exception e) {
            takeScreenShot("Breadcrumb list doesnt contain search Text", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Breadcrumb list doesnt contain search Text" + e.getMessage());
        }
    }

    @Given("^user updates the tags to the data items in DD$")
    public void user_updates_the_tags_to_the_data_items_in_DD(DataTable data) throws Exception {
        try {
            for (Map<String, String> value : data.asMaps(String.class, String.class)) {
                String URL = value.get("getTagsPayloadURL");
                String[] stringList = value.get("item hierarchy").split(",");
                List<String> hierarchyList = new ArrayList<>();
                for (String val : stringList) {
                    hierarchyList.add(val);
                }
                String[] tableStringList = value.get("tableName").split(",");
                List<String> tableList= new ArrayList<>();
                for (String val : tableStringList) {
                    tableList.add(val);
                }
                String firstHierarchyItem = value.get("firstItemType");
                String lineage = value.get("LineageFor");
                String filePath2 = value.get("bodyFile2");
                String filePath = value.get("bodyFile1");
                String URL2 = value.get("assignTagsURL");
                String jsonPath1 = value.get("jsonPath1");
                String jsonPath2 = value.get("jsonPath2");
                String jsonValue = value.get("jsonValue");

                new SubjectAreaManagerActions(driver).caeLineage(hierarchyList,tableList, firstHierarchyItem, lineage, filePath, filePath2, URL, URL2, jsonPath1,jsonPath2,jsonValue);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Lineage Generated");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Lineage generation failed");
            Assert.fail("CAE Lineage generation failed");
        }
    }

    @When("^user performs following actions in the Search results page$")
    public void user_on_header(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                waitUntilAngularReady(driver);
                new SubjectAreaManagerActions(driver).genericActions(values.get("actionType"), values.get("actionItem"));
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

    @And("^user perform following actions in Custom Attribute Page$")
    public void userPerformFollowingActionsInCustomAttributePage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                waitForAngularLoad(driver);
                new SubjectAreaManagerActions(driver).dataModalPageValidations(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"), values.get("Actionname"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in Item View Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Custom Attribute page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }
}
