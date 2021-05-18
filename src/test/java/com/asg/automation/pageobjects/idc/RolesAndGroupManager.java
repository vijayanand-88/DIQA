package com.asg.automation.pageobjects.idc;

import com.asg.automation.pageactions.idc.RolesAndGroupManagerActions;
import com.asg.automation.pageobjects.ida.AnalysisPage;
import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import javax.management.relation.RoleList;
import javax.ws.rs.DELETE;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.TreeMap;

public class RolesAndGroupManager extends UIWrapper {
    private WebDriver driver;

    public RolesAndGroupManager(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intializing Bundle Manager PageFactory Class");
    }

    @FindBy(xpath = "//div[@class='dashboard-widget dashboard_16']//div[@class='asg-base-widget-quick-header'][contains(text(),'QUICK LINKS')]")
    private WebElement RolesQuickLinkLabel;

    @FindBy(xpath = "//div[@class='dashboard-widget dashboard_16']//div[@class='asg-base-widget-recent-header'][contains(text(),'RECENT')]")
    private WebElement RolesRecentLinkLabel;

    @FindBy(css="div.dashboard-widget.dashboard_16>div.btn-group.widget-menu:nth-child(2)>button.btn.btn-primary")
    private WebElement RolesGroupResizeButton;

    @FindBy(xpath = "//span[contains(.,'Manage Roles and User')]")
    private WebElement RoleGroupDefinition;

    @FindBy(xpath = "//p[contains(.,'Role manager: assign roles and permissions')]")
    private WebElement RoleGroupDescription;

    public List<WebElement> getWidgetName(String widget){
        return driver.findElements(By.xpath("//li[@class[contains(.,'dashboard-widget-wraper')]]//a[contains(.,'"+widget+"')]"));
    }

    @FindBy(css = "table>tbody>tr:nth-child(1) button:nth-child(1)")
    private WebElement RolesAndGroupForkIcon;

    @FindBy(xpath = "//div[@class='actions-bar']//span[contains(text(),'Create New Role')]")
    private WebElement createNewRoleButton;

    @FindBy(xpath = "//div[@class='actions-bar']//span[contains(text(),'Assign Group and User')]")
    private WebElement assignGroupAndUserButton;

    @FindBy(xpath = "//span[contains(text(),'Create New Role')]/following::div[@class='content-role-table'][1]")
    private List<WebElement> RolesList;

    @FindBy(xpath = "//span[contains(text(),'Create New Role')]/following::div[@class='content-role-table'][2]")
    private List<WebElement> GroupAndUserList;

    @FindBy(xpath = "//div[@class='asg-item-view-tabs']//following::li")
    private List<WebElement> isLabelsPresentInManageAccess;

    @FindBy(xpath = "//div[@class[contains(.,'title')]]")
    private WebElement headerText;

    @FindBy(xpath = "//span[@class[contains(.,'add-text cursor-pointer')]]")
    private WebElement addRoleAndUserButtonInManageAccessRolesPage;

    @FindBy(xpath = "//div//following::button[contains(.,'SAVE')]")
    private WebElement addRoleAndUserSaveButtonInManageAccessRolesPage;

    @FindBy(xpath = "//div[@class[contains(.,'header-title')]]/span[@class[contains(.,'title')]]/span[@class[contains(.,'count')]]")
    private WebElement HeaderofManageAccess;

    @FindBy(xpath = "//span[@class='count ng-star-inserted']")
    private WebElement CountofManageAccess;

    @FindBy(xpath = "//button[contains(@class,'form-control hide-default-toggle')]")
    private WebElement TestUserDropdownfilter;

    @FindBy(xpath = "//button[contains(@class,'dropdown-toggle field-element')]")
    private WebElement selectRolesDropdownButton;

    @FindBy(xpath = "//button[contains(@class,'form-control hide-default-toggle')]//span[contains(text(),'Select role')]")
    private WebElement usersandgroupsrolesdropdown;

    @FindBy(xpath = "//input[@class='form-control']")
    private WebElement UsersandRolesSearchText;

    @FindBy(xpath = "//em[@class='fa fa-close']")
    private WebElement CreateTestUserFilterCloseButton;

    @FindBy(xpath = "//em[@class='add-icon fas fa-plus-square cursor-pointer pt-2 pl-2']")
    private WebElement CreateTestUserRoleButton;

    @FindBy(xpath = "//span[contains(@class,'mr-3 manage-search cursor-pointer fa fa-filter')]")
    private WebElement ManageAccessFilterButton;

    @FindBy(xpath = "//span[@class[contains(.,'asg-change-password float-left bg-transparent cursor-pointer text-left mt-2')]]")
    private WebElement CreateTestUserChangePassword;

    @FindBy(xpath = "//td[contains(@class,'text-truncate')]")
    private List<WebElement> UsersList;

    @FindBy(xpath = "//button[@role='option']")
    private List<WebElement> manageAccessSuggestionsList;

    @FindBy(xpath = "//*[@class[contains(.,'form-field-element')]]/preceding::label")
    private List<WebElement> manageAccessFieldNameList;

    @FindBy(xpath = "//*[@class[contains(.,'form-field-element')]]")
    private List<WebElement> manageAccessFieldList;

    @FindBy(xpath = "//div[@class[contains(.,'multi-selection-box dropdown-content')]]")
    private List<WebElement> manageAccessDropdownbox;

    @FindBy(xpath = "//*[@class[contains(.,'form-field-element')]]/input")
    private List<WebElement> manageAccessTextFieldList;

    @FindBy(xpath = "//button[@class[contains(.,'align-items-center')]]")
    private List<WebElement> manageAccessMenuOptionsAsList;

    @FindBy(xpath = "//button[@class[contains(.,'field-element')]]/div/div[@class[contains(.,'align-items')]]")
    private List<WebElement> manageAccessMenuOptionsinField;

    @FindBy(xpath = "//h4[@class='text-center title-style']")
    private WebElement manageAcessPopupTitle;

    @FindBy(xpath = "//button[@role='menuitem']/div")
    private List<WebElement> manageAccessFilterDropDownnList;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate')]][1]")
    private List<WebElement> manageAccessUsersList;

    @FindBy(xpath = "//span[@class='text-truncate']")
    private List<WebElement> manageAccessPopupOptionsList;

    @FindBy(xpath = "//span[@class='cursor-pointer'][@title]")
    private List<WebElement> manageAccessColumnList;

    @FindBy(css = "button[id='roles'] > em")
    private WebElement rolesDropdown;
    @FindBy(xpath = "//button[@class[contains(.,'')]]//following::span[contains(.,'')]")
    private List<WebElement> rolesList;

    public WebElement getTextBoxInAddRolesAndUsersPages(String textbox) {
        return driver.findElement(By.xpath("//input[@id='" + textbox + "']"));
    }

    public WebElement clickPermissionsInAddRolesPages(String textbox) {
        return driver.findElement(By.xpath("//div[@class='asg-custom-checkbox']/following::input[@id[contains(.,'" + textbox + "')]]"));
    }

    public WebElement clickManageAccessMenuTab(String Tab) {
        return driver.findElement(By.xpath("//div[@class='asg-item-view-tabs']//following::li[contains(.,'" + Tab + "')]"));
    }

    public WebElement getRole(String role) {
        return driver.findElement(By.xpath("//div[@class='content-role-table']//following::td[contains(.,'" + role + "')]"));
    }

    public WebElement identifyRolesGroup() {
        return driver.findElement(By.xpath("//a[contains(.,'ROLES AND GROUP MANAGER')]"));
    }

    public WebElement getCloneButtonForTheRole(String roleName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + roleName + "')]//following::span[@class[contains(.,'fa fa-clone')]][1]"));
    }

    public WebElement getEditButtonForTheRole(String roleName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + roleName + "')]//following::span[@class[contains(.,'far fa-edit')]][1]"));
    }

    public WebElement getDeleteButtonForTheRole(String roleName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + roleName + "')]//following::span[@class[contains(.,'far fa-trash')]][1]"));
    }

    public WebElement getRolesTable(String tableName) {
        return driver.findElement(By.xpath("//span[contains(text(), '"+tableName+"')]"));
    }

    public WebElement getRolesCount(String tableName) {
        return driver.findElement(By.xpath("//span[contains(text(), '"+tableName+"')]//span[@class='count']"));
    }

    public WebElement getRolesAndGroupManagerQuickLink() {
        scrollToWebElement(driver, RolesQuickLinkLabel);
        return RolesQuickLinkLabel;
    }

    public WebElement getRolesAndGroupManagerRecentLabel() {
        scrollToWebElement(driver, RolesRecentLinkLabel);
        return RolesRecentLinkLabel;
    }

    public WebElement getRolesGroupResizeButton() {
        scrollToWebElement(driver, RolesGroupResizeButton);
        return RolesGroupResizeButton;

    }

    public WebElement getRolesGroupDefinition() {
        synchronizationVisibilityofElement(driver, RoleGroupDefinition);
        return RoleGroupDefinition;
    }

    public WebElement getRolesAndGroupForkIcon() {
        synchronizationVisibilityofElement(driver, RolesAndGroupForkIcon);
        return RolesAndGroupForkIcon;
    }
    public WebElement getRoleGroupDescription() {
        synchronizationVisibilityofElement(driver, RoleGroupDescription);
        return RoleGroupDescription;
    }
    public WebElement getCreateNewRoleButton() {
        synchronizationVisibilityofElement(driver, createNewRoleButton);
        return createNewRoleButton;
    }

    public WebElement getAssignGroupAndUserButton() {
        synchronizationVisibilityofElement(driver, assignGroupAndUserButton);
        return assignGroupAndUserButton;
    }

    public List<WebElement> getRoleList() {
        return RolesList;
    }

    public List<WebElement> getGroupAndUserList() {
        return GroupAndUserList;
    }

    public WebElement getHeaderText() {
        synchronizationVisibilityofElement(driver, headerText);
        return headerText;
    }

    public WebElement getAddRoleAndUserButtonInManageAccessRolesPage() {
        synchronizationVisibilityofElement(driver, addRoleAndUserButtonInManageAccessRolesPage);
        return addRoleAndUserButtonInManageAccessRolesPage;
    }

    public WebElement getAddRoleAndUserSaveButtonInManageAccessRolesPage() {
        synchronizationVisibilityofElement(driver, addRoleAndUserSaveButtonInManageAccessRolesPage);
        return addRoleAndUserSaveButtonInManageAccessRolesPage;
    }
    public void selectmanageaccessusersandgroups(String fieldName) throws Exception {
        moveToElement(driver, getManageaccessUserandgroupsdropdown(fieldName));
        clickonWebElementwithJavaScript(driver, getManageaccessUserandgroupsdropdown(fieldName));
    }
    public void selectmanageaccessusersandgroupsroles(String fieldName) throws Exception {
        moveToElement(driver, getManageaccessUserandgroupsrolesdropdown(fieldName));
        clickonWebElementwithJavaScript(driver, getManageaccessUserandgroupsrolesdropdown(fieldName));
    }
    public WebElement usersandgroupssearchtextvalidation(String ActionItem) {
        return driver.findElement(By.xpath("//button[@class='dropdown-item active ng-star-inserted']//span[contains(text(),'"+ActionItem+"')]"));
    }
    public WebElement usersandgroupsAssignedroles(String ActionItem) {
        return driver.findElement(By.xpath("//label[contains(text(),'"+ActionItem+"')]"));
    }
    public WebElement getManageaccessUserandgroupsdropdown(String FieldName) {
        return driver.findElement(By.xpath("//div[@class='dropdown-filter text-truncate'][contains(text(),'"+FieldName+"')]"));
    }
    public WebElement getManageaccessUserandgroupsrolesdropdown(String FieldName) {
        return driver.findElement(By.xpath("//li[contains(@class,'dropdown-item')]//span[contains(text(),'"+FieldName+"')]"));
    }
    public WebElement getUsersandgroupsediticon(String actionItem) {
        return driver.findElement(By.xpath("(//span[text()='"+actionItem+"']//following::span[contains(@class,'far fa-edit cursor-pointer')])[1]"));
    }
    public WebElement getTestUserTabvalues(String ActionItem) {
        return driver.findElement(By.xpath("//td[@title='"+ActionItem+"']//span[contains(text(),'"+ActionItem+"')]"));
    }
    public WebElement  getManageAccessNameRoleType(String actionItem) {
        return driver.findElement(By.xpath("//span[@class='cursor-pointer' and contains(text(),' " + actionItem + "')]"));
    }
    public WebElement getUsersandGroupsHeader(String actionItem) {
        return driver.findElement(By.xpath("//h4[contains(text(),'"+actionItem+"')]"));
    }
    public WebElement getUsersandGroupshelptext(String actionItem) {
        return driver.findElement(By.xpath("//p[contains(text(),'"+actionItem+"')]"));
    }
    public WebElement getTabvalueManageAccess(String ActionItem) {
        return driver.findElement(By.xpath("//ul[@class='nav nav-tabs']//a[contains(text(),'" + ActionItem + "')]"));
    }
    public WebElement getTestUserRoleValue(String ActionItem) {
        return driver.findElement(By.xpath("//span[@class='ng-star-inserted' and text()='" + ActionItem + "']"));
    }
    public WebElement getManageAccessHeader() {
        return HeaderofManageAccess;
    }
    public WebElement getManageAccessCount() {
        synchronizationVisibilityofElement(driver, CountofManageAccess);
        return CountofManageAccess;
    }
    public List<WebElement> ManageAccesstabstablesize() {
        List<WebElement> ManageAccesstable=driver.findElements(By.xpath("//div[@class='table']//following::tr"));
        return ManageAccesstable;
    }
    public WebElement getTestUserFilterDropdown() {
        synchronizationVisibilityofElement(driver, TestUserDropdownfilter);
        return  TestUserDropdownfilter;
    }
    public WebElement getRolesDropDown() {
        synchronizationVisibilityofElement(driver, selectRolesDropdownButton);
        return  selectRolesDropdownButton;
    }
    public WebElement getusersandgroupsdropdown() {
        synchronizationVisibilityofElement(driver, usersandgroupsrolesdropdown);
        return usersandgroupsrolesdropdown;
    }
    public WebElement getUsersandRolessearchText() {
        synchronizationVisibilityofElement(driver, UsersandRolesSearchText);
        return UsersandRolesSearchText;
    }
    public WebElement getusersandgroupsusernamealertmessage(String actionItem) {
        return driver.findElement(By.xpath("//div[contains(text(),'"+actionItem+"')]"));
    }
    public WebElement getTestUserFilterDropdownclosebutton() {
        synchronizationVisibilityofElement(driver, CreateTestUserFilterCloseButton);
        return  CreateTestUserFilterCloseButton;
    }
    public WebElement getCreateTestUserRoleButton() {
        synchronizationVisibilityofElement(driver, CreateTestUserRoleButton);
        return CreateTestUserRoleButton;
    }
    public WebElement getTestUserFilter() {
        synchronizationVisibilityofElement(driver, ManageAccessFilterButton);
        return ManageAccessFilterButton;
    } public WebElement getTestUserChangePassword() {
        synchronizationVisibilityofElement(driver, CreateTestUserChangePassword);
        return CreateTestUserChangePassword;
    }
    public WebElement getTestUsersPopuPAccessDenied(String actionItem) {
        return driver.findElement(By.xpath("//p[contains(text(),'"+actionItem+"')]"));
    }
    public WebElement getManageUsersandRoles(String value) {
        return driver.findElement(By.xpath("//div[@class='icon-block d-flex align-items-center']//following::a[contains(text(),'"+value+"')]"));
    }
    public WebElement getManageConfigurationsHeader(String value) {
        return driver.findElement(By.xpath("//div[contains(text(),'"+value+"')]"));
    }

    public WebElement getGroupsndRole(String User,String Role) {
        return driver.findElement(By.xpath("//span[@title='"+User+"']//following::span[@title='"+Role+"'][1]"));
    }

    public WebElement getUsersandgroupsrolesdropdown(String FieldName) {
        return driver.findElement(By.xpath("//button[contains(@class,'dropdown-item')]//span[contains(text(),'"+FieldName+"')]"));
    }

    public void selectUserFromdrodown(String fieldName) throws Exception {
        moveToElement(driver, getUsersandgroupsrolesdropdown(fieldName));
        clickonWebElementwithJavaScript(driver, getUsersandgroupsrolesdropdown(fieldName));
        waitForAngularLoad(driver);
    }

    public WebElement getTestUser(String ActionItem) {
        return driver.findElement(By.xpath("//td[@title='"+ActionItem+"']"));
    }

    public WebElement getTestUsersText(String name) {
        return driver.findElement(By.xpath("//input[@name='"+name+"']"));
    }

    public List<WebElement> getUsersList() {
        return UsersList;
    }

    public WebElement getManageAccessField(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::input"));
    }

    public List<WebElement> getManageAccessSuggestionsList(){
        return manageAccessSuggestionsList;
    }

    public List<WebElement> getManageAccessFieldList() {
        return manageAccessFieldList;
    }

    public List<WebElement> getManageAccessFieldNameList() {
        return manageAccessFieldNameList;
    }

    public List<WebElement> getManageAccessDropdownbox() {
        return manageAccessDropdownbox;
    }

    public List<WebElement> getManageAccessTextFieldList() {
        return manageAccessTextFieldList;
    }

    public List<WebElement> getManageAccessMenuOptionsAsList() {
        return manageAccessMenuOptionsAsList;
    }

    public List<WebElement> getManageAccessMenuOptionsinField() {
        return manageAccessMenuOptionsinField;
    }

    public WebElement getManageAcessPopupTitle() {
        return manageAcessPopupTitle;
    }

    public WebElement getManageAccessFilterButton(String roleName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'label-text')]][contains(.,'" + roleName + "')]//following::em[@class='fa fa-chevron-down']"));
    }

    public List<WebElement> getManageAccessFilterDropDownnList() {
        return manageAccessFilterDropDownnList;
    }

    public List<WebElement> getManageAccessUsersList() {
        return manageAccessUsersList;
    }

    public WebElement getManageAccessPopupDropdown(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(@class,'asg-dyn-form-property-label')][contains(.,'" + fieldName + "')]//following::em"));
    }

    public List<WebElement> getManageAccessPopupOptionsList() {
        return manageAccessPopupOptionsList;
    }

    public List<WebElement> getManageAccessColumnList() {
        return manageAccessColumnList;
    }

    public WebElement getRolesDropdown() {
        return rolesDropdown;
    }

    public WebElement selectRole(String roleName) {
        return driver.findElement(By.xpath("//button//span[contains(.,'"+roleName+"')]"));
    }


    public List<WebElement> getRolesFromList(){
        return rolesList;
    }
    //=============================================================
    //=======================Page Actions==========================
    //=============================================================


    public void genericClick(String elementName, String... argu) {
        try {
            switch (elementName) {
                case "RolesGroup Widget Resize":
                    waitForAngularLoad(driver);
                    clickOn(driver,getRolesGroupResizeButton());
                    break;
                case "1 x 1":
                    clickOn(driver,traverseListContainsElementReturnsElement(new PluginManager(driver).pluginManagerResizeMenuList(), elementName));
                    break;
                case "1 x 2":
                    clickOn(driver,traverseListContainsElementReturnsElement(new PluginManager(driver).pluginManagerResizeMenuList(), elementName));
                    break;
                case "Fork Icon":
                    clickOn(driver,getRolesAndGroupForkIcon());
                    break;
                case "Roles":
                    clickonWebElementwithJavaScript(driver,clickManageAccessMenuTab(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Users":
                    clickonWebElementwithJavaScript(driver,clickManageAccessMenuTab(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Groups":
                    clickonWebElementwithJavaScript(driver,clickManageAccessMenuTab(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Data Assets":
                    clickonWebElementwithJavaScript(driver,clickManageAccessMenuTab(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Add Role":
                case "Add Local User":
                case "Add LDAP User":
                case "Add User":
                    clickOn(getAddRoleAndUserButtonInManageAccessRolesPage());
                    waitForAngularLoad(driver);
                    break;
                case "Save Role":
                case "Save Local User":
                    moveToElementUsingJavaScript(driver,getAddRoleAndUserSaveButtonInManageAccessRolesPage());
                    clickOn(driver,getAddRoleAndUserSaveButtonInManageAccessRolesPage());
                    sleepForSec(5000);
                    break;
                case "Permissions":
                    waitForAngularLoad(driver);
                    moveToElement(driver, clickPermissionsInAddRolesPages(argu[0]));
                    clickonWebElementwithJavaScript(driver, clickPermissionsInAddRolesPages(argu[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Clone":
                    moveToElementWithActions(driver, getCloneButtonForTheRole(argu[0]));
                    clickonWebElementwithJavaScript(driver, getCloneButtonForTheRole(argu[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Edit":
                    moveToElementWithActions(driver, getEditButtonForTheRole(argu[0]));
                    clickonWebElementwithJavaScript(driver, getEditButtonForTheRole(argu[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Delete":
                    waitForAngularLoad(driver);
                    moveToElementWithActions(driver, getDeleteButtonForTheRole(argu[0]));
                    clickOn(driver, getDeleteButtonForTheRole(argu[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Add users":
                    scrollToWebElement(driver,getAddRoleAndUserButtonInManageAccessRolesPage());
                    clickonWebElementwithJavaScript(driver,getAddRoleAndUserButtonInManageAccessRolesPage());
                    waitForAngularLoad(driver);
                    break;
                case "Click remove role":
                    waitForAngularLoad(driver);
                    clickOn(driver, new AnalysisPage(driver).getEditTestUserRolecloseButton());
                    break;
                case "Click on Tab":
                    clickOn(getTabvalueManageAccess(argu[0]));
                    break;
                case "Add Roles":
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver,getCreateTestUserRoleButton());
                    break;
                case "Click Filter":
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver,getTestUserFilter());
                    break;
                case "Edit Icon":
                     waitForAngularLoad(driver);
                     moveToElement(driver,getTestUserTabvalues(argu[0]));
                     clickOn(driver,getUsersandgroupsediticon(argu[0]));
                     break;
                case "Change password":
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver,getTestUserChangePassword());
                    break;
                case "Users & Groups":
                    clickOn(driver,getManageUsersandRoles(argu[0]));
                    waitForAngularLoad(driver);
                    break;

            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "ROLES AND GROUP MANAGER":
                    Assert.assertTrue(isElementPresent(identifyRolesGroup()));
                    break;
                case "QUICK lINKS":
                    Assert.assertTrue(isElementPresent(getRolesAndGroupManagerQuickLink()));
                    break;
                case "RECENT":
                    Assert.assertTrue(isElementPresent(getRolesAndGroupManagerRecentLabel()));
                    break;
                case "Manage roles and users here":
                    Assert.assertTrue(isElementPresent(getRolesGroupDefinition()));
                    break;
                case "Assign roles and permissions":
                    Assert.assertTrue(isElementPresent(getRoleGroupDescription()));
                    break;
                case "Fork Icon":
                    Assert.assertTrue(isElementPresent(getRolesAndGroupForkIcon()));
                    break;
                case "Create New Role":
                    Assert.assertTrue(isElementPresent(getCreateNewRoleButton()));
                    break;
                case "Assign Group and User":
                    Assert.assertTrue(isElementPresent(getAssignGroupAndUserButton()));
                    break;
                case "Groups and Users":
                    Assert.assertTrue(new RolesAndGroupManager(driver).getGroupAndUserList().isEmpty());
                    break;
                case "Manage Access Header text":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getHeaderText()));
                    break;
                case "Manage Access Message":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getHeaderText()));
                    break;
                  //10.3
                case "Roles":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getRolesTable(elementName)));
                    Assert.assertTrue(isElementPresent(getRolesCount(elementName)));
                    break;
                case "name":
                case "Description":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getRolesTable(elementName)));
                    break;
                case "Username textbox is disabled":
                    waitForAngularLoad(driver);
                    Assert.assertFalse(isElementEnabled(getUsersandRolessearchText()));
                    break;
                case "Access denied to perform this operation":
                    Assert.assertTrue(isElementPresent(getTestUsersPopuPAccessDenied(elementName)));
                    break;

            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public boolean validateElementPresense(String actionType, List<String> data) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionType) {
            case "labels":
                for (String expValue : data) {
                    expected.add(expValue);
                }
                for (WebElement label : isLabelsPresentInManageAccess) {
                    actual.add(label.getText());
                }
                if (CommonUtil.compareLists(actual, expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
        }
        return flag;
    }

    public void enterTextInAddRolesAndUsersPages(String fieldName, String inputText) throws Exception {
        sleepForSec(1000);
            waitForAngularLoad(driver);
            enterText(getTextBoxInAddRolesAndUsersPages(fieldName), inputText);
            waitForAngularLoad(driver);
    }

    public boolean validateElementPresenseForRolesAndusers(String action, String roleName) throws Exception {
        boolean flag = false;
        switch (action) {
            case "Clone":
                takeScreenShot(action +" is captured", driver);
                moveToElement(driver,getCloneButtonForTheRole(roleName));
                verifyTrue(isElementPresent(getCloneButtonForTheRole(roleName)));
                break;
            case "Edit":
                takeScreenShot(action +" is captured", driver);
                moveToElement(driver,getEditButtonForTheRole(roleName));
                verifyTrue(isElementPresent(getEditButtonForTheRole(roleName)));
                break;
            case "Delete":
                takeScreenShot(action +" is captured", driver);
                moveToElement(driver,getDeleteButtonForTheRole(roleName));
                verifyTrue(isElementPresent(getDeleteButtonForTheRole(roleName)));
                break;
        }

        return flag;
    }
    public void manageAccessValidation(String actionType, String actionItem,String ItemName,String Section, String Attribute) throws Exception {
        switch (actionType) {
            case "Verifies Item Displayed":
                String text = getElementText(getTestUserTabvalues(actionItem));
                Assert.assertEquals(actionItem, text.trim());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is displayed under the Manage Access");
                break;
            case "Verifies TestUser Filter based value":
                String roletext = getElementText(getTestUserRoleValue(actionItem));
                Assert.assertEquals(actionItem, roletext);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Manage Access");
                break;
            case "Verify Header and Count":
                String header = getElementText(getManageAccessHeader());
                String hdr = header.substring(0, 10);
                String count = getElementText(getManageAccessCount());
                String countrim = count.replaceAll("[()]", "");
                int tblsiz = Integer.parseInt(countrim);
                Assert.assertEquals(actionItem, hdr.trim());
                Assert.assertEquals(tblsiz,ManageAccesstabstablesize().size());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "TestUsers Header Found");
                break;
            case "Verifies Role,Name,Type":
                String ManageAccesstext = getElementText(getManageAccessNameRoleType(actionItem));
                ManageAccesstext.equalsIgnoreCase(actionItem);
                clickOn(driver,getManageAccessNameRoleType(actionItem));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Manage Access");
                break;
            case "Verify Header and Count of Users and Groups":
                Assert.assertTrue(isElementPresent(getManageAccessHeader()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "TestUsers Header Found");
                break;
            case "Verify Header and Count of Test Users":
                Assert.assertTrue(isElementPresent(getManageAccessHeader()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "TestUsers Header Found");
                break;
            case "Select Dropdown":
                if (Section.equalsIgnoreCase("As Input")) {
                    getTestUserFilterDropdown().isDisplayed();
                    moveToElement(driver,getTestUserFilterDropdown());
                    clickOn(getTestUserFilterDropdown());
                    selectmanageaccessusersandgroups(ItemName);
                    keyPressEvent(driver, Keys.ESCAPE);
                } else if (Section.equalsIgnoreCase("In Mapping Value")) {
                    moveToElement(driver,getusersandgroupsdropdown());
                    clickOn(getusersandgroupsdropdown());
                    sleepForSec(2000);
                    selectmanageaccessusersandgroupsroles(ItemName);
                    keyPressEvent(driver, Keys.ESCAPE);
                } else if (Section.equalsIgnoreCase("User dropdown Value")) {
                  sleepForSec(1000);
                    waitForAngularLoad(driver);
                    selectUserFromdrodown(ItemName);
                } else {
                    throw new Exception();
                }
                break;
            case "Verify Header":
                waitForAngularLoad(driver);
                String headertext = getElementText(getUsersandGroupsHeader(actionItem));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Manage Access");
                Assert.assertEquals(actionItem, headertext.trim());
                break;
            case "Verify Assigned Username,Roles":
                String assignedtext = getElementText(usersandgroupsAssignedroles(actionItem));
                String assignedtextsub = assignedtext.substring(0, 14);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Manage Access");
                Assert.assertEquals(actionItem, assignedtextsub.trim());
                break;
            case "Verify Users and groups help text ":
                String helptext = getElementText(getUsersandGroupshelptext(actionItem));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Help Text is displayed");
                Assert.assertEquals(actionItem, helptext.trim());
                break;
            case "Verify Usersandgroupalertmessage":
                String alerttext = getElementText(getusersandgroupsusernamealertmessage(actionItem));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "alert message is displayed");
                Assert.assertEquals(actionItem, alerttext.trim());
                break;
            case "Clears the text area in add test user page":
                doubleClick(driver, new DashBoardPage(driver).getTextBoxInSaveSearchPage(actionItem));
                keyPressEvent(driver, Keys.BACK_SPACE);
                break;
            case "Verify Header of Manage Configurations":
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Header is displayed");
                Assert.assertTrue(getManageConfigurationsHeader(actionItem).isDisplayed());
                break;
            case "Verify Header of Administation left panel menu":
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Administration Left panel Menu is displayed");
                Assert.assertTrue(getManageUsersandRoles(actionItem).isDisplayed());
                break;
            case "Verify Groups,roles":
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Administration Left panel Menu is displayed");
                Assert.assertTrue(getGroupsndRole(actionItem, ItemName).isDisplayed());
                break;
            case "Enter Text in User and Groups":
                waitUntilAngularReady(driver);
                if (Section.equalsIgnoreCase("Assigned Roles")) {
                    scrollToWebElement(driver, usersandgroupsAssignedroles(Section));
                    enterText(getTestUsersText(actionItem), ItemName);
                }else if(Section.equalsIgnoreCase("Edit")){
                    enterText(new DashBoardPage(driver).gettextboxPlaceholdermessage(actionItem), ItemName);
                    clickOn(getTestUserChangePassword());
                }
                else if(Section.equalsIgnoreCase("Usersandgroups")){
                    waitForAngularLoad(driver);
                    enterText(getUsersandRolessearchText(), ItemName);
                }
                else {
                    enterText(new DashBoardPage(driver).gettextboxPlaceholdermessage(actionItem), ItemName);
                }
                break;
            case "User/groups dropdown":
                waitForAngularLoad(driver);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "User/group is displayed");
                Assert.assertTrue(isElementPresent(getUsersandgroupsrolesdropdown(ItemName)));
                break;
            case "Verifies User Displayed":
                String user = getElementText(getTestUser(actionItem));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "User is displayed");
                Assert.assertEquals(actionItem, user.trim());
                break;
            case "Verifies User not Displayed":
                Assert.assertFalse(traverseListContainsElement(getUsersList(),ItemName));
                break;
            case "Verifies Profile Icon Highlighted":
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).getProfileIcon()));
                clickOn(new DashBoardPage(driver).getProfileIcon());
                Assert.assertTrue(isElementPresent(new DashBoardPage(driver).getProfileIconActive()));
                break;
            case "Enter Text in field":
                if (actionItem.equalsIgnoreCase("Role")) {
                    enterText(getManageAccessField(actionItem), ItemName);
                    waitForAngularLoad(driver);
                    traverseListContainsElementAndClick(driver, getManageAccessSuggestionsList(), ItemName);
                    waitForAngularLoad(driver);
                    clickOn(getCreateTestUserRoleButton());
                } else if (actionItem.equalsIgnoreCase("LDAP User")) {
                    enterText(getManageAccessField(actionItem), ItemName);
                    waitForAngularLoad(driver);
                    traverseListContainsElementAndClick(driver, getManageAccessSuggestionsList(), ItemName);
                } else if (actionItem.equalsIgnoreCase("Select Role")) {
                    clickOn(getRolesDropDown());
                    traverseListContainsElementAndClick(driver, getRolesFromList(), ItemName);
                } else {
                    enterText(getManageAccessField(actionItem), ItemName);
                }
                waitForAngularLoad(driver);
                break;
            case "Verify User Groups are not displayed in LDAP User dropdown":
                enterText(getManageAccessField(actionItem), ItemName);
                waitForAngularLoad(driver);
                Assert.assertTrue(getManageAccessSuggestionsList().isEmpty());
                break;
            case "Key Navigations":
                int fieldCount = -2;
                scrolltoElement(driver, getManageAccessField("Name"), true);
                waitUntilAngularReady(driver);
                clickOn(getManageAccessField("Name"));
                waitUntilAngularReady(driver);
                clickOn(getManageAccessField("Name"));
                waitForAngularLoad(driver);
                for (WebElement fieldName : getManageAccessFieldNameList()) {
                    String fieldDropdown = fieldName.getText();
                    fieldCount++;
                    if (fieldDropdown.contains(ItemName)) {
                        multiSelectValidations(actionItem, ItemName, Section, Attribute, fieldCount);
                        break;
                    } else {
                        if (fieldDropdown.contains("Email")) {
                            keyPressEvent(driver, Keys.TAB);
                            keyPressEvent(driver, Keys.TAB);
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }
                    }
                }
                waitUntilAngularReady(driver);
                break;
            case "Close Dropdown Popup":
                scrolltoElement(driver, getManageAcessPopupTitle(), true);
                clickOn(getManageAcessPopupTitle());
                break;
            case "Select Filter":
                clickOn(getManageAccessFilterButton(actionItem));
                waitForAngularLoad(driver);
                traverseListContainsElementAndClick(driver, getManageAccessFilterDropDownnList(), ItemName);
                break;
            case "Verify Users List":
            case "Verify Roles List":
                Assert.assertTrue(traverseListContainsElementText(getManageAccessUsersList(), actionItem));
                break;
            case "Select Roles in Users Popup":
                clickOn(getManageAccessPopupDropdown(actionItem));
                waitForAngularLoad(driver);
                traverseListContainsElementAndClick(driver, getManageAccessPopupOptionsList(), ItemName);
                break;
            case "Verify absence of Column":
                Assert.assertFalse(traverseListContainsElementText(getManageAccessColumnList(), actionItem));
                break;
            case "Verify Role is not displayed":
            case "Verify Local User is not displayed":
                Assert.assertFalse(traverseListContainsElementText(getManageAccessUsersList(), actionItem));
                break;
            case "Verify Role is displayed":
            case "Verify Local User is displayed":
                Assert.assertTrue(traverseListContainsElementText(getManageAccessUsersList(), actionItem));
                break;
            case "Select Role":
                clickOn(getRolesDropdown());
                waitForAngularLoad(driver);
//                scrolltoElement(driver, selectRole(ItemName), true);
                clickOn(selectRole(ItemName));
                waitForAngularLoad(driver);
                break;
        }
    }

    public void multiSelectValidations(String action, String itemName, String section, String attribute, int count) throws Exception {
        try {
            switch (action) {
                case "Click Dropdown":
                case "Verify Dropdown Presence":
                    keyPressEvent(driver, Keys.ENTER);
                    Assert.assertTrue(isElementPresent(getManageAccessDropdownbox().get(0)));
                    break;
                case "Verify First Option in the menu":
                    keyPressEvent(driver, Keys.ENTER);
                    Assert.assertTrue(isElementPresent(getManageAccessDropdownbox().get(0)));
                    Assert.assertTrue(getManageAccessMenuOptionsAsList().get(0).getText().equals(itemName));
                    break;
                case "Verify Tab is Highlighted":
                    sleepForSec(2000);
                    Assert.assertTrue(getManageAccessTextFieldList().get(count).getCssValue("border-bottom-color").equals("rgba(60, 203, 218, 1)"));
                    sleepForSec(2000);
                    break;
                case "Verify Menu options are not Highlighted":
                    for (int i = 0; i < getManageAccessMenuOptionsAsList().size(); i++) {
                        Assert.assertTrue(getManageAccessMenuOptionsAsList().get(i).getCssValue("background-color").equals("rgba(0, 0, 0, 0)"));
                    }
                    break;
                case "Close Dropdown":
                    keyPressEvent(driver, Keys.ENTER);
                    keyPressEvent(driver, Keys.TAB);
                    keyPressEvent(driver, Keys.ENTER);
                    Assert.assertFalse(waitandFindElement(driver, getManageAccessDropdownbox().get(0), 2, false));
                    break;
                case "Verify menu option is highlighted on tab navigation":
                    keyPressEvent(driver, Keys.ENTER);
                    keyPressEvent(driver, Keys.TAB);
                    keyPressEvent(driver, Keys.TAB);
                    Assert.assertTrue(getManageAccessMenuOptionsAsList().get(0).getCssValue("background-color").equals("rgba(229, 229, 229, 1)"));
                    break;
                case "Select a option from Dropdown":
                case "Verify the presence of selected option in the field":
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    keyPressEvent(driver, Keys.ENTER);
                    keyPressEvent(driver, Keys.TAB);
                    keyPressEvent(driver, Keys.TAB);
                    for (int i = 0; i < getManageAccessMenuOptionsAsList().size(); i++) {
                        if (getManageAccessMenuOptionsAsList().get(i).getText().equalsIgnoreCase(section)) {
                            keyPressEvent(driver, Keys.ENTER);
                            Assert.assertTrue(traverseListContainsElementText(getManageAccessMenuOptionsinField(), section));
                            Assert.assertTrue(isElementPresent(getManageAccessDropdownbox().get(0)));
                            LoggerUtil.logInfo(this.getClass().getSimpleName() + "option is present in the list");
                            break;
                        } else {
                            keyPressEvent(driver, Keys.ARROW_DOWN);
                        }
                    }
                    break;
                case "Verify the presence of All selected option in the field":
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    keyPressEvent(driver, Keys.ENTER);
                    keyPressEvent(driver, Keys.TAB);
                    keyPressEvent(driver, Keys.TAB);
                    for (int i = 0; i < getManageAccessMenuOptionsAsList().size(); i++) {
                        String[] menuItems = attribute.split(",");
                        if (getManageAccessMenuOptionsAsList().get(i).getText().equalsIgnoreCase(section)) {
                            keyPressEvent(driver, Keys.ENTER);
                            for (int j = 0; j < menuItems.length; j++) {
                                Assert.assertTrue(traverseListContainsElementText(getManageAccessMenuOptionsinField(), menuItems[j]));
                            }
                            LoggerUtil.logInfo(this.getClass().getSimpleName() + "option is present in the list");
                            break;
                        } else {
                            keyPressEvent(driver, Keys.ARROW_DOWN);
                        }
                    }
                    break;
                case "Verify deselected item is not displayed in the field":
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    keyPressEvent(driver, Keys.ENTER);
                    keyPressEvent(driver, Keys.TAB);
                    keyPressEvent(driver, Keys.TAB);
                    for (int i = 0; i < getManageAccessMenuOptionsAsList().size(); i++) {
                        if (getManageAccessMenuOptionsAsList().get(i).getText().equalsIgnoreCase(section)) {
                            keyPressEvent(driver, Keys.ENTER);
                            for (int j = 0; j < getManageAccessMenuOptionsAsList().size(); j++) {
                                if (getManageAccessMenuOptionsAsList().get(j).getText().equalsIgnoreCase(attribute)) {
                                    scrolltoElement(driver, getManageAccessMenuOptionsAsList().get(j), true);
                                    clickOn(getManageAccessMenuOptionsAsList().get(j));
                                    break;
                                }
                            }
                            Assert.assertFalse(traverseListContainsElementText(getManageAccessMenuOptionsinField(), attribute));
                            break;
                        } else {
                            keyPressEvent(driver, Keys.ARROW_DOWN);
                        }
                    }
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }
}

