package com.asg.automation.stepdefinition.edi;


import com.asg.automation.utils.*;
import com.asg.automation.wrapper.RestAPIWrapper;
import com.asg.utils.productutils.*;
import cucumber.api.DataTable;
import cucumber.api.PendingException;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import de.rochade.ds.Server;
import org.testng.Assert;

import java.util.*;

import static com.asg.automation.utils.Constant.REST_PAYLOAD;
import static io.restassured.path.xml.XmlPath.from;
import static org.hamcrest.Matchers.hasItems;

/**
 * Created by muthuraja.ramakrishn on 4/17/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class EDIBusDefinition extends RestAPIWrapper {
    private static int id, rating;
    protected DBPostgresUtil db_postgres_util;
    RepoData repoData;
    protected EDIJavaAPIUtil ediJavaAPIUtil;
    private JsonRead jsonRead;
    private CommonUtil commonUtil;
    private XMLReaderUtil xmlReader;
    private FileUtil fileUtil;
    Server server = null;

    @Before()
    public void initialize(Scenario scenario) {
        /*Initializing Rest API Base URI, BasePath*/
        initializeRestAPI("IDC");
        ediJavaAPIUtil = new EDIJavaAPIUtil();
        propertyLoader();


        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "================================");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Scenario Test Execution Started");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "================================");

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "=====================================================================");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Scenario Test Execution Started for: " + scenario.getName());
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "======================================================================");


    }

    @After()
    public void tearDown(Scenario scenario) {
        /*Resetting Rest API Base URI, BasePath*/
        resetRestAPI();
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "=========================================================================");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Scenario Test Execution Completed: : " + scenario.getName());
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "==========================================================================");
    }


    @And("^user connects Rochade Server and \"([^\"]*)\" the items in EDI subject area$")
    public void userConnectsRochadeServerAndTheItemsInEDISubjectArea(String actionType, DataTable table) throws Throwable {
        ediJavaAPIUtil = new EDIJavaAPIUtil();
        try {
            String hostName = null;
            Integer portNumber = null;
            String username = null;
            String password = null;
            String database = null;
            String subjectArea = null;
            String subjectAreaVersion = null;
            String query = null;
            String itemType = null;
            String itemName = null;
            String itemCount = null;
            String itemNames = null;
            String attributeName = null;
            String attributeValue = null;
            String[] itemArray = null;
            String transactionName = null;
            Long transactionTime = null;
            String transactionStatus = null;
            String transactionOperation = null;
            Integer transactionID = null;
            String childItemType=null;
            String childItemName=null;
            String linkItemType=null;
            String linkItemName=null;
            String operationName=null;
            String renameName=null;


            for (Map<String, String> data : table.asMaps(String.class, String.class)) {
                hostName = propLoader.prop.getProperty("EDIHostName");
                portNumber = Integer.parseInt(propLoader.prop.getProperty("EDIPortNumber"));
                username = "ADMIN";
                password = "rochade";
                database = data.get("databaseName");
                subjectArea = data.get("subjectArea");
                subjectAreaVersion = data.get("subjectAreaVersion");
                query = data.get("query");
                itemType = data.get("itemType");
                itemName = data.get("itemName");
                itemNames = data.get("itemNames");
                itemCount = (data.get("itemCount"));
                attributeName = (data.get("attributeName"));
                attributeValue = (data.get("attributeValue"));
                transactionName = (data.get("transactionName"));
                transactionOperation = (data.get("transactionOperation"));
                transactionStatus = (data.get("transactionStatus"));
                childItemType = data.get("childItemType");
                childItemName = data.get("childItemName");
                linkItemType = data.get("linkItemType");
                linkItemName = data.get("linkItemName");
                operationName = data.get("operationName");
                renameName=data.get("renameName");
                int count = 0;
                if (data.get("transactionID") != null) {
                    transactionID = Integer.parseInt(data.get("transactionID"));
                }
                if (data.get("transactionTime") != null) {
                    transactionTime = Long.parseLong(data.get("transactionTime"));
                }
                ediJavaAPIUtil.connectDatabase(hostName, portNumber, username, password, database, subjectArea, subjectAreaVersion);
                switch (actionType) {
                    case "clears":
                        ediJavaAPIUtil.clearSubjectArea(query);
                        Assert.assertEquals(ediJavaAPIUtil.getCount(query), 0);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items deletion successful");
                        break;
                    case "add":
                        ediJavaAPIUtil.createItem(itemType, itemName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items addition successful");
                        break;
                    case "verifies":
                        count = ediJavaAPIUtil.getCount(query);
                        Assert.assertEquals(Integer.parseInt(itemCount), count);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item Count  : " + ediJavaAPIUtil.getCount(query));
                        break;
                    case "compare count":
                        count = ediJavaAPIUtil.getCount(query);
                        Assert.assertEquals(Integer.parseInt(CommonUtil.getTemporaryText()), count);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item count matches with EDI  : " + ediJavaAPIUtil.getCount(query));
                        break;

                    case "verify itemNames":
                        if (itemNames.contains(",")) {
                            itemArray = itemNames.split(",");
                            for (String items : itemArray) {
                                Assert.assertTrue(ediJavaAPIUtil.getItemNames(query).contains(items));
                            }
                        } else {
                            Assert.assertTrue(ediJavaAPIUtil.getItemNames(query).contains(itemNames));
                        }

                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EDI item Names  : " + ediJavaAPIUtil.getItemNames(query));
                        break;

                    case "verify itemNames notFound":
                        if (itemNames.contains(",")) {
                            itemArray = itemNames.split(",");
                            for (String items : itemArray) {
                                Assert.assertFalse(ediJavaAPIUtil.getItemNames(query).contains(items));
                            }
                        } else {
                            Assert.assertFalse(ediJavaAPIUtil.getItemNames(query).contains(itemNames));
                        }

                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EDI item Names  : " + ediJavaAPIUtil.getItemNames(query));
                        break;

                    case "compare lineage itemNames":
                        String[] splitlineagename = CucumberDataSet.facetSelectionNameToLineageHopName().get(itemName).split(",");

                        for (String splitname : splitlineagename) {
                            if (ediJavaAPIUtil.getItemNames(query).contains(splitname)) {
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EDI lineagehop matched");
                            } else {
                                Assert.fail("EDI ItemName" + ediJavaAPIUtil.getItemNames(query) + "and JSON response string" + splitname + "didn't matched");
                            }
                        }


                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EDI item Names  : " + ediJavaAPIUtil.getItemNames(query));
                        break;

                    case "compare itemNames":
                        Assert.assertTrue((ediJavaAPIUtil.getItemNames(query)).containsAll(CommonUtil.getTemporaryList()));
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item Name matches with EDI  : " + ediJavaAPIUtil.getItemNames(query));
                        break;

                    case "verify attributeValues":
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EDI Attribute Value  : " + ediJavaAPIUtil.getAttributeValue(itemType, itemName, attributeName));
                        Assert.assertTrue(ediJavaAPIUtil.getAttributeValue(itemType, itemName, attributeName).contains(attributeValue));
                        break;

                    case "verify attributeValues notFound":
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "EDI Attribute Value  : " + ediJavaAPIUtil.getAttributeValue(itemType, itemName, attributeName));
                        Assert.assertFalse(ediJavaAPIUtil.getAttributeValue(itemType, itemName, attributeName).contains(attributeValue));

                        break;
//                    case "compare count":
//                        count = ediJavaAPIUtil.getCount(query);
//                        Assert.assertEquals(Integer.parseInt(commonUtil.getTemporaryText()), count);
//                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item count matches with EDI  : " + ediJavaAPIUtil.getCount(query));
//                        break;

                    case "verify itemCount notNull":
                        count = ediJavaAPIUtil.getCount(query);
                        Assert.assertNotEquals(0, count);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item Count  : " + ediJavaAPIUtil.getCount(query));
                        break;

                    case "creates newTransaction":
                        ediJavaAPIUtil.createTransaction(transactionName, transactionTime);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Transaction Created  : " + transactionName);
                        break;

                    case "verify transactionStatus":
                        Assert.assertEquals(transactionStatus, ediJavaAPIUtil.getTransactionStatus(transactionName));
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Transaction Status  : " + transactionName + transactionStatus);
                        break;

                    case "updateTransaction":
                        ediJavaAPIUtil.updateTransaction(transactionName, transactionOperation);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Transaction Updated  : " + transactionName + transactionOperation);
                        break;

                    case "verify transactionID":
                        Assert.assertTrue(ediJavaAPIUtil.getListOfSubjectAreaID(transactionName).contains(transactionID));
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Transaction ID  : " + transactionName + transactionID);
                        break;

                    case "verify all EDI items presence in IDP":
                        Assert.assertTrue((CommonUtil.getTemporaryList()).containsAll(ediJavaAPIUtil.getItemNames(query)));
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "All Item Names in EDI are present in IDP  : " + ediJavaAPIUtil.getItemNames(query));
                        break;

                    case "addChildItem":
                        ediJavaAPIUtil.createChildItem(childItemType,childItemName,itemType, itemName,attributeName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items addition successful");
                        break;
                    case "linkItem":
                        ediJavaAPIUtil.linkItem(itemType,itemName,linkItemType,itemType,linkItemName,attributeName,operationName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link items successful");
                        break;
                    case "rename":
                        ediJavaAPIUtil.renameItem(itemName,itemType,renameName);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Renaming item is successful");
                        break;
                    case "verify lineageHopNames":
                        FileUtil.createFileAndWriteData(Constant.REST_DIR+"payloads/idc/EdiBusPayloads/lineageEDIBus.json","{}");
                        JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR+"payloads/idc/EdiBusPayloads/lineageEDIBus.json","lineageName", ediJavaAPIUtil.getItemNames(query));
                }

            }
        } catch (Exception | AssertionError e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while adding items");
            Assert.fail("Error while adding items" + e.getMessage());
        } finally {
            ediJavaAPIUtil.serverDispose();
        }
    }

    @And("^user connects Rochade Server and \"([^\"]*)\" the items in EDI subject areas$")
    public void userConnectsRochadeServerAndTheItemsInEDISubjectAreas(String actionType, DataTable table) throws Throwable {
        String hostName = null;
        Integer portNumber = null;
        String username = null;
        String password = null;
        String database = null;
        String licenseType = null;
        ediJavaAPIUtil = new EDIJavaAPIUtil();
        try {
            for (Map<String, String> data : table.asMaps(String.class, String.class)) {
                hostName = propLoader.prop.getProperty("EDIHostName");
                portNumber = Integer.parseInt(propLoader.prop.getProperty("EDIPortNumber"));
                username = "ADMIN";
                password = "rochade";
                database = data.get("databaseName");
                licenseType = data.get("licenseInfo");
                ediJavaAPIUtil.connectDatabase(hostName, portNumber, username, password, database);
            switch (actionType) {
                case "licenseUpdate":
                    if (licenseType.equals("windowsLineage")) {
                        Assert.assertTrue(ediJavaAPIUtil.licenseUpdate(hostName, portNumber, username, password, propLoader.prop.getProperty("EDICompanyName"), propLoader.prop.getProperty("EDIWindowsLineageLicenseKey")));
                    } else if (licenseType.equals("windowsNonLineage")) {
                        Assert.assertTrue(ediJavaAPIUtil.licenseUpdate(hostName, portNumber, username, password, propLoader.prop.getProperty("EDICompanyName"), propLoader.prop.getProperty("EDIWindowsLicenseKey")));
                    }
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "License Updated");
                    break;


            }
        }
        }
        catch (Exception | AssertionError e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error while adding items");
            Assert.fail("Error while adding items" + e.getMessage());
        } finally {
            ediJavaAPIUtil.serverDispose();
        }
    }
}






