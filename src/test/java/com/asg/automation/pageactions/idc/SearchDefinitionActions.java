package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.SubjectArea;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.List;

/**
 * Created by Divya.Bharathi on 01/31/2019.
 */
public class SearchDefinitionActions extends SubjectArea {

    public SearchDefinitionActions(WebDriver driver) {
        super(driver);
    }

    public void selectType(String type) {
        if (getShowAllButtonInDashboardPage()) {
            genericClick("showAll_Button");
            genericClick("type",type);
        } else {
            sleepForSec(500);
            genericClick("type",type);
        }
    }

    public void userAssignsTagAnsSaveit() {
        genericClick("Assign/Unassign Tags");
        genericClick("create new tag");
        enterActions("enter tag details");
        genericClick("tagPanelSaveButton");
    }


    public void genericActions(String actionType, String elementName, String... dynamicItem){
        switch (actionType.toLowerCase()) {
            case "click":
                genericClick(elementName);
                break;

            case "double click":
                break;

            case "verify not displayed":
                if(dynamicItem.length==0)
                    genericVerifyElementNotPresent(elementName);
                else if(dynamicItem.length==1)
                    genericVerifyElementNotPresent(elementName,dynamicItem[0]);
                break;

            case "verify not equals":
                break;

            case "verify displayed":
                if(dynamicItem.length==0)
                    genericVerifyElementPresent(elementName);
                else if(dynamicItem.length==1)
                    genericVerifyElementPresent(elementName,dynamicItem[0]);
                break;

            case "verify equals":
                break;

            case "verifies enabled":
                break;

            case "verifies disabled":
                break;

        }
    }

    public void validatePresence(String actionType, String value, List<String> listValues) throws Exception{
        switch (actionType.toLowerCase()) {
            case "verifies presence":
                try {
                    Assert.assertTrue(facetListVerification(value, listValues));
                } catch (Exception e) {
                    Assert.fail("Sort Item Results failed : " + e.getMessage());
                }
                break;
        }
    }
}
