package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.CommonPage;
import org.openqa.selenium.WebDriver;

/**
 * Created by Divya.Bharathi on 01/29/2019
 */
public class CommonActions extends CommonPage {

    public CommonActions(WebDriver driver) { super(driver);

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
                else
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                break;

            case "verify equals":
                if (dynamicItem.length==0)
                    genericVerifyEquals(elementName);
                else
                    genericVerifyEquals(elementName, dynamicItem[0]);
                break;

            case "verifies enabled":
                if (dynamicItem.length==0)
                    genericVerifyEnabled(elementName);
                else
                    genericVerifyEnabled(elementName, dynamicItem[0]);
                break;
            case "verifies disabled":
                break;

            case "enters text":
                break;

                //10.3 New UI
            case "displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementPresent(elementName);
                else
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                break;

            case "not displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementNotPresent(elementName);
                else
                    genericVerifyElementNotPresent(elementName, dynamicItem[0]);
                break;

        }
    }
    public void selectCatalogAndSearchItems(String catalogName,String itemName) {
        selectCatalogAndItemSearch(catalogName,itemName);
    }

    public void verifyPresence(String actionType, String fieldName, String alertMessage) throws Exception {
        switch (actionType) {
            case "validation message":
                validatePresence(actionType,fieldName,alertMessage);
                break;
            case "Hint text":
            case "background color":
            case "Save Search tooltip validation":
                validatePresence(actionType, fieldName, alertMessage);
            case "tooltip validation":
                validatePresence(actionType, fieldName, alertMessage);
                break;
        }
    }

    public void verifyPresenceOfTabFocus(String actionType,String fieldName, String actionItem,String itemName,String section,String reverseTab) throws Exception {
        switch (actionType) {
            case "Taborder ManageTags Validation":
                validatePresenceOfTabFocusManageTags(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder AssignTags Validation":
                validatePresenceOfTabFocusAssignTags(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder ItemViewScreen Validation":
                validatePresenceOfTabFocusItemView(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder ItemViewBA Validation":
                validatePresenceOfTabFocusItemViewEdit(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder Manage Roles validation":
                validatePresenceOfTabFocusManageRoles(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder Manage LDAP Users validation":
                validatePresenceOfTabFocusLDAPUsers(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder Manage Local Users validation":
                validatePresenceOfTabFocusLocalUsers(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            case "Taborder Manage Roles LDAP and Local User validation":
                validatePresenceOfTabFocusManageRolesLDAPLocalUsers(actionType,fieldName,actionItem, itemName,section,reverseTab);
                break;
            }
        }

    }
