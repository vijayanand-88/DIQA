package com.asg.automation.stepdefinition.ida;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.ida.*;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.skyscreamer.jsonassert.JSONCompareMode;
import org.testng.Assert;

import java.util.*;

import static com.asg.automation.utils.FileUtil.fileCompareLineByLine;
import static com.asg.automation.utils.FileUtil.trimFileContent;
import static com.asg.utils.commonutils.FileUtil.createFileAndWriteData;

public class AnalysisPluginStepDefinition extends DriverFactory {
    private WebDriver driver;
    RepoData repoData;

    @Before("@webtest")
    public void beforeScenario() {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @After("@webtest")
    public void close() {
        destroyDriver();
    }

    @When("^user navigate to analysis tab and open the collector link$")
    public void user_navigate_to_analysis_tab_and_open_the_collector_link() {
        try {
            new AnalysisPage(driver).clickAnalysisWidget();
            Assert.assertTrue(new AnalysisPage(driver).returnAnlysiswidget().isDisplayed());
        } catch (Exception e) {
            new AnalysisPage(driver).clickAnalysisWidget();
            Assert.fail(e.getMessage());
            takeScreenShot("Analysis tab", driver);
        }


    }

    @Given("^user click on the collector analysis link and open the log$")
    public void user_click_on_the_collector_analysis_link_and_open_the_log() {

        try {
            new AnalysisPage(driver).clickAnalysislink();
            takeScreenShot("Analysis link clicked", driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Analysis link is  clicked");
            new AnalysisPage(driver).click_log();
            takeScreenShot("Analysis log clicked", driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Analysis log is  clicked");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            takeScreenShot("Git Collector log", driver);
        }


    }


    @Then("^Analysis widget should be created in dashboard\\.$")
    public void analysis_widget_should_be_created_in_dashboard() {
        try {
            new AnalysisPage(driver).validate_Widget_Addition();
            LoggerUtil.logLoader_info(this.getClass().getName(), "New Analysis Widget Created");
        } catch (Exception e) {
            new AnalysisPage(driver).validate_Widget_Addition();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Source count in log \"([^\"]*)\" should have number of newly created files in repository$")
    public void source_count_in_log_should_have_number_of_newly_created_files_in_repository(String logLine) {
        try {
            waitForAngularLoad(driver);
            String fileCountFromAPI = DataLoader.getDataLoaderInstance().getRepoData().getRepoFileCount().toString();
            LoggerUtil.logLoader_info("No Of Files from Bit Bucket repository", "\n" + fileCountFromAPI);
            for (String actualCollectedCount : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (actualCollectedCount.contains(logLine)) {
                    LoggerUtil.logLoader_info(this.getClass().getName(), actualCollectedCount.substring(7));
                    if (actualCollectedCount.substring(6, 29).replace(",", "").contains(fileCountFromAPI)) {
                        LoggerUtil.logLoader_info(this.getClass().getName(), actualCollectedCount.substring(7));
                    } else {
                        Assert.fail("Expected is " + fileCountFromAPI + " actual is " + actualCollectedCount);
                    }

                }
            }
        } catch (Exception e) {
            takeScreenShot("Git Collector log", driver);
            Assert.fail(e.getMessage());

        }


    }

    @Then("^Source count in log should have number of newly created files in repository$")
    public void source_count_in_log_should_have_number_of_newly_created_files_in_repository() {
        try {
            String newFileName = DataLoader.getDataLoaderInstance().getRepoData().getFiles().toString();
            String uiLogText = new AnalysisPage(driver).logtext();
            verifyContains(newFileName, uiLogText);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            takeScreenShot("Git Collector log", driver);

        }

    }

    @Then("^user validates the deletion count is updated in IDA UI log\\.$")
    public void user_validates_the_deletion_count_is_updated_in_IDA_UI_log() {
        try {
            for (String log : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (log.contains("0014")) {
                    verifyContains(log.substring(54), String.valueOf(DataLoader.getDataLoaderInstance().getRepoData().getFiles()));
                    LoggerUtil.logLoader_info("Log line has", "deleted file name");
                }
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            takeScreenShot("Git Collector log", driver);

        }

    }

    @Then("^user validate Analysis log \"([^\"]*)\" in IDB UI$")
    public void user_validate_Analysis_log_in_IDB_UI(String logText) {
        try {
            for (String uiLog : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (uiLog.contains(logText)) {
                    verifyContains(uiLog.substring(54), DataLoader.getDataLoaderInstance().getRepoData().getFiles().toString());
                    LoggerUtil.logLoader_info(logText, " is displayed in IDB log");
                } else {
                    LoggerUtil.logLoader_info(logText, " is displayed in IDB log");
                }
            }
        } catch (Exception e) {
            Assert.fail("UI Log doesn't have " + logText);
        }
    }

    @When("^User clicks on IDA dashboard$")
    public void user_clicks_on_IDA_dashboard_twice() {
        try {
            new AnalysisPage(driver).click_idadashboard();
            sleepForSec(1000);
            takeScreenShot("IDA Dashboard clicked", driver);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @And("^User clicks on widget name$")
    public void user_clicks_on_widget_name() {
        try {
            new AnalysisPage(driver).click_widgetname();
            sleepForSec(1000);
            takeScreenShot("IDA Dashboard clicked", driver);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }


    @Then("^filepattern count from Bitbucket repository and IDA UI should match \\.$")
    public void filepattern_count_from_Bitbucket_repository_and_IDA_UI_should_match() {
        try {
            String fileExtensionCount = DataLoader.getDataLoaderInstance().getRepoData().getRepoFileCount().toString();

            for (String splitLogText : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (splitLogText.contains("-0012")) {

                    if (splitLogText.substring(6).contains(fileExtensionCount)) {
                        LoggerUtil.logLoader_info("File Pattern Count from Bit Bucket Repository and UI", "are Equal");

                    } else {
                        Assert.fail("File count from BitBucket API and UI Mismatches");
                    }


                }

            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }

    }

    @When("^user clicks on log link and opens the log$")
    public void user_clicks_on_log_link_and_opens_the_log() {
        try {
            new AnalysisPage(driver).click_log();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            takeScreenShot("Collector log", driver);

        }
    }

    @Then("^log file text from index \"([^\"]*)\" should match the expected result$")
    public void log_file_text_from_index_should_match_the_expected_result(int index) throws Throwable {
        try {
            String logText = new AnalysisPage(driver).logtextuse();
            sleepForSec(2000);
            createFileAndWriteData(Constant.PYHTONTEMPLOG, logText);
            trimFileContent(Constant.PYHTONTEMPLOG, Constant.PYTHONLOGACTUALRESULT, index);
            Assert.assertTrue(fileCompareLineByLine(Constant.PYTHONLOGEXPECTEDRESULT, Constant.PYTHONLOGACTUALRESULT));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Python parser log is as expected");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        } finally {
            FileUtil.deleteFile(Constant.PYHTONTEMPLOG);
            FileUtil.deleteFile(Constant.PYTHONLOGACTUALRESULT);
        }
    }

  /*  @Then("^log file text should match the expected result with index$")
    public void log_file_text_should_match_the_expected_result_with_index(DataTable Expected) throws Throwable {
        try {
            for (Map<String, String> values : Expected.asMaps(String.class, String.class)) {
                String index = values.get("index");
                int index1 = Integer.parseInt(index);
                String text = values.get("expected text");
                String logText = new AnalysisPage(driver).getLogsList();
                FileUtil.createFileAndWriteData(Constant.PYHTONTEMPLOG, logText);
                trimFileContent(Constant.PYHTONTEMPLOG, Constant.PYTHONLOGACTUALRESULT, index1);
                int existence = FileUtil.searchContentsofFile(Constant.PYTHONLOGACTUALRESULT, text);
                if (existence != 0) {
                    Assert.assertTrue(true);
                    existence = 1;
                }
                Assert.assertEquals(existence, 1);
                takeScreenShot("Python Parser log", driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Python parser log is as expected");
            }
        } catch (Exception e) {
            takeScreenShot("Python Parser log", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        } finally {
//            FileUtil.deleteFile(Constant.PYHTONTEMPLOG);
//           FileUtil.deleteFile(Constant.PYTHONLOGACTUALRESULT);
        }
    }*/


    @Then("^log file text should match the expected result$")
    public void log_file_text_should_match_the_expected_result(DataTable Expected) throws Throwable {
        try {

            for (Map<String, String> values : Expected.asMaps(String.class, String.class)) {
                String text = values.get("expected text");
                String logText = new AnalysisPage(driver).logtext();
                sleepForSec(2000);
                FileUtil.createFileAndWriteData(Constant.PYHTONTEMPLOG, logText);
                int existence = FileUtil.searchContentsofFile(Constant.PYHTONTEMPLOG, text);
                if (existence != 0) {
                    Assert.assertTrue(true);
                    existence = 0;
                } else {
                    Assert.fail("Log message is not matching with the expected result");
                    takeScreenShot("Log message", driver);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Log message is not matching with the expected result");
                }
            }
        } catch (Exception e) {
            takeScreenShot("Python Parser log", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        } finally {
            // FileUtil.deleteFile(Constant.PYHTONTEMPLOG);
            //FileUtil.deleteFile(Constant.PYTHONLOGEXPECTEDRESULT);
        }
    }

    @Then("^the \"([^\"]*)\" metadata of item \"([^\"]*)\" should be as expected$")
    public void the_metadata_of_item_should_be_as_expected(String property, String itemName) {
        try {
            switch (property) {
                case "Comments":
                    if (itemName.equalsIgnoreCase("FunctionDefinition")) {
                        Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.CLASSCOMMENT);

                    } else if (itemName.equalsIgnoreCase("__init__")) {
                        Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.METHODCOMMENT);
                    }
                    break;
                case "staticVariable":
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.STATICVARIABLEEXPRESULT);
                    break;
                case "superClasses":
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.SUPERCLASSESEXPRESULT);
                    break;
                case "constantStrings":
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.CONSTANTSTRINGSEXPRESULT);
                    break;
                case "rawInvokes":
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.RAWINVOKESEXPRESULT);
                    break;
                case "errorDetails":
                    if (itemName.equalsIgnoreCase("error")) {
                        Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.ERRORDETAILSEXPRESULT);
                    } else if (itemName.equalsIgnoreCase("sample1")) {
                        Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.ERRORDETAILSFORPYTHONEXPRESULT);
                    } else if (itemName.equalsIgnoreCase("InvalidJavaFile")) {
                        Assert.assertEquals(new AnalysisPage(driver).getMetaDataValues(property).getText(), Constant.JAVAPARSER_ERRODETAILS_EXPRESULT);
                    }
                    break;
                //case "content":
                case "Data":
                    if (itemName.equalsIgnoreCase("SubClassWithSuperClass.java")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.JAVAPARSER_SOURCECODE_EXPRESULT);
                    }else if (itemName.equalsIgnoreCase("PythonTestJob1")){
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.GlueCollector_PythonEXPRESULT);
                    }else if (itemName.equalsIgnoreCase("ScalaTestJob1")){
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.GlueCollector_ScalaEXPRESULT);
                    }
                    else if (itemName.equalsIgnoreCase("CreateReplaceView")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEREPLACEVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("CreateViewClass")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEVIEWCLASS);
                    }
                    else if (itemName.equalsIgnoreCase("CreateViewScholarSpecific")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEVIEWSPECIFIC);
                    }
                    else if (itemName.equalsIgnoreCase("SecureView")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.SECUREVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("ForceView")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.FORCEVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("JoinViews")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.JOINVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("EMPLOYEE_HIERARCHY_02")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.RECURSIVEVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("snowflakecsvexttable1view")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.SNOWFLAKEEXTVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("CreateReplaceView")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEREPLACEVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("CreateViewClass")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEVIEWCLASS);
                    }
                    else if (itemName.equalsIgnoreCase("CreateViewScholarSpecific")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEVIEWSPECIFIC);
                    }
                    else if (itemName.equalsIgnoreCase("SecureView")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.SECUREVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("ForceView")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.FORCEVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("JoinViews")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.JOINVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("EMPLOYEE_HIERARCHY_02")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.RECURSIVEVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("snowflakecsvexttable1view")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.SNOWFLAKEEXTVIEW);
                    }
                    else if (itemName.equalsIgnoreCase("DiffDataTypesMinimizedView")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_DiffDataTypesMinimizedView);
                    }else if (itemName.equalsIgnoreCase("customerviewwithjoin")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_customerviewwithjoin);
                   }
                    else if (itemName.equalsIgnoreCase("updatablecityview")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_updatablecityview);
                    }
                    else if (itemName.equalsIgnoreCase("cityviewwithcheckoption")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_cityviewwithcheckoption);
                    }
                    else if (itemName.equalsIgnoreCase("childcityview")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_childcityview);
                    }
                    else if (itemName.equalsIgnoreCase("childcityviewwithlocal")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_childcityviewwithlocal);
                    }
                    else if (itemName.equalsIgnoreCase("materializedviewwithdata")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_materializedviewwithdata);
                    }
                    else if (itemName.equalsIgnoreCase("managertreerecursive")) {
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.PostgressCataloger_managertreerecursive);
                    }
                    else if (itemName.equalsIgnoreCase("createdatabasehivequeryparserdb")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEHIVEDATABASE);
                    }
                    else if (itemName.equalsIgnoreCase("dropdatabasehivequeryparserdb")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.DROPHIVEDATABASE);
                    }
                    else if (itemName.equalsIgnoreCase("select*fromhivequeryparserdb.customers")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.SELECTHIVEDATABASE);
                    }
                    else if (itemName.equalsIgnoreCase("createtablehivequeryparserdb.customers1asselect*fromhivequeryparserdb.customers")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATESELECTFROMTABLE1);
                    }
                    else if (itemName.equalsIgnoreCase("createtablehivequeryparserdb.customers(customer_idint,product_idint,product_namevarchar(60),brand_namevarchar(60))")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATESELECTFROMTABLE2);
                    }
                    else if (itemName.equalsIgnoreCase("insertintohivequeryparserdb.productstore(store_id,product_id,pro_D73989246CD4FDDA17E37902E5E4983")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.INSERTSELECTTABLE);
                    }
                    else if (itemName.equalsIgnoreCase("insertoverwritetablehivequeryparserdb.cust_shop_listselect*fromhivequeryparserdb.customer_shopping_list")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.INSERTOVERWRITETABLE);
                    }
                    else if (itemName.equalsIgnoreCase("insertoverwritedirectory'hivelinker/csv/testcsvfolder'select*fromhivequeryparserdb.customer_shopping_list")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.INSERTOVERWRITEDIRECTORY);
                    }
                    else if (itemName.equalsIgnoreCase("createexternaltableifnotexistshivequeryparserdb.city(idstring,na_7CADA5C483F4D8CACFED042984FE6")){
                        waitForAngularLoad(driver);
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.CREATEEXTERNALTABLE);
                    }


                    else
                        Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.JUNKCHARACTERSEXPRESULT);
                    break;
                case "rawImports":
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.RAWIMPORTSEXPRESULTPARSER);
                    break;
                case "Number of imports":
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, property).getText(), Constant.IMPORTCOUNTEXPRESULT);
                    break;
                case "source":
                    Assert.assertEquals(new AnalysisPage(driver).logtext().trim(), Constant.IMPORTCOUNTEXPRESULT);
                    break;
                default:
                    throw new IllegalArgumentException("Invalid metadata property: " + property);
            }
            takeScreenShot(property + " verified in metadata", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), property + " verified in metadata");
        } catch (Exception e) {
            takeScreenShot(property + " metadata", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on python parser link$")
    public void user_clicks_on_python_parser_link() {
        try {
            new AnalysisPage(driver).clickpythonParserlink();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on python parser link");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on python spark lineage link$")
    public void user_clicks_on_python_spark_lineage_link() {
        try {
            new AnalysisPage(driver).clickpythonSparkLineagelink();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on python parser link");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on python Use Function link$")
    public void user_clicks_on_python_Use_Function_link() {
        try {
            new AnalysisPage(driver).clickpythonUseFunctionlink();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on python parser link");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }


    @Given("^user clicks on python package link$")
    public void user_clicks_on_python_package_link() {
        try {
            new AnalysisPage(driver).clickpythonPackagelink();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on python parser link");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on python import link$")
    public void user_clicks_on_python_import_link() {
        try {
            new AnalysisPage(driver).clickpythonImportlink();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on python parser link");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on python parser link from Analysis facet$")
    public void user_clicks_on_python_parser_link_from_Analysis_facet() {
        try {
            new AnalysisPage(driver).clickpythonParserlinkonAnalysis();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on python parser link");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on git collector link$")
    public void user_clicks_on_git_collector_link() {
        try {
            waitandFindElement(driver, new AnalysisPage(driver).returngitCollectorLink(), 5, false);
            new AnalysisPage(driver).clickgitCollectorLink();
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Collector link is  clicked");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on hdfs collector link$")
    public void user_clicks_on_hdfs_collector_link() {
        try {
            waitandFindElement(driver, new AnalysisPage(driver).returnhdfsCollectorLink(), 5, false);
            new AnalysisPage(driver).clickhdfsCollectorLink();
            LoggerUtil.logLoader_info(this.getClass().getName(), "Collector link is  clicked");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on oracleCataloger analysis link$")
    public void user_clicks_on_oracleCataloger_analysis_link() {
        try {
            waitandFindElement(driver, new AnalysisPage(driver).returnoracleCatalogerLink(), 5, false);
            new AnalysisPage(driver).clickoracleCatalogerLink();
            LoggerUtil.logLoader_info(this.getClass().getName(), "Collector link is  clicked");
        } catch (Exception e) {
            takeScreenShot("Error clicking on python parser link", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on \"([^\"]*)\" item from the processed items$")
    public void user_clicks_on_item_from_the_processed_items(String itemName) {
        try {
            trversePaginationAndClickOnDynamicItem(driver, new AnalysisPage(driver).getprocesseditemsOfparser(), itemName, new SubjectArea(driver).getpaginationNextButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on item" + itemName);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item" + itemName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on \"([^\"]*)\" item from the processed items of git$")
    public void user_clicks_on_item_from_the_processed_items_of_git(String itemName) {
        try {
            new AnalysisPage(driver).clickProcesseditems(itemName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on item" + itemName);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item" + itemName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user clicks on \"([^\"]*)\" item from the files tab list$")
    public void user_clicks_on_item_from_the_files_tab_list(String itemName) {
        try {
            trversePaginationAndClickOnDynamicItem(driver, new AnalysisPage(driver).getfilestab(), itemName, new SubjectArea(driver).getpaginationNextButton());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on item" + itemName);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item" + itemName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^verify the table has item for packagelinker$")
    public void verify_the_table_has_item_for_packagelinker(DataTable data) {

        for (Map<String, String> values : data.asMaps(String.class, String.class)) {
            String hasTableName = values.get("Table");
            String itemName = values.get("item");

            if (new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailable(hasTableName, itemName) != null) {
                try {
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailable(hasTableName, itemName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " has " + itemName);
                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            } else {
                try {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                    waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTablewithdifftagforvalidation(hasTableName, itemName), 3, true);
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTablewithdifftagforvalidation(hasTableName, itemName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " has " + itemName);
                    System.out.println(hasTableName + " has " + itemName);
                    takeScreenShot(hasTableName + " has " + itemName, driver);


                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            }
        }
    }

    @Then("^verify the table has item$")
    public void verify_the_table_has_item(DataTable data) {

        for (Map<String, String> values : data.asMaps(String.class, String.class)) {
            String hasTableName = values.get("Table");
            String itemName = values.get("item");

            if (new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailablediff(hasTableName, itemName) != null) {
                try {
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailablediff(hasTableName, itemName)));
                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            } else {
                try {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                    waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " has " + itemName);
                    takeScreenShot(hasTableName + " has " + itemName, driver);


                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            }
        }
    }

    @Then("^verify the results table has item$")
    public void verify_the_results_table_has_item(DataTable data) {

        for (Map<String, String> values : data.asMaps(String.class, String.class)) {
            String itemName = values.get("item");


            if (new AnalysisPage(driver).getresultsofoperationsifnotavailable(itemName) != null)
                try {

                    waitandFindElement(driver, new AnalysisPage(driver).getresultsofoperationsifnotavailable(itemName), 3, true);
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getresultsofoperationsifnotavailable(itemName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Results has " + itemName);
                    takeScreenShot("Results has " + itemName, driver);
                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            else {
                try {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                    waitandFindElement(driver, new AnalysisPage(driver).getresultsofoperations(itemName), 3, true);
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getresultsofoperations(itemName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " has " + itemName);
                    System.out.println(" has " + itemName);
                    takeScreenShot(" has " + itemName, driver);

                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            }
        }
    }


    @And("^verify the table \"([^\"]*)\" has item \"([^\"]*)\"$")
    public void verify_the_table_has_item(String hasTableName, String itemName) {
        boolean flag = false;
        try {
            waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " has " + itemName);
            takeScreenShot(hasTableName + " has " + itemName, driver);
        } catch (Exception e) {
            takeScreenShot(hasTableName + " has " + itemName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    //    @Then("^user clicks on the operation from results tab single level lineage$")
//    public void user_clicks_on_the_operation_from_results_tab_for_single_level_lineage(DataTable data) {
//        boolean flag = false;
//        for (Map<String, String> values : data.asMaps(String.class, String.class)) {
//            String hasTableName = values.get("Table");
//            String itemName = values.get("item");
//            try {
//                for (int i = 1; 1 <= new AnalysisPage(driver).listofCountofOperations().size(); i++) {
//
//                    if (new AnalysisPage(driver).TraverseontheOperations(i) != null) {
//
//                        //trversePaginationAndClickOnDynamicItem(driver,new AnalysisPage(driver).listofCountofOperations(),new AnalysisPage(driver).TraverseontheOperations(i).getText(),new SubjectArea(driver).getpaginationNextButton());
//                        // WebElement ele = new AnalysisPage(driver).TraverseontheOperations(i);
//                        clickOn(new AnalysisPage(driver).TraverseontheOperations(i));
//                        //System.out.println(new AnalysisPage(driver).getresultsofoperations(LineageHop).getText());
//                        if ((new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailablediff( hasTableName,  itemName)) == null) {
//
//                            clickOn(new AnalysisPage(driver).exitofResultButton());
//
//                        } else {
//
//                            break;
//                        }
//
//
//                    }
//                }
//
//
//                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "RESULTS tablehas " + hasTableName +itemName );
//                takeScreenShot("RESULTS tablehas " + hasTableName +itemName, driver);
//
//            } catch (Exception e) {
//                takeScreenShot("RESULTS tablehas " + hasTableName +itemName, driver);
//                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
//                new DashBoardPage(driver).Click_profileLogoutButton();
//                Assert.fail(e.getMessage());
//            }
//        }
//    }

    @Then("^user clicks \"([^\"]*)\" from results tab for Operation type$")
    public void user_clicks_from_results_tab_for_Operations_type(String hasTableName) {
        boolean flag = false;
        try {
            clickOn(new AnalysisPage(driver).getresultsofoperations(hasTableName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "RESULTS tablehas " + hasTableName);
            takeScreenShot("RESULTS tablehas " + hasTableName, driver);
        } catch (Exception e) {
            takeScreenShot("RESULTS tablehas " + hasTableName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @Then("^verify the table \"([^\"]*)\" does not have item \"([^\"]*)\"$")
    public void verify_the_table_does_not_have_item(String hasTableName, String itemName) {
        try {
            isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName));
        } catch (NoSuchElementException nse) {
            Assert.assertTrue(true);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " does not has " + itemName);
            takeScreenShot(hasTableName + "does not has " + itemName, driver);
        } catch (Exception e) {
            takeScreenShot(hasTableName + " has " + itemName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on item \"([^\"]*)\" in table \"([^\"]*)\"$")
    public void user_clicks_on_item_in_table(String itemName, String hasTableName) {
        try {
            if (!waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, false))
                ;
            {
                waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
            }
            new AnalysisPage(driver).click_dynamicItemFromDynamicHasTable1(hasTableName, itemName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on item " + itemName + "in table " + hasTableName);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item " + itemName + "in table " + hasTableName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user clicks on item \"([^\"]*)\" in table \"([^\"]*)\" from parser$")
    public void user_clicks_on_item_in_table_from_parser(String itemName, String hasTableName) {
        try {
            if (!waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, false))
                ;
            {
                waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
            }
            try {
                new AnalysisPage(driver).click_absoluteDynamicItemFromDynamicHasTable(hasTableName, itemName);
            } catch (NoSuchElementException e) {
                new AnalysisPage(driver).click_dynamicItemFromDynamicHasTable(hasTableName, itemName);
            }
            sleepForSec(1000);
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on item " + itemName + "in table " + hasTableName);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item " + itemName + "in table " + hasTableName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^verify the table \"([^\"]*)\" has item \"([^\"]*)\" if not then the \"([^\"]*)\" metadata of item \"([^\"]*)\" should be as expected$")
    public void verify_the_table_has_item_if_not_then_the_metadata_of_item_should_be_as_expected(String hasTableName, String itemName, String data, String table) {
        if (new AnalysisPage(driver).importsection().getText().contains(hasTableName)) {
            try {
                waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " has " + itemName);
                takeScreenShot(hasTableName + " has " + itemName, driver);


            } catch (Exception e) {
                takeScreenShot(data + " has " + table, driver);
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                new DashBoardPage(driver).Click_profileLogoutButton();
                Assert.fail(e.getMessage());
            }
        } else {
            try {
                Assert.assertEquals(new AnalysisPage(driver).rawimportdata(data, table).getText(), Constant.EXTERNALIMPORT);
            } catch (Exception e) {
                takeScreenShot(hasTableName + " has " + itemName, driver);
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                new DashBoardPage(driver).Click_profileLogoutButton();
                Assert.fail(e.getMessage());
            }
        }

    }

    @Then("^user validate renamed files are marked as deleted in IDB log \"([^\"]*)\"$")
    public void user_validate_renamed_files_are_marked_as_deleted_in_IDB_log(String logLine) {
        List<String> deletedFileList = new ArrayList<>();
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();
        try {
            for (String deletedList : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (deletedList.contains(logLine)) {
                    deletedFileList.add(deletedList.substring(69, 77).trim().replaceAll("/", ""));
                    LoggerUtil.logLoader_info("Renamed Files are marked as Deleted", deletedFileList + " in IDB log");

                }
            }
            Collections.sort(CommonUtil.convertStringListToLowerCase(deletedFileList));
            Collections.sort(CommonUtil.convertStringListToLowerCase(FileUtil.getMultiplefileList()));
            LoggerUtil.logInfo(deletedFileList + " " + FileUtil.getMultiplefileList());
            Assert.assertTrue(deletedFileList.equals(FileUtil.getMultiplefileList()));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(FileUtil.getMultiplefileList() + " not collected in log file");
        }

    }

    @Then("^user validate new file names are marked as collected in IDP log \"([^\"]*)\"\\.$")
    public void user_validate_new_file_names_are_marked_as_collected_in_IDP_log(String logLine) {
        List<String> fileList = new ArrayList<>();
        try {
            for (String reNamedList : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (reNamedList.contains(logLine)) {
                    fileList.add(reNamedList.substring(69, 77).trim().replaceAll("/", ""));
                    LoggerUtil.logInfo("Renamed Files collected in UI Log");

                }
            }
            Collections.sort(CommonUtil.convertStringListToLowerCase(fileList));
            Collections.sort(CommonUtil.convertStringListToLowerCase(FileUtil.getModifiedFileList()));
            LoggerUtil.logInfo(fileList + " " + FileUtil.getModifiedFileList());
            Assert.assertTrue(fileList.equals(FileUtil.getModifiedFileList()));
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Then("^UI Log should collect \"([^\"]*)\" in log line \"([^\"]*)\"$")
    public void ui_Log_should_collect_in_log_line(String fileName, String logLine) {

        try {
            for (String uiLog : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), "ANALYSIS-GIT")) {
                if (uiLog.contains(logLine)) {
                    if (uiLog.substring(68).contains(fileName)) {
                        LoggerUtil.logLoader_info(this.getClass().getName(), "Files for which content changed is collected in UI Log");
                        break;
                    } else {
                        LoggerUtil.logLoader_info("", "Files for which content changed is not collected in UI Log");
                        takeScreenShot("Git Collector log", driver);

                    }

                }

            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Given("^user clicks on type of item \"([^\"]*)\" in table \"([^\"]*)\"$")
    public void user_clicks_on_type_of_item_in_table(String itemName, String hasTableName) throws Throwable {
        try {
            if (!waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, false))
                ;
            {
                waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
            }
            sleepForSec(1000);
            new AnalysisPage(driver).click_dynamicItemTypeFromDynamicHasTable(hasTableName, itemName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicked on item " + itemName + "in table " + hasTableName);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item " + itemName + "in table " + hasTableName, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the below metadata should get displayed for \"([^\"]*)\"$")
    public void the_below_metadata_should_get_displayed_for(String arg1, DataTable arg2) throws Throwable {
        try {
            List<Map<String, String>> metadata = arg2.asMaps(String.class, String.class);
            for (Map<String, String> metadataMap : metadata) {
                for (Map.Entry<String, String> entry : metadataMap.entrySet()) {
                    Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(arg1, entry.getKey()).getText(), entry.getValue());
                }
            }
            takeScreenShot("Clicking on item " + arg1 + "in table " + arg2, driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicking on item " + arg1 + "in table " + arg2);
        } catch (Exception e) {
            takeScreenShot("Error clicking on item " + arg1 + "in table " + arg2, driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        } finally {
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^the below metadata should not get displayed for \"([^\"]*)\"$")
    public void the_below_metadata_should_not_get_displayed_for(String arg1, DataTable arg2) throws Throwable {
        try {
            List<Map<String, String>> metadata = arg2.asMaps(String.class, String.class);
            for (Map<String, String> metadataMap : metadata) {
                for (Map.Entry<String, String> entry : metadataMap.entrySet()) {
                    new AnalysisPage(driver).getdynamicPropertyInMetadata(arg1, entry.getKey()).getText();
                }
            }
            takeScreenShot("Clicking on item " + arg1 + "in table " + arg2, driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Clicking on item " + arg1 + "in table " + arg2);
        } catch (NoSuchElementException e) {
            Assert.assertTrue(true);
            takeScreenShot("Error clicking on item " + arg1 + "in table ", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Clicking on item " + arg1 + "in table " + arg2);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Given("^user validates the Cluster has service \"([^\"]*)\" has DatabaseOrDirectory \"([^\"]*)\" has TableOrFile \"([^\"]*)\" has ColumnsOrFields \"([^\"]*)\" has below metadata$")
    public void user_validates_the_Cluster_has_service_has_DatabaseOrDirectory_has_TableOrFile_has_ColumnsOrFields_has_below_metadata(String service, String DatabaseOrDirectory, String TableOrFile, String ColumnsOrFields, DataTable arg2) throws Throwable {
        DBPostgresUtil db_postgres_util = new DBPostgresUtil();
        String firstQueryValue = null;
        try {
            if (service.equalsIgnoreCase("Hdfs")) {
                firstQueryValue = db_postgres_util.get_String_Value(Constant.firstHdfsQuery, "ID");
            }
            String query = Constant.getHiveOrHdfsQuery(service, DatabaseOrDirectory, TableOrFile, ColumnsOrFields);
            query = query.replace("%%", "%" + firstQueryValue + "%");
            for (Map<String, String> hm : arg2.asMaps(String.class, String.class)) {
                Assert.assertTrue(db_postgres_util.returnQueryasMap(query).entrySet().containsAll(hm.entrySet()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata got displayed");
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }


    @Then("^the following tags \"([^\"]*)\" should get displayed for the column \"([^\"]*)\"$")
    public void the_following_tags_should_get_displayed_for_the_column(String expectedTags, String arg2) throws Throwable {
        try {
            sleepForSec(2000);
            if (expectedTags.isEmpty()) {
                Assert.assertEquals(new SubjectArea(driver).getListOfTagsinSearchResult(arg2).size(), 0);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected Tags  matched with actual tags ");
            } else {
                List<String> actual = new ArrayList<>(getStringListFromElementsList(new SubjectArea(driver).getListOfTagsinSearchResult(arg2)));
                List<String> expected = new ArrayList<>(Arrays.asList(expectedTags.split(",")));
                if (expected.size() <= actual.size()) {
                    for (int i = 0; i < expected.size(); i++) {
                        Iterator<String> e = expected.iterator();
                        if (traverseListContainsString(actual, expected.get(i)) == false) {
                            Assert.fail(expected.get(i) + " is not listed in tags");
                            break;
                        }
                        e.next();
                    }
                }


                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected Tags " + expected + " matched with actual tags " + actual);
            }

        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^user validates the Column \"([^\"]*)\" of table \"([^\"]*)\" has following tags \"([^\"]*)\" in postgres$")
    public void user_validates_the_Column_of_table_has_following_tags_in_postgres(String columnName, String tableName, String expectedTags) throws Throwable {
        DBPostgresUtil db_postgres_util = new DBPostgresUtil();
        try {
            String query = "SELECT \"vtag\".\"name\" from \"MLANALYZER CATALOG\".\"V_Table\" vtable join \"MLANALYZER CATALOG\".\"E_has_Column\" ecolumn on \"vtable\".\"ID\"=\"ecolumn\".\"MLANALYZER CATALOG.Table__O\" join \"MLANALYZER CATALOG\".\"V_Column\" vcolumn on \"ecolumn\".\"MLANALYZER CATALOG.Column__I\"=\"vcolumn\".\"ID\" join \"MLANALYZER CATALOG\".\"E_tag\" etag on \"vcolumn\".\"ID\"=\"etag\".\"MLANALYZER CATALOG.Column__I\" join \"MLANALYZER CATALOG\".\"V_Tag\" vtag on \"vtag\".\"ID\"=\"etag\".\"MLANALYZER CATALOG.Tag__O\" where \"vtable\".\"name\" like '" + tableName + "' and \"vcolumn\".\"name\" like '" + columnName + "';\n";
            if (expectedTags.isEmpty()) {
                Assert.assertEquals(db_postgres_util.returnQueryList(query, "name").size(), 0);
            } else {
                TreeSet<String> actual = new TreeSet<String>(db_postgres_util.returnQueryList(query, "name"));
                TreeSet<String> expected = new TreeSet<String>(Arrays.asList(expectedTags.split(",")));
                Assert.assertEquals(actual, expected);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected Tags  matched with actual tags ");
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^IDC \"([^\"]*)\" log \"([^\"]*)\" count should be \"([^\"]*)\"$")
    public void idc_log_count_should_be(String logName, String logLine, String expectedFilesCount) throws Throwable {
        try {
            for (String splitLogText : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), logName)) {
                if (splitLogText.contains(logLine)) {
                    if (splitLogText.substring(6).contains(expectedFilesCount)) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Pattern Count from Bit Bucket Repository and UI are Equal");

                    } else {
                        Assert.fail("Expected is " + expectedFilesCount + " where actual is " + splitLogText);
                    }
                }
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
        }
    }

    @Then("^IDC \"([^\"]*)\" log \"([^\"]*)\" count and count from BitBucket API should match$")
    public void idc_log_count_and_count_from_BitBucket_API_should_match(String analysisLog, String logLine) throws Throwable {
        try {
            String actualValue = null;
            String expectedFilesCount = DataLoader.getDataLoaderInstance().getRepoData().getRepoFileCount().toString();
            for (String splitLogText : CommonUtil.splittedText(new AnalysisPage(driver).logtext(), analysisLog)) {
                if (splitLogText.contains(logLine)) {
                    actualValue = splitLogText.substring(6, 29);
                    if (actualValue.contains(",")) {
                        actualValue = actualValue.replaceAll(",", "");
                    }
                    if (actualValue.contains(expectedFilesCount)) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Pattern Count from Bit Bucket Repository and UI are Equal");

                    } else {
                        Assert.fail("Expected log is " + expectedFilesCount + " actual is " + actualValue);
                    }
                }
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
            takeScreenShot("Git Collector log", driver);

        }
    }

    @Given("^user click on the \"([^\"]*)\" analysis link$")
    public void user_click_on_the_analysis_link(String analysisName) throws Throwable {
        try {
            sleepForSec(1500);
            new AnalysisPage(driver).clickAnalysisJobLink(analysisName);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Analysis link is  clicked");
        } catch (Exception e) {
            Assert.fail(analysisName + " is not clicked");
            takeScreenShot(analysisName + " is not clicked", driver);
        }
    }


    @Then("^METADATA widget should have following item values$")
    public void metadata_widget_should_have_following_item_values(DataTable metaDataWidgetItemValues) throws
            Throwable {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> item : metaDataWidgetItemValues.asMaps(String.class, String.class)) {
                Assert.assertTrue(new AnalysisPage(driver).metaDataWidgetItemValues(item.get("metaDataItem")).getText().equals(item.get("metaDataItemValue")));
                takeScreenShot("Metadata widget item values are correct", driver);

            }
        } catch (Exception e) {
            Assert.fail("Metadata widget item values are not correct");
            takeScreenShot("Metadata widget item values are not correct", driver);
        }
    }

    @Given("^user click on Analysis log link in DATA widget section$")
    public void user_click_on_Analysis_log_link_in_DATA_widget_section() throws Throwable {
        try {
            sleepForSec(1000);
            new AnalysisPage(driver).click_log();
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Analysis log is  clicked");
        } catch (Exception e) {
            Assert.fail("Analysis Log is not clicked");
            takeScreenShot("Analysis Log is not clicked", driver);
        }
    }

    @Then("^user verifies \"([^\"]*)\" table should have following values$")
    public void user_verifies_table_should_have(String tableName, DataTable processedItems) throws Throwable {
        try {
            List ls = new ArrayList(new AnalysisPage(driver).getProcessedItemsFromTable(tableName));
            int i = 1;
            for (Map<String, String> item : processedItems.asMaps(String.class, String.class)) {
                if (i <= ls.size()) {
                    Assert.assertTrue(new AnalysisPage(driver).processedItemsFileNameRow(item.get("fileName"), tableName).getText().trim().equals(item.get("fileName")));
                    Assert.assertTrue(new AnalysisPage(driver).processedItemsFileTypeRow(item.get("fileType"), tableName).getText().trim().equals(item.get("fileType")));
                    takeScreenShot("FileNames and Type are correct", driver);
//                    i = i + 1;
                } else {
                    Assert.fail("Verify the Table name from feature file = '" + tableName + "' with DOM value");
                }
            }
        } catch (Exception e) {
            takeScreenShot("FileNames and Type are not correct", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("FileNames and Type are not correct");
        }
    }

    //do not add angular wait in this method since we do not involve UI to get the logs
    @Then("^Analysis log \"([^\"]*)\" should display below info/error/warning$")
    public void analysis_log_should_display_below_info_error_warning(String analysisName, DataTable arg1) throws Throwable {
            try {
                String concatUIText = new AnalysisPage(driver).getLogsList(analysisName);
                for (Map<String, String> param : arg1.asMaps(String.class, String.class)) {
                    switch (param.get("type")) {
                        case "ERROR":
                            String rtconcatUIText = concatUIText.replaceAll("\\d{4}-\\d{1,2}-\\d{1,2} \\d{2}:\\d{2}:\\d{2}.\\d{1,9}", "");
                            if (param.get("type").equals("ERROR")) {
                                Assert.assertTrue(rtconcatUIText.contains(param.get("logValue")));
                            }
                            break;

                    case "INFO":
                        String usertext = param.get("logValue").replaceAll(param.get("type"), "");
                        String removeText = param.get("removableText").replaceAll("\\s", "").toLowerCase();
                        String pluginName = param.get("pluginName").replaceAll("\\s", "").toLowerCase();
                        ArrayList<String> uiTextList = new ArrayList<String>();
                        int infocount = 0;
                        for (String uiText : CommonUtil.splittedText(concatUIText, param.get("type"))) {
                            if (uiText.contains(param.get("logCode"))) {
                                uiText = uiText.replaceAll("\n", "").replaceAll(Constant.DATE_TIME_REGEX_TZ_PATTERN, "").replaceAll(Constant.DATE_TIME_REGEX_TZ_PATTERN4, "").replaceAll(Constant.DATE_TIME_REGEX_TZ_PATTERN3, "").toLowerCase();
                                uiTextList.add(uiText);
                            }
                        }
                        String uilistToString = uiTextList.toString();
                        if (uilistToString.contains(param.get("logCode").toLowerCase())) {
                            String uiLog = uilistToString.replaceAll("\n", "").replaceAll(param.get("logCode").toLowerCase(), "").replaceAll(Constant.DATE_TIME_REGEX, "").replaceAll(Constant.TIME_REGEX, "").replaceAll("[^0-9a-zA-Z]", "").replaceAll("\\s", "").toLowerCase();
                            int sent1Count = uiLog.length();
                            String userLog = usertext.replaceAll("\n", "").replaceAll(param.get("logCode"), "").replaceAll(Constant.DATE_TIME_REGEX_TZ_PATTERN, "").replaceAll(Constant.DATE_TIME_REGEX_TZ_PATTERN4, "").replaceAll(Constant.DATE_TIME_REGEX, "").replaceAll(Constant.TIME_REGEX, "").replaceAll(Constant.DATE_TIME_REGEX_TZ_PATTERN3, "").replaceAll("[^0-9a-zA-Z]", "").replaceAll("\\s", "").toLowerCase();
                            int sent2Count = userLog.length();
                            if (removeText.contains("pluginversion") && uiLog.contains(pluginName) && !removeText.isEmpty() && !pluginName.isEmpty()) {
                                uiLog = uiLog.substring(0, uiLog.indexOf(removeText)) + uiLog.substring(uiLog.lastIndexOf("pluginconfiguration"), sent1Count);
                                userLog = userLog.substring(0, userLog.indexOf(removeText)) + userLog.substring(userLog.lastIndexOf("pluginconfiguration"), sent2Count);
                                if (uiLog.contains(userLog)) {
                                    infocount++;
                                }
                            } else if (removeText.contains("emrclusterid") && uiLog.contains(pluginName) && !removeText.isEmpty() && !pluginName.isEmpty()) {
                                uiLog = uiLog.substring(0, uiLog.indexOf(removeText)) + uiLog.substring(uiLog.lastIndexOf("histogrambuckets"), sent1Count);
                                userLog = userLog.substring(0, userLog.indexOf(removeText)) + userLog.substring(userLog.lastIndexOf("histogrambuckets"), sent2Count);
                                if (uiLog.contains(userLog)) {
                                    infocount++;
                                }
                            } else if (removeText.contains("auditfields") && uiLog.contains(pluginName) && !removeText.isEmpty() && !pluginName.isEmpty()) {
                                uiLog = uiLog.substring(0, uiLog.indexOf(removeText)) + uiLog.substring(uiLog.lastIndexOf("catalogname"), sent1Count);
                                userLog = userLog.substring(0, userLog.indexOf(removeText)) + userLog.substring(userLog.lastIndexOf("catalogname"), sent2Count);
                                if (uiLog.contains(userLog)) {
                                    infocount++;
                                }
                            }
                            else if (uiLog.contains(pluginName) && removeText.isEmpty() && !pluginName.isEmpty()) {
                                if (uiLog.contains(userLog)) {
                                    infocount++;
                                }
                            } else if (uiLog.contains(userLog) && removeText.isEmpty() && pluginName.isEmpty()) {
                                infocount++;

                            }
                            if (infocount >= 1 || userLog.equals(uiLog)) {
                                Assert.assertTrue(true);
                            } else {
                                Assert.fail("user text=> " + userLog + " didn't matched with UI Text=> " + uiLog + " for the Anlaysis code=> " + param.get("logCode") + "");
                            }
                        }else {
                            Assert.fail(param.get("logCode")+" is not available in the Logs");
                        }
                        break;
                    case "WARN":
                        Assert.assertTrue(concatUIText.contains(param.get("logCode")));
                        String[] logWarnInformation=CommonUtil.splittedText(concatUIText, param.get("logCode"));
                        for(int i=0;i<logWarnInformation.length;i++){
                            String warnCode = logWarnInformation[i];
                            String[] warnLines = warnCode.split("\n");
                            for (int j=0;j<warnLines.length;j++) {
                                String warnMessage=warnLines[j];
                                if (warnMessage.contains(param.get("logValue"))) {
                                    LoggerUtil.logInfo(warnMessage);
                                    break;
                                } else {
                                    if(j==warnLines.length-1 && i==logWarnInformation.length-1){
                                        Assert.fail(param.get("logValue")+ " is not present in the analysis log");
                                    }
                                    LoggerUtil.logInfo(warnMessage);
                                }
                            }
                        }
                        break;

                    case "HALT":
                            String[] loginformation=CommonUtil.splittedText(concatUIText, param.get("logCode"));
                            for (int i=0;i<loginformation.length;i++) {
                                String haltErrorCode = loginformation[i];
                                Assert.assertTrue(concatUIText.contains(param.get("logCode")));
                                String[] haltErrorLines = haltErrorCode.split("\n");
                                for (int j=0;j<haltErrorLines.length;j++) {
                                    String errorMessage=haltErrorLines[j];
                                    if (errorMessage.contains(param.get("logValue"))) {
                                        LoggerUtil.logInfo(errorMessage);
                                        break;
                                    } else {
                                        if(j==haltErrorLines.length-1 && i==loginformation.length-1){
                                            Assert.fail(param.get("logValue")+ " is not present in the analysis log");
                                        }
                                        LoggerUtil.logInfo(errorMessage);
                                    }
                                }
                            }
                            break;
                }
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Expected log values are not displayed");

        }
    }

        @Then("^user iterate the analysis logs and click on the log from stored text$")
        public void user_iterate_the_analysis_logs_and_click_on_the_log_from_stored_text () throws Throwable {
            List<String> logSearchResults = new ArrayList<>();
            try {

    /*        for (WebElement analysisText : new SubjectArea(driver).itemResultList()) {
                logSearchResults.add(analysisText.getText());
            }
            while (true) {
                for (WebElement analysisText : new SubjectArea(driver).itemResultList()) {
                    logSearchResults.add(analysisText.getText());
                }
                if (traverseListContainsString(logSearchResults, CommonUtil.getText().replace("\\", ""))) {
                    clickOn(new SubjectArea(driver).getItem(CommonUtil.getText().replace("\\", "")));
                    break;
                } else if (new SubjectArea(driver).getpaginationNextButton().isDisplayed()) {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                    sleepForSec(2000);
                }
            }
*/

            List<String> previousPage = new ArrayList<>();
            List<String> currentPage = new ArrayList<>();
            String count = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
            List<WebElement> listValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
            for (WebElement ele : listValue) {
                currentPage.add(ele.getText());
            }
            if (new SubjectArea(driver).scrolListContainsElementAndClick(driver, listValue, CommonUtil.getText().replace("\\", "")) != true) {
                if (Integer.parseInt(count) == currentPage.size()) {
                    Assert.fail("Not able to find the element before scroll ");
                }
                while (true) {
                    List<WebElement> elements = new SubjectArea(driver).getScrollItemList("Preview");
                    previousPage.clear();
                    previousPage.addAll(currentPage);
                    currentPage.clear();
                    scrollDownUsingJS(driver, elements, 1);
                    waitForAngularLoad(driver);
                    if (new SubjectArea(driver).scrolListContainsElementAndClick(driver, listValue, CommonUtil.getText().replace("\\", "")) == true) {
                        break;
                    }
                    for (WebElement ele : new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound()) {
                        currentPage.add(ele.getText());
                    }
                    if (previousPage.equals(currentPage)) {
                        Assert.fail("Failed to find Element");
                    }
                }

            }


        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), CommonUtil.getText() + " link is not clicked");
            e.getMessage();
        }
    }

    @Then("^user clicks on the \"([^\"]*)\" item in \"([^\"]*)\" table$")
    public void user_clicks_on_the_item_in_table(String itemName, String tableName) throws Throwable {
        try {
            new AnalysisPage(driver).processedItemsToClick(tableName, itemName);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "User clicks on" + itemName + "Successfully");
        } catch (Exception e) {
            takeScreenShot("Unable to click on the" + itemName + "in the table", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Unable to click on the item in the table");
        }
    }

    @Then("^the following metadata values should be displayed$")
    public void theFollowingMetadataValuesShouldBeDisplayed(DataTable metaDataValues) {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> items : metaDataValues.asMaps(String.class, String.class)) {
                try {
                    if (!items.containsKey("widgetName")) {
                        Assert.assertEquals(new AnalysisPage(driver).getMetaDataValues(items.get("metaDataAttribute")).getText(), items.get("metaDataValue"));
                        takeScreenShot("Metadata item values are correct", driver);
                    } else {
                        Assert.assertEquals(new AnalysisPage(driver).getMetaDataValuesInItemSection(items.get("metaDataAttribute"), items.get("widgetName")).getText().trim(), items.get("metaDataValue"));
                        takeScreenShot("Metadata item values are correct", driver);
                    }
                }catch (AssertionError e){
                    throw new Exception("Metadata widget item values are not correct for the item "+items.get("metaDataAttribute")+ "  "+e.getMessage());
                }
            }
        } catch (Exception e) {
            takeScreenShot("Metadata item values are not correct for", driver);
            Assert.fail(e.getMessage());
        }


    }


    @Then("^confirm \"([^\"]*)\" window is not available$")
    public void confirmWindowIsNotAvailable(String windowName) {
        try {
            switch (windowName) {
                case "SOURCE TREE":
                    if (new AnalysisPage(driver).getSourceTreeWindNumbers() > 0) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Source Tree window is available");
                    } else
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Source Tree window is not available");
                    break;
                case "uses":
                    if (new AnalysisPage(driver).getUsesWindNumbers() > 2) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Uses window is available");
                    } else
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Uses window is not available");
                    break;
                case "Lineage Hops":
                    if (new AnalysisPage(driver).getLineageHopsWindNumbers() == 0) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Lineage Hops window is not available");
                    } else {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Lineage Hops window is available");
                        Assert.fail("Lineage Hops window is available");
                    }
                    break;
                default:
                    throw new IllegalArgumentException("Invalid WindowName: " + windowName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            takeScreenShot("Searched window: " + windowName + " is available", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @And("^Last linked date displayed is valid$")
    public void lastLinkedDateDisplayedIsValid() {

        try {
            if (new AnalysisPage(driver).verifyLastlinkeddate().isDisplayed()) {
                Assert.assertNotNull(new AnalysisPage(driver).getLastlinkeddate());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Last Linked date attribute is available and is not null");
            }
        } catch (Exception e) {
            e.printStackTrace();
            takeScreenShot("LastLinked date attribute is not available", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }


    }

    @Then("^the following metadata values should be displayed for \"([^\"]*)\" item$")
    public void theFollowingMetadataValuesShouldBeDisplayedForItem(String itemName, DataTable arg3) {

        try {
            for (Map<String, String> data : arg3.asMaps(String.class, String.class)) {
                String metaDataAttribute = data.get("metaDataAttribute");
                String metaDataValue = data.get("metaDataValue");
                Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(itemName, metaDataAttribute).getText(), metaDataValue);
            }
        } catch (Exception e) {
            takeScreenShot("Metadata item values are not correct", driver);
            Assert.fail("Metadata  item values are not correct");
        }

    }

    @And("^user \"([^\"]*)\" of the following items$")
    public void verifyTheMetadataValuesOfTheFollowingItems(String verificationItem, DataTable arg) {

        try {
            switch (verificationItem) {
                case "verify the metadata values":
                    for (Map<String, String> data : arg.asMaps(String.class, String.class)) {
                        String table = data.get("Table");
                        String item = data.get("item");
                        String fileExtension = data.get("FileExtension");
                        String fileName = data.get("FileName");
                        String location = data.get("Location");
                        waitForAngularLoad(driver);
                        waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(table, item), 3, true);
                        new AnalysisPage(driver).click_absoluteDynamicItemFromDynamicHasTable(table, item);
                        waitForAngularLoad(driver);
                        try {
                            Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(item, "File extension").getText(), fileExtension);
                            Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(item, "File name").getText(), fileName);
                            Assert.assertEquals(new AnalysisPage(driver).getdynamicPropertyInMetadata(item, "Location").getText(), location);
                        } catch (Exception e) {
                            takeScreenShot("Metadata item values are not correct", driver);
                            Assert.fail("Metadata  item values are not correct");
                        }
                        waitForAngularLoad(driver);
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
                        waitForAngularLoad(driver);
                    }
                    break;
                default:
                    throw new IllegalArgumentException("Invalid verification item: " + verificationItem);
            }
        } catch (Exception e) {
            takeScreenShot("Metadata validation failed", driver);
            Assert.fail("Metadata validation failed");
        }
    }

    @Given("^user validate the \"([^\"]*)\" for following parameters$")
    public void user_validate_the_for_following_parameters(String action, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> data : dataTable.asMaps(String.class, String.class)) {
                String expFilePath = Constant.REST_PAYLOAD + data.get("expectedJsonFile");
                String actFilePath = Constant.REST_PAYLOAD + data.get("actualJsonFile");
                String expJsonPath = data.get("expectedJsonPath");
                String actJsonPath = data.get("actualJsonPath");
                Assert.assertEquals(JsonRead.getJsonValue(expFilePath, expJsonPath), JsonRead.getJsonValue(actFilePath, actJsonPath));

            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Expected values doesn't match with actual values");
        }
    }

    @Given("^user validates \"([^\"]*)\" with \"([^\"]*)\" for \"([^\"]*)\" using \"([^\"]*)\" and \"([^\"]*)\"$")
    public void user_validates_with_for_using_and(String expectedValues, String actualValues, String valueType, String expectedJsonPath, String actualJsonPath) throws Throwable {
        try {
            String expFilePath = Constant.REST_DIR + expectedValues;
            String actFilePath = Constant.REST_DIR + actualValues;
            switch (valueType) {
                case "stringCompare":
                    CommonUtil.jsonAssertTwoJSONFiles(expFilePath, expFilePath);
//                    Assert.assertEquals(JsonRead.getJsonValue(expFilePath, expFilePath), JsonRead.getJsonValue(actFilePath, actualJsonPath));
                    break;
                case "intCompare":
                    Assert.assertEquals(JsonRead.getJsonValueAsInteger(expFilePath, expectedJsonPath), JsonRead.getJsonValueAsInteger(actFilePath, actualJsonPath));
                    break;
                case "stringListCompare":
                    Assert.assertEquals(JsonRead.getJsonValueAsList(expFilePath, expectedJsonPath), JsonRead.getJsonValueAsList(actFilePath, actualJsonPath));
                    break;
                case "intListCompare":
                    Assert.assertEquals(JsonRead.returnIntegerList(expFilePath, expectedJsonPath), JsonRead.returnIntegerList(actFilePath, actualJsonPath));
                    break;
                case "stringNonPresence":
                    verifyNotEquals(JsonRead.getJsonValue(expFilePath, expectedJsonPath), JsonRead.getJsonValue(actFilePath, actualJsonPath));
                    break;
            }

        } catch (Exception e) {
            Assert.fail(valueType + " are not equal");
        }
    }


    @Then("^verify the table Files/Processed Items has below values$")
    public void verify_the_table_Files_Processed_Items_has_below_values(DataTable data) {

        for (Map<String, String> values : data.asMaps(String.class, String.class)) {
            String hasTableName = values.get("Table");
            String itemName = values.get("value");
            waitForAngularLoad(driver);
            if (new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailablediff(hasTableName, itemName) != null) {
                try {
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTableifnotavailablediff(hasTableName, itemName)));
                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            } else {
                try {
                    clickOn(new SubjectArea(driver).getpaginationNextButton());
                    waitandFindElement(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName), 3, true);
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(hasTableName, itemName)));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hasTableName + " has " + itemName);
                    takeScreenShot(hasTableName + " has " + itemName, driver);


                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    Assert.fail(e.getMessage());
                }
            }
        }
    }

    @Then("^user verifies the class \"([^\"]*)\" for the function \"([^\"]*)\"$")
    public void user_verifies_the_class_for_the_function(String className, String functionName) {
        try {
            waitForAngularLoad(driver);
            if (isElementPresent(new AnalysisPage(driver).getClassNameOfFunction(functionName))) {
                try {
                    Assert.assertTrue(new AnalysisPage(driver).getClassNameOfFunction(functionName).getText().equals(className));
                } catch (Exception e) {
                    takeScreenShot(this.getClass().getSimpleName(), driver);
                    LoggerUtil.logLoader_error(this.getClass().getName(), "The class name of the function is not matching");
                    Assert.fail("The class name of the function is not matching");
                }
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^the following field/column should have the specified sequence number$")
    public void theFollowingFieldColumnShouldHaveTheSpecifiedSequenceNumber(DataTable seqValues) throws Throwable {
        try {
            waitForAngularLoad(driver);
            for (Map<String, String> items : seqValues.asMaps(String.class, String.class)) {
                try {
                    Assert.assertEquals(new AnalysisPage(driver).getSequenceNumberFromDynamicHasTable(items.get("dynamicTable"), items.get("itemName")).getText(), items.get("sequenceNumber"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Sequence numbers are correct ");
                    takeScreenShot("Sequence numbers are correct ", driver);
                }catch (AssertionError e){
                    takeScreenShot("Sequence numbers are not correct ", driver);
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    throw new Exception("Sequence numbers are not correct for the item "+items.get("itemName")+ "  "+e.getMessage());
                }
            }
        } catch (Exception e) {
            takeScreenShot("Sequence numbers are not correct ", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^the following tags \"([^\"]*)\" should not get displayed for the column \"([^\"]*)\"$")
    public void the_following_tags_should_not_get_displayed_for_the_column(String expectedTags, String arg2) throws Throwable {
        try {
            sleepForSec(2000);
            if (expectedTags.isEmpty()) {
                Assert.assertEquals(new SubjectArea(driver).getListOfTagsinSearchResult(arg2).size(), 0);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected Tags  matched with actual tags ");
            } else {
                List<String> actual = new ArrayList<>(getStringListFromElementsList(new SubjectArea(driver).getListOfTagsinSearchResult(arg2)));
                List<String> expected = new ArrayList<>(Arrays.asList(expectedTags.split(",")));
                if (expected.size() <= actual.size()) {
                    for (int i = 0; i < expected.size(); i++) {
                        Iterator<String> e = expected.iterator();
                        if (traverseListContainsString(actual, expected.get(i)) == true) {
                            Assert.fail(expected.get(i) + " is listed in tags");
                            break;
                        }
                        e.next();
                    }
                }


                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected Tags " + expected + " matched with actual tags " + actual);
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Unable to process the Query:  " + e.getMessage());
        }
    }

    @Given("^Verify Analysis log \"([^\"]*)\" info/error/warning for below parameters$")
    public void verify_Analysis_log_info_error_warning_for_below_parameters(String analysisName, DataTable dataTable) throws Throwable {
        try {
            String concatUIText = new AnalysisPage(driver).getLogsList(analysisName);
            for (Map<String, String> param : dataTable.asMaps(String.class, String.class)) {
                String type = param.get("type");
                String logCode = param.get("code");
                String assertion = param.get("assertion");
                String logMessage = param.get("logMessage");
                switch (assertion) {
                    case "should contain":
                        String[] logs = concatUIText.split("\n");
                        String actual = null;
                        for (String lineText : logs) {
                            if (lineText.contains(logCode)) {
                                actual = lineText.substring(lineText.lastIndexOf(logCode));
                            }
                        }
                        Assert.assertTrue(concatUIText.contains(logMessage));
                        LoggerUtil.logInfo("Expected : " + logMessage + "actual : " + actual.trim());
                        Assert.assertTrue(actual.trim().equals(logMessage));
                        break;
                    case "should not contain":
                        LoggerUtil.logInfo("log text contains "+logMessage);
                        Assert.assertFalse(concatUIText.contains(logMessage));
                        break;
                }
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Expected log values are not displayed");

        }
    }

    @And("^Import log \"([^\"]*)\" should display below info/error/warning$")
    public void importLogShouldDisplayBelowInfoErrorWarning(String Importname, DataTable arg1) throws Throwable {
        try {
            String concatUIText = new AnalysisPage(driver).getLogsImportList(Importname);
            for (Map<String, String> param : arg1.asMaps(String.class, String.class)) {
                switch (param.get("type")){
                    case "ERROR":
                        String rtconcatUIText = concatUIText.replaceAll("\\d{4}-\\d{1,2}-\\d{1,2} \\d{2}:\\d{2}:\\d{2}.\\d{1,9}", "");
                        if (param.get("type").equals("ERROR")) {
                            Assert.assertTrue(rtconcatUIText.contains(param.get("logValue")));
                        }
                        break;
                    case "INFO":
                        String rtconcatUItext = concatUIText.replaceAll("\\d{4}-\\d{1,2}-\\d{1,2} \\d{2}:\\d{2}:\\d{2}.\\d{1,9}", "");
                        if (param.get("type").equals("INFO")) {
                            Assert.assertTrue(rtconcatUItext.contains(param.get("logValue")));
                        }
                        break;

                }
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Expected log values are not displayed");

        }
    }

}



