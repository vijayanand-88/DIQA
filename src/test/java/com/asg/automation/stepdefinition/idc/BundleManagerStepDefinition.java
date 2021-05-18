package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.BundleManagerActions;
import com.asg.automation.pageobjects.idc.BundleManager;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.ItemViewManagement;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.apache.commons.lang3.math.NumberUtils;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.util.*;
import java.util.List;

import static com.asg.automation.utils.PostgresSqlBuilder.getselectedColumnName;

/**
 * Created by Sivanandam.Meiya on 12/22/2017.
 */
public class BundleManagerStepDefinition extends DriverFactory
{
    private JsonRead jsonRead;
    private CommonUtil commonUtil;
    protected DBPostgresUtil db_postgres_util;
    private WebDriver driver;

    @Before("@webtest")
    public void beforeScenario() {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
            jsonRead = new JsonRead();
        }catch (Exception e){
            Assert.fail("Driver not initialized"+e.getMessage());
        }
    }

    @After("@webtest")
    public void close() {
        destroyDriver();

    }

    @And("^user clicks on bundle type \"([^\"]*)\"$")
    public void userClicksOnBundleType(String bundleType) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver,new BundleManager(driver).clickBundleType(bundleType));
            waitForPageLoads(driver,5);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), bundleType + " is expanded");
        } catch (Exception e) {
            takeScreenShot("MLP-4239" + bundleType, driver);
            Assert.fail(bundleType + " is not expanded");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), bundleType + " not expanded");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Given("^user clicks on bundle name \"([^\"]*)\"$")
    public void user_clicks_on_bundle_name(String bundleName) {
        try {
            sleepForSec(2000);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome") || propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                clickOn(driver,new BundleManager(driver).clickBundleName(bundleName));
            }else{
                clickonWebElementwithJavaScript(driver,new BundleManager(driver).clickBundleName(bundleName));
            }
            waitForAngularLoad(driver);
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), bundleName + " is expanded");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName() + bundleName, driver);
            Assert.fail(bundleName + " is not expanded");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), bundleName + " not expanded");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user clicks on sub bundle name \"([^\"]*)\"$")
    public void userClicksOnSubBundleName(String subBundleName) throws Throwable {
        try {
            sleepForSec(1000);
            moveToElement(driver,new BundleManager(driver).getSubBundleName(subBundleName));
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).getSubBundleName(subBundleName));
            waitForAngularLoad(driver);
            sleepForSec(2000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName() + "MLP-4239", subBundleName + " is expanded");
        } catch (Exception e) {
            takeScreenShot("MLP-4239" + subBundleName, driver);
            Assert.fail(subBundleName + " is not expanded");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName()+"MLP-4239", subBundleName + " not expanded");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user clicks on bundle version$")
    public void userClicksOnBundleVersion() throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).getBundleVersion());
            waitForAngularLoad(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "bundleVersion  is displayed");
        } catch (Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            Assert.fail("bundleVersion is not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "bundleVersion is not displayed");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user clicks on plugin name \"([^\"]*)\"$")
    public void userClicksOnPluginName(String pluginName) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver,new BundleManager(driver).getPluginNameDetails(pluginName));
            waitForPageLoads(driver,5);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), pluginName + " is displayed");
        } catch (Exception e) {
            takeScreenShot("MLP-4239" + pluginName, driver);
            Assert.fail(pluginName + " is not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), pluginName + " not displayed");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }


    @Then("^verify the metadata of the plugin \"([^\"]*)\"$")
    public void verify_the_metadata_of_the_plugin(String pluginName,Map<String, String> metaData) throws Throwable {

        // Write code here that turns the phrase above into concrete actions
        try {
            sleepForSec(1000);
            List<String> expectedPluginMetadata = new ArrayList<String>();
            if (!(metaData.get("Description").isEmpty()))
                expectedPluginMetadata.add(metaData.get("Description"));
            if (!(metaData.get("SupportedTechnologies").isEmpty()))
                expectedPluginMetadata.add(metaData.get("SupportedTechnologies"));
            if (!metaData.get("TypeofAnalyzer").isEmpty())
                expectedPluginMetadata.add(metaData.get("TypeofAnalyzer"));
            if (!(metaData.get("SupportedContentTypes").isEmpty()))
                expectedPluginMetadata.add(metaData.get("SupportedContentTypes"));
            if (!(metaData.get("SupportedExtentions").isEmpty()))
                expectedPluginMetadata.add(metaData.get("SupportedExtentions"));
            if (!(metaData.get("IDANoderestrictions").isEmpty()))
                expectedPluginMetadata.add(metaData.get("IDANoderestrictions"));

            List<WebElement> pluginMetadataActual = new BundleManager(driver).getPluginMetadata(pluginName);
            List actualPluginMetadata=convertWebElementListIntoStringList(pluginMetadataActual);
            Assert.assertTrue(CommonUtil.compareLists(actualPluginMetadata,expectedPluginMetadata));
            waitForPageLoads(driver,5);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName()+"MLP-4239", pluginName + " is displayed");
        } catch (Exception e) {
            takeScreenShot("MLP-4239" + pluginName, driver);
            Assert.fail(pluginName + " is not displayed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName()+"MLP-4239", pluginName + " not displayed");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Given("^List of bundles with version should be displayed$")
    public void list_of_bundles_with_version_should_be_displayed(DataTable dataTableCollection) {
        try {
            List<String> criteriaValue = new ArrayList<>();
            List<String> resultList = new ArrayList<>();
            List<String> actualList = new ArrayList<>();
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            db_postgres_util = new DBPostgresUtil();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (WebElement bundleName : new BundleManager(driver).bundlePluginList()) {
                actualList.add(bundleName.getText());
                resultList.retainAll(actualList);
            }

        } catch (Exception e) {
            Assert.fail("Bundle list in UI doesn't match with database bundle list");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Given("^user click on each bundle and validate the bundle size with below db values$")
    public void user_click_on_each_bundle_and_validate_the_bundle_size_with_below_db_values(DataTable dataTableCollection) {
        try {
            List<String> criteriaValue = new ArrayList<>();
            List<String> resultList = new ArrayList<>();
            List<String> uiVersionCount = new ArrayList<>();
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            db_postgres_util = new DBPostgresUtil();
            for (WebElement bundleName : new BundleManager(driver).bundlePluginList()) {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, bundleName);
                criteriaValue.removeAll(criteriaValue);
                uiVersionCount.removeAll(uiVersionCount);
                for (WebElement versionNumber : new BundleManager(driver).bundleVersionCount()) {
                    uiVersionCount.add(getElementText(versionNumber));
                    criteriaValue.add(bundleName.getText());
                    String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                    resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
                    uiVersionCount.retainAll(resultList);
                }
                clickOn(new BundleManager(driver).bundleDetailsCloseButton());
            }
        } catch (Exception e) {
            Assert.fail("Bundle version count UI doesn't match with database bundle list versions");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            {
                db_postgres_util.disConnect();
            }
        }
    }


    @Given("^user validates following \"([^\"]*)\" are displayed by default$")
    public void user_validates_following_are_displayed_by_default(String bundleType) {
        try {
            for (WebElement bundleTypeName : new BundleManager(driver).bundleTypeList()) {
                if (bundleTypeName.getText().equalsIgnoreCase(bundleType)) {
                    LoggerUtil.logLoader_error(this.getClass().getName(), "Bundle Type is present");
                    break;
                }

            }

        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Bundle Type is not present");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Then("^deleted bundle type \"([^\"]*)\" should not be displayed$")
    public void deleted_bundle_type_should_not_be_displayed(String bundleType) {
        try {
                if (traverseListContainsElement(new BundleManager(driver).bundleTypeList(),bundleType)==false) {
                    LoggerUtil.logLoader_error(this.getClass().getName(), "Bundle Type is not present");
                }else{
                    Assert.fail("Bundle Type is  present");
            }

        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);

            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^user clicks on bundle upload button and click browse button$")
    public void user_clicks_on_bundle_upload_button_and_click_browse_button() {
        try {
            clickonWebElementwithJavaScript(driver, new ItemViewManagement(driver).clickBundleUpload());
            clickOn(new ItemViewManagement(driver).clickBundleUploadBrowse());
            //new ItemViewManagement(driver).clickBundleUploadSubmit();
            LoggerUtil.logLoader_info(this.getClass().getName(), "Upload button is clicked");
        } catch (Exception e) {
            takeScreenShot("Upload button is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Upload button is not clicked " + e.getMessage());
        }
    }

    @Given("^user clicks Submit$")
    public void user_upload_bundle_and_click_Submit(String osgiBundle) {
        try {
            Robot robot = new Robot();
            robot.setAutoDelay(1000);
            StringSelection stringSelection = new StringSelection(Constant.OSGI_BUNDLES + osgiBundle);
            Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
            robot.setAutoDelay(1000);
            robot.keyPress(KeyEvent.VK_CONTROL);
            robot.keyPress(KeyEvent.VK_V);
            robot.keyRelease(KeyEvent.VK_CONTROL);
            robot.keyRelease(KeyEvent.VK_V);
            robot.setAutoDelay(1000);
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
            clickOn(new ItemViewManagement(driver).clickBundleUploadSubmit());
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getName(), "OSGI bundle is uploaded");
        } catch (Exception e) {
            takeScreenShot("OSGI bundle is not uploaded", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("OSGI bundle is not uploaded " + e.getMessage());

        }
    }

    @And("^user clicks on submit button in the upload bundle page$")
    public void userClicksOnSubmitButton()  {
        try{
            clickOn(driver,new BundleManager(driver).getSubmitButton());
            waitUntilAngularReady(driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"submit button has been clicked");
        }catch (Exception e) {
            takeScreenShot("submit button has not been clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("submit button has not been clicked" + e.getMessage());
        }
    }

    @Given("^user upload \"([^\"]*)\" bundle$")
    public void user_upload_bundle(String osgiBundle) {
        try {
            Robot robot = new Robot();
            robot.setAutoDelay(1000);
            StringSelection stringSelection = new StringSelection(Constant.OSGI_BUNDLES + osgiBundle);
            Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
            robot.setAutoDelay(1000);
            robot.keyPress(KeyEvent.VK_CONTROL);
            robot.keyPress(KeyEvent.VK_V);

            robot.keyRelease(KeyEvent.VK_CONTROL);
            robot.keyRelease(KeyEvent.VK_V);
            robot.setAutoDelay(1000);
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
            LoggerUtil.logLoader_info(this.getClass().getName(), "OSGI bundle is uploaded");
        } catch (Exception e) {
            takeScreenShot("OSGI bundle is not uploaded", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("OSGI bundle is not uploaded " + e.getMessage());
        }
    }

    @Given("^user delete all the plugin inside bundle$")
    public void user_delete_all_the_plugin_inside_bundle() {
        try {

            for (WebElement pluginName : new BundleManager(driver).bundlePluginList()) {
                sleepForSec(1000);
                clickonWebElementwithJavaScript(driver, pluginName);
                clickonWebElementwithJavaScript(driver, new BundleManager(driver).bundleDetailsDelete());
                clickOn(new DashBoardPage(driver).notificationDismissYes());
                LoggerUtil.logLoader_error(this.getClass().getName(), "Bundle plugins deleted");
            }
        } catch (Exception e) {
            takeScreenShot("OSGI bundle plugins is not deleted", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("OSGI bundle is not deleted " + e.getMessage());
        }


    }

    @Given("^user click on close button in bundle details page$")
    public void user_click_on_close_button_in_bundle_details_page() {
        try {
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).bundleDetailsCloseButton());
            LoggerUtil.logLoader_error(this.getClass().getName(), "Bundle details close button clicked");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getName(), "Bundle details close button not clicked");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        }
    }

    @Given("^user delete the plugin \"([^\"]*)\" in \"([^\"]*)\" bundle$")
    public void user_delete_the_plugin_in_bundle(String pluginName, String bundleName) {
        try {
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).clickBundleName(bundleName));
            for (WebElement pluginNameInBundle : new BundleManager(driver).bundlePluginList()) {
                if (pluginNameInBundle.getText().equals(pluginName)) {
                    clickOn(new BundleManager(driver).clickPluginName(pluginName));
                    clickonWebElementwithJavaScript(driver, new BundleManager(driver).bundleDetailsDelete());
                    LoggerUtil.logLoader_info(this.getClass().getName(), pluginName + " deleted");
                    break;
                }
            }

        } catch (Exception e) {
            Assert.fail(pluginName + "not deleted");
            takeScreenShot(this.getClass().getSimpleName(), driver);
        }
    }

    @Then("^upload plugin \"([^\"]*)\" should be displayed in \"([^\"]*)\" bundle$")
    public void upload_plugin_should_be_displayed_in_bundle(String pluginName, String bundleName) {
        try {
            for (WebElement pluginNameInBundle : new BundleManager(driver).bundlePluginList()) {
                if (pluginNameInBundle.getText().equals(pluginName)) {
                    LoggerUtil.logLoader_info(this.getClass().getName(), pluginName + " is displayed in " + bundleName);
                    break;
                }
            }

        } catch (Exception e) {
            Assert.fail(pluginName + "not added to " + bundleName);
            takeScreenShot(this.getClass().getSimpleName(), driver);

        }
    }

    @Then("^uploaded file size should get displayed in bundle upload page$")
    public void uploaded_file_size_should_get_displayed_in_bundle_upload_page() {
        try {
            waitForPageLoads(driver,5);
            verifyTrue(NumberUtils.isCreatable(new BundleManager(driver).bundleUploadFileSize()));
            LoggerUtil.logLoader_info(this.getClass().getName(), "File Size is displayed");
        }catch (NumberFormatException e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("File Size is not a number");
        }catch(Exception e) {
            takeScreenShot(this.getClass().getSimpleName(), driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("File Size is not displayed");
        }
    }


    @Then("^user verifies Upload button is displayed in Bundle management$")
    public void user_verifies_Upload_button_is_displayed_in_Bundle_Management() {
        try {
            Assert.assertTrue(new BundleManager(driver).getbundleManagementUploadButton().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Upload Bundle button not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @Then("^user verifies Bundle Details panel is displayed$")
    public void user_verifies_Bundle_Details_panel_is_displayed() {
        try {
            waitandFindElement(driver, new BundleManager(driver).getBundleDetailsPanelHeader(), 3, false);
            Assert.assertTrue(new BundleManager(driver).getBundleDetailsPanelHeader().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Deatils Panel not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user verifies Upload Bundle panel is displayed$")
    public void user_verifies_Upload_Bundle_panel_is_displayed() {
        try {
            Assert.assertTrue(new BundleManager(driver).getUploadBundlePanelHeader().isDisplayed());
        } catch (Exception e) {
            takeScreenShot("Bundle Manager description not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^Error message \"([^\"]*)\" should be displayed$")
    public void error_message_should_be_displayed(String errorMessage) {
        try {
            clickOn(new BundleManager(driver).geterrorCloseButton());
            waitForPageLoads(driver,5);
            verifyTrue(errorMessage.equals(getElementText(new BundleManager(driver).getInvalidBundleUploadError()).substring(0, 35)));
        } catch (Exception e) {
            takeScreenShot("Invalid bundle manager error message is displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user compare the plugin count in bundle management and bundle version panel$")
    public void user_compare_the_plugin_count_in_bundle_management_and_bundle_version_panel() {
        try {
            for (WebElement bundleName : new BundleManager(driver).bundlePluginList()) {
                sleepForSec(1000);
                clickOn(bundleName);
                sleepForSec(1000);
                Assert.assertEquals(String.valueOf(new BundleManager(driver).getBundleVersionsPluginCount().size()), getElementText(new BundleManager(driver).getBundleManagementPluginVersionCount()));
                LoggerUtil.logLoader_info(this.getClass().getName(), "Version count in Bundle Management list and Bundle version matches");
                clickOn(new BundleManager(driver).bundleDetailsCloseButton());
                sleepForSec(500);
            }
        } catch (Exception e) {
            takeScreenShot("Invalid bundle manager error message is displayed", driver);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Version count in Bundle Management list and Bundle version is not matched");
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user delete all the plugins in \"([^\"]*)\" bundle type$")
    public void user_delete_all_the_plugins_in_bundle_type(String bundleName) {
        try {

            for (WebElement pluginName : new BundleManager(driver).bundlePluginList()) {
                sleepForSec(1000);
                clickOn(pluginName);
                waitForPageLoads(driver,4);
                clickonWebElementwithJavaScript(driver,new BundleManager(driver).bundleDetailsDelete());
                sleepForSec(1000);
                clickOn(new DashBoardPage(driver).notificationDismissYes());
                sleepForSec(500);
                LoggerUtil.logLoader_error(this.getClass().getName(), "Bundle plugins deleted");

            }
        } catch (Exception e) {
            takeScreenShot("Bundle Manager description not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }


    }

    @Given("^Delete button should not be displayed$")
    public void delete_button_should_not_be_displayed() {
        try {
            if (isElementPresent(new BundleManager(driver).bundleDetailsDelete())) {
                Assert.fail("itemPreviewSection + \" is displayed");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("MLP-2332 Delete button is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Delete button is not present");
        } catch (Exception e) {
            takeScreenShot("MLP-2332 Delete button is displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Delete button is present");
        }
    }

    @Then("^Delete button should be displayed$")
    public void delete_button_should_be_displayed() {
        try {
            if (isElementPresent(new BundleManager(driver).bundleDetailsDelete())) {
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Delete button is  present");
            }
        } catch (NoSuchElementException e) {
            takeScreenShot("MLP-2332 Delete button is not displayed", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Delete button is not displayed");
            Assert.fail("Delete button is not displayed");

        }

    }

    @And("^user clicks on Plugin_management in the Bundle details panel$")
    public void user_clicks_on_Plugin_management_in_Bundle_details_apnel() throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver,new BundleManager(driver).getPluginManagementtButton());
            waitForPageLoads(driver,5);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Plugin management button is clicked under bundle details panel");
        } catch (Exception e) {
            takeScreenShot("Plugin management button is not clicked under bundle details panel", driver);
            Assert.fail("Plugin management button is not clicked under bundle details panel");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Plugin management button is not clicked under bundle details panel");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }




    @And("^user clicks on the bundle version of the jar \"([^\"]*)\" under Bundle details panel$")
    public void user_clicks_on_bundle_version_of_the_jar(String bundle) throws Throwable {
        try {
            sleepForSec(1000);
            clickonWebElementwithJavaScript(driver,new BundleManager(driver).getBundleVersion(bundle));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Bundle version is clicked under bundle details panel");
            sleepForSec(500);
        } catch (Exception e) {
            takeScreenShot("Bundle version is not clicked under bundle details panel", driver);
            Assert.fail("Bundle version is not clicked under bundle details panel");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Bundle version is not clicked under bundle details panel");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user clicks on Download Content in the Bundle version details panel$")
    public void user_clicks_on_Download_content_in_Bundle_version_details_apnel() throws Throwable {
        try {
            clickonWebElementwithJavaScript(driver,new BundleManager(driver).getDownloadContentButton());
            sleepForSec(5000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Download content is clicked under bundle version details panel");
        } catch (Exception e) {
            takeScreenShot("Download content is not clicked under bundle version details panel", driver);
            Assert.fail("Download content is not clicked under bundle version details panel");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Download content is not clicked under bundle version details panel");
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @Then("^user validates the database for \"([^\"]*)\" has following tags in postgres$")
    public void userValidatesTheDatabaseForHasFollowingTagsInPostgres(String pluginName,Map<String, String> expectedTags) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        DBPostgresUtil db_postgres_util = new DBPostgresUtil();
        try {

            String query="SELECT l.schemes FROM \"public\".\"V_Bundle\" l,unnest(plugins) a WHERE a LIKE '%"+ pluginName +"%'";
            if(expectedTags.isEmpty()){
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected tags is displayed");
                Assert.assertEquals(db_postgres_util.get_String_Value(query,"schemes"),"");
            }
            else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected tags is not displayed");
                List<String> expectedPluginMetadata = new ArrayList();

                    if (!(expectedTags.get("DBDescription").isEmpty()))
                        expectedPluginMetadata.add(expectedTags.get("DBDescription"));
                    if (!(expectedTags.get("DBSupportedTechnologies").isEmpty()))
                        expectedPluginMetadata.add(expectedTags.get("DBSupportedTechnologies"));
                    if (!(expectedTags.get("DBTypeofAnalyzer").isEmpty()))
                        expectedPluginMetadata.add(expectedTags.get("DBTypeofAnalyzer"));
                    if (!(expectedTags.get("DBContentTypes").isEmpty()))
                    expectedPluginMetadata.add(expectedTags.get("DBContentTypes"));
                    if (!(expectedTags.get("DBSupportedExtentions").isEmpty()))
                    expectedPluginMetadata.add(expectedTags.get("DBSupportedExtentions"));
                if (!(expectedTags.get("DBIDANoderestrictions").isEmpty()))
                    expectedPluginMetadata.add(expectedTags.get("DBIDANoderestrictions"));


                Collections.sort(expectedPluginMetadata);

                String actualPluginMetadata=db_postgres_util.get_String_Value(query,"schemes");
                for(String s:expectedPluginMetadata){
                    Assert.assertTrue(actualPluginMetadata.contains(s));
                }

            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata got displayed");
        }catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
            Assert.fail("Unable to process the Query: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^user \"([^\"]*)\" of following \"([^\"]*)\" in bundle manager page$")
    public void user_of_following_in_bundle_manager_page(String actionType, String elementName, DataTable data) throws Throwable {
        try {
            List<Map<String, String>> valueList = data.asMaps(String.class,String.class);
            new BundleManagerActions(driver).verifyPresenceOfElement(actionType, elementName, valueList);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value matches with "+ elementName);
        } catch (Exception e) {
            takeScreenShot("MLP-4239", driver);
            Assert.fail("Values from " +elementName+" doesn't match");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values doesn't matches with" + elementName);
            new DashBoardPage(driver).Click_profileLogoutButton();
        }
    }

    @And("^user validate the bundle information for parameters$")
    public void user_validate_the_bundle_information_for_parameters(DataTable data){
      try {
          List<Map<String, String>> hm = data.asMaps(String.class,String.class);
          new BundleManager(driver).bundleManagerDetails(hm);
           } catch (Exception e) {
          takeScreenShot("MLP-4239", driver);
          Assert.fail("Values doesn't match" + e.getMessage());
          LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Values doesn't matches");
          new DashBoardPage(driver).Click_profileLogoutButton();
      }
}
}




