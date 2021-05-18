package com.asg.automation.pageobjects.idc;

import com.asg.automation.pageactions.idc.LoginActions;
import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import com.google.common.collect.Ordering;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.Color;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.ArrayList;
import java.util.List;

public class CommonPage extends UIWrapper {
    private WebDriver driver;

    @FindBy(css = "div.bottom-section.bottom-block > app-asg-actions-panel > div > button:nth-child(4)")
    private WebElement orderList;

    @FindBy(css = "div[class='asg-order-access-request-submit']>button")
    private WebElement submitOrderButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]][contains(text(),'Type')]//following::div[@class[contains(.,'asg-show-more-facet')]][1]/button")
    private WebElement ShowAll_facet_Button;

    @FindBy(xpath = "//i[@class[contains(.,'fa fa-chevron')]]")
    private WebElement arrowIcon;

    @FindBy(xpath = "//div[@class='tooltip-inner']//i[@class='fa fa-close']")
    private WebElement popUpCloseButton;

    @FindBy(css = "div[class='tooltip-inner']")
    private List<WebElement> popUpContainer;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//button[contains(.,' SAVE ')]")
    private WebElement saveButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item full-size-item')]]/div/div/button[@class='exit-btn']/i")
    private WebElement itemFullViewcloseButton;

    @FindBy(css = "div[class='asg-search-header-ellipsis']")
    private WebElement catalogDropDown;

    @FindBy(xpath = "//ul[@class='schema-dropdown-menu dropdown-menu show']//li")
    private List<WebElement> catalogList;

    @FindBy(xpath = "//span[@class='input-group-addon search-addon'][1]/span")
    private WebElement topSearchIcon;

    @FindBy(xpath = "//td[@class='text-truncate ng-star-inserted sorted-column']")
    private List<WebElement> ValueColumnList;

    @FindBy(xpath = "//input[contains(@placeholder,'Search...')]")
    private WebElement topItemSearchField;

    @FindBy(css = "span[class='app-version']")
    private WebElement getVersion;

    //10.3 New UI

    @FindBy(xpath = "(//div//button[@class[contains(.,'asg-btn-confirm-secondary')]])[1]")
    private WebElement noButtonInPopUp;

    @FindBy(xpath = "//button[@class='close float-right']/span")
    private WebElement closeButtonInPopUp;


    @FindBy(xpath = "//button[@class[contains(.,'btn asg-btn-confirm-primary float-right')]][contains(.,'Yes')]")
    private WebElement yesButtonInPopUp;

    @FindBy(xpath = "//button[@class[contains(.,'btn asg-btn-confirm-secondary asg-btn-space-right')]]")
    private WebElement deleteButtonInPopUp;

    public WebElement getAdminPages(String pageName) {
        return driver.findElement(By.xpath("//div[@class='asg-manage-container']/*/div/div/h3[contains(.,'"+pageName+"')]"));
    }

    @FindBy(xpath = "//div[@class='modal-content-body']//following::div[@class[contains(.,'split-container')]]//div/span[@class[contains(.,'title')]]")
    private List<WebElement> assignBAPopupSection;

    @FindBy(xpath = "//span[contains(.,'Available')]//following::div[@class='overflow-auto wrapper'][1]/div[@class[contains(.,'select-none')]]")
    private List<WebElement> availablePopupSectionList;

    @FindBy(xpath = "//span[contains(.,'Assigned')]//following::div[@class='overflow-auto wrapper'][1]/div[@class[contains(.,'select-none')]]")
    private List<WebElement> assignedPopupSectionList;

    @FindBy(xpath = "//span[@class[contains(.,'fa-plus-square')]]/preceding-sibling::*/span[@class[contains(.,'search')]][1]")
    private WebElement searchIcon;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-search cursor-pointer')]][1]")
    private WebElement itemViewsearchIcon;

    @FindBy(xpath = "//input[@id='asgManageSearch']")
    private WebElement itemSearchTag;

    @FindBy(xpath = "//span[contains(text(),'Structure Information Tags')]")
    private WebElement manageTagTitle;

    @FindBy(xpath = "//a[contains(text(),'Cancel')]")
    private WebElement assignTagCancelButton;

    @FindBy(xpath = "//button[contains(text(),'SAVE')]")
    private WebElement saveCreatedTag;

    @FindBy(xpath = "//span[contains(text(),'General')]")
    private WebElement generalTagTile;

    @FindBy(xpath = "//input[@id='tagName']")
    private WebElement createNewTagName;

    @FindBy(xpath = "//span[contains(text(),'Search Results')]")
    private WebElement searchResultsScreenTitle;

    @FindBy(xpath = "//span[contains(text(),'Rating')]")
    private WebElement ratingWidgetTitle;

    @FindBy(xpath = "//div[contains(text(),'Application ID')]")
    private WebElement baApplicationIDTitle;

    @FindBy(xpath = "//div[@class='list-caption for-edit text-right'][contains(.,'Application ID')][1]//following::input[1]")
    private WebElement getApplicationIDTextBox;

    @FindBy(xpath = "//div[contains(text(),'Business Criticality')]")
    private WebElement businessCriticalityField;

    @FindBy(xpath = "//div[@class[contains(.,'cursor-pointer asg-diagram-toolbar')]]")
    private WebElement leftPaneWidgetArrowButton;

    @FindBy(xpath = "//input[@id='roleName']")
    private WebElement enterRoleNameTextBox;

    @FindBy(xpath = "//input[@id='description']")
    private WebElement enterRoleDescriptionTextBox;

    @FindBy(id = "asgManageSearch")
    private WebElement enterInSearchTextBox;

    @FindBy(xpath = "//span[@title[contains(.,'Permission to perform')]]")
    private WebElement clickOnPermissionText;

    @FindBy(xpath = "//input[@class='form-control']")
    private WebElement ldapUserNameSearchField;

    @FindBy(xpath = "//input[@formcontrolname='fullName']")
    private WebElement localUserFullNameField;

    @FindBy(xpath = "//input[@formcontrolname='account']")
    private WebElement localUserNameField;

    @FindBy(xpath = "//input[@type='password']")
    private WebElement localUserPasswordField;

    @FindBy(xpath = "//input[@formcontrolname='email']")
    private WebElement localUserEmailField;

    @FindBy(xpath = "//span[@class[contains(.,'title')]]")
    private WebElement roleLDAPLocalscereenTitle;

    @FindBy(xpath = "//input[@id='definition']")
    private WebElement createNewTagNameDefinition;

    @FindBy(xpath = "//em[@class='fa fa-close']")
    private WebElement searchCloseIcon;

    @FindBy(xpath = "//div[@class[contains(.,'search-input-block')]]//input[@placeholder]")
    private WebElement tableComponentsearchInputBox;

    @FindBy(xpath = "//button[@role='option']")
    private List<WebElement> suggestionsListInVisibilityPopup;

    @FindBy(xpath = "//div[@class[contains(.,'configuration-properties')]]//tbody/tr/td[1]")
    private List<WebElement> itemListInGrantAccessPopup;

    public CommonPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized DataSet");
    }

    public WebElement getMyAccessStatusText(String status) {
        return driver.findElement(By.xpath("//span[@class='asg-order-access-status-label'][contains(.,'" + status + "')]"));
    }

    public void clickOrderList() {
        clickOn(orderList);
    }

    public void clickFirstDataItemDisplayed(String itemName) {
        clickOn(driver.findElement(By.xpath("//div[contains(.,'" + itemName + "')]/preceding::th[@class='checkbox-selectable-cell'][1]")));
    }

    public void clickOnHeaderCheckbox() {
        clickOn(driver.findElement(By.xpath("//label[@class='header-checkbox'][1]/..")));
    }

    public void clickSubmitOrderButton() {
        clickOn(submitOrderButton);
    }

    public void clickArrowIconInOpenNotificationPanel() {
        clickOn(arrowIcon);
    }


    public void clickPopUpCloseButton() {
        clickOn(popUpCloseButton);
    }

    public List<WebElement> popUpContainerBox(){
        return popUpContainer;
    }

    public void clickSaveButton() {
        clickOn(saveButton);
    }

    public void clickItemFullViewCloseButton() {
        clickOn(itemFullViewcloseButton);
    }

    public WebElement getSaveButton() {
        return saveButton;
    }


    public WebElement catalogDropDown() {

        synchronizationVisibilityofElement(driver, catalogDropDown);
        return catalogDropDown;
    }

    public WebElement getTopItemSearchField() {
        synchronizationVisibilityofElement(driver, topItemSearchField);
        return topItemSearchField;
    }

    public WebElement getTopSearchIcon() {
        synchronizationVisibilityofElement(driver, topSearchIcon);
        return topSearchIcon;
    }

    public List<WebElement> getValueColumnList() {
        synchronizationVisibilityofElementsList(driver, ValueColumnList);
        return ValueColumnList;
    }

    public WebElement getVersion() {
        return getVersion;
    }

    //10.3  New UI
    public WebElement getNoButtonInpopUp() {
        return noButtonInPopUp;
    }

    public WebElement getCloseButtonInpopUp() {
        return closeButtonInPopUp;
    }

    public List<WebElement> getCongratulationsPopup(String popUpName) {
        return driver.findElements(By.xpath("//div[@class='modal-content']/div/div/div/span[contains(.,'"+popUpName+"')]"));
    }

    public List<WebElement> getsimilaritemlist(String widgetName) {
        return driver.findElements(By.xpath("//span[contains(text(), '"+widgetName+"')]//following::td[@class='text-truncate ng-star-inserted']"));
    }


    public List<WebElement> getPopUp(String popUpName) {
        return driver.findElements(By.xpath("//div[@class='modal-content']//following::h4[contains(.,'"+popUpName+"')]"));
    }

    public List<WebElement> getNestedPopUp(String popUpName) {
        return driver.findElements(By.xpath("//div[@class='modal-content']/div/h4[contains(.,'"+popUpName+"')]"));
    }

    public List<WebElement> getPopUpBody() {
        return driver.findElements(By.xpath("//div[@class[contains(.,'modal-body')]]"));
    }


    public WebElement getPopUpLinks(String linkName) {
        return driver.findElement(By.xpath("//div[@class='modal-content']//following::li/a[contains(.,'"+linkName+"')]"));
    }


    public WebElement getSimiliarwidget(String widgetName) {
        return driver.findElement(By.xpath("//span[contains(text(), '"+widgetName+"')]"));
    }

    public WebElement getwidgetCount(String widgetName) {
        return driver.findElement(By.xpath("//span[contains(text(), '"+widgetName+"')]//span[@class='count']"));
    }

    public WebElement getSimiliarwidgetTable(String columnName) {
        return driver.findElement(By.xpath("//span[contains(text(), 'similar')]//following::span[@title='"+columnName+"']"));
    }

    public WebElement getMFVwidgetTable(String columnName) {
        return driver.findElement(By.xpath("//span[contains(text(), 'Most frequent values')]//following::span[@title='"+columnName+"']"));
    }

    public WebElement getPageHeading(String linkName) {
        return driver.findElement(By.xpath("//div[@class='modal-content']//following::li/a[contains(.,'"+linkName+"')]"));
    }

    public WebElement getPopUpTextbox(String textboxName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textboxName+"')]//following::input[1]"));
    }

    public WebElement getValidationMessageForTheTextbox(String textboxName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textboxName+"')]//following::div[@class[contains(.,'error')]]"));
    }

    public WebElement getHintTextForTheTextbox(String textboxName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textboxName+"')]//following::div[@class[contains(.,'hint')]]"));
    }

    public WebElement getAttributeFromDropdown(String option) {
        return driver.findElement(By.xpath("//li[@class[contains(.,'dropdown-item')]][contains(.,'"+option+"')]"));
    }

    public WebElement getSaveSearchDescriptionTooltip(String searchText) {
        return driver.findElement(By.xpath("//td[contains(.,'Customer1')]//following::td[@tooltipclass][2]"));
    }

    public WebElement getFieldName() {
        return driver.findElement(By.xpath("//div/following::label[contains(@class,'asg-dyn-form-property-label')]"));
    }

    public WebElement getSaveSearchDescriptionTooltipContent() {
        return driver.findElement(By.xpath("//div[@class='tooltip-inner']/div/div/div/div"));
    }

    public WebElement getYesButtonInpopUp() {
        return yesButtonInPopUp;
    }

    public WebElement getDeleteButtonInpopUp() {
        return deleteButtonInPopUp;
    }

    public WebElement getTooltipContent(String searchText) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label tooltip-indicator')]][contains(.,'" + searchText + "')]//following::*[@role='tooltip']"));
    }

    public List<WebElement> getPopUpCloseButton() {
        return driver.findElements(By.xpath("//div[@class='modal-content']//following::button[@class[contains(.,'close')]]"));
    }

    public List<WebElement> getAssignBAPopUpSection() {
        return assignBAPopupSection;
    }

    public List<WebElement> getPopUpLabel(String section, String itemName, String label) {
        return driver.findElements(By.xpath("//span[contains(text(),'"+section+"')]//following::span[contains(.,'"+itemName+"')]//following-sibling::span[contains(.,'"+label+"')]"));
    }

    public WebElement getSectionCheckbox(String section, String itemName) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+section+"')]//following::span[contains(.,'"+itemName+"')]//following::input"));
    }

    public WebElement getPopUpItemRemovalButton(String section, String itemName) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+section+"')]//following::span[contains(.,'"+itemName+"')]//following-sibling::span[@title='Remove']"));
    }

    public List<WebElement> getPopupSectionList(String section){
        return driver.findElements(By.xpath("//span[contains(.,'"+section+"')]//following::div[@class='overflow-auto wrapper'][1]/div[@class[contains(.,'select-none')]]"));
    }

    public WebElement getSearchIcon(){
        return searchIcon;
    }

    public WebElement getItemViewsearchIcon(){
        return itemViewsearchIcon;
    }

    public WebElement getsearchTag(){
        return itemSearchTag;
    }

    public WebElement getManageTagTitle(){
        return manageTagTitle;
    }

    public WebElement getSaveTagButton(){
        return saveCreatedTag;
    }

    public WebElement getAssignTagCancelButton(){
        return assignTagCancelButton;
    }

    public WebElement getGeneralTagTile(){
        return generalTagTile;
    }

    public WebElement getTagNameField(){
        return createNewTagName;
    }

    public WebElement getSearchResultsTitle(){
        return searchResultsScreenTitle;
    }

    public WebElement getTagDefinitionField(){
        return createNewTagNameDefinition;
    }

    public WebElement getSearchCloseIcon(){
        return searchCloseIcon;
    }

    public WebElement getTableComponentsearchInputBox(){
        return tableComponentsearchInputBox;
    }

    public WebElement getDropdownFieldValueInPopup(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'" + fieldName + "')]//following::span[@class[contains(.,'text-left')]]"));
    }

    public WebElement getOptionFromDropdownInPopup(String filterName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'" + filterName + "')]//following::button[@role='menuitem'][contains(.,'" + option + "')]"));
    }

    public WebElement getTextBoxInVisibilityPopup(String textbox) {
        return driver.findElement(By.xpath("//label[contains(.,'" + textbox + "')]//following::input[1]"));
    }

    public WebElement getMemberInVisibilityPopup(String textbox, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'" + textbox + "')]//following::input[1]/../../div//ul//div//span[contains(.,'" + option + "')]"));
    }

    public WebElement getOwnerFieldInVisibilityPopup(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'" + fieldName + "')]//following::input"));
    }

    public List<WebElement> getSuggestionsListInVisibilityPopup() {
        return suggestionsListInVisibilityPopup;
    }

    public List<WebElement> getColumnNameUnderTable(String tableName) {
        return driver.findElements(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+tableName+"')]//following::th"));
    }

    public List<WebElement> getItemListInGrantAccessPopup() {
        return itemListInGrantAccessPopup;
    }


    public WebElement getRatingWidgetTitle(){
        return ratingWidgetTitle;
    }

    public WebElement getApplicationIDLabelField(){
        return baApplicationIDTitle;
    }

    public WebElement getApplicationIDTextBox(){
        return getApplicationIDTextBox;
    }

    public WebElement getBusinessCriticalityField(){
        return businessCriticalityField;
    }

    public WebElement getLeftWidgetArrowButton(){
        return leftPaneWidgetArrowButton;
    }

    public WebElement getRoleNameField(){
        return enterRoleNameTextBox;
    }

    public WebElement getRoleDescriptionField(){
        return enterRoleDescriptionTextBox;
    }

    public WebElement getSearchBoxInManageAcess(){
        return enterInSearchTextBox;
    }

    public WebElement getPermissionText(){
        return clickOnPermissionText;
    }

    public WebElement getLdapUserNameSearchField(){
        return ldapUserNameSearchField;
    }

    public WebElement getLocalUserFullNameField(){
        return localUserFullNameField;
    }

    public WebElement getLocalUserNameField(){
        return localUserNameField;
    }

    public WebElement getLocalUserPassword(){
        return localUserPasswordField;
    }

    public WebElement getLocalUserEmail(){
        return localUserEmailField;
    }

    public WebElement getRoleLDAPLocalscereenTitle(){
        return roleLDAPLocalscereenTitle;
    }




    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void genericClick(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "arrow icon":
                    clickArrowIconInOpenNotificationPanel();
                    break;
                case "Order List":
                    clickOrderList();
                    break;
                case "submit order":
                    clickSubmitOrderButton();
                    sleepForSec(2500);
                    break;
                case "pop up close":
                    clickPopUpCloseButton();
                    break;
                case "Header checkbox":
                    clickOnHeaderCheckbox();
                    break;
                case "save button":
                    clickSaveButton();
                    break;
                case "item full view close button":
                    clickItemFullViewCloseButton();
                    break;
                //10.3 New UI
                case "No":
                    moveToElement(driver,getNoButtonInpopUp());
                    clickOn(driver, getNoButtonInpopUp());
                    waitForAngularLoad(driver);
                    break;
                case "Close button":
                    clickOn(driver, getCloseButtonInpopUp());
                    waitForAngularLoad(driver);
                    break;
                case "Start and manage the configuration":
                case "Add a configuration":
                case "Add a data source":
                case "Add a credential":
                    clickOn(driver, getPopUpLinks(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "similar":
                    clickOn(driver,getsimilaritemlist(elementName).get(0));
                    waitForAngularLoad(driver);
                    break;
                case "Yes":
                    clickOn(driver, getYesButtonInpopUp());
                    waitForAngularLoad(driver);
                    break;
                case "DELETE":
                    clickOn(driver, getDeleteButtonInpopUp());
                    waitForAngularLoad(driver);
                    break;
                case "Close popup":
                    if(isElementPresent(getPopUpCloseButton().get(0))){
                        clickOn(driver, getPopUpCloseButton().get(0));
                    }else{
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"PopUp is not displayed");
                    }
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Manage Configurations":
                case "Manage Credentials":
                case "Manage Data Sources":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getAdminPages(elementName)));
                    break;
                case "Congratulations":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getCongratulationsPopup(elementName).get(0)));
                    break;
                case "Add Configuration to LocalNode":
                case "Add Data Source":
                case "Add Credential":
                case "Unsaved changes":
                case "Run Recent Search":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Delete Widget":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Delete Bundles":
                case "Add Local User":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Delete Itemtype":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Delete Data Type":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Excel Importer":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Edit Excel Import":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Clone Excel Import":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Manage Excel Imports":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(elementName).get(0)));
                    break;
                case "Start and manage the configuration":
                case "Add a configuration":
                case "Add a data source":
                case "Add a credential":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUpLinks(elementName)));
                    break;
                case "similar ":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getSimiliarwidget(elementName)));
                    Assert.assertTrue(isElementPresent(getwidgetCount(elementName)));
                    break;
                case "Name":
                case "type":
                case "Description":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getSimiliarwidgetTable(elementName)));
                    break;
                case "Most frequent values":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getwidgetCount(elementName)));
                    break;
                case "Value":
                case "Count":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getMFVwidgetTable(elementName)));
                    break;
                case "Verifies popup":
                    waitForAngularLoad(driver);
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopUp(dynamicItem[0]).get(0)));
                    break;
                case "Verifies Nested popup":
                    waitForAngularLoad(driver);
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getNestedPopUp(dynamicItem[0]).get(0)));
                    break;
                case "Verifies popup content":
                    waitForAngularLoad(driver);
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getPopUpBody().get(0).getText().contains(dynamicItem[0]));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }


    public void genericVerifyElementNotPresent(String elementName,String... dynamicItem) {
        try {
            switch (elementName) {
                case "pop up":
                    Assert.assertTrue(popUpContainerBox().size()==0);
                    break;
                    //10.3 NEW UI
                case "Congratulations":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getCongratulationsPopup(elementName).isEmpty());
                    break;
                case "Add Local User":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(getCongratulationsPopup(elementName).isEmpty());
                    break;
                case " similar ":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isNotElementPresent(getSimiliarwidget(elementName)));
                    break;
                case "No sort order":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(getValueColumnList().isEmpty());
                    break;
                case "Verifies popup":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getPopUp(dynamicItem[0]).isEmpty());
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyEquals(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyEnabled(String elementName,String... dynamicItem) {
        try {
            switch (elementName) {
                case "save button":
                    Assert.assertTrue(getSaveButton().isEnabled());
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void selectCatalogAndItemSearch(String catalogName, String itemName) {
        try {
             if(catalogName.equals("All")) {
                 enterText(getTopItemSearchField(), itemName);
                 waitUntilJSReady(driver);
                 clickOn(getTopSearchIcon());
                 waitForAngularLoad(driver);
                 sleepForSec(3000);
             }else if(itemName.equals("All")){
                 clickonWebElementwithJavaScript(driver, catalogDropDown);
                 clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(catalogList, catalogName));
                 waitForAngularLoad(driver);
                 sleepForSec(1000);
                 clickOn(getTopSearchIcon());
                 waitForAngularLoad(driver);
                 sleepForSec(3000);
             } else{
                 clickonWebElementwithJavaScript(driver, catalogDropDown);
                 clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(catalogList, catalogName));
                 sleepForSec(2000);
                 enterText(getTopItemSearchField(), itemName);
                 sleepForSec(2000);
                 clickOn(driver, getTopSearchIcon());
                 waitForAngularLoad(driver);
             }

        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public boolean validatePresence(String actionType, String textBoxName, String validationMessage) throws Exception {
        boolean flag = false;
        switch (actionType) {
            case "validation message":
                clickOn(getPopUpTextbox(textBoxName));
                if (textBoxName.equalsIgnoreCase("Driver Bundle Name")) {
                    enterText(getPopUpTextbox(textBoxName), "demo");
                    clearTextWithJavaScript(driver, getPopUpTextbox(textBoxName));
                }else if(textBoxName.equalsIgnoreCase("Sample data count")||textBoxName.equalsIgnoreCase("Top values")||textBoxName.equalsIgnoreCase("Histogram buckets")){
                    String actualText = getElementText(getValidationMessageForTheTextbox(textBoxName));
                    Boolean matchValue = validationMessage.equals(actualText.trim());
                    Assert.assertTrue(matchValue);
                    flag=true;
                    break;
                }
                else if(textBoxName.equalsIgnoreCase("Query Code")) {
                    String actualText = getElementText(getValidationMessageForTheTextbox(textBoxName));
                    Boolean matchValue = validationMessage.equals(actualText.replaceAll("\n", " "));
                    Assert.assertTrue(matchValue);
                    flag = true;
                    break;
                }
                textClear(getPopUpTextbox(textBoxName));
                keyPressEvent(driver, Keys.TAB);
                String actualText = getElementText(getValidationMessageForTheTextbox(textBoxName));
                Assert.assertEquals(actualText.trim(), validationMessage);
                break;
            case "Hint text":
                String actualHintText = getElementText(getHintTextForTheTextbox(textBoxName));
                Assert.assertEquals(actualHintText.trim(), validationMessage);
                break;
            case "background color":
                moveToElement(driver,getAttributeFromDropdown(textBoxName));
                String actualBackgroundColor = getAttributeFromDropdown(textBoxName).getCssValue("background-color");
                String hexColor = Color.fromString(actualBackgroundColor).asHex().trim();
                Assert.assertEquals(hexColor.trim(), validationMessage.trim());
                break;
            case "Save Search tooltip validation":
                moveToElement(driver,getSaveSearchDescriptionTooltip(textBoxName));
                String actualContent = getElementText(getSaveSearchDescriptionTooltipContent());
                Assert.assertEquals(actualContent, validationMessage.trim());
                break;
            case "tooltip validation":
                moveToElement(driver, getFieldName());
                String toolTipText = getElementText(getTooltipContent(textBoxName));
                Assert.assertEquals(toolTipText, validationMessage.trim());
                break;
        }
        return flag;
    }

    public void Popupvalidations(String actionType, String actionItem, String itemName, String section) throws Exception {
        List<String> actual = new ArrayList<>();
        boolean flag = false;
        try {
            switch (actionType) {
                case "Verify Section Presence":
                    String sections[] = section.split(",");
                    for (String sectionName : sections) {
                        Assert.assertTrue(traverseListContainsText(getAssignBAPopUpSection(), sectionName));
                    }
                    break;
                case "Verify label presence for Item":
                    Assert.assertTrue(isElementPresent(getPopUpLabel(section, actionItem, itemName).get(0)));
                    break;
                case "Verify label absence for Item":
                    Assert.assertTrue(getPopUpLabel(section, actionItem, itemName).isEmpty());
                    break;
                case "Remove tagged item in the Section":
                    clickOn(getPopUpItemRemovalButton(section,actionItem));
                    break;
                case "Select checkbox":
                    clickOnWithJavascript(driver, getSectionCheckbox(section, actionItem));
                    break;
                case "verifies sorting order":
                    for (WebElement datasource : getPopupSectionList(section)) {
                        actual.add(datasource.getText());
                    }
                    if (actionItem.equalsIgnoreCase("Ascending")) {
                        flag = Ordering.natural().isOrdered(actual);
                        Assert.assertTrue(flag);
                    } else if (actionItem.equalsIgnoreCase("Descending")) {
                        flag = Ordering.natural().reverse().isOrdered(actual);
                        Assert.assertTrue(flag);
                    } else {
                        Assert.assertFalse(Ordering.natural().isOrdered(actual));
                        Assert.assertFalse(Ordering.natural().reverse().isOrdered(actual));
                    }
                    break;
                case "Verify the dropdown option selected for field":
                    waitForAngularLoad(driver);
                    sleepForSec(500);
                    Assert.assertTrue(getElementText(getDropdownFieldValueInPopup(actionItem)).equals(itemName));
                    waitUntilAngularReady(driver);
                    break;
                case "Select option from dropdown":
                    clickOn(getDropdownFieldValueInPopup(actionItem));
                    waitForAngularLoad(driver);
                    clickOn(getOptionFromDropdownInPopup(actionItem, itemName));
                    waitForAngularLoad(driver);
                    break;
                case "Select Member":
                    List<String> expected = new ArrayList<>();
                    String[] attr = itemName.split(",");
                    for (String exp : attr) {
                        expected.add(exp);
                    }
                    int expectedsize = expected.size();
                    for (int i = 0; i < expectedsize; i++) {
                        enterTextWithoutClear(getTextBoxInVisibilityPopup(actionItem), expected.get(i));
                        sleepForSec(500);
                        clickOn(driver, getMemberInVisibilityPopup(actionItem, expected.get(i)));
                        waitForAngularLoad(driver);
                    }
                    break;
                case "Select Owner":
                    enterText(getOwnerFieldInVisibilityPopup(actionItem), itemName);
                    waitForAngularLoad(driver);
                    traverseListContainsElementAndClick(driver, getSuggestionsListInVisibilityPopup(), itemName);
                    break;
                case "click":
                    if (actionItem.equalsIgnoreCase("ADD")) {
                        clickOn(driver, new SubjectArea(driver).getAddItemToDSADDButton(actionItem));
                    } else if (actionItem.equalsIgnoreCase("ADD AND OPEN")){
                    clickOn(driver, new SubjectArea(driver).getAddItemToDSADDButton(actionItem));
                } else{
                    throw new Exception();
                }
                break;
                case "Verify Column names for the table":
                    String[] columnName = itemName.split(",");
                    for (String expectedColName : columnName) {
                    traverseListContainsElement(getColumnNameUnderTable(actionItem), expectedColName);
                    }
                    break;
                case "Verify the item names in Requested Data Table":
                    String[] itemsName = actionItem.split(",");
                    for (String expectedColName : itemsName) {
                        traverseListContainsElement(getItemListInGrantAccessPopup(), expectedColName);
                    }
                    break;
            }
            waitUntilAngularReady(driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Validation on case " + actionItem + " failed");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Validation on case " + actionItem + " failed");

        }
    }

    public void searchComponentValidations(String actionType, String actionItem, String itemName, String section) throws Exception {
        List<String> actual = new ArrayList<>();
        boolean flag = false;
        try {
            switch (actionType) {
                case "Verify Presence":
                    if(actionItem.equalsIgnoreCase("Search Icon")) {
                        Assert.assertTrue(isElementPresent(getSearchIcon()));
                    } else if(actionItem.equalsIgnoreCase("Search InputBox")){
                        Assert.assertTrue(isElementPresent(getTableComponentsearchInputBox()));
                    } else if(actionItem.equalsIgnoreCase("Search InputBox Placeholder text")){
                        Assert.assertTrue(getTableComponentsearchInputBox().getAttribute("placeholder").contains(itemName));
                    } else if(actionItem.equalsIgnoreCase("Item View Search Icon")){
                        Assert.assertTrue(isElementPresent(getItemViewsearchIcon()));
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Click":
                    if(actionItem.equalsIgnoreCase("Search Icon")) {
                        clickOn(driver,getSearchIcon());
                    }else if(actionItem.equalsIgnoreCase("Clear Search")){
                        getTableComponentsearchInputBox().clear();
                        waitUntilAngularReady(driver);
                        enterText(getTableComponentsearchInputBox(), " ");
                        waitUntilAngularReady(driver);
                        sleepForSec(300);
                        pressKey(getTableComponentsearchInputBox(), Keys.BACK_SPACE);
                        waitUntilAngularReady(driver);
                    }  else if(actionItem.equalsIgnoreCase("Item View Search Icon")){
                        clickOn(getItemViewsearchIcon());
                    } else if(actionItem.equalsIgnoreCase("Close search box")){
                        clickOn(getSearchCloseIcon());
                    }else {
                        throw new Exception();
                    }
                    break;
                case "Enter Text":
                    enterText(getTableComponentsearchInputBox(), actionItem);
                    break;
            }
            waitUntilAngularReady(driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Validation on case " + actionItem + " failed");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Validation on case " + actionItem + " failed");

        }
    }

    public void validatePresenceOfTabFocusManageTags(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder ManageTags Validation":
                if (section.equalsIgnoreCase("ManageTags")) {
                    clickOn(getManageTagTitle());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    clickOn(getsearchTag());
                    getsearchTag().sendKeys("GEN");
                    waitForAngularLoad(driver);
                    clickOn(getGeneralTagTile());
                    String general = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(general, fieldName);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String Addbutton = driver.switchTo().activeElement().getAttribute("title");
                    Assert.assertEquals(Addbutton, actionItem);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String Editbutton = driver.switchTo().activeElement().getAttribute("title");
                    Assert.assertEquals(Editbutton, itemName);
                }
                break;
        }
    }

    public void validatePresenceOfTabFocusAssignTags(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder AssignTags Validation":
                if (section.equalsIgnoreCase("AssignTags")) {
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String createTagButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(createTagButton, fieldName);
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    waitForAngularLoad(driver);
                    clickOn(getTagNameField());
                    getTagNameField().sendKeys("NEW");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    clickOn(getTagDefinitionField());
                    getTagDefinitionField().sendKeys("Definition");
                    clickOn(getTagDefinitionField());
                    clickOn(getSaveTagButton());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    String cancelButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(cancelButton, itemName);
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String assignTagButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(assignTagButton, reverseTab);
                    actions.keyUp(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    waitForAngularLoad(driver);
                }
                break;
        }
    }

    public void validatePresenceOfTabFocusItemView(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder ItemViewScreen Validation":
                if (section.equalsIgnoreCase("ItemViewBreadcrumbNavigation")) {
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    Assert.assertTrue(isElementPresent(getSearchResultsTitle()));
                } else if (section.equalsIgnoreCase("ItemViewScreenWidgetCollapseAndRate")) {
                    clickOn(getRatingWidgetTitle());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("ARROW_RIGHT"));
                    actions.keyUp(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    waitForAngularLoad(driver);
                }
                break;
        }
    }

    public void validatePresenceOfTabFocusItemViewEdit(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder ItemViewBA Validation":
                if (section.equalsIgnoreCase("BAItemViewOnEditing")) {
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String cancelBaButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(cancelBaButton, fieldName);
                    clickOn(getApplicationIDLabelField());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    getApplicationIDTextBox().sendKeys("123");
                    waitForAngularLoad(driver);
                    clickOn(getBusinessCriticalityField());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    clickOn(getLeftWidgetArrowButton());
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    actions.keyUp(Keys.SHIFT).release().perform();
                    String saveButtonReverseTab = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(saveButtonReverseTab, reverseTab);
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                }
                break;
        }
    }

    public void validatePresenceOfTabFocusManageRoles(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder Manage Roles validation":
                if (section.equalsIgnoreCase("Add Role Screen")) {
                    waitForAngularLoad(driver);
                    getRoleNameField().sendKeys("Tab Role");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    getRoleDescriptionField().sendKeys("Test Description");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    getSearchBoxInManageAcess().sendKeys("BASE_PERMISSION");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    clickOn(getPermissionText());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                } else if (section.equalsIgnoreCase("Edit Role Screen")) {
                    waitForAngularLoad(driver);
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String cancelButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(cancelButton, reverseTab);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String saveButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(saveButton, actionItem);
                    actions.keyUp(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                } else if (section.equalsIgnoreCase("Clone Role Screen")) {
                    waitForAngularLoad(driver);
                    getRoleNameField().sendKeys("Tab Role Clone");
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String closeButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(closeButton, reverseTab);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String cancelButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(cancelButton, itemName);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    String saveButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(saveButton, actionItem);
                    actions.keyUp(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                }
                break;
        }
    }

    public void validatePresenceOfTabFocusLDAPUsers(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder Manage LDAP Users validation":
                if (section.equalsIgnoreCase("Add LDAP Screen")) {
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    getLdapUserNameSearchField().sendKeys("Becubic Build");
                    waitForAngularLoad(driver);
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                } else if (section.equalsIgnoreCase("Edit LDAP Screen")) {
                    waitForAngularLoad(driver);
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    actions.keyUp(Keys.SHIFT).release().perform();
                    String cancelButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(cancelButton, reverseTab);
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    actions.keyUp(Keys.SHIFT).release().perform();
                }
                break;

        }
    }

    public void validatePresenceOfTabFocusLocalUsers(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder Manage Local Users validation":
                if (section.equalsIgnoreCase("Add Local User Screen")) {
                    getLocalUserFullNameField().sendKeys("LocalUser");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    getLocalUserNameField().sendKeys("LocalUser");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    getLocalUserPassword().sendKeys("LocalUser");
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    getLocalUserEmail().sendKeys("LocalUser@asg.com");
                } else if (section.equalsIgnoreCase("Edit Local User Screen")) {
                    waitForAngularLoad(driver);
                    actions.keyDown(Keys.SHIFT).release().perform();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    actions.keyUp(Keys.SHIFT).release().perform();
                    String cancelButton = driver.switchTo().activeElement().getText();
                    Assert.assertEquals(cancelButton, reverseTab);
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                }
                break;
        }
    }

    public void validatePresenceOfTabFocusManageRolesLDAPLocalUsers(String actionType, String fieldName, String actionItem, String itemName, String section, String reverseTab) throws Exception {
        Actions actions = new Actions(driver);
        boolean flag = false;
        switch (actionType) {
            case "Taborder Manage Roles LDAP and Local User validation":
                if (section.equalsIgnoreCase("Manage Roles Screen")) {
                    waitForAngularLoad(driver);
                    clickOn(getRoleLDAPLocalscereenTitle());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    getSearchBoxInManageAcess().sendKeys("System Administrator");
                } else if (section.equalsIgnoreCase("Manage LDAP Users Screen")) {
                    waitForAngularLoad(driver);
                    clickOn(getRoleLDAPLocalscereenTitle());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    boolean filterButton = driver.switchTo().activeElement().isDisplayed();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    getSearchBoxInManageAcess().sendKeys("Becubic Build");
                } else if (section.equalsIgnoreCase("Manage Local Users Screen")) {
                    waitForAngularLoad(driver);
                    clickOn(getRoleLDAPLocalscereenTitle());
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    boolean filterButton = driver.switchTo().activeElement().isDisplayed();
                    keyPressEvent(driver, Keys.valueOf("TAB"));
                    keyPressEvent(driver, Keys.valueOf("ENTER"));
                    getSearchBoxInManageAcess().sendKeys("Test System Administrator");
                }
                break;
        }
    }
}