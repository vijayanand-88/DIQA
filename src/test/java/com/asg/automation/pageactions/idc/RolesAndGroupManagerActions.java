package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.RolesAndGroupManager;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.List;
import java.util.Map;

public class RolesAndGroupManagerActions extends RolesAndGroupManager {

    public RolesAndGroupManagerActions(WebDriver driver) {
        super(driver);
    }

    public void genericActions(String actionType, String elementName, String... dynamicItem){
        switch (actionType.toLowerCase()) {
            case "click":
                if (dynamicItem.length == 0)
                    genericClick(elementName);
                else
                    genericClick(elementName, dynamicItem[0]);
                break;
            case "double click":
                break;

            case "dynamic click":
                break;

            case "verifies displayed":
                genericVerifyElementPresent(elementName);
                break;

            case "displayed":
                genericVerifyElementPresent(elementName);
                break;

            case "verifies not displayed":
                genericVerifyElementPresent(elementName);
                break;

            case "verify equals":
                break;

            case "verify not equals":
                break;

        }
    }

    public void resizeWidgetRolesAndGroupManager(String widgetName, String resizeValue){
        genericClick(widgetName);
        genericClick(resizeValue);
    }

    public void validateElementsInManageAccessPage(String actionType, String actionToBeverified, List<String> data) throws Exception {
        switch (actionType) {
            case "verifies presense":
                validateElementPresense(actionToBeverified, data);
                break;
        }
    }

    public void manageAccessPageConfigurations(String actionType, String fieldName, String option) throws Exception {
        switch (actionType) {
            case "select dropdown":
                break;
            case "enter text":
                enterTextInAddRolesAndUsersPages(fieldName,option);
                break;
            case "Uncollapse dropdown":
                break;
            case "verifies displayed":
                genericVerifyElementPresent(fieldName,option);
                break;
            case "click":
                genericClick(fieldName,option);
                break;
        }
    }

    public void actionsInManageAccessRolesAndUsersPage(String actionType, String buttonName, String roleName) throws Exception {
        switch (actionType) {
            case "displayed":
                validateElementPresenseForRolesAndusers(buttonName, roleName);
                break;
        }
    }

}
