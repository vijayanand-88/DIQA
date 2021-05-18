package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.util.List;

public class DataSets extends UIWrapper {
    public CommonUtil commonUtil = new CommonUtil();
    private WebDriver driver;

    @FindBy(css = "button>i[class='fa fa-database']")
    private WebElement assignDataSetButton;

    @FindBy(css = "div.no-more-tables > table > tbody > tr:nth-child(1) > td.checkbox-cell > app-asg-checkbox > div > label")
    private WebElement firstItemCheckbox;

    @FindBy(css = "button[class='btn btn-default']>span[class='fa fa-database']")
    private WebElement createNewDataSet;

    @FindBy(xpath = "//div[@title='NEW DATA SET']//following::input[@id='dataset-name']")
    private WebElement dataSetName;

    @FindBy(xpath = "//div[@title='NEW DATA SET']//following::textarea[@id='dataset-description']")
    private WebElement dataSetDescription;

    @FindBy(xpath = "//div[@title='NEW DATA SET']//following::button[@type='submit']")
    private WebElement dataSetSubmit;

    @FindBy(css = "div[title='ASSIGN DATA SET']~button[class='exit-btn']>i")
    private WebElement assignDataSetClose;

    @FindBy(css = "span[title='DataSet Sales Fact Test Data one one has been created by TestService']")
    private WebElement dataSetCreateNotification;

    @FindBy(css = "span[title='DataSet Sales Fact Test Data one one has been updated by TestService']")
    private WebElement dataSetUpdateNotification;

    @FindBy(xpath = "//div[@title='ASSIGN TO DATA SET']//following::button[@class='btn btn-default asg-assign-submit-btn']")
    private WebElement dataSetAssignButton;

    @FindBy(css = "button[id='datasetSelection']")
    private WebElement availableDataSetDropDown;

    @FindBy(xpath = "//div[@class='bottom-section bottom-block']//following::button/i[@class='fa fa-trash-o']")
    private WebElement dataSetDelete;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger')]]/div[3]")
    private WebElement duplicateDataSetAlert;

    @FindBy(css = "div[class='modal-body']>div>span")
    private WebElement unAssignDataElement;

    @FindBy(xpath = "//ul[@class[contains(.,'nav nav-tabs dashboard-tabs-panel')]]//li//a[contains(text(),'Data Sets')]")
    private WebElement dataSetDashBoard;

    @FindBy(xpath = "//ul[@class[contains(.,'nav nav-tabs item-view-categories')]]//li[2]//a[contains(text(),'Data')]")
    private WebElement dataTab;

    @FindBy(css = "div[class='flex-wrapper']>table>tbody>tr")
    private WebElement dataElementsInDataTab;

    @FindBy(css = "div[title='ASSIGN DATA SET']")
    private WebElement assignDataSetTitle;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger')]]/div[2]")
    private WebElement restritedErrorMessage;

    @FindBy(css = "input[placeholder='Search a dataset...']")
    private WebElement dataSetSearchText;

    @FindBy(xpath = "//ul[@class[contains(.,'nav nav-tabs item-view-categories')]]//following::a[contains(text(),'Data Analysis')]")
    private WebElement dataAnalysisTab;

    @FindBy(xpath = "//button[@class[contains(.,'btn btn-primary')]]//following::span[contains(.,'New Notebook')]")
    private WebElement newNotebookButton;

    @FindBy(css = "input[id='asg-note-book-name']")
    private WebElement notebookTitle;

    @FindBy(css = "textarea[id='asg-note-book-description']")
    private WebElement notebookDescription;

    @FindBy(css = "div[class='table-responsive-sm asg-item-view-selectable-table']")
    private WebElement notebookCount;

    @FindBy(css = "table[class='table table-hover']>tbody>tr")
    private List<WebElement> notebookList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item full-size-item')]]//span[contains(.,'Add')]//parent::span[@class='tags-widget-edit-button span-common fa fas fa-plus']")
    private WebElement addTagNotebook;

    @FindBy(xpath = "//p[contains(.,'DESCRIPTION')]//following::div[@class='ngx-wrapper']/div")
    private WebElement descriptionTextarea;

    @FindBy(xpath = "//p[contains(.,'DESCRIPTION')]//following::div[2]/div")
    private WebElement descriptionText;

    @FindBy(css = "i[class='fa fa-pencil asg-item-view-setting-btn']")
    private WebElement editWidgetButton;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu')]]/li")
    private List<WebElement> commentsDropdownList;

    @FindBy(xpath = "//button[@class[contains(.,'asg-notebook-insert-cell-btn')]]")
    private WebElement insertCellButton;

    @FindBy(xpath = "//button[@class[contains(.,'btn asg-notebook-dropdown-btn')]]")
    private WebElement dropdownButton;

    @FindBy(xpath = "//input[@id='asg-note-book-name']//following::div[@class[contains(.,'alert alert-danger')]]/div")
    private WebElement notebookError;

    @FindBy(xpath = "//button[@class='close float-right']")
    private WebElement notebookError_button;

    @FindBy(xpath = "//input[@id='asg-note-book-name']//following::div[@class[contains(.,'alert alert-danger')]]/div[3]")
    private WebElement duplicateNotebookError;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item full-size-item')]]//following::button[@class='exit-btn']/i")
    private WebElement exitButton;

    @FindBy(xpath = "//button[@class='asg-notebook-insert-cell-btn'][2]")
    private WebElement insertCellSecondButton;

    @FindBy(xpath = "//button[@class='asg-notebook-insert-cell-btn']//following::button[@class='btn asg-notebook-dropdown-btn'][2]")
    private WebElement dropdownSecondButton;

    @FindBy(xpath = "//button[@class='btn btn-primary dropdown-button']/i[@class='fa fa-cloud-download']")
    private WebElement exportButton;
    @FindBy(xpath = "//button[@class[contains(.,'btn btn-primary')]]/i[@class='fa fa-pencil-square-o']")
    private WebElement editButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-item asg-item-view asg-panels-active-item full-size-item')]]/div")
    private WebElement dataSetFullViewTab;

    @FindBy(css = "div[class='asg-item-view-multi-properties-widget']>p")
    private WebElement dataSetTitleMetadata;

    @FindBy(css = "p[class='asg-item-view-html-edit-title']")
    private WebElement dataSetTitleDesc;

    @FindBy(css = "p[class='asg-item-view-taglist-widget-title']")
    private WebElement dataSetTitleTag;

    @FindBy(css = "p[class='asg-item-view-rating-widget-caption']")
    private WebElement dataSetTitleRating;

    @FindBy(css = "table[class='table table-hover']>thead>tr>th[scope='col']")
    private List<WebElement> dataTabTableHeaderList;

    @FindBy(css = "div[class='filter-tabs']>ul>li")
    private List<WebElement> dataSetFilterValues;

    @FindBy(css = "div[class='form-group tags']")
    private WebElement tagFilters;

    @FindBy(xpath = "//div[@class='dashboard-dataset-content']//div[@class='card-body']//a/h5[contains(text(),'SALES FACT TEST DATA SETS')]")
    private WebElement dataSetSales;

    @FindBy(css = "div[class='assign-unassign-tags-save']")
    private WebElement assignTagSaveButton;

    @FindBy(xpath = "//div[@class='form-group tags']//ul//li/a")
    private List<WebElement> dataSetTagListValues;

    @FindBy(css = "div[class='form-group tags']")
    private WebElement tagDropDown;

    @FindBy(xpath = "//button[@class[contains(.,'btn btn-primary')]]/i[@class='fa fa-play']")
    private List<WebElement> runButton;

    @FindBy(xpath = "//div[@class='output_png output_subarea ']/img")
    private WebElement resultImage;

    @FindBy(css = "ul[class='dashboard-content edit-mode edge']>li[class='dashboard-widget-wraper']")
    private List<WebElement> PlaceToBeDropped_Edge;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-item')]]//button[contains(.,'SAVE')]")
    private WebElement saveButton;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger')]]//div[2]")
    private WebElement duplicateName;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger')]]//div[1]")
    private WebElement reqquiredFieldError;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger')]]//div[3]")
    private WebElement invalidNameError;

    @FindBy(css = "div.bottom-section.bottom-block > app-asg-actions-panel > div > button:nth-child(4)")
    private WebElement orderList;

    @FindBy(css = "div[class='asg-order-access-request-submit']>button")
    private WebElement submitOrderButton;

    @FindBy(css = "tr[class='asg-order-access-request-removed-item']")
    private WebElement removalItem;

    @FindBy(xpath = "//i[@class[contains(.,'fa fa-chevron')]]")
    private WebElement arrowIcon;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::i[@class='fa fa-expand']")
    private WebElement fullviewIcon;

    @FindBy(xpath = "//table/tbody/tr[@class='item']")
    private WebElement firstItemInOrderRequestTab;

    @FindBy(css = "span[class='asg-order-access-tooltip-view-details']")
    private WebElement viewDetailsLink;

    @FindBy(css = "li[class='nav-item']")
    private List<WebElement> orderRequestTab;

    @FindBy(xpath = "//div[contains(text(),'SHOW COMMENTS FROM')]")
    private WebElement showCommentText;

    @FindBy(xpath = "//button[@class='btn asg-comment-dropdown-btn clearfix']")
    private WebElement commentsDropdownButton;

    @FindBy(css = "div[class='asg-workflow-diagram-step-comments']>i")
    private WebElement notesIcon;

    @FindBy(css = "div[class='asg-multi-select-block']>input")
    private List<WebElement> multiSelectInputField;

    @FindBy(css = "div[class='asg-edit-visibility-save']>button")
    private WebElement editVisibilitySaveButton;

    @FindBy(xpath = "//ul[@class[contains(.,'search-menu show-border')]]/li/div/span[2]")
    private List<WebElement> usersDropDownList;

    @FindBy(css = "i[class='fa fa-times remove-item']")
    private List<WebElement> removeButton_MultiSelectField;

    @FindBy(css = "div[class='asg-total-user-count-block']>span")
    private WebElement topUserCountBlock;

    @FindBy(css = "div[class='asg-last-user-block']")
    private WebElement topUserLastUserBlock;

    @FindBy(css = "div[class='asg-top-user-block']")
    private WebElement topUsersBlock;

    @FindBy(css = "div[class='asg-workflow-diagram-step asg-workflow-diagram-approved']")
    private WebElement workflow_diagram_approved_block;

    @FindBy(css = "span[class='asg-order-request-catalog-status text-truncate']")
    private WebElement datasetStatusInOrderRequestpanel;

    @FindBy(css = "div[class='asg-workflow-diagram-step asg-workflow-diagram-approved asg-workflow-diagram-rejected']")
    private WebElement workflow_diagram_Rejected_block;

    @FindBy(css = "div[class='asg-workflow-diagram-step-end-type']")
    private WebElement workflow_diagram_end_block;

    @FindBy(xpath = "//button[contains(.,'Post Comment')]")
    private WebElement postCommentButton;

    @FindBy(xpath = "//button[@class='asg-order-request-top-btn pull-right']/span[contains(.,'Cancel Request')]")
    private WebElement cancelRequestButton;

    @FindBy(css="button[class='asg-item-view-caption-icon fa-fw fa-2x form-control btn btn-default'")
    private WebElement iconDatasetPage;

    @FindBy(css="div[class='asg-create-dataset-select-icon']")
    private WebElement CreateDatasetImageIcon;

    @FindBy(css = "div[class='asg-panels-item asg-item-view full-size-item disabled']")
    private WebElement disabledPanelDataset;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-scrollbar')]]/span[1]")
    private WebElement leftScrollClick;

    @FindBy(css = "div[class='asg-panels-item asg-item-view asg-panels-active-item full-size-item disabled']")
    private WebElement disabledFullsizePanel;

    @FindBy(xpath = "//th[@class='checkbox-selectable-cell'][1]")
    private WebElement firstItemCheckBox;

    //1.2

    @FindBy(xpath = "//div[@class[contains(.,'card cursor-pointer')]]//following::div[@class[contains(.,'card-title')]]")
    private List<WebElement> dataSetList;

    @FindBy(css = "input[id='asgManageSearch']")
    private WebElement dataSetFilterSearchField;

    @FindBy(xpath = "//span[@title='Search Data Sets']")
    private WebElement dataSetFilterSearchButton;

    @FindBy(xpath = "//div[@class='no-data-content']/div/div[contains(.,'No record(s) found.')]")
    private WebElement dataSetNoRecordFoundText;

    public DataSets(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized DataSet");
    }

    public WebElement getCreateDatasetImageIcon(){
        synchronizationVisibilityofElement(driver,CreateDatasetImageIcon);
        return CreateDatasetImageIcon;
    }


    public WebElement getAssignDataSetButton() {
        synchronizationVisibilityofElement(driver, assignDataSetButton);
        return assignDataSetButton;
    }

    public WebElement getFirstItemCheckbox() {
        synchronizationVisibilityofElement(driver, firstItemCheckbox);
        return firstItemCheckbox;
    }

    public WebElement getCreateNewDataSet() {
        synchronizationVisibilityofElement(driver, createNewDataSet);
        return createNewDataSet;
    }

    public void clickCreateNewDataSet() {
        synchronizationVisibilityofElement(driver, createNewDataSet);
        clickOn(createNewDataSet);
    }

    public WebElement getDataSetName() {
        synchronizationVisibilityofElement(driver, dataSetName);
        return dataSetName;
    }

    public WebElement getDataSetDescription() {
        synchronizationVisibilityofElement(driver, dataSetDescription);
        return dataSetDescription;
    }

    public WebElement getDataSetSubmit() {
        synchronizationVisibilityofElement(driver, dataSetSubmit);
        return dataSetSubmit;
    }

    public WebElement getAssignDataSetClose() {
        synchronizationVisibilityofElement(driver, assignDataSetClose);
        return assignDataSetClose;
    }

    public String getDataSetCreateNotification() {
        synchronizationVisibilityofElement(driver, dataSetCreateNotification);
        return dataSetCreateNotification.getText();
    }

    public String getDataSetUpdateNotification() {
        synchronizationVisibilityofElement(driver, dataSetUpdateNotification);
        return dataSetUpdateNotification.getText();
    }

    public WebElement getDataSetAssignButton() {
        return dataSetAssignButton;
    }

    public WebElement getAvailableDataSetDropDown() {
        synchronizationVisibilityofElement(driver, availableDataSetDropDown);
        return availableDataSetDropDown;
    }

    public WebElement getDataSetDelete() {
        synchronizationVisibilityofElement(driver, dataSetDelete);
        return dataSetDelete;
    }

    public WebElement getItemName(String itemName) {
        return driver.findElement(By.xpath("//td[@data-title='name']/a[contains(text(),'" + itemName + "')]//preceding::td[1]"));
    }


    public void clickItemCheckbox(String itemName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//span[contains(text(),'" + itemName + "')]//preceding::div[@class='asg-custom-checkbox'][1]/input")));
    }

    public WebElement getDataElement(String dataElement) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'dataset-element')]]/*[contains(text(),'" + dataElement + "')]//following::div[@class='dataset-element-remove'][1]"));
    }


    public String getDuplicateDataSetAlert() {
        synchronizationVisibilityofElement(driver, duplicateDataSetAlert);
        return duplicateDataSetAlert.getText();
    }

    public String getUnAssignDataElement() {
        synchronizationVisibilityofElement(driver, unAssignDataElement);
        return unAssignDataElement.getText();
    }

    public WebElement getDataSetDashBoard() {
        synchronizationVisibilityofElement(driver, dataSetDashBoard);
        scrollToWebElement(driver,dataSetDashBoard);
        return dataSetDashBoard;
    }

    public WebElement getDataSet(String dataSet) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class='dashboard-dataset-content']//following::h5[starts-with(.,'"+dataSet+"')]")),10);
        return driver.findElement(By.xpath("//div[@class='dashboard-dataset-content']//following::h5[starts-with(.,'"+dataSet+"')]"));
    }

    public WebElement getDataSetTab(String tabName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//ul[@class[contains(.,'nav nav-tabs item-view-categories')]]//li//a[contains(text(),'"+tabName+"')]")));
        return driver.findElement(By.xpath("//ul[@class[contains(.,'nav nav-tabs item-view-categories')]]//li//a[contains(text(),'"+tabName+"')]"));
    }

    public WebElement getDataTab() {
        synchronizationVisibilityofElement(driver, dataTab);
        return dataTab;
    }

    public WebElement getDataElementsInDataTab() {
        synchronizationVisibilityofElement(driver, dataElementsInDataTab);
        return dataElementsInDataTab;
    }

    public WebElement getAssignDataSetTitle() {
        synchronizationVisibilityofElement(driver, assignDataSetTitle);
        return assignDataSetTitle;
    }

    public String getRestritedErrorMessage() {
        return restritedErrorMessage.getText();
    }

    public WebElement getDatasetSearchText() {
        synchronizationVisibilityofElement(driver, dataSetSearchText);
        return dataSetSearchText;
    }

    public List<WebElement> getDataSetTitleLink(String dataSet) {
        return driver.findElements(By.xpath("//h5[contains(text(),'" + dataSet + "')]/parent::a"));
    }

    public WebElement getDataAnalysisTab() {
        synchronizationVisibilityofElement(driver, dataAnalysisTab);
        return dataAnalysisTab;
    }

    public WebElement getNotebookCount() {
        synchronizationVisibilityofElement(driver, notebookCount);
        return notebookCount;
    }

    public WebElement getNewNotebookButton() {
        synchronizationVisibilityofElement(driver, newNotebookButton);
        return newNotebookButton;
    }

    public WebElement getNotebookTitle() {
        synchronizationVisibilityofElement(driver, notebookTitle);
        return notebookTitle;
    }

    public WebElement getNotebookDescription() {
        synchronizationVisibilityofElement(driver, notebookDescription);
        return notebookDescription;
    }


    public WebElement getButtonsInNotebook(String buttonName) {
        return driver.findElement(By.xpath("//button[@class[contains(.,'btn btn-primary')]]/span[contains(.,'" + buttonName + "')]"));
    }

    public WebElement getHeaderNames(String headerName) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']//following::th[contains(.,'" + headerName + "')]"));
    }

    public List<WebElement> getNotebookList() {
        synchronizationVisibilityofElementsList(driver, notebookList);
        return notebookList;
    }

    public WebElement getNotebookValue(String notebookValue) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']//following::div[contains(text(),'" + notebookValue + "')]"));
    }

    public WebElement getNotebookTabName(String tabName) {
        return driver.findElement(By.xpath("//div[@class='itemview-detail-navbar full-size']/ul/li/a[contains(.,'" + tabName + "')]"));
    }

    public WebElement getMyRating(String rating) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-active-item full-size-item')]]//p[contains(.,'MY')]//following::span[@title='" + rating + "']"));
    }

    public WebElement getNotebookValue(String notebookName, String notebookValue) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']//following::span[@title='" + notebookName + "']//following::span[@title='" + notebookValue + "']"));
    }

    public WebElement getAddTagButton() {
        synchronizationVisibilityofElement(driver, addTagNotebook);
        return addTagNotebook;
    }

    public WebElement getTagUnderTagWidget(String tagName) {
        return driver.findElement(By.xpath("//div[@class='item-view-taglist-widget']//span[contains(.,'" + tagName + "')]"));
    }

    public WebElement getItemLabelsWithWidgets(String labelName) {
        return driver.findElement(By.xpath("//p[contains(.,'" + labelName + "')]//following::div[1]"));
    }

    public WebElement selectNotebookCheckbox(String notebookName) {
        return driver.findElement(By.xpath("//span[@title='" + notebookName + "']/preceding::input[1]"));
    }

    public WebElement getDescriptionTextarea() {
        synchronizationVisibilityofElement(driver, descriptionTextarea);
        return descriptionTextarea;
    }

    public WebElement getDescriptionText() {
        synchronizationVisibilityofElement(driver, descriptionText);
        return descriptionText;
    }

    public WebElement getDescriptionButton(String buttonName) {
        return driver.findElement(By.xpath("//p[contains(.,'DESCRIPTION')]//following::button[contains(.,'" + buttonName + "')]"));
    }

    public WebElement getEditWidgetButton() {
        synchronizationVisibilityofElement(driver, editWidgetButton);
        return editWidgetButton;

    }

    public List<WebElement> get_CommentsDropdown() {
        synchronizationVisibilityofElementsList(driver, commentsDropdownList);
        return commentsDropdownList;
    }

    public WebElement getInsertCellButton() {
        synchronizationVisibilityofElement(driver, insertCellButton);
        return insertCellButton;

    }

    public WebElement getDropdownButton() {
        synchronizationVisibilityofElement(driver, dropdownButton);
        return dropdownButton;

    }

    public WebElement getLanguageButton(String buttonName) {
        return driver.findElement(By.xpath("//ul[@class[contains(.,'dropdown-menu show')]]//following::a[contains(.,'" + buttonName + "')]"));
    }

    public WebElement getLanguageText(String buttonName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + buttonName + "')]//following::pre"));
    }

    public WebElement getNotebookError() {
        synchronizationVisibilityofElement(driver, notebookError);
        return notebookError;
    }

    public WebElement getNotebookErrorCloseButton() {
        synchronizationVisibilityofElement(driver, notebookError_button);
        return notebookError_button;
    }

    public boolean getNotebookErrorButton_status() {
        Boolean status = isElementPresent(notebookError_button);
        return status;
    }

    public WebElement getDuplicateNotebookError() {
        synchronizationVisibilityofElement(driver, duplicateNotebookError);
        return duplicateNotebookError;

    }

    public WebElement getExitButton() {
        synchronizationVisibilityofElement(driver, exitButton);
        return exitButton;

    }

    public WebElement getLanguageTextarea(String languageName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::div[@class='asg-notebook-cell-body']/textarea"));
    }

    public WebElement getLanguageEyeIcon(String languageName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::i[@class='fa fa-eye']"));
    }

    public List<WebElement> getEyeIcon(String languageName) {
        return driver.findElements(By.cssSelector("i[class='fa fa-eye']"));
    }

    public WebElement getLanguagePencilIcon(String languageName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::i[@class='fa fa-pencil']"));
    }

    public WebElement getTextAreaValue(String languageName, String tagName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::markdown/p/" + tagName));
    }

    public WebElement getLanguageDeleteButton(String languageName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::i[@class='fa fa-trash']"));
    }

    public WebElement getUpArrowButton(String languageName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::i[@class='fa fa-arrow-circle-o-up']/parent::button"));
    }

    public WebElement getDownArrowButton(String languageName) {
        return driver.findElement(By.xpath("//button[@class='btn asg-notebook-dropdown-btn']/span[contains(.,'" + languageName + "')]//following::i[@class='fa fa-arrow-circle-o-down']/parent::button"));
    }

    public WebElement getInsertCellSecondButton() {
        //synchronizationVisibilityofElement(driver,insertCellSecondButton );
        return insertCellSecondButton;

    }

    public WebElement getDropdownSecondButton() {
        // synchronizationVisibilityofElement(driver,dropdownSecondButton );
        return dropdownSecondButton;

    }

    public WebElement getButtonsInNotebookFullView(String buttonName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//button[@class='btn btn-primary']/span[contains(.,'" + buttonName + "')]"));
    }

    public WebElement getExportButton() {
        synchronizationVisibilityofElement(driver, exportButton);
        return exportButton;

    }

    public WebElement getEditButton() {
        synchronizationVisibilityofElement(driver, editButton);
        return editButton;

    }

    public WebElement getDataSetFullViewTab() {
        synchronizationVisibilityofElement(driver, dataSetFullViewTab);
        return dataSetFullViewTab;
    }

    public WebElement getDataSetTitleDesc() {
        synchronizationVisibilityofElement(driver, dataSetTitleDesc);
        return dataSetTitleDesc;
    }

    public WebElement getDataSetTitleMetadata() {
        synchronizationVisibilityofElement(driver, dataSetTitleMetadata);
        return dataSetTitleMetadata;
    }

    public WebElement getDataSetTitleTag() {
        synchronizationVisibilityofElement(driver, dataSetTitleTag);
        return dataSetTitleTag;
    }

    public WebElement getDataSetTitleRating() {
        synchronizationVisibilityofElement(driver, dataSetTitleRating);
        return dataSetTitleRating;
    }

    public WebElement getDataSetNameFromList(String dataSetName) {
        return driver.findElement(By.xpath("//td//a[contains(text(),'" + dataSetName + "')]"));
    }

    public List<WebElement> getDataSetNameFromListStatus(String dataSetName) {
        return driver.findElements(By.xpath("//td//a[contains(text(),'" + dataSetName + "')]"));

    }

    public List<WebElement> getDataTabTableHeaderList() {
        synchronizationVisibilityofElementsList(driver, dataTabTableHeaderList);
        return dataTabTableHeaderList;
    }

    public List<WebElement> getDataSetFilterValues() {
        synchronizationVisibilityofElementsList(driver, dataSetFilterValues);
        return dataSetFilterValues;
    }

    public WebElement getTagFilters() {
        synchronizationVisibilityofElement(driver, tagFilters);
        return tagFilters;
    }

    public WebElement getDataSetFilterTabs(String filterTabName) {
        return driver.findElement(By.xpath("//li[@class='nav-item']/a[contains(text(),'" + filterTabName + "')]"));
    }

    public WebElement getDataSetViewTabs(String tabName) {
        return driver.findElement(By.xpath("//li[@role='presentation']/a[contains(text(),'" + tabName + "')]"));

    }

    public WebElement getDataSetRating(String dataSetRating) {
        return driver.findElement(By.xpath("//*[contains(text(),'SALES FACT TEST DATA SETS')]//following::p[@class='card-text rating']//span["+dataSetRating+"]"));
    }

    public WebElement getDataSetSales() {
        synchronizationVisibilityofElement(driver, dataSetSales);
        return dataSetSales;
    }

    public WebElement getItemTaglink(String itemName) {
        return driver.findElement(By.xpath("//td[@data-title='name']//a[contains(text(),'" + itemName + "')]//following::td[@data-title='Tags']"));
    }

    public WebElement getTagName(String tagName) {
        return driver.findElement(By.xpath("//ul[@class='nav nav-stacked']/li/a/span[contains(text(),'" + tagName + "')]"));
    }

    public WebElement clickItemFromResults(String itemName) {
//        return driver.findElement(By.xpath("//td[@data-title='Item name']/a[contains(text(),'" + itemName + "')]"));
        return driver.findElement(By.xpath("//div[@class='item-list']//a[contains(text(),'" + itemName + "')]"));

    }

    public List<WebElement> dataSetTagListValues() {
        synchronizationVisibilityofElementsList(driver, dataSetTagListValues);
        return dataSetTagListValues;
    }

    public WebElement getTagDropDown() {
        synchronizationVisibilityofElement(driver, tagDropDown);
        return tagDropDown;
    }

    public List<WebElement> getRunButton() {
        synchronizationVisibilityofElementsList(driver, runButton);
        return runButton;

    }

    public WebElement getResultImage() {
        synchronizationVisibilityofElement(driver, resultImage);
        return resultImage;

    }

    public List<WebElement> getPlaceToBeDropped_Edge() {
        return PlaceToBeDropped_Edge;
    }

    public WebElement returnDataSetActionButton(String actionName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//button//span[contains(.,'" + actionName + "')]")));
        return driver.findElement(By.xpath("//button//span[contains(.,'" + actionName + "')]"));
    }

    public WebElement returnPanel(String panelName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div//div[@title='" + panelName + "']/b[contains(text(),'" + panelName + "')]")));
        return driver.findElement(By.xpath("//div//div[@title='" + panelName + "']/b[contains(text(),'" + panelName + "')]"));
    }

    public WebElement returnTextbox(String labelName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class='data-content']//div/label/b[contains(text(),'" + labelName + "')]/following::input[1]")));
        return driver.findElement(By.xpath("//div[@class='data-content']//div/label/b[contains(text(),'" + labelName + "')]/following::input[1]"));
    }

    public WebElement returnTextArea(String labelName) {
        if(labelName.equalsIgnoreCase("DESCRIPTION")) {
            synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div/form/div/div[@class='form-group']/label/b[contains(text(),'" + labelName + "')]//following::div[contains(@class,'ql-editor')]")));
            return driver.findElement(By.xpath("//div/form/div/div[@class='form-group']/label/b[contains(text(),'" + labelName + "')]//following::div[contains(@class,'ql-editor')]"));
        }
        else{
            synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div/form/div/div[@class='form-group']/label/b[contains(text(),'" + labelName + "')]/following::textarea[1]")));
            return driver.findElement(By.xpath("//div/form/div/div[@class='form-group']/label/b[contains(text(),'" + labelName + "')]/following::textarea[1]"));
        }
    }

    public WebElement returnSaveButton() {
        synchronizationVisibilityofElement(driver, saveButton);
        return saveButton;
    }

    public WebElement returnReportElement(String reportName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class='asg-reports-card-view-container']//ul//li[contains(.,'" + reportName + "')]")),10);
        return driver.findElement(By.xpath("//div[@class='asg-reports-card-view-container']//ul//li[contains(.,'" + reportName + "')]"));

    }

    public WebElement returnDuplicateNameError() {
        synchronizationVisibilityofElement(driver, duplicateName);
        return duplicateName;
    }

    public WebElement returnreqquiredFieldError() {
        synchronizationVisibilityofElement(driver, reqquiredFieldError);
        return reqquiredFieldError;
    }

    public WebElement returnInvalidNameError() {
        synchronizationVisibilityofElement(driver, invalidNameError);
        return invalidNameError;
    }

    public WebElement returnfacetTypeandItem(String facetType, String dataType) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class[contains(.,'asg-search-facet-box-wrapper')]]/div[contains(text(),'" + facetType + "')]/following-sibling::div//div[@title='" + dataType + "']")));
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-search-facet-box-wrapper')]]/div[contains(text(),'" + facetType + "')]/following-sibling::div//div[@title='" + dataType + "']"));
    }

    public WebElement getOrderList() {
        synchronizationVisibilityofElement(driver, orderList);
        return orderList;
    }

    public void clickFirstDataItemDisplayed(String itemName) {
        clickOn(driver.findElement(By.xpath("//div[contains(.,'"+itemName+"')]/preceding::th[@class='checkbox-selectable-cell'][1]")));
    }

    public void clickOrderList() {
        clickOn(orderList);
    }

    public void clickItemRemoveButton(String itemName) {
        clickOn(driver.findElement(By.xpath("//b[contains(.,'ORDER LIST')]//following::div[contains(.,'" + itemName + "')]//following::i[@class[contains(.,'fa fa-remove')]]")));
    }

    public List<WebElement> getPanelDisplayStatus(String panel) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'asg-panels-active-item')]]/div/div/div[@title='" + panel + "']"));
    }

    public WebElement getSelectedElementsText() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-active-item')]]/div/div/div[@title='ORDER LIST']//following::div[@class='asg-order-access-request-body']/b"));
    }

    public void clickSubmitOrderButton() {
        clickOn(submitOrderButton);
    }

    public WebElement getSubmitOrderButton() {
        return submitOrderButton;
    }

    public WebElement getRemovalItem() {
        synchronizationVisibilityofElement(driver, removalItem);
        return removalItem;
    }

    public WebElement getPlusButton(String itemName) {
        return driver.findElement(By.xpath("//div[contains(.,'" + itemName + "')]//following::i[@class='fa fa-plus']"));
    }

    public WebElement getItemFromOrderList(String itemName) {
        return driver.findElement(By.xpath("//table[@class='table table-borderless table-bordered']/tbody/tr/td/div[contains(.,'"+itemName+"')]"));
    }

    public void clickArrowIconInOpenNotificationPanel() {
        clickOn(arrowIcon);
    }

    public void clickFirstOrderFromTheList() {
        clickOn(firstItemInOrderRequestTab);
    }

    public List<WebElement> getItemFromOpenNotificationPanel() {
        return driver.findElements(By.xpath("//tabset/div/tab/table/tbody/tr/td[1]"));
    }

    public WebElement getOrderRequestslabelsAndvalues(int position, String label, String Value) {
        return driver.findElement(By.xpath("//table/thead/tr/th[" + position + "][contains(.,'" + label + "')]//following::tbody/tr/td[" + position + "][contains(.,'" + Value + "')]"));
    }

    public WebElement getOrderRequestsHeaderAndvalues(int position, String label, String Value) {
        return driver.findElement(By.xpath("//div[@class='asg-order-request-catalog-table-header']/div[" + position + "][contains(.,'" + label + "')]//following::div[@class='asg-order-request-catalog-row-main clearfix']/span[" + position + "][contains(.,'" + Value + "')]"));
    }

    public void clickFullViewIcon() {
        clickOn(fullviewIcon);
    }

    public void clickFirstItemFromOrderRequestsPanel() {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class='asg-order-request-catalog-row-main clearfix']/span")));
        clickOn(driver.findElement(By.xpath("//div[@class='asg-order-request-catalog-row-main clearfix']/span")));
    }

    public void clickIiconUnderMyAccess(String itemName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[contains(.,'"+itemName+"')]//following::span[@class='asg-order-access-status-info fa fa-info-circle']")));
    }

    public void clickViewDetailsInPopUp() {
        clickOn(driver,viewDetailsLink);
    }

    public List<WebElement> getTabInOrderRequestPanel() {
        return orderRequestTab;
    }

    public WebElement getNameInOrderRequestPanel(String orderName) {
        return driver.findElement(By.xpath("//tr[@class='item']/td/span[contains(.,'" + orderName + "')]"));
    }

    public void clickStartStepNotesIcon(String notesBy) {
        clickOn(driver.findElement(By.xpath("//span[contains(.,'" + notesBy + "')]//following::div[@class='asg-workflow-diagram-step-comments'][1]/i")));
    }

    public WebElement get_showComments() {
        synchronizationVisibilityofElement(driver, showCommentText);
        return showCommentText;
    }

    public void click_commentsDropdownButton() {
        synchronizationVisibilityofElement(driver, commentsDropdownButton);
        clickOn(commentsDropdownButton);
    }

    public WebElement getColumns(String column) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']/thead/tr/th[contains(.,'" + column + "')]"));
    }

    public WebElement getDatasetStatus(String status) {
        return driver.findElement(By.cssSelector("div[class='asg-item-view-status-and-setting']>span[class='status-value']"));
    }

    public List<WebElement> getRemoveButton_MultiSelectInputField() {
        return removeButton_MultiSelectField;
    }

    public List<WebElement> getMultiSelectInputField() {
        synchronizationVisibilityofElementsList(driver, multiSelectInputField);
        return multiSelectInputField;
    }

    public WebElement get_editVisibilitySaveButton() {
        return editVisibilitySaveButton;
    }

    public List<WebElement> get_usersDropdownList() {
        synchronizationVisibilityofElementsList(driver, usersDropDownList);
        return usersDropDownList;
    }

    public List<WebElement> getRunButtonDisplayStatus(String action) {
        return driver.findElements(By.xpath("//span[contains(.,'" + action + "')]//following::button[@class='btn btn-sm action-button'][1]/span"));
    }

    public WebElement getDatasetLastUser(String user) {
        return driver.findElement(By.xpath("//div[@class='last-user-item asg-user-items']/span[contains(.,'" + user + "')]"));
    }

    public WebElement get_TopUserWidget_CallCount_Block() {
        return topUserCountBlock;
    }

    public WebElement get_TopUserWidget_LastUser_Block() {
        return topUserLastUserBlock;
    }

    public WebElement get_TopUserWidget_TopUsersBlock() {
        return topUsersBlock;
    }

    public WebElement getWidgetWidth(String widget) {
        return driver.findElement(By.xpath("//p[contains(.,'" + widget + "')]//following::div[@class='content asg-item-view-topuser-widget-body']"));
    }

    public WebElement getTopUserName(String userName) {
        return driver.findElement(By.xpath("//ul[@class='nav nav-pills asg-top-user-container']/li[1][contains(.,'" + userName + "')]"));
    }

    public WebElement getMyAccessStatusForTheItem(String itemName, String status) {
        return driver.findElement(By.xpath("//table/tbody/tr/td/div[contains(.,'"+itemName+"')]//following::span[contains(.,'"+status+"')]"));
    }

    public WebElement getMyAccessStatus(String itemName) {
        return driver.findElement(By.xpath("//table/tbody/tr/td/div[contains(.,'"+itemName+"')]//following::span[@class='asg-order-access-status-label']"));
    }

    public WebElement getDatasetStatusInOrderRequestPanel(){
        return datasetStatusInOrderRequestpanel;
    }

    public WebElement getMyAccessStatusForInProgress(String itemName) {
        return driver.findElement(By.xpath("//table/tbody/tr/td/div[contains(.,'"+itemName+"')]//following::span[@class='asg-order-access-status-container asg-order-access-status-in-progress']"));
    }

    public WebElement getMyAccessStatusForRequested(String itemName) {
        return driver.findElement(By.xpath("//table/tbody/tr/td/div[contains(.,'" + itemName + "')]//following::span[@class='asg-order-access-status-container asg-order-access-status-requested']"));
    }

    public WebElement get_workflowDiagramApproved_Block() {
        return workflow_diagram_approved_block;
    }

    public WebElement get_workflowDiagramRejected_Block() {
        return workflow_diagram_Rejected_block;
    }

    public WebElement get_workflowDiagramEnd_Block() {
        return workflow_diagram_end_block;
    }

    public WebElement getDiagramDetails(String action, String user) {
        synchronizationVisibilityofElement(driver,driver.findElement(By.xpath("//div[@class='asg-workflow-diagram-step-body text-center clearfix']//span[contains(.,'" + action + "')]//following::b[contains(.,'" + user + "')][1]")));
        return driver.findElement(By.xpath("//div[@class='asg-workflow-diagram-step-body text-center clearfix']//span[contains(.,'" + action + "')]//following::b[contains(.,'" + user + "')][1]"));
    }

    public WebElement getNoteCountInOrderRequestPanel(String action) {
        return driver.findElement(By.xpath("//span[contains(.,'" + action + "')]//following::div[@class='asg-workflow-diagram-step-comments'][1]/span[1]"));
    }

    public boolean getButtonInCommentBox_status(String user, String button) {
        boolean status = isElementNotPresent(driver, By.xpath("//div[@class='asg-comments-body']/span/b[contains(.,'" + user + "')]//following::button[contains(.,'" + button + "')][1]"));
        return status;
    }

    public void Click_buttonInCommentBox(String user, String button) {
        clickOn(driver.findElement(By.xpath("//div[@class='asg-comments-body']/span/b[contains(.,'" + user + "')]//following::button[contains(.,'" + button + "')][1]")));
        sleepForSec(500);
    }


    public void click_ButtonInPanel(String buttonName) {
        clickOn(driver.findElement(By.xpath("//button[contains(.,'" + buttonName + "')]")));
        sleepForSec(500);
    }

    public void click_CancelRequestButton() {
        clickOn(cancelRequestButton);
        sleepForSec(1000);
    }

    public boolean getCancelRequestButton_status() {
        boolean status = isElementPresent(cancelRequestButton);
        return status;
    }

    public void enter_comments(String comment, String section) {
        enterText(driver.findElement(By.xpath("//textarea[@placeholder[contains(.,'" + section + "')]]")), comment);
    }

    public void enter_commentsInEditSection(String comment) {
        enterText(driver.findElement(By.xpath("//div[@class='asg-comments-body-edit']/textarea")), comment);
    }

    public WebElement getMyAccessStatusText(String status) {
        return driver.findElement(By.xpath("//span[@class='asg-order-access-status-label'][contains(.,'" + status + "')]"));
    }

    public WebElement geticonDatasetPage() {
        synchronizationVisibilityofElement(driver, iconDatasetPage);
        return iconDatasetPage;
    }

    public WebElement getdisabledPanelDataset() {
        synchronizationVisibilityofElement(driver, disabledPanelDataset);
        return disabledPanelDataset;
    }

    public WebElement clickgetactivePanelCloseButton(String Name) {
        return (driver.findElement(By.xpath("//div[@title='" + Name + "']//following::button[@class='exit-btn'][1]")));
    }

    public WebElement getdisabledFullsizePanel() {
        synchronizationVisibilityofElement(driver, disabledFullsizePanel);
        return disabledFullsizePanel;
    }

    public WebElement getLeftScrollClick() {
        return leftScrollClick;
    }

    public WebElement getFirstItemCheckBox() {
        return firstItemCheckBox;
    }

    public WebElement getPopUpParameters(String value) {
        return driver.findElement(By.xpath("//div[@class='tooltip-inner']//following::span[contains(.,'"+value+"')]"));
    }

    //1.2 Dataset page objects

    public List<WebElement> getDataSetList() {
        synchronizationVisibilityofElementsList(driver, dataSetList);
        return dataSetList;
    }

    public WebElement getDataSetFilterSearchButton() {
        synchronizationVisibilityofElement(driver, dataSetFilterSearchButton);
        return dataSetFilterSearchButton;
    }

    public WebElement getDataSetFilterSearchField() {
        synchronizationVisibilityofElement(driver, dataSetFilterSearchField);
        return dataSetFilterSearchField;
    }

    public WebElement getDataSetNoRecordFoundText() {
        synchronizationVisibilityofElement(driver, dataSetNoRecordFoundText);
        return dataSetNoRecordFoundText;
    }

    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void dynamicClickActions(String elementType, String... dynamicItem) {
        try {
            switch (elementType) {
                case "dataset":
                    clickOn(driver, getDataSet(dynamicItem[0]));
                    sleepForSec(2000);
                    waitForAngularLoad(driver);
                    break;
                case "tab":
                    sleepForSec(500);
                    clickOn(getDataSetTab(dynamicItem[0]));
                    sleepForSec(800);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void enterActions(String elementType, String text) {
        try {
            switch (elementType) {
                case "DatasetName":
                    enterText(getDataSetName(), text);
                    break;
                case "DataSetDescription":
                    enterText(getDataSetDescription(), text);
                    break;
                case "edit":
                    enter_commentsInEditSection(text);
                    break;
                case "Write a reply":
                    enter_comments(text, elementType);
                    break;
                case "Leave comment":
                    enter_comments(text, elementType);
                    break;
                case "MultiSelectInputField":
                    enterText(getMultiSelectInputField().get(0), text);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public boolean isDataSetElementPresent(String elementType) {
        boolean flag = false;
        try {
            switch (elementType) {
                case "callCountBlock":
                    isElementPresent(get_TopUserWidget_CallCount_Block());
                    flag = true;
                    break;
                case "LastUser_Block":
                    isElementPresent(get_TopUserWidget_LastUser_Block());
                    flag = true;
                    break;
                case "TopUsersBlock":
                    isElementPresent(get_TopUserWidget_TopUsersBlock());
                    flag = true;
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
        return flag;
    }

    public void genericClick(String elementName,String... dynamicItem) {
        try {
            switch (elementName) {
                case "dataset_dashboard":
                    clickOn(driver,getDataSetDashBoard());
                    sleepForSec(2500);
                    break;
                case "assign dataset button":
                    clickonWebElementwithJavaScript(driver,getAssignDataSetButton());
                    waitForAngularLoad(driver);
                    break;
                case "create new dataset button":
                    clickonWebElementwithJavaScript(driver, getCreateNewDataSet());
                    break;
                case "Submit button":
                    clickonWebElementwithJavaScript(driver,getDataSetSubmit());
                    sleepForSec(2500);
                    break;
                case "Panel assign dataset button":
                    clickOn(getDataSetAssignButton());
                    waitForAngularLoad(driver);
                    sleepForSec(3500);
                    break;
                case "Dataset_Dropdown":
                    sleepForSec(200);
                    clickonWebElementwithJavaScript(driver,getAvailableDataSetDropDown());
                    sleepForSec(500);
                    break;
                case "selectDataset":
                    sleepForSec(200);
                    clickonWebElementwithJavaScript(driver,traverseListContainsElementTextReturnsElement(getDataSetList(), dynamicItem[0]));
                    sleepForSec(1000);
                    break;
                case "Full view icon":
                    clickFullViewIcon();
                    sleepForSec(1000);
                    break;
                case "First Order In List":
                    clickFirstOrderFromTheList();
                    sleepForSec(200);
                    break;
                case "first item from the Order Request Panel":
                    sleepForSec(1000);
                    clickFirstItemFromOrderRequestsPanel();
                    break;
                case "PROGRESS":
                    clickOn(traverseListContainsElementReturnsElement(getTabInOrderRequestPanel(), elementName));
                    break;
                case "Request submitted by":
                    clickStartStepNotesIcon(elementName);
                    break;
                case "Approved by":
                    clickStartStepNotesIcon(elementName);
                    break;
                case "show comments from dropdown":
                    get_showComments().isDisplayed();
                    click_commentsDropdownButton();
                    sleepForSec(500);
                    clickOn(traverseListContainsElementReturnsElement(get_CommentsDropdown(), dynamicItem[0]));
                    break;
                case "edit widget button":
                    sleepForSec(500);
                    clickonWebElementwithJavaScript(driver, getEditWidgetButton());
                    sleepForSec(800);
                    break;
                case "arrow icon":
                    new DataSets(driver).clickArrowIconInOpenNotificationPanel();
                    break;
                case "Public":
                    clickOn(traverseListContainsElementReturnsElement(get_CommentsDropdown(), elementName));
                    break;
                case "Restricted":
                    clickOn(traverseListContainsElementReturnsElement(get_CommentsDropdown(), elementName));
                    break;
                case "remove button in multiselectInput field":
                    clickOn(getRemoveButton_MultiSelectInputField().get(0));
                    break;
                case "MultiSelectInput_user":
                    clickOn(traverseListContainsElementReturnsElement(get_usersDropdownList(), dynamicItem[0]));
                    break;
                case "save button":
                    clickOn(get_editVisibilitySaveButton());
                    break;
                case "Run button":
                    clickonWebElementwithJavaScript(driver, getRunButton().get(0));
                    break;
                case "Post Comment":
                    click_ButtonInPanel(elementName);
                    break;
                case "SEND":
                    click_ButtonInPanel(elementName);
                    sleepForSec(300);
                    break;
                case "save":
                    click_ButtonInPanel(elementName);
                    break;
                case "remove button":
                    clickItemRemoveButton(dynamicItem[0]);
                    break;
                case "widget edit button":
                    new DashBoardPage(driver).Click_editWidgetDashboard_chrome();
                    break;
                case "Cancel Request Button":
                    new DataSets(driver).click_CancelRequestButton();
                    break;
                case "View Details":
                    new DataSets(driver).clickViewDetailsInPopUp();
                    sleepForSec(1000);
                    break;
                case "DataSetImageIcon":
                    clickOn(driver, getCreateDatasetImageIcon());
                    break;
                case "DATA SET ICON":
                    clickOn(driver, clickgetactivePanelCloseButton("DATA SET ICON"));
                    break;
                case "EDIT VISIBILITY":
                    clickOn(driver, clickgetactivePanelCloseButton("EDIT VISIBILITY"));
                    break;
                case "LINK REPORT":
                    clickOn(driver, clickgetactivePanelCloseButton("LINK REPORT"));
                    break;
                case "DatasetDetailsImageicon":
                        clickOn(driver,geticonDatasetPage());
                    break;
                case "First checkbox from the list in Data Panel":
                    clickOn(getFirstItemCheckBox());
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementPresent(String elementName,String... dynamicItem) {
        try {
            switch (elementName) {
                case "MY ACCESS":
                    Assert.assertTrue(isElementPresent(getColumns("MY ACCESS")));
                    break;
                case "TestService":
                    Assert.assertTrue(isElementPresent(getTopUserName("TestService")));
                    break;
                case "TestDataConsumer":
                    Assert.assertTrue(isElementPresent(getDatasetLastUser("TestDataConsumer")));
                    break;
                case "item full view page":
                    Assert.assertTrue(isElementPresent(getDatasetLastUser("TestDataConsumer")));
                    break;
                case "dataset status":
                    Assert.assertTrue(getElementText(getDatasetStatus(dynamicItem[0])).equalsIgnoreCase(dynamicItem[0]));
                    break;
                case "multiple select serach":
                    Assert.assertTrue(isElementPresent(getMultiSelectInputField().get(0)));
                    break;
                case "verify dataset title":
                    moveToElementUsingJavaScript(driver, getDataSet(dynamicItem[0]));
                    Assert.assertTrue(getDataSetTitleLink(dynamicItem[0]).get(0).isDisplayed());
                    break;
                case "comment text":
                    verifyTrue(getElementText(new SubjectArea(driver).get_commentBody()).contains(dynamicItem[0]));
                    break;
                case "ORDER LIST":
                    Assert.assertTrue(getPanelDisplayStatus(elementName).get(0).isDisplayed());
                    break;
                case "Workflow diagram":
                    Assert.assertTrue(isElementPresent(get_workflowDiagramApproved_Block()));
                    Assert.assertTrue(isElementPresent(get_workflowDiagramRejected_Block()));
                    Assert.assertTrue(isElementPresent(get_workflowDiagramEnd_Block()));
                    break;
                case "2ITEMS REQUESTED FOR ACCESS":
                    Assert.assertEquals(elementName, getElementText(new DataSets(driver).getSelectedElementsText()));
                    break;
                case "plus button":
                    Assert.assertTrue(getPlusButton(dynamicItem[0]).isDisplayed());
                    break;
                case "Diagram progress":
                    Assert.assertTrue(isElementPresent(getDiagramDetails(dynamicItem[0], dynamicItem[1])));
                    break;
                case "data items":
                    Assert.assertTrue(traverseListContainsElementText(getItemFromOpenNotificationPanel(), dynamicItem[0]));
                    break;
                case "pop up parameters":
                    Assert.assertTrue(isElementPresent(getPopUpParameters(dynamicItem[0])));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementNotPresent(String elementName,String... dynamicItem) {
        try {
            switch (elementName) {
                case "multiple select serach":
                    Assert.assertTrue(getMultiSelectInputField().isEmpty());
                    break;
                case "ORDER LIST":
                    Assert.assertTrue(getPanelDisplayStatus(elementName).isEmpty());
                    break;
                case "Cancel Request Button":
                    Assert.assertFalse(getCancelRequestButton_status());
                    break;
                case "Run button":
                    Assert.assertTrue(getPanelDisplayStatus(dynamicItem[0]).isEmpty());
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyEquals(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "TOP USER":
                    Assert.assertEquals(getWidgetWidth(elementName).getSize().getWidth(), Integer.parseInt(dynamicItem[0]));
                    break;
                case "Requested":
                    Assert.assertEquals(getMyAccessStatusText(elementName).getCssValue("color"), dynamicItem[0]);
                    break;
                case "In Progress":
                    Assert.assertEquals(getMyAccessStatusText(elementName).getCssValue("color"), dynamicItem[0]);
                    break;
                case "Approved":
                    Assert.assertEquals(getMyAccessStatusText(elementName).getCssValue("color"), dynamicItem[0]);
                    break;
                case "noteCount":
                    Assert.assertEquals(getElementText(getNoteCountInOrderRequestPanel(dynamicItem[0])),dynamicItem[1]);
                    break;
                case "removal_item_bg_color":
                    String actualRGBCode = getRemovalItem().getCssValue("background-color");
                    Assert.assertEquals(actualRGBCode, dynamicItem[0]);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyEnabled(String elementName) {
        try {
            switch (elementName) {
                case "submit order":
                    Assert.assertTrue(getSubmitOrderButton().isEnabled());
                    break;
                case "save button":
                    Assert.assertTrue(get_editVisibilitySaveButton().isEnabled());
                    break;
                case "order list":
                    Assert.assertTrue(getOrderList().isEnabled());
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyDisabled(String elementName) {
        try {
            switch (elementName) {
                case "submit order":
                    Assert.assertFalse(getSubmitOrderButton().isEnabled());
                    break;
                case "save button":
                    Assert.assertFalse(get_editVisibilitySaveButton().isEnabled());
                    break;
                case "order list":
                    Assert.assertFalse(getOrderList().isEnabled());
                    break;
                case "DataSetpanel":
                    sleepForSec(1000);
                    Assert.assertTrue(new DataSets(driver).getdisabledPanelDataset().isDisplayed());
                    break;
                case "NoteBook":
                    clickOn(driver, getLeftScrollClick());
                    Assert.assertTrue(isElementPresent(getdisabledFullsizePanel()));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void dataScienceAndAnalyticsDashboardPage(String actionType, String actionItem, String ItemName, String Section) throws Exception {
        try {

            switch (actionType) {
                case "Verify presence":
                    if (actionItem.equalsIgnoreCase("Data Set")) {
                        Assert.assertTrue(traverseListContainsDynamicElementText(getDataSetList(), ItemName));
                    } else if(actionItem.equalsIgnoreCase("No record found text")){
                        Assert.assertTrue(isElementPresent(getDataSetNoRecordFoundText()));
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Verify non presence":
                    if (actionItem.equalsIgnoreCase("Data Set")) {
                        Assert.assertFalse(traverseListContainsDynamicElementText(getDataSetList(), ItemName));
                    }
                    break;
                case "Click Data Set":
                    clickOn(driver, traverseListContainsDynamicElementTextReturnsElement(getDataSetList(), ItemName));
                    waitForAngularLoad(driver);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }
}