package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;


@SuppressWarnings("DefaultFileTemplate")
public class ItemViewManagement extends UIWrapper {

    private WebDriver driver;

    public ItemViewManagement(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intializing Dashboard PageFactory Class");
    }

    @FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'ITEM AND LIST VIEW MANAGER')]")
    private WebElement itemViewManagement;

    @FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'BUNDLE MANAGER')]")
    private WebElement bundleManager;


    @FindBy(xpath = "//button[@class='btn btn-default asg-item-view-management-top-btns']//span[contains(.,'Create')]")
    private WebElement itemViewCreateButton;

    @FindBy(css = "input#pluginName")
    private WebElement itemViewName;

    @FindBy(css = "input#definition")
    private WebElement itemViewDefinition;

    @FindBy(css = ".dropdown-toggle.form-control.clearfix")
    private WebElement itemViewSupportedTypes;

    @FindBy(xpath = "//label[contains(.,'CATALOGS')]/following::button[1]/span/em")
    private WebElement catalogSelectionDropDownButton;

    //@FindBy(css=".dropdown-menu")
    @FindBy(xpath = "//ul[@class='dropdown-menu']/li/a")
    //@FindBy(xpath="//div[@class='input-group asg-advanced-select-input']/typeahead-container/ul")
    private List<WebElement> listOfSupportedTypes;

    //@FindBy(css=".pull-right.btn.btn-default")
    @FindBy(xpath = "//div[@class='asg-dyn-form-advanced-select-item-container clearfix']")
    private WebElement supportedTypeAddButton;

    //@FindBy(xpath = "//span[@class[contains(.,'input-group-btn')]]//button[contains(text(),'Add')]")
    @FindBy(xpath = "//button[@class='dropdown-item active'][1]")
    private WebElement supportedTypeAdd;

    @FindBy(css = "input[type='number']")
    private WebElement enterPageSize;

    @FindBy(xpath = "//*[@class='dropdown open']//ul[@class='dropdown-menu']//li/a[@href]")
    private List<WebElement> supportedTypeList;

    @FindBy(xpath = "//div[@class='asg-edit-item-view-config-save']/button[contains(.,'SAVE')]")
    private WebElement newItemViewSaveButton;

    @FindBy(xpath = "//span[contains(text(),'WIDGETS')]/following::table/tbody/tr/td")
    private List<WebElement> widgetList;

    @FindBy(xpath = "//p[contains(text(),'SUPPORTEDTYPES')]/following::table/tbody/tr/td")
    private List<WebElement> tabsList;

    @FindBy(xpath = "//div[@class='asg-item-view-management-container']//a[contains(.,'ITEM VIEWS')]//following::table/tbody/tr/td[1]")
    private List<WebElement> newItemList;

    @FindBy(xpath = "//span[contains(.,'Delete')]/parent::button[@class[contains(.,'btn btn-default asg-edit-item-view-config-top-btns')]]")
    private WebElement deleteButtonItemViewPanel;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::button[@class='exit-btn']")
    private WebElement itemViewExitButton;

    @FindBy(xpath = "//div[@class='asg-panels-item-caption clearfix scrollable']/div[@title='VISUAL COMPOSER']//following::button[@class='exit-btn'][1]")
    private WebElement itemFullViewExitButton;

    @FindBy(xpath = "//button[contains(text(),'Yes')]")
    private WebElement itemViewAlertYes;

    @FindBy(xpath = "//button[contains(text(),'No')]")
    private WebElement itemViewAlertNo;

    @FindBy(css = "div[class='modal-header']>em")
    private WebElement itemViewAlertHeader;

    @FindBy(css = ".modal-body>div>span")
    private WebElement itemViewAlertContent;

    @FindBy(css = "button[class='form-control clearfix asg-multi-select-dropdown-button'] > span >i")
    private WebElement itemViewCatalogButton;

    @FindBy(css = "ul[class='dropdown-menu show']>li>a")
    private List<WebElement> itemViewCatalogList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::span[@class='fa fa-desktop']/..")
    private WebElement visualComposerButton;

    @FindBy(css = "a.add-new-tab.tab-link")
    private WebElement newTabPlusSignButton;

    @FindBy(xpath = "//li[@class[contains(.,'dashboard-new-widget')]]")
    private List<WebElement> widgetListFromVisualComposer;

    // @FindBy(xpath = "//div/span[@class='fa fa-angle-right']")
    @FindBy(xpath = "//div[@class[contains(.,'scroll right-scroll')]]/span[@class[contains(.,'fa fa-angle-right')]]")
    private WebElement rightArrowList;

    @FindBy(xpath = "//div[@class='input-group']/input")
    private WebElement searchInputBoxFromVisualComposerPage;

    @FindBy(xpath = "//li[@class='float-right asg-item-view-builder-warning']/div")
    private WebElement warningMessage;

    @FindBy(xpath = "//li[@class='asg-item-view-builder-apply-button']/button[contains(.,'PREVIEW')]")
    private WebElement previewButton;

    @FindBy(xpath = "//li[@class='asg-item-view-builder-apply-button']/button[contains(.,'APPLY')]")
    private WebElement applyButton;

    @FindBy(xpath = "//li[@class='asg-item-view-builder-apply-button']/button[contains(.,'APPLY')]")
    //@FindBy(xpath = "//div[@class='asg-panels-item-dynamic']//following::button[contains(.,'APPLY')]")
    private WebElement ItemViewapplyButton;

    @FindBy(xpath = "//div[@class='input-group asg-advanced-select-input']/input")
    private WebElement supportedTypesInputbox;

    @FindBy(xpath = "//div[@class[contains(.,'asg-edit-item-view-config-main-content')]]//following::span[@class[contains(.,'fa fa-info-circle asg-dyn-form-property-label-info')]]")
    private WebElement supportedTypeHoverText;

    @FindBy(xpath = "//label[@class='asg-dyn-form-property-label']//strong[contains(text(),'ATTRIBUTES')]//following::div[@class='input-group asg-advanced-select-input']/input")
    private WebElement attributeInputBox;

    @FindBy(xpath = "//strong[contains(text(),'ATTRIBUTES')]//following::div/span/button")
    private WebElement attributeInputBoxAdd;

    @FindBy(xpath = "//strong[contains(.,'ATTRIBUTE TYPES')]//following::button[@class='form-control clearfix hide-default-toggle asg-multi-select-dropdown-button dropdown-toggle'][1]")
    private WebElement attributeInputDropDown;

    @FindBy(xpath = "//div[@title='ATTRIBUTEFILTER']//following::div[@class='input-group asg-advanced-select-input']//input")
    private WebElement attributeTypeInputbox;

    @FindBy(xpath = "//li[@role='menuitem']/a[@class='text-truncate']")
    private List<WebElement> attributeTypeAdd;

    @FindBy(xpath = "//a[@class='dropdown-item text-truncate']//following::span[contains(.,'string')]")
    private WebElement firstSuggestion;

    @FindBy(xpath = "//button[@class='asg-iv-builder-widget-invalid']")
    private WebElement widgetAlert;

    @FindBy(xpath = "//button/i[@class='fa fa-pencil']")
    private WebElement widgetNoAlert;

    @FindBy(xpath = "//div[@class='alert alert-danger']")
    private List<WebElement> alertinWidgetConfig;

    @FindBy(xpath = "//div[@class='modal-dialog']//div[@class='modal-body']//span")
    private WebElement modalAlertInWidgetConfig;


    @FindBy(xpath = "//ul[@class='dropdown-menu show']/li[@role='menuitem']/a/span")
    private List<WebElement> attributeList;

    //@FindBy(css = "button[class='form-control asg-dynamic-form-select-drop-down-btn asg-invalid-form-element']>span>i")
    @FindBy(xpath = "//strong[contains(.,'ATTRIBUTE NAME')]//following::em[@class='fa fa-chevron-down'][1]")
    private WebElement attributeName;

    @FindBy(xpath = "//strong[contains(.,'ATTRIBUTEFILTER')]//following::em[@class='fa fa-chevron-down'][1]")
    private WebElement attributeFilter;

    @FindBy(xpath = "//label[contains(.,'ATTRIBUTEFILTER')]//following::button[@class='dropdown-toggle form-control clearfix'][1]")
    private WebElement attributFiltereName;

    @FindBy(css = "div[class='form-group ng-untouched ng-pristine ng-valid']")
    private WebElement multiWidgetAttributeName;

    @FindBy(xpath = "//strong[contains(text(),'DIRECTION')]//following::button[@class='dropdown-toggle form-control clearfix'][1]")
    private WebElement direction;

    @FindBy(xpath = "//strong[contains(.,'LABEL')]//following::input[1]")
    private WebElement labelName;

    @FindBy(xpath = "//div[@class[contains(.,'asg-plugin-label-property')]]//following::input[1]")
    private WebElement gremLabelName;


    //@FindBy(xpath = "//div[@class='asg-panels-item-caption-ellipsis']//following::button[@class='form-control asg-dynamic-form-select-drop-down-btn'][2]")
    //@FindBy(css = "button[class='form-control asg-dynamic-form-select-drop-down-btn']>span>i")
    @FindBy(xpath = "//strong[contains(.,'TYPE')]//following::div[@class='btn-group asg-dynamic-form-select-drop-down dropdown'][2]/button/span/em")
    private WebElement type;

    @FindBy(xpath = "//li[@class='dashboard-widget-wraper']")
    private WebElement emptyDashBoard;

    @FindBy(css = "td.asg-item-views-table-name-cell")
    private List<WebElement> itemviewList;

    @FindBy(css = "div[class='content-table asg-item-views-table']>table>tbody>tr>td:nth-child(1)")
    private List<WebElement> itemviewListFirefox;

    @FindBy(xpath = "//div[@class='btn-group widget-menu']/button")
    private WebElement widgetSizeMenu;

    @FindBy(xpath = "//div[@class='builder-item']//p[contains(.,'DATASAMPLING')]")
    private WebElement dataSamplingContainer;

    @FindBy(xpath = "//div[@class='builder-item']//p[contains(.,'RATING')]")
    private WebElement ratingContainer;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//div[@class='buttons-panel']/button")
    private WebElement visualComposer_DeleteButton;

    @FindBy(xpath = "//ul[@class='nav nav-tabs item-view-builder-tabs-panel']/li/a[@class='tab-link remove']//span[1]")
    private WebElement dashboard_deleteButtonOnItemView;

    @FindBy(xpath = "//div[@class='alert alert-danger asg-dashboard-alert']")
    private WebElement dashboardAlert;

    @FindBy(xpath = "//div[@class='input-group dashboard-name']/input")
    private WebElement dashboardName;

    @FindBy(xpath = "//ul/li[@role='menuitem']")
    private List<WebElement> catalogListFromItemView;

    @FindBy(xpath = "//label[@class='asg-dyn-form-property-label']//strong[contains(text(),'CATALOGS')]//following::ul//li//div[@class='asg-dyn-form-multi-select-filter']//input")
    private WebElement catalogDropDownInput;

    @FindBy(xpath = "//li[@role='presentation']/a")
    private List<WebElement> itemViewDashboardList;

    @FindBy(xpath = "//label[@class='asg-dyn-form-property-label']/b[contains(text(),'fieldName')]//following::div[@class='alert alert-danger'][1]")
    private WebElement attributeWidgetFieldAlerts;

    @FindBy(xpath = "//div[@class='content item-view full-size']//div/input")
//    @FindBy(xpath = "//div[@class='content item-view full-size']//textarea")
    private WebElement ratingSingletonLabelValue;

    @FindBy(xpath = "//div[@class='content item-view full-size']//textarea")
    private WebElement stringRatingSingletonLabelValue;

    @FindBy(xpath = "//div[@class='content item-view full-size']//span")
    private WebElement ratingSingletonJsonLabelValue;

    @FindBy(xpath = "//div[@class='content item-view full-size']//div//pre")
    private WebElement ratingSingletonLabelBinaryValue;


    //    @FindBy(xpath = "//div[@class='asg-child-configuration-save']//button[@class='btn btn-default'][@type='submit']")
    @FindBy(xpath = "//div[@class='asg-child-configuration-save']/button[contains(.,'APPLY')]")
    private WebElement attributeWidgetSave;

    @FindBy(css = "p[class='asg-item-view-table-widget-title']")
    private List<WebElement> itemPreviewValue;

    @FindBy(xpath = "//div[@class='item'][1]")
    private WebElement itemHolder;

    @FindBy(css = "th.tbl-header")
    private List<WebElement> itemPreviewTableHeaders;

    @FindBy(xpath = "//table[@class='table table-hover asg-dyn-form-widget-table']//tbody/tr/td")
    private List<WebElement> itemHeadersList;

    @FindBy(xpath = "//div[@title='TABLE HEADER']//following::button//span[contains(.,'Delete')]")
    private WebElement deleteHeader;

    @FindBy(css = "div[class='asg-bundle-list']>div>span:nth-of-type(1)")
    private List<WebElement> bundlePluginList;

    @FindBy(css = "table[class='table table-hover']>tbody>tr>td:nth-of-type(1)")
    private List<WebElement> bundleVersionCount;

    @FindBy(xpath = "//div[@title='BUNDLE DETAILS']//following::button[@class='exit-btn'][1]")
    private WebElement bundleDetailsCloseButton;

    @FindBy(css = "button[class='btn btn-default']>span:nth-of-type(1)")
    private WebElement bundleDetailsDelete;


    @FindBy(css = "div[class='asg-bundle-types-list-content']>div>div>div")
    private List<WebElement> bundleTypeList;

    //@FindBy(css = "div[class='asg-dyn-form-table-add-cataloger-bth']")
    @FindBy(xpath = "//div//div/label/strong[contains(text(),'FILTERS')]/following::div[contains(text(),'+Add')]")
    private WebElement addFilterBtnMutlipleAttribute;

    //  @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//following::button[contains(text(),'APPLY')]")
    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//div[@class='data-content']//button[contains(text(),'APPLY')]")
    private WebElement applyBtnMutlipleAttributeFilter;


    @FindBy(css = "div[class='actions-bar']>button>span:nth-of-type(1)")
    private WebElement bundleUploadButton;

    @FindBy(css = "span[class='btn btn-default btn-file asg-bundle-upload-btn']")
    private WebElement bundleuploadBrowse;

    public WebElement GetBundleUploadBrowseButton() {
        return bundleuploadBrowse;
    }

    @FindBy(css = "div[class='submit']>button[type='submit']")
    private WebElement bundleUploadSubmit;


    @FindBy(xpath = "//div[@title='TABLE HEADER']//following::strong[contains(text(),'ATTRIBUTE NAME')]//following::input[1]")
    private WebElement tableHeaderAttribute;

    @FindBy(xpath = "//div[@title='TABLE HEADER']//following::div[@class='asg-child-configuration-save']//button")
    private WebElement tableHeaderApply;

    @FindBy(xpath = "//div[@title='ATTRIBUTEFILTER']//following::div[@class='asg-child-configuration-save']//button")
    private WebElement attributeFilterApply;


    @FindBy(xpath = "//div/label/strong[contains(text(),'HIDDEN')]/following::ui-switch/span/small")
    private WebElement tableHeaderHiddenCheckbox;

    @FindBy(css = "div[class='asg-item-view-multi-properties-widget']>ul>li>span:nth-of-type(1)")
    private List<WebElement> previewAttributeTableList;


    @FindBy(xpath = "//strong[contains(.,'QUERY NAME')]//following::input[1]")
    private WebElement storedQueryName;


    @FindBy(xpath = "//div[@title='TABLE HEADER']//following::button[@class='exit-btn'][1]")
    private WebElement tableHeaderCloseButton;


    //@FindBy(xpath = "//div[@class='asg-child-configuration-main-content']//div[6]//span[@title]")
    @FindBy(xpath = "//strong[contains(.,'PAGE SIZE')]//following::span[1]")
    private WebElement widgetPageSize;

    @FindBy(xpath = "//strong[contains(.,'PAGE SIZE')]//following::ngb-tooltip-window[1]")
    private WebElement widgetPageSizeHoverText;

    @FindBy(xpath = "//div[@class='asg-child-configuration-main-content']//div[4]//span[@title]")
    private WebElement widgetType;

    @FindBy(css = "div[class='alert-danger']")
    private WebElement visualComposerAlertMessage;

    @FindBy(xpath = "//strong[contains(.,'QUERY TEXT')]//following::input[1]")
    private WebElement gremlinQueryText;

    @FindBy(css = "div.asg-panels-item:nth-child(4) > div:nth-child(1) > div:nth-child(1) > button:nth-child(2) > i")
    private WebElement previewExitButton;

    @FindBy(css = "a.tab-link:nth-child(2) > span:nth-child(2)")
    private WebElement setAsPreviewButton;

    @FindBy(css = "p[class='name-and-type']>b:nth-child(1)")
    private WebElement previewLabel;

    @FindBy(css = "div[class='dashboard-widget item-view-builder_01']")
    private WebElement secondWidgetTitle;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::button[contains(.,'APPLY')]")
    private WebElement widgetPanelApplyButton;

    @FindBy(xpath = "//div[@class='asg-item-view-management-container']//following::td[@class='asg-item-views-table-name-cell'][1]//following::em[@class='fa fa-code-fork'][1]")
    private WebElement forkIcon;

    @FindBy(css = "div[class='btn-group widget-menu']")
    private WebElement resizeMenu;

    @FindBy(xpath = "//li[@role='menuitem']/a[contains(.,'Remove')]")
    private WebElement removeButton;

    @FindBy(xpath = "//div[@class='btn-group widget-menu dropdown']/button")
    private WebElement widgetSideMenu;

    public WebElement returnItemViewManagement() {
        // synchronizationVisibilityofElement(driver, itemViewManagement);
        scrollToWebElement(driver, itemViewManagement);
        return itemViewManagement;
    }

    public WebElement returnbundleManager() {
        scrollToWebElement(driver, bundleManager);
        return bundleManager;
    }

    public void click_ItemViewCreateButton() {

        synchronizationVisibilityofElement(driver, itemViewCreateButton);
        clickonWebElementwithJavaScript(driver, itemViewCreateButton);
    }

    public WebElement returnnewItemViewName() {
        synchronizationVisibilityofElement(driver, itemViewName);
        return itemViewName;
    }
    public WebElement returnItemViewtable() {
        synchronizationVisibilityofElement(driver, itemViewName);
        return itemViewName;
    }

    public WebElement returnitemViewDefinition() {
        synchronizationVisibilityofElement(driver, itemViewDefinition);
        return itemViewDefinition;
    }

    public WebElement returnitemViewSupportedTypes() {
        synchronizationVisibilityofElement(driver, itemViewSupportedTypes);
        return itemViewSupportedTypes;
    }


    public WebElement click_NewItemViewSaveButton() {

        synchronizationVisibilityofElement(driver, newItemViewSaveButton);
        return newItemViewSaveButton;
    }

    public List<WebElement> returnListOfWidgets() {
        synchronizationVisibilityofElementsList(driver, widgetList);
        return widgetList;

    }

    public List<WebElement> returnListOfTabs() {
        synchronizationVisibilityofElementsList(driver, tabsList);
        return tabsList;

    }

    public List<WebElement> returnListOfItemViews() {
        synchronizationVisibilityofElementsList(driver, newItemList);
        return newItemList;

    }

    public void click_deleteButtonOnItemView() {
        clickOn(deleteButtonItemViewPanel);
    }


    public void click_SupportedTypeDropDown() {

        synchronizationVisibilityofElement(driver, itemViewSupportedTypes);
        clickOn(itemViewSupportedTypes);
    }

    public List<WebElement> returnListOfSupportedTypes() {
        synchronizationVisibilityofElementsList(driver, listOfSupportedTypes);
        return listOfSupportedTypes;
    }

    public void click_SupportedTypeAddButton() {

        synchronizationVisibilityofElement(driver, supportedTypeAddButton);
        clickOn(supportedTypeAddButton);
    }

    public void click_SupportedTypeAddButtonClick() {

        synchronizationVisibilityofElement(driver, supportedTypeAdd);
        clickonWebElementwithJavaScript(driver,supportedTypeAdd);
    }

    public void enter_PageSize(String pageSize) {
        scrollToWebElement(driver, enterPageSize);
        textClear(enterPageSize);
        enterText(enterPageSize, pageSize);
    }

    public void click_itemViewExitButton() {

        synchronizationVisibilityofElement(driver, itemViewExitButton);
        clickonWebElementwithJavaScript(driver, itemViewExitButton);
    }

    public void click_itemFullViewExitButton() {

        synchronizationVisibilityofElement(driver, itemFullViewExitButton);
        clickonWebElementwithJavaScript(driver, itemFullViewExitButton);
    }

    public WebElement itemViewAlertHeader() {

        synchronizationVisibilityofElement(driver, itemViewAlertHeader);
        return itemViewAlertHeader;
    }

    public WebElement itemViewAlertYes() {

        synchronizationVisibilityofElement(driver, itemViewAlertYes);
        return itemViewAlertYes;
    }

    public WebElement itemViewAlertNo() {

        synchronizationVisibilityofElement(driver, itemViewAlertNo);
        return itemViewAlertNo;
    }

    public WebElement itemViewAlertContent() {

        synchronizationVisibilityofElement(driver, itemViewAlertContent);
        return itemViewAlertContent;
    }

    public void click_itemViewCatalogButton() {

        synchronizationVisibilityofElement(driver, itemViewCatalogButton);
        clickOn(itemViewCatalogButton);
    }

    public List<WebElement> returnListOfCatalogs() {
        synchronizationVisibilityofElementsList(driver, itemViewCatalogList);
        return itemViewCatalogList;
    }

    public WebElement returnvisualComposerButton() {
        synchronizationVisibilityofElement(driver, visualComposerButton);
        return visualComposerButton;
    }

    public void click_newTabAddButtonInVisualCOmposer() {
        synchronizationVisibilityofElement(driver, newTabPlusSignButton);
        scrollToWebElement(driver, newTabPlusSignButton);
        clickOn(new ItemViewManagement(driver).newTabPlusSignButton);
    }

    public Set<String> widgetListFromVisualComposer() {

        Set<String> setWidget = new HashSet<>();
        for (WebElement element : widgetListFromVisualComposer) {
            setWidget.add(element.getText());
            if (isElementPresent(rightArrowList)) {
                clickOn(rightArrowList);
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "End of the list");
            }
        }

        for (WebElement element : widgetListFromVisualComposer) {
            setWidget.add(element.getText());
        }
        return setWidget;
    }

    public Set<WebElement> widgetElementtsFromVisualComposer() {

        Set<WebElement> setWidget = new HashSet<>();
        for (WebElement element : widgetListFromVisualComposer) {
            setWidget.add(element);
            if (isElementPresent(rightArrowList))
                clickOn(rightArrowList);
        }

        for (WebElement element : widgetListFromVisualComposer) {
            setWidget.add(element);
        }
        System.out.println(setWidget.size());
        return setWidget;
    }

    public WebElement returnsearchInputBoxFromVisualComposerPage() {
        synchronizationVisibilityofElement(driver, searchInputBoxFromVisualComposerPage);
        return searchInputBoxFromVisualComposerPage;
    }

    public WebElement returnwarningMessage() {
        synchronizationVisibilityofElement(driver, warningMessage);
        return warningMessage;
    }

    public WebElement returnPreviewButton() {
        synchronizationVisibilityofElement(driver, previewButton);
        return previewButton;
    }

    public WebElement returnApplyButton() {
        return applyButton;
    }

    public WebElement getApplyButtonInWidgetPanel() {
        synchronizationVisibilityofElement(driver, widgetPanelApplyButton);
        return widgetPanelApplyButton;
    }

    public WebElement returnsupportedTypesInputbox() {
        synchronizationVisibilityofElement(driver, supportedTypesInputbox);
        return supportedTypesInputbox;
    }

    public WebElement returnAttributeTypesInputbox() {
        synchronizationVisibilityofElement(driver, attributeTypeInputbox);
        return attributeTypeInputbox;
    }

    public void clickAttributeDropDown() {
        synchronizationVisibilityofElement(driver, attributeInputDropDown);
        clickOn(attributeInputDropDown);
    }

    public WebElement returnsupportedTypeAddButton() {
        synchronizationVisibilityofElement(driver, supportedTypeAddButton);
        return supportedTypeAddButton;
    }

    public List<WebElement> returnAttributeTypeAddButton() {
        synchronizationVisibilityofElementsList(driver, attributeTypeAdd);
        return attributeTypeAdd;
    }


    public WebElement returnAttributeNameInputbox() {
        synchronizationVisibilityofElement(driver, attributeInputBox);
        return attributeInputBox;
    }


    public WebElement returnAttributeInputAddButton() {
        synchronizationVisibilityofElement(driver, attributeInputBoxAdd);
        return attributeInputBoxAdd;
    }


    public List<WebElement> returnsupportedTypeValues() {
        synchronizationVisibilityofElementsList(driver, supportedTypeList);
        return supportedTypeList;
    }

    public WebElement returnwidgetAlert() {
        synchronizationVisibilityofElement(driver, widgetAlert);
        return widgetAlert;
    }

    public List<WebElement> returnalertinWidgetConfig() {
        return alertinWidgetConfig;
    }

    public WebElement returnModalalertinWidgetConfig() {
        return modalAlertInWidgetConfig;
    }

    public Boolean VerifyRemovedAttributes() {
        //Boolean bool = Boolean.parseBoolean(itemHolder.getText().trim());
        Boolean bool = Boolean.parseBoolean(driver.findElement(By.cssSelector("th.tbl-header")).getText().trim());
        return bool;
    }

    public List<WebElement> getItemPreviewValue() {
        synchronizationVisibilityofElementsList(driver, itemPreviewValue);
        return itemPreviewValue;
    }

    public List<WebElement> getItemPreviewTableValue() {
        synchronizationVisibilityofElementsList(driver, itemPreviewTableHeaders);
        return itemPreviewTableHeaders;
    }


    public List<WebElement> getWidgetHeadersList() {
        synchronizationVisibilityofElementsList(driver, itemHeadersList);
        return itemHeadersList;
    }

    public WebElement deleteHeader() {
        synchronizationVisibilityofElement(driver, deleteHeader);
        return deleteHeader;
    }

    public List<WebElement> returnAtrributeValueasList() {
        return attributeList;
    }

    public List<WebElement> getwidgetListFromVisualComposer() {
        return widgetListFromVisualComposer;
    }

    public WebElement getattributeName() {
        synchronizationVisibilityofElement(driver, attributeName);
        return attributeName;
    }

    public WebElement getAttributeFilter() {
        synchronizationVisibilityofElement(driver, attributeFilter);
        return attributeFilter;
    }

    public WebElement getMultiWidgetAttributeName() {
        synchronizationVisibilityofElement(driver, multiWidgetAttributeName);
        return multiWidgetAttributeName;
    }

    public WebElement getLinkWidgetFields(String fieldLabel) {
        return driver.findElement(By.xpath("//strong[contains(text(),'" + fieldLabel + "')]//following::div//span[@class='asg-dynamic-form-select-drop-down-icon float-right'][1]"));
    }

    public WebElement getLabelName() {
        scrollToWebElement(driver, labelName);
        return labelName;
    }

    public WebElement enterTableHeaderAttribute() {
        synchronizationVisibilityofElement(driver, tableHeaderAttribute);
        return tableHeaderAttribute;
    }

    public void enableTableHeaderHidden() {
        synchronizationVisibilityofElement(driver, tableHeaderHiddenCheckbox);
        sleepForSec(1000);
        clickonWebElementwithJavaScript(driver, tableHeaderHiddenCheckbox);
    }

    public void clickTableHeaderApply() {
        synchronizationVisibilityofElement(driver, tableHeaderApply);
        clickOn(tableHeaderApply);
    }

    public void clickAttributeFilterApply() {
        synchronizationVisibilityofElement(driver, attributeFilterApply);
        clickOn(attributeFilterApply);
    }


    public WebElement gremLinLabel() {
        synchronizationVisibilityofElement(driver, gremLabelName);
        return gremLabelName;
    }

    public WebElement getType() {
        synchronizationVisibilityofElement(driver, type);
        return type;
    }


    public WebElement getwidgetNoAlert() {
        synchronizationVisibilityofElement(driver, widgetNoAlert);
        return widgetNoAlert;
    }

    public WebElement getemptyDashBoard() {
        synchronizationVisibilityofElement(driver, emptyDashBoard);
        return emptyDashBoard;
    }

    public List<WebElement> getItemViewList() {
        return itemviewList;
    }

    public List<WebElement> getItemViewListFirefox() {
        return itemviewListFirefox;
    }

    public WebElement getwidgetSizeMenu() {
        synchronizationVisibilityofElement(driver, widgetSizeMenu);
        return widgetSizeMenu;
    }

    public WebElement getDataSamplingContainer() {
        synchronizationVisibilityofElement(driver, dataSamplingContainer);
        return dataSamplingContainer;
    }

    public WebElement getRatingContainer() {
        synchronizationVisibilityofElement(driver, ratingContainer);
        return ratingContainer;
    }

    public void click_deleteButton() {
        synchronizationVisibilityofElement(driver, visualComposer_DeleteButton);
        clickOn(visualComposer_DeleteButton);
    }

    public void click_dashboardDeleteonItemViewComposer() {
        synchronizationVisibilityofElement(driver, dashboard_deleteButtonOnItemView);
        clickOn(dashboard_deleteButtonOnItemView);
    }

    public WebElement returnDashboardAlert() {
        synchronizationVisibilityofElement(driver, dashboardAlert);
        return dashboardAlert;
    }

    public WebElement returndashboardName() {
        synchronizationVisibilityofElement(driver, dashboardName);
        return dashboardName;
    }

    public WebElement returncatalogSelectionDropDownButton() {
        synchronizationVisibilityofElement(driver, catalogSelectionDropDownButton);
        return catalogSelectionDropDownButton;
    }

    public List<WebElement> returncatalogListFromItemView() {
        return catalogListFromItemView;
    }

    public WebElement getCatalogDropDownInput() {
        return catalogDropDownInput;
    }

    public List<WebElement> returnitemViewDashboardList() {
        return itemViewDashboardList;
    }

    public WebElement getrightArrowList() {
        synchronizationVisibilityofElement(driver, rightArrowList);
        return rightArrowList;
    }

    public String getRatingSingletonLabelValue() {
        synchronizationVisibilityofElement(driver, ratingSingletonLabelValue);
        return ratingSingletonLabelValue.getAttribute("value");
    }

    public String getStringRatingSingletonLabelValue() {
        synchronizationVisibilityofElement(driver, stringRatingSingletonLabelValue);
        return stringRatingSingletonLabelValue.getAttribute("value");
    }


    public String getJsonRatingSingletonLabelValue() {
        synchronizationVisibilityofElement(driver, ratingSingletonJsonLabelValue);
        return ratingSingletonJsonLabelValue.getText();
    }


    public String getRatingSingletonBinaryLabelValue() {
        synchronizationVisibilityofElement(driver, ratingSingletonLabelBinaryValue);
        return ratingSingletonLabelBinaryValue.getText();
    }

    public void getAttributeWidgetSave() {
        scrollToWebElement(driver, attributeWidgetSave);
        clickOn(attributeWidgetSave);
    }

    public void click_addFilterBtnMutlipleAttribute() {
        synchronizationVisibilityofElement(driver, addFilterBtnMutlipleAttribute);
        clickonWebElementwithJavaScript(driver, addFilterBtnMutlipleAttribute);
    }


    public WebElement getApplyBtnMutlipleAttributeFilter() {
        synchronizationVisibilityofElement(driver, applyBtnMutlipleAttributeFilter);
        return applyBtnMutlipleAttributeFilter;
    }

    public WebElement clickBundleUpload() {
        synchronizationVisibilityofElement(driver, bundleUploadButton);
        return bundleUploadButton;
    }

    public WebElement clickBundleUploadBrowse() {
        synchronizationVisibilityofElement(driver, bundleuploadBrowse);
        return bundleuploadBrowse;
    }

    public WebElement clickBundleUploadSubmit() {
        synchronizationVisibilityofElement(driver, bundleUploadSubmit);
        return bundleUploadSubmit;
    }

    public WebElement getItemType(String itemName) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']//tbody//tr//td[contains(text(),'" + itemName + "')]//following::td[1]"));
    }

    public WebElement getSupportedTypeHoverText() {
        synchronizationVisibilityofElement(driver, supportedTypeHoverText);
        return supportedTypeHoverText;
    }

    public List<WebElement> returnPreviewTableValueList() {
        return previewAttributeTableList;
    }


    public WebElement click_WidgetItem(String itemName) {
        return driver.findElement(By.xpath("//table[@class='table table-hover asg-dyn-form-widget-table']//tbody//tr//td[contains(.,'" + itemName + "')]"));
    }

    public WebElement getStoredQueryName() {
        scrollToWebElement(driver, storedQueryName);
        return storedQueryName;
    }


    public WebElement click_TableHeadCloseButton() {
        synchronizationVisibilityofElement(driver, tableHeaderCloseButton);
        return tableHeaderCloseButton;
    }

    public WebElement widgetToolTip(String fieldName) {
        return driver.findElement(By.xpath("(//label[contains(.,'"+fieldName+"')]//following::label[text()=' technology'])[1]"));
    }

    public String widgetHoverText(String fieldName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-child-configuration')]]//strong[contains(.,'"+fieldName+"')]//following::ngb-tooltip-window[1]")).getText();
    }

    public WebElement tableHeaderToolTip(String fieldName) {
        return driver.findElement(By.xpath("//b[contains(.,'TABLE HEADER')]//following::strong[contains(.,'" + fieldName + "')]//following::span[1]"));
    }


    public String tableHeaderHoverText(String fieldName) {
        return driver.findElement(By.xpath("//b[contains(.,'TABLE HEADER')]//following::strong[contains(.,'"+fieldName+"')]//following::ngb-tooltip-window[1]")).getText();
    }


    public WebElement getWidgetPageSize() {
        scrollToWebElement(driver, widgetPageSize);
        return widgetPageSize;

    }

    public String pageSizeHoverText() {
        return widgetPageSize.getAttribute("title");
    }

    public WebElement attributeFilterToolTip(String fieldName) {
        return driver.findElement(By.xpath("//div[@title='ATTRIBUTEFILTER']//following::strong[contains(.,'" + fieldName + "')]//following::span[1]"));
    }

    public String attributeFilterHoverText(String fieldName) {
        return driver.findElement(By.xpath("//div[@title='ATTRIBUTEFILTER']//following::strong[contains(.,'" + fieldName + "')]//following::ngb-tooltip-window[1]")).getText();
    }

    public WebElement getWidgetType() {
        synchronizationVisibilityofElement(driver, widgetType);
        return widgetType;

    }

    public String getWidgetHoverText() {
        return widgetType.getAttribute("title");
    }

    public String getVisualComposerAlert() {
        return visualComposerAlertMessage.getText();
    }

    public WebElement attributeFilterProperties(String fieldName) {
        return driver.findElement(By.xpath("//div[@title='ATTRIBUTEFILTER']//following::strong[contains(.,'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement gremlinQueryText() {
        synchronizationVisibilityofElement(driver, gremlinQueryText);
        return gremlinQueryText;

    }

    public WebElement getItemViewapplyButton() {
        synchronizationVisibilityofElement(driver, ItemViewapplyButton);
        return ItemViewapplyButton;
    }

    public WebElement getMouseHoverText(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-child-configuration-main-content']//following::strong[contains(.,'" + fieldName + "')]//following::span[1]"));
    }

    public WebElement clickCloseIcon(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::strong[contains(.,'" + fieldName + "')]//following::div[@class='asg-dyn-form-table-add-cataloger-bth']"));
    }

    public WebElement getPreviewTab(String tabName) {
        return driver.findElement(By.xpath("//div[@class='itemview-detail-navbar full-size']//following::a[contains(text(),'" + tabName + "')]"));
    }

    public WebElement getPreviewExitButton() {
        synchronizationVisibilityofElement(driver, previewExitButton);
        return previewExitButton;
    }

    public void click_setAsPreviewButtonInVisualComposer() {

        synchronizationVisibilityofElement(driver, setAsPreviewButton);
        clickOn(setAsPreviewButton);
    }

    public WebElement getPreviewLabel() {
        synchronizationVisibilityofElement(driver, previewLabel);
        return previewLabel;
    }

    public WebElement getSecondWidget(String widgetName) {
        return driver.findElement(By.xpath("//div[@class='dashboard-widget item-view-builder_01']//following::span[contains(.,'" + widgetName + "')]"));
    }

    public WebElement getSecondWidgetTitle() {
        synchronizationVisibilityofElement(driver, secondWidgetTitle);
        return secondWidgetTitle;
    }

    public WebElement getItemValueLayout(String valueName) {
        return driver.findElement(By.xpath("//div[contains(@style,'grid-area')]//following::p[contains(.,'" + valueName + "')]"));
    }

    public WebElement getWidgetName(String widgetName) {
        return driver.findElement(By.xpath("//li[@class[contains(.,'dashboard-widget-wraper')]]//following::div/span[contains(.,'" + widgetName + "')]"));
    }

    public WebElement getWidgetFieldName(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::strong[contains(.,'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement getItemViewHeaderCheckbox(String checkbox) {
        return driver.findElement(By.xpath("//strong[contains(.,'"+checkbox+"')]//following::span[@class='switch checked switch-small']/small"));
    }

    public WebElement getForkIcon() {
        synchronizationVisibilityofElement(driver, forkIcon);
        return forkIcon;
    }


    public WebElement getItemValueLayout_Edge(String valueName) {
        return driver.findElement(By.xpath("//div[@class='item-view-wrapper item-view-wrapper-full-size edge']//following::p[contains(.,'" + valueName + "')]"));
    }

    public WebElement getResizeMenu() {
        return resizeMenu;
    }

    public WebElement getResizeMenuForTheWidget(String widgetName) {
        return driver.findElement(By.xpath("//li[@class='dashboard-widget-wraper']//span[contains(.,'" + widgetName + "')]//following::div[@class='btn-group widget-menu']"));
    }

    public WebElement getHighlightedSize(String size) {
        return driver.findElement(By.xpath("//li[@class[contains(.,'asg-dashboard-selected-size')]]/a[contains(.,'"+size+"')]"));
    }

    public WebElement getwidgetSideMenu() {
        synchronizationVisibilityofElement(driver, widgetSideMenu);
        return widgetSideMenu;
    }

    public void clickWidgetRemoveButton(String widgetName) {
        clickOn(driver.findElement(By.xpath("//div[@class='asg-iv-builder-widget-ellipsis']/span[contains(.,'" + widgetName + "')][1]//following::span[@class='fa fa-ellipsis-v'][1]")));
    }

    public void clickRemoveButton() {
        clickOn(removeButton);
    }


    public WebElement selectItemViewInItemManager(String panelName, String itemName) {
        return driver.findElement(By.xpath("//div[@title='"+panelName+"']/../..//table[@class='table table-hover']//td[text()=' "+itemName+" ']"));
    }


    public WebElement clickItemViewFieldDropDown(String panelName, String itemName) {
        return driver.findElement(By.xpath("//div[@title='" + panelName + "']//following::label[contains(.,'" + itemName + "')]//following::button[1]"));
    }

    public List<WebElement> getListOfCatalogs(String panelName, String labelName) {
        List<WebElement> list = driver.findElements(By.xpath("//div[@title='" + panelName + "']//following::label[contains(.,'" + labelName + "')]//following::button[1]//following::ul//li[@class='dropdown-item']"));
        return list;
    }

    public WebElement enterSearchText(String panelName, String labelName) {
        return driver.findElement(By.xpath("//div[@title='" + panelName + "']//following::label[contains(.,'" + labelName + "')]//following::input[@type='text'][1]"));
    }

    public List<WebElement> getListOfSupportedTypes(String panelName, String labelName) {
        List<WebElement> list = driver.findElements(By.xpath("//div[@title='" + panelName + "']//following::label[contains(.,'" + labelName + "')]//following::button[contains(@class,'dropdown-item')]"));
        return list;
    }

    public List<WebElement> getListOfAssignedCatalogs(String labelName) {
        List<WebElement> list = driver.findElements(By.xpath("//label[@class='asg-dyn-form-property-label'][contains(.,'" + labelName + "')]//following::div[1]/div//ul//li/span"));
        return list;
    }

    public List<WebElement> getListOfAssignedSupportedTypes(String labelName) {
        List<WebElement> list = driver.findElements(By.xpath("//label[@class='asg-dyn-form-property-label'][contains(.,'" + labelName + "')]//following::div/div//ul//li/span"));
        return list;
    }

    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void genericClick(String elementType, String... dynamicItem) {
        try {
            switch (elementType) {
                case "select item name from list":
                    clickOn(driver, traverseListContainsElementReturnsElement(new ItemViewManagement(driver).getItemViewList(), dynamicItem[0]));
                    break;
                case "TOP USERS WIDGET":
                    clickOn(driver, getResizeMenuForTheWidget(elementType));
                    break;
                case "1 x 1":
                    clickOn(driver, traverseListContainsElementReturnsElement(new PluginManager(driver).pluginManagerResizeMenuList(), elementType));
                    break;
                case "1 x 2":
                    clickOn(driver, traverseListContainsElementReturnsElement(new PluginManager(driver).pluginManagerResizeMenuList(), elementType));
                    break;
                case "apply_button":
                    clickonWebElementwithJavaScript(driver, getItemViewapplyButton());
                    break;
                case "SaveButton":
                    clickOn(driver, click_NewItemViewSaveButton());
                    waitForAngularLoad(driver);
                    sleepForSec(3000);
                    break;
                case "Visual Composer":
                    clickOn(driver, returnvisualComposerButton());
                    sleepForSec(1000);
                    break;
                case "ITEM AND LIST VIEW MANAGER":
                    clickOn(selectItemViewInItemManager(elementType, dynamicItem[0]));
                    sleepForSec(3000);
                    break;

            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericActionsMap(List<Map<String, String>> dataTable, String... actionType) {
        try {
            for (Map<String, String> values : dataTable) {
                for (Map.Entry<String, String> data : values.entrySet()) {
                    switch (data.getKey()) {
                        case "CATALOGS":
                            if (traverseListContainsElement(getListOfAssignedCatalogs(data.getKey()), data.getValue()) == true) {
                                break;
                            } else {
                                waitForAngularLoad(driver);
                                clickonWebElementwithJavaScript(driver, clickItemViewFieldDropDown(actionType[0], data.getKey()));
//                                enterText(enterSearchText(actionType[1].toUpperCase(), data.getKey()), data.getValue());
                                traverseListContainsElementAndClick(driver, getListOfCatalogs(actionType[1].toUpperCase(), data.getKey()), data.getValue());
                                waitForAngularLoad(driver);
                                sleepForSec(5000);
                                break;
                            }
                        case "SUPPORTED TYPES":
                            if (traverseListContainsElement(getListOfAssignedSupportedTypes(data.getKey()), data.getValue()) == true) {
                                break;
                            } else {
                                clickOn(enterSearchText(actionType[1].toUpperCase(), data.getKey()));
                                enterText(enterSearchText(actionType[1].toUpperCase(), data.getKey()), data.getValue());
                                sleepForSec(1000);
                                traverseListContainsElementAndClick(driver, getListOfSupportedTypes(actionType[1].toUpperCase(), data.getKey()), data.getValue());
                                waitForAngularLoad(driver);
                                sleepForSec(5000);
                                break;
                            }
                    }
                }
                waitForAngularLoad(driver);
                clickonWebElementwithJavaScript(driver, click_NewItemViewSaveButton());
                sleepForSec(3000);
                waitForAngularLoad(driver);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in configuring item values");
            Assert.fail(e.getMessage() + "Issue in configuring item values");
        }
    }

}
