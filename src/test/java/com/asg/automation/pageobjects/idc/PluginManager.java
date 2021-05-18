package com.asg.automation.pageobjects.idc;

import com.asg.automation.pageactions.idc.PluginManagerActions;
import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.Constant;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import com.google.common.collect.Ordering;
import org.openqa.selenium.*;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Sivanandam.Meiya on 1/22/2018.
 */
public class PluginManager extends UIWrapper {

    private WebDriver driver;

    @FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'PLUGIN MANAGER')]")
    private WebElement pluginManagement;

    @FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'PLUGIN MANAGER')]")
    private List<WebElement> pluginManagementLink;

    @FindBy(xpath = "//b[contains(.,'PLUGIN MANAGEMENT')]")
    private WebElement pluginManagementPanel;

    @FindBy(xpath = "//span[contains(.,'Manage your nodes and plugins here')]")
    private WebElement pluginManagerDefinition;

    @FindBy(xpath = "//p[contains(.,'Plugin manager: assign and configure plugins')]")
    private WebElement pluginManagerDesc;

    @FindBy(xpath = "//a[contains(.,'PLUGIN MANAGER')]//following::div[@class='asg-base-widget-quick'][1]/div[1]")
    private WebElement pluginManagerQuickLinkLabel;

    @FindBy(xpath = "//a[contains(.,'PLUGIN MANAGER')]//following::div[@class='asg-base-widget-recent'][1]/div[1]")
    private WebElement pluginManagerRecentLabel;

    @FindBy(xpath = "//a[contains(.,'PLUGIN MANAGER')]//following::div[@class='btn-group widget-menu dropdown'][1]")
    private WebElement pluginManagerresizeMenu;

    @FindBy(xpath = "//ul[@class='dropdown-menu-right dropdown-menu show']/li/a")
    private List<WebElement> pluginManagerresizeOptionList;

    @FindBy(xpath = "//a[contains(.,'PLUGIN MANAGER')]//following::div//ul//li[@class[contains(.,'asg-dashboard-selected-size')]]/a")
    private WebElement selectPluginManagerWidgetSize;

    @FindBy(css = "button[class='btn btn-default asg-plugin-management-top-btns']")
    private WebElement addNewNode;

    @FindBy(css = "input[name='pluginName']")
    private WebElement nodeName;

    @FindBy(css = "button[class='btn asg-btn-primary-sm selected-drop-item dropdown-toggle']")
    private WebElement catalogDropDown;

    @FindBy(xpath = "//ul[@class ='schema-dropdown-menu dropdown-menu show']//following::li[contains(@role,'menuitem')]//a/span")
    private List<WebElement> catalogList;

    @FindBy(xpath = "//li[@role='menuitem']/a/span")
    private List<WebElement> catalogListInPluginConfiguration;

    @FindBy(xpath = "//div[@id='asgNodeAvailablePlugins']//table/tbody/tr/td[1]//following::td[1]/span")
    private List<WebElement> pluginList;

    @FindBy(xpath = "//div[@id='asgNodeAvailablePlugins']//table/tbody/tr/td[1]//following::td[1]")
    private WebElement pluginCheckBox;

    @FindBy(css = "button[class='asg-node-assign float-right btn btn-default']")
    private WebElement assignButton;

    //@FindBy(css = "div[class='asg-assigned-nodes']>div>table>tbody>tr>td")
    @FindBy(css = "td.asg-node-table-plugin-name.asg-node-table-ellipsis")
    private List<WebElement> assignedPluginList;

    @FindBy(css = "div[class='asg-node-save']>button")
    private WebElement createNodeSave;

    @FindBy(css = "div[class='content-table asg-nodes-table']>table>tbody>tr>td[title]")
    private List<WebElement> nodeList;

    @FindBy(xpath = "//div[@class='table']//tbody/tr/td[1]")
    private List<WebElement> PluginsList;

    @FindBy(xpath = "//span[contains(text(),'Delete Node')]")
    private WebElement nodeDeleteButton;

    @FindBy(xpath = "//input[@id='scanHdfs_Plugin Configuration']//following::label[@for='asg-custom-checkbox'][1]")
    private WebElement scanHDFS;

    @FindBy(xpath = "//div[@class='asg-child-configuration-main-content']//span[@class='switch switch-small']/small")
    private WebElement autoStartPlugin;

    @FindBy(xpath = "//span[@class='switch switch-small'][1]/small")
    private WebElement newAutoStartPlugin;

    @FindBy(xpath = "//strong[contains(.,'ENABLE HIVE QUERY PARSER')]//following::span[@class='switch switch-small']/small")
    private WebElement enableQueryParser;

    @FindBy(xpath = "//div[@title='PLUGIN CONFIGURATION']//following::div[@class='alert alert-danger']")
    private WebElement nameFieldAlertMessage;

    @FindBy(xpath = "//strong[contains(.,'LINEAGE DIRECTION')]/following::button[1]")
    private WebElement lineageDirectiondropdown;

    @FindBy(xpath = "//strong[contains(.,'LINEAGE DIRECTION')]/following::button[1]//following::ul[@class='dropdown-menu show']//li")
    private List<WebElement> lineageDirectionList;

    @FindBy(xpath = "//div[@title='CHECKS']//following::strong[contains(.,'CLASS')]//following::div[1]")
    private WebElement checksClassDropDown;

    @FindBy(xpath = "//div[@title='CHECKS']//following::strong[contains(.,'CLASS')]//following::ul[1]//li")
    private List<WebElement> checksClassDropDownList;

    @FindBy(css = "table[class='table table-hover'] > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(3) > i")
    private WebElement eyeOpenIcon;

    @FindBy(css = "div[class='asg-plugin-controller-caption'] > b")
    public WebElement pluginConfigurationStatuslable;

    @FindBy(xpath = "//table[@class='table table-hover asg-plugin-controller-table']/tbody/tr/td/span/span[1]")
    public WebElement pluginsArrow;

    @FindBy(xpath = "//table[@class='table table-hover asg-plugin-controller-table']/tbody/tr/td[2] | //table[@class='table table-hover asg-plugin-controller-table']/tbody/tr/td[3]")
    public WebElement pluginControllerStatusAndActions;

    @FindBy(css = "button.btn-default:nth-child(2) > span:nth-child(2)")
    public WebElement pluginControllerButton;

    @FindBy(css = "button[class='btn btn-default asg-plugin-management-top-btns']")
    public WebElement addNewNodeButton;

    @FindBy(xpath = "//td[@class[contains(.,'asg-nodes-table-name-data')]]")
    public List<WebElement> getNodeList;

    @FindBy(id = "pluginName")
    public WebElement pluginNameField;

    @FindBy(css = "div[class='alert alert-danger asg-node-error-message']>div:nth-of-type(2)")
    public WebElement spaceErrorMessage;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger asg-node-error-message')]]/div[3]")
    public WebElement duplicateNodeNameErrorMessage;

    @FindBy(xpath = "//div[@class='asg-node-save']/button[contains(.,'SAVE')]")
    public WebElement newNodePanelSaveButton;

    @FindBy(css = "div.asg-panels-item:nth-child(2) > div:nth-child(1) > div:nth-child(1) > button:nth-child(2)")
    public WebElement newNodePanelCloseButton;

/*    @FindBy(xpath = "//div[@class='modal-body']/div/span")
    public WebElement unsavedChangesPopUpContent;*/

    @FindBy(css = "div[class='asg-node-content']")
    public WebElement newNodePanel;

    @FindBy(xpath = "//li[@class[contains(.,'nav-item active')]]")
    public WebElement nodeslabelAndCount;

    @FindBy(xpath = "//li[@class='nav-item']/a/span[contains(.,'DATA SET PLUGINS')]")
    public WebElement Datasetplugin;

    @FindBy(xpath = "//li[@class[contains(.,'nav-item')]]/a[contains(.,' Analysis Plugins')]")
    public WebElement AnalysisPlugin;

    @FindBy(xpath = "//li[@class='nav-item']/a/span[contains(.,'ANALYSIS NODES')]")
    public WebElement AnalysisNodes;

    @FindBy(xpath = "//button[@class='asg-node-assign float-right btn btn-default']/span[contains(.,'Assign')]")
    public WebElement assignButtonInNewNodePanel;

    @FindBy(css = "div[class='asg-dyn-form-table-add-cataloger-bth']")
    public WebElement addButton;

    @FindBy(css = "div[class='asg-dyn-form-table-add-cataloger-bth']")
    public WebElement addButtonInPluginConfiguration;

    @FindBy(css = "div.asg-child-configuration-property:nth-child(13) > ng-component:nth-child(1) > div:nth-child(1) > property-label:nth-child(1) > div:nth-child(1) > span:nth-child(2)")
    public WebElement queryFieldHoverText;

    @FindBy(css = "button[id='pluginCatalogSelection']")
    public WebElement catalogSelectionText;

    @FindBy(xpath = "//div[@class='asg-custom-checkbox']//following::td[1]")
    public List<WebElement> availablePluginList;

    // ".asg-node-table-check-box > asg-checkbox:nth-child(1) > div:nth-child(1) > label:nth-child(2)"
    @FindBy(xpath = "//div[@class='asg-custom-checkbox']/label[@class='header-checkbox'][1]")
    public WebElement pluginCheckbox;

    @FindBy(css = "label[class='header-checkbox']")
    public List<WebElement> availablePluginsCheckbox;

    @FindBy(css = "div[class='asgNodeAvailablePlugins']")
    public WebElement emptyPluginList;

    @FindBy(xpath = "//div[@class='asg-assigned-nodes']//following::td[@class='asg-node-table-plugin-name asg-node-table-ellipsis']")
    public WebElement assignedPluginsList;

    @FindBy(xpath = "//div[@class='modal fade in show']//following::span")
    public WebElement PopUpContent;

    @FindBy(css = ".table > tbody:nth-child(2) > tr:nth-child(3) > td:nth-child(3) > i:nth-child(1)")
    public WebElement testNodePluginControllericon;

    @FindBy(css = "td[class='asg-node-table-remove-icon']>i")
    public WebElement assingedPluginCloseButton;

    @FindBy(css = "button[class='btn btn-default asg-child-configuration-top-btns']")
    public WebElement unassignButton;

    @FindBy(xpath = "//div[@class='data-content']//following::th[contains(.,'CONFIGURATION NAME')]")
    public WebElement configurationPanel;

    @FindBy(xpath = "//span[contains(.,'errors')]//following::span[1]")
    public WebElement errorCount;

    //@FindBy(xpath = "//p[contains(.,'DATA')]//following::span[contains(.,'log')]")
    @FindBy(xpath = "//p[contains(.,'DATA')]//following::th[contains(.,'NAME')]//following::span[contains(.,'log')]")
    public WebElement logLink;

    @FindBy(xpath = "//div[@class='asg-modal-buttons-block']//button[@class='btn asg-modal-confirm-btn float-right']")
    private WebElement deleteNodeYes;

    //@FindBy(css = "div[class='left-navigation-item']>span[class='fa fa-home']")
    //@FindBy(css = "div.left-navigation-item>span.fa.fa-home")
    @FindBy(css = "span.fa.fa-home")
    public WebElement homeButton;

    @FindBy(xpath = "//b[contains(.,'DATABASES')]//following::i[1]")
    private WebElement removeDatabaseInFiltersPage;

    @FindBy(xpath = "//b[contains(.,'FILTERS')]//following::td")
    private WebElement catalogUnderFilters;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//following::span[contains(.,'Delete')]")
    private WebElement deleteButtonUnderFilters;

    @FindBy(xpath = "//i[@class='fa fa-times text-left'][1]")
    private WebElement databaseRemoveButton;

    @FindBy(xpath = "//strong[contains(.,'SIMPLE OR REGULAR EXPRESSION')]//following::em[1]")
    private WebElement expressionDropDown;

    @FindBy(xpath = "//strong[contains(.,'SIMPLE OR REGULAR EXPRESSION')]//following::li[@class='dropdown-item']")
    public List<WebElement> expressionTypeList;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu show')]]//li/a")
    public List<WebElement> configurationDropDownValue;

    @FindBy(xpath = "//div[@class[contains(.,'tag-container')]]/div/div")
    public List<WebElement> tagsInAdvancedSettingsPanel;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu')]]//following::a[@class='dropdown-item']")
    public List<WebElement> configurationDropDownValueForStatus;

    @FindBy(xpath = "//div[@class[contains(.,'asg-plugin-monitor-icon-holder')]]//following::div[1]")
    public List<WebElement> displayedPluginNameList;

    @FindBy(xpath = "//div[@class='asg-plugin-monitor-icon-holder']//following::div[@class='asg-plugin-monitor-status-box asg-gray']")
    public List<WebElement> displayedPluginStatusList;

    @FindBy(css = "div.asg-plugin-monitor-node-name")
    public WebElement configPanelNodeName;

    @FindBy(css = "div[class='clearfix']")
    public List<WebElement> displayedPluginCountInMonitorPanel;

    @FindBy(css = "div>pre[class=' CodeMirror-line ']")
    public WebElement getDynamicField;

    @FindBy(css = "div[class='CodeMirror-hscrollbar']")
    public WebElement getDynamicFieldScrollBar;

    @FindBy(xpath = "//div[@class='tab-pane active']//td[@class='asg-dataset-plugin-name-data']")
    public List<WebElement> analysisPlugin;

    @FindBy(xpath = "//div[@class[contains(.,'advanced-properties-header cursor-pointer')]]")
    public WebElement showAdvancedSettings;

    @FindBy(xpath = "//strong[contains(.,'CATALOG NAME')]//following::em[@class='fa fa-chevron-down'][1]")
    public WebElement catalogdropdownIcon;

    @FindBy(xpath = "//div[@class='asg-plugin-management-container']//ul[@role='tablist']/li[contains(.,'Analysis Plugins')]")
    public WebElement getPluginTab;

    @FindBy(xpath = "//div[@class='asg-plugin-management-container']//ul[@role='tablist']/li[contains(.,'ANALYSIS NODES')]")
    public WebElement getAnalysisNodePluginTab;

 /*
    10.3 Page factory
     */

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-filter')]]")
    public WebElement getFilterIcon;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-search cursor-pointer')]]")
    public WebElement getSearchIcon;

    @FindBy(css = "span>i[class='fa fa-close']")
    public WebElement filterOrSearchCloseButon;

    @FindBy(xpath = "//span/img[@src[contains(.,'running')]] | //span/img[@src[contains(.,'unknown')]] | //span/img[@src[contains(.,'idle')]] | //span/img[@src[contains(.,'stopped')]]")
    public WebElement statusIndicators;

    @FindBy(xpath = "//input[@id='asgManageSearch']")
    private WebElement searchText;

    @FindBy(xpath = "//div//div[@class[contains(.,'config-filter-display')]]//following::div[@class='table']/table/tbody/tr/td")
    private List<WebElement> configInTableView;

    @FindBy(xpath = "//img[@src[contains(.,'running')]]")
    public WebElement runningStatusIndicatorWithStatusCount;

    @FindBy(xpath = "//div[@class[contains(.,'asg-console-output')]]")
    public WebElement logViewer;

    //@FindBy(xpath = "//span[@class='status-count-align']//preceding-sibling::span/img[@src[contains(.,'warning')]]")
    @FindBy(xpath = "//img[@src[contains(.,'warning')]]")
    public WebElement unknownStatusIndicatorWithStatusCount;

    @FindBy(xpath = "//img[@src[contains(.,'idle')]]")
    public WebElement idleStatusIndicatorWithStatusCount;

    @FindBy(xpath = "//img[@src[contains(.,'stopped')]]")
    public WebElement stoppedStatusIndicatorWithStatusCount;

    @FindBy(xpath = "//div[@class='toast-msg']")
    public List<WebElement> pluginCompletionPopUp;

    @FindBy(css = "em[class='far fa-times cursor-pointer']")
    public WebElement popupCloseButton;

    @FindBy(xpath = "//div[@class='asg-dynamic-form-property-label-container']//label[contains(.,'Credential')]//following::input[@id='name']")
    private WebElement credentialNameTextbox;

    @FindBy(xpath = "//div[@class='asg-dynamic-form-property-label-container']/label[contains(.,'Data Source')]//following::input[@id='name']")
    private WebElement dataSourceNameTextbox;

    @FindBy(css = "button[class='test-btn mb-1']")
    private WebElement testConnectionButton;

    @FindBy(xpath = "//div[@class='modal-content']//button[@type='button']/span")
    private WebElement popUpXButton;

    @FindBy(xpath = "//div[@class='modal-content']//following::button[contains(.,'Close')]")
    private WebElement popUpCloseButton;

    @FindBy(css = "button[class='save-btn mb-1']")
    private WebElement testConnectionButtonDisabled;

    @FindBy(css = "button[class='spinner-btn']")
    private WebElement saveButtonDisabled;

    @FindBy(xpath = "//div[@class[contains(.,'test-error')]][contains(.,'No connection with data source')]")
    private WebElement failedConnectionMessage;

    @FindBy(xpath = "//div[@class[contains(.,'test-success')]][contains(.,'Successful connection with data source.')]")
    private WebElement successConnectionMessage;

    @FindBy(xpath = "//button[contains(.,'FINISH')]")
    private WebElement finishButton;

    @FindBy(xpath = "//*[@class[contains(.,'tooltip show asg-table-error-tooltip')]]")
    private WebElement errorTooltip;

    @FindBy(xpath = "//div[@class[contains(.,'error-row')]]/div[2]")
    private List<WebElement> errorTooltipList;

    @FindBy(xpath = "//div[@class[contains(.,'error-row')]]/div[1]/strong")
    private List<WebElement> errorTooltipTimeStampList;

    @FindBy(css = "input[id='undefined']")
    private WebElement logTypeCheckBox;

    @FindBy(xpath = "//button[contains(.,'SAVE')]")
    public WebElement saveButton;

    @FindBy(xpath = "//button[contains(.,'Add')]")
    private WebElement JDBCAddButton;

    @FindBy(xpath = "//div[@class[contains(.,'time-list-item d-flex align-items-center cursor-pointer')]]")
    private List<WebElement> timestampInLogPage;

    @FindBy(css = "button[class='btn btn-outline-secondary calendar']")
    private WebElement calenderIcon;

    @FindBy(xpath = "//div[@class[contains(.,'asg-day select-none has-log')]]")
    private WebElement dayhasLog;

    @FindBy(xpath = "//div[@class[contains(.,'ngb-dp-day disabled')]][1]//div[@class[contains(.,'text-muted')]][1]")
    private WebElement dayHasNoLog;

    @FindBy(xpath = "//div[@class='header'][contains(.,'Errors (0)')]//following::div[contains(.,'No error(s) found.')][1]")
    private WebElement emptiedErrorMessagePanel;

    @FindBy(xpath = "//th[contains(.,'BRANCH')]//preceding::div[@class='asg-dyn-form-table-add-cataloger-btn']")
    private WebElement branchAddButton;

    @FindBy(css = "//label[contains(text(),'Dry Run')]//following::div/ui-switch[@class='ng-valid ng-touched ng-dirty']//span[@class='switch switch-small']")
    private WebElement dryRunButtonDisabled;

    @FindBy(css = "div[class='CodeMirror-vscrollbar']")
    private WebElement verticalLogBar;

    @FindBy(css = "div[class='CodeMirror-hscrollbar']")
    private WebElement horizontalLogBar;

    @FindBy(css = "input[id='branch']")
    private WebElement branchTextbox;

    @FindBy(xpath = "//li[@class[contains(.,'d-inline')]]//a[contains(.,'Manage Configurations')]")
    private WebElement manageConfigurationsLink;

    @FindBy(xpath = "//input[@placeholder='Enter tags']")
    private WebElement addConfigurationsTags;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-plus-square')]]")
    private WebElement addPipelineButton;

    @FindBy(css = "input[placeholder='Enter pipeline name']")
    private WebElement pipelineNametextbox;

    @FindBy(css = "textarea[placeholder='Enter description']")
    private WebElement pipelineDesctextbox;

    @FindBy(xpath = "//div[@class='node-content position-relative']//div/div[@class='text-truncate']")
    private List<WebElement> diagramOrder;

    @FindBy(xpath = "//a[contains(.,'Show the data elements in a list')]")
    private WebElement showtheDataElementsLink;

    public PluginManager(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized SubjectArea page");
    }


    public WebElement locatePluginManager() {
        return driver.findElement(By.xpath("//a[@class='asg-base-widget-title'][contains(.,'PLUGIN MANAGER')]"));
    }

    public void clickPluginManager() {
        scrollToWebElement(driver, pluginManagement);
        clickonWebElementwithJavaScript(driver, pluginManagement);
    }

    public List<WebElement> getPluginManagementLink() {
        return pluginManagementLink;
    }

    WebElement getPluginManagerLink() {
        return pluginManagement;
    }

    public String getPluginManagerDefinition() {

        synchronizationVisibilityofElement(driver, pluginManagerDefinition);
        return pluginManagerDefinition.getText().trim();
    }

    public WebElement getPluginManagerQuickLinkLabel() {

        synchronizationVisibilityofElement(driver, pluginManagerQuickLinkLabel);
        return pluginManagerQuickLinkLabel;
    }

    public WebElement getPluginManagerRecentLabel() {

        scrollToWebElement(driver, pluginManagerRecentLabel);
        return pluginManagerRecentLabel;
    }


    public String getPluginManagerDesc() {

        synchronizationVisibilityofElement(driver, pluginManagerDesc);
        return pluginManagerDesc.getText().trim();
    }

    public WebElement pluginManagerResizeMenu() {

        scrollToWebElement(driver, pluginManagerresizeMenu);
        return pluginManagerresizeMenu;
    }

    public List<WebElement> pluginManagerResizeMenuList() {

        synchronizationVisibilityofElementsList(driver, pluginManagerresizeOptionList);
        return pluginManagerresizeOptionList;
    }

    public String pluginManagerWidgetSize() {

        scrollToWebElement(driver, selectPluginManagerWidgetSize);
        return selectPluginManagerWidgetSize.getText().trim();
    }

    public WebElement addNewNode() {

        synchronizationVisibilityofElement(driver, addNewNode);
        return addNewNode;
    }

    public WebElement nodeName() {

        synchronizationVisibilityofElement(driver, nodeName);
        return nodeName;
    }

    public WebElement catalogDropDown() {

        synchronizationVisibilityofElement(driver, catalogDropDown);
        return catalogDropDown;
    }

    public List<WebElement> catalogList() {
        synchronizationVisibilityofElementsList(driver, catalogList);
        return catalogList;
    }

    public List<WebElement> catalogListInPluginConfigurationPage() {
        synchronizationVisibilityofElementsList(driver, catalogListInPluginConfiguration);
        return catalogListInPluginConfiguration;
    }

    public List<WebElement> pluginList() {
        synchronizationVisibilityofElementsList(driver, pluginList);
        return pluginList;
    }

    public WebElement pluginCheckBox(String pluginName) {
        return driver.findElement(By.xpath("//div[@id='asgNodeAvailablePlugins']//table/tbody/tr/td[1]//following::td[1]/span[contains(.,'" + pluginName + "')]/preceding::label[@for='asg-custom-checkbox'][1]"));
    }

    public WebElement assignButton() {

        synchronizationVisibilityofElement(driver, assignButton);
        return assignButton;
    }

    public List<WebElement> assignedPluginList() {
        synchronizationVisibilityofElementsList(driver, assignedPluginList);
        return assignedPluginList;
    }

    public WebElement childPageAddButton(String pageName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item-caption-ellipsis']//b[contains(.,'" + pageName + "')]//following::div[@class='asg-dyn-form-table-add-cataloger-bth']"));
    }


    public WebElement pluginConfigurationInput(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(@class,'asg-dyn-form-property-label tooltip-indicator')][text()=' "+fieldName+"']/../../..//input"));
    }


    public WebElement filterPageAttributes(String fieldName) {
        return driver.findElement(By.xpath("//div[@title='FILTERS']//following::label/strong[contains(.,'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement childPageApplyButton(String childPage) {
        //return driver.findElement(By.xpath("//div[@title='" + childPage + "']//following::div[@class='asg-child-configuration-save'][1]"));
        return driver.findElement(By.xpath("//div[@title='" + childPage + "'][@class='asg-panels-item-caption-ellipsis']//following::button[@type='submit']"));
    }

    public WebElement getApplyButton() {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::button[contains(.,'APPLY')]"));
    }

    public WebElement checkPageAttributes(String fieldName) {
        return driver.findElement(By.xpath("//div[@title='CHECKS']//following::strong[contains(.,'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement createNodeSave() {

        synchronizationVisibilityofElement(driver, createNodeSave);
        return createNodeSave;
    }

    public List<WebElement> getNodeList() {
        synchronizationVisibilityofElementsList(driver, nodeList);
        return nodeList;
    }

    public List<WebElement> getPluginsList() {
        synchronizationVisibilityofElementsList(driver, PluginsList);
        return PluginsList;
    }

    public WebElement deleteNode() {

        synchronizationVisibilityofElement(driver, nodeDeleteButton);
        return nodeDeleteButton;
    }

    public WebElement getScanHDFS() {

        synchronizationVisibilityofElement(driver, scanHDFS);
        return scanHDFS;
    }

    public WebElement filterPageTextFields(String filterFields) {
        return driver.findElement(By.xpath("//div[@title='FILTERS']//following::strong[contains(.,'" + filterFields + "')]//following::input[1]"));
    }

    public WebElement filterPageTextAdd(String filterFields) {
        return driver.findElement(By.xpath("//div[@title='FILTERS']//following::strong[contains(.,'" + filterFields + "')]//following::input[1]//following::span[1]"));
    }

    public WebElement pluginManagementPageTextAdd(String filterFields) {
        return driver.findElement(By.xpath("//div[@title='PLUGIN CONFIGURATION']//following::strong[contains(.,'" + filterFields + "')]//following::input[1]//following::span[1]"));
    }

    public WebElement getAutoStartPlugin() {

        scrollToWebElement(driver, autoStartPlugin);
        return autoStartPlugin;
    }

    public WebElement getPluginConfigurationCheckbox(String checkBox) {

        return driver.findElement(By.xpath("//b[contains(.,'" + checkBox + "')]//following::span[@class='switch switch-small'][1]/small"));
    }

    public void clickPluginConfigurationCheckbox(String checkBox) {

        clickOn(driver.findElement(By.xpath("//b[contains(.,'" + checkBox + "')]//following::span[@class='switch switch-small'][1]/small")));
    }


    public WebElement getEnableQueryParser() {

        synchronizationVisibilityofElement(driver, enableQueryParser);
        return enableQueryParser;
    }

    public WebElement getNameFieldAlertMessage() {

        synchronizationVisibilityofElement(driver, nameFieldAlertMessage);
        return nameFieldAlertMessage;
    }

    public WebElement getConfigName(String pluginName) {

        return driver.findElement(By.xpath("//tr/th[contains(text(),'" + pluginName + "')]//following::td[contains(text(),'HdfsMonitor')]"));
    }

    public WebElement getLineageDirectionDropDown() {

        synchronizationVisibilityofElement(driver, lineageDirectiondropdown);
        return lineageDirectiondropdown;
    }

    public List<WebElement> getLineageDirectionList() {
        synchronizationVisibilityofElementsList(driver, lineageDirectionList);
        return lineageDirectionList;
    }

    public WebElement getChecksClassDropDown() {

        synchronizationVisibilityofElement(driver, checksClassDropDown);
        return checksClassDropDown;
    }

    public List<WebElement> getChecksClassDropDownList() {
        synchronizationVisibilityofElementsList(driver, checksClassDropDownList);
        return checksClassDropDownList;
    }

    public WebElement getEyeOpenIcon() {
        synchronizationVisibilityofElement(driver, eyeOpenIcon);
        return eyeOpenIcon;
    }

    public WebElement getPluginConfigurationStatuslable() {
        synchronizationVisibilityofElement(driver, pluginConfigurationStatuslable);
        return pluginConfigurationStatuslable;
    }

    public WebElement getPluginsArrow() {
        synchronizationVisibilityofElement(driver, pluginsArrow);
        return pluginsArrow;
    }

    public WebElement getPluginConfigStatusAndActions() {
        synchronizationVisibilityofElement(driver, pluginControllerStatusAndActions);
        return pluginControllerStatusAndActions;
    }

    public WebElement getNode(String node) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item-caption clearfix']//following::td[contains(.,'" + node + "')]"));
    }

    public WebElement getPanelHeaderName(String headerNodeName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item-caption-ellipsis']/b[contains(.,'" + headerNodeName + "')]"));
    }

    public WebElement getPluginControllerButton() {
        synchronizationVisibilityofElement(driver, pluginControllerButton);
        return pluginControllerButton;
    }

    public WebElement getAddNewNodeButton() {
        synchronizationVisibilityofElement(driver, addNewNodeButton);
        return addNewNodeButton;
    }

    public List<WebElement> getListOfNodes() {
        synchronizationVisibilityofElementsList(driver, getNodeList);
        return getNodeList;
    }

    public WebElement getNameField() {
        synchronizationVisibilityofElement(driver, pluginNameField);
        return pluginNameField;
    }

    public WebElement getSpaceErrorMessage() {
        synchronizationVisibilityofElement(driver, spaceErrorMessage);
        return spaceErrorMessage;
    }

    public WebElement getDuplicateNodeNameErrorMessage() {
        synchronizationVisibilityofElement(driver, duplicateNodeNameErrorMessage);
        return duplicateNodeNameErrorMessage;
    }

    public WebElement getNewNodePanelSaveButton() {
        synchronizationVisibilityofElement(driver, newNodePanelSaveButton);
        return newNodePanelSaveButton;
    }

    public WebElement getNewNodePanelCloseButton() {
        synchronizationVisibilityofElement(driver, newNodePanelCloseButton);
        return newNodePanelCloseButton;
    }

    public WebElement getNewNodePanel() {
        return newNodePanel;
    }

    public WebElement getNodeLabelAndCount() {
        synchronizationVisibilityofElement(driver, nodeslabelAndCount);
        return nodeslabelAndCount;
    }

    public WebElement getDatasetPlugins() {
        synchronizationVisibilityofElement(driver, Datasetplugin);
        return Datasetplugin;
    }

    public WebElement getAnalysisPlugins() {
        synchronizationVisibilityofElement(driver, AnalysisPlugin);
        return AnalysisPlugin;
    }

    public WebElement getAnalysisNodes() {
        synchronizationVisibilityofElement(driver, AnalysisNodes);
        return AnalysisNodes;
    }

    public WebElement getPluginCountOfNode(String nodeName) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']/tbody/tr/td[contains(.,'" + nodeName + "')]//following::td[@class='asg-nodes-table-plugins-data']"));
    }

    public WebElement getPluginsList(String pluginName) {
        return driver.findElement(By.xpath("//div[@id='asgNodeAvailablePlugins']/div/table/tbody/tr/td[contains(.,'" + pluginName + "')]//preceding::label[@for][1]"));
    }

    public WebElement clickAssignButton() {
        synchronizationVisibilityofElement(driver, assignButtonInNewNodePanel);
        return assignButtonInNewNodePanel;
    }

    public WebElement clickPluginUnderAssignButton(String pluginName) {
        return driver.findElement(By.xpath("//td[@class='asg-node-table-plugin-name asg-node-table-ellipsis']//span[contains(.,'" + pluginName + "')]"));
    }

    public WebElement clickAddButton() {
        synchronizationVisibilityofElement(driver, addButton);
        return addButton;
    }

    public WebElement getInfoIconForPluginField(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']/div/div/div//following::strong[contains(.,'" + fieldName + "')]//following::span[1]"));
    }

    public WebElement getMouseHoverTextForPluginField(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+fieldName+"')]//following::div[@class='tooltip-inner']//div[@class='content']"));
    }

    public WebElement getQueryFieldHoverText() {
        synchronizationVisibilityofElement(driver, queryFieldHoverText);
        return queryFieldHoverText;
    }

    public WebElement LocateQueryFieldHoverText() {
        return driver.findElement(By.cssSelector("div.asg-child-configuration-main-content > div:nth-child(13) > ng-component > div > app-asg-property-label > div > span"));
    }

    public WebElement clickAddButtonInPluginConfiguration(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-dynamic-form-property-label-container']//label[(text()=' "+fieldName+"')]/../../..//div[contains(@class,'asg-dyn-form-table-add-cataloger-btn')]"));
        //div[@class='asg-dynamic-form-property-label-container']//label[text()=' "+fieldName+"']/../../..//div[@class='asg-dyn-form-table-add-cataloger-btn']
    }

    public WebElement clickAddButtonInsideFieldPanel(String fieldName) {
        return driver.findElement(By.xpath("//b[contains(.,'" + fieldName + "')]//following::button[@class='exit-btn']/i[1]"));
    }

    public void clickonconfigurationexit() {
        clickOn(driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//button[@class='exit-btn']")));
    }


    public WebElement getFieldValidationMesssage(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::strong[contains(.,'" + fieldName + "')]//following::div[@class='alert alert-danger']"));
    }

    public WebElement getFieldValidationMesssageByPage(String fieldName, String pageName) {
        return driver.findElement(By.xpath("//b[contains(.,'" + pageName + "')]//following::strong[contains(.,'" + fieldName + "')]//following::div[@class='alert alert-danger']"));
    }

    public WebElement getFieldTextBoxByPage(String fieldName, String pageName) {
        return driver.findElement(By.xpath("//b[contains(.,'" + pageName + "')]//following::strong[contains(text(),'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement getFieldTextBox(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::b[contains(text(),'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement getNewNodePanelLabelName(String labelName) {
        return driver.findElement(By.xpath("//b[contains(.,'" + labelName + "')]"));
    }

    public WebElement getCatalogSelectionBoxText() {
        synchronizationVisibilityofElement(driver, catalogSelectionText);
        return catalogSelectionText;
    }

    public List<WebElement> getPluginList() {
        synchronizationVisibilityofElementsList(driver, availablePluginList);
        return availablePluginList;
    }

    public WebElement clickPluginCheckbox() {
        synchronizationVisibilityofElement(driver, pluginCheckbox);
        return pluginCheckbox;
    }

    public List<WebElement> getAvailablePluginsCheckBox() {
        synchronizationVisibilityofElementsList(driver, availablePluginsCheckbox);
        return availablePluginsCheckbox;
    }

    public WebElement getEmptyPluginList() {
        return emptyPluginList;
    }

    public WebElement getAssignedPluginList() {
        synchronizationVisibilityofElement(driver, assignedPluginsList);
        return assignedPluginsList;
    }

    public WebElement getPopUpContent() {
        synchronizationVisibilityofElement(driver, PopUpContent);
        return PopUpContent;
    }

    public WebElement getPluginControllerIcon() {
        return testNodePluginControllericon;
    }

    public WebElement clickAssingedPluginCloseButton() {
        synchronizationVisibilityofElement(driver, assingedPluginCloseButton);
        return assingedPluginCloseButton;
    }

    public WebElement clickUnassignPluginButtton() {
        synchronizationVisibilityofElement(driver, unassignButton);
        return unassignButton;
    }

    public WebElement getConfigurationPanel() {
        return configurationPanel;
    }

    public WebElement clickPluginMonitorIcon(String nodeName) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']/tbody/tr/td[contains(.,'" + nodeName + "')]//following::i[1]"));
    }

    public WebElement getpluginManagerHamburgerMenu(String nodeName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + nodeName + "')]//following::button[@class='btn btn-primary'][1]/span[@class='fa fa-ellipsis-v'][1]"));
    }

    public WebElement clickStartButton(String plugin, String pluginMonitorStatus) {
        return driver.findElement(By.xpath("//div[@class='asg-plugin-monitor-icon-holder']//following::div[contains(text(),'" + plugin + "')]//following::div/button[contains(.,'" + pluginMonitorStatus + "')]"));
    }

    public WebElement getPluginMonitorStatus(String pluginName, String status) {
        return driver.findElement(By.xpath("//div[@class='asg-plugin-monitor-icon-holder']//following::div[contains(text(),'" + pluginName + "')]//following::div/div[2][contains(text(),'" + status + "')][1]"));
    }

    public WebElement clickOnAnanlysisFirstLink(String widgetName) {
        return driver.findElement(By.xpath("//a[contains(.,'" + widgetName + "')]//following::a[1]"));
    }

    public WebElement getMetadataErrorsCount() {
        scrollToWebElement(driver, errorCount);
        return errorCount;
    }

    public WebElement clickLogLink() {
        scrollToWebElement(driver, logLink);
        return logLink;
    }

    public WebElement clickConfigurationName(String plugin) {
        return driver.findElement(By.xpath("//table[@class='table table-hover asg-dyn-form-widget-table']//td[contains(.,'" + plugin + "')]"));
    }

    public WebElement getDeleteNodeYes() {
        synchronizationVisibilityofElement(driver, deleteNodeYes);
        return deleteNodeYes;
    }

    public WebElement getAnalysisRunResult(String widget, String plugin) {
        return driver.findElement(By.xpath("//a[contains(.,'" + widget + "')]//following::a[contains(.,'Analysis: " + plugin + "')]"));
    }

    public WebElement getFilters(String filterName) {
        return driver.findElement(By.xpath("//b[contains(.,'FILTERS')]//following::td[contains(.,'" + filterName + "')]"));
    }

    public WebElement getHomeButton() {
        synchronizationVisibilityofElement(driver, homeButton);
        return homeButton;
    }

    public WebElement getdataBaseInFiltersPage() {
        synchronizationVisibilityofElement(driver, removeDatabaseInFiltersPage);
        return removeDatabaseInFiltersPage;
    }

    public WebElement getcatalogUnderFilters() {
        scrollToWebElement(driver, catalogUnderFilters);
        return catalogUnderFilters;
    }

    public WebElement getDeleteButtonInFiltersPage() {
        scrollToWebElement(driver, deleteButtonUnderFilters);
        return deleteButtonUnderFilters;
    }

    public WebElement getDatabaseRemoveButton() {
        synchronizationVisibilityofElement(driver, databaseRemoveButton);
        return databaseRemoveButton;
    }

    public WebElement getFileFiltersInput(String filterName) {
        return driver.findElement(By.xpath("//b[contains(.,'FILEFILTERS')]//following::strong[contains(.,'" + filterName + "')]//following::input[1]"));
    }

    public WebElement getexpressionType() {
        synchronizationVisibilityofElement(driver, expressionDropDown);
        return expressionDropDown;
    }

    public List<WebElement> getExpressionTypeList() {
        synchronizationVisibilityofElementsList(driver, expressionTypeList);
        return expressionTypeList;
    }

    public WebElement getPluginManagementPanel() {
        synchronizationVisibilityofElement(driver, pluginManagementPanel);
        return pluginManagementPanel;
    }

    public WebElement getLabelsInConfigurationPanel(String labelName) {
        return driver.findElement(By.xpath("//div[@class='actions-bar']//following::span[contains(.,'" + labelName + "')]"));
    }

    public WebElement getConfigurationPanelDropDown(String labelName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-active-item')]]//span[contains(.,'" + labelName + "')]//following::i[@class='fa fa-chevron-down'][1]"));
    }


    public List<WebElement> getConfigurationDropDownValue() {
        synchronizationVisibilityofElementsList(driver, configurationDropDownValue);
        return configurationDropDownValue;
    }

    public List<WebElement> getConfigurationDropDownValueForStatus() {
        synchronizationVisibilityofElementsList(driver, configurationDropDownValueForStatus);
        return configurationDropDownValueForStatus;
    }

    public List<WebElement> getDisplayedPluginList() {
        synchronizationVisibilityofElementsList(driver, displayedPluginNameList);
        return displayedPluginNameList;
    }

    public List<WebElement> getDisplayedPluginStatusList() {
        synchronizationVisibilityofElementsList(driver, displayedPluginStatusList);
        return displayedPluginStatusList;
    }

    public WebElement getConfigPanelNodeName() {
        synchronizationVisibilityofElement(driver, configPanelNodeName);
        return configPanelNodeName;
    }

    public WebElement getPluginNameAndPluginType(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='clearfix']//following::div[contains(text(),'" + fieldName + "')]//following::div[@class='asg-plugin-monitor-text-container'][1]"));
    }

    public WebElement getNodeStatus(String nodeName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + nodeName + "')]//following::td[@class='asg-nodes-table-node-status']/div"));
    }

    public WebElement getStatusCount(String status) {
        return driver.findElement(By.xpath("//span[contains(.,'" + status + "')]//following::b[1]"));
    }

    public WebElement getPluginCount(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + pluginName + "')]//following::td[1]"));
    }

    public List<WebElement> getDisplayedPluginCount() {
        synchronizationVisibilityofElementsList(driver, displayedPluginCountInMonitorPanel);
        return displayedPluginCountInMonitorPanel;
    }

    public WebElement removePluginFromNode(String nodeName) {
        return driver.findElement(By.xpath("//div[@class='asg-assigned-nodes']//tr/td[@title='" + nodeName + "']//following::td[@class='asg-node-table-remove-icon'][1]"));
    }

    public WebElement nodeCondition() {
        return driver.findElement(By.xpath("//label[@class='asg-dyn-form-property-label' and contains (.,'NODE CONDITION')]"));
    }

    public WebElement eventclass() {
        return driver.findElement(By.xpath("//label[@class='asg-dyn-form-property-label' and contains (.,'EVENT CLASS')]"));
    }

    public WebElement eventcondition() {
        return driver.findElement(By.xpath("//label[@class='asg-dyn-form-property-label' and contains (.,'EVENT CONDITION')]"));
    }


    public WebElement noadvancedSettings() {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//div[@class='actions-bar']"));
    }

    public WebElement nodeinvalideexpression(String errorcondition) {
        return driver.findElement(By.xpath("//div[@class='alert alert-danger asg-error-message']//li[contains(.,'Invalid script for setting " + errorcondition + " in configuration')]"));
    }


    public WebElement getDynamicFieldInTableautemplates() {
        synchronizationVisibilityofElement(driver, getDynamicField);
        return getDynamicField;
    }

    public WebElement getDynamicFieldScrollBar() {
        synchronizationVisibilityofElement(driver, getDynamicFieldScrollBar);
        return getDynamicFieldScrollBar;
    }

    public List<WebElement> getAnalysisPlugin() {
        synchronizationVisibilityofElementsList(driver, analysisPlugin);
        return analysisPlugin;
    }

    public WebElement getAdvancedSettingOption() {
        synchronizationVisibilityofElement(driver, showAdvancedSettings);
        return showAdvancedSettings;
    }

    public WebElement getCatalogdropdownIcon() {
        synchronizationVisibilityofElement(driver, catalogdropdownIcon);
        return catalogdropdownIcon;
    }

    public WebElement getCatalogInPluginManager(String catalogName) {
        return driver.findElement(By.xpath("//strong[contains(.,'CATALOG NAME')]//following::li[@class='dropdown-item']/a/span[contains(.,'" + catalogName + "')]"));
    }

    public WebElement getSearchCloseicon() {
        return driver.findElement(By.xpath("//em[@class='fa fa-close']"));
    }

    public WebElement getPluginTab() {
        synchronizationVisibilityofElement(driver, getPluginTab);
        return getPluginTab;
    }

    public WebElement getAnalyisisNode() {
        synchronizationVisibilityofElement(driver, getAnalysisNodePluginTab);
        return getAnalysisNodePluginTab;
    }

    public WebElement getPluginConfigEdit(String configName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//tr/td[contains(.,'" + configName + "')]"));
    }


    public WebElement pluginConfigurationInputError(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(@class,'asg-dyn-form-property-label tooltip-indicator')][text()=' "+fieldName+"']/../../..//div[contains(@class,'error text-left')]"));
    }

    public WebElement getPluginName(String pluginName) {
        return driver.findElement(By.xpath("//div[@class='content-table asg-dataset-plugins-table']//tbody//tr//td[1][contains(.,'" + pluginName + "')]"));
    }


    /*
    10.3 Page Objects for Plugin Manager
     */

    public WebElement getFilterIconInManageConfigurationsPage() {
        return getFilterIcon;
    }

    public WebElement getSearchIconInManageConfigurationsPage() {
        return getSearchIcon;
    }

    public WebElement getFilterOrSearchCloseButon() {
        return filterOrSearchCloseButon;
    }

    public WebElement getSearchText() {
        return searchText;
    }

    @FindBy(xpath = "//span[@class[contains(.,'label-text')]]")
    private List<WebElement> isLabelsPresentInmanageConfig;

    @FindBy(xpath = "//label[@class[contains(.,'asg-dyn-form-property-label')]]")
    private List<WebElement> isLabelsPresentInAddConfig;

    @FindBy(xpath = "//div[@class='manage-config-table']//tr/td[3]")
    private List<WebElement> typesAttribute;

    @FindBy(xpath = "//div[@class='manage-config-table']//following::div/div/button/div[1]")
    private List<WebElement> deploymentAttribute;

    @FindBy(xpath = "//div[@class='manage-config-table']//tr/td[1]/span")
    private List<WebElement> ConfigurationAttribute;

    @FindBy(xpath = "//div[@class='manage-config-table']//tr/td[4]")
    private List<WebElement> CatalogAttribute;

    @FindBy(xpath = "//label[contains(.,'Function')]/..//following::div[@class[contains(.,'asg-dynamic-form-select-drop-down')]][1]//li/a/span")
    private List<WebElement> edibusFunctionDropdown;

    @FindBy(xpath = "//li[@class[contains(.,'d-inline ng-star-inserted')]]")
    private List<WebElement> breadcrumbListInLogView;

    @FindBy(css = "span[role='presentation']")
    private List<WebElement> pluginLog;

    public WebElement getDropdownButtonOfFilters(String filterName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'label-text')]][contains(.,'"+filterName+"')]//following::div/button/span[2]"));
    }

    public WebElement getAttributeInFilterDropDown(String filterName, String option) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'label-text')]][contains(.,'"+filterName+"')]//following::li[@class[contains(.,'dropdown-item')]]/div[contains(.,'"+option+"')]"));
    }

    public WebElement getDeploymentStatus(String deploymentStatus) {
        return driver.findElement(By.xpath("//div[@class='text-left node-header-align'][contains(.,'" + deploymentStatus + "')]/span/img"));
    }

    public WebElement getPluginCount(String deploymentName, String status) {
        return driver.findElement(By.xpath("//div[@class='text-left node-header-align'][contains(.,'" + deploymentName + "')][1]//following::img[@src[contains(.,'" + status + "')]][2]//following::span[1]"));
    }

    public WebElement getAllTheStatusIndicators() {
        return statusIndicators;
    }

    public void clickCollapseButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//button[contains(.,'" + deploymentName + "')]/div/div/span/em[@class[contains(.,'fa-caret-down')]]")));
    }

    public void clickDeploymentOpenButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='text-left node-header-align'][1][contains(.,'" + deploymentName + "')]/span")));
    }

    public void clickPluginExpandOrCollapseButton(String pluginType, String pluginName) {
        scrolltoElement(driver, driver.findElement(By.xpath("//span[contains(.,'"+pluginType+"')]//following::span[contains(.,'"+pluginName+"')]/../div/span[@class[contains(.,'expand-collapse-icon')]]")), true);
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//span[contains(.,'"+pluginType+"')]//following::span[contains(.,'"+pluginName+"')]/../div/span[@class[contains(.,'expand-collapse-icon')]]")));
    }

    public void clickPluginOpenButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//span[@class='config-detail'][contains(.,'"+deploymentName+"')]/preceding-sibling::*/span[1]")));
    }

    public void clickAddConfigurationButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='text-left node-header-align'][contains(.,'" + deploymentName + "')]//following::span[contains(@class,'fa fa-plus-square cursor-pointer')]")));
    }

    public void clickSearchConfigurationButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='text-left node-header-align'][contains(.,'" + deploymentName + "')]//following::span[contains(@class,'fa fa-search cursor-pointer pr-2')]")));
    }

    public WebElement getAddConfigurationButton(String deploymentName) {
        return driver.findElement(By.xpath("//div[@class='text-left node-header-align'][contains(.,'" + deploymentName + "')]//following::span[@class='fa fa-plus-square']"));
    }

    public void clickAddDataSourceButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='footer']//span[contains(.,'" + deploymentName + "')]")));
    }

    public void clickAddDataSourceButton() {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='table-container']//div[contains(@class,'footer')]//span[@class='fa fa-plus-square']")));
    }

    public void clickAddUserOrGroupButton(String deploymentName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='footer']//span[contains(.,'" + deploymentName + "')]")));
    }

    public List<WebElement> getConfigInTableView() {
        return configInTableView;
    }

    public WebElement getRunningStatusIndicatorWithStatusCount() {
        return runningStatusIndicatorWithStatusCount;
    }

    public WebElement getIdleStatusIndicatorWithStatusCount() {
        return idleStatusIndicatorWithStatusCount;
    }

    public WebElement getStoppedStatusIndicatorWithStatusCount() {
        return stoppedStatusIndicatorWithStatusCount;
    }

    public WebElement getUnknownStatusIndicatorWithStatusCount() {
        return unknownStatusIndicatorWithStatusCount;
    }

    public WebElement getDropdownButtonOfTheField(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'" + fieldName + "')]//following::button[1]/span[@class[contains(.,'float-right')]]/em"));
    }

    public WebElement getAttributeInDropdown(String filterName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+filterName+"')][1]//following::button[@class[contains(.,'dropdown-item')]]/span[contains(.,'"+option+"')]"));
    }

    public WebElement getDropdownButtonOfAdvancedSettingField(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+fieldName+"')]//following::button[@class[contains(.,'asg-multi-select-dropdown-button')]]/span/em"));
    }

    public List<WebElement> getLabelsInManageConfigurations() {
        return isLabelsPresentInAddConfig;
    }

    public WebElement getCloneButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + pluginName + "')]//following::span[@class[contains(.,'fa fa-clone')]][1]"));
    }

    public WebElement getPluginBusinessApplicationButton(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'"+pluginName+"')]//following::td[3]/span"));
    }

    public WebElement getLogButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//td[@title='"+pluginName+"']//following::span[@class[contains(.,'fa fa-external-link')]][1]"));
    }

    public WebElement getEditButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + pluginName + "')]//following::span[@class[contains(.,'far fa-edit')]][1]"));
    }

    public WebElement getDeleteButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + pluginName + "')]//following::span[@class[contains(.,'far fa-trash')]][1]"));
    }

    public WebElement getErrorIconButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+pluginName+"')]/following::img[@class[contains(.,'on-hover cursor-pointer')]]"));
    }

    public WebElement getStartButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + pluginName + "')]//following::span[@class[contains(.,'fas fa-play-circle')]][1]"));
    }


    public WebElement getclearButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//span[contains(.,'" + pluginName + "')]//following::div[@class[contains(.,'error-row')]][1]/a[1]"));
    }

    public WebElement getclearallButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//span[contains(.,'" + pluginName + "')]//following::div[@class='header'][1]/a"));
    }

    public WebElement getStopButtonForThePlugin(String pluginName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + pluginName + "')]//following::span[@class[contains(.,'fa fa-stop-circle')]][1]"));
    }
    public WebElement getWindowsAuthenticationButton() {
        return driver.findElement(By.xpath("//following::span[@class='switch switch-small']"));
    }

    public WebElement getLogViewer() {
        return logViewer;
    }

    public List<WebElement> getPluginCompletionPopUp() {
        return pluginCompletionPopUp;
    }

    public WebElement getPopupCloseButton() {
        return popupCloseButton;
    }

    public WebElement getTextBoxInManageDataSources(String textbox) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'configuration-property')]][1]//following::label[contains(.,'" + textbox + "')][1]//following::input[1]"));
    }

    public WebElement getPlugin(String pluginName) {
        return driver.findElement(By.xpath("//tr//td[1]/span[contains(text(),'" + pluginName + "')]"));
    }

    public WebElement getCredentialNameTextBox() {
        return credentialNameTextbox;
    }

    public WebElement getDataSourceNameTextBox() {
        return dataSourceNameTextbox;
    }

    public WebElement getTestConnectionButton() {
        synchronizationVisibilityofElement(driver, testConnectionButton);
        return testConnectionButton;
    }

    public WebElement getPopUpXButton() {
        synchronizationVisibilityofElement(driver, popUpXButton);
        return popUpXButton;
    }

    public WebElement getPopUpCloseButton() {
        synchronizationVisibilityofElement(driver, popUpCloseButton);
        return popUpCloseButton;
    }

    public WebElement getFinishButton() {
        return finishButton;
    }

    public WebElement getTestConnectionButtonDisabled() {
        synchronizationVisibilityofElement(driver, testConnectionButtonDisabled);
        return testConnectionButtonDisabled;
    }

    public WebElement getsaveButtonDisabled() {
        synchronizationVisibilityofElement(driver, saveButtonDisabled);
        return saveButtonDisabled;
    }

    public WebElement getFieldValidationMesssage(String pageName, String fieldName) {
        return driver.findElement(By.xpath("//div/h4[contains(.,'" + pageName + "')]//following::label[contains(.,'" + fieldName + "')][1]//following::div[@class[contains(.,'error text-left')]][1]"));
    }

    public WebElement getFailureConnectionMessage() {
        synchronizationVisibilityofElement(driver, failedConnectionMessage);
        return failedConnectionMessage;
    }

    public WebElement getSuccessConnectionMessage() {
        synchronizationVisibilityofElement(driver, successConnectionMessage);
        return successConnectionMessage;
    }


    public WebElement getErrorTooltip() {
        synchronizationVisibilityofElement(driver, errorTooltip);
        return errorTooltip;
    }

    public List<WebElement> getErrorInListFromToolTip() {
        return errorTooltipList;
    }

    public List<WebElement> getErrorTimestampInListFromToolTip() {
        return errorTooltipTimeStampList;
    }


    public WebElement getManageBundleText(String text) {
        return driver.findElement(By.xpath("//div[contains(text(), '" + text + "')]"));
    }

    public WebElement getManageuploadBundleText(String Uploadtext) {
        return driver.findElement(By.xpath("//p[contains(text(), '" + Uploadtext + "')]"));
    }

    public WebElement getCloneButtonForTheCredentials(String credentialName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + credentialName + "')]//following::span[@class[contains(.,'fa fa-clone')]][1]"));
    }

    public WebElement getEditButtonForTheCredential(String credentialName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + credentialName + "')]//following::span[@class[contains(.,'far fa-edit')]]"));
    }

    public WebElement getCloneButtonForTheDataSource(String dataSourceName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + dataSourceName + "')]//following::span[@class[contains(.,'fa fa-clone')]][1]"));
    }

    public WebElement getEditButtonForTheDataSource(String dataSourceName) {
        return driver.findElement(By.xpath("//td[contains(.,'" + dataSourceName + "')]//following::span[@class[contains(.,'far fa-edit')]]"));
    }

    public WebElement getTextBoxInAddOrUpdateConfiguration(String textbox) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-plugin')]]//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+textbox+"')]//following::input[1]"));
    }

    public WebElement getPipelinePluginNameTextBox(String textbox) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-plugin')]]//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+textbox+"')]//following::input[1]"));
    }

    public WebElement getPropertiesTextBoxInAddConfiguration(String textbox) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-dynamic-form-property-label-container')]][1]//following::label[contains(.,'" + textbox + "')][4]//following::input[1]"));
    }

    public WebElement getLogType(String type) {
        return driver.findElement(By.xpath("//strong[contains(.,'Type')]//following::input[@id='" + type + "']"));
    }

    public WebElement getLogTypeCheckbox() {
        return logTypeCheckBox;
    }

    public WebElement getAddConfigSaveButton() {
        synchronizationVisibilityofElement(driver, saveButton);
        return saveButton;
    }

    public WebElement getJDBCSettingsAddButton() {
        synchronizationVisibilityofElement(driver, JDBCAddButton);
        return JDBCAddButton;
    }

    public void clickConfigurationAddButton(String buttonName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='asg-dynamic-form-property-label-container']/label[contains(.,'" + buttonName + "')]//following::div[@class='asg-dyn-form-table-add-cataloger-btn']")));
    }

    public List<WebElement> getFirstTimeStampInLogPage() {
        return timestampInLogPage;
    }

    public WebElement getLogCalenderIcon() {
        synchronizationVisibilityofElement(driver, calenderIcon);
        return calenderIcon;
    }

    public WebElement getDayHasLog() {
        synchronizationVisibilityofElement(driver, dayhasLog);
        return dayhasLog;
    }

    public WebElement getDayHasNoLogIsDisabled() {
        synchronizationVisibilityofElement(driver, dayHasNoLog);
        return dayHasNoLog;
    }

    public WebElement getDryRunButtonDisabled() {
        synchronizationVisibilityofElement(driver, dryRunButtonDisabled);
        return dryRunButtonDisabled;
    }

    public void clickAddButtonForTheField(String fieldName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("(//label[contains(.,'" + fieldName + "')]/following::em[@class[contains(.,'input-group-addon add-icon fas fa-plus')]])[1]")));
    }

    public void clickTagSuggestionInAdvancedSetting(String suggesstedTag){
        clickOn(driver.findElement(By.xpath("//li[@class[contains(.,'tag-search-result-item')]][contains(.,'"+suggesstedTag+"')]")));
    }

    public void clickAddButtonForFilter(String fliterName) {
        moveToElementUsingJavaScript(driver,driver.findElement(By.xpath("//label[contains(.,'" + fliterName + "')]//following::div[@class='asg-dyn-form-table-add-cataloger-btn'][1]")));
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//label[contains(.,'" + fliterName + "')]//following::div[@class='asg-dyn-form-table-add-cataloger-btn'][1]")));
    }

    public void clickAddButtonForEnteredFilter(String fliterName) {
        scrolltoElement(driver,driver.findElement(By.xpath("//strong[contains(.,'"+fliterName+"')]//following::button[@class='spinner-btn']")), true);
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//strong[contains(.,'"+fliterName+"')]//following::button[@class='spinner-btn']")));
    }

    public void clickLabel(String fieldName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//label[contains(.,'" + fieldName + "')]")));
    }

    public List<WebElement> getAddedItem(String container) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'configuration-property')]][contains(.,'" + container + "')]//div[@class[contains(.,'tag')]]/div/span[1]"));
    }

    public WebElement getBranchAddButton() {
        synchronizationVisibilityofElement(driver, branchAddButton);
        return branchAddButton;
    }

    public WebElement getDefaultSelectedOption(String fieldName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+fieldName+"')]//following::div[@class[contains(.,'asg-dynamic-form-select-drop-down')]]/button/span[contains(.,'"+option+"')]"));
    }

    public WebElement getBADefaultOptionInPluginManager(String option) {
        return driver.findElement(By.xpath("//label[contains(.,' Business Application')]//following::span[contains(.,'"+option+"')]"));
    }

    public WebElement getEmptiedErrorMessagePanel() {
        synchronizationVisibilityofElement(driver, emptiedErrorMessagePanel);
        return emptiedErrorMessagePanel;
    }

    public WebElement getManageConfigurationsLink() {
        synchronizationVisibilityofElement(driver, manageConfigurationsLink);
        return manageConfigurationsLink;
    }

    public WebElement getVerticalLogBar(){
        return verticalLogBar;
    }

    public WebElement getHorizontalLogBar(){
        return horizontalLogBar;
    }

    public WebElement getBranchTextBox() {
        return branchTextbox;
    }

    public WebElement getMenuButtonForThePlugin(String pluginName, String buttonName) {
        return driver.findElement(By.xpath("//*[contains(.,'"+pluginName+"')]//following::span[@title='"+buttonName+"']"));
    }

    public WebElement GetInlineErrorMessage(String ErrorMessage) {
        return driver.findElement(By.xpath("//div[@class='error text-left ng-star-inserted'][contains(.,'"+ErrorMessage+"')]"));
    }

    public WebElement GetDeleteErrorMessage(String ErrorMessage) {
        return driver.findElement(By.xpath("//p[contains(.,'"+ErrorMessage+"')]"));
    }
    public List<WebElement> getTagsInAdvancedSettingsPanel() {
        synchronizationVisibilityofElementsList(driver, tagsInAdvancedSettingsPanel);
        return tagsInAdvancedSettingsPanel;
    }

    public WebElement getTagCloseIcon(String tagName) {
        return driver.findElement(By.xpath("//div[@title='"+tagName+"']//following-sibling::em"));
    }
    public WebElement getDetailPluginPanel(String Name) {
        return driver.findElement(By.xpath("//span[contains(.,'"+Name+"')]"));
    }

    public WebElement getSchedulerType(String Name) {
        return driver.findElement(By.xpath("//input[@id='"+Name+"']"));
    }
    public WebElement getExpandCollspaselogfilter(String Name) {
        return driver.findElement(By.xpath("//strong[contains(.,'"+Name+"')]//../span/em"));
    }

    public WebElement getNodeName(String Name) {
        return driver.findElement(By.xpath("(//button[@aria-controls='"+Name+"']//following::span[contains(.,'Log')])[1]"));
    }

    public WebElement getAdvacedSettingTagsBox() {
        return driver.findElement(By.cssSelector("input[placeholder='Enter tags']"));
    }

    public WebElement getAddConfigurationsTags() {
        synchronizationVisibilityofElement(driver, addConfigurationsTags);
        return addConfigurationsTags;
    }

    public void clickPluginEdit(String pluginname) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//span[contains(text(),'"+pluginname+"')]")));
    }

    public WebElement getpluginTooltip(String pluginname,String tooltip) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+pluginname+"')]//following::span[@title='"+tooltip+"']"));
    }
    public WebElement getAddPipelineButton() {
        return addPipelineButton;
    }

    public void clickPluginTypeExpandButton(String pluginType) {
        pluginType = pluginType.toLowerCase();
        scrolltoElement(driver, driver.findElement(By.xpath("//span[@class[contains(.,'plugin-type')]][contains(.,'" + pluginType + "')]/preceding-sibling::span[1]")), true );
        clickOn(driver.findElement(By.xpath("//span[@class[contains(.,'plugin-type')]][contains(.,'" + pluginType + "')]/preceding-sibling::span[1]")));
    }

    public void clickNewConfigPluginTypeTab() {
        clickOn(driver.findElement(By.xpath("//div[@class[contains(.,'tab')]][contains(.,'New Configurations')]")));
    }

    public void clickPluginInExistingConfiguration(String pluginName) {
        clickOn(driver.findElement(By.xpath("//div[@class[contains(.,'existing-config')]][contains(.,'" + pluginName + "')]")));
    }

    public void clickPluginInNewConfiguration(String pluginName) {
        clickOn(driver.findElement(By.xpath("//div[@class[contains(.,'new-config')]][contains(.,'" + pluginName + "')]")));
    }

    public WebElement getPipelineNametextbox() {
        return pipelineNametextbox;
    }
    public WebElement getPipelineDesctextbox() {
        return pipelineDesctextbox;
    }

    public void clickExpandPipelineButton(String pipelineName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//span[@class[contains(.,'config-detail plugin-name-container')]][contains(.,'" + pipelineName + "')]/preceding-sibling::span")));
    }

    public WebElement getDiagram(String configName,String configType) {
        return driver.findElement(By.xpath("//div[@class='text-truncate'][contains(.,'"+configName+"')]/preceding::span[@class='title text-capitalize'][contains(.,'"+configType+"')]"));
    }

        public List<WebElement> getPipelineAccordion(String pipelineAccordion) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'accordion-container')]][contains(.,'"+pipelineAccordion+"')]"));
    }

    public WebElement getDiagramStatus(String configName) {
        return driver.findElement(By.xpath("//div[@class='text-truncate'][contains(.,'"+configName+"')][1]/preceding-sibling::*//..//../div/span[2]/img"));
    }

    public WebElement getFieldValuesInPipelineAccordion(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]/following::div[1]"));
    }

    public WebElement getDiagramMenuOption(String configName, String menuOption) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'text-truncate')]][contains(.,'"+configName+"')]/following::span[@title='"+menuOption+"']"));
    }
    public WebElement getQueryCodeTextBox() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'configuration-property')]][1]//following::label[contains(.,'Query Code')][1]//following::textarea"));
    }

    public WebElement getAccordionTableScroll(String pluginname) {
        return driver.findElement(By.xpath("//span[@class='config-detail'][contains(.,'"+pluginname+"')]//following::div[@class='table-wrapper overflow-auto']"));
    }

    public WebElement getActiveAccordion(String pluginConfigname) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'align-items-center cursor-pointer accordion-header active')]][contains(.,'"+pluginConfigname+"')]"));
    }


    public void clickShowtheDataElementsLink() {
        clickOn(showtheDataElementsLink);
    }
    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void dynamicClickActions(String elementType, String... dynamicItem) {
        switch (elementType) {
        }
    }

    public void enterActions(String elementType, String text) {
        switch (elementType) {
            case "dynamic field":
                enterUsingActions(driver, getDynamicFieldInTableautemplates(), Constant.DYNAMIC_FIELD_INPUT_TEXT);
                break;
            case "Search Box":
                enterText(getSearchText(), text);
                break;
        }
    }

    public void genericClick(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Dataset plugin label":
                    clickOn(driver, getDatasetPlugins());
                    break;
                case "Analysis plugin label":
                    clickOn(driver, getAnalysisPlugins());
                    sleepForSec(1000);
                    break;
                case "Analysis nodes label":
                    clickOn(driver, getAnalysisNodes());
                    break;
                case "list of Plugins":
                    WebElement element = traverseListContainsElementReturnsElement(getPluginsList(), dynamicItem[0]);
                    scrollToWebElement(driver, element);
                    clickonWebElementwithJavaScript(driver, element);
                    sleepForSec(1000);
                    break;
                case "add button":
                    scrollToWebElement(driver, childPageAddButton(dynamicItem[0]));
                    sleepForSec(500);
                    clickonWebElementwithJavaScript(driver, childPageAddButton(dynamicItem[0]));
                    sleepForSec(500);
                    break;
                case "Add button near to field":
                    clickOn(clickAddButtonInPluginConfiguration(dynamicItem[0]));
                    sleepForSec(500);
                    break;
                case "catalog dropdown button":
                    clickOn(getCatalogdropdownIcon());
                    break;
                case "select catalog in plugin configuration":
                    scrolltoElement(driver, getCatalogInPluginManager(dynamicItem[0]), true);
                    clickonWebElementwithJavaScript(driver, getCatalogInPluginManager(dynamicItem[0]));
                    break;
                case "select plugin":
                    scrolltoElement(driver, traverseListContainsElementReturnsElement(getAnalysisPlugin(), dynamicItem[0]), true);
                    clickOn(traverseListContainsElementReturnsElement(getAnalysisPlugin(), dynamicItem[0]));

                    break;
                case "ANALYSIS PLUGINS":
                    waitForAngularLoad(driver);
                    clickOn(getPluginTab());
                    sleepForSec(2000);
                    break;

                case "ANALYSIS NODES":
                    waitForAngularLoad(driver);
                    clickOn(getGetAnalysisNodePluginTab());
                    sleepForSec(2000);
                    break;
                //10.3 New UI
                case "Filter Icon":
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver, getFilterIconInManageConfigurationsPage());
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    break;
                case "Search Icon":
                    clickonWebElementwithJavaScript(driver, getSearchIconInManageConfigurationsPage());
                    waitForAngularLoad(driver);
                    break;
                case "Filter/Search Close Button":
                    clickOn(driver, getFilterOrSearchCloseButon());
                    break;
                case "Collapse Deployment":
                    clickCollapseButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Open Deployment":
                    clickDeploymentOpenButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Open Plugin":
                    clickPluginOpenButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Add Configuration":
                    clickAddConfigurationButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "SearchConfiguration":
                    clickSearchConfigurationButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Show Advanced Settings":
                    scrollToWebElement(driver, getAdvancedSettingOption());
                    clickOn(getAdvancedSettingOption());
                    sleepForSec(500);
                    break;
                case "Hide Advanced Settings":
                    clickOn(getAdvancedSettingOption());
                    sleepForSec(500);
                    break;
                case "Save":
                    clickOn(driver, getAddConfigSaveButton());
                    waitForAngularLoad(driver);
                    sleepForSec(3000);
                    break;
                case "Add":
                    clickConfigurationAddButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    sleepForSec(2000);
                    break;
                case "Add JDBC Settings":
                    waitForAngularLoad(driver);
                    synchronizationVisibilityofElement(driver, getJDBCSettingsAddButton());
                    clickOn(getJDBCSettingsAddButton());
                    waitForAngularLoad(driver);
                    sleepForSec(2000);
                    break;
                case "Clone":
                    moveToElementWithActions(driver, getCloneButtonForThePlugin(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getCloneButtonForThePlugin(dynamicItem[0]));
                    //clickOn(driver, getCloneButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Edit":
                    moveToElementWithActions(driver, getEditButtonForThePlugin(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getEditButtonForThePlugin(dynamicItem[0]));
                    //clickOn(driver, getEditButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Delete":
                    clickOn(driver, getDeleteButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Start":
                    moveToElementWithActions(driver, getStartButtonForThePlugin(dynamicItem[0]));
                    clickOn(driver, getStartButtonForThePlugin(dynamicItem[0]));
                    sleepForSec(1000);
                    break;
                case "Stop":
                    moveToElementWithActions(driver, getStopButtonForThePlugin(dynamicItem[0]));
                    clickOn(getStopButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Log":
                    waitForAngularLoad(driver);
                    scrollToWebElement(driver, getPlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    moveToElement(driver, getLogButtonForThePlugin(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver,getLogButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Error Icon":
                    clickOn(getErrorIconButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "popup close button":
                    clickOn(getPopupCloseButton());
                    sleepForSec(1000);
                case "Test Connection":
                    clickOn(getTestConnectionButton());
                    waitForAngularLoad(driver);
                    break;
                case "PopUp X":
                    clickOn(getPopUpXButton());
                    waitForAngularLoad(driver);
                    break;
                case "PopUp Close":
                    clickOn(getPopUpCloseButton());
                    waitForAngularLoad(driver);
                    break;
                case "Clone_Add Credential":
                    moveToElementWithActions(driver, getCloneButtonForTheCredentials(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getCloneButtonForTheCredentials(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Edit_Add Credential":
                    moveToElementWithActions(driver, getEditButtonForTheCredential(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getEditButtonForTheCredential(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Clone_DataSource":
                    moveToElementWithActions(driver, getCloneButtonForTheDataSource(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getCloneButtonForTheCredentials(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Edit_DataSource":
                    moveToElementWithActions(driver, getEditButtonForTheDataSource(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getEditButtonForTheCredential(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Clear":
                    clickOn(getclearButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "ClearAll":
                    waitForAngularLoad(driver);
                    clickOn(driver,getclearallButtonForThePlugin(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "select type":
                    clickonWebElementwithJavaScript(driver, getLogType(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Type checkbox":
                    clickonWebElementwithJavaScript(driver, getLogTypeCheckbox());
                    waitForAngularLoad(driver);
                    break;
                case "Add Data Source":
                    clickAddDataSourceButton();
                    waitForAngularLoad(driver);
                    break;
                case "Add User or Group":
                    clickAddUserOrGroupButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Configuration Add":
                    clickTagSuggestionInAdvancedSetting(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Expand Label":
                    clickLabel(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Add attribute for Branch":
                    clickOn(driver,getBranchAddButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add entered attribute":
                    clickAddButtonForEnteredFilter(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Manage Configurations Link":
                    clickOn(driver, getManageConfigurationsLink());
                    waitForAngularLoad(driver);
                    break;
                case "Plugin Business Application":
                    moveToElementWithActions(driver, getPluginBusinessApplicationButton(dynamicItem[0]));
                    clickonWebElementwithJavaScript(driver, getPluginBusinessApplicationButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Add attribute":
                    clickAddButtonForFilter(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Advanced Settings":
                    scrollToWebElement(driver, getAdvancedSettingOption());
                    clickOn(getAdvancedSettingOption());
                    sleepForSec(500);
                    break;
                case "Advanced settings dropdown":
                    scrolltoElement(driver, getDropdownButtonOfAdvancedSettingField(dynamicItem[0]),true);
                    clickOn(driver, getDropdownButtonOfAdvancedSettingField(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "plugin menu buttons":
                    moveToElementWithActions(driver, getStartButtonForThePlugin(dynamicItem[1]));
                    clickOn(driver, getMenuButtonForThePlugin(dynamicItem[1], dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Add tags in Advanced Settings":
                    enterText(new DashBoardPage(driver).getTagsTextbox(), dynamicItem[0]);
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver, new DashBoardPage(driver).getSuggestedOptionInTaggingPage(dynamicItem[0]));
                    break;
                case "Add Invalid tags in Advanced Settings":
                    enterText(new DashBoardPage(driver).getTagsTextbox(), dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Tags close icon":
                    clickOn(driver, getTagCloseIcon(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Expand accordion":
                    clickDeploymentOpenButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    clickPluginExpandOrCollapseButton(dynamicItem[1],dynamicItem[2]);
                    waitForAngularLoad(driver);
                    break;
                case "Expand accordion and click menu option":
                    clickDeploymentOpenButton(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    clickPluginExpandOrCollapseButton(dynamicItem[1],dynamicItem[2]);
                    waitForAngularLoad(driver);
                    clickOn(driver, getMenuButtonForThePlugin(dynamicItem[2], dynamicItem[3]));
                    waitForAngularLoad(driver);
                    break;
                case "Add Pipeline":
                    clickOn(getAddPipelineButton());
                    waitForAngularLoad(driver);
                    break;
                case "Detail plugin panel":
                    clickOn(driver, getDetailPluginPanel(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Plugin Edit":
                    clickPluginEdit(dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;

                case "Windows Authentication":
                    clickOn(getWindowsAuthenticationButton());
                    waitForAngularLoad(driver);
                    break;
                case "Scheduler Type":
                    clickOn(driver,getSchedulerType(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "ExpandCollapse Log filter":
                    clickOn(driver, getExpandCollspaselogfilter(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Logs of nodes":
                    clickOn(driver,getNodeName(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Search close Icon":
                    clickOn(driver,getSearchCloseicon());
                    waitForAngularLoad(driver);
                    break;
                case "Show the data elements in a list link":
                    clickShowtheDataElementsLink();
                    waitForAngularLoad(driver);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "dynamic scroll bar":
                    verifyTrue(getDynamicFieldScrollBar().isDisplayed());
                    break;
                //10.3 New UI
                case "Status Indicators":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyTrue(getAllTheStatusIndicators().isDisplayed());
                    break;
                case "Table view of configs":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyTrue(getConfigInTableView().get(0).isDisplayed());
                    break;
                case "Staus count and Staus Indicator":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyTrue(getRunningStatusIndicatorWithStatusCount().isDisplayed());
                    verifyTrue(getIdleStatusIndicatorWithStatusCount().isDisplayed());
                    verifyTrue(getStoppedStatusIndicatorWithStatusCount().isDisplayed());
                    verifyTrue(getUnknownStatusIndicatorWithStatusCount().isDisplayed());
                    break;
                case "Add Configuration":
                    takeScreenShot(elementName + " is captured", driver);
                    moveToElement(driver, getAddConfigurationButton(dynamicItem[0]));
                    verifyTrue(isElementPresent(getAddConfigurationButton(dynamicItem[0])));
                    waitForAngularLoad(driver);
                    break;
                case "Log Viewer":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyTrue(isElementPresent(getLogViewer()));
                    waitForAngularLoad(driver);
                    break;
                case "plugin completion popup":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyTrue(isElementPresent(getPluginCompletionPopUp().get(0)));
                    waitForAngularLoad(driver);
                    break;
                case "Failed datasource connection":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getFailureConnectionMessage()));
                    break;
                case "Successful datasource connection":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSuccessConnectionMessage()));
                    break;
                case "Error tooltip":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getErrorTooltip()));
                    break;
                case "Timestamp in the Error tooltip":
                    takeScreenShot(elementName + " is captured", driver);
                    String pattern = "yyyy-MM-dd";
                    String currentDate = CommonUtil.getCurrentDate(pattern);
                    Assert.assertTrue(getErrorTimestampInListFromToolTip().get(0).getText().contains(currentDate));
                    break;
                case "Calender Icon":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyTrue(isElementPresent(getLogCalenderIcon()));
                    break;
                case "Add and delete bundles.":
                case "Drag and drop anywhere to upload.":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageBundleText(elementName)));
                    break;
                case "Select a bundle to upload.":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageuploadBundleText(elementName)));
                    break;
                case "Default Option selected":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getDefaultSelectedOption(dynamicItem[0],dynamicItem[1])));
                    break;
                case "Default BA Option selected":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getBADefaultOptionInPluginManager(dynamicItem[0])));
                    break;
                case "Error message is emptied":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getEmptiedErrorMessagePanel()));
                    break;
                case "Horizontal Bar for Log Viewer":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getHorizontalLogBar()));
                    break;
                case "Vertical Bar for Log Viewer":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getVerticalLogBar()));
                    break;
                case "AdvanceSettingsExpand":
                    takeScreenShot(elementName + " is captured", driver);
                    scrollToWebElement(driver,getAdvancedSettingOption());
                    Assert.assertTrue(isElementPresent(getAdvancedSettingOption()));
                    break;
                case "Accordion table scroll":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getAdvancedSettingOption()));
                    break;
                case "Search close Icon":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSearchCloseicon()));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementNotPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                //10.3 New UI
                case "plugin list":
                    takeScreenShot(elementName + " is captured", driver);
                    verifyFalse(traverseListContainsElement(PluginsList, dynamicItem[0]));
                    break;
                case "Multi select dropdown for tags":
                    takeScreenShot(elementName + " is captured", driver);
                    enterText(new DashBoardPage(driver).getTagsTextbox(), "a");
                    waitForAngularLoad(driver);
                    verifyTrue(getConfigurationDropDownValue().isEmpty());
                    break;
                case "Search close Icon":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isNotElementPresent(getSearchCloseicon()));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementIsEnabled(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                //10.3 New UI
                case "Test Connection":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getTestConnectionButton()));
                    break;
                case "Finish button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled((getFinishButton())));
                    break;
                case "Save":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementEnabled(getsaveButtonDisabled()));
                    break;
            }
        } catch (NoSuchElementException e) {
            //Assert.fail(e.getMessage() + "Element not found ");
            LoggerUtil.logLoader_info("Element Not found" + e.getMessage(), e.getLocalizedMessage());
        }

    }

    public void genericVerifyElementIsDisabled(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                //10.3 New UI
                case "Test Connection":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isElementEnabled(getTestConnectionButtonDisabled()));
                    break;
                case "Day which has no log":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getDayHasNoLogIsDisabled()));
                    String date = CommonUtil.getCurrentDay();
                    Assert.assertTrue(date.contains(getDayHasLog().getText()));
                    break;
                case "DryRun button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isElementEnabled(getDryRunButtonDisabled()));
                case "Save":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertFalse(isElementEnabled(getsaveButtonDisabled()));
                    break;
            }
        } catch (NoSuchElementException e) {
            Assert.fail(e.getMessage() + "Element not found ");
            LoggerUtil.logLoader_info("Element Not found" + e.getMessage(), e.getLocalizedMessage());
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

    public void genericVerifyEnabled(String elementName) {
        try {


        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyDisabled(String elementName) {
        try {


        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void navigateToPluginConfig(String pluginName, String pluginConfig) throws Exception {
        moveToElement(driver, getPluginName(pluginName));
        traverseListContainsElementAndClick(driver, getPluginsList(), pluginName);
        waitUntilJSReady(driver);
        sleepForSec(3000);
        clickOn(getPluginConfigEdit(pluginConfig));
        waitUntilJSReady(driver);
        sleepForSec(1000);
    }

    public void navigateToPluginConfigListPage(String pluginName) throws Exception {
        moveToElement(driver, getPluginName(pluginName));
        traverseListContainsElementAndClick(driver, getPluginsList(), pluginName);
        waitUntilJSReady(driver);
//        sleepForSec(3000);
        waitForAngularLoad(driver);
    }

    public boolean isElementpresentInPluginConfig(String actionType, List<Map<String, String>> arg) throws Exception {
        boolean flag = false;
        switch (actionType) {
            case "Verify Error message presence":
                for (int i = 0; i < arg.size(); i++) {
                    if (pluginConfigurationInputError(arg.get(i).get("fieldName")).getText().equals(arg.get(i).get("errorMessage"))) {
                        flag = true;
                    } else {
                        throw new Exception(arg.get(i).get("fieldName"));
                    }
                }
                break;
        }

        return flag;
    }


    public boolean isMapElementpresentInPluginConfig(String actionType, Map<String, String> arg) throws Exception {
        boolean flag = false;
        switch (actionType) {
            case "Verify tool tip message presence":
                for (Map.Entry<String, String> values : arg.entrySet()) {
                    JavascriptExecutor js = (JavascriptExecutor) driver;
                    js.executeScript("arguments[0].scrollIntoView();", pluginConfigToolTipButton(values.getKey()));
                    Actions mouseover = new Actions(driver);
                    mouseover.clickAndHold(pluginConfigToolTipButton(values.getKey())).build().perform();
                    if (getPluginConfigurationToolTip(values.getKey()).getText().equals(values.getValue())) {
                        flag = true;
                        mouseover.click(pluginConfigToolTipButton(values.getKey())).build().perform();
                    } else {
                        throw new Exception(values.getKey());
                    }
                }
                break;
        }
        return flag;
    }

    private WebElement getGetAnalysisNodePluginTab() {
        synchronizationVisibilityofElement(driver, getAnalysisNodePluginTab);
        return getAnalysisNodePluginTab;
    }

    public void advancedsettingvalidationforallplugin() {
        clickOn(driver, new PluginManagerActions(driver).getAnalysisPlugins());
        List<WebElement> pluginname = new PluginManagerActions(driver).getAnalysisPlugin();
        for (int i = 0; i < pluginname.size(); i++) {
            new PluginManagerActions(driver).clickmultipleAnalysisPluginFromList(pluginname.get(i).getText());
            clickOn(new PluginManager(driver).clickAddButton());
            clickOn(new PluginManager(driver).clickUnassignPluginButtton());
            Assert.assertTrue(new PluginManager(driver).nodeCondition().isDisplayed() || new PluginManager(driver).eventcondition().isDisplayed() || new PluginManager(driver).eventclass().isDisplayed());
            clickOn(new PluginManager(driver).clickAddButtonInsideFieldPanel("PLUGIN CONFIGURATION"));
            sleepForSec(2000);
            new PluginManager(driver).clickonconfigurationexit();
        }
    }

    public void datasetvalidationforallplugin() {
        clickOn(driver, new PluginManagerActions(driver).getDatasetPlugins());
        List<WebElement> pluginname = new PluginManagerActions(driver).getAnalysisPlugin();
        for (int i = 0; i < pluginname.size(); i++) {
            sleepForSec(2000);
            new PluginManagerActions(driver).clickmultipleAnalysisPluginFromList(pluginname.get(i).getText());
            clickOn(new PluginManager(driver).clickAddButton());
            Assert.assertTrue(new PluginManager(driver).noadvancedSettings().isDisplayed());
            clickOn(new PluginManager(driver).clickAddButtonInsideFieldPanel("DATASET PLUGIN CONFIGURATION"));
            sleepForSec(2000);
            new PluginManager(driver).clickonconfigurationexit();
        }
    }

    public void nodeinvalidexpressionvalidation(String errorcondition) {
        Assert.assertTrue(new PluginManager(driver).nodeinvalideexpression(errorcondition).isDisplayed());

    }

    public WebElement pluginConfigToolTipButton(String fieldName) {
        return driver.findElement(By.xpath("//div//label[contains(@class,'asg-dyn-form-property-label tooltip-indicator')][contains(.,'" + fieldName + "')]"));
    }

    @FindBy(xpath = "//app-asg-property-label//LABEL[contains(@class,'asg-dyn-form-property-label')]")
    private List<WebElement> isCaptionsPresentInPluginConfig;


    public boolean isCaptionsPresentInPluginConfig(String actionType, List<String> data) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionType) {
            case "Verify the presnce of captions":
                for (String expValue : data) {
                    expected.add(expValue);
                }
                for (WebElement caption : isCaptionsPresentInPluginConfig) {
                    actual.add(caption.getText());
                }
                actual.retainAll(expected);
                Collections.sort(actual);
                Collections.sort(expected);
                if (actual.equals(expected)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Verify only below list of item is present for Configuration Filter":
                for (WebElement Types : ConfigurationAttribute) {
                    if (data.contains(Types.getText()) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Verify only below list of item is present for Catalog Filter":
                for (WebElement Types : CatalogAttribute) {
                    if (data.contains(Types.getText()) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Verify list of items in EDIBus function dropdown":
            {
                 moveToElement(driver, getDropdownButtonOfTheField("Function"));
                 clickonWebElementwithJavaScript(driver, getDropdownButtonOfTheField("Function"));
                 Assert.assertEquals(edibusFunctionDropdown.size(),data.size());
                for (WebElement Types : edibusFunctionDropdown) {
                    if (data.contains(Types.getText()) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                }
                break;
        }

        return flag;
    }

    public void selectAttributeFromTheDropdown(String filterName, String option) throws Exception {
        clickonWebElementwithJavaScript(driver, getDropdownButtonOfFilters(filterName));
        waitForAngularLoad(driver);
        clickOn(driver, getAttributeInFilterDropDown(filterName, option));
        waitUntilJSReady(driver);
//        sleepForSec(3000);
        waitForAngularLoad(driver);
    }

    public void selectAttributesFromTheDropdown(String fieldName, String option) throws Exception {
        waitForAngularLoad(driver);
        moveToElement(driver, getDropdownButtonOfTheField(fieldName));
        clickonWebElementwithJavaScript(driver, getDropdownButtonOfTheField(fieldName));
        waitForAngularLoad(driver);
        scrolltoElement(driver, getAttributeInDropdown(fieldName, option), true);
        waitForAngularLoad(driver);
        moveToElement(driver, getAttributeInDropdown(fieldName, option));
        clickOn(driver, getAttributeInDropdown(fieldName, option));
        waitForAngularLoad(driver);

    }

    public void enterTextInAddOrUpdateConfigurationPage(String fieldName, String inputText) throws Exception {
        if (fieldName.equalsIgnoreCase("Credential Name")) {
            waitForAngularLoad(driver);
            enterText(getCredentialNameTextBox(), inputText);
            waitForAngularLoad(driver);
        }else if (fieldName.equalsIgnoreCase("Name")) {
            waitForAngularLoad(driver);
            enterText(getPipelinePluginNameTextBox(fieldName), inputText);
            waitForAngularLoad(driver);
        }else {
            clickOn(getTextBoxInAddOrUpdateConfiguration(fieldName));
            enterText(getTextBoxInAddOrUpdateConfiguration(fieldName), inputText);
            waitForAngularLoad(driver);
        }
    }

    public void enterTextInAddConfigurationPage(String fieldName, String inputText) throws Exception {
        if (fieldName.equalsIgnoreCase("Credential Name")) {
            waitForAngularLoad(driver);
            enterText(getCredentialNameTextBox(), inputText);
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("Data Source Name")) {
            waitForAngularLoad(driver);
            enterText(getDataSourceNameTextBox(), inputText);
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("Branch Name")) {
            waitForAngularLoad(driver);
            enterText(getBranchTextBox(), inputText);
            waitForAngularLoad(driver);
        } else if(fieldName.equalsIgnoreCase("Add Branch Name under Filters")){
            clickOn(driver,getBranchAddButton());
            waitForAngularLoad(driver);
            enterText(getBranchTextBox(), inputText);
            waitForAngularLoad(driver);
            clickAddButtonForEnteredFilter("FILTERS");
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("Tags")) {
            enterText(getAdvacedSettingTagsBox(), inputText);
        }else if (fieldName.equalsIgnoreCase("Enter tags")) {
            waitForAngularLoad(driver);
            enterText(getAddConfigurationsTags(), inputText);
            waitForAngularLoad(driver);
        }else if (fieldName.equalsIgnoreCase("Query Code")) {
            enterText(getQueryCodeTextBox(), inputText);
        }
        else{
            enterText(getTextBoxInManageDataSources(fieldName), inputText);
            waitForAngularLoad(driver);
        }
    }

    public void validateErrorMessageForTheFields(String fieldName, String validationMessage, String pageName) throws Exception {
        String actualText = getElementText(getFieldValidationMesssage(pageName, fieldName));
        Assert.assertEquals(validationMessage, actualText.trim());
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), fieldName + " validation message is displayed under the field");
    }

    public WebElement getPluginConfigurationToolTip(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(@class,'asg-dyn-form-property-label tooltip-indicator')][contains(.,'" + fieldName + "')]/../ngb-tooltip-window"));
    }

    public void getPluginConfigurationStatus(String deploymentName, String status) {
        String actualText = getAttributeValue(getDeploymentStatus(deploymentName), "src");
        verifyContains(actualText, status);
    }

    public void getPluginConfigurationStatusCount(String deploymentName, String status, String count) {
        String actualText = getElementText(getPluginCount(deploymentName, status));
        verifyContains(actualText, count);
    }

    public void verifyLogTextDispalyedRegardsToTime(String timeSelected) {
        int index = getFirstTimeStampInLogPage().size();
        String timestamp = "";
        if (timeSelected.equalsIgnoreCase("latest")) {
            timestamp = getFirstTimeStampInLogPage().get(0).getText().substring(0, 5);
            clickonWebElementwithJavaScript(driver, getFirstTimeStampInLogPage().get(0));
        } else if (timeSelected.equalsIgnoreCase("oldest")) {
            int indexCount = index - 3 ;
            timestamp = getFirstTimeStampInLogPage().get(indexCount).getText().substring(0, 5);
            clickonWebElementwithJavaScript(driver, getFirstTimeStampInLogPage().get(indexCount));
        }
        waitForAngularLoad(driver);
        Assert.assertTrue(getElementText(getLogViewer()).contains(timestamp));
    }

    public void enterPropertiesTextInAddConfigurationPage(String fieldName, String inputText) throws Exception {
        if (fieldName.equalsIgnoreCase("Name")) {
            waitForAngularLoad(driver);
            enterText(getPropertiesTextBoxInAddConfiguration(fieldName), inputText);
            waitForAngularLoad(driver);
        } else {
            waitForAngularLoad(driver);
            enterText(getTextBoxInAddOrUpdateConfiguration(fieldName), inputText);
            waitForAngularLoad(driver);
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
                for (WebElement label : isLabelsPresentInmanageConfig) {
                    actual.add(label.getText());
                }
                if (CommonUtil.compareLists(actual, expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Items displayed for Type Filter":
                for (WebElement Types : typesAttribute) {
                    if (data.contains(Types.getText()) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Items displayed for Deployment filter":
                for (WebElement Types : deploymentAttribute) {
                    String actualText = Types.getText().replaceAll("[0-9]", "").replace("(", "").replace(")", "").replaceAll(" ", "").replaceAll("\n", "");
                    actual.add(actualText);
                }
                for (String item : data) {
                    if (traverseListContainsString(actual, item) == true) {
                    } else {
                        throw new Exception();

                    }
                }
                break;
            case "Items displayed for Configuration Filter":
                for (WebElement Type : ConfigurationAttribute) {
                    if (Type.getText().equals(data.get(0))) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Items displayed for Catalog Filter":
                for (WebElement Types : CatalogAttribute) {
                    if (data.contains(Types.getText()) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Log Breadcrumbs":
                TreeMap<String, String> expectedValue = new TreeMap<>();
                TreeMap<String, String> actualValue = new TreeMap<>();
                for (int i = 0; i < data.size(); i++) {
                    expectedValue.put(String.valueOf(i), data.get(i));
                }
                for (int i = 0; i < breadcrumbListInLogView.size(); i++) {
                    actualValue.put(String.valueOf(i), breadcrumbListInLogView.get(i).getText());
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(),""+actualValue);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(),""+expectedValue);
                if (actualValue.equals(expectedValue)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Log text":
                for (String log : data) {
                    if (getLogViewer().getText().contains(log) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Text in Error tooltip":
                for (String error : data) {
                    if (getErrorInListFromToolTip().get(0).getText().toString().contains(error) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Popup message":
                for (String expValue : data) {
                    expected.add(expValue);
                }
                for (WebElement label : pluginCompletionPopUp) {
                    actual.add(label.getText());
                }
                if (CommonUtil.compareLists(actual, expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Colored border for selected date":
                for (String expValue : data) {
                    expected.add(expValue);
                }
                moveToElement(driver, getFirstTimeStampInLogPage().get(0));
                String actualBackgrounColor = getFirstTimeStampInLogPage().get(0).getCssValue("background-color");
                Assert.assertEquals(expected.get(0).toString(), actualBackgrounColor);
                break;
            case "Date is greyed when that date has log":
                clickonWebElementwithJavaScript(driver, getLogCalenderIcon());
                waitForAngularLoad(driver);
                String date = CommonUtil.getCurrentDay();
                String jd =getDayHasLog().getText();
                Assert.assertTrue(date.contains(getDayHasLog().getText().trim()));
                break;
            case "Advanced Setting Tags":
                for (String tags : data) {
                    if (traverseListContainsElementText(getTagsInAdvancedSettingsPanel(), tags) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Active Accordion":
                Assert.assertTrue(isElementPresent(getActiveAccordion(data.get(0))));
                flag = true;
                break;
        }

        return flag;
    }

    public boolean validateElementNotPresense(String actionType, List<String> data) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionType) {
            case "Log text":
                for (String log : data) {
                    if (getLogViewer().getText().toString().contains(log) == false) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Add Configuration Popup fields":
                for (String field : data) {
                    if (traverseListContainsElementText(isLabelsPresentInAddConfig, field) == false) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "BA Attribute of Type BULK":
            case "Advanced Setting Tags":
                for (String tags : data) {
                    if (traverseListContainsElementText(getTagsInAdvancedSettingsPanel(),tags) == false) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
        }

        return flag;
    }

    public boolean verifySortingOrder(String actionToBeVerified, List<String> data) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionToBeVerified) {
            case "Tags are in ascending order":
                enterText(new DashBoardPage(driver).getTagsTextbox(), "a");
                for (WebElement tags : tagsInAdvancedSettingsPanel) {
                    actual.add(tags.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
        }

        return flag;
    }

    public boolean isElementsPresentInList(List<String> listValues, String... elementType) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();
        switch (elementType[0]) {
            case "PluginConfiguration":
                for (String credentials : listValues) {

                    if (traverseListContainsElementText(getLabelsInManageConfigurations(), credentials) == true) {
                        flag = true;
                        takeScreenShot(this.getClass().getName() + " is captured", driver);
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Newly added item":
                for (String addedItem : listValues) {
                    if (traverseListContainsElementText(getAddedItem(elementType[1]), addedItem) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "verify duplicate item is added":
                try {
                    if (getAddedItem(elementType[1]).size() < 1) {
                        flag = false;
                        break;
                    } else {
                        throw new Exception();
                    }
                } catch (Exception e) {
                    flag = true;
                }
                break;
            case "Diagram Order":
                try {
                    for (String diagramOrder : listValues) {
                        expected.add(diagramOrder);
                    }
                    for (WebElement label : diagramOrder) {
                        actual.add(label.getText());
                    }
                    Assert.assertTrue(expected.equals(actual));
                    flag = true;
                } catch (Exception e) {
                    flag = false;
                }
                break;
        }
        return flag;
    }


    public boolean validateElementPresenseForPluginConfigurations(String action, String pluginName) throws Exception {
        boolean flag = false;
        switch (action) {
            case "Log":
                takeScreenShot(action + " is captured", driver);
                moveToElement(driver, getLogButtonForThePlugin(pluginName));
                verifyTrue(isElementPresent(getLogButtonForThePlugin(pluginName)));
                break;
            case "Clone":
                takeScreenShot(action + " is captured", driver);
                moveToElement(driver, getCloneButtonForThePlugin(pluginName));
                verifyTrue(isElementPresent(getCloneButtonForThePlugin(pluginName)));
                break;
            case "Edit":
                takeScreenShot(action + " is captured", driver);
                moveToElement(driver, getEditButtonForThePlugin(pluginName));
                verifyTrue(isElementPresent(getEditButtonForThePlugin(pluginName)));
                break;
            case "Delete":
                takeScreenShot(action + " is captured", driver);
                moveToElement(driver, getDeleteButtonForThePlugin(pluginName));
                verifyTrue(isElementPresent(getDeleteButtonForThePlugin(pluginName)));
                break;
            case "Start":
                takeScreenShot(action + " is captured", driver);
                moveToElement(driver, getStartButtonForThePlugin(pluginName));
                verifyTrue(isElementPresent(getStartButtonForThePlugin(pluginName)));
                break;
            case "Stop":
                takeScreenShot(action + " is captured", driver);
                moveToElement(driver, getStopButtonForThePlugin(pluginName));
                verifyTrue(isElementPresent(getStopButtonForThePlugin(pluginName)));
                break;
        }

        return flag;
    }

    public boolean isProjectItemsPresent(String actionType, List<String> data) throws Exception {
        boolean flag = false;
        switch (actionType) {
            case "Verify the projects are presence":
                try {
                    for (String expValue : data) {
                        isProjectItemsPresent(expValue);
                        flag = true;
                    }
                } catch (Exception e) {
                    throw new Exception(e.getMessage());
                }
        }
        return flag;
    }

    public WebElement isProjectItemsPresent(String fieldName) {
        return driver.findElement(By.xpath(("//div[contains(@class,'asg-search-list-item')]//div[contains(@class,'flex-grow-1 d-flex flex-wrap text-truncate')]/span[contains(text(),'" + fieldName + "')]")));
    }

    public void managePipelinePageValidations(String actionType, String actionItem, String ItemName, String Section) throws Exception {
        try {
            switch (actionType) {
                case "Expand accordion and click on menu option":
                    clickExpandPipelineButton(actionItem);
                    waitForAngularLoad(driver);
                    clickOn(driver, getMenuButtonForThePlugin(actionItem, ItemName));
                    waitForAngularLoad(driver);
                    break;
                case "Expand accordion":
                    clickExpandPipelineButton(actionItem);
                    waitForAngularLoad(driver);
                    break;
                case "click on menu option":
                    clickOn(driver, getMenuButtonForThePlugin(actionItem, ItemName));
                    waitForAngularLoad(driver);
                    break;
                case "Pipeline Accordion":
                    if (actionItem.equalsIgnoreCase("Expand Accordion")) {
                        clickOn(getPipelineAccordion(ItemName).get(0));
                    } else if (actionItem.equalsIgnoreCase("Verify Pipeline Accordion")) {
                        Assert.assertTrue(isElementPresent(getPipelineAccordion(ItemName).get(0)));
                    } else if (actionItem.equalsIgnoreCase("Verify Header Menu options")) {
                        String[] headerIcons = ItemName.split(",");
                        if (ItemName.contains(",")) {
                            for (String icon : headerIcons) {
                                Assert.assertTrue(isElementPresent(getMenuButtonForThePlugin(Section, icon)));
                            }
                        } else {
                            Assert.assertTrue(isElementPresent(getMenuButtonForThePlugin(Section, ItemName)));
                        }
                    } else if (actionItem.equalsIgnoreCase("Click Header Menu options")) {
                        clickOn(getMenuButtonForThePlugin(Section, ItemName));
                        waitForAngularLoad(driver);
                        break;
                    }else if (actionItem.equalsIgnoreCase("Inline Error Message")) {
                        Assert.assertTrue(isElementPresent(GetInlineErrorMessage(ItemName)));
                            waitForAngularLoad(driver);
                            break;
                    } else if (actionItem.equalsIgnoreCase("Verify Field Details")) {
                        String value = getElementText(getFieldValuesInPipelineAccordion(Section));
                        if (Section.equalsIgnoreCase("Last execution")) {
                            String currentDate = CommonUtil.getCurrentDateFormatted();
                            Assert.assertTrue(value.contains(currentDate));
                        } else {
                            Assert.assertEquals(value,ItemName);
                        }
                        break;
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Verify Diagram Configuration Values":
                    if (actionItem.equalsIgnoreCase("Status")) {
                        sleepForSec(2000);
                        Assert.assertTrue(getDiagramStatus(Section).getAttribute("src").contains(ItemName));
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Diagram Configuration":
                    if(actionItem.equalsIgnoreCase("Click diagram menu")){
                        clickOn(getDiagramMenuOption(Section,ItemName));
                        sleepForSec(1000);
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Plugin Accordion":
                    if(actionItem.equalsIgnoreCase("Plugin Error Message")){
                        Assert.assertTrue(isElementPresent(GetDeleteErrorMessage(ItemName)));
                    }

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DashBoard Validation is not performed");
            Assert.fail(e.getMessage());
        }
    }

    public void pipelineConfiguratorPageValidations(String actionType, String actionItem, String ItemName, String Section) throws Exception {
        try {
            switch (actionType) {
                case "Expand Accordion and Select Plugin Type":
                    clickPluginTypeExpandButton(actionItem);
                    waitForAngularLoad(driver);
                    if (ItemName.equalsIgnoreCase("New Configurations")) {
                        clickNewConfigPluginTypeTab();
                        clickPluginInNewConfiguration(Section);
                    } else {
                        clickPluginInExistingConfiguration(Section);
                    }
                    waitForAngularLoad(driver);
                    clickPluginTypeExpandButton(actionItem);
                    break;
                case "Click":
                    if (actionItem.equalsIgnoreCase("Save")) {
                        clickOn(getAddConfigSaveButton());
                        waitForAngularLoad(driver);
                        break;
                    } else {
                        throw new Exception();
                    }
                case "Enter Text":
                    if (actionItem.equalsIgnoreCase("Pipeline Name")) {
                        enterText(getPipelineNametextbox(), ItemName);
                        waitForAngularLoad(driver);
                        break;
                    } else if (actionItem.equalsIgnoreCase("Pipeline Description")){
                        enterText(getPipelineDesctextbox(), ItemName);
                        waitForAngularLoad(driver);
                        break;
                    }else {
                        throw new Exception();
                    }
                case "Drag and Drop Diagram":
                    String[] dragItem =actionItem.split(",");
                    String[] dropItem =ItemName.split(",");
                    scrolltoElement(driver, getDiagram(dragItem[0],dragItem[1]), true);
                    dragAndDropElementUsingJavaScript(driver, getDiagram(dragItem[0], dragItem[1]), getDiagram(dropItem[0], dropItem[1]));
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DashBoard Validation is not performed");
            Assert.fail(e.getMessage());
        }
    }
}