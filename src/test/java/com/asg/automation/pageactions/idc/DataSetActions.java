package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.DataSets;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

/**
 * Created by Divya.Bharathi on 01/29/2019
 */
public class DataSetActions extends DataSets {

    public DataSetActions(WebDriver driver) {
        super(driver);
    }

    public void userClicksOnDataSetDashboardAndnavigatestoTheDatasetTab(String datasetName, String tabName) {
        genericClick("dataset_dashboard");
        dynamicClickActions("dataset", datasetName);
        dynamicClickActions("tab", tabName);
    }

    public void assignAnyDataSet(String datasetName){
        genericClick("assign dataset button");
        genericClick("Dataset_Dropdown");
        genericClick("selectDataset",datasetName);
        genericClick("Panel assign dataset button");
    }

    public void userCreatesADataset(String datasetName, String dataSetDescription){
        genericClick("assign dataset button");
        genericClick("create new dataset button");
        enterActions("DatasetName",datasetName);
        enterActions("DataSetDescription",dataSetDescription);
        genericClick("Submit button");
        genericClick("Panel assign dataset button");
    }

    public void userClicksOnDataSetDashboardAndnavigatestoTheDataset(String datasetName) {
        genericClick("dataset_dashboard");
        dynamicClickActions("dataset", datasetName);
    }

    public void userVerifiesWhetherTopUserWidgetIsDisplayedWithMandatoryInfo(){
        Assert.assertTrue(isDataSetElementPresent("callCountBlock"));
        Assert.assertTrue(isDataSetElementPresent("LastUser_Block"));
        Assert.assertTrue(isDataSetElementPresent("TopUsersBlock"));
    }

    public void clickItemCheckBox(String itemName) {
        clickFirstDataItemDisplayed(itemName);
    }

    public void genericActions(String actionType, String elementName, String... dynamicItem){
        switch (actionType.toLowerCase()) {
            case "click":
                if (dynamicItem.length==0)
                    genericClick(elementName);
                else
                    genericClick(elementName, dynamicItem[0]);
                break;
            case "double click":
                break;

            case "verify not displayed":
            if (dynamicItem.length==0)
                genericVerifyElementNotPresent(elementName);
            else
                genericVerifyElementNotPresent(elementName, dynamicItem[0]);
            break;

            case "verify not equals":
                break;

            case "verify displayed":
                if (dynamicItem.length==0)
                    genericVerifyElementPresent(elementName);
                else if (dynamicItem.length==1)
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                else if (dynamicItem.length==2)
                    genericVerifyElementPresent(elementName, dynamicItem[0],dynamicItem[1]);
                break;

            case "verify equals":
                genericVerifyEquals(elementName, dynamicItem[0]);
                break;

            case "verifies enabled":
                genericVerifyEnabled(elementName);
                break;

            case "verifies disabled":
                genericVerifyDisabled(elementName);
                break;

            case "enters text":
                enterActions(elementName,dynamicItem[0]);
                break;


        }
    }

}
