package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.SubjectAreaManagement;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.List;

public class SubjectAreaMgmtActions extends  SubjectAreaManagement {
    public SubjectAreaMgmtActions(WebDriver driver) {
        super(driver);
    }

    public void userSelectsCatalogAndTypeFromCreateItemPanel(String catalogName, String typeName){
        genericClick("Create button");
        genericClick("Catalog dropdown",catalogName);
        genericClick("Type dropdown",typeName);
    }

    public void userSelectsRootTypeAndItemNameFromCreateItemPanel(String rootType, String itemName){
        genericClick("Root Item Type",rootType);
        genericClick("Root Item Name",itemName);
    }

    public void genericActions(String actionType, String elementName, String... argu){
        switch (actionType.toLowerCase()) {
            case "click":
                if (argu.length==0)
                    genericClick(elementName);
                else
                    genericClick(elementName, argu[0]);
                break;

            case "double click":
                break;

            case "dynamic click":
                break;

            case "verifies displayed":
                if (argu.length==0)
                genericVerifyElementPresent(elementName);
                else
                    genericVerifyElementPresent(elementName, argu[0]);
                break;

            case "verifies not displayed":
                if (argu.length==0)
                    genericVerifyElementNotPresent(elementName);
                else
                    genericVerifyElementNotPresent(elementName, argu[0]);
                break;

            case "verify equals":
                break;

            case "verify not equals":
                break;

            case "verify disabled":
                break;

             case "verifies disabled":
                genericVerifyDisabled(elementName);
                break;

        }
    }

}

