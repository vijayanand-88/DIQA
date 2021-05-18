package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.JsonRead;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.util.Iterator;
import java.util.List;

@SuppressWarnings("DefaultFileTemplate")
public class SubjectAreaManagement extends UIWrapper {

    private WebDriver driver;
    private JsonRead jsonRead = new JsonRead();

    @FindBy(xpath = "//button[@class='btn btn-default subject-areas']")
    private WebElement SubjectAreaManagercreateButton;

    @FindBy(xpath = "//b[contains(.,'SUBJECT AREA MANAGEMENT')]")
    private WebElement verifySubjectAreaManagement;

    @FindBy(xpath = "//h4[contains(.,'Tags')]")
    private WebElement subjectAreaTagField;

    @FindBy(xpath = "//h4[contains(.,'Views')]")
    private WebElement subjectAreaViewsField;

    @FindBy(xpath = "//div[@class='content catalogs']//following::tbody/tr/td[1]")
    private List<WebElement> listedSubjectAreas;

    @FindBy(xpath = "//input[@class='form-control']")
    private List<WebElement> createTagProperties;

    @FindBy(xpath = "//button[contains(.,'Create new tag')]")
    private WebElement createNewTag;

    @FindBy(xpath = "//input[@id='tagType']")
    private WebElement newTagName;

    @FindBy(xpath = "//button[@class='btn btn-default catalogs']")
    private WebElement newSubjectAreaCreateButton;

    @FindBy(name = "catalogName")
    private WebElement newSubjectAreaName;

    @FindBy(id = "catalogDescription")
    private WebElement newSubjectAreaDescription;

    @FindBy(xpath = "//table/tbody/tr/td[1]")
    private WebElement SubjectAreaName;

    @FindBy(xpath = "//table/tbody/tr/td[2]")
    private WebElement SubjectAreaDescription;

    @FindBy(id = "areaIcon")
    private WebElement chooseIconButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::div[2]/div/button[1]/span")
    private WebElement selectSubjectAreaIconImage;

    @FindBy(xpath = "//button[@type='submit']")
    private WebElement newSubjectAreaSaveButton;

    @FindBy(xpath = "//p[contains(.,'Select an icon from the list below')]")
    private WebElement selectIconFromListLabel;

    //    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//button[contains(.,'Delete')][@class=\"btn btn-default\"]")
    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-item asg-panels-active-item')]]//button//span[@class='fa fa-trash']")
    private WebElement deleteSubjectAreaButton;

    @FindBy(xpath = "//tr/td[contains(text(), 'sampleSubjectAreaqaAtm')]")
    private WebElement newSubjectAreaText;

    @FindBy(xpath = "//app-asg-panels/div/div[2]/div/div[1]/button[1]/i")
    private WebElement newSubjectAreaPageExitButton;

    @FindBy(xpath = "//div[@class='center']//div[@class='asg-panels-item select-icon asg-panels-active-item']//button[@class='exit-btn']")
    private WebElement subjectAreaIconExitButton;

    @FindBy(xpath = "//b[contains(.,'SUBJECT AREA ICON')]")
    private WebElement subjectAreaIconPageTitleLabel;

    @FindBy(xpath = "//label[contains(.,'Quick Links')]")
    private WebElement subjectAreaQuickLinksLabel;

    @FindBy(xpath = "//*[@id='quickLinks']/select[1]")
    private WebElement subjectAreaQuickLinksDropDown1;

    @FindBy(xpath = "//*[@id='quickLinks']/select[2]")
    private WebElement subjectAreaQuickLinksDropDown2;

    @FindBy(xpath = "//*[@id='quickLinks']/select[3]")
    private WebElement subjectAreaQuickLinksDropDown3;

    @FindBy(xpath = "//b[contains(.,'NEW CATALOG')]")
    private WebElement newSubjectAreaPageTitleLabel;

    @FindBy(xpath = "//td[contains(.,'BigData')]")
    private WebElement subjectAreaBigData;

    @FindBy(xpath = "//a[@class='list-group-item'][2]//following::p[@class='list-group-item-text']")
    private WebElement subjectAreaViews;

    @FindBy(xpath = "//a[@class='list-group-item']//following::span[2]")
    private WebElement subjectAreaEdit;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//button[contains(text(),'SAVE')]/preceding::button[2]")
    private WebElement itemViewsButton;

    @FindBy(xpath = "//div[@id='existing-views']//button[@id='btn-append-to-body-left']")
    private List<WebElement> existingViewsInAssignViewsPage;

    //@FindBy(xpath = "//span[contains(.,'Tag')]/ancestor::div[@class='btn-group open']//ul[@class='dropdown-menu']//span")
    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu')]]/li")
    private List<WebElement> allItemViewsInDropdown;

    @FindBy(xpath = "//h4[@class='list-group-item-heading']//following::span[1]")
    private WebElement addTagLink;

    @FindBy(xpath = "//h4[@class='list-group-item-heading']")
    private List<WebElement> editCatalogOptions;

    @FindBy(css = "ul[class='dropdown-menu show']>li")
    private List<WebElement> CatalogAdvanceOptionsList;

    @FindBy(css = "ul[class='dropdown-menu workflow-dropdown-width show']>li>a>span")
    private List<WebElement> CatalogAdvanceOptionsWorkflowList;

    //@FindBy(xpath = "//*[@id='tagName']")
    @FindBy(css = "input[id='tagName']")
    private WebElement tagName;

    //@FindBy(xpath = "//*[@id='tagName']")
    @FindBy(css = ".btn.btn-default.asg-edit-tag-button")
    private WebElement newTagSaveButton;

    @FindBy(css = "//h4[contains(text(),'ERROR')]")
    private WebElement errorCatalogpopup;

    //@FindBy(xpath = "//*[@id='tagName']")
    @FindBy(css = ".form-group>label")
    private WebElement definition;

    @FindBy(xpath = "//*[@class='ql-editor ql-blank']")
    private WebElement tagDefinition;

    @FindBy(xpath = "//button[@class[contains(.,'btn btn-default asg-edit-tag-button')]]")
    //@FindBy(xpath = "//button[contains(text(),'SAVE')]")
    private WebElement tagSavebutton;

    @FindBy(xpath = "//h4[contains(.,'Tags')]")
    private WebElement tags;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//following::button[contains(text(),'SAVE')]")
    private WebElement editTagsSavebutton;

    @FindBy(xpath = "//div[@class='buttons-panel']//following::span[contains(text(),'Add Itemview')]")
    private WebElement subjectAreaAddItemViews;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::button[contains(.,'SAVE')]")
    private WebElement addItemViewsSave;

    @FindBy(xpath = "//button[contains(text(),'SAVE')]")
    private WebElement editSubjectAreaSave;

    @FindBy(xpath = "//div[@id='existing-views']//span[@class='fa fa-trash']")
    private WebElement firstItemViewDeleteButton;


    @FindBy(xpath = "//tr[@class='edit-tags-row']//following::span[@class='text-name']")
    private List<WebElement> tagsList;

    @FindBy(xpath = "//div[@class[contains(.,'alert alert-danger')]]")
    private WebElement leadingTrailingSpaceError;

    //@FindBy(xpath="//span[contains(text(),'Add')]")
    @FindBy(css = "div.list-group>a[class='list-group-item']>span")
    private WebElement addTag;

    //@FindBy(xpath="//span[contains(text(),'Create new tag')]")
    @FindBy(css = "div.buttons-panel>button:nth-of-type(2)")
    private WebElement createNewTagButton;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//span[contains(text(),'Delete')]/parent::button")
    private WebElement deleteButton;

//    @FindBy(xpath = "//a[contains(text(),'CATALOG MANAGER')]//following::div[@class='asg-base-widget-recent'][1]//div[@title='"+text+"']")
//    private WebElement catalogManagerList;

    //@FindBy(css="input[type='text'][required=''][name='tagName']")
    //  @FindBy(xpath="//div[@class='form-group'][1]//input")
    //private WebElement NewTagName;

    @FindBy(xpath = "//span[contains(.,'Data Analysis')]")
    private WebElement dataAnalysisTagTemplate;

    @FindBy(xpath = "//span[contains(.,'PII')]")
    private WebElement PIITagTemplate;

    @FindBy(xpath = "//span[contains(.,'Test Tag Template')]")
    private WebElement testTagTemplate;

    @FindBy(css = "div[class='content edit-tags']>div[class='content-table']>table[class='table table-hover']>tbody>tr")
    private List<WebElement> tagList;

    @FindBy(xpath = "//div[@class='content catalogs']//following::tbody/tr/td[2]")
    private List<WebElement> descriptionList;

    @FindBy(css = "a[class='list-group-item disabled']")
    private WebElement viewsSectionDisable;

    @FindBy(xpath = "//button[contains(.,'Add a Tag Template')]")
    private WebElement addTagTemplateButton;

    @FindBy(xpath = "//caption[contains(.,'Select from the tag template below')]")
    private WebElement tagTemplatePageCaption;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//div[@class='list-group']/a")
    private List<WebElement> listOfTagTemplates;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//table//tbody//tr[@class[contains(.,'edit-tags-row root-parent')]][1]//span[@class='text-name']")
    private WebElement firsttagTemplateParenttagName;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//table//tbody//tr[@class[contains(.,'edit-tags-row root-parent')]]//td[@class='right-content']//span[@class='fa fa-times']")
    private WebElement firsttagTemplateParenttagRemoveButton;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//div[@class='submit']/button")
    private WebElement activePanelSaveButton;

    @FindBy(xpath = "//h4[contains(.,'Tags')]/ancestor::a/p")
    private WebElement tagsCount;

    @FindBy(xpath = "//tr[@class[contains(.,'edit-tags-row')]]/td/span[3]")
    private List<WebElement> listOfChildTags;

    @FindBy(css = ".btn.btn-default.asg-edit-tag-button")
    private WebElement saveButtonAfterEditingTag;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//button[@class='exit-btn']/i")
    private WebElement editTagsPageExitButton;

    @FindBy(xpath = "//tr[@class[contains(.,'edit-tags-row')]]")
    private List<WebElement> listOfhiddenChildTags;

    @FindBy(xpath = "//tr[@class[contains(.,'edit-tags-row root-parent')]]//i[@class[contains(.,'fa fa-minus')]]")
    private WebElement parentTagMinusButton;

    @FindBy(xpath = "//tr[@class[contains(.,'edit-tags-row root-parent')]]//i[@class[contains(.,'fa fa-plus')]]")
    private WebElement parentTagPlusButton;

    @FindBy(css = "input[id='catalogName']")
    private WebElement catalogName;

    @FindBy(xpath = "//h4[contains(.,'Views')]")
    private WebElement views;

    @FindBy(xpath = "//div[@class='btn-group dropdown']/button[@id='btn-append-to-body']")
    private List<WebElement> existingItemViewsInAssignViewsPage;

    @FindBy(css = "div[class='left-navigation-item']>span[class='fa fa-home']")
    public WebElement homeButton;

    @FindBy(css = "div[class='asg-panels-item asg-panels-active-item']>div>div>div")
    public WebElement assignViewPanel;

    @FindBy(xpath = "//span[contains(.,'Personal EDI')]//following::span[contains(.,'IP Address')][1]")
    public WebElement personalEDI_childTag;

    @FindBy(xpath = "//b[contains(.,'ADD TAG TEMPLATE')]")
    public WebElement addTagTemplatePanel;

    @FindBy(xpath = "//b[contains(.,'Workflows')]//following::i[@class='fa fa-chevron-down'][1]")
    public WebElement workflowDropdown;

    @FindBy(css = "input[name='searchIcon']")
    public WebElement Searchtextbox;

    @FindBy(xpath="//button[@class='form-control btn btn-default']")
    public WebElement EditCatalogicon;

    public SubjectAreaManagement(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "SubjectAreaManagement Login page");
    }

    @FindBy(css = "button[class='btn btn-default']")
    private WebElement createButtonInDashboardPage;

    @FindBy(xpath = "//div[@class='asg-panels-item-caption-ellipsis' and @title='CREATE ITEM']/b")
    private WebElement createItemPanelText;

    @FindBy(css = "button#createItemCatalogSelection")
    private WebElement createPanelSaveButton;

    @FindBy(css = "button#createItemCatalogSelection")
    private WebElement createPanelSaveAndOpenButton;

    @FindBy(css = "button#createItemCatalogSelection")
    private WebElement createPanelCatalogDropDown;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//following::ul/li[@class='dropdown-item']/a/span")
    private List<WebElement> returnCreatePanelCatalogDropdownSearch;

    @FindBy(css = "button#asgCreateItemTypeSelection")
    private WebElement createPanelCatalogItemTypeDropDown;

    @FindBy(css = "input#name")
    private WebElement createItemName;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//following::ul/li[@role='menuitem']/a/span")
    private List<WebElement> returnCreatePanelCatalogItemTypeDropdownSearch;

    @FindBy(xpath = "//b[contains(.,'CREATE ITEM')]//following::button[@class='exit-btn']")
    private WebElement createItemPanelClose;

    @FindBy(css = "button#asgCreateItemRootTypeSelection")
    private WebElement rootItemTypeFromCreatePanel;

    @FindBy(xpath = "//ul[@role='menu']/li[@role='menuitem']/a/span")
    private List<WebElement> returnRootItemTypeFromCreatePanelDropdownSearch;

    @FindBy(css = "button#asgCreateItemRootItemSelection")
    private WebElement rootItemFromCreatePanel;

    @FindBy(xpath = "//ul[@role='menu']/li[@role='menuitem']/a/span")
    private List<WebElement> returnRootItemFromCreatePanelDropdownSearch;

    @FindBy(xpath = "//div[@class='asg-item-view-multi-properties-widget-body']")
    private WebElement widgetMetadata;

    @FindBy(xpath = "//input[@class='form-control ng-untouched ng-pristine']")
    private List<WebElement> metadataTechnicalDetails;

    @FindBy(xpath = "//div[@class[contains(.,'attr-widget-edit-button')]]/i[@class[contains(.,'fa p-2 fa-pencil')]]")
    private WebElement editButtonForWidgets;

    @FindBy(css = "span[class='fa fa-file-pdf-o']")
    private WebElement pdficon;

    @FindBy(css = "div[class='tooltip-inner']")
    private WebElement tooltip;

    @FindBy(css ="input[id='name']")
    private WebElement CreateFieldName;

    public WebElement getpdficon(){
        synchronizationVisibilityofElement(driver,pdficon);
        return pdficon;
    }

    public WebElement gettooltip(){
        synchronizationVisibilityofElement(driver,tooltip);
        return tooltip;
    }

    public WebElement getCreateFieldName(){
        synchronizationVisibilityofElement(driver,CreateFieldName);
        return CreateFieldName;
    }


    public WebElement getSubjectAreaManagercreateButton() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagercreateButton);
        return SubjectAreaManagercreateButton;
    }

    public WebElement returnSubjectAreaMgmtText() {
        synchronizationVisibilityofElement(driver, newTagName);
        return newTagName;
    }

    public WebElement enter_tagType() {
        synchronizationVisibilityofElement(driver, newTagName);
        return newTagName;
    }

    public WebElement returnnewSubjectAreaName() {
        synchronizationVisibilityofElement(driver, newSubjectAreaName);
        return newSubjectAreaName;
    }

    public WebElement returnnewSubjectAreaDescription() {
        synchronizationVisibilityofElement(driver, newSubjectAreaDescription);
        return newSubjectAreaDescription;
    }

    public WebElement getSubjectAreaName() {
        synchronizationVisibilityofElement(driver, SubjectAreaName);
        return SubjectAreaName;
    }

    public WebElement getSubjectAreaDescription() {
        synchronizationVisibilityofElement(driver, SubjectAreaDescription);
        return SubjectAreaDescription;
    }

    public WebElement returnselectIconFromListLabel() {
        synchronizationVisibilityofElement(driver, selectIconFromListLabel);
        return selectIconFromListLabel;
    }


    public WebElement returnsubjectAreaIconPageTitleLabel() {
        return subjectAreaIconPageTitleLabel;
    }

    public WebElement returnchooseIconButton() {
        synchronizationVisibilityofElement(driver, chooseIconButton);
        return chooseIconButton;
    }

    public WebElement returnSubjectAreaTagField() {
        synchronizationVisibilityofElement(driver, subjectAreaTagField);
        return subjectAreaTagField;
    }


    public WebElement returnSubjectAreaViewsField() {
        synchronizationVisibilityofElement(driver, subjectAreaViewsField);
        return subjectAreaViewsField;
    }

    public WebElement returnsubjectAreaQuickLinksLabel() {
        synchronizationVisibilityofElement(driver, subjectAreaQuickLinksLabel);
        return subjectAreaQuickLinksLabel;
    }

    public WebElement returnsubjectAreaQuickLinksDropDown1() {
        synchronizationVisibilityofElement(driver, subjectAreaQuickLinksDropDown1);
        return subjectAreaQuickLinksDropDown1;
    }

    public WebElement returnsubjectAreaQuickLinksDropDown2() {
        synchronizationVisibilityofElement(driver, subjectAreaQuickLinksDropDown2);
        return subjectAreaQuickLinksDropDown2;
    }

    public WebElement returnsubjectAreaQuickLinksDropDown3() {
        synchronizationVisibilityofElement(driver, subjectAreaQuickLinksDropDown3);
        return subjectAreaQuickLinksDropDown3;
    }

    public WebElement returnnewSubjectAreaPageTitleLabel() {
        synchronizationVisibilityofElement(driver, newSubjectAreaPageTitleLabel);
        return newSubjectAreaPageTitleLabel;
    }


    public void clickFirstElementinSubjectAreapage() {
        synchronizationVisibilityofElement(driver, listedSubjectAreas.get(0));
        clickOn(listedSubjectAreas.get(0));
    }

    public List<WebElement> get_subjectAreaNames() {
        synchronizationVisibilityofElementsList(driver, listedSubjectAreas);
        return listedSubjectAreas;
    }

    public void enterCreateTagProperties() {
        synchronizationVisibilityofElement(driver, createTagProperties.get(0));
        enterText(createTagProperties.get(0), "hello");
    }

    public void clickeditsubjectAreaTagField() {
        synchronizationVisibilityofElement(driver, subjectAreaTagField);
        clickOn(subjectAreaTagField);
    }

    public void clickCreateNewTag() {
        synchronizationVisibilityofElement(driver, createNewTag);
        clickOn(createNewTag);
    }

    public void click_SubjectAreaManagercreateButton() {

        synchronizationVisibilityofElement(driver, SubjectAreaManagercreateButton);
        clickOn(SubjectAreaManagercreateButton);
    }

    public void click_newSubjectAreaCreateButton() {

        synchronizationVisibilityofElement(driver, newSubjectAreaCreateButton);
        clickonWebElementwithJavaScript(driver, newSubjectAreaCreateButton);
    }

    public void click_chooseIconButton() {

        synchronizationVisibilityofElement(driver, chooseIconButton);
        clickonWebElementwithJavaScript(driver, chooseIconButton);
    }

    public void click_selectSubjectAreaIconImage() {

        synchronizationofElementTobeClickable(driver, selectSubjectAreaIconImage);
        clickonWebElementwithJavaScript(driver, selectSubjectAreaIconImage);
    }

    public WebElement getSubjectAreaIconImage() {
//        synchronizationVisibilityofElement(driver, selectSubjectAreaIconImage);
        return selectSubjectAreaIconImage;
    }

    public void click_newSubjectAreaSaveButton() {

        scrollToWebElement(driver, newSubjectAreaSaveButton);
        clickonWebElementwithJavaScript(driver, newSubjectAreaSaveButton);
    }

    public void click_deleteSubjectAreaButton() {

        synchronizationVisibilityofElement(driver, deleteSubjectAreaButton);
        clickOn(deleteSubjectAreaButton);
    }

    public WebElement getnewSubjectAreaText() {
        synchronizationVisibilityofElement(driver, newSubjectAreaText);
        return newSubjectAreaText;
    }

    public WebElement getdeleteSubjectAreaButton() {

        synchronizationVisibilityofElement(driver, deleteSubjectAreaButton);
        return deleteSubjectAreaButton;
    }

    public List<WebElement> returnListOfSubjectAreas() {
        synchronizationVisibilityofElementsList(driver, listedSubjectAreas);
        return listedSubjectAreas;

    }

    public void click_subjectAreaIconExitButton() {

        synchronizationVisibilityofElement(driver, subjectAreaIconExitButton);
        clickOn(subjectAreaIconExitButton);
    }

    public void click_newSubjectAreaPageExitButton() {

        synchronizationVisibilityofElement(driver, newSubjectAreaPageExitButton);
        clickOn(newSubjectAreaPageExitButton);
    }

    public void click_bigDataSubjectArea() {

        synchronizationVisibilityofElement(driver, subjectAreaBigData);
        clickonWebElementwithJavaScript(driver, subjectAreaBigData);
    }

    public String get_subjectAreaViewCount() {

        synchronizationVisibilityofElement(driver, subjectAreaViews);
        return subjectAreaViews.getText();
    }

    public void click_subjectAreaEdit() {

        synchronizationVisibilityofElement(driver, subjectAreaEdit);
        clickOn(subjectAreaEdit);
    }

    public void click_subjectAreaAddItemViews() {

        synchronizationVisibilityofElement(driver, subjectAreaAddItemViews);
        clickOn(subjectAreaAddItemViews);
    }

    public void click_AddItemViewsbutton() {
        synchronizationVisibilityofElement(driver, itemViewsButton);
        clickOn(itemViewsButton);
    }

    public void click_subjectAreaItemViewsSave() {

        synchronizationVisibilityofElement(driver, addItemViewsSave);
        clickOn(addItemViewsSave);
    }

    public void click_editsubjectAreaSave() {

        synchronizationVisibilityofElement(driver, editSubjectAreaSave);
        clickOn(editSubjectAreaSave);
    }

    public List<WebElement> getallItemViewsInDropdown() {

        synchronizationVisibilityofElementsList(driver, allItemViewsInDropdown);
        return allItemViewsInDropdown;
    }

    public void click_firstItemViewDeleteButton() {

        synchronizationVisibilityofElement(driver, firstItemViewDeleteButton);
        clickOn(firstItemViewDeleteButton);
    }

    public void click_addTag() {
        synchronizationVisibilityofElement(driver, addTagLink);
        clickOn(addTagLink);
    }

    public void click_EditCatalogOption(String option) throws Exception {
        traverseListContainsElementAndClick(driver, editCatalogOptions, option);
        sleepForSec(500);
    }

    public WebElement enter_TagName() {
        synchronizationVisibilityofElement(driver, tagName);
        return tagName;
    }

    public WebElement unexpected_error(){
        getElementText(errorCatalogpopup);
        return errorCatalogpopup ;
    }

    public WebElement newTagClickSaveButton() {
        synchronizationVisibilityofElement(driver, newTagSaveButton);
        return newTagSaveButton;
    }

    public WebElement clickDefinition() {
        synchronizationVisibilityofElement(driver, definition);
        return definition;
    }

    public WebElement enter_TagDefinition() {
        synchronizationVisibilityofElement(driver, tagDefinition);
        return tagDefinition;

    }

    public void click_tagSave() {
        synchronizationVisibilityofElement(driver, tagSavebutton);
        clickOn(tagSavebutton);
    }
    public WebElement getTagSave() {
        synchronizationVisibilityofElement(driver, tagSavebutton);
        return tagSavebutton;
    }


    public void click_editTagSave() {
        synchronizationVisibilityofElement(driver, editTagsSavebutton);
        clickOn(editTagsSavebutton);
    }

    public void click_tags() {
        synchronizationVisibilityofElement(driver, tags);
        clickonWebElementwithJavaScript(driver,tags);
    }

    public WebElement getTags() {
        synchronizationVisibilityofElement(driver, tags);
        return tags;
    }

    public List<WebElement> get_tagsList() {
        synchronizationVisibilityofElementsList(driver, tagsList);
        return tagsList;
    }

    public WebElement returntagSavebutton() {
        synchronizationVisibilityofElement(driver, tagSavebutton);
        return tagSavebutton;
    }


    public WebElement returnnewSubjectAreaPageTitleLabelWithNoSync() {

        return newSubjectAreaPageTitleLabel;
    }

    public WebElement leadingTrailingError() {
        synchronizationVisibilityofElement(driver, leadingTrailingSpaceError);
        return leadingTrailingSpaceError;
    }

    public WebElement newSubjectAreaSaveButtonEnable() {

        synchronizationVisibilityofElement(driver, newSubjectAreaSaveButton);
        return newSubjectAreaSaveButton;
    }

    public void Click_AddTag() {

        synchronizationVisibilityofElement(driver, addTag);
        clickOn(addTag);
    }

    public void Click_CreateNewTagButton() {

        synchronizationVisibilityofElement(driver, createNewTag);
        clickonWebElementwithJavaScript(driver,createNewTag);
    }

    @Override
    public void synchronizationVisibilityofAlert(WebDriver driver) {
        super.synchronizationVisibilityofAlert(driver);
    }

    public WebElement returndataAnalsysisTagTemplate() {
        synchronizationVisibilityofElement(driver, dataAnalysisTagTemplate);
        return createNewTag;
    }

    public WebElement returnPIITagTemplate() {
        synchronizationVisibilityofElement(driver, PIITagTemplate);
        return PIITagTemplate;
    }

    public WebElement returntestTagTemplate() {
        synchronizationVisibilityofElement(driver, testTagTemplate);
        return testTagTemplate;
    }

    public List<WebElement> returntagList() {
        return tagList;
    }

    public List<WebElement> returnListOfDescription() {
        synchronizationVisibilityofElementsList(driver, descriptionList);
        return descriptionList;

    }

    public WebElement getViewsSectionDisable() {
        synchronizationVisibilityofElement(driver, viewsSectionDisable);
        return viewsSectionDisable;
    }

    public WebElement getaddTagTemplateButton() {
        synchronizationVisibilityofElement(driver, addTagTemplateButton);
        return addTagTemplateButton;
    }

    public WebElement gettagTemplatePageCaption() {
        synchronizationVisibilityofElement(driver, tagTemplatePageCaption);
        return tagTemplatePageCaption;
    }

    public List<WebElement> getlistOfTagTemplates() {
        synchronizationVisibilityofElementsList(driver, listOfTagTemplates);
        return listOfTagTemplates;
    }

    public WebElement getfirsttagTemplateParenttagName() {
        synchronizationVisibilityofElement(driver, firsttagTemplateParenttagName);
        return firsttagTemplateParenttagName;
    }

    public WebElement getfirsttagTemplateParenttagNameWithoutSync() {
        return firsttagTemplateParenttagName;
    }

    public WebElement getfirsttagTemplateParenttagRemoveButton() {
        synchronizationVisibilityofElement(driver, firsttagTemplateParenttagRemoveButton);
        return firsttagTemplateParenttagRemoveButton;
    }

    public WebElement getactivePanelSaveButton() {
        synchronizationVisibilityofElement(driver, activePanelSaveButton);
        return activePanelSaveButton;
    }

    public WebElement gettagsCount() {
        synchronizationVisibilityofElement(driver, tagsCount);
        return tagsCount;
    }

    public WebElement getDynamicChildTagRemoveButton(String text) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::span[contains(.,'" + text + "')]/following::span[@class='fa fa-times'][1]"));
    }

    public List<WebElement> getlistOfChildTags() {
        return listOfChildTags;
    }

    public List<WebElement> getlistOfhiddenChildTags() {
        return listOfhiddenChildTags;
    }

    public WebElement getsaveButtonAfterEditingTag() {
        synchronizationVisibilityofElement(driver, saveButtonAfterEditingTag);
        return saveButtonAfterEditingTag;
    }

    public WebElement getDynamicParentTagEditButton(String text) {
        return driver.findElement(By.xpath("//tr[@class='edit-tags-row root-parent']//span[contains(.,'" + text + "')]/ancestor::tr//span[@class='fa fa-pencil']"));
    }

    public WebElement getDynamicChildTagEditButton(String text) {
        return driver.findElement(By.xpath("//tr[@class='edit-tags-row']//span[contains(.,'" + text + "')]/ancestor::tr//span[@class='fa fa-pencil']"));
    }

    public WebElement returnTagName() {
        synchronizationVisibilityofElement(driver, tagName);
        return tagName;
    }

    public WebElement returnTagDefinition() {
        synchronizationVisibilityofElement(driver, tagDefinition);
        return tagDefinition;

    }

    //tr[@class='edit-tags-row']//span[contains(.,'text')]
    public WebElement getDynamicTagInTagStructurePage(String text) {
        return driver.findElement(By.xpath("//tr[@class='edit-tags-row root-parent']//td//span[contains(.,'" + text + "')]"));
    }

    public WebElement getDynamicParentTag(String text) {
        return driver.findElement(By.xpath("//tr[@class[contains(.,'edit-tags-row root-parent')]]/td[contains(.,'" + text + "')]"));
    }

    public WebElement getDynamicChildTag(String text) {
        return driver.findElement(By.xpath("//tr[@class[contains(.,'edit-tags-row')]]//span[contains(.,'" + text + "')]"));
        //return driver.findElement(By.xpath("//tr[@class='edit-tags-row']//span[contains(.,'"+text+"')]"));
    }

    public WebElement getDynamicParentAndChildTag(String parentTag, String childTag) {
        return driver.findElement(By.xpath("//tr[@class='edit-tags-row root-parent']/td//span[contains(.,'" + parentTag + "')]//following::span[contains(.,'" + childTag + "')]"));
        //return driver.findElement(By.xpath("//tr[@class='edit-tags-row']//span[contains(.,'"+text+"')]"));
    }

    public WebElement geteditTagsPageExitButton() {
        synchronizationVisibilityofElement(driver, editTagsPageExitButton);
        return editTagsPageExitButton;
    }

    public WebElement getparentTagMinusButton() {
        synchronizationVisibilityofElement(driver, parentTagMinusButton);
        return parentTagMinusButton;
    }

    public WebElement getparentTagPlusButton() {
        synchronizationVisibilityofElement(driver, parentTagPlusButton);
        return parentTagPlusButton;
    }

    public WebElement getDynamicChildTagLeftTriangleButton(String text) {
        return driver.findElement(By.xpath("//tr[@class[contains(.,'edit-tags-row')]]//span[contains(.,'" + text + "')]/ancestor::td//span[@class='fa fa-caret-left']"));
    }

    public WebElement getDynamicChildTagRightTriangleButton(String text) {
        return driver.findElement(By.xpath("//tr[@class='edit-tags-row']//span[contains(.,'" + text + "')]/ancestor::td//span[@class='glyphicon glyphicon-triangle-right']"));
    }

    public void clickCatalogManager(String text) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//a[contains(text(),'CATALOG MANAGER')]//following::div[@class='asg-base-widget-recent'][1]//div[@title='" + text + "']//a")));
    }

    public List<WebElement> getexistingViewsInAssignViewsPage() {
        synchronizationVisibilityofElementsList(driver, existingViewsInAssignViewsPage);
        return existingViewsInAssignViewsPage;
    }

    public WebElement enterCatalogName() {
        synchronizationVisibilityofElement(driver, catalogName);
        return catalogName;
    }

    public WebElement getEditCatalogicon()
    {
        synchronizationVisibilityofElement(driver,EditCatalogicon);
        return EditCatalogicon;
    }

    public void click_views() {
        synchronizationVisibilityofElement(driver, views);
        clickOn(views);
    }

    public List<WebElement> getexistingItemViewsInAssignViewsPage() {
        synchronizationVisibilityofElementsList(driver, existingItemViewsInAssignViewsPage);
        return existingItemViewsInAssignViewsPage;
    }

    public WebElement getSubjectAreaItemViewsSaveButton() {

        synchronizationVisibilityofElement(driver, addItemViewsSave);
        return addItemViewsSave;
    }

    public void clickButtonInPanel(String buttonName) {
        clickOn(driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-active-item')]]//following::button[contains(.,'" + buttonName + "')]")));
    }

    public void click_SubjectArea(String text) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//td[contains(.,'" + text + "')]")));
    }

    public WebElement getHomeButton() {
        synchronizationVisibilityofElement(driver, homeButton);
        return homeButton;
    }

    public WebElement getDeleteButton() {
        synchronizationVisibilityofElement(driver, deleteButton);
        return deleteButton;
    }


    public WebElement getParentAndChildTag(String child, String parent) {
        return driver.findElement(By.xpath("//span[contains(.,'" + child + "')]/preceding::tr/td/span[contains(.,'" + parent + "')]"));
    }

    public WebElement getChildTagRemoveButton(String parent, String child) {
        return driver.findElement(By.xpath("//span[contains(.,'" + parent + "')]//following::span[contains(.,'" + child + "')]/following::span[@class='fa fa-times'][1]"));
    }

    public WebElement getPersonalEDI_ChildTag() {
        return personalEDI_childTag;
    }

    public WebElement getFieldTextBox(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::label[contains(text(),'" + fieldName + "')]//following::input[1]"));
    }

    public WebElement getFieldAlertMesssage(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//following::label[contains(.,'" + fieldName + "')]//following::div[@class='alert alert-danger']"));
    }

    public WebElement getAddTagTemplatePanel() {
        synchronizationVisibilityofElement(driver, addTagTemplatePanel);
        return addTagTemplatePanel;
    }

    public void clickCatalogAdvanceOptionsDropdown(String option) {
        clickOn(driver,driver.findElement(By.xpath("//span[contains(.,'"+option+"')]//following::span[2]/em[@class='fa fa-caret-down']")));
    }

    public void click_CatalogAvanceOption(String option) throws Exception {
        traverseListContainsElementAndClick(driver, CatalogAdvanceOptionsList, option);
    }

    public void clickCatalogAdvanceOptionsDropdownForWorkflows(String option) {
        clickOn(driver, workflowDropdown);
    }

    public void click_CatalogAdvanceWorkflowOption(String option) throws Exception {
        traverseListContainsElementAndClick(driver, CatalogAdvanceOptionsWorkflowList, option);
    }

    public WebElement getCatalogAdvanceWorkflowOptionFromList(String option) {
        return driver.findElement(By.xpath("//b[contains(.,'Workflows')]//following::li/a[@class='dropdown-item']/span[contains(.,'"+option+"')]"));
    }

    public void click_CatalogAvanceWorkflowOptionFromList(String option) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//b[contains(.,'Workflows')]//following::li/a[@class='dropdown-item']/span[contains(.,'"+option+"')]")));
    }

    public WebElement getCreateButtonInDashboardPage() {
        synchronizationVisibilityofElement(driver, createButtonInDashboardPage);
        return createButtonInDashboardPage;
    }

    public WebElement getCreateItemPanelClose() {
        synchronizationVisibilityofElement(driver, createItemPanelClose);
        return createItemPanelClose;
    }

    public WebElement getCreateItemPanelText() {
        synchronizationVisibilityofElement(driver, createItemPanelText);
        return createItemPanelText;
    }

    public void clickCreateItemSaveButtons(String elementType) {
        clickOn(driver.findElement(By.xpath("//div[@class='asg-create-item-save']/button[contains(.,'" + elementType + "')]")));
    }

    public WebElement getCreateItemSaveButtons(String elementType) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class='asg-create-item-save']/button[contains(.,'" + elementType + "')]")));
        return driver.findElement(By.xpath("//div[@class='asg-create-item-save']/button[contains(.,'" + elementType + "')]"));
    }

    public void clickOnCreateItemSaveButtons(String buttonName) {
        clickonWebElementwithJavaScript(driver, getCreateItemSaveButtons(buttonName));
    }

    public WebElement getCreatePanelCatalogDropDown() {
        synchronizationVisibilityofElement(driver, createPanelCatalogDropDown);
        return createPanelCatalogDropDown;
    }

    public WebElement getCreatePanelCatalogItemTypeDropDown() {
        synchronizationVisibilityofElement(driver, createPanelCatalogItemTypeDropDown);
        return createPanelCatalogItemTypeDropDown;
    }

    public void getCreatePanelCatalogDropdownSearch(String catalogName) throws Exception {
        traverseListContainsElementAndClick(driver,returnCreatePanelCatalogDropdownSearch, catalogName);
    }

    public void getCreatePanelCatalogItemTypeDropdownSearch(String typeName) throws Exception {
        traverseListContainsElementAndClick(driver,returnCreatePanelCatalogItemTypeDropdownSearch, typeName);
    }

    public WebElement getRootItemTypeFromCreatePanel() {
        synchronizationVisibilityofElement(driver, rootItemTypeFromCreatePanel);
        return rootItemTypeFromCreatePanel;
    }

    public void getRootItemTypeFromCreatePanelDropdownSearch(String type) throws Exception {
        traverseListContainsElementAndClick(driver,returnRootItemTypeFromCreatePanelDropdownSearch, type);
    }

    public WebElement getRootItemFromCreatePanel() {
        synchronizationVisibilityofElement(driver, rootItemFromCreatePanel);
        return rootItemFromCreatePanel;
    }

    public void getRootItemFromCreatePanelDropdownSearch(String type) throws Exception {
        traverseListContainsElementAndClick(driver,returnRootItemFromCreatePanelDropdownSearch, type);
    }

    public WebElement getTextFieldElements(String elementType) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@class[contains(.,'form-group')]]/div/label/strong[contains(text(),'"+elementType+"')]//following::input[1]")));
        return driver.findElement(By.xpath("//div[@class[contains(.,'form-group')]]/div/label/strong[contains(text(),'"+elementType+"')]//following::input[1]"));
    }

    public WebElement getRadioBoxElements(String radioButtonName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//ui-switch[@id[contains(.,'" + radioButtonName + "')]]")));
        return driver.findElement(By.xpath("//ui-switch[@id[contains(.,'" + radioButtonName + "')]]"));
    }

    public WebElement getMetaDataWidget() {
        synchronizationVisibilityofElement(driver, widgetMetadata);
        return widgetMetadata;
    }

    public WebElement getEditButtonInWidget() {
        synchronizationVisibilityofElement(driver, editButtonForWidgets);
        return editButtonForWidgets;
    }

    public List<WebElement> getWidgetMetadataTechnicalDetails() {
        synchronizationVisibilityofElementsList(driver, metadataTechnicalDetails);
        return metadataTechnicalDetails;
    }

    public WebElement returnSearchtextbox()
    {
        synchronizationVisibilityofElement(driver,Searchtextbox);
        return Searchtextbox;
    }

    public WebElement getDynamicItem(String itemName) {
        return driver.findElement(By.xpath("//a[@class='asg-search-list-item-name text-truncate'][contains(.,'"+itemName+"')]"));
    }

    public List<WebElement> getQualityValue(String qualityValue) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'item-view-quality-text')]]/span[contains(text(),'"+qualityValue+"')]"));
    }

    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void enterActions(String elementType, String text) {
        try {
            switch (elementType) {
                case "catalog name and description":
                    enterText(returnnewSubjectAreaName(), text);
                    enterText(returnnewSubjectAreaDescription(), jsonRead.readJSon("createNewSubjectArea", "Description"));
                    break;
                case "CatalogName":
                    enterText(enterCatalogName(), text);
                    break;
                case "CatalogDescription":
                    enterText(returnnewSubjectAreaDescription(), text);
                    break;
                case "SearchText":
                    enterText(returnSearchtextbox(),text);
                    break;
                case"Icon":
                    enterText(returnSearchtextbox(),text);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericClick(String elementType, String... dynamicItem) {
        try {
            switch (elementType) {
                case "Schemas, Types and Attributes":
                    sleepForSec(300);
                    click_EditCatalogOption(elementType);
                    sleepForSec(500);
                    break;
                case "Schemas":
                    clickCatalogAdvanceOptionsDropdown(elementType);
                    click_CatalogAvanceOption(dynamicItem[0]);
                    clickonWebElementwithJavaScript(driver, getSubjectAreaItemViewsSaveButton());
                    clickonWebElementwithJavaScript(driver, getSubjectAreaItemViewsSaveButton());
                    break;
                case "Types":
                    new SubjectAreaManagement(driver).clickCatalogAdvanceOptionsDropdown(elementType);
                    new SubjectAreaManagement(driver).click_CatalogAvanceOption(dynamicItem[0]);
                    break;
                case "Workflows":
                    new SubjectAreaManagement(driver).clickCatalogAdvanceOptionsDropdownForWorkflows(elementType);
                    sleepForSec(300);
                    scrolltoElement(driver,getCatalogAdvanceWorkflowOptionFromList(dynamicItem[0]),true);
                    new SubjectAreaManagement(driver).click_CatalogAvanceWorkflowOptionFromList(dynamicItem[0]);
                    sleepForSec(300);
                    clickonWebElementwithJavaScript(driver, getSubjectAreaItemViewsSaveButton());
                    sleepForSec(300);
                    clickonWebElementwithJavaScript(driver, getSubjectAreaItemViewsSaveButton());
                    sleepForSec(500);
                    break;
                case "Test Data1":
                    clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(returnListOfSubjectAreas(), jsonRead.readJSon("selectingSubjectAreaFromList1", "Name")));
                    break;
                case "Test Data2":
                    clickOn(driver, traverseListContainsElementReturnsElement(returnListOfSubjectAreas(), jsonRead.readJSon("selectingSubjectAreaFromList2", "Name")));
                    break;
                case "Test Data3":
                    clickOn(driver, traverseListContainsElementReturnsElement(returnListOfSubjectAreas(), jsonRead.readJSon("createNewSubjectArea4", "Name")));
                    break;
                case "BigData":
                    clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(returnListOfSubjectAreas(), elementType));
                    break;
                case "SAVE":
                    clickButtonInPanel(elementType);
                    break;
                case "AnalysisItem":
                    clickOn(getDynamicItem(dynamicItem[0]));
                    sleepForSec(1000);
                    break;
                case "edit Tags Page Exit Button":
                    clickOn(geteditTagsPageExitButton());
                    break;
                case "Create button":
                    clickOn(driver, getCreateButtonInDashboardPage());
                    break;
                case "Create panel close button":
                    clickOn(driver, getCreateItemPanelClose());
                    break;
                case "Save":
                    Assert.assertTrue(new SubjectAreaManagement(driver).getCreateItemSaveButtons(elementType).isEnabled());
                    clickCreateItemSaveButtons(elementType);
                    break;
                case "Save and open":
                    Assert.assertTrue(new SubjectAreaManagement(driver).getCreateItemSaveButtons(elementType).isEnabled());
                    clickCreateItemSaveButtons(elementType);
                    sleepForSec(2000);
                    break;
                case "Catalog dropdown":
                    clickOn(driver, getCreatePanelCatalogDropDown());
                    getCreatePanelCatalogDropdownSearch(dynamicItem[0]);
                    break;
                case "Type dropdown":
                    clickOn(driver, getCreatePanelCatalogItemTypeDropDown());
                    getCreatePanelCatalogItemTypeDropdownSearch(dynamicItem[0]);
                    break;
                case "Root Item Type":
                    clickOn(driver, getRootItemTypeFromCreatePanel());
                    getRootItemTypeFromCreatePanelDropdownSearch(dynamicItem[0]);
                    break;
                case "Root Item Name":
                    clickOn(driver, getRootItemFromCreatePanel());
                    getRootItemFromCreatePanelDropdownSearch(dynamicItem[0]);
                    break;
                case "matchFull":
                    clickOn(driver, getRadioBoxElements(elementType));
                    break;
                case "Create":
                    new SubjectAreaManagement(driver).click_newSubjectAreaCreateButton();
                    break;
                case "icon":
                    clickonWebElementwithJavaScript(driver,returnchooseIconButton());
                    break;
                case "CatalogIcon":
                    clickOn(getEditCatalogicon());
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Issue in identifying element");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying element");
                }
        }







    public void genericVerifyDisabled(String elementType) {
        try {
            switch (elementType) {
                case "Save":
                    Assert.assertFalse(new SubjectAreaManagement(driver).getCreateItemSaveButtons(elementType).isEnabled());
                    break;
                case "Save and open":
                    Assert.assertFalse(new SubjectAreaManagement(driver).getCreateItemSaveButtons(elementType).isEnabled());
                    break;
                case "Technical details":
                    Iterator<WebElement> iter = getWidgetMetadataTechnicalDetails().iterator();
                    while (iter.hasNext()) {
                        WebElement fields = iter.next();
                        Assert.assertFalse(fields.isEnabled());
                    }
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementPresent(String elementName,String... dynamicItem) {
        try {
            switch (elementName) {
                case "widget edit button":
                    sleepForSec(1500);
                    clickOn(driver.findElement(By.xpath("//div[@class='asg-item-view-multi-properties-widget-body']")));
//                    clickOn(driver, getMetaDataWidget());
                    sleepForSec(1000);
                    Assert.assertTrue(isElementPresent(getEditButtonInWidget()));
                    clickonWebElementwithJavaScript(driver, getEditButtonInWidget());
                    break;
                case "pdf":
                    moveToElement(driver,getpdficon());
                    verifyEquals(dynamicItem[0],gettooltip().getText());
                    break;
                case "FieldName":
                    keyPressEvent(driver, Keys.TAB);
                    keyPressEvent(driver, Keys.TAB);
                    verifyEquals(dynamicItem[0],getFieldAlertMesssage("Name").getText());
                    break;
                case "Quality":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getQualityValue(dynamicItem[0]).get(0)));
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementNotPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Quality":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getQualityValue(dynamicItem[0]).isEmpty());
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

}
