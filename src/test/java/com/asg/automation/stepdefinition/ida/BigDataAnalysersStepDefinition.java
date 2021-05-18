package com.asg.automation.stepdefinition.ida;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.LoginActions;
import com.asg.automation.pageobjects.ida.AmbariPage;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.utils.*;
import com.asg.utils.commonutils.SFTPUtil;
import cucumber.api.DataTable;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import org.testng.annotations.Test;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.function.Predicate;

import static com.asg.automation.utils.Constant.REST_PAYLOAD;

/**
 * Created by venkata.mulugu on 7/13/2017.
 */
public class BigDataAnalysersStepDefinition extends DriverFactory {
    JSONObject jsonobject;
    String fileSource;
    private WebDriver driver;
    private JsonRead jsonRead;
    //from local repoistory
    private SftpUtil sftpConnection;
    //from automation jar branch
    private SFTPUtil sftpUtil = new SFTPUtil();
    List<String> finalColumns;
    List<String> queryExecutionQueue = new ArrayList<>();

    private com.asg.utils.commonutils.FileUtil fileUtil;


    @Before("@webtest")
    public void beforeScenario() {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            jsonRead = new JsonRead();
            propertyLoader();

        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @Before("@sftp")
    public void initializesftpdocker() throws Exception {
        propertyLoader();
        sftpConnection = new SftpUtil();
        sftpConnection.setConnectionConfigurationhost(propLoader);
        sftpConnection.connect();
    }

    @Before("@ambari")
    public void initializeambari() throws Exception {
        propertyLoader();
        sftpConnection = new SftpUtil();
        sftpConnection.setConnectionConfiguration(propLoader);
        sftpConnection.connect();
    }

    @After("@webtest")
    public void close() {

        destroyDriver();
    }

    @After("@droptable")
    public void droptablerequest() throws Exception {
        System.out.println("\n==================Dropping Tables Started =========================");

        SSHBean sshdemobean = new SSHBean();
        if (sshdemobean.openConnection(propLoader.prop.getProperty("sftpServerHostname"), Integer.parseInt(propLoader.prop.getProperty("sftpPortNumber")), propLoader.prop.getProperty("sftpUsername"), propLoader.prop.getProperty("sftpPassword"), 120000)) {
            System.out.println("Connected to the server successfully !!!");

            sshdemobean.sendCommand("hive \n");
            Thread.sleep(15000);
            System.out.println("Result:" + sshdemobean.recvData());

            sshdemobean.sendCommand("drop table foodmart.customer_shopping_list;drop table cus_shop_list; \n");
            Thread.sleep(15000);
            System.out.println("Result:" + sshdemobean.recvData());
        }
        System.out.println("\n=================Dropping Tables completed ======================");
    }

    @Before("@sftp")
    public void initializesftp() throws Exception {
        propertyLoader();
        sftpConnection = new SftpUtil();
        sftpConnection.setConnectionConfiguration(propLoader);
        sftpConnection.connect();
    }

    @After("@sftp")
    public void tearDownSftp() throws Throwable {
        sftpConnection.disconnect();
        delete_the_downloaded_xml_file();
    }


    @Given("^User launch browser and traverse to Ambari login page$")
    public void user_launch_browser_and_traverse_to_Ambari_login_page() {

        try {
            launchBrowser(driver, propLoader.prop.getProperty("ambariURL_docker"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Browser launched successfully");
            driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
            Assert.assertTrue(driver.getTitle().equalsIgnoreCase("Ambari"));

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Fail to Launch Browser");
            Assert.fail("Failed to launch Browser");
        }

    }

    @Given("^user enter credentials for Ambari login$")
    public void user_enter_credentials_for_Ambari_login() {
        try {

            new AmbariPage(driver).loginToAmbariPage(propLoader.prop.getProperty("ambariUsername"), propLoader.prop.getProperty("ambariPassword"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in to Ambari");

        } catch (Exception e) {

            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }

    }


    @When("^user clicks on cataloger in Ambari left navigation bar$")
    public void user_clicks_on_cataloger_in_Ambari_left_navigation_bar() {

        try {
            new AmbariPage(driver).Click_catalogerButton();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

    }

    @When("^user clicks on Hive Viewer$")
    public void user_clicks_on_Hive_Viewer() {

        try {
            sleepForSec(3000);
            driver.switchTo().defaultContent();
            new AmbariPage(driver).Click_HiveViewer();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }

    }

    @When("^user clicks on cataloger configs tab$")
    public void user_clicks_on_cataloger_configs_tab() {
        try {
            new AmbariPage(driver).Click_catalogerConfigsTab();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }

    }

    @When("^user clicks on cataloger settings tab$")
    public void user_clicks_on_cataloger_settings_tab() {
        try {
            new AmbariPage(driver).Click_catalogerCatalogersSettingsTab();
            sleepForSec(2000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @When("^user sets the enable query log button to \"([^\"]*)\"$")
    public void user_sets_the_enable_query_log_button_to(String arg1) {
        try {
            if (arg1.equalsIgnoreCase("Yes")) {
                if (new AmbariPage(driver).gettoogleButton().getAttribute("class").contains("-switch-off")) {
                    new AmbariPage(driver).return_enableQueryNoButton().click();
                    sleepForSec(3000);
                }
            } else if (arg1.equalsIgnoreCase("No")) {
                if (new AmbariPage(driver).gettoogleButton().getAttribute("class").contains("-switch-on")) {
                    System.out.println("No Button is clicked");
                    new AmbariPage(driver).return_enableQueryYesButton().click();
                    sleepForSec(3000);
                }
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }

    }

    @When("^user clicks on save button in the cataloger page$")
    public void user_clicks_on_save_button_in_the_cataloger_page() {
        try {
            if (new AmbariPage(driver).return_catalogerSaveButton().isEnabled()) {
                System.out.println("Save Button is enabled");
                new AmbariPage(driver).Click_catalogerSaveButton();
            } else {
                System.out.println("Save Button is disabled");
                new AmbariPage(driver).return_enableQueryYesButton().click();
                sleepForSec(1000);

                new AmbariPage(driver).Click_catalogerSaveButton();
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @When("^user enters text in the save configuration box$")
    public void user_enters_text_in_the_save_configuration_box() {
        try {
            enterText(new AmbariPage(driver).return_changeMessageTextBox(), "Changing Enable Query Log");
            sleepForSec(2000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @When("^user restarts the cataloger service$")
    public void user_restarts_the_cataloger_service() {
        try {
            new AmbariPage(driver).Click_catalogerRestartButton();
            sleepForSec(3000);
            new AmbariPage(driver).Click_catalogerRestartAllEffectedButton();
            sleepForSec(1000);
            new AmbariPage(driver).Click_confirmRestartAllButton();
            sleepForSec(3000);
            new AmbariPage(driver).return_restartProgressButton().isDisplayed();
            sleepForSec(5000);
            new AmbariPage(driver).Click_restartSuccessOkButton();

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @When("^user clicks on ok button in the save configuration changes box$")
    public void user_clicks_on_ok_button_in_the_save_configuration_changes_box() {
        try {
            sleepForSec(2000);
            new AmbariPage(driver).Click_saveConfigurationChangesOkButton();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @When("^user clicks on save button in the save configuration box$")
    public void user_clicks_on_save_button_in_the_save_configuration_box() {
        try {
            new AmbariPage(driver).Click_saveConfigurationSaveButton();
            sleepForSec(4000);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @And("^user connects to the sftp server and downloads the \"([^\"]*)\" \"([^\"]*)\" file for Query\"([^\"]*)\"$")
    public void userConnectsToTheSftpServerAndDownloadsTheFileForQuery(String arg1, String arg2, String arg3) {
        Boolean stopValidFileDownloaded = true;
        int COUNT = 0;
        try {
            sleepForSec(3000);
            if ((arg1.equalsIgnoreCase("xml")) && (arg2.equalsIgnoreCase("config"))) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("hiveConfigXmlPath"), propLoader.prop.getProperty("logsDestinationPath") + "MLP-1306_Scenario1.xml");

            } else if ((arg1.equalsIgnoreCase("xml")) && (arg2.equalsIgnoreCase("query"))) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("hiveQueryPath"), propLoader.prop.getProperty("logsDestinationPath") + "MLP-1306_Scenario1.xml");

            } else if ((arg1.equalsIgnoreCase("event")) && (arg2.equalsIgnoreCase("text"))) {
                fileSource = sftpConnection.retrieveFilesInDirectory(propLoader.prop.getProperty("eventFileDirectoryPath"), propLoader.prop.getProperty("DestinationEventFilePath"), "*.txt");

            } else if ((arg1.equalsIgnoreCase("catalogHive")) && (arg2.equalsIgnoreCase("log"))) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("CataloghivePath"), propLoader.prop.getProperty("logsDestinationPath") + "MLP-1953_catalogHive.log");
            } else if ((arg1.equalsIgnoreCase("hive")) && (arg2.equalsIgnoreCase("xml"))) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("hiveConfigXmlPath"), propLoader.prop.getProperty("logsDestinationPath") + "IdcScanHive.xml");
            } else if ((arg1.equalsIgnoreCase("hdfs")) && (arg2.equalsIgnoreCase("xml"))) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("hdfsConfigXmlPath"), propLoader.prop.getProperty("logsDestinationPath") + "IdcScanHdfs.xml");
            }

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {

        }

    }

    @And("^user connects to the sftp server and run the \"([^\"]*)\" command$")
    public void userConnectsToTheSftpServerAndRunsTheCommand(String command) {
        try {
            sftpConnection.executeShellCommand(Constant.shellCommand(command));

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @Given("^user retrives the file \"([^\"]*)\" from remote location \"([^\"]*)\"$")
    public void user_retrives_the_file_from_remote_location(String file, String path) {
        try {

            sftpConnection.retrieveFile(path, propLoader.prop.getProperty("logsDestinationPath") + "ScanHDFS.xml");

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {

        }

    }

    @When("^user converts the xml file to json file$")
    public void user_converts_the_xml_file_to_json_file() throws Throwable {
        jsonobject = XML.toJSONObject(new String(Files.readAllBytes(Paths.get(propLoader.prop.getProperty("logsDestinationPath") + "MLP-1306_Scenario1.xml"))));
        System.out.println(jsonobject);

    }

    @Then("^cataloger\\.enable\\.queryLog in the should be set to \"([^\"]*)\"$")
    public void cataloger_enable_queryLog_in_the_should_be_set_to(String arg1) throws Throwable {

        JSONArray arr = jsonobject.getJSONObject("configuration").getJSONArray("property");
        for (int i = 0; i < arr.length(); i++) {
            if (arr.getJSONObject(i).getString("name").equalsIgnoreCase("cataloger.enable.querylog")) {
                // System.out.println(arr.getJSONObject(i).getString("name"));
                if (arg1.equalsIgnoreCase("true")) {
                    verifyTrue(arr.getJSONObject(i).getBoolean("value"));
                } else if (arg1.equalsIgnoreCase("false")) {
                    verifyFalse(arr.getJSONObject(i).getBoolean("value"));
                }
            }
        }
    }

    @Given("^user connects to the SFTP server for below parameters$")
    public void user_connects_to_the_SFTP_server_for_below_parameters(DataTable arg1) throws Throwable {
        String server = null;
        String port = null;
        String user = null;
        String password = null;
        try {
            for (Map<String, String> map : arg1.asMaps(String.class, String.class)) {
                if (map.get("sftpHost") != null) {
                    server = propLoader.prop.getProperty(map.get("sftpHost"));
                    port = propLoader.prop.getProperty(map.get("sftpPort"));
                    user = propLoader.prop.getProperty(map.get("sftpUser"));
                    password = propLoader.prop.getProperty(map.get("sftpPw"));
                    switch (map.get("sftpAction")) {
                        case "uploadFolder":
                            new SFTPUtil(server, Integer.parseInt(port), user, password).uploadFolderToSftpDir(Constant.REST_PAYLOAD + map.get("localDir"), map.get("remoteDir"));
                            break;
                        case "copyFiles":
                            new SFTPUtil(server, Integer.parseInt(port), user, password).copyFileToSftp(map.get("remoteDir"), Constant.REST_PAYLOAD + map.get("localDir"));
                            break;
                        case "deleteFiles":
                            new SFTPUtil(server, Integer.parseInt(port), user, password).deleteFiles(map.get("remoteDir"), map.get("localDir"));
                            break;
                    }
                } else if (map.get("sftpHost") == null) {
                    switch (map.get("sftpAction")) {
                        case "copytoLocal":
                            fileUtil.copyFilesToNewDirectory(Constant.REST_PAYLOAD + map.get("remoteDir"), Constant.LocalSparkDirectory);
                            break;
                        case "copytoremote":
                            fileUtil.copyFilesToNewDirectory(Constant.REST_PAYLOAD + map.get("localDir"), map.get("remoteDir"));
                            break;
                        case "deleteLocalFiles":
                            fileUtil.deleteFiles(Constant.LocalSparkDirectory, map.get("remoteDir"));
                            break;
                        case "deleteDir":
                            fileUtil.deleteDirectory(new File(Constant.LocalSparkDirectory));
                            break;
                        case "deleteLocalFile":
                            fileUtil.deleteFile(Constant.LocalDownload + map.get("localfile"));
                            break;

                    }
                }
            }
        } catch (
                Exception e) {
            e.printStackTrace();
        }
    }


    @And("^user connects to the sftp server and runs spark commands$")
    public void user_connects_to_the_sftp_server_and_runs_spark_commands(DataTable table) {

        try {
            for (Map<String, String> values : table.asMaps(String.class, String.class)) {

                String command = values.get("command");
                String Filename = values.get("Filename");
                String remoteName = values.get("RemoteMachineDir");
                String remoteMachinePath = values.get("RemoteMachinePath");
                sftpConnection.connect();
                sftpConnection.executeShellCommand(Constant.shellCommandtorunspark(command, remoteName, remoteMachinePath, Filename));

            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @And("^user connects to the sftp server or local Machine and runs commands$")
    public void user_connects_to_the_sftp_server_or_local_Machine_and_runs_commands(DataTable table) {

        try {
            for (Map<String, String> values : table.asMaps(String.class, String.class)) {

                String command = values.get("command");
                String Filename = values.get("Filename");
                String remoteName = values.get("RemoteMachineName");
                String remoteMachinePath = values.get("RemoteMachinePath");
                switch (values.get("Env")) {
                    case "Ambari":
                        int waitTime = Integer.parseInt(values.get("TimeInMilliSecs"));
                        sftpUtil.setConnectionConfiguration(propLoader.prop.getProperty("sftpServerHostname"), propLoader.prop.getProperty("sftpPortNumber"), propLoader.prop.getProperty("sftpUsername"), propLoader.prop.getProperty("sftpPassword"));
                        sftpUtil.connect();
                        sftpUtil.executeShellCommand(Constant.shellCommandtorunspark(command, remoteName, remoteMachinePath, Filename));
                        sleepForSec(waitTime);
                        break;
                    case "Local":
                        sftpUtil.executeCommand(Constant.shellCommandtorunspark(command, remoteName, remoteMachinePath, Filename));
                        break;
                }
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @And("^user connects to cmdprompt and runs spark commands in local$")
    public void user_connects_to_cmdprompt_and_runs_spark_commands_in_local(DataTable table) {
        try {
            for (Map<String, String> values : table.asMaps(String.class, String.class)) {

                String command = values.get("command");
                String Filename = values.get("Filename");
                String remoteName = values.get("RemoteMachineName");
                String remoteMachinePath = values.get("RemoteMachinePath");
                sftpUtil.executeCommand(Constant.shellCommandtorunspark(command, remoteName, remoteMachinePath, Filename));

            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @And("^user connects to the sftp server and runs docker commands$")
    public void user_connects_to_the_sftp_server_and_runs_docker_commands(DataTable table) {

        try {
            for (Map<String, String> values : table.asMaps(String.class, String.class)) {

                String command = values.get("command");
                String Filename = values.get("Filename");
                String remoteName = values.get("RemoteMachineDir");
                String remoteMachinePath = values.get("RemoteMachinePath");
                initializesftpdocker();
                sftpConnection.executeShellCommand(Constant.shellCommandtorunspark(command, remoteName, remoteMachinePath, Filename));
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @And("^user connects to cmdprompt and runs java spark commands in local$")
    public void user_connects_to_cmdprompt_and_runs_java_spark_commands_in_local(DataTable table) {
        try {
            for (Map<String, String> values : table.asMaps(String.class, String.class)) {

                String command = values.get("command");
                String Filename = values.get("Filename");
                String remoteName = values.get("RemoteMachineDir");
                String jarFile = values.get("JarFile");
                sftpUtil.executeCommand(Constant.shellCommandtorunspark(command, remoteName, remoteName, Filename + " " + Constant.LocalSparkDirectory1 + jarFile));

            }
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        } finally {
        }
    }

    @Then("^delete the downloaded xml file$")
    public void delete_the_downloaded_xml_file() {
        try {
            String filePath = propLoader.prop.getProperty("logsDestinationPath") + "MLP-1306_Scenario1.xml";
            //create a new file
            File file = new File(filePath);

            if (file.exists()) {
                file.delete();
            } else {
                System.out.println(file.getPath() + "does not exists");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }


    }

    @When("^user clicks on Hive View$")
    public void user_clicks_on_Hive_View() throws Throwable {
        sleepForSec(3000);
        // moveToElement(driver, new AmbariPage(driver).return_servicesIconDropDown());
        new AmbariPage(driver).Click_hiveViewIconButton();
    }

    @And("^user enters the \"([^\"]*)\" \"([^\"]*)\" in Hive query box and clicks on execute$")
    public void userEntersTheInHiveQueryBoxAndClicksOnExecute(String arg1, String arg2) throws Throwable {
        new AmbariPage(driver).switchToFrame(driver, new AmbariPage(driver).getframe());
        // sleepForSec(3000);
        if (arg1.equalsIgnoreCase("Query")) {
            moveToElement(driver, new AmbariPage(driver).getQueryspace(), new JsonRead().readJSon("Queries", "QueryLog_Q" + arg2));
            queryExecutionQueue.add(new JsonRead().readJSon("Queries", "QueryLog_Q" + arg2));
        } /*else {
            moveToElement(driver, new AmbariPage(driver).getQueryspace(), arg1);
        }*/
        new AmbariPage(driver).Click_executeQueryButton();
        //sleepForSec(2000);
    }

    @Given("^user sets the enable query log to Yes via shell script$")
    public void user_sets_the_enable_query_log_to_Yes_via_shell_script() throws Throwable {

        /*String filePath="C:\\Users\\venkata.mulugu\\Desktop\\Script1.sh";
        Runtime.getRuntime().exec("cmd /c start " + filePath);*/
        String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date());
        System.out.println(timeStamp);


    }

    @Then("^Query log should not be generated$")
    @Test(expectedExceptions = {FileNotFoundException.class})
    public void queryLogShouldNotBeGenerated() throws Throwable {
        File inputFile = new File("src/test/resources/com.asg.automation.testdata.queryLogFiles/MLP-1306_Scenario1.xml");
    }

    @Then("^the query executed should match with the query \"([^\"]*)\" and only \"([^\"]*)\" queries should be there$")
    public void theQueryExecutedShouldMatchWithTheQueryAndOnlyQueriesShouldBeThere(String expectedQuery, int count) throws Throwable {
        int actualCount = 0;
        Map<String, String> queryStack = new HashMap<>();
        String[] Q1 = new JsonRead().readJSon("Queries", expectedQuery).split(";");
        for (int i = 0; i < Q1.length; i++) {
            queryStack.put(Q1[i], Q1[i]);
        }
        File inputFile = new File("src\\test\\resources\\testdata\\features\\querylog\\queryLogFiles\\MLP-1306_Scenario1.xml");
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(inputFile);
        NodeList nList = doc.getElementsByTagName("queryText");
        int queryTextCount = nList.getLength();
        for (int j = 0; j < queryTextCount; j++) {
            String node = nList.item(j).getTextContent();
            if (node.contains(queryStack.get(node))) {
                actualCount++;
            }
        }
        Assert.assertEquals(actualCount, count);
    }

    @Then("^user then executes the query and connect to sftp server to retrive the event file and compare its contents$")
    @Test(dataProvider = "DataFeed", dataProviderClass = ExcelDataLoaderUtil.class)
    public void userThenExecutesTheQueryAndConnectToSftpServerToRetriveTheEventFileAndCompareItsContents(String query, String eventType, String entityType, String initialName, String finalName, String queryString, String queryUser) throws Throwable {
        {

            userEntersTheInHiveQueryBoxAndClicksOnExecute(query, "");
            String s1 = sftpConnection.retrieveFilesInDirectory(propLoader.prop.getProperty("eventFileDirectoryPath"), propLoader.prop.getProperty("DestinationEventFilePath"), "*.txt");
            HashMap<String, String> map = null;
            File src = new File(s1);
            map = new HashMap<>();
            Scanner file = new Scanner(src);
            while (file.hasNextLine()) {
                String fileText = file.nextLine();
                int index = fileText.indexOf('=');
                fileText = fileText.substring(index + 1);
                map.put(fileText, fileText);
                if (eventType.equalsIgnoreCase(map.get(eventType)) &&
                        entityType.equalsIgnoreCase(map.get(entityType)) &&
                        initialName.equalsIgnoreCase(map.get(initialName)) &&
                        finalName.equalsIgnoreCase(map.get(finalName)) &&
                        queryString.equalsIgnoreCase(map.get(queryString)) &&
                        queryUser.equalsIgnoreCase(map.get(queryUser))) {
                    Assert.assertTrue(true);

                } else
                    Assert.assertTrue(false);
            }
        }
    }


    @Given("^verify the HDFS scanned content to include the following$")
    public void verify_the_HDFS_scanned_content_to_include_the_following(DataTable table) throws Throwable {    // Write code here that turns the phrase above into concrete actions

        List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
        String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHDFS.xml";
        List<String> listofDirectoryNames = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "directory", "name");
        List<String> listofFileNames = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "file", "name");
        List<String> listofDirectoryGroup = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "directory", "group");
        List<String> listofDirectoryCreatedBy = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "directory", "createdBy");
        List<String> listofDirectoryTags = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "directory", "tags");

        String clusterName = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "cluster", "name").get(0);
        Assert.assertEquals(idaDatasets.get(0).getIcluster(), clusterName);

        idaDatasets.forEach(directoryContent -> {
            try {
                Assert.assertEquals(listofDirectoryNames.stream().filter(directoryName -> directoryName.equalsIgnoreCase(directoryContent.getIdirectory())).findFirst().get(), directoryContent.getIdirectory());
                Assert.assertEquals(listofFileNames.stream().filter(directoryName -> directoryName.equalsIgnoreCase(directoryContent.getIfile())).findFirst().get(), directoryContent.getIfile());
                Assert.assertEquals(listofDirectoryGroup.stream().filter(directoryName -> directoryName.equalsIgnoreCase(directoryContent.getIgroup())).findFirst().get(), directoryContent.getIgroup());
                Assert.assertEquals(listofDirectoryCreatedBy.stream().filter(directoryName -> directoryName.equalsIgnoreCase(directoryContent.getIcreatedBy())).findFirst().get(), directoryContent.getIcreatedBy());
                Assert.assertEquals(listofDirectoryTags.stream().filter(directoryName -> directoryName.equalsIgnoreCase(directoryContent.getItags())).findFirst().get(), directoryContent.getItags());

            } catch (Exception e) {
                //Assert.assertFalse(true, e.toString());
                Assert.fail(e.getMessage());
            }

        });
    }

    @Given("^verify the hdfs scanned content not to include files and the excluded directory$")
    public void verify_the_hdfs_scanned_content_not_to_include_files_and_the_excluded_directory(DataTable table) {
        try {
            List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
            String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHDFS.xml";
            List<String> listofFileNames = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "file", "name");
            Assert.assertEquals(0, listofFileNames.size());
            List<String> listofDirectoryNames = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "directory", "name");
            Predicate<String> directoryMatch = s -> s.startsWith(idaDatasets.get(0).getIdirectory());
            Assert.assertTrue(listofDirectoryNames.stream().noneMatch(directoryMatch));
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @And("^delete the downloaded event File$")
    public void deleteTheDownloadedEventFile() {

    }

    @Then("^verify the HIVE scanned content to include the following clusterName dbSystemName$")
    public void verify_the_HIVE_scanned_content_to_include_the_following_clusterName_dbSystemName(DataTable table) {
        try {
            List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
            String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHive.xml";
            String clusterName = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "cluster", "name").get(0);
            String dbSystemName = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "dbSystem", "appName").get(0);
            Assert.assertEquals(idaDatasets.get(0).getCluster(), clusterName);
            Assert.assertEquals(idaDatasets.get(0).getDbSystem(), dbSystemName);

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^verify the HIVE scanned content to include the following datatype content$")
    public void verify_the_HIVE_scanned_content_to_include_the_following_datatype_content(DataTable table) {
        try {
            List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
            String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHive.xml";
            List<String> listofDataTypes = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "dataType", "name");
            List<String> listofDataTypeXmiids = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "dataType", "xmi:id");
            List<String> listofDataTypeStages = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "dataType", "stage");
            List<String> listofDataTypeDefs = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "dataType", "def");

            idaDatasets.forEach(datatypeContent -> {
                        Assert.assertEquals(listofDataTypes.stream().filter(dataTypeName -> dataTypeName.equalsIgnoreCase(datatypeContent.getDataType())).findFirst().get(), datatypeContent.getDataType());
                        Assert.assertEquals(listofDataTypeXmiids.stream().filter(dataTypeName -> dataTypeName.equalsIgnoreCase(datatypeContent.getXmiid())).findFirst().get(), datatypeContent.getXmiid());
                        Assert.assertEquals(listofDataTypeStages.stream().filter(dataTypeName -> dataTypeName.equalsIgnoreCase(datatypeContent.getStage())).findFirst().get(), datatypeContent.getStage());
                        Assert.assertEquals(listofDataTypeDefs.stream().filter(dataTypeName -> dataTypeName.equalsIgnoreCase(datatypeContent.getDef())).findFirst().get(), datatypeContent.getDef());


                    }


            );
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }


    }

    @Then("^verify the HIVE scanned content to include the following database content$")
    public void verify_the_HIVE_scanned_content_to_include_the_following_database_content(DataTable table) {

        try {
            List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
            String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHive.xml";
            String databaseName = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "database", "name").get(0);
            String databaseLocation = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "database", "location").get(0);
            String databaseStorageType = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "database", "storageType").get(0);
            String databaseTags = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "database", "tags").get(0);
            String databaseDef = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "database", "def").get(0);

            Assert.assertEquals(idaDatasets.get(0).getDatabase(), databaseName);
            Assert.assertEquals(idaDatasets.get(0).getDbLocation(), databaseLocation);
            Assert.assertEquals(idaDatasets.get(0).getDbStorageType(), databaseStorageType);
            Assert.assertEquals(idaDatasets.get(0).getDbTags(), databaseTags);
            Assert.assertEquals(idaDatasets.get(0).getDbDef(), databaseDef);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }


    }

    @Then("^verify the HIVE scanned content to include the following table content$")
    public void verify_the_HIVE_scanned_content_to_include_the_following_table_content(DataTable table) {
        try {
            List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
            String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHive.xml";
            String tableName = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "name").get(0);
            String bucketsNumber = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "bucketsNumber").get(0);
            String createdBy = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "createdBy").get(0);
            String delimitedFields = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "delimitedFields").get(0);
            String filesCount = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "filesCount").get(0);
            String inputType = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "inputType").get(0);
            String location = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "location").get(0);
            String modifiedAt = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "modifiedAt").get(0);
            String modifiedBy = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "modifiedBy").get(0);
            String partitionedBy = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "partitionedBy").get(0);
            String serdeLibrary = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "serdeLibrary").get(0);
            String tags = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "tags").get(0);
            String storageType = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "table", "storageType").get(0);


            Assert.assertEquals(idaDatasets.get(0).getTable(), tableName);
            Assert.assertEquals(idaDatasets.get(0).getTbucketsNumber(), bucketsNumber);
            Assert.assertEquals(idaDatasets.get(0).getTcreatedBy(), createdBy);
            Assert.assertEquals(idaDatasets.get(0).getTdelimitedFields(), delimitedFields);
            Assert.assertEquals(idaDatasets.get(0).getTfilesCount(), filesCount);
            Assert.assertEquals(idaDatasets.get(0).getTinputType(), inputType);
            Assert.assertEquals(idaDatasets.get(0).getTlocation(), location);
            Assert.assertEquals(idaDatasets.get(0).getTmodifiedAt(), modifiedAt);
            Assert.assertEquals(idaDatasets.get(0).getTmodifiedBy(), modifiedBy);
            Assert.assertEquals(idaDatasets.get(0).getTpartitionedBy(), partitionedBy);
            Assert.assertEquals(idaDatasets.get(0).getTserdeLibrary(), serdeLibrary);
            Assert.assertEquals(idaDatasets.get(0).getTtags(), tags);
            Assert.assertEquals(idaDatasets.get(0).getTstorageType(), storageType);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }


    }

    @Then("^verify the HIVE scanned content to include the following colummn content$")
    public void verify_the_HIVE_scanned_content_to_include_the_following_colummn_content(DataTable table) {
        try {
            List<CucumberDataSet> idaDatasets = table.asList(CucumberDataSet.class);
            String logslocalDestination = propLoader.prop.getProperty("tempDirectoryPath") + "ScanHive.xml";
            List<String> listofColumnNames = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "column", "name");
            List<String> listofdataOfType = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "column", "dataOfType");
            List<String> listofdataTypes = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "column", "dataType");
            List<String> listofxmiid = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "column", "xmi:id");
            List<String> listoftags = XMLReaderUtil.readAnAttributeFromFile(logslocalDestination, "column", "tags");

            idaDatasets.forEach(columnContent -> {

                        Assert.assertEquals(listofColumnNames.stream().filter(columnName -> columnName.equalsIgnoreCase(columnContent.getColumn())).findFirst().get(), columnContent.getColumn());
                        Assert.assertEquals(listofdataOfType.stream().filter(columnName -> columnName.equalsIgnoreCase(columnContent.getCdataOfType())).findFirst().get(), columnContent.getCdataOfType());
                        Assert.assertEquals(listofdataTypes.stream().filter(columnName -> columnName.equalsIgnoreCase(columnContent.getCdataType())).findFirst().get(), columnContent.getCdataType());
                        Assert.assertEquals(listofxmiid.stream().filter(columnName -> columnName.equalsIgnoreCase(columnContent.getCxmiid())).findFirst().get(), columnContent.getCxmiid());
                        Assert.assertEquals(listoftags.stream().filter(columnName -> columnName.equalsIgnoreCase(columnContent.getCtags())).findFirst().get(), columnContent.getCtags());

                    }


            );
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }


    }

    @And("^user validates the status of cataloger enable query log flag to \"([^\"]*)\"$")
    public void userValidatesTheStatusOfCatalogerEnableQueryLogFlagTo(String flagStatus) throws Throwable {
        File src = new File("src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1953_catalogHive.log");
        // Open the file
        FileInputStream fstream = new FileInputStream(src);
        BufferedReader br = new BufferedReader(new InputStreamReader(fstream));
        String strLine;
        String flag = "cataloger.enable.queryLog      = " + flagStatus;
        List<String> list = new ArrayList<>();

        //Read File Line By Line
        while ((strLine = br.readLine()) != null) {
            if (strLine.contains("cataloger.enable.queryLog")) {
                list.add(strLine);
            }
        }
        int index = list.size() - 1;
        if (list.get(index).equalsIgnoreCase(flag)) {
            Assert.assertTrue(true);
            System.out.println("Flag status is validated");
        } else {
            System.out.println("Flag status validation Failed");
            Assert.assertTrue(false);
        }

        //Close the input stream
        br.close();
    }


    @And("^user validates the contents of the query xml$")
    public void userValidatesTheContentsOfTheQueryXml() throws Throwable {
        String localXmlPath = "src\\test\\resources\\testdata\\features\\querylog\\queryLogFiles\\MLP-1306_Scenario1.xml";

        List<String> clusterName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster", "name");
        Assert.assertTrue(clusterName.get(0).equalsIgnoreCase("Cluster Demo"));

        List<String> databaseName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database", "name");
        Assert.assertTrue(databaseName.get(0).equalsIgnoreCase("xademo"));

        List<String> tableName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table", "name");
        Assert.assertTrue(tableName.get(0).equalsIgnoreCase("recharge_details"));

        List<String> columnNames = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table/column", "name");
        String[] actualColumnNames = {"phone_number", "rec_date", "channel", "plan", "amount"};
        for (int i = 0; i < columnNames.size(); i++) {
            Assert.assertTrue(columnNames.get(i).equalsIgnoreCase(actualColumnNames[i]));
        }

        List<String> input = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/input", "name");
        Assert.assertTrue(input.get(0).equalsIgnoreCase("xademo.recharge_details"));

        List<String> queryText = XMLReaderUtil.readAttributesFromXmlTagName(localXmlPath, "queryText");
        Assert.assertTrue(queryText.get(0).equalsIgnoreCase("select * from xademo.recharge_details"));


    }

    @And("^user deletes the downloaded text files$")
    public void userDeletesTheDownloadedTextFiles() throws Throwable {
        sleepForSec(2000);
        FileUtils.cleanDirectory(new File("src\\test\\resources\\com.asg.automation.testdata.queryLogFiles\\EventFilesCollection"));
    }

    @And("^user navigates to IDC UI$")
    public void userNavigatesToIDCUI() throws Throwable {
        navigateToUrl(driver, propLoader.prop.getProperty("qaURL"));
        sleepForSec(2000);
        new LoginActions(driver).loginToIDCPage("TestService", "Service");
    }

    @And("^user searches for the content\"([^\"]*)\" in the search box$")
    public void userSearchesForTheQueryInTheSearchBox(String searchcontent) throws Throwable {
        String searchText = null;
        if (searchcontent.equalsIgnoreCase("Solr_Search_for_ClusterDemo")) {
            searchText = Constant.SOLRSEARCH_FOR_CLUSTER_DEMO;
        } else {
            searchText = "name_s:" + new JsonRead().readJSon("Queries", "QueryLog_Q" + Integer.parseInt(searchcontent));
        }
        new DashBoardPage(driver).enterTextToTopSearchBox(searchText);
    }

    @And("^user validates the file contents for Query$")
    public void userValidatesTheFileContentsForQuery(List<CucumberDataSet> dataTableCollection) {
        try {
            List<String> jsonDataList = new ArrayList<>();
            List<String> queryDataList = new ArrayList<>();

            for (CucumberDataSet data : dataTableCollection) {
                jsonDataList.add(new JsonRead().readJSonFromQuery(fileSource, data.getJsonAttributeList()).toLowerCase());
                sleepForSec(1000);
                queryDataList.add(new JsonRead().readJSon(data.getPageNameList(), data.getFieldNameList() + data.getQueryNumber()).toLowerCase());
                sleepForSec(1000);
            }
            Assert.assertTrue(jsonDataList.containsAll(queryDataList));
            LoggerUtil.logLoader_info("All the contents in the query are present", this.getClass().getName());
        } catch (Exception e) {
            Assert.fail("All the contents in the query are not present");
            LoggerUtil.logLoader_error("Contents are not present", this.getClass().getName());
        }
    }

    @And("^user validates the file contents inside child json$")
    public void userValidatesTheFileContentsForChildJson(List<CucumberDataSet> dataTableCollection) {
        try {
            List<String> jsonDataList = new ArrayList<>();
            List<String> queryDataList = new ArrayList<>();

            for (CucumberDataSet data : dataTableCollection) {
                jsonDataList.add(new JsonRead().readJSonFromQuery(fileSource, data.getJsonPageNameList(), data.getJsonFieldNameList()).toLowerCase());
                queryDataList.add(new JsonRead().readJSon(data.getPageNameList(), data.getFieldNameList() + data.getQueryNumber()).toLowerCase());
            }
            Assert.assertTrue(jsonDataList.containsAll(queryDataList));
            LoggerUtil.logLoader_info("All the contents inside the child json are present", this.getClass().getName());
        } catch (Exception e) {
            Assert.fail("All the contents inside the child json are not present");
            LoggerUtil.logLoader_error("Contents are not present", this.getClass().getName());
        }
    }

    @And("^user validates the file contents inside \"([^\"]*)\"$")
    public void userValidatesTheFileContentsForChild(String type, List<CucumberDataSet> dataTableCollection) {
        try {
            List<String> jsonDataList = new ArrayList<>();
            List<String> queryDataList = new ArrayList<>();

            for (CucumberDataSet data : dataTableCollection) {
                jsonDataList.add(new JsonRead().readJSonFromChildWithType(fileSource, data.getJsonPageNameList(), data.getJsonFieldNameList(), type).toLowerCase());
                queryDataList.add(new JsonRead().readJSon(data.getPageNameList(), data.getFieldNameList() + data.getQueryNumber()).toLowerCase());
            }
            Assert.assertTrue(jsonDataList.containsAll(queryDataList));
            LoggerUtil.logLoader_info("All the contents inside the child json are present", this.getClass().getName());
        } catch (Exception e) {
            Assert.fail("All the contents inside the child json are not present");
            LoggerUtil.logLoader_error("Contents are not present", this.getClass().getName());
        }
    }

    @And("^user validates the file contents with lineage$")
    public void userValidatesTheFileContentsFromLineage(List<CucumberDataSet> dataTableCollection) {
        try {
            List<String> jsonDataList = new ArrayList<>();
            List<String> queryDataList = new ArrayList<>();

            for (CucumberDataSet data : dataTableCollection) {
                jsonDataList.add(new JsonRead().readJSonFromLineage(fileSource, data.getJsonFieldNameList(), data.getJsonFieldNameList()).toLowerCase());
                queryDataList.add(new JsonRead().readJSon(data.getPageNameList(), data.getFieldNameList()).toLowerCase());
            }
            Assert.assertTrue(jsonDataList.containsAll(queryDataList));
            LoggerUtil.logLoader_info("All the contents inside the child json are present", this.getClass().getName());
        } catch (Exception e) {
            Assert.fail("All the contents inside the child json are not present");
            LoggerUtil.logLoader_error("Contents are not present", this.getClass().getName());
        }
    }

    @And("^user searches for the event file releated to the Query \"([^\"]*)\"$")
    public void userSearchesForTheEventFileReleatedToTheQuery(String query) throws Throwable {
        sleepForSec(2000);
        int count = 0;
        boolean searchElement = false;
        String expectedQuery = new JsonRead().readJSon("IDCEventFile", "IDCEvent_E" + query);
        expectedQuery = expectedQuery.replaceAll("\\s+", "");

        while (new DashBoardPage(driver).getTableNavigation().isEnabled()) {
            if (count >= 1) {
                new DashBoardPage(driver).getTableNavigation().click();
                sleepForSec(2000);
            }
            List<WebElement> resultsTable = new DashBoardPage(driver).getResultsTable();
            for (WebElement webElement : resultsTable) {
                String tdValue = webElement.getText();
                if (tdValue.contains(expectedQuery.toLowerCase())) {
                    webElement.click();
                    searchElement = true;
                    break;
                }
            }
            if (searchElement) break;
            count++;
        }
    }

    @And("^user verifies the input table for the table Name \"([^\"]*)\" executed from the query \"([^\"]*)\" and clicks on it$")
    public void userVerifiesTheInputTableForTheTableNameExecutedFromTheQueryAndClicksOnIt(String tableName, String query) throws Throwable {
        sleepForSec(2000);
        String queryText = new DashBoardPage(driver).getQueryText().getText();
        Assert.assertEquals(queryText, new JsonRead().readJSon("QueryString", "QS_E" + query));
        List<WebElement> inputTable = new DashBoardPage(driver).getInputWebTable();
        for (WebElement inputElement : inputTable) {
            String match = inputElement.getText();
            if (match.equalsIgnoreCase(tableName)) {
                Assert.assertTrue(true);
                inputElement.click();
                break;
            }
        }
    }

    @And("^user captures the list of table columns names generated$")
    public void userCapturesTheListOfTableColumnsNamesGenerated() throws Throwable {
        finalColumns = new ArrayList<>();
        List<WebElement> columnsNames = new AmbariPage(driver).getQueryResultsTable().findElements(By.tagName("th"));
        for (WebElement columnName : columnsNames) {
            String tableColumnName = columnName.getText();
            int firstIndex = tableColumnName.lastIndexOf('.');
            int lastIndex = tableColumnName.length();
            finalColumns.add(tableColumnName.substring(firstIndex + 1, lastIndex));
        }

    }

    @And("^user validates the table columns names under HAS_COLUMNS$")
    public void userValidatesTheTableColumnsNamesUnderHAS_COLUMNS() throws Throwable {
        sleepForSec(2000);
        List<String> actualColumns = new ArrayList<>();
        List<WebElement> hasColumnsTable = new DashBoardPage(driver).getHasColumns();
        for (WebElement element : hasColumnsTable) {
            String match = element.getText();
            actualColumns.add(match);
        }
        Assert.assertTrue(actualColumns.removeAll(finalColumns));
    }

    @And("^user validates the contents of the xml for the CREATE query$")
    public void userValidatesTheContentsOfTheXmlForTheCREATEQuery() throws Throwable {
        String localXmlPath = "src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1306_Scenario1.xml";

        List<String> clusterName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster", "name");
        Assert.assertTrue(clusterName.get(0).equalsIgnoreCase("Cluster Demo"));

        List<String> databaseName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database", "name");
        Assert.assertTrue(databaseName.get(0).equalsIgnoreCase("foodmart"));

        List<String> tableName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table", "name");
        Assert.assertTrue(tableName.get(0).equalsIgnoreCase("customer_shopping_list"));

        List<String> input = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/output", "name");
        Assert.assertTrue(input.get(0).equalsIgnoreCase("foodmart.customer_shopping_list"));

        List<String> queryText = XMLReaderUtil.readAttributesFromXmlTagName(localXmlPath, "queryText");
        Assert.assertTrue(queryText.get(0).equalsIgnoreCase("CREATE TABLE foodmart.customer_shopping_list(customer_id int,product_id int,product_name varchar(60),brand_name varchar(60))"));
    }

    @Then("^user verifies the output table for the table Name \"([^\"]*)\" executed from the query \"([^\"]*)\" and clicks on it$")
    public void userVerifiesTheOutputTableForTheTableNameExecutedFromTheQueryAndClicksOnIt(String tableName, String query) throws Throwable {
        sleepForSec(2000);
        String queryText = new DashBoardPage(driver).getQueryText().getText();
        Assert.assertEquals(queryText, new JsonRead().readJSon("QueryString", "QS_E" + query));
        List<WebElement> outputTable = new DashBoardPage(driver).getOutputWebTable();
        for (WebElement outputElement : outputTable) {
            String match = outputElement.getText();
            if (match.equalsIgnoreCase(tableName)) {
                Assert.assertTrue(true);
                outputElement.click();
                break;
            }
        }
    }

    @And("^user validates the contents of the xml for the INSERT query$")
    public void userValidatesTheContentsOfTheXmlForTheINSERTQuery() throws Throwable {
        String localXmlPath = "src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1306_Scenario1.xml";

        List<String> clusterName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster", "name");
        Assert.assertTrue(clusterName.get(0).equalsIgnoreCase("Cluster Demo"));

        List<String> databaseName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database", "name");
        Assert.assertTrue(databaseName.get(0).equalsIgnoreCase("foodmart"));

        List<String> tableName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table", "name");
        String[] actualtableName = {"product", "sales_fact_dec_1998", "customer_shopping_list"};
        for (int i = 0; i < tableName.size(); i++) {
            Assert.assertTrue(tableName.get(i).equalsIgnoreCase(actualtableName[i]));
        }

        List<String> columnNames = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table/column", "name");
        String[] actualColumnNames = {"product_class_id", "product_id", "brand_name", "product_name", "sku", "srp", "gross_weight", "net_weight", "recyclable_package", "low_fat", "units_per_case", "cases_per_pallet", "shelf_width", "shelf_height", "shelf_depth", "product_id", "time_id", "customer_id", "promotion_id", "store_id", "store_sales", "store_cost", "unit_sales", "customer_id", "product_id", "product_name", "brand_name"};
        for (int i = 0; i < columnNames.size(); i++) {
            Assert.assertTrue(columnNames.get(i).equalsIgnoreCase(actualColumnNames[i]));
        }

        List<String> output = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/output", "name");
        Assert.assertTrue(output.get(0).equalsIgnoreCase("foodmart.customer_shopping_list"));

        List<String> input = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/input", "name");
        String[] actualInput = {"foodmart.product", "foodmart.sales_fact_dec_1998"};
        for (int i = 0; i < input.size(); i++) {
            Assert.assertTrue(input.get(i).equalsIgnoreCase(actualInput[i]));
        }

        List<String> queryText = XMLReaderUtil.readAttributesFromXmlTagName(localXmlPath, "queryText");
        Assert.assertTrue(queryText.get(0).equalsIgnoreCase("INSERT INTO foodmart.customer_shopping_list(customer_id,product_id,product_name,brand_name) SELECT b.customer_id,b.product_id,a.product_name,a.brand_name from foodmart.product a INNER JOIN foodmart.sales_fact_dec_1998 b on a.product_id=b.product_id"));

    }


    @And("^user validates the contents of the xml for the CREATE EXTERNAL TABLE query$")
    public void userValidatesTheContentsOfTheXmlForTheCREATEEXTERNALTABLEQuery() throws Throwable {
        String localXmlPath = "src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1306_Scenario1.xml";

        List<String> clusterName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster", "name");
        Assert.assertTrue(clusterName.get(0).equalsIgnoreCase("Cluster Demo"));

        List<String> databaseName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database", "name");
        Assert.assertTrue(databaseName.get(0).equalsIgnoreCase("default"));

        List<String> tableName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table", "name");
        Assert.assertTrue(tableName.get(0).equalsIgnoreCase("cus_shop_list"));

        List<String> input = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/output", "name");
        Assert.assertTrue(input.get(0).equalsIgnoreCase("default.cus_shop_list"));

        List<String> queryText = XMLReaderUtil.readAttributesFromXmlTagName(localXmlPath, "queryText");
        Assert.assertTrue(queryText.get(0).equalsIgnoreCase("create external table cus_shop_list(customer_id INT,product_id INT,product_name STRING,brand_name STRING)"));


    }

    @And("^user validates the contents of the xml for the INSERT DIRECTORY query$")
    public void userValidatesTheContentsOfTheXmlForTheINSERTDIRECTORYQuery() throws Throwable {
        String localXmlPath = "src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1306_Scenario1.xml";

        List<String> clusterName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster", "name");
        Assert.assertTrue(clusterName.get(0).equalsIgnoreCase("Cluster Demo"));

        List<String> databaseName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database", "name");
        Assert.assertTrue(databaseName.get(0).equalsIgnoreCase("northwind"));

        List<String> tableName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table", "name");
        Assert.assertTrue(tableName.get(0).equalsIgnoreCase("employees"));

        List<String> columnNames = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/dbSystem/database/table/column", "name");
        String[] actualColumnNames = {"employeeid", "lastname", "firstname", "title", "titleofcourtesy", "birthdate", "hiredate", "address", "city", "region", "postalcode", "country", "homephone", "extension", "notes", "reportsto", "photopath"};
        for (int i = 0; i < columnNames.size(); i++) {
            Assert.assertTrue(columnNames.get(i).equalsIgnoreCase(actualColumnNames[i]));
        }

        List<String> output = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/output", "name");
        Assert.assertTrue(output.get(0).equalsIgnoreCase("user/totalCommerce/testcsvfolder"));

        List<String> input = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/input", "name");
        Assert.assertTrue(input.get(0).equalsIgnoreCase("northwind.employees"));

        List<String> queryText = XMLReaderUtil.readAttributesFromXmlTagName(localXmlPath, "queryText");
        Assert.assertTrue(queryText.get(0).equalsIgnoreCase("INSERT OVERWRITE DIRECTORY 'user/totalCommerce/testcsvfolder' select * from northwind.employees"));

    }

    @Given("^user converts the \"([^\"]*)\" xml file to json file$")
    public void user_converts_the_xml_file_to_json_file(String... arg) {
        try {
            jsonobject = XML.toJSONObject(new String(Files.readAllBytes(Paths.get(propLoader.prop.getProperty("logsDestinationPath") + arg[0]))));
            System.out.println(jsonobject);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Then("^verify all the \"([^\"]*)\" config parameters in the xml$")
    public void verify_all_the_config_parameters_in_the_xml(String arg1, DataTable table) {
        try {
            if ((arg1.equalsIgnoreCase("hive"))) {
                Map<String, String> expProperties = table.asMap(String.class, String.class);
                TreeMap<String, String> expectedProperties = new TreeMap<String, String>();
                expectedProperties.putAll(expProperties);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected properties are  " + expectedProperties);
                List<String> listofProperties = XMLReaderUtil.readAttributesFromXmlTagName(propLoader.prop.getProperty("logsDestinationPath") + "IdcScanHive.xml", "name");
                List<String> listofPropertyValues = XMLReaderUtil.readAttributesFromXmlTagName(propLoader.prop.getProperty("logsDestinationPath") + "IdcScanHive.xml", "value");
                TreeMap<String, String> actualProperties = CommonUtil.loadTwoListsIntoTreeMap(listofProperties, listofPropertyValues);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected properties are  " + actualProperties);
                Assert.assertEquals(actualProperties, expectedProperties);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Properties are matached");

            } else if (arg1.equalsIgnoreCase("hdfs")) {

                Map<String, String> expProperties = table.asMap(String.class, String.class);
                TreeMap<String, String> expectedProperties = new TreeMap<String, String>();
                expectedProperties.putAll(expProperties);
                List<String> listofProperties = XMLReaderUtil.readAttributesFromXmlTagName(propLoader.prop.getProperty("logsDestinationPath") + "IdcScanHdfs.xml", "name");
                List<String> listofPropertyValues = XMLReaderUtil.readAttributesFromXmlTagName(propLoader.prop.getProperty("logsDestinationPath") + "IdcScanHdfs.xml", "value");
                TreeMap<String, String> actualProperties = CommonUtil.loadTwoListsIntoTreeMap(listofProperties, listofPropertyValues);
                Assert.assertEquals(actualProperties, expectedProperties);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Properties are matached");

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Given("^delete the downloaded \"([^\"]*)\" file$")
    public void delete_the_downloaded_file(String arg1) {
        try {
            String filePath = propLoader.prop.getProperty("logsDestinationPath") + arg1;
            //create a new file
            File file = new File(filePath);

            if (file.exists()) {
                file.delete();
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), file.getPath() + "does not exists");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Unable to to delete the file successfully");
            e.printStackTrace();
        } finally {
        }
    }

    @And("^user waits for the query to be succeeded$")
    public void userWaitsForTheQueryToBeSucceeded() throws Throwable {
        WebElement flag = new AmbariPage(driver).getSuccessFlag();
        synchronizationVisibilityofElement(driver, flag, 300);

    }


    @And("^user validates the operation,execution Tags and their count =\"([^\"]*)\" in the xml for the query\"([^\"]*)\"$")
    public void userValidatesTheOperationExecutionTagsAndTheirCountInTheXmlForTheQuery(int count, String query) throws Throwable {
        String localXmlPath = "src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1306_Scenario1.xml";
        List<String> operationName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation", "name");
        String expectedQuery = new JsonRead().readJSon("IDCEventFile", "IDCEvent_E" + query);

        expectedQuery = expectedQuery.replaceAll("\\s+", "");
        Assert.assertTrue(operationName.get(0).equalsIgnoreCase(expectedQuery));

        List<String> executionName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/execution", "name");
        Assert.assertEquals(executionName.size(), count);

    }


    @Then("^The overall xml should have \"([^\"]*)\" operation Tag and \"([^\"]*)\" execution Tags$")
    public void theOverallXmlShouldHaveOperationTagAndExecutionTags(int operationCount, int executionCount) throws Throwable {

        String localXmlPath = "src/test/resources/testdata/features/querylog/queryLogFiles/MLP-1306_Scenario1.xml";
        List<String> operationName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation", "name");
        Assert.assertEquals(operationName.size(), operationCount);

        List<String> executionName = XMLReaderUtil.readAttributesFromXmlAttributes(localXmlPath, "//cluster/operationService/operationTask/operation/execution", "name");
        Assert.assertEquals(executionName.size(), executionCount);


    }

    @And("^user logs in as different user from Putty and execute the same query\"([^\"]*)\" and different query \"([^\"]*)\"$")
    public void userLogsInAsDifferentUserFromPuttyAndExecuteTheSameQueryAndDifferentQuery(String query1, String query2) throws Throwable {

        SSHBean sshdemobean = new SSHBean();
        if (sshdemobean.openConnection("10.33.6.122", 2222, "root", "hortonworks", 120000)) {
            System.out.println("Connected to the server successfully !!!");

            sshdemobean.sendCommand("hive \n");
            Thread.sleep(15000);
            System.out.println("Result:" + sshdemobean.recvData());

            sshdemobean.sendCommand(new JsonRead().readJSon("Queries", "QueryLog_Q" + query1) + "\n");
            Thread.sleep(45000);
            System.out.println("Result:" + sshdemobean.recvData());

            sshdemobean.sendCommand(new JsonRead().readJSon("Queries", "QueryLog_Q" + query2) + "\n");
            Thread.sleep(45000);
            System.out.println("Result:" + sshdemobean.recvData());
            //closing ssh session after send all command
            sshdemobean.close();

        } else {
            System.out.println("System Failed to connect to the Shell");
            Assert.assertFalse(true);
        }

    }

    @And("^user configure the advance search for the login$")
    public void userConfigureTheAdvanceSearchForTheLogin() throws Throwable {
        new DashBoardPage(driver).getSetting().click();
        sleepForSec(1000);
        synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getPreference(), 10);
        new DashBoardPage(driver).getPreference().click();
        sleepForSec(1000);
//      if(new DashBoardPage(driver).getAdvanceSearch().isEnabled()){
//            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Advanced search checkbox is enabled");
//        }else{
        new DashBoardPage(driver).getAdvanceSearch().click();
//            sleepForSec(1000);
//        }
        new DashBoardPage(driver).getSaveButton().click();
        sleepForSec(500);
        new DashBoardPage(driver).getExitButton().click();
        sleepForSec(1500);
        refresh(driver);
        sleepForSec(1000);


    }


    @And("^user verifies whether all the event files are moved to catalog Hive$")
    public void userVerifiesWhetherAllTheEventFilesAreMovedToCatalogHive() throws Throwable {
        int fileCheck = 0;
        do {
            fileCheck = sftpConnection.countOfFilesInDirectory(propLoader.prop.getProperty("eventFileDirectoryPath"), "*.json");
        } while (fileCheck != 0);
        sleepForSec(3000);
    }

    // ==============================NEW STEPS DEFINITION FOR IDA PLUGINS*****************=============================

    @And("^user connects to the SFTP server and downloads the \"([^\"]*)\"$")
    public void userConnectsToTheSFTPServerAndDownloadsThe(String fileFormat) {
        try {
            if (fileFormat.equalsIgnoreCase("eventFile")) {
                fileSource = sftpConnection.retrieveFilesInDirectory(propLoader.prop.getProperty("eventFileDirectoryPath"), propLoader.prop.getProperty("DestinationEventFilePath"), "*.json");
                sleepForSec(2000);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " File retrived successfully");
            } else if (fileFormat.equalsIgnoreCase("messages.log")) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("Message.Log"), propLoader.prop.getProperty("logsDestinationPath") + "message.log");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " File retrived successfully");
            } else {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("CatalogerLogs") + fileFormat, propLoader.prop.getProperty("logsDestinationPath") + fileFormat);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " File retrived successfully");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Unable to retrive files from the SFTP Location");
            Assert.fail("Unable to retrive files from the SFTP location");
        }
    }

    @And("^user checks whether the event files directory has \"([^\"]*)\" event files$")
    public void userChecksWhetherTheEventFilesDirectoryHasEventFiles(int expectedCount) {
        try {
            // int COUNT = sftpConnection.countOfFilesInDirectory(propLoader.prop.getProperty("eventFileDirectoryPath"), "*.txt");
            int COUNT = sftpConnection.countOfFilesInDirectory(propLoader.prop.getProperty("eventFileDirectoryPath"), "*.json");
            Assert.assertEquals(COUNT, expectedCount);
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }


    @Then("^user finds the entry in \"([^\"]*)\" when the \"([^\"]*)\" plugin is stopped$")
    public void userFindsTheEntryInWhenThePluginIsStopped(String arg0, String arg1) {
        try {
            String path = propLoader.prop.getProperty("logsDestinationPath") + arg0;
            String searchText = null;
            switch (arg1) {
                case "HiveMonitor":
                    searchText = Constant.HiveMonitorStopPluginMessage;
                    break;
                case "HdfsMonitor":
                    searchText = Constant.HdfsMonitorStopPluginMessage;
                    break;
                case "HiveMonitor_Running":
                    searchText = Constant.HiveMonitorRunningMessage;
                    break;
                case "HdfsMonitor_Running":
                    searchText = Constant.HdfsMonitorRunningMessage;
                    break;
                case "HiveCatalogerScanInitiated":
                    searchText = Constant.HiveCatalogerScanInitiated;
                    break;
                case "HiveCatalogerTagsScannedEntry":
                    searchText = Constant.HiveCatalogerTagsScannedEntry;
                    break;
                case "HiveCatalogerDatabaseScanEntry":
                    searchText = Constant.HiveCatalogerDatabaseScanEntry;
                    break;
                case "HiveCatalogerDatabaseRetrivalEntry":
                    searchText = Constant.HiveCatalogerDatabaseRetrivalEntry;
                    break;
                case "HiveCatalogerTableScanEntry1":
                    searchText = Constant.HiveCatalogerTableScanEntry1;
                    break;
                case "HiveCatalogerFieldSchemaEntry1":
                    searchText = Constant.HiveCatalogerFieldSchemaEntry1;
                    break;
                case "HiveCatalogerTableScanEntry2":
                    searchText = Constant.HiveCatalogerTableScanEntry2;
                    break;
                case "HiveCatalogerFieldSchemaEntry2":
                    searchText = Constant.HiveCatalogerFieldSchemaEntry2;
                    break;
                case "HiveCatalogertoDataAnalyzerEntry":
                    searchText = Constant.HiveCatalogertoDataAnalyzerEntry;
                    break;
                case "HiveCatalogerDataAnalyzerStartedEntry":
                    searchText = Constant.HiveCatalogerDataAnalyzerStartedEntry;
                    break;
                case "HiveCatalogerDataAnalyzerStartedConfirmation":
                    searchText = Constant.HiveCatalogerDataAnalyzerStartedConfirmation;
                    break;

            }
            int existence = FileUtil.searchContentsofFile(path, searchText);
            if (existence != 0) {
                Assert.assertTrue(true);
            }
        } catch (Exception e) {
            Assert.fail("No Entry available in the Log: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("No Entry available in the Log:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user executes the query\"([^\"]*)\" on the Hive JDBC$")
    public void userExecutesTheQueryOnTheHiveJDBC(String arg0) {
        try {
            String query = new JsonRead().readJSon("QueryParser", arg0);
            new HiveJdbc().runHiveQuery(query);
        } catch (Exception e) {
            Assert.fail("Unable to execute the Queries on Hive JDBC: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @And("^user waits for the delta time to be completed for the monitor to trigger Cataloger$")
    public void userWaitsForTheDeltaTimeToBeCompletedForTheMonitorToTriggerCataloger() {
        sleepForSec(5000);
    }

    @Then("^user validates the entries in \"([^\"]*)\"$")
    public void userValidatesTheEntriesIn(String arg0, DataTable table) {
        try {
            List<CucumberDataSet> log = table.asList(CucumberDataSet.class);
            String path = propLoader.prop.getProperty("logsDestinationPath") + arg0;
            String searchText = null;
            for (CucumberDataSet set : log) {
                switch (set.getLogEntry()) {
                    case "HiveMonitor":
                        searchText = Constant.HiveMonitorStopPluginMessage;
                        break;
                    case "HdfsMonitor":
                        searchText = Constant.HdfsMonitorStopPluginMessage;
                        break;
                    case "HiveMonitor_Running":
                        searchText = Constant.HiveMonitorRunningMessage;
                        break;
                    case "HdfsMonitor_Running":
                        searchText = Constant.HdfsMonitorRunningMessage;
                        break;
                    case "HiveCatalogerScanInitiated":
                        searchText = Constant.HiveCatalogerScanInitiated;
                        break;
                    case "HiveCatalogerTagsScannedEntry":
                        searchText = Constant.HiveCatalogerTagsScannedEntry;
                        break;
                    case "HiveCatalogerDatabaseScanEntry":
                        searchText = Constant.HiveCatalogerDatabaseScanEntry;
                        break;
                    case "HiveCatalogerDatabaseRetrivalEntry":
                        searchText = Constant.HiveCatalogerDatabaseRetrivalEntry;
                        break;
                    case "HiveCatalogerTableScanEntry1":
                        searchText = Constant.HiveCatalogerTableScanEntry1;
                        break;
                    case "HiveCatalogerFieldSchemaEntry1":
                        searchText = Constant.HiveCatalogerFieldSchemaEntry1;
                        break;
                    case "HiveCatalogerTableScanEntry2":
                        searchText = Constant.HiveCatalogerTableScanEntry2;
                        break;
                    case "HiveCatalogerFieldSchemaEntry2":
                        searchText = Constant.HiveCatalogerFieldSchemaEntry2;
                        break;
                    case "HiveCatalogertoDataAnalyzerEntry":
                        searchText = Constant.HiveCatalogertoDataAnalyzerEntry;
                        break;
                    case "HiveCatalogerDataAnalyzerStartedEntry":
                        searchText = Constant.HiveCatalogerDataAnalyzerStartedEntry;
                        break;
                    case "HiveCatalogerDataAnalyzerStartedConfirmation":
                        searchText = Constant.HiveCatalogerDataAnalyzerStartedConfirmation;
                        break;
                    case "HiveMonitorState":
                        searchText = Constant.HiveMonitorState;
                        break;
                    case "HiveMonitorDeltaTimeEntry":
                        searchText = Constant.HiveMonitorDeltaTimeEntry;
                        break;
                    case "HiveMonitorDatabaseFilterEntry":
                        searchText = Constant.HiveMonitorDatabaseFilterEntry;
                        break;
                    case "HiveMonitorChangeEntry":
                        searchText = Constant.HiveMonitorChangeEntry;
                        break;
                    case "HiveMonitorScanKickOff":
                        searchText = Constant.HiveMonitorScanKickOff;
                        break;
                    case "HiveMonitortoScannerMessage":
                        searchText = Constant.HiveMonitortoScannerMessage;
                        break;
                    case "HiveMonitorClearEvent":
                        searchText = Constant.HiveMonitorClearEvent;
                        break;
                    case "HiveCatalogerNoDatabaseEntry":
                        searchText = Constant.HiveCatalogerNoDatabaseEntry;
                        break;
                    case "HiveCatalogerDataBaseWithNoTables":
                        searchText = Constant.HiveCatalogerDataBaseWithNoTables;
                        break;
                    case "HdfsCatalogerScanInitiated":
                        searchText = Constant.HdfsCatalogerScanInitiated;
                        break;
                    case "HdfsCatalogerScanMessage":
                        searchText = Constant.HdfsCatalogerScanMessage;
                        break;
                    case "HdfsCatalogerFinishedMessage":
                        searchText = Constant.HdfsCatalogerFinishedMessage;
                        break;
                    case "HiveCatalogerBDAnalyzer":
                        searchText = Constant.HiveCatalogerBDAnalyzer;
                        break;
                }
                int existence = FileUtil.searchContentsofFile(path, searchText);
                if (existence != 0) {
                    Assert.assertTrue(true);
                    existence = 0;
                }else {
                    Assert.fail("\r\nUnix file content \n="+searchText + " \r\n didn't matched with unix messages \r\n" +FileUtil.returnFileContentToSTring(path));
                }

            }
        } catch (Exception e) {
            Assert.fail("No Entry available in the Log: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("No Entry available in the Log:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user executes the following Query in the Hive JDBC$")
    public void userExecutesTheFollowingQueryInTheHiveJDBC(DataTable table) {
        List<CucumberDataSet> queries = table.asList(CucumberDataSet.class);
        String hiveQuery = null;
        try {
            for (CucumberDataSet query : queries) {
                if (query.getQueryEntry().contains("Constant")) {
                    String filepath = query.getQueryEntry().replaceAll("Constant.REST_PAYLOAD", Constant.REST_PAYLOAD);
                    hiveQuery = FileUtil.readAllBytesInFile(filepath);
                    new HiveJdbc().runHiveQuery(hiveQuery);
                }else  {
                    hiveQuery = new JsonRead().readJSon("QueryParser", query.getQueryEntry());
                    new HiveJdbc().runHiveQuery(hiveQuery);
                }
            }
        } catch (SQLException e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Table/Database does not exist");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " :Table/Database does not exist");
        } finally {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), hiveQuery + " : executed successfully");
        }
    }

    @And("^user validates the existence of the Query under the following tables$")
    public void userValidatesTheExistenceOfTheQueryUnderTheFollowingTables(DataTable table) {
        List<CucumberDataSet> dataset = table.asList(CucumberDataSet.class);
        String searchContext = null;
        try {
            for (CucumberDataSet set : dataset) {
                scrollToWebElement(driver, new DashBoardPage(driver).getItemFullViewTable(set.getTableEntry()));
                searchContext = set.getQueryEntry();
                if (set.getQueryEntry().contains("Query")) {
                    searchContext = CommonUtil.getElementsInList().get(0);
                }
                for (int i = 1; i <= new DashBoardPage(driver).getItemFullViewTableSize(set.getTableEntry()).size(); i++) {
                    String expectedSearchText = new DashBoardPage(driver).getItemFullViewSearchValue(set.getTableEntry(), String.valueOf(i), "1").getText();
                    //*************** after the issue is communicated and fixed, below contains should be replaced with equal ignore case
                    sleepForSec(500);
                    if (expectedSearchText.contains(searchContext)) {
                        Assert.assertTrue(true);
                        clickOn(new DashBoardPage(driver).getItemFullViewSearchValue(set.getTableEntry(), String.valueOf(i), "1"));
                        sleepForSec(3000);
                        break;
                    }
                }
            }
            takeScreenShot(this.getClass().getSimpleName(), driver);
        } catch (Exception e) {
            takeScreenShot("Unable to click on " + searchContext + " under the Table", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user \"([^\"]*)\" Support full Solr syntax$")
    public void user_Support_full_Solr_syntax(String action) throws Throwable {
        try {
            switch (action) {
                case "Enable":
                    new DashBoardPage(driver).getSetting().click();
                    sleepForSec(1000);
                    synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getPreference(), 10);
                    new DashBoardPage(driver).getPreference().click();
                    sleepForSec(1000);
                    new DashBoardPage(driver).getAdvanceSearch().click();
                    new DashBoardPage(driver).getSaveButton().click();
                    sleepForSec(1500);
                    new DashBoardPage(driver).getExitButton().click();
                    sleepForSec(1500);
                    new DashBoardPage(driver).Click_administrationDashboard();
                    break;
                case "Disable":
                    new DashBoardPage(driver).getSetting().click();
                    sleepForSec(1000);
                    synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getPreference(), 10);
                    new DashBoardPage(driver).getPreference().click();
                    sleepForSec(1000);
                    new DashBoardPage(driver).getAdvanceSearch().click();
                    new DashBoardPage(driver).getSaveButton().click();
                    sleepForSec(1500);
                    new DashBoardPage(driver).getExitButton().click();
                    sleepForSec(1500);
                    break;
            }
        } catch (Exception e) {
            takeScreenShot("Solr Search is not enabled", driver);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail(e.getMessage());
        }

    }

    @Given("^user connects to the SFTP server and clear the \"([^\"]*)\"$")
    public void user_connects_to_the_SFTP_server_and_clear_the(String arg1) throws Throwable {
        try {
            sftpConnection.clearSFTPFileContent(propLoader.prop.getProperty("Message.Log"));

        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Unable to clear content of file in SFTP Location");
            Assert.fail("Unable to clear content of file in SFTP Location");
        }
    }

    @Given("^user retrieves \"([^\"]*)\" from sftp and store it in \"([^\"]*)\" as text format$")
    public void user_retrieves_from_sftp_and_store_it_in_as_text_format(String sourceFile, String storeFormat) throws Throwable {
        try {
            if (sourceFile.equalsIgnoreCase("messages.log")) {
                sftpConnection.retrieveFile(propLoader.prop.getProperty("Message.Log"), Constant.FEATURES + storeFormat);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " File retrived successfully");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Unable to retrive files from the SFTP Location");
            Assert.fail("Unable to retrive files from the SFTP location");
        }
    }

    @Given("^User update the ambari host in following files using json path$")
    public void user_update_the_ambari_host_in_following_files_using_json_path(DataTable values) throws Throwable {
        try {
            try {
                for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                    switch (data.get("node")) {
                        case "clusterManagerHost":
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("jsonPath"), propLoader.prop.getProperty("clusterHostName"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
                            break;
                        case "HeadlessEDINode":
                            if (data.get("jsonPath").contains("nodeCondition")) {
                                JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("jsonPath"), "name==" + "\"" + propLoader.prop.getProperty("clusterHostName") + "\"");

                            } else
                                JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + data.get("filePath"), data.get("jsonPath"), propLoader.prop.getProperty("clusterHostName"));
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
                            break;
                    }

                }
            } catch (Exception e) {
                Assert.fail(" ambari host not updated in json configuration file");
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
            }
        } catch (Exception e) {

        }
    }
}
