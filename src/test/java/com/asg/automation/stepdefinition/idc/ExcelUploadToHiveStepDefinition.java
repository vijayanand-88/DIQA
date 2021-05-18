package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.ExcelUpload;
import com.asg.automation.utils.*;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.Assert;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.net.InetAddress;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.asg.automation.utils.Constant.DOWNLOAD_FILE_PATH;
import static org.apache.sis.util.resources.Vocabulary.Keys.Directory;

public class ExcelUploadToHiveStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;
    private CommonUtil commonUtil;
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
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @After("@webtest")
    public void close() throws Exception {
        //new DriverFactory(BrowserName).destroyDriver();
        destroyDriver();

    }

    @Given("^user clicks on Excel Upload Manager in Administration dashboard$")
    public void user_clicks_on_Excel_Upload_Manager_in_Administration_dashboard() throws Throwable {
        try {
            new ExcelUpload(driver).clickExcelUploadManager();
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Excel Upload Manager in Admin dashboard is clicked");
        } catch (Exception e) {
            takeScreenShot("Excel Upload Manager in Admin dashboard is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Excel Upload Manager in Admin dashboard is not clicked" + e.getMessage());
        }
    }


    @And("^user clicks Upload Excel File button$")
    public void userClicksUploadExcelFileButton() throws Throwable {
        try{
            clickonWebElementwithJavaScript(driver,new ExcelUpload(driver).returnUploadExcel());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Button Upload Excel has been clicked");
            sleepForSec(2000);
        }catch (Exception e){
            takeScreenShot("button is not found ",driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("button is not found:" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "button Upload Excel is not found: ");
        }
    }

    @And("^user clicks on browse button$")
    public void userClicksOnBrowseButton()  {
        try{
            isElementPresent(new ExcelUpload(driver).returnBrowseButton());
            clickOn(new ExcelUpload(driver).returnBrowseButton());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Browse Button has been clicked");
        }catch (Exception e){
            takeScreenShot("broswse button is not found ",driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("browse button is not found:" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "browse button is not found");
        }
    }

    @And("^user upload \"([^\"]*)\" file$")
    public void UserUploadFile(String fileName) throws Throwable {
            String dir = System.getProperty("user.dir");
        try {
            Robot robot = new Robot();
            robot.setAutoDelay(1000);
            StringSelection stringSelection = new StringSelection(dir+Constant.EXCEL_UPLOAD_PATH + fileName);
            Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
            robot.setAutoDelay(1000);
            robot.keyPress(KeyEvent.VK_CONTROL);
            robot.keyPress(KeyEvent.VK_V);
            robot.keyRelease(KeyEvent.VK_CONTROL);
            robot.keyRelease(KeyEvent.VK_V);
            robot.setAutoDelay(1000);
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
            LoggerUtil.logLoader_info(this.getClass().getName(), "Excel file has been choosen");
        } catch (Exception e) {
            takeScreenShot("Excel file could not be chosen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Excel file could not be chosen" + e.getMessage());
        }
    }

    @And("^user clicks on \"([^\"]*)\" and choose \"([^\"]*)\"$")
    public void userClicksOnAndChoose(String labelName, String elementTobeChosen) {
        try{
            clickOn(new ExcelUpload(driver).returnDropDownFromExcelUpload(labelName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"labelName :" +labelName+"has been clicked");
            clickOn(new ExcelUpload(driver).returnDropDownElement(elementTobeChosen));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Element :" +elementTobeChosen+"is chose");
        }catch (Exception e){
            takeScreenShot("Catalog or Cluster element could not be chosen", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("catalog or cluster element could not be chosen" + e.getMessage());
        }
    }

    @And("^user enters \"([^\"]*)\" name as \"([^\"]*)\"$")
    public void userEntersNameAs(String labelName, String inputParam) throws Throwable {
        try{
            clearTextWithJavaScript(driver, new ExcelUpload(driver).returnTextBoxElements(labelName));
            enterText(new ExcelUpload(driver).returnTextBoxElements(labelName),inputParam);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),labelName+" has been entered as :" +inputParam);
            enterText(new ExcelUpload(driver).returnTextBoxElements(labelName),inputParam);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),labelName+" has been entered as :" +inputParam);
        }catch (Exception e){
            takeScreenShot(labelName+" has not been entered", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(labelName+" has not been entered" + e.getMessage());
        }
    }

    @And("^user clicks on submit button$")
    public void userClicksOnSubmitButton()  {
       try{
           clickOn(new ExcelUpload(driver).returnExcelUploadSubmit());
           LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"submit button has been clicked");
       }catch (Exception e) {
           takeScreenShot("submit button has not been clicked", driver);
           new DashBoardPage(driver).Click_profileLogoutButton();
           LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
           Assert.fail("submit button has not been clicked" + e.getMessage());
       }
    }

    @Then("^user should be able to see upload data of \"([^\"]*)\"$")
    public void userShouldBeAbleToSeeUploadDataOf(String fileName) throws Throwable {
     try{

         waitForAngularLoad(driver);
         if(new ExcelUpload(driver).returnUploadDataList(fileName).get(0).isDisplayed()){
             LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Upload data for "+fileName+" is present");
         }else {
             new ExcelUpload(driver).click_paginationNextButton();
         }
         isElementPresent(new ExcelUpload(driver).returnUploadData(fileName));
         LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Upload data for "+fileName+" is present");
         sleepForSec(5000);
     }catch(Exception e) {
         takeScreenShot("Upload data for "+fileName+ "is not found", driver);
         new DashBoardPage(driver).Click_profileLogoutButton();
         LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
         Assert.fail("Upload data for "+fileName+ "is not found" + e.getMessage());
     }
    }

    @And("^user checks the existence of Hive table through JDBC$")
    public void userChecksTheExistenceOfHiveTableThroughJDBC(DataTable dataTable) {
        List<CucumberDataSet> queries = dataTable.asList(CucumberDataSet.class);
        String hiveQuery = null;
        int rowCount = 0;
        try {
            for (CucumberDataSet query : queries) {
                hiveQuery = new JsonRead().readJSon("ExcelUpload", query.getQueryList());
                if (new HiveJdbc().checkTableRowsCountPresentInHive(hiveQuery) > 1)
                {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table " + query.getQueryList() + "is found " +
                            "in Hive");
                }else{
                    Assert.fail("Table " + query.getQueryList() + "is not found in Hive");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Table "+query.getQueryList()+ "is not found in the Hive ");
                }
            }
        } catch (SQLException e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed" +e.getMessage());
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed");
        }

    }

//    @And("^columns and its datatype should match for \"([^\"]*)\" table$")
//    public void columnsAndItsDatatypeShouldMatchForTable(String tableName, DataTable data) {
//        List<Map<String, String>> hiveTable = data.asMaps(String.class, String.class);
//        String hiveQuery = null;
//        try {
//            hiveQuery = new JsonRead().readJSon("ExcelUpload", tableName);
//            Map<String, String> map = new HiveJdbc().returnHiveTableDescToMap(hiveQuery);
//            Assert.assertEquals(hiveTable.get(0), map);
//            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table description is matching as expected");
//        } catch (Exception e) {
//            takeScreenShot("Upload data for "+tableName+ "is not found", driver);
//            new DashBoardPage(driver).Click_profileLogoutButton();
//            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed");
//        }
//    }

    @When("^user checks the existence of Hive table through JDBC and verify that row count is (\\d+)$")
    public void userChecksTheExistenceOfHiveTableThroughJDBCAndVerifyThatRowCountIs(int rowCount, DataTable dataTable) throws Throwable {
        List<CucumberDataSet> queries = dataTable.asList(CucumberDataSet.class);
        String hiveQuery = null;
        try {
            for (CucumberDataSet query : queries) {
                hiveQuery = new JsonRead().readJSon("ExcelUpload", query.getQueryList());
                if (new HiveJdbc().checkTableRowsCountPresentInHive(hiveQuery) == rowCount)
                {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table " + query.getQueryList() + "is found " +
                            "in Hive");
                }else{
                    Assert.fail("Table " + query.getQueryList() + "is not found in Hive ");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Table "+query.getQueryList()+ "is not found in the Hive ");
                }
            }
        } catch (SQLException e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed" +e.getMessage());
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed");
        }

    }

    @Then("^user should be still seeing panel \"([^\"]*)\"$")
    public void userShouldBeStillSeeingPanel(String panelName)  {
        try{
            isElementPresent(new ExcelUpload(driver).returnPanelName(panelName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Panel : " +panelName+ " is visible to the user");
        }catch (Exception e){
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Panel : " +panelName+ " is not visible to the user "+e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Panel : " +panelName+ " is not visible to the user");
            }
    }

    @And("^user checks the allow existing table update$")
    public void userChecksTheAllowExistingTableUpdate()  {
       try{
           clickonWebElementwithJavaScript(driver,new ExcelUpload(driver).returnallowUpdateCheckBox());
           LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Allow update check box has been checked");
       }catch (Exception e){
           new DashBoardPage(driver).Click_profileLogoutButton();
           Assert.fail("Allow update check box is not clicked " +e.getMessage());
           LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Allow update check box has not been clicked");
       }
    }

    @Then("^user should be seeing the alert message \"([^\"]*)\"$")
    public void userShouldBeSeeingTheAlertMessage(String alertMsg) {
        try{
            isElementPresent(new ExcelUpload(driver).returnAlertMessage());
            Assert.assertEquals(alertMsg,new ExcelUpload(driver).returnAlertMessage().getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Alert is present and message is showing to the user");
        }catch (Exception e){
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Alert is not present and upload is successful "+e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Alert is not present and upload is successful");
        }
    }

    @Then("^user should be seeing \"([^\"]*)\" as mandatory field$")
    public void userShouldBeSeeingAsMandatoryField(String labelName) {
        try {
            isElementPresent(new ExcelUpload(driver).returnAlertDropDownElement(labelName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is showing as mandatory field");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not showing as mandatory field "+e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not showing as mandatory field");
        }
    }

    @And("^user should be seeing \"([^\"]*)\" as a mandatory field$")
    public void userShouldBeSeeingAsAMandatoryField(String labelName) throws Throwable {
        try {
            isElementPresent(new ExcelUpload(driver).returnAlertTextBoxElements(labelName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), labelName + " is showing as mandatory field");
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(labelName + " is not showing as mandatory field " +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), labelName + " is not showing as mandatory field");
        }
    }

    @And("^user clicks on upload data \"([^\"]*)\"$")
    public void userClicksOnUploadData(String uploadData)  {
       try{
           clickOn(new ExcelUpload(driver).returnUploadData(uploadData));
           LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"upload data for "+uploadData+ "is showing'");
       }catch (Exception e){
           new DashBoardPage(driver).Click_profileLogoutButton();
           Assert.fail("Upload Data "+uploadData + " is not able to clicked " +e.getMessage());
           LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Upload Data "+uploadData + " is not able to clicked");
       }
    }

    @Then("^user should be seeing the \"([^\"]*)\" as \"([^\"]*)\"$")
    public void userShouldBeSeeingTheAs(String prop, String value) {
        Map<String, String> uploadData = new HashMap<>();
        try {
            for (int i = 0; i < new ExcelUpload(driver).returnPropName().size(); i++) {
                uploadData.put(new ExcelUpload(driver).returnPropName().get(i).getText(),
                        new ExcelUpload(driver).returnPropValue().get(i).getText());
            }
            Assert.assertEquals(value, uploadData.get(prop));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Upload Data for " + prop + " is showing as " + value);
        } catch (Exception e) {
            takeScreenShot("User could not be seeing upload data", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Upload Data is not found " +e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Upload Data for " + prop + " is not showing as " + value);
        }
    }

    @And("^user should see the widget \"([^\"]*)\"$")
    public void userShouldSeeTheWidget(String widgetName)  {
        try{
            isElementPresent(new DashBoardPage(driver).clickDashBoardWidget(widgetName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),widgetName + " is available");
        }catch (Exception e){
            new DashBoardPage(driver).Click_profileLogoutButton();
            takeScreenShot(widgetName+" is not present", driver);
            Assert.fail(widgetName + " is not present");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),widgetName + " is not present" +e.getMessage());
        }
    }

    @And("^user verifies the upload data for \"([^\"]*)\" file$")
    public void userVerifiesTheUploadDataForFile(String fileName, DataTable dataTable)  {
        Map<String, String> uploadData = new HashMap<>();
       List<Map<String, String>> uplData = dataTable.asMaps(String.class, String.class);
        try {
            sleepForSec(10000);
            String name = InetAddress.getLocalHost().getCanonicalHostName();
            String id = "BigData.UploadData:::"+CommonUtil.getText();
            //.getCanonicalHostName()
            Map<String, String> mapWithUpdatedHostName = new HashMap<>();
            for(Map.Entry<String,String> test:uplData.get(0).entrySet()){
                mapWithUpdatedHostName.put(test.getKey(),test.getValue());
            }
            mapWithUpdatedHostName.put("Host name",name);
            mapWithUpdatedHostName.put("ID",id);

            //actionClick(driver,new ExcelUpload(driver).returnUploadData(fileName));
            clickonWebElementwithJavaScript(driver,new ExcelUpload(driver).returnUploadData(fileName));
            for (int i = 0; i < new ExcelUpload(driver).returnPropName().size(); i++) {
                    uploadData.put(new ExcelUpload(driver).returnPropName().get(i).getText(),
                            new ExcelUpload(driver).returnPropValue().get(i).getText());
                }

        Assert.assertEquals(uploadData, mapWithUpdatedHostName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Upload is showing as expected");

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Upload Data is mismatching or file is not uploaded " +e.getMessage());
            takeScreenShot("Upload Data is mismatching or file is not uploaded", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Upload Data is mismatching or file is not uploaded");
        }
    }

    @Given("^user creates a new database \"([^\"]*)\"$")
    public void whenUserCreatesANewDatabase(String databaseQueryName)  {
        String hiveQuery = null;
        try {
            hiveQuery = new JsonRead().readJSon("ExcelUpload", databaseQueryName);
            new HiveJdbc().runHiveQuery(hiveQuery);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Hive query is completed and database has been created");
      }catch (Exception e){
            new DashBoardPage(driver).Click_profileLogoutButton();
          Assert.fail("Database could not be created");
          takeScreenShot("Database could not be created", driver);
          LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Database could not be created " +e.getMessage());
      }
    }

    @Given("^update the upload Hive config to use target host from file \"([^\"]*)\"$")
    public void updateTheUploadHiveConfigToUseTargetHostFromFile(String fileName) throws Throwable {
       try{
           FileUtil.replaceSpecficString("\\d{2}+.+\\d{2}+.+\\d{1}+.+\\d{3}",propLoader.prop.getProperty("sftpServerHostname")+":10000",Constant.REST_PAYLOAD+fileName);
           LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"host name: sandbox.hortonworks.com has been " +
                   "replaced with : " +propLoader.prop.getProperty("sftpServerHostname"));
       }catch (Exception e){
          Assert.fail("Hive host could not be updated");
           takeScreenShot("Hive host could not be updated", driver);
          LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Hive host could not be updated " +e.getMessage());
       }
    }

    @And("^inedx (\\d+) columns and its index (\\d+) datatype should match for \"([^\"]*)\" table$")
    public void inedxColumnsAndItsIndexDatatypeShouldMatchForTable(int indexOne, int indexTwo, String tableName, DataTable data) throws Throwable {
        List<Map<String, String>> hiveTable = data.asMaps(String.class, String.class);
        String hiveQuery = null;
        try {
            hiveQuery = new JsonRead().readJSon("ExcelUpload", tableName);
            Map<String, String> map = new HiveJdbc().returnHiveTableDescToMap(hiveQuery,indexOne,indexTwo);
            Assert.assertEquals(hiveTable.get(0), map);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table description is matching as expected");
        } catch (Exception e) {
            takeScreenShot("Upload data for "+tableName+ "is not found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed");
        }
    }


    @And("^user should see the following tables in \"([^\"]*)\" database in col (\\d+)$")
    public void userShouldSeeTheFollowingTablesInDatabaseInCol(String tableName, int colIndex,DataTable data)  {
        List<String> tableList = data.asList(String.class);
        String hiveQuery=null;
        try{
            hiveQuery = new JsonRead().readJSon("ExcelUpload", tableName);
            List<String> tableQueryList = new HiveJdbc().returnHiveQueryValuesToList(hiveQuery,colIndex);
            Assert.assertEquals(tableList.size(),tableQueryList.size());
            CommonUtil.compareLists(tableList,tableQueryList);
        }catch (Exception e){
            takeScreenShot(tableName+ "is not found", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Query could not be executed");
        }
    }

    @And("^user upload file$")
    public void userUploadFile(DataTable tablefields) {
        RobotClassUtil robotClassWrapper;
        try {
            new RobotClassUtil().robotClassOperation(tablefields);
        } catch (Exception e) {
            LoggerUtil.log.info("RobotClass Exception" + e.getMessage());
        }
    }

    @And("^user Download file$")
    public void userDownloadFile(DataTable tablefields) {
        RobotClassUtil robotClassWrapper;
        try {
            new RobotClassUtil().robotClassOperation(tablefields);
        } catch (Exception e) {
            LoggerUtil.log.info("RobotClass Exception" + e.getMessage());
        }

    }

    @And("^user verifies excel values of filenames \"([^\"]*)\" and \"([^\"]*)\" sheetnumbers \"([^\"]*)\" and \"([^\"]*)\" and compare \"([^\"]*)\"$")
    public void userVerifiesExcelValuesOfFilenamesAndSheetnumbersAndAndCompare(String uploadPathfilename, String downloadPathfilename, String uploadPathsheetname, String downloadPathsheetname, String action) throws Throwable {
        waitForAngularLoad(driver);
        List<String> Upload = new ArrayList<>();
        List<String> Download = new ArrayList<>();
        try {
            String dir = System.getProperty("user.dir");
            FileInputStream fisupload = new FileInputStream(new File(dir+Constant.EXCEL_UPLOAD_PATH+ uploadPathfilename));
            FileInputStream fisdownload = new FileInputStream(new File(Constant.LocalDownload  + downloadPathfilename));
            XSSFRow row;
            XSSFCell cell;
            String fileExtensionName = uploadPathfilename.substring(uploadPathfilename.indexOf("."));
            String fileExtensionName1 = downloadPathfilename.substring(downloadPathfilename.indexOf("."));
            if (fileExtensionName.equals(".xlsx") && fileExtensionName1.equals(".xlsx") ) {
                XSSFWorkbook Book = new XSSFWorkbook(fisupload);
                XSSFSheet Sheet = Book.getSheet(uploadPathsheetname);
                int RowCount = Sheet.getLastRowNum();
                for (int i = 1; i < RowCount + 1; i++) {
                    row = Sheet.getRow(i);
                    for (int j = 1; j < row.getPhysicalNumberOfCells(); j++) {
                        cell = row.getCell(j);
                        Upload.add(cell.getStringCellValue());
                    }
                }
                XSSFWorkbook Book1 = new XSSFWorkbook(fisdownload);
                XSSFSheet Sheet1 = Book1.getSheet(downloadPathsheetname);
                int RowCount1 = Sheet1.getLastRowNum();
                for (int i = 1; i < RowCount1 + 1; i++) {
                    row = Sheet1.getRow(i);
                    for (int j = 1; j < row.getPhysicalNumberOfCells(); j++) {
                        cell = row.getCell(j);
                        Download.add(cell.getStringCellValue());
                    }
                }
                Boolean status = Download.equals(Upload);
                if (action.equals("Equal")) {
                    Assert.assertTrue(status);
                } else {
                    Assert.assertFalse(status);
                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Action in Excel Importer Page is not performed ");
            Assert.fail("action in Excel Importer Page is not performed" + e.getMessage());
        }
    }
}

