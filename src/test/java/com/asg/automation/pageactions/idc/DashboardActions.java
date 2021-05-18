package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.*;
import com.asg.automation.utils.LoggerUtil;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;

import java.util.List;

/**
 * Created by Divya.Bharathi on 01/29/2019.
 */
public class DashboardActions extends DashBoardPage {

    public DashboardActions(WebDriver driver) {
        super(driver);
    }

    public void clickHomeButton() {
        genericClick("Home Button");
    }

    public void clickAdministrationWidget() {
        genericClick("Administration");
    }

    public void clickLogoutButton() {
        genericClick("LogOut button");
    }

    public void clickItemViewManager() {
        genericClick("ITEM VIEW MANAGER");
    }

    public WebElement returnItremViewManager() {
        ItemViewManagement("ITEM VIEW MANAGER");
        return ItemViewManagement("ITEM VIEW MANAGER");
    }

    public void userOpensFirstNotificationFromTheList() {
        genericClick("notification_icon");
        genericClick("openFirstNotification");
    }

    public void genericActions(String actionType, String elementName, String... dynamicItem) {
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
                if (dynamicItem.length == 0)
                    genericVerifyElementPresent(elementName);
                else
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                break;
            case "verifies not displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementNotPresent(elementName);
                else
                    genericVerifyElementNotPresent(elementName, dynamicItem[0]);
                break;
            case "verify equals":
                genericVerifyEquals(elementName);
                break;

            case "verify not equals":
                break;

            case "enters text":
                enterActions(elementName, dynamicItem[0]);
                break;

            case "mouse hover":
                if (dynamicItem.length == 0)
                    genericMouseHover(elementName);
                else
                    genericMouseHover(elementName, dynamicItem[0]);
                break;

            case "displayed":
                if (dynamicItem.length==0) {
                    genericVerifyElementPresent(elementName);
                } else
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                break;
            case "not displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementNotPresent(elementName);
                else
                    genericVerifyElementNotPresent(elementName, dynamicItem[0]);
                break;

            case "enabled":
                genericVerifyElementIsEnabled(elementName);
                break;

            case "disabled":
                genericVerifyElementIsDisabled(elementName);
                break;
            case "click configuration menu buttons":
                genericClick(actionType,elementName, dynamicItem[0]);
                break;

        }
    }

    public void selectCatalogAndClickSearch(String elementName) {
        genericSelect("globalCatalogSelect", elementName);
    }

    public void verifyNotificationPropertiesContains(String panelName, String notificationTitle, String section, String propertyName, String expectedText) throws Exception {
        isElementContainsTheNotificationProperties(panelName, notificationTitle, section, propertyName, expectedText);
    }

    public void verifyNotificationPanelProperty(String section, List<String> data) throws Exception {
        isElementListPresentInNotificationPanel(section, data);
    }

    public void verifyElementPresence(List<String> itemList, String... actionType) throws Exception {
        switch (actionType[0]) {
            case "verify submenus":
                Assert.assertTrue(doesElementsPresentInList(itemList, actionType[1]));
                break;
            case "Dynamic form":
                Assert.assertTrue(doesElementsPresentInList(itemList, actionType[1]));
                break;
            case "verify non presence":
                Assert.assertFalse(verifyListElementNotPresent(itemList, actionType[1]));
                break;
            case "verify presence":
                Assert.assertTrue(doesElementsPresentInList(itemList, actionType[1]));
                break;
            case "verifies Tree Sructure of Tags":
                Assert.assertTrue(doesElementsPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "verifies missing Tags in Tree Sructure":
                Assert.assertFalse(verifyListElementNotPresent(itemList, actionType[0], actionType[1]));
                break;
            case "verifies protected lock icon":
                Assert.assertTrue(doesElementsPresentInList(itemList, actionType[0]));
                break;
            case "Verify trust policy labels":
                Assert.assertTrue(doesElementsPresentInList(itemList, actionType[1]));
                break;
        }
    }

    public void addDataSourcePageConfigurations(String actionType, String fieldName, String option, String pageName) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectAttributesFromTheDropdown(fieldName, option);
                break;
            case "enter text":
                enterTextInAddDataSourcePage(fieldName, option, pageName);
                break;
            case "Validate the field Error Message":
                validateErrorMessageForTheFields(fieldName, option, pageName);
                break;
            case "enter credentials":
                enterCredentials(option);
                break;
            case "Click":
                genericClick(fieldName, option);
                break;
        }
    }

    public void enterPageConfigurations(String actionType, String option) throws Exception {
        switch (actionType) {
            case "enter credentials":
                enterCredentials(option);
                break;
        }
    }

    public void validatePresense(String actionType, String fieldName) throws Exception {
        switch (actionType) {
            case "widget presense":
            case "Widget Header Title presense":
                genericVerifyElementPresent(actionType, fieldName);
                break;
            case "Widget absense":
                genericVerifyElementNotPresent(actionType, fieldName);
                break;
            case "New tab opened":
                genericVerifyElementPresent(actionType);
                break;
            case "Item view page title":
                genericVerifyElementPresent(actionType, fieldName);
                break;
        }
    }

    public void addcreatePageConfigurations(String actionType, String fieldName, String attribute, String option, String Message) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectcreatepageDropdown(fieldName, attribute);
                break;
            case "enter text":
                enterText(getTextBoxInCreatePage(fieldName), attribute);
                break;
            case "Validate the Error Message":
                String Error_message = getElementText(getFieldErorMessage(fieldName,Message));
                Assert.assertTrue(Error_message.trim().contains(Message));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), Message + " validation message is displayed under the field");
                break;
            case "Verify the Field Error message":
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), Message + " validation message is displayed under the field");
                Assert.assertTrue(isElementPresent(getFieldErorMessage(fieldName,Message)));
                break;
            case "Verify contextual message":
                String actualText = getElementText(getContextualMessage(Message));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), Message + " validation message is displayed under the field");
                Assert.assertEquals(Message, actualText.trim());
                break;
            case "Verify Placeholder":
                verifyPlaceHolder(fieldName, Message, option);
                break;
            case "enter owner":
                addOwnersInBusinessappl(fieldName,attribute);
                break;
            case "delete owner":
                deleteOwnersInBusinessappl(fieldName, attribute);
                break;
            case "Create Item":
                CreateItem(fieldName, attribute, option, Message);
                break;

        }
    }

    public void addCredentialsPageConfigurations(String actionType, String fieldName, String option, String pageName) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectAttributesFromTheDropdown(fieldName, option);
                break;
            case "enter text":
                enterTextInAddDataSourcePage(fieldName, option);
                break;
            case "verifies not displayed":
                genericVerifyElementPresent(fieldName, option);
                break;
            case "verifies displayed":
                genericVerifyElementPresent(fieldName, option);
                break;
        }
    }

    public void addPipelinesPageConfigurations(String actionType, String fieldName, String actionItem, String itemName) throws Exception{
        switch(actionType){
            case "enter text":
                enterTextInPipelinePage(fieldName,actionItem, itemName);
                break;
            case "click":
                clickInPipelinePage(fieldName, actionItem, itemName);
                break;
            case "verifies displayed":
                genericVerifyElementPresent(actionItem, itemName);
                break;
            case "verifies not displayed":
                genericVerifyElementNotPresent(fieldName, itemName);
                break;
            case"enter text in Scheudler":
                enterTextInPipelinePage(fieldName, actionItem, itemName);
                break;
        }
    }

    public void addProfileSettingPageConfigurations(String actionType, String fieldName, String option, String attribute) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectAttributeInProfileSettingPageFromTheDropdown(fieldName, option);
                break;
            case "verifies displayed":
                genericVerifyElementPresent(fieldName, option);
                break;
            case "Default Option selected":
                genericVerifyElementPresent(actionType,fieldName,option);
                break;
            case "Default BA Option selected":
                genericVerifyElementPresent(actionType,fieldName,option);
                break;
            case "verifies tagging Policy Default Option":
                genericVerifyElementPresent(actionType,fieldName,option);
                break;
            case "verify label absense":
                genericVerifyElementNotPresent(actionType,fieldName);
                break;
            case "click configuration menu buttons":
                genericClick(actionType, fieldName, option);
                break;
            case "Expand accordion":
                genericClick(actionType, fieldName, option, attribute);
                break;
        }
    }

    public void manageDataSourcePageConfigurations(String actionType, String fieldName, String actionItem, String itemName) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectDataSourceTypeFromTheDropdown(fieldName, actionItem);
                break;
            case "select Bundles dropdown":
                selectBundleTypeFromTheDropdown(fieldName, actionItem);
                break;
            case "select DS filter dropdown":
            case "select Data Set filter dropdown":
                selectFilterTypeFromTheDropdown(fieldName, actionItem);
                break;
            case "enter text":
                enterActions(fieldName, actionItem);
                break;
            case "Uncollapse dropdown":
                unCollapseDropdown(fieldName,actionItem);
                break;
            case "Collapse":
                genericClick(fieldName,actionItem);
                break;
            case "click":
                genericClick(fieldName, actionItem, itemName);
                break;
            case "Expand Bundle":
            case "Collapse Bundle":
                genericClick(actionType, fieldName);
                break;
            case "verify presence":
                genericVerifyElementPresent(fieldName, actionItem);
                break;
            case "verifies widgets":
                genericVerifyElementPresent(actionType, fieldName);
                break;
            case "verifies widgets absence":
                genericVerifyElementNotPresent(actionType, fieldName);
                break;
            case "verifies preconfigured widgets":
                genericVerifyElementPresent(actionType, fieldName);
                break;
            case "verify Widget chart type":
                genericVerifyElementPresent(actionType, fieldName, actionItem);
                break;
            case "verify trust score":
                genericVerifyElementPresent(actionType, fieldName, actionItem, itemName);
                break;
            case "select BA Attributes dropdown":
                selectBAAttributesDropdown(fieldName, actionItem);
                break;
            case "Select dropdown in Dashboard Config":
                selectDashboardConfigDropdown(fieldName, actionItem);
                break;
            case "Verify Label presence":
                genericVerifyElementPresent(actionType,fieldName, actionItem,itemName);
                break;
            case "Verify License Widget":
                genericVerifyElementPresent(actionType,fieldName, actionItem,itemName);
                break;
            case "Enter Value in Dashboard Config":
                if (fieldName.equalsIgnoreCase("Title")) {
                    enterText(getWidgetTitleTextbox(), actionItem);
                } else if (fieldName.equalsIgnoreCase("Description")) {
                    enterText(getWidgetDescription(), actionItem);
                } else if (fieldName.equalsIgnoreCase("Error Message")) {
                    Assert.assertEquals(getWidgetFieldErrorMessage().getText(), actionItem);
                } else {
                    Assert.fail("Action not Performed");
                }
                break;
            case "verify Widget Item Type":
                genericVerifyElementPresent(actionType, fieldName, actionItem, itemName);
                break;
            case "verifies Piechart Business Criticality":
                genericVerifyElementPresent(fieldName, actionItem);
                break;
            case "verify Widget Dropdown Values":
                genericVerifyElementPresent(actionType, fieldName, actionItem, itemName);
                break;
            case "verifies non mandatory field":
                genericVerifyElementNotPresent(actionType, fieldName);
            case "Verify Highlighted Excel Import":
                genericVerifyElementPresent(actionType,fieldName, actionItem);
                break;
            case "Verify Dashboard Validation text":
                genericVerifyElementPresent(actionType,fieldName, actionItem);
                break;
            case "Forbidden validation message":
                genericVerifyElementPresent(actionType,fieldName, actionItem,itemName);
                break;
        }
    }

    public void validateElementsInManageDataSourcePage(String actionType, String actionToBeVerified, List<String> data) throws Exception {
        switch (actionType) {
            case "verifies presence":
                validateElementPresense(actionToBeVerified, data);
                break;
            case "verifies absence":
                isDataSetElementNotPresentInList(data);
                break;
            case "verifies sorting order":
                verifySortingOrder(actionToBeVerified, data);
                break;
            case "verify sidebar menu items":
                validateSubMenusForSidebar(actionToBeVerified, data);
                break;
            case "verifies Tree Sructure of Tags":
                validateElementPresense(actionToBeVerified, data);
                break;
            case "verifies License field presence":
                validateElementPresense(actionType, data);
                break;
        }
    }

    public void verifySelects(String actionType, String elementName, String... dynamicItem) throws Exception {
        switch (actionType) {
            case "selects":
                verifySelectsFilter(elementName, dynamicItem[0]);
                break;
            case "click":
                genericClick(elementName, dynamicItem[0]);
                break;



        }
    }

    public void enterDynamicTextInSaveSearchPage(String actionType, String fieldName, String option) throws Exception {
        switch (actionType) {
            case "enter text":
                enterTextInSaveSearchPage(fieldName, option);
                break;
            case "Verify Text":
                genericVerifyElementPresent(fieldName, option);
                break;
        }
    }

    public void runSearchPageConfigurations(String actionType, String searchName) throws Exception {
        switch (actionType) {
            case "displayed":
                isElementPresentinRunSearchList(actionType, searchName);
                break;
            case "deleted":
                isElementPresentinRunSearchList(actionType, searchName);
                break;
        }
    }

    public void DashBoardPageValidations(String actionType, String elementName, String ItemName) throws Exception {
        switch (actionType) {
            case "Validate DashBoardWidget":
                TagValidation(elementName, ItemName);
                break;
            case "Validate Most Used Tags Descending":
                TagValidation(elementName, ItemName);
                break;
            case "Validate Least Used Tags Descending":
                TagValidation(elementName, ItemName);
                break;
            case "Select Configure Heading":
                TagValidation(elementName, ItemName);
                break;

        }
    }
}
