package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.DataSetActions;
import com.asg.automation.pageactions.idc.SubjectAreaManagerActions;
import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.pageobjects.idc.DataSets;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.*;
import com.google.common.base.CharMatcher;
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
import java.util.NoSuchElementException;

import static com.asg.automation.utils.Constant.FEATURES;
import static com.asg.automation.utils.PostgresSqlBuilder.getselectedColumnName;

public class DataSetStepDefinition extends DriverFactory {

    private WebDriver driver;
    private DBPostgresUtil db_postgres_util;
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

    @Then("^Assign Data set button should be visible in search result page$")
    public void assign_Data_set_button_should_be_visible_in_search_result_page() throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getAssignDataSetButton().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Assign Data Set button not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Assign Data Set button not displayed" + e.getMessage());
        }

    }

    @Given("^user clicks on checkbox in the items listed$")
    public void user_clicks_on_checkbox_in_the_items_listed_in_search_result(List<CucumberDataSet> dataTableCollection) {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                if (isElementPresent(new SubjectArea(driver).getpaginationNextButtonWithoutSync())) {
                    trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), data.getItemName(), new SubjectArea(driver).getpaginationNextButton());
                } else {
                    WebElement element = traverseListContainsElementReturnsElement(new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), data.getItemName());
                    waitandFindElement(driver, element, 3, false);
                    clickOn(new DataSets(driver).getItemName(data.getItemName()));
                }
            }
        } catch (Exception e) {
            takeScreenShot("user clicks on the checkboxes mentioned", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());

        }
    }

    @Given("^user click on Assign DataSet button$")
    public void user_click_on_Assign_DataSet_button() throws Throwable {
        try {
            new DataSets(driver).getAssignDataSetButton().click();
            LoggerUtil.logLoader_info(this.getClass().getName(), "Assign data set button is clicked");
        } catch (Exception e) {
            takeScreenShot("Assign Data Set button is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Assign Data Set button is not clickable" + e.getMessage());
        }
    }

    @Given("^user click on Create New DataSet button in Assign Data Set panel$")
    public void user_click_on_Create_New_DataSet_button_in_Assign_Data_Set_panel() throws Throwable {
        try {
            sleepForSec(1000);
            clickOn(new DataSets(driver).getCreateNewDataSet());
            LoggerUtil.logLoader_info(this.getClass().getName(), "Create DataSet button is not clicked");
        } catch (Exception e) {
            takeScreenShot("Assign Data Set button is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Assign Data Set button is not clickable" + e.getMessage());
        }
    }


    @Given("^user enter name field values as \"([^\"]*)\" in New Data set panel$")
    public void user_enter_name_field_values_as_in_New_Data_set_panel(String dataSetName) throws Throwable {
        try {
            enterText(new DataSets(driver).getDataSetName(), dataSetName);
            LoggerUtil.logLoader_info(this.getClass().getName(), "DataSet name is entered");
        } catch (Exception e) {
            takeScreenShot("Data set name is not entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Data set name is not entered" + e.getMessage());
        }
    }

    @Given("^user enter description field values as \"([^\"]*)\" in New Data set panel$")
    public void user_enter_description_field_values_as_in_New_Data_set_panel(String dataSetDescription) throws Throwable {
        try {
            enterText(new DataSets(driver).getDataSetDescription(), dataSetDescription);
            LoggerUtil.logLoader_info(this.getClass().getName(), "DataSet Description entered");
        } catch (Exception e) {
            takeScreenShot("Data set description is not entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Data set description is not entered" + e.getMessage());
        }
    }

    @Given("^user click Submit button in New Data Set panel$")
    public void user_click_Submit_button_in_New_Data_Set_panel() throws Throwable {
        try {
            clickOn(new DataSets(driver).getDataSetSubmit());
            LoggerUtil.logLoader_info(this.getClass().getName(), "Create DataSet submit button is clicked");
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot("Create New Data set submit is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Create DataSet submit button is clicked" + e.getMessage());
        }
    }

    @Given("^user clicks on close button in the Assign Data Set panel$")
    public void user_clicks_on_close_button_in_the_Assign_Data_Set_panel() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getAssignDataSetClose());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Assign Data set is closed");

        } catch (Exception e) {
            takeScreenShot("Assign data set panel is not closed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Assign data set panel is not closed" + e.getMessage());
        }
    }

    @Given("^user click on Assign button in Assign Data Set panel$")
    public void user_click_on_Assign_button_in_Assign_Data_Set_panel() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(2000);
                scrolltoElement(driver, new DataSets(driver).getDataSetAssignButton(), true);
                LoggerUtil.logLoader_info(this.getClass().getName(), "Element not scrolled to Data Set Assign button");
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getDataSetAssignButton());
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set Assign button is clicked");
                sleepForSec(1000);
            } else {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getDataSetAssignButton());
                waitForAngularLoad(driver);
                sleepForSec(3000);
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set Assign button is clicked");
            }

        } catch (Exception e) {
            takeScreenShot("Assign button is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Assign button is not clicked" + e.getMessage());
        }
    }

    @Given("^notification \"([^\"]*)\" should be displayed$")
    public void notification_should_be_displayed(String expectedNotification) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                if (expectedNotification.contains("created")) {
                    sleepForSec(3000);
                    Assert.assertEquals(expectedNotification, new DataSets(driver).getDataSetCreateNotification().trim());
                } else if (expectedNotification.contains("updated")) {
                    Assert.assertEquals(expectedNotification, new DataSets(driver).getDataSetUpdateNotification().trim());
                }
            } else {
                if (expectedNotification.contains("created")) {
                    Assert.assertEquals(expectedNotification, new DataSets(driver).getDataSetCreateNotification());
                } else if (expectedNotification.contains("updated")) {
                    Assert.assertEquals(expectedNotification, new DataSets(driver).getDataSetUpdateNotification());
                }
            }
        } catch (Exception e) {
            takeScreenShot("Data Set Create notification is not generated", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user select \"([^\"]*)\" in Data Set dropdown in Assign data set panel$")
    public void user_select_in_Data_Set_dropdown_in_Assign_data_set_panel(String dataSet) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickOn(new DataSets(driver).getAvailableDataSetDropDown());
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set drop down is clicked");
                sleepForSec(2000);
                clickOn(traverseListContainsElementTextReturnsElement(new DataSets(driver).getDataSetList(), dataSet));
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set from list is selected");

            } else {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getAvailableDataSetDropDown());
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set drop down is clicked");
                clickOn(traverseListContainsElementTextReturnsElement(new DataSets(driver).getDataSetList(), dataSet));
                LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set from list is selected");
            }
        } catch (Exception e) {
            takeScreenShot("Data Set is not selected", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Data Set is not selected" + e.getMessage());
        }
    }

    @Given("^user clicks on Delete button in Data Set page$")
    public void user_clicks_on_Delete_button_in_Data_Set_page() throws Throwable {
        try {
            clickOn(new DataSets(driver).getDataSetDelete());
            LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set Deleted button is clicked");
        } catch (Exception e) {
            takeScreenShot("Data Set delete button is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Data Set Deleted button is not clicked" + e.getMessage());
        }
    }

    @Given("^user enables the following item checkboxes$")
    public void user_enables_the_following_item_checkboxes(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            List<String> itemList = new ArrayList<>();
            sleepForSec(2000);
            for (CucumberDataSet data : dataTableCollection) {
//                if(traverseListContainsElementText(new SubjectArea(driver).getSearchItemList(), data.getItemName())){
//                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Item is present in the List");
//                }
//                else{
//                    new SubjectArea(driver).click_paginationNextButton();
//                }
                new DataSets(driver).clickItemCheckbox(data.getItemName());
                itemList.add(data.getItemName());
                CommonUtil.storeTemporaryList(itemList);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Item check boxes are not selected");
        }
    }

    @Given("^user get the ID for data set \"([^\"]*)\" from below query$")
    public void user_get_the_ID_for_data_set_from_below_query(String dataSetName, DataTable dataTableCollection) throws Throwable {
        try {
            List<String> criteriaValue = new ArrayList<>();
            List<String> resultList = new ArrayList<>();
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            db_postgres_util = new DBPostgresUtil();
            criteriaValue.add(dataSetName);

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

    @Given("^user remove the following data element from dataset$")
    public void user_remove_the_following_data_element_from_dataset(List<CucumberDataSet> dataElements) throws Throwable {
        try {
            for (CucumberDataSet data : dataElements) {
                sleepForSec(2000);
                clickOn(new DataSets(driver).getDataElement(data.getDataElements()));
                sleepForSec(500);
                clickOn(new DashBoardPage(driver).notificationDismissYes());
                sleepForSec(2000);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Data Elements are not removed");
        }
    }

    @Then("^\"([^\"]*)\" alert should be displayed$")
    public void alert_should_be_displayed(String duplicateAlert) throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(new DataSets(driver).getDuplicateDataSetAlert().trim().equalsIgnoreCase(duplicateAlert));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Duplicate data set alert is not displayed");
        }
    }

    @Given("^user remove the data element \"([^\"]*)\" from dataset$")
    public void user_remove_the_data_element_from_dataset(String dataElement) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                clickOn(new DataSets(driver).getDataElement(dataElement));
            } else {
                clickOn(new DataSets(driver).getDataElement(dataElement));
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Data Elements are not removed");
        }
    }

    @Then("^Alert modal should display \"([^\"]*)\"$")
    public void alert_modal_should_display(String unAssignAlert) throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getUnAssignDataElement().trim().equalsIgnoreCase(unAssignAlert));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Un Assign  data Element alert is not displayed");
        }
    }

    @Given("^user clicks on DataSet dashboard$")
    public void user_clicks_on_DataSet_dashboard() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(3000);
                clickOn(new DataSets(driver).getDataSetDashBoard());
            } else {
                sleepForSec(3000);
                clickOn(new DataSets(driver).getDataSetDashBoard());
            }
            sleepForSec(500);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Data Set dashboard is not clicked");
        }
    }

    @Given("^user clicks on \"([^\"]*)\" data set$")
    public void user_clicks_on_data_set(String dataSetName) throws Throwable {
        try {
            clickOn(new DataSets(driver).getDataSet(dataSetName));
            sleepForSec(1000);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Data Set is not clicked");
        }
    }

    @Given("^user navigate to data tab$")
    public void user_navigate_to_data_tab() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getDataTab());
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Data tab is not clicked");
        }
    }

    @Then("^No data should be displayed in data tab$")
    public void no_data_should_be_displayed_in_data_tab() throws Throwable {
        try {
            if (new DataSets(driver).getDataElementsInDataTab().isDisplayed()) {
                Assert.fail("Data Elements not removed from data tab");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("Data Element removed from data set", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data Element not removed from data set");
        } catch (Exception e) {
            takeScreenShot("Data Element removed from data set", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data Element removed from data set");
        }
    }

    @Then("^Assign Data Set Panel should be displayed$")
    public void assign_Data_Set_Panel_should_be_displayed() throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getAssignDataSetTitle().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Data Element removed from data set", driver);
            Assert.fail("Data Element removed from data set");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data Element removed from data set");
        }
    }

    @Then("^Assign Data Set Panel should not be displayed$")
    public void assign_Data_Set_Panel_should_not_be_displayed() throws Throwable {
        try {
            if (new DataSets(driver).getAssignDataSetTitle().isDisplayed()) {
                Assert.fail("Assign Data Set page is not closed");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("Assign data set is closed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Assign data set is closed");
        } catch (Exception e) {
            takeScreenShot("Assign data set is closed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Assign data set is closed");
        }
    }


    @Given("^\"([^\"]*)\" should be displayed when user enters blank space$")
    public void should_be_displayed_when_user_enters_blank_space(String expectedError) throws Throwable {
        try {
            clickOn(new DataSets(driver).getDataSetName());
            keyPressEvent(driver, Keys.SPACE);
            Assert.assertEquals(new DataSets(driver).getRestritedErrorMessage().trim(), expectedError);
            sleepForSec(1000);
            keyPressEvent(driver, Keys.BACK_SPACE);
        } catch (Exception e) {
            Assert.fail(expectedError + " is not displayed");
            takeScreenShot(expectedError + " is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), expectedError + " is not displayed");
        }
    }

    @Then("^\"([^\"]*)\" should be displayed for below values$")
    public void should_be_displayed_for_below_values(String expectedError, List<CucumberDataSet> dataSetName) throws Throwable {
        try {
            for (CucumberDataSet dataSetSpecialChar : dataSetName) {
                clickOn(new DataSets(driver).getDataSetName());
                enterText(new DataSets(driver).getDataSetName(), dataSetSpecialChar.getDataSetName());
                Assert.assertTrue(new DataSets(driver).getRestritedErrorMessage().trim().equalsIgnoreCase(expectedError));
                keyPressEvent(driver, Keys.BACK_SPACE);
            }
        } catch (Exception e) {
            Assert.fail(expectedError + " is not displayed");
            takeScreenShot(expectedError + " is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), expectedError + " is not displayed");
        }
    }

    @Given("^user validate data set full view window is displayed and following sections are available$")
    public void user_validate_data_set_full_view_window_is_displayed_and_following_sections_are_available(List<CucumberDataSet> dataSetSections) throws Throwable {
        try {
            sleepForSec(3000);
            Assert.assertTrue(new DataSets(driver).getDataSetFullViewTab().isDisplayed());
            for (CucumberDataSet dataSetSectionTitle : dataSetSections) {
                switch (dataSetSectionTitle.getDataSetOverViewSections()) {
                    case "DESCRIPTION":
                        Assert.assertTrue(new DataSets(driver).getDataSetTitleDesc().isDisplayed());
                        break;
                    case "METADATA":
                        Assert.assertTrue(new DataSets(driver).getDataSetTitleMetadata().isDisplayed());
                        break;
                    case "TAG":
                        Assert.assertTrue(new DataSets(driver).getDataSetTitleTag().isDisplayed());
                        break;
                    case "RATING":
                        Assert.assertTrue(new DataSets(driver).getDataSetTitleTag().isDisplayed());
                        break;
                }
            }
        } catch (Exception e) {
            Assert.fail("OverView section is not displayed");
            takeScreenShot("", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "OverView section is not displayed");
        }

    }

    @Then("^Deleted dataset \"([^\"]*)\" should not get displayed in data set list$")
    public void deleted_dataset_should_not_get_displayed_in_data_set_list(String dataSetName) throws Throwable {
        try {
            if (new DataSets(driver).getDataSetNameFromListStatus(dataSetName).size() != 0) {
                Assert.fail("Data Set is not Deleted");
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Assign data set is deleted");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("Assign data set is deleted", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Assign data set is deleted");
        } catch (Exception e) {
            takeScreenShot("Assign data set is deleted", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Assign data set is deleted");
        }
    }

    @Then("^data tab table header column name should be in upper case$")
    public void data_tab_table_header_column_name_should_be_in_upper_case() throws Throwable {
        try {
            List<WebElement> headerColumns = new DataSets(driver).getDataTabTableHeaderList();
            for (WebElement header : headerColumns) {
                Assert.assertTrue(CharMatcher.javaUpperCase().or(CharMatcher.whitespace()).matchesAllOf(header.getText().trim()));
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Headers is in uppercase");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Header is not in uppercase");
            takeScreenShot("Headers are not in upper case", driver);
            Assert.fail("Header is not in upper case");

        }
    }

    @Given("^user enters larger description \"([^\"]*)\" in data set description field$")
    public void user_enters_larger_description_in_data_set_description_field(String dataSetDescription) throws Throwable {
        try {
            for (int i = 0; i < 50; i++) {
                enterTextWithoutClear(new DataSets(driver).getDataSetDescription(), dataSetDescription);
            }
        } catch (Exception e) {
            takeScreenShot("Data set description is not entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^following filter sections values and tag filter should be displayed$")
    public void following_filter_sections_values_and_tag_filter_should_be_displayed(List<CucumberDataSet> dataSetFilters) throws Throwable {
        try {
            List<String> actualFilterList = new ArrayList<>();
            List<String> expectedFilterList = new ArrayList<>();
            List<WebElement> filterSections = new DataSets(driver).getDataSetFilterValues();

            for (WebElement filterText : filterSections) {
                actualFilterList.add(filterText.getText());
            }

            for (CucumberDataSet dataSetFilter : dataSetFilters) {
                expectedFilterList.add(dataSetFilter.getDataSetFilters());
            }

            Assert.assertTrue(actualFilterList.equals(expectedFilterList));
            Assert.assertTrue(new DataSets(driver).getTagFilters().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Data set description is not entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" tab$")
    public void user_clicks_on_tab(String dataSetFilterTabName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(2000);
                clickOn(new DataSets(driver).getDataSetFilterTabs(dataSetFilterTabName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dataSetFilterTabName + " is clicked");
            } else {
                sleepForSec(2000);
                clickOn(new DataSets(driver).getDataSetFilterTabs(dataSetFilterTabName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), dataSetFilterTabName + " is clicked");
            }

        } catch (Exception e) {
            takeScreenShot("Data set filter tab" + dataSetFilterTabName + "is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^\"([^\"]*)\" data set should be available in My DataSet tabs$")
    public void data_set_should_be_available_in_My_DataSet_tabs(String dataSetName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge")) {
                sleepForSec(1000);
                Assert.assertTrue(isElementPresent(new DataSets(driver).getDataSet(dataSetName)));
            } else {
                Assert.assertTrue(isElementPresent(new DataSets(driver).getDataSet(dataSetName)));
            }

        } catch (Exception e) {
            takeScreenShot("Data set description is not entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user selects dataset rating as \"([^\"]*)\" in rating section$")
    public void user_selects_dataset_rating_as_in_rating_section(String ratingNumber) throws Throwable {
        try {
            sleepForSec(1000);
            int rating = Integer.parseInt(ratingNumber)*2;
            moveToElementUsingAction(driver, new DataSets(driver).getDataSetRating(Integer.toString(rating)));
            clickOn(new DataSets(driver).getDataSetRating(Integer.toString(rating)));
            sleepForSec(2000);
        } catch (Exception e) {
            takeScreenShot("Rating four is not selected", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^selected rating \"([^\"]*)\" should be updated in database$")
    public void selected_rating_should_be_updated_in_database(String rating, DataTable dataTableCollection) throws Throwable {
        try {
            List<String> criteriaValue = new ArrayList<>();
            List<String> resultList = new ArrayList<>();
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            db_postgres_util = new DBPostgresUtil();
            criteriaValue.add(CommonUtil.getText());
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            Assert.assertTrue(resultList.get(0).equals(rating));

        } catch (
                Exception e) {
            Assert.fail("Rating  not found in db");
            takeScreenShot("Rating ID is not retrieved in DB", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            new DashBoardPage(driver).Click_profileLogoutButton();

        } finally

        {
            db_postgres_util.disConnect();
        }
    }

    @Given("^data set \"([^\"]*)\" should not be displayed in \"([^\"]*)\" tab$")
    public void data_set_should_not_be_displayed_in_tab(String dataSetName, String dataSetFavTab) throws Throwable {
        try {
            clickOn(new DataSets(driver).getDataSetFilterTabs(dataSetFavTab));
            if (new DataSets(driver).getDataSetSales().isDisplayed()) {
                Assert.fail("Data Set is displayed in Favoruites tab");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("Data set is displayed in Favorites tab", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data set is displayed in Favorites tab");
        } catch (Exception e) {
            takeScreenShot("Data set is displayed in Favorites tab", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());

        }
    }

    @Given("^data set \"([^\"]*)\" should  be displayed in \"([^\"]*)\" tab$")
    public void data_set_should_be_displayed_in_tab(String dataSetName, String dataSetFavTab) throws Throwable {
        try {
            sleepForSec(2000);
            clickOn(new DataSets(driver).getDataSetFilterTabs(dataSetFavTab));
            Assert.assertTrue(new DataSets(driver).getDataSet(dataSetName).isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Data set is not displayed in Favorites tab\"", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user enters \"([^\"]*)\" in search text box$")
    public void user_enters_in_search_text_box(String dataSetName) throws Throwable {
        try {
            clickOn(new DataSets(driver).getDataSetFilterSearchButton());
            enterText(new DataSets(driver).getDataSetFilterSearchField(), dataSetName);
        } catch (Exception e) {
            takeScreenShot(dataSetName + " is entered", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clear search dataset textbox$")
    public void user_clear_search_dataset_textbox() throws Throwable {
        try {
            textClear(new DataSets(driver).getDataSetFilterSearchField());
        } catch (Exception e) {
            takeScreenShot("Data Set search text is not cleared", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user click on tag button in \"([^\"]*)\" item$")
    public void user_click_on_tag_button_in_item(String itemName) throws Throwable {
        try {
            sleepForSec(1000);
            clickOn(new DataSets(driver).getItemTaglink(itemName));
            sleepForSec(2000);
        } catch (Exception e) {
            takeScreenShot("Tag button for " + itemName + " is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user assign the following tags to item$")
    public void user_assign_the_following_tags_to_item(List<CucumberDataSet> tagList) throws Throwable {
        try {
            List<String> tagListName = new ArrayList<>();
            for (CucumberDataSet data : tagList) {
                enterText(new SubjectArea(driver).enterTagName(), data.getTagName());
                clickOn(new SubjectArea(driver).selectTagName(data.getTagName()));
                // clickOn(new DataSets(driver).getTagName(data.getTagName()));
                tagListName.add(data.getTagName());
                sleepForSec(1000);
                CommonUtil.storeTemporaryList(tagListName);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Tags are added");
        }
    }

    @Then("^added tag values should be displayed in tag list box$")
    public void added_tag_values_should_be_displayed_in_tag_list_box() throws Throwable {
        try {
            clickOn(new DataSets(driver).getTagDropDown());
            List<String> actualTagList = new ArrayList<>();
            List<WebElement> dataSetTagList = new DataSets(driver).dataSetTagListValues();
            for (WebElement tagName : dataSetTagList) {
                actualTagList.add(tagName.getText());
            }
            Assert.assertTrue(CommonUtil.compareLists(actualTagList, CommonUtil.getTemporaryList()));

        } catch (Exception e) {
            takeScreenShot("Tag values are not listed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user select \"([^\"]*)\" in tag dropdown$")
    public void user_select_in_tag_dropdown(String tagName) throws Throwable {
        try {
            clickOn(traverseListContainsElementReturnsElement(new DataSets(driver).dataSetTagListValues(), tagName));
        } catch (Exception e) {
            takeScreenShot(tagName + "is not selected", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(tagName + " is not selected from tag list");
        }
    }

    @Given("^user clicks on \"([^\"]*)\" item from search results$")
    public void user_clicks_on_item_from_search_results(String itemName) throws Throwable {
        try {
            while (new SubjectArea(driver).returnitemListPagination().size() >= 0) {
                if (traverseListContainsElementText(new SubjectArea(driver).getlistOfItemNameLink(), itemName)) {
                    sleepForSec(1500);
                    clickOn(new DataSets(driver).clickItemFromResults(itemName));
                    LoggerUtil.logLoader_info(this.getClass().getName(), itemName + " is clicked");
                    sleepForSec(1500);
                    break;
                } else {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                    sleepForSec(1000);
                }
            }
        } catch (Exception e) {
            takeScreenShot(itemName + "is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Item " + itemName + " is not clicked");
        }
    }


    @Then("^user verifies search text inside search area$")
    public void user_verifies_search_text_inside_search_area() throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getDatasetSearchText().isDisplayed());
            takeScreenShot("Search Text is displayed", driver);
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Search Text is not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Search text not displayed");
        }
    }

    @When("^user mouse hovers on \"([^\"]*)\" and verifies title$")
    public void user_mouse_hovers_on_and_verifies_title(String datasetName) throws Throwable {
        try {
            sleepForSec(1000);
            new DataSetActions(driver).genericVerifyElementPresent("verify dataset title", datasetName);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dataset Title link not displayed");
            Assert.fail(e.getMessage());
            takeScreenShot("Dataset Title link not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @When("^user verifies \"([^\"]*)\" dataset is not displayed$")
    public void user_verifies_dataset_not_displayed(String datasetName) throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(new DataSets(driver).getDataSetTitleLink(datasetName).isEmpty());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dataset Title link is displayed");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Dataset Title link not displayed");
            Assert.fail(e.getMessage());
            takeScreenShot("Dataset Title link not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user clicks on Data Analysis tab$")
    public void userClicksOnDataAnalysisTab() throws Throwable {
        try {
            if (isElementPresent(new DataSets(driver).getDataAnalysisTab())) {

            } else {
                refresh(driver);
                sleepForSec(1000);
            }
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getDataAnalysisTab());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataAnalysis tab is clicked");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("DataAnalysis tab is not clicked");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "DataAnalysis tab is clicked");
        }
    }


    @And("^verify notebook count is displayed as \"([^\"]*)\"$")
    public void verifyNotebookCountIsDisplayedAs(String notebookCount) throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(new DataSets(driver).getNotebookCount().getText().contains(notebookCount));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notebook count:" + notebookCount);

        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Notebook count mismatch");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notebook count:" + notebookCount + "mismatch");
        }
    }

    @And("^user clicks on New Notebook button$")
    public void userClicksOnNewNotebookButton() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getNewNotebookButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "NewNotebook button is clicked");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("NewNotebook is not clicked" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "NewNotebook is not clicked");
        }
    }

    @When("^user enters Notebook title as \"([^\"]*)\" and description as \"([^\"]*)\"$")
    public void userEntersNotebookTitleAsAndDescriptionAs(String notebookTitle, String notebookDescription) throws Throwable {
        try {
            //waitandFindElement(driver, new DataSets(driver).getNotebookTitle(), 3, false);
            sleepForSec(1000);
            enterText(new DataSets(driver).getNotebookTitle(), notebookTitle);
            enterText(new DataSets(driver).getNotebookDescription(), notebookDescription);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notebook title and description entered");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Notebook title and description not entered");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notebook title and description not entered");
        }
    }

    @And("^user clicks on \"([^\"]*)\" button in notebook$")
    public void userClicksOnButtonInNotebook(String buttonName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getButtonsInNotebook(buttonName));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notebook " + buttonName + " button is clicked");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Notebook " + buttonName + " button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notebook " + buttonName + " button is not clicked");
        }
    }

    @And("^user verifies the following headings of notebook$")
    public void userVerifiesTheFollowingHeadingsOfNotebook(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                Assert.assertTrue(isElementPresent(new DataSets(driver).getHeaderNames(data.getNotebookHeaders())));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notebook headers verified ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Failure in notebook headers verification");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Failure in notebook headers verification");
        }
    }

    @And("^user verifies list of notebooks under DataAnalysis$")
    public void userVerifiesListOfNotebooksUnderDataAnalysis() throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getNotebookList().size() > 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "List of Notebook verified");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("List of Notebook not present");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "List of Notebook not present");
        }
    }


    @And("^user clicks on \"([^\"]*)\" notebook in DataAnalysis Tab$")
    public void userClicksOnNotebookInDataAnalysisTab(String notebookName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getNotebookValue(notebookName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Click on notebook is successful");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Click on notebook is not successful");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Click on notebook is not successful");
        }
    }

    @And("^user clicks on \"([^\"]*)\" tab under Notebook$")
    public void userClicksOnTabUnderNotebook(String tabName) throws Throwable {
        try {
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(2000);
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getNotebookTabName(tabName));
            } else {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getNotebookTabName(tabName));
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Click on" + tabName + " tab is successful");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Click on" + tabName + " tab is not successful");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Click on" + tabName + " tab is not successful");
        }
    }

    @And("^user gives \"([^\"]*)\" rating for notebook$")
    public void userGivesRatingForNotebook(String ratingStars) throws Throwable {
        try {
            sleepForSec(1000);
            waitandFindElement(driver, new DataSets(driver).getMyRating(ratingStars), 3, false);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getMyRating(ratingStars));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ratingStars + " rating is successful");

        } catch (Exception e) {
            takeScreenShot("Rating is not successful", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Rating for notebook is not successful");
        }
    }

    @And("^user verifies \"([^\"]*)\" rating is displayed for \"([^\"]*)\" notebook$")
    public void userVerifiesRatingIsDisplayedForNotebook(String ratingValue, String notebookName) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DataSets(driver).getNotebookValue(notebookName, ratingValue)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating for notebook is displayed");
            takeScreenShot("Rating for notebook is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Rating for notebook is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Rating for notebook is not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Rating for notebook is not displayed");
        }
    }

    @And("^user clicks on Add tag in notebook$")
    public void userClicksOnAddTagInNotebook() throws Throwable {
        try {
            clickOn(new DataSets(driver).getAddTagButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Click on AddTag button is successful");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Click on AddTag button is not successful");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Click on AddTag button is not successful");
        }
    }

    @And("^user assign tag \"([^\"]*)\" and clicks on save$")
    public void userAssignTagAndClicksOnSave(String tagName) throws Throwable {
        try {
            enterText(new SubjectArea(driver).enterTagName(), tagName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is entered");
            clickOn(new DataSets(driver).getTagName(tagName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Name is Selected");
            sleepForSec(1000);
            clickOn(new SubjectArea(driver).getAssignTagSaveButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is tagged and saved");
        } catch (Exception e) {
            takeScreenShot("Tag is not assigned to an item", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item is not tagged");
        }
    }

    @And("^user verifies \"([^\"]*)\" tag is displayed for \"([^\"]*)\" notebook$")
    public void userVerifiesTagIsDisplayedForNotebook(String tagName, String notebookName) throws Throwable {
        try {
            waitandFindElement(driver, new DataSets(driver).getNotebookValue(notebookName, tagName), 2, false);
            Assert.assertTrue(isElementPresent(new DataSets(driver).getNotebookValue(notebookName, tagName)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag for notebook is displayed");
            takeScreenShot("Tag for notebook is displayed", driver);
        } catch (Exception e) {
            takeScreenShot("Tag for notebook not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Tag for notebook not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag for notebook not displayed");
        }
    }


    @And("^user verifies added tag \"([^\"]*)\" in details$")
    public void userVerifiesAddedTagInDetails(String tagName) throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue(isElementPresent(new DataSets(driver).getTagUnderTagWidget(tagName)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag is displayed");

        } catch (Exception e) {
            takeScreenShot("Tag not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Tag not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Tag not displayed");
        }
    }


    @And("^user verifies \"([^\"]*)\" button is displayed$")
    public void userVerifiesButtonIsDisplayed(String buttonName) throws Throwable {
        try {
            if (buttonName.equalsIgnoreCase("Run")) {
                if (new DataSets(driver).getRunButton().size() > 0) {
                    Assert.assertTrue(isElementPresent(new DataSets(driver).getRunButton().get(0)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " ConfiguredRun Button is displayed");
                } else {
                    Assert.assertTrue(isElementPresent(new DataSets(driver).getButtonsInNotebook(buttonName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " Configured Run Button is displayed");
                }
            } else {
                Assert.assertTrue(isElementPresent(new DataSets(driver).getButtonsInNotebook(buttonName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " Button is displayed");
            }

        } catch (Exception e) {
            takeScreenShot(buttonName + " Button not displayed", driver);
            Assert.fail(buttonName + " Button not displayed");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " Button not displayed");
        }
    }

    @And("^user verifies \"([^\"]*)\" label and its widget$")
    public void userVerifiesLabelAndItsWidget(String tab) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DataSets(driver).getItemLabelsWithWidgets(tab)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tab + " Label is displayed ");
        } catch (Exception e) {
            takeScreenShot(tab + " Label is not displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(tab + " Label is not displayed ");
        }
    }

    @And("^user selects \"([^\"]*)\" notebook in DataAnalysis Tab$")
    public void userSelectsNotebookInDataAnalysisTab(String notebookName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).selectNotebookCheckbox(notebookName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Select Notebook is successful");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Select Notebook is not successful");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Select Notebook is not successful");
        }

    }


    @And("^user mouse hovers on edit button in description and clicks it$")
    public void userMouseHoversOnEditButtonInDescriptionAndClicksIt() throws Throwable {
        try {
            sleepForSec(1000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getEditWidgetButton());
            } else {
                sleepForSec(1000);
                moveToElement(driver, new DataSets(driver).getDescriptionText());
                clickonWebElementwithJavaScript(driver, new DataSets(driver).getEditWidgetButton());
            }


        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Edit button not displayed");
            Assert.fail("Edit button not displayed");
            takeScreenShot("Edit button not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user mouse hovers on edit button in header and clicks it$")
    public void userMouseHoversOnEditButtonInHeaderAndClicksIt() throws Throwable {
        try {
            new DataSetActions(driver).genericClick("edit widget button");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Edit button not displayed");
            Assert.fail("Edit button not displayed");
            takeScreenShot("Edit button not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user verifies \"([^\"]*)\" button under description widget$")
    public void userVerifiesButtonUnderDescriptionWidget(String buttonName) throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DataSets(driver).getDescriptionButton(buttonName)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " Button is displayed ");
        } catch (Exception e) {
            takeScreenShot(buttonName + " Button is not displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(buttonName + " Button is not displayed ");
        }
    }

    @And("^user edits description text as \"([^\"]*)\"$")
    public void userEditsDescriptionTextAs(String descriptionText) throws Throwable {
        try {
            enterText(new DataSets(driver).getDescriptionTextarea(), descriptionText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description text is entered");

        } catch (Exception e) {
            takeScreenShot("Description text is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Description text is notentered");
            Assert.fail("Description text is not entered");
        }
    }

    @And("^user clicks on \"([^\"]*)\" button in description$")
    public void userClicksOnButtonInDescription(String buttonName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getDescriptionButton(buttonName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), buttonName + " Button is clicked ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), buttonName + " Button is not clicked ");
            Assert.fail("Button is not clicked ");
        }
    }

    @And("^user verifies description text \"([^\"]*)\" is displayed$")
    public void userVerifiesDescriptionTextIsDisplayed(String descriptionText) throws Throwable {
        try {
            sleepForSec(1000);
            Assert.assertTrue((new DataSets(driver).getDescriptionText().getText()).equals(descriptionText));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), descriptionText + "  is displayed ");
        } catch (Exception e) {
            takeScreenShot(descriptionText + " is not displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(descriptionText + " is not displayed ");
        }
    }

    @And("^user clicks on Insert cell in notebook$")
    public void userClicksOnInsertCellInNotebook() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getInsertCellButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " InsertCell Button is clicked ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " InsertCell button is not clicked ");
            Assert.fail(" InsertCell button is not clicked");
        }
    }

    @And("^user selects \"([^\"]*)\" language from dropdown$")
    public void userSelectsLanguageFromDropdown(String langauageName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getDropdownButton());
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getLanguageButton(langauageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Language selection is successful ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Language selection is not successful ");
            Assert.fail(" Language selection is not successful");
        }
    }


    @And("^user enters code as \"([^\"]*)\" for \"([^\"]*)\" language$")
    public void userEntersCodeAsForLanguage(String descriptionText, String languageName) throws Throwable {
        try {
            enterUsingActions(driver, new DataSets(driver).getLanguageText(languageName), descriptionText);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description text is entered");

        } catch (Exception e) {
            takeScreenShot("Description text is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Description text is not entered");
            Assert.fail(" Description text is not entered");
        }
    }

    @And("^user verifies the following notebook is displayed$")
    public void userVerifiesTheFollowingNotebookIsDisplayed(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            sleepForSec(1000);
            for (CucumberDataSet data : dataTableCollection) {
                Assert.assertTrue(isElementPresent(new DataSets(driver).getNotebookValue(data.getNotebookNames())));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notebook names verified ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Failure in notebook names verification");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Failure in notebook names verification");
        }
    }

    @And("^user clears the text in notebook title$")
    public void userClearsTheTextInNotebookTitle() throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("firefox") || browserName.equalsIgnoreCase("edge")) {
                enterText(new DataSets(driver).getNotebookTitle(), " ");
                pressKey(new DataSets(driver).getNotebookTitle(), Keys.BACK_SPACE);

            } else {
                enterText(new DataSets(driver).getNotebookTitle(), "");
                pressKey(new DataSets(driver).getNotebookTitle(), Keys.BACK_SPACE);
                pressKey(new DataSets(driver).getNotebookTitle(), Keys.SPACE);
                pressKey(new DataSets(driver).getNotebookTitle(), Keys.BACK_SPACE);
            }

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description text is entered");

        } catch (Exception e) {
            takeScreenShot("Description text is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Description text is not entered");
        }
    }

    @And("^error message \"([^\"]*)\" should be displayed in notebook$")
    public void errorMessageShouldBeDisplayedInNotebook(String errorMessage) throws Throwable {
        try {
//            if(new DataSets(driver).getNotebookErrorButton_status()){
//                clickOn(new DataSets(driver).getNotebookErrorCloseButton());
//            }
//            else{
//                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), errorMessage + " Notebook error button is not present");
//            }
            Assert.assertTrue((new DataSets(driver).getNotebookError().getText().trim()).equals(errorMessage));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), errorMessage + "  is displayed ");
        } catch (Exception e) {
            takeScreenShot(errorMessage + " is not displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(errorMessage + " is not displayed");
        }
    }

    @And("^error message \"([^\"]*)\" for duplicate notebook should be displayed$")
    public void errorMessageForDuplicateNotebookShouldBeDisplayed(String errorMessage) throws Throwable {
        try {
            Assert.assertTrue((new DataSets(driver).getDuplicateNotebookError().getText().trim()).equals(errorMessage));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), errorMessage + "  is displayed ");
        } catch (Exception e) {
            takeScreenShot(errorMessage + " is not displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(errorMessage + " is not displayed ");
        }
    }

    @And("^user clears the text with the following character and verifies error$")
    public void userClearsTheTextWithTheFollowingCharacterAndVerifiesError(DataTable data) throws Throwable {
        try {

            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                enterText(new DataSets(driver).getNotebookTitle(), values.get("notebookTitle"));
                pressKey(new DataSets(driver).getNotebookTitle(), Keys.SPACE);
                String actualText = new DataSets(driver).getRestritedErrorMessage().trim();
                Assert.assertEquals(values.get("errorMessage"), actualText);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Error message is displayed for restricted character");

            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Error message is not displayed for restricted character ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("Error message is not displayed for restricted character");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error message is not displayed for restricted character");
        }
    }

    @And("^user enters \"([^\"]*)\" in textarea of \"([^\"]*)\" language$")
    public void userEntersInTextareaOfLanguage(String descriptionText, String languageName) throws Throwable {
        try {
            enterText(new DataSets(driver).getLanguageTextarea(languageName), descriptionText);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getLanguageEyeIcon(languageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description text is entered");

        } catch (Exception e) {
            takeScreenShot("Description text is not entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Description text is not entered");
        }
    }


    @And("^user verifies pencil icon for \"([^\"]*)\" language$")
    public void userVerifiesPencilIconForLanguage(String languageName) throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getLanguagePencilIcon(languageName).isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Pencil icon  is displayed ");
        } catch (Exception e) {
            takeScreenShot(" Pencil icon  is displayed ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(" Pencil icon  is displayed ");
        }
    }


    @And("^user verifies text for \"([^\"]*)\" is displayed in \"([^\"]*)\"$")
    public void userVerifiesTextForIsDisplayedIn(String languageName, String fontStyle) throws Throwable {
        try {
            if (fontStyle.equals("italic")) {
                Assert.assertTrue(new DataSets(driver).getTextAreaValue(languageName, "em").getCssValue("font-style").equals(fontStyle));
            } else if (fontStyle.equals("bold")) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Font weight" + new DataSets(driver).getTextAreaValue(languageName, "strong").getCssValue("font-style"));
                Assert.assertTrue(Integer.parseInt(new DataSets(driver).getTextAreaValue(languageName, "strong").getCssValue("font-weight")) >= 700);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Pencil icon  is displayed ");
        } catch (Exception e) {
            takeScreenShot(" Fontstyle  is mismatching ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(" Fontstyle  is mismatching ");
        }
    }

    @And("^user clicks on pencil icon for \"([^\"]*)\" language$")
    public void userClicksOnPencilIconForLanguage(String languageName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getLanguagePencilIcon(languageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Pencil icon  is clicked");

        } catch (Exception e) {
            takeScreenShot("Pencil icon is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Pencil icon is not clicked");
            Assert.fail("Pencil icon is not clicked");
        }
    }

    @And("^user clicks on Delete button for \"([^\"]*)\"$")
    public void userClicksOnDeleteButtonFor(String languageName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getLanguageDeleteButton(languageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Delete button  is clicked");

        } catch (Exception e) {
            takeScreenShot("Delete button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Delete button is not clicked");
            Assert.fail("Delete button is not clicked");
        }
    }

    @And("^user verifies \"([^\"]*)\" cell is deleted$")
    public void userVerifiesCellIsDeleted(String languageName) throws Throwable {
        try {
            if (new DataSets(driver).getEyeIcon(languageName).size() == 0) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Inserted cell is  deleted");

            } else {
                Assert.fail("Inserted cell is not deleted");

            }
        } catch (Exception e) {
            takeScreenShot("Inserted cell is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Inserted cell is not deleted");
            Assert.fail("Inserted cell is not  deleted");
        }
    }

    @And("^user verifies Up arrow is disabled for \"([^\"]*)\"$")
    public void userVerifiesUpArrowIsDisabledFor(String languageName) throws Throwable {
        try {
            Assert.assertFalse(new DataSets(driver).getUpArrowButton(languageName).isEnabled());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Up arrow  is disabled ");
        } catch (Exception e) {
            takeScreenShot(" Up arrow  is enabled ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(" Up arrow  is enabled ");
        }
    }

    @And("^user verifies Down arrow is disabled for \"([^\"]*)\"$")
    public void userVerifiesDownArrowIsDisabledFor(String languageName) throws Throwable {
        try {
            Assert.assertFalse(new DataSets(driver).getDownArrowButton(languageName).isEnabled());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Down arrow  is disabled ");
        } catch (Exception e) {
            takeScreenShot(" Down arrow  is enabled ", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(" Down arrow  is enabled ");
        }
    }

    @And("^user clicks on second Insert cell in notebook$")
    public void userClicksOnSecondInsertCellInNotebook() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getInsertCellSecondButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " InsertCell Button is clicked ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " InsertCell button is not clicked ");
            Assert.fail(" InsertCell button is not clicked ");
        }
    }

    @And("^user selects \"([^\"]*)\" language for second dropdown$")
    public void userSelectsLanguageForSecondDropdown(String langauageName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getDropdownSecondButton());
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getLanguageButton(langauageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Language selection is successful ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Language selection is not successful ");
            Assert.fail(" Language selection is not successful  ");
        }
    }

    @And("^user clicks on Up arrow for \"([^\"]*)\"$")
    public void userClicksOnUpArrowFor(String langauageName) throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getUpArrowButton(langauageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Up arrow is clicked ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Up arrow  is not clicked ");
            Assert.fail(" Up arrow  is not clicked  ");
        }
    }

    @And("^user verifies \"([^\"]*)\" is displayed at top$")
    public void userVerifiesIsDisplayedAtTop(String languageName) throws Throwable {
        try {
            String actualText = new DataSets(driver).getDropdownButton().getText().trim();
            Assert.assertTrue(actualText.equals(languageName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), languageName + " is displayed at top ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), languageName + " is not displayed at top ");
            Assert.fail(languageName + " is not displayed at top  ");
        }

    }

    @And("^user clicks on \"([^\"]*)\" button in notebook full view$")
    public void userClicksOnButtonInNotebookFullView(String buttonName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getButtonsInNotebookFullView(buttonName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Notebook " + buttonName + " button is clicked");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Notebook " + buttonName + " button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Notebook " + buttonName + " button is not clicked");
        }
    }

    @And("^user verifies export button is displayed$")
    public void userVerifiesExportButtonIsDisplayed() throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getExportButton().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Export button is displayed");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Export button is not displayed");
            Assert.fail("Export button is not displayed");
        }
    }

    @And("^user verifies Edit button is displayed in notebook$")
    public void userVerifiesEditButtonIsDisplayedInNotebook() throws Throwable {
        try {
            Assert.assertTrue(isElementPresent(new DataSets(driver).getEditButton()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit Button is displayed");

        } catch (Exception e) {
            takeScreenShot(" EditButton not displayed", driver);
            Assert.fail(" Edit Button not displayed");
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Edit Button not displayed");
        }
    }

    @And("^user enters code from \"([^\"]*)\" for \"([^\"]*)\" language$")
    public void userEntersCodeFromForLanguage(String fileName, String languageName) throws Throwable {
        try {
            fileUtil.replaceSpecficString("ambarihost", propLoader.prop.getProperty("sftpServerHostname"), FEATURES + fileName);
            String text = fileUtil.readFile(FEATURES + fileName);
            enterUsingActions(driver, new DataSets(driver).getLanguageText(languageName), text);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Text entered successfully");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Text entered not successful");
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in notebook$")
    public void userClicksOnRunButtonInNotebook(String actionType, String buttonName) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, buttonName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Run button is clicked");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(" Run button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Run button is not clicked");
        }
    }

    @And("^user verifies output image is displayed$")
    public void userVerifiesOutputImageIsDisplayed() throws Throwable {
        try {
            Assert.assertTrue(new DataSets(driver).getResultImage().isDisplayed());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Output image is displayed ");
        } catch (Exception e) {
            takeScreenShot(" Output image is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on exit button in notebook full view$")
    public void userClicksOnExitButtonInNotebookFullView() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver, new DataSets(driver).getExitButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Language selection is successful ");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " Language selection is not successful ");
            Assert.fail("Language selection is not successful");
        }
    }

    @Then("^\"([^\"]*)\" button should be available in DataSet$")
    public void buttonShouldBeAvailableInDataSet(String actionName) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                isElementPresent(new DataSets(driver).returnDataSetActionButton(actionName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet action button " + actionName + "is found in DataSet");
            } else {
                isElementPresent(new DataSets(driver).returnDataSetActionButton(actionName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet action button " + actionName + "is found in DataSet");
            }
        } catch (Exception e) {
            takeScreenShot(actionName + " button is not found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), actionName + " button is not found ");
            Assert.fail(actionName + " button is not found ");
        }
    }

    @And("^user clicks on \"([^\"]*)\" button$")
    public void userClicksOnButton(String actionName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(2000);
                clickonWebElementwithJavaScript(driver, new DataSets(driver).returnDataSetActionButton(actionName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionName + " button is clicked");
            } else {
                clickonWebElementwithJavaScript(driver, new DataSets(driver).returnDataSetActionButton(actionName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionName + " button is clicked");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(actionName + " button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), actionName + " is not clicked");
        }
    }

    @Then("^\"([^\"]*)\" panel should be opening$")
    public void panelShouldBeOpening(String panelName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                isElementPresent(new DataSets(driver).returnPanel(panelName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), panelName + " is showing");
            } else {
                isElementPresent(new DataSets(driver).returnPanel(panelName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), panelName + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(panelName + " is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), panelName + " is not showing");
        }
    }

    @And("^panel should have \"([^\"]*)\" field$")
    public void panelShouldHaveField(String labelName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                isElementPresent(new DataSets(driver).returnTextbox(labelName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is showing");
            } else {
                isElementPresent(new DataSets(driver).returnTextbox(labelName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not showing");
        }
    }

    @And("^panel should have \"([^\"]*)\" fields$")
    public void panelShouldHaveFields(String labelName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                isElementPresent(new DataSets(driver).returnTextArea(labelName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is showing");
            } else {
                isElementPresent(new DataSets(driver).returnTextArea(labelName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not showing");
        }
    }

    @And("^user enters the report \"([^\"]*)\" as \"([^\"]*)\"$")
    public void userEntersTheReportAs(String labelName, String reportName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                enterText(new DataSets(driver).returnTextbox(labelName), reportName);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is entered as " + reportName);
            } else {
                enterText(new DataSets(driver).returnTextbox(labelName), reportName);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is entered as " + reportName);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not entered as " + reportName);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not entered as " + reportName);
        }
    }

    @And("^user enters the reports \"([^\"]*)\" as \"([^\"]*)\"$")
    public void userEntersTheReportsAs(String labelName, String description) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                enterText(new DataSets(driver).returnTextArea(labelName), description);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is entered as " + description);
            } else {
                enterText(new DataSets(driver).returnTextArea(labelName), description);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is entered as " + description);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not entered as " + description);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not entered as " + description);
        }
    }

    @And("^user enters the \"([^\"]*)\" as \"([^\"]*)\"$")
    public void userEntersTheAs(String labelName, String reportUrl) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                enterText(new DataSets(driver).returnTextArea(labelName), new JsonRead().readJSon(labelName, reportUrl));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is entered as " + reportUrl);
            } else {
                enterText(new DataSets(driver).returnTextArea(labelName),reportUrl);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is entered as " + reportUrl);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not entered as " + reportUrl);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not entered as " + reportUrl);
        }
    }

    @And("^user clicks on save button$")
    public void userClicksOnSaveButton() {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, new DataSets(driver).returnSaveButton());
                sleepForSec(2000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Save button is clicked");
            } else {
                clickOn(driver, new DataSets(driver).returnSaveButton());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Save button is clicked");
                waitForAngularLoad(driver);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("save button is not clicked");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "save button is not clicked");
        }
    }


    @And("^report \"([^\"]*)\" should  be displayed in tab$")
    public void reportShouldBeDisplayedInTab(String reportName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                Assert.assertTrue(new DataSets(driver).returnReportElement(reportName).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), reportName + " is showing");
            } else {
                sleepForSec(1000);
                Assert.assertTrue(new DataSets(driver).returnReportElement(reportName).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), reportName + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(reportName + " is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), reportName + " is not showing");
        }
    }

    @Then("^Error message \"([^\"]*)\" should be displayed for duplicate report$")
    public void errorMessageShouldBeDisplayedForDuplicateReport(String errorMsg) throws Throwable {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                Assert.assertEquals(new DataSets(driver).returnDuplicateNameError().getText().trim(), errorMsg.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), errorMsg + " is showing");
            } else {
                sleepForSec(1000);
                Assert.assertEquals(new DataSets(driver).returnDuplicateNameError().getText().trim(), errorMsg.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), errorMsg + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(errorMsg + " alert is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), errorMsg + " alert is not showing");
        }
    }

    @Then("^Error message \"([^\"]*)\" should be displayed in report$")
    public void errorMessageShouldBeDisplayedInReport(String requiredFieldError) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                Assert.assertEquals(new DataSets(driver).returnreqquiredFieldError().getText().trim(), requiredFieldError.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), requiredFieldError + " is showing");
            } else {
                sleepForSec(1000);
                Assert.assertEquals(new DataSets(driver).returnreqquiredFieldError().getText().trim(), requiredFieldError.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), requiredFieldError + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(requiredFieldError + " alert is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), requiredFieldError + " alert is not showing");
        }
    }

    @Then("^Error message \"([^\"]*)\" should be displayed in report panel$")
    public void errorMessageShouldBeDisplayedInReportPanel(String invalidNameError) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                Assert.assertEquals(new DataSets(driver).returnInvalidNameError().getText().trim(), invalidNameError.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), invalidNameError + " is showing");
            } else {
                sleepForSec(1000);
                Assert.assertEquals(new DataSets(driver).returnInvalidNameError().getText().trim(), invalidNameError.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), invalidNameError + " is showing");
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(invalidNameError + " alert is not showing");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), invalidNameError + " alert is not showing");
        }
    }

    @Then("^facet \"([^\"]*)\" should have a \"([^\"]*)\"$")
    public void facetShouldHaveA(String facetType, String dataType) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(1000);
                Assert.assertTrue(new DataSets(driver).returnfacetTypeandItem(facetType, dataType).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "facet " + facetType + " is showing" + dataType);
            } else {
                sleepForSec(1000);
                Assert.assertTrue(new DataSets(driver).returnfacetTypeandItem(facetType, dataType).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "facet " + facetType + " is showing" + dataType);
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(facetType + " facet is not having " + dataType + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), facetType + " facet is not having " + dataType);
        }
    }

    @Then("^user clicks on \"([^\"]*)\" tab in DataSet item view$")
    public void userClicksOnTabInDataSetItemView(String tabName) {
        try {
            String browserName = propLoader.prop.getProperty("browserName");
            if (browserName.equalsIgnoreCase("edge") || browserName.equalsIgnoreCase("firefox")) {
                sleepForSec(2000);
                clickOn(new DataSets(driver).getDataSetViewTabs(tabName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tabName + " is clicked");
            } else {
                sleepForSec(2000);
                clickOn(new DataSets(driver).getDataSetViewTabs(tabName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), tabName + " is clicked");
            }

        } catch (Exception e) {
            takeScreenShot("Data set filter tab" + tabName + "is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" for \"([^\"]*)\" in the Data tab$")
    public void order_list_should_be_enabled(String actionType, String orderList) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, orderList);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "user " + actionType + " for " + orderList);
        } catch (Exception e) {
            takeScreenShot("Issue in identifying Order list", driver);
            Assert.fail("Issue in identifying Order list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying Order list");
        }
    }

    @When("^user \"([^\"]*)\" on \"([^\"]*)\" for the \"([^\"]*)\" item in the order list panel$")
    public void user_clicks_on_remove_button_for_the_item(String actionType, String buttonName, String itemName) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, buttonName, itemName);
//            new DataSets(driver).clickItemRemoveButton(itemName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "item remove button is clicked");
        } catch (Exception e) {
            takeScreenShot("item remove button is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Then("^user \"([^\"]*)\" for the \"([^\"]*)\" panel$")
    public void user_verifies_panel_displayed_or_not(String actionType, String panel) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, panel);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "user " + actionType + " for the " + panel + " panel");
        } catch (Exception e) {
            takeScreenShot("Issue in identifying panel display status", driver);
            Assert.fail("Issue in identifying panel display status");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying panel display status");
        }
    }

    @And("^user \"([^\"]*)\" for \"([^\"]*)\" in the ORDER LIST panel$")
    public void user_verifies_selected_elements_are_displayed(String actionType, String text) {
        try {
            new DataSetActions(driver).genericActions(actionType, text);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The selected elements count is displayed in the order list panel");
        } catch (Exception e) {
            takeScreenShot("The selected elements count is not displayed in the order list panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The selected elements count is not displayed in the order list panel" + e.getMessage());
        }
    }

    @And("^user verifies whether plus button is displayed for the \"([^\"]*)\" item and background color for the selected item for removal is \"([^\"]*)\" in the order list panel$")
    public void userVerifiesWhetherButtonIsDisplayedForTheItemAndBackgroundColorForTheSelectedItemForRemovalIs(String itemName, String expectedRGBCode) throws Throwable {
        try {
            new DataSetActions(driver).genericVerifyElementPresent("plus button", itemName);
            new DataSetActions(driver).genericVerifyEquals("removal_item_bg_color", expectedRGBCode);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Background color is verified");
        } catch (Exception e) {
            takeScreenShot("The selected elements count is not displayed in the order list panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("The selected elements count is not displayed in the order list panel" + e.getMessage());
        }
    }

    @Then("^user validates the following data items are present in the order list panel$")
    public void user_verifies_whether_items_are_present_in_order_list_panel(List<CucumberDataSet> dataTableCollection) {
        try {
            waitForAngularLoad(driver);
            for (CucumberDataSet data : dataTableCollection) {
                Assert.assertTrue(isElementPresent(new DataSets(driver).getItemFromOrderList(data.getItemsFromOrderList())));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items are displayed under the order List panel");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Items are not displayed under the order List panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Items are not displayed under the order List panel" + e.getMessage());
        }
    }

    @Then("^user validates the following data items are not present in the open notification panel$")
    public void user_verifies_whether_items_are_not_present_in_open_notification_panel(List<CucumberDataSet> dataTableCollection) {
        try {

            for (CucumberDataSet data : dataTableCollection) {
                Assert.assertFalse(traverseListContainsElementText(new DataSets(driver).getItemFromOpenNotificationPanel(), data.getRemovedItemsFromOrderList()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items are removed should not get displayed under the open notification panel");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Items are removed is displayed under the open notification panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Items are removed is displayed under the open notification panel" + e.getMessage());
        }
    }

    @And("^user verfies whether the following labels and values are present in the Order Requests tab$")
    public void userVerfiesWhetherTheFollowingLabelsAndValuesArePresentInTheOrderRequestsTab(DataTable dataTable) throws Throwable {
        try {
            int count = 1;
            String time = CommonUtil.getCurrentDateInStringFormat();
            waitForAngularLoad(driver);
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {

                String label = values.get("orderlistLabels");
                String Labelvalues = values.get("orderListValues");

                if (values.get("orderlistLabels").equalsIgnoreCase("REQUESTED AT")) {
                    Labelvalues = Labelvalues + time.toLowerCase();
                    Labelvalues = CommonUtil.getFirstLetterAsUpperCase(Labelvalues);
                }
                Assert.assertTrue(isElementPresent(new DataSets(driver).getOrderRequestslabelsAndvalues(count, label, Labelvalues)));
                count++;
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "labels and values are showing as expected");
        } catch (Exception e) {
            takeScreenShot("Error in displaying labels and values", driver);
            Assert.fail("Error in displaying labels and values");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user verfies whether the following Headers and values are present in the Order Requests panel$")
    public void userVerfiesWhetherTheFollowingHeadersAndValuesArePresentInTheOrderRequestsPanel(DataTable dataTable) throws Throwable {
        try {

            int count = 1;
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {

                String status = getElementText(new DataSets(driver).getDatasetStatusInOrderRequestPanel());

                String label = values.get("orderlistHeaders");
                String Labelvalues = values.get("orderListValues");

                if (values.get("orderListValues").equalsIgnoreCase("STATUS") && ((status.equalsIgnoreCase("In Progress")||status.equalsIgnoreCase("Requested")))){
                    Labelvalues = Labelvalues.replace(values.get("orderListValues"),status);
                }

                Assert.assertTrue(isElementPresent(new DataSets(driver).getOrderRequestsHeaderAndvalues(count, label, Labelvalues)));
                count++;
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Headers and values are showing as expected in Order Requests panel");
        } catch (Exception e) {
            takeScreenShot("Error in displaying Headers and values in Order Requests panel", driver);
            Assert.fail("Error in displaying Headers and values in Order Requests panel");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user clicks on the first order from the list in the Order Request Panel$")
    public void userClicksOnTheFirstOrderFromTheList() throws Throwable {
        try {
            new DataSetActions(driver).genericClick("First Order In List");
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "First order from the list is clicked");
        } catch (Exception e) {
            takeScreenShot("First order from the list is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user clicks on \"([^\"]*)\" order from the list under Order Request tab$")
    public void userClicksOnTheOrderFromTheList(String arg0) throws Throwable {
        try {
            clickOn(new DataSets(driver).getNameInOrderRequestPanel(arg0));
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "First order from the list is clicked");
        } catch (Exception e) {
            takeScreenShot("First order from the list is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }


    @And("^user \"([^\"]*)\" on the \"([^\"]*)\"$")
    public void userClicksOnTheFirstOrderitemFromThePanel(String actionType, String firstItem) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, firstItem);
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "First item from the order request is clicked");
        } catch (Exception e) {
            takeScreenShot("First item from the order request is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Given("^user clicks on Full view icon in Datasets page$")
    public void user_clicks_the_full_view_button_for_the_facet() throws Throwable {
        try {
            new DataSetActions(driver).genericClick("Full view icon");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Full view icon is clicked");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Full view icon is not clicked");
            Assert.fail("Full view icon is not clicked" + e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" for the following \"([^\"]*)\" in the order requests panel$")
    public void user_verifies_whether_items_are_not_present_in_order_requests_panel(String actionType, String dataItem, List<CucumberDataSet> dataTableCollection) {
        try {

            for (CucumberDataSet data : dataTableCollection) {
                new DataSetActions(driver).genericActions(actionType, dataItem, data.getorderRequestItems());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items are displayed under the order requests panel");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Items are not displayed under the order requests panel", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Items are not displayed under the order requests panel" + e.getMessage());
        }
    }

    @When("^user clicks on the i icon of \"([^\"]*)\" item under My Access under Data tab$")
    public void user_clicks_on_i_icon_under_My_Access(String item) throws Throwable {
        try {
            new DataSets(driver).clickIiconUnderMyAccess(item);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "i icon under My access is clicked");
        } catch (Exception e) {
            takeScreenShot("i icon under My access is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user \"([^\"]*)\" on the \"([^\"]*)\" in the popUp under Data tab$")
    public void userClicksOnTheViewDetailsInThePopUp(String actionType, String argu0) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, argu0);
            LoggerUtil.logLoader_info(this.getClass().getName(), "View Details link in the popup is clicked");
        } catch (Exception e) {
            takeScreenShot("View Details link in the popup is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" in the Order Request Panel$")
    public void userClicksOnInTheOrderRequestPanel(String actionType, String arg0) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, arg0);
            LoggerUtil.logLoader_info(this.getClass().getName(), arg0 + " Tab is clicked under the order request panel ");
        } catch (Exception e) {
            takeScreenShot(arg0 + " Tab is not clicked under the order request panel", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user \"([^\"]*)\" \"([^\"]*)\" comment in the \"([^\"]*)\" section$")
    public void userEntersCommentInTheSection(String actionType, String arg0, String arg1) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, arg1, arg0);
            sleepForSec(1000);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks on the note icon displayed under the progress tab for the \"([^\"]*)\"$")
    public void userClicksOnAnyOfTheNoteDisplayedUnderTheProgressTab(String notesBy) throws Throwable {
        try {
            new DataSetActions(driver).genericClick(notesBy);
            sleepForSec(500);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" \"([^\"]*)\" option in \"([^\"]*)\"$")
    public void user_check_show_comments_and_selects_all_user_dropdown(String actionType, String user, String dropdown) {
        try {
            new DataSetActions(driver).genericActions(actionType, dropdown, user);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user verifies whether the following is displayed in the comment$")
    public void verify_the_comment_is_from_user(List<CucumberDataSet> dataTableCollection) {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                new DataSetActions(driver).genericVerifyElementPresent("comment text", data.getCommentText());
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Comment is verified");
        } catch (Exception e) {
            takeScreenShot("Comment is not verified", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" column in the table under data tab$")
    public void userVerifiesWhetherColumnIsDisplayedInTheTable(String actionType, String ColumnName) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, ColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ColumnName + " column is displayed");
        } catch (Exception e) {
            takeScreenShot(ColumnName + " column is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(ColumnName + " column is not displayed" + e.getMessage());
        }
    }

    @And("^user verifies whether the status of Dataset status is \"([^\"]*)\" under dataset overview tab$")
    public void userVerifiesWhetherStatusIsDisplayed(String status) throws Throwable {
        try {
            new DataSetActions(driver).genericVerifyElementPresent("dataset status", status);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), status + " status is displayed");
        } catch (Exception e) {
            takeScreenShot(status + " status is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(status + " column is not displayed" + e.getMessage());
        }
    }

    @When("^user \"([^\"]*)\" \"([^\"]*)\" option from the dropdown for Data Visibility$")
    public void user_selects_option_from_the_dropdown_for_data_visibility(String actionType, String option) {
        try {
            new DataSetActions(driver).genericActions(actionType, option);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user \"([^\"]*)\" for \"([^\"]*)\" field under edit visibility panel$")
    public void user_verifies_multiple_search_displayed_or_not(String actionType, String status) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, status);
        } catch (Exception e) {
            takeScreenShot("Issue in identifying Multi select input field", driver);
            Assert.fail("Issue in identifying Multi select input field");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying panel display status");
        }
    }

    @And("^user enters the user name and selects the option from the dropdown list in the edit visibility panel$")
    public void userEntersDifferentUserName(List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            if (new DataSets(driver).getRemoveButton_MultiSelectInputField().isEmpty()) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No items are displayed to remove");
            } else {
                new DataSetActions(driver).genericClick("remove button in multiselectInput field");
            }

            sleepForSec(500);
            for (CucumberDataSet data : dataTableCollection) {
                String username = data.getUserNames();
                new DataSetActions(driver).enterActions("MultiSelectInputField", username);
                new DataSetActions(driver).genericClick("MultiSelectInput_user", username);
            }
        } catch (Exception e) {
            takeScreenShot("Issue in identifying Multi select input field", driver);
            Assert.fail("Issue in identifying Multi select input field");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying panel display status");
        }
    }

    @Then("^user \"([^\"]*)\" for \"([^\"]*)\" for \"([^\"]*)\" under Run Dataset actions panel$")
    public void user_verifies_Run_button_displayed_or_not(String actionType, String button, String connector) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, button, connector);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionType + "for Run button");
        } catch (Exception e) {
            takeScreenShot("Issue in identifying Run button display status", driver);
            Assert.fail("Issue in identifying Run button display status");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying Run button display status");
        }
    }

    @And("^user \"([^\"]*)\" whether the Last user is \"([^\"]*)\" under dataset overview tab$")
    public void userVerifiesTheLastUserIs(String actionType, String userName) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, userName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), userName + " is displayed as the last user");
        } catch (Exception e) {
            takeScreenShot(userName + " is not displayed as the last user", driver);
            Assert.fail("Issue in identifying last user");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), userName + " is not displayed as the last user");
        }
    }

    @And("^user verifies whether top user widget is displayed with mandatory information under dataset overview tab$")
    public void userVerifiesWhetherTopUserWidgetIsDisplayedWithMandatoryInformation() throws Throwable {
        try {
            new DataSetActions(driver).userVerifiesWhetherTopUserWidgetIsDisplayedWithMandatoryInfo();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All the information regarding the top user is displayed under the Top user widget");
        } catch (Exception e) {
            takeScreenShot("The information regarding the top user is not displayed under the Top user widget", driver);
            Assert.fail("Issue in identifying last user");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The information regarding the top user is not displayed under the Top user widget");
        }
    }

    @And("^user \"([^\"]*)\" whether the width of the \"([^\"]*)\" widget and \"([^\"]*)\" are same under dataset overview tab$")
    public void userVerifiesWhetherTheWidthOfTheWidgetIs(String actionType, String arg0, String arg1) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, arg0, arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verified the width of the widget and its matching with the expected");
        } catch (Exception e) {
            takeScreenShot("The widget width is not matching with the expected", driver);
            Assert.fail("Issue in identifying the widget width");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The widget width is not matching with the expected");
        }
    }

    @And("^user verifies \"([^\"]*)\" call is displayed in the Top User widget$")
    public void userVerifiesCallIsDisplayed(int arg0) throws Throwable {
        try {
            String callCount = String.valueOf(arg0);
            Assert.assertTrue(getElementText(new DataSets(driver).get_TopUserWidget_CallCount_Block()).contains(callCount));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verified the width of the widget and its matching with the expected");
        } catch (Exception e) {
            takeScreenShot("The widget width is not matching with the expected", driver);
            Assert.fail("Issue in identifying the widget width");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The widget width is not matching with the expected");
        }
    }

    @And("^user \"([^\"]*)\" whether the top users of the dataset contains \"([^\"]*)\" username under dataset overview tab$")
    public void userVerifiesWhetherTheTopUsersOfTheDatasetContainsUsername(String actionType, String arg0) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, arg0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg0 + " is displayed as the top user");
        } catch (Exception e) {
            takeScreenShot(arg0 + " is not displayed as the top user", driver);
            Assert.fail("Issue in identifying the top user");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), arg0 + " is not displayed as the top user");
        }
    }

    @And("^user verifies MYACCESS status for item is displayed under Data tab$")
    public void verifiesWhetherStatusIsDisplayedForTheItem(DataTable data) throws Throwable {
        try {
            String status = "";
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                sleepForSec(500);
                status = getElementText(new DataSets(driver).getMyAccessStatus(values.get("itemName")));
                if (status.equalsIgnoreCase("Requested")) {
                    Assert.assertTrue(isElementPresent(new DataSets(driver).getMyAccessStatusForRequested(values.get("itemName"))));
                } else if (status.equalsIgnoreCase("In Progress")) {
                    Assert.assertTrue(isElementPresent(new DataSets(driver).getMyAccessStatusForInProgress(values.get("itemName"))));
                } else {
                    Assert.assertTrue(new DataSets(driver).getMyAccessStatusForTheItem(values.get("itemName"), status).isDisplayed());
                }
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "My Access is displayed");
        } catch (Exception e) {
            takeScreenShot("MyAccess syatus is not displayed", driver);
            Assert.fail("Issue in identifying myAccess status");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), " MyAccess is not displayed");
        }
    }

    @And("^user \"([^\"]*)\" for \"([^\"]*)\" with all the details in both preview and full view in the Order Request Panel$")
    public void userVerifiesWhetherWorkflowDiagramIsDisplayedInFullView(String actionType, String workflow) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, workflow);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All the information regarding the top user is displayed under the Top user widget");
        } catch (Exception e) {
            takeScreenShot("The information regarding the top user is not displayed under the Top user widget", driver);
            Assert.fail("Issue in identifying last user");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The information regarding the top user is not displayed under the Top user widget");
        }
    }


    @And("^user \"([^\"]*)\" for the workflow \"([^\"]*)\" in the order request panel$")
    public void userVerifiesWhetherWorkflowDiagramIsDisplayedInFullView(String actionType, String diagramProgress, DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new DataSetActions(driver).genericActions(actionType, diagramProgress, values.get("stepPerformedBy"), values.get("user"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All the information regarding the diagram is displayed in the diagram blocks");
            }
        } catch (Exception e) {
            takeScreenShot("The information regarding the diagram is not displayed in the diagram blocks", driver);
            Assert.fail("Issue in identifying the deatils about diagram");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "The information regarding the diagram is not displayed in the diagram blocks");
        }
    }

    @And("^user verifies the note count of the workflow Diagram in the Order Request Panel$")
    public void userVerifiesTheNoteCountInTheDiagram(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                new DataSetActions(driver).genericVerifyEquals("noteCount", values.get("stepPerformedBy"), values.get("noteCount"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected count is displayed in the Work flow diagram");
            }
        } catch (Exception e) {
            takeScreenShot("Expected count is not displayed in the Work flow diagram", driver);
            Assert.fail("Issue in identifying the note count in the diagram diagram");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected count is not displayed in the Work flow diagram");
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" button in the Notes panel$")
    public void userClicksOnPostButtonButtonInNotesPanel(String actionType, String arg0) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, arg0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg0 + " button is clicked successfully");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), arg0 + " button is not clicked");
            Assert.fail(arg0 + " button is not clicked");
        }
    }

    @And("^user \"([^\"]*)\" for \"([^\"]*)\" in the Order request panel$")
    public void userClicksOnTheCancelRequestButtonInTheOrderRequestPanel(String actionType, String buttonName) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, buttonName);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Cancel Request Button is verified");
        } catch (Exception e) {
            takeScreenShot("Cancel Request Button is not verified", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" button in the Order Request panel for the \"([^\"]*)\" user$")
    public void userVerifiesButtonIsNotDisplayedInTheNotesPanel(String arg0, String arg1, String arg2) throws Throwable {
        try {
            if (arg0.equalsIgnoreCase("click")) {
                new DataSets(driver).Click_buttonInCommentBox(arg2, arg1);
            } else if (arg0.equalsIgnoreCase("verifies displayed")) {
                Assert.assertTrue(new DataSets(driver).getButtonInCommentBox_status(arg1, arg2));
            } else if (arg0.equalsIgnoreCase("verifies not displayed")) {
                Assert.assertFalse(new DataSets(driver).getButtonInCommentBox_status(arg1, arg2));
            }
            LoggerUtil.logLoader_info(this.getClass().getName(), arg1 + " Button is verified");
        } catch (Exception e) {
            takeScreenShot(arg1 + " Button is not verified", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user clicks On DataSet Dashboard And navigates to The \"([^\"]*)\" Dataset \"([^\"]*)\" Tab$")
    public void userClicksOnDataSetDashboardAndnavigatestoTheDatasetTab(String dataSetName, String tabName) throws Throwable {
        try {
            sleepForSec(1000);
            waitForAngularLoad(driver);
            new DataSetActions(driver).userClicksOnDataSetDashboardAndnavigatestoTheDatasetTab(dataSetName, tabName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User navigated to dataset tab");
            takeScreenShot("User navigated to dataset tab", driver);
        } catch (Exception e) {
            takeScreenShot("Issue in navigating to dataset tab", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user creates a dataset with name \"([^\"]*)\" and description \"([^\"]*)\"$")
    public void userCreatesADataset(String dataSetName, String datasetDescription) throws Throwable {
        try {
            new DataSetActions(driver).userCreatesADataset(dataSetName, datasetDescription);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User created dataset");
            takeScreenShot("User created dataset", driver);
        } catch (Exception e) {
            takeScreenShot("Issue in creating dataset", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^user clicks On DataSet Dashboard And navigates to The \"([^\"]*)\" Dataset$")
    public void userClicksOnDataSetDashboardAndnavigatestoTheDataset(String dataSetName) throws Throwable {
        try {
            new DataSetActions(driver).userClicksOnDataSetDashboardAndnavigatestoTheDataset(dataSetName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User navigated to dataset");
            takeScreenShot("User navigated to dataset", driver);
        } catch (Exception e) {
            takeScreenShot("Issue in navigating to dataset", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user assigns \"([^\"]*)\" dataset from the Assign data set panel$")
    public void user_select_in_Data_Set_in_Assign_data_set_panel(String dataSet) throws Throwable {
        try {
            new DataSetActions(driver).assignAnyDataSet(dataSet);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set drop down is clicked");
            LoggerUtil.logLoader_info(this.getClass().getName(), "Data Set from list is selected");
        } catch (Exception e) {
            takeScreenShot("Data Set is not selected", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Data Set is not selected" + e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" data item checkbox from the list$")
    public void user_clicks_first_item_checkbox_from_item(String item) throws Throwable {
        try {
            new DataSets(driver).clickFirstDataItemDisplayed(item);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "First item checkbox is clicked");
        } catch (Exception e) {
            takeScreenShot("Item checkbox is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Item checkbox is not clickable" + e.getMessage());
        }
    }

    @When("^user clicks on Order List$")
    public void user_clicks_on_order_list() throws Throwable {
        try {
            new DataSets(driver).clickOrderList();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Order List is clicked");
        } catch (Exception e) {
            takeScreenShot("Order List is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @When("^user clicks on submit order button$")
    public void user_clicks_on_submit_button() throws Throwable {
        try {
            new DataSets(driver).clickSubmitOrderButton();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "submit order button is clicked");
        } catch (Exception e) {
            takeScreenShot("submit order button is not clickable", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @And("^user \"([^\"]*)\" on \"([^\"]*)\" on DatasetPage$")
    public void user_click_on_Dataseticon_inDatasetpage(String actionType, String elementName) throws Throwable {
        try {
            new DataSetActions(driver).genericActions(actionType, elementName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Dataseticon is Clicked");
        } catch (Exception e) {
            takeScreenShot("Dataseticon is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }
    @And("^user \"([^\"]*)\" \"([^\"]*)\" on DatasetPage$")
    public void user_veriifes_disabled_Datatsetpanel_on_Datasetpage(String actionType, String elementName)throws Throwable{
        try {

            new DataSetActions(driver).genericActions(actionType, elementName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "DataSetpanel is disabled");
        }
        catch (Exception e){
            takeScreenShot("Datasetpanel is not disabled", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }
    @And("^user \"([^\"]*)\" on \"([^\"]*)\" close button in active panel on DatasetPage$")
    public void user_click_on_icon_in_close_button_in_active_panel(String actionType, String elementName)throws Throwable{
    try {sleepForSec(2000);
            new DataSetActions(driver).genericActions(actionType, elementName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Icon is clicked");
        }
        catch (Exception e){
            takeScreenShot("icon is not clicked", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }


    @And("^user \"([^\"]*)\" for the header and other \"([^\"]*)\" under Data tab in Dataset$")
    public void userForTheHeaderAndOtherUnderDataTab(String arg0, String arg1, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            for (CucumberDataSet data : dataTableCollection) {
                String popUpParameter = data.getPopUpParameters();
                new DataSetActions(driver).genericActions(arg0,arg1,popUpParameter);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "labels and values are showing as expected");
        } catch (Exception e) {
            takeScreenShot("Error in displaying labels and values", driver);
            Assert.fail("Error in displaying labels and values");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    //1.2

    @And("^user perform following actions in Dataset Dashboard Page$")
    public void userPerformFollowingActionsInCustomAttributePage(DataTable dataTable) {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                waitForAngularLoad(driver);
                new DataSetActions(driver).dataScienceAndAnalyticsDashboardPage(values.get("Actiontype"), values.get("ActionItem"), values.get("ItemName"), values.get("Section"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action Performed in dataset dashboard Page");
            }
        } catch (Exception e) {
            takeScreenShot("action in item View page is not performed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Custom Attribute page is not performed ");
            Assert.fail("action in item View page is not performed" + e.getMessage());
        }
    }

}

