package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.*;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.asg.automation.utils.Constant.REST_PAYLOAD;

/**
 * Created by Divya.Bharathi on 01/31/2019
 */
public class SubjectAreaManagerActions extends SubjectArea {

    public SubjectAreaManagerActions(WebDriver driver) {
        super(driver);
    }

    public void genericActions(String actionType,String... arg) throws Exception {
        switch (actionType) {
            case "click":
                if (arg.length == 1)
                    genericClick(arg[0]);
                else
                    genericClick(arg[0], arg[1]);
                break;
            case "item view click":
                genericClick(actionType, arg[1], arg[0]);
                break;

            case "Item Full View Close":
                genericClick(actionType);
                break;
            case "navigatesToTab":
                genericClick(actionType, arg[0]);
                break;
            case "Delete":
                genericClick(actionType);
                break;
            case "dynamic item click":
                genericClick(actionType,arg[0]);
                break;

            case "widget not present":
                genericVerifyElementNotPresent(actionType, arg[0]);
                break;

            case "widget presence":
                genericVerifyElementPresent(actionType, arg[0]);
                break;

            case "definite facet selection":
                genericClick(actionType, arg[0], arg[1]);
                break;
                //10.3 New UI

            case "facet selection":
                genericClick(actionType, arg[0], arg[1]);
                break;
            case "item click":
                genericClick(actionType, arg[0]);
                break;
            case "catalog not contains":
                Assert.assertFalse(verifyElementNotPresent(actionType, arg[0], arg[1]));
                break;

            case "click and switch tab":
                genericClick(actionType, arg[0], arg[1], arg[2]);
                break;
            case "latest analysis click":
                genericClick(actionType, arg[0]);
                break;
            case "checkbox selection":
                genericClick(actionType, arg[0]);
                break;

            case "section not present":
                genericVerifyElementNotPresent(actionType, arg[0]);
                break;

            case "section presence":
                genericVerifyElementPresent(actionType, arg[0]);
                break;

            case "chart widget presence":
                genericVerifyElementPresent(actionType, arg[0]);
                break;
            case "facet Show button presence":
                genericVerifyElementPresent(arg[0], arg[1]);
                break;
            case "verifies displayed":
                if (arg.length == 1)
                    genericVerifyElementPresent(arg[0]);
                else
                    genericVerifyElementPresent(arg[0], arg[1]);
                break;
            case "verifies not displayed":
                genericVerifyElementNotPresent(arg[0]);
                break;
            case "Select item":
                genericClick(actionType, arg[0]);
                break;
            case "verify element is enabled":
                genericVerifyElementIsEnabled(arg[0]);
                break;
            case "verify element is disabled":
                genericVerifyElementIsDisabled(arg[0]);
                break;
        }

    }

    public void verifyCount(String elementName, String... arg) {
        switch (elementName) {
            case "items count":
                genericVerifyEquals(elementName, arg[0]);
                break;
            case "file count":
                genericVerifyEquals(elementName, arg[0]);
                break;
            case "search first item":
                genericVerifyEquals(elementName, arg[0]);
                break;
            case "search result":
                genericVerifyEquals(elementName, arg[0]);
                break;
            case "search item count":
                genericVerifyEquals(elementName, arg[0]);
                break;
        }
    }

    public void deleteMultipleItemsinUI(String... arg) throws Throwable {
        //arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]
        //action, type, catalogName, name, query, param
        deleteMultipleItems(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]);
    }

    public void getItemCountInSearchView() {
        Assert.assertEquals(commonUtil.getExactNumfromUISearchResults(getItemCount().getText()), CommonUtil.getText());
    }

    public void verifyMetadataProperties(String elementName, List<String> data) throws Exception {
        isDataSetElementPresentInList(data, elementName);
    }

    public void verifyMetadataPropertyValues(String actionType, String itemName, List<Map<String, String>> data) throws Exception {
        isDataSetElementPresentInMap(data, actionType, itemName);
    }

    public void verifyDataSampleValuesPresence(String itemName, List<Map<String, String>> data) throws Exception {
        Assert.assertTrue(isDataSetElementPresentInMap(data, itemName));
    }

    public void getS3FileCount(String bucketName,String dirPath){
          getAwsFileCount(bucketName,dirPath);
    }


    public void writeMetaDataContentToFile(Map<String, String> arg) {
        writeMetaDataValueToFile(arg);

    }
    public void writeMetaDataToFile(Map<String, String> arg) throws IOException, ParseException {
        String targetFile=arg.get("actualFilePath");
        String jsonpath=arg.get("jsonpath");
        String attributeName=arg.get("attributeName");
        JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + targetFile, jsonpath, getPropertyMetadata(attributeName).getText());
    }

    public void getValueFromJsonFile(String actionType, String fileName, String Action, String jsonpath, String AttributeName) throws FileNotFoundException, ParseException {
        switch (actionType) {
            case "Get": {
                String Json_Value = JsonRead.getJsonValue(REST_PAYLOAD + fileName, jsonpath);
                String Formatted_Value=Json_Value.replaceAll("\\[", "").replaceAll("\\]","").replace("\"", "");
                if (Action.equalsIgnoreCase("NotEquals")) {
                    String Metadata_Value = getPropertyMetadata(AttributeName).getText();
                    Assert.assertNotEquals(Metadata_Value, Formatted_Value);
                }
                else if (Action.equalsIgnoreCase("Equals")) {
                    String Metadata_Value = getPropertyMetadata(AttributeName).getText();
                    Assert.assertEquals(Metadata_Value, Formatted_Value);
                }
                else {
                    Assert.fail("Values are not there");
                }
                break;
            }

        }
    }

    public void verifyTableRelationship(String elementType, String elementName, List<Map<String,String>> datamap) throws Exception{
        Assert.assertTrue(verifyRelationship(elementType,elementName,datamap));
    }

    public void verifyElementPresence(String actionType, String... arg) throws Exception {
        try {
            switch (actionType) {
                case "verify analysis log contains":
                    genericVerifyElementPresent(actionType, arg[0]);
                    break;

                case "verify logtext not contains":
                    if (verifyElementNotPresent(actionType, arg[0]) == false) {
                    throw new Exception();
                    }
                case "verify breadcrumb contains":
                    genericVerifyElementPresent(actionType, arg[0]);
                    break;
                case "verify widget contains":
                    genericVerifyElementPresent(actionType, arg[0], arg[1]);
                    break;
            }
        } catch (Exception e) {
            Assert.fail("Verification fails:" + e.getMessage());
        }

    }

    public boolean verifyTagWithFileName(String ...arg) {
        //arg[0]= catalogName; arg[1]=name; arg[2]=Tag; arg[3]=facetType; arg[4]=fileName;
        boolean flag = false;
        try {
            if (verifyTagPresenceForFileName(arg[0],arg[1], arg[2], arg[3], arg[4]) == true) {
                flag = true;
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return flag;
    }

    public boolean verifyTagInSearchResult(String ...arg){

        boolean flag = false;

        if (verifyTagPresenceInSearchResult(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]) == true) {
            flag = true;

        }

        return flag;
    }

    public boolean verifyTagNotInSearchResult(String... arg) {

        boolean flag = false;

        if (verifyTagNonPresenceInSearchResult(arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]) == true) {
            flag = true;

        }

        return flag;
    }

    public boolean verifyWindowNotAvailable(String... arg) {
        // arg[0]= catalogName, arg[1]= facetName, arg[2]= facet, arg[3]= itemName, arg[4]= windowName
        boolean flag = false;

        if (verifyWindowNonPresence(arg[0], arg[1], arg[2], arg[3], arg[4]) == true) {
            flag = true;

        }

        return flag;
    }

    public boolean verifyTag_navigatedItems(String arg,String item) {
        boolean flag = false;
        try {
            if (verifyTagPresence_1(arg,item) == true) {
                flag = true;
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return flag;
    }
    public Map<String,String> MapValuefromJson(String actionType, String filePath, String jsonPath){
        Map<String,String> hm = new HashMap<>();
        try{
            switch (actionType.toLowerCase()){
                case "verifies":
                    hm = getMapValueFromJson(filePath,jsonPath);
                    break;
            }
        }catch(Exception e){
            e.getMessage();
        }
        return hm;
    }

    public void verifyJsonValue(String actionType, String filePath, String jsonValue, String expectedValue, String expectedFilePath)throws Exception{
        if(verifyValue(actionType,filePath,jsonValue,expectedValue,expectedFilePath) == false){
            throw new Exception();
        }
    }

    public void verifyMetadataPropertiesNotContains(String elementName, List<String> data) throws Exception {
        if(isDataSetElementNotPresentInList(data, elementName) == false){
            throw new Exception();
        }
    }

    public void verifyMetadataPropertiesContains(String propertyName, String expectedText) throws Exception {
        isDataSetElementContainsInList(propertyName,expectedText);
    }

    public void verifyItemResultsSort(String value) throws Exception{
        try {
            Assert.assertTrue(sortItemsInResultPage(value));
        }catch(Exception e){
            Assert.fail("Sort Item Results failed : "+e.getMessage());
        }
    }


    public boolean verifyElementNonPresence(Map<String, String> mapValues, String... actionType) throws Exception {
        boolean flag = true;
        switch (actionType[1]) {
            case "Empty Values":
                try {
                    if (verifyMapElementNotPresent(mapValues, actionType[1]) == false) {
                        flag = false;
                    }
                } catch (Exception e) {
                    throw new Exception("Values displayed in UI");

                }
                break;

        }

        return flag;
    }


    public void removeAttributesFromThePanel(String elementName, List<String> data) throws Exception {
        removeAttribute(elementName,data);
    }

    public boolean verifyElementNonPresence(List<Map<String, String>> mapValues, String... actionType) throws Exception {
        boolean flag = true;
        switch (actionType[0]) {
            case "password encrypted":
                Assert.assertFalse(verifyMapElementNotPresent(mapValues, actionType[0]));
                try {
                    if (verifyMapElementNotPresent(mapValues, actionType[0]) == false) {
                        flag = false;
                    }
                } catch (Exception e) {
                    throw new Exception("Values displayed in UI");
                }
                break;

        }

        return flag;
    }

    //10.3 New UI Implementations

    public void verifyDBValuesAndUIValues(List<String> itemList, String... values) throws Exception {
        switch (values[0]) {
            case "metadata property values":
                Assert.assertTrue(assertDBValuesAndUIValues(values[0], values[1], values[2], itemList));

        }
    }

    public void verifyElementPresence(List<String> itemList, String... actionType) throws Exception {
        switch (actionType[0]) {
            case "verify presence":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[1]));
                break;
            case "presence of facets":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "verify non presence":
                Assert.assertFalse(verifyListElementNotPresent(itemList,actionType[1]));
                break;
            case "Most frequent values":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "Presence of Search Tag":
                actionType[1]=CommonUtil.getText();
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "presence of Tag facets":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "Presence of Assigned Tag":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "Presence of Sorted Tag":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "Presence of Sorted List":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "Tag List in facet":
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "non presence of facets":
                Assert.assertFalse(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "presence of search configuration":
                actionType[1]=CommonUtil.getText();
                Assert.assertTrue(isDataSetElementPresentInList(itemList, actionType[0], actionType[1]));
                break;
        }
    }

    public boolean verifyTag(String ...arg) {
        //arg[0]= catalogName; arg[1]=name; arg[2]=Tag; arg[3]=facetType
        boolean flag = false;
        try {
            if (verifyTagPresence(arg[0],arg[1], arg[2], arg[3]) == true) {
                flag = true;
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return flag;
    }

    public void verifyFacetTypeAndCounts(String facetType,String count,String sectionName){
        if (getShowAllButtonInDashboardPage()) {
            genericClick("showAll_Button");
        }
        LoggerUtil.logInfo("Expected count for " + facetType + " is " + getFacetTypeCount(facetType, sectionName).getText() + " actual is " + count);
        Assert.assertEquals(getFacetTypeCount(facetType, sectionName).getText(), count);
    }

    public void verifymetaDataValues(String filePath, String jsonPath, String metadataSection) throws Exception {
        Assert.assertTrue(verifyMetadatavaluesWithJson(filePath,jsonPath,metadataSection));
    }

    public void verifyLineageHopValues(String filePath, String jsonPath ) throws Exception {
        Assert.assertTrue(verifyLineageHopValuesWithJson(filePath,jsonPath));
    }

    public void verifyValuesfromUIandDB(String actionType, String elementName) {
        String set= null;
        try {
            switch (actionType) {
                case "verifies":
                    if (compareValuesfromDBandUI(elementName,  set) == false) {
                        throw new Exception();
                    }
                    break;
            }

        } catch (Exception e) {
            Assert.fail("Values in Item Search result page of UI and DB doesn't match");
        }
    }

    public void verifyValuesfromUIandDB(String actionType,String tabName, String elementName) {
        try {
            switch (actionType) {
                case "verifies":
                    if (compareValuesfromDBandUI(elementName, tabName) == false) {
                        throw new Exception();
                    }
                    break;
            }

        } catch (Exception e) {
            Assert.fail("Values in Item Search result page of UI and DB doesn't match");
        }
    }

    public void verifyTabSectionValues(String actionType, String tabName, List<String> values){
        try {
            switch (actionType) {
                case "verifies tab section values":
                    Assert.assertTrue(isValuesPresnetinTabSection(tabName, values));
                    break;
                case "verifies tab non presence section values":
                    Assert.assertTrue(isValuesNotPresnetinTabSection(tabName, values));
                    break;
            }
        }catch (Exception e){
            Assert.fail(e.getMessage());
        }

    }

    public void validateElementInSearchResultPage (String actionType, String fieldName, String option, String actionItem) throws Exception {
        switch (actionType) {
            case "Color code for each type":
                Assert.assertTrue(searchPageValidations(actionType, fieldName, option, actionItem));
                break;
            case "Short name for each type":
                Assert.assertTrue(searchPageValidations(actionType, fieldName, option, actionItem));
                break;
        }
    }

    public void verifyMetadataAttributesNotContains(String elementName, List<Map<String,String>> data) throws Exception {
        if(isDataSetElementNotPresentInListMap(data, elementName) == false){
            throw new Exception();
        }
    }
    public void ValidateTrustPolicyRules(String actionType, String ItemName, String actionItem,String Section) throws Exception {
        switch (actionType) {
            case "Create and Edit Rules":
                trustPolicyRulesValidations(actionItem, ItemName,Section);
                break;
            case "Change Trust Policy Label":
                trustPolicyRulesValidations(actionItem, ItemName,Section);
                break;
            case "Change Trust Policy Factor":
                trustPolicyRulesValidations(actionItem, ItemName,Section);
                break;
        }
    }

    public void tagVerification(String... arg)throws Exception{
            Assert.assertTrue(tagValueVerification(arg[0],arg[1]));
    }

    public void storeMetadataValueAction(String action, String... args) throws Exception {
        switch (action) {
            case "store":
                String value=getAttributeValue(args[0], args[1]);
                commonUtil.storeTemporaryText(value);
                break;

            case "verify equals":
                genericVerifyEquals(action,args);
                break;

            case "store as Static":
                String staticValue = getAttributeValue(args[0], args[1]);
                CommonUtil.storeText(args[1]);
                FileUtil.createFileAndWriteData(Constant.LocalDirectory,staticValue);
                break;
            case "verify not equals":
                genericVerifyEquals(action, args[0], args[1]);

                break;
        }

    }


    public boolean verifyMetadataAttributesNotAvailable(String metaDataAttribute, String widgetName) throws Exception {
        boolean flag = false;
        try {
            if(isMetadataAttributeNotAvailable(metaDataAttribute, widgetName) == true){
                flag = true;
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return flag;
    }

    public void caeLineage (List<String> list1, List<String> list2,String ...args) throws Exception{
        boolean flag=false;
        try{
            if(caeLineageGeneration(list1,list2,args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8])== false){
                Assert.fail("Lineage Generation failed");
            }
        }catch (AssertionError e){
            Assert.fail("Lineage Generation failed");
        }
    }

}


