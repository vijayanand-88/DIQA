package com.asg.automation.pageobjects.idc;


import com.amazonaws.regions.Regions;
import com.asg.automation.pageactions.idc.DashboardActions;
import com.asg.automation.pageactions.idc.QuickStartActions;
import com.asg.automation.pageobjects.ida.AnalysisPage;
import com.asg.automation.stepdefinition.restapi.RESTAPIDefinition;
import com.asg.automation.utils.*;
import com.asg.automation.wrapper.RestAPIWrapper;
import com.asg.automation.wrapper.UIWrapper;
import com.asg.utils.AWSutil.S3Util;
import com.google.common.collect.Ordering;
import jodd.util.collection.SortedArrayList;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.Select;
import org.testng.Assert;

import javax.json.Json;
import java.io.IOException;
import java.time.Duration;
import java.util.*;
import java.util.stream.Collectors;

import static com.asg.automation.utils.Constant.REST_DIR;

/**
 * Created by thirveni.moganlal on 5/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class SubjectArea extends UIWrapper {

    private WebDriver driver;
    private DBHelper dbHelper = new DBHelper();
    private JsonRead jsonRead = new JsonRead();
    public CommonUtil commonUtil = new CommonUtil();
    public ExcelDataLoaderUtil ExcelUtil=new ExcelDataLoaderUtil();

    @FindBy(xpath = "//label[@for='BigData']")
    private WebElement bigDataCheckbox;

    @FindBy(xpath = "//div[@title='Table']//preceding::label[@for][1]")
    private WebElement tableFacetSelectionCheckbox;

    @FindBy(xpath = "//table[@class='table table-responsive table-condensed cf']//tbody//following::td[@data-title='Tags']//a")
    private WebElement itemListTag;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-list-item')]][1]//div[@class='flex-grow-1 d-flex flex-wrap text-truncate'][1]/a[1]")
    private WebElement firstItemListName;

    @FindBy(xpath = "//th[contains(.,'NAME')]")
    private WebElement returnsort;


    @FindBy(xpath = "//tbody/tr/td[@class[contains(.,'asg-item-list-ellipsis asg-item-name')]]")
    private List<WebElement> searchItemResults;

    @FindBy(css = "table[class='table table-responsive table-condensed cf']>tbody>tr:nth-child(2)>td[data-title='type']")
    private WebElement firstItemType;

    @FindBy(xpath = "//span[contains(.,'If you close this panel, your existing work will not be saved')]")
    private WebElement mutliplePanelWarning;

    @FindBy(xpath = "//span[contains(.,'Do you still wish to close this panel?')]")
    private WebElement mutliplePanelWarning_text;

    //@FindBy(xpath = "//button[contains(.,'YES')]")
    @FindBy(css = "button[class='btn asg-modal-confirm-btn float-right']")
    private WebElement acceptWarning;

    @FindBy(css = "button[class='btn asg-modal-confirm-btn float-right']")
    private List<WebElement> acceptWarningPopup;

    @FindBy(xpath = "//button[contains(.,'CANCEL')]")
    private WebElement dismissWarning;

    @FindBy(xpath = "//span[contains(.,'Search Results')]")
    private WebElement resultsVerification;

    @FindBy(xpath = "//div[@class='item-list']")
    private WebElement itemListTable;

    @FindBy(xpath = "//div[@class='asg-tag-list']")
    private WebElement subjectAreaTagStructure;

    @FindBy(xpath = "//div[@class='item-list']//div[@class[contains(.,'text-center asg-item-list-pagination')]]//ul[@class='pagination pagination-sm text-center justify-content-center']/li/a")
    private List<WebElement> itemListPagination;

    @FindBy(xpath = "//div[@class='item-list']//div[@class[contains(.,'text-center asg-item-list-pagination')]]//ul[@class='pagination pagination-sm text-center justify-content-center']/li")
    private List<WebElement> itemListPaginationClassNames;

    @FindBy(xpath = "//li[@class='page-item']/a[@aria-label='Next']")
    private WebElement paginationNextButton;

    @FindBy(xpath = "//li[@class='pagination-next page-item']/a")
    private WebElement paginationNextButton_Active;

    @FindBy(xpath = "//li[@class='page-item']//a [@aria-label='Previous']")
    private WebElement paginationPreviousButton;

    @FindBy(xpath = " //a[contains(.,'2')]")
    private WebElement paginationSecondPageButton;

    @FindBy(xpath = "//li[@class[contains(.,'pagination-first page-item')]]/a")
    private WebElement paginationFirstButton;

    @FindBy(xpath = "//li[@class[contains(.,'pagination-last page-item')]]/a")
    private WebElement paginationLastButton;

    @FindBy(xpath = "//div[@title='Cluster Demo [Cluster]']/preceding::div[@class[contains(.,'asg-toggle-button-holder')]][1]")
    private WebElement dataAnalysisTagCollapsingTriangleButton;

    @FindBy(xpath = "//button[@class='btn btn-default asg-facet-toggle-sign pull-right']/i[@class='glyphicon glyphicon-menu-down']")
    private WebElement dataAnalysisTagExpandingTriangleButton;

    @FindBy(xpath = "//div[@title='Cluster Demo [Cluster]']/following::div[@class='asg-facet-tree-item-holder text-left asg-facet-item-ellipsis']")
    private List<WebElement> dataAnalysisSubTags;
    ////div[@title='Cluster Demo [Cluster]']//following::div[@class='asg-facet-tree-item-holder text-left asg-facet-item-ellipsis']

    @FindBy(xpath = "//span[contains(.,'Quality')]")
    private WebElement qualityLabel;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-item-view asg-panels-active-item']//following::span[contains(.,'QUALITY')]")
    private WebElement qualityLabelInCurrentpanel;

    @FindBy(xpath = "//span[contains(.,'QUALITY')]")
    private WebElement previewItemQualityLabel;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-list-items')]]//div[1]/span[1]")
    private List<WebElement> tableOfItemsFound;

    @FindBy(xpath = "//div[@class[contains(.,'no-more-tables')]]//tbody/tr[2]/td[3]/span")
    private WebElement itemsFound;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]")
    private WebElement itemPreviewPage;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item full-size-item')]]")
    private WebElement itemFullViewPage;

    @FindBy(xpath = "//div[@class='table-container']")
    private WebElement DataSamplingTable;

    @FindBy(css = "div[class='no-more-tables ng-star-inserted'] >table >tbody >tr >td >bs-tooltip-container")
    private List<WebElement> datatooltip;

    @FindBy(xpath = "//p[@class='name-and-type']/b")
    private WebElement itemText;

    @FindBy(xpath = "//input[contains(@placeholder,'Search...')]")
    private WebElement searchBox;

    @FindBy(xpath = "//span[@class='input-group-addon search-addon'][1]/span")
    private WebElement searchButton;

    @FindBy(xpath = "//strong[contains(.,'Metadata Type')][1]//following::div[contains(@class,'asg-show-more-facet')][1]/span[contains(.,'Show More')]")
    private WebElement ShowAll_facet_Button;

    @FindBy(xpath = "//div[@role='progressbar']")
    private WebElement qualityColorBar;

    @FindBy(xpath = "//div[contains(@style,'background-color: rgb(219, 195, 73)')]")
    private WebElement qualityColorYellow;

    @FindBy(xpath = "//div[contains(@style,'background-color: rgb(255, 94, 86)')]")
    private WebElement qualityColorRed;

    @FindBy(xpath = "//div[contains(@style,'background-color: rgb(92, 196, 109)')]")
    private WebElement qualityColorGreen;

    @FindBy(xpath = "//div[@class='progress']//div[contains(@style,'background-color: rgb(165, 156, 156)')]")
    private WebElement qualityColorNotApply;

    @FindBy(xpath = "//div[@class='progress']//following::span[1]")
    private WebElement qualityLabelDescription;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-item-dynamic-caption')]]//following::i[@class='fa fa-expand']")
    private WebElement fullScreenButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-item-dynamic-caption')]]//following::i[@class='fa fa-compress']")
    private WebElement compressScreenButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//following::i[@class='fa fa-expand']")
    private WebElement fullviewIcon;

    @FindBy(xpath = "//div[@class='asg-item-view-table-widget-container']//p//span[contains(text(),'LINEAGE SOURCE')]//following::div//span[1]")
    private WebElement lineagesource;

    @FindBy(xpath = "//div[@class='asg-item-view-table-widget-container']//p//span[contains(text(),'LINEAGE TARGET')]//following::div//span[1]")
    private WebElement lineagetarget;

    @FindBy(xpath = "//b[contains(.,'RESULTS')]")
    private WebElement itemListPageTitle;

    @FindBy(xpath = "//a[contains(.,'Overview')]")
    private WebElement itemOverviewAccessPoint;

    @FindBy(xpath = "//a[contains(.,'DATA SAMPLING')]")
    private WebElement itemDataSamplingAccessPoint;

    @FindBy(xpath = "//a[contains(.,'LINEAGE')]")
    private WebElement itemLineageAccessPoint;

    @FindBy(xpath = "//a[contains(.,'Comments')]")
    private WebElement itemCommentsAccessPoint;

    @FindBy(xpath = "//div[@class='asg-item-comments-header']/span[contains(text(),'COMMENTS')]")
    private WebElement itemComments;

    @FindBy(xpath = "//span[@class[contains(.,'asg-item-comments-count')]]")
    private WebElement itemCommentsCount;

    @FindBy(xpath = "//button[contains(.,'View All')]")
    private WebElement viewAllComments;

    @FindBy(css = ".pull-left.asg-item-comments-text")
    private WebElement commentsSection;

    @FindBy(xpath = "//textarea[@placeholder='Leave comment']")
    private WebElement enterComments;

    @FindBy(xpath = "//button[@class='asg-comments-reply-btn asg-comments-send-btn']")
    private WebElement postComments;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-block')]]")
    private WebElement commentsContainer;

    @FindBy(xpath = "//input[@id='Cluster/Cluster Demo']/..")
    private WebElement dataAnalysisCheckbox;

    @FindBy(xpath = "//div[@class='asg-breadcrumb-content']/div/span[2]")
    private List<WebElement> previewPageItemFullQualifiedName;

    @FindBy(xpath = "//div[@class='asg-breadcrumb-content']/div/span[2]")
    private List<WebElement> fullviewPageItemFullQualifiedName;

    @FindBy(css = ".asg-item-view-multi-properties-widget-title")
    private WebElement fullviewPageItemPropertiesTitle;

    //@FindBy(xpath = "//div[@class='asg-panels-item asg-item-view asg-panels-active-item']//p[contains(.,'PROPERTIES')]")
    @FindBy(xpath = "//div[@class='asg-item-view-multi-properties-widget']")
    private WebElement previewPageMetaDataTitle;

    @FindBy(xpath = "//p[contains(text(),'METADATA')]")
    private List<WebElement> previewPageItemPropertiesList;

    @FindBy(xpath = "//p[contains(text(),'METADATA')]")
    private List<WebElement> fullviewPageItemPropertiesList;

    //@FindBy(xpath = "//span[contains(.,'COMMENTS')]")
    @FindBy(css = "div[class='asg-comments-full-size-header float-left']")
    private WebElement commentLabel;

    @FindBy(xpath = "//div[@class='asg-item-no-comments']")
    private WebElement noCommentsLabel;

    @FindBy(css = "button[class='float-right asg-item-show-comments']")
    private WebElement leaveCommentButton;

    @FindBy(xpath = "//textarea[@placeholder='Leave comment']")
    private WebElement commentTextBox;

    @FindBy(xpath = "//button[contains(text(),' POST COMMENT ')]")
    private WebElement postCommentButton;

    @FindBy(xpath = "//div[contains(text(),'SHOW COMMENTS FROM')]")
    private WebElement showCommentText;

    @FindBy(xpath = "//button[@class='btn asg-comment-dropdown-btn clearfix']")
    private WebElement commentsDropdownButton;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu')]]/li")
    private List<WebElement> commentsDropdownList;

    @FindBy(css = "div[class='asg-comments-body']")
    private WebElement commentBody;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-body')]]/span[3]")
    private List<WebElement> commentsList;

    @FindBy(xpath = " //div[@class[contains(.,'asg-panels-active-item')]]//p[@class='name-and-type']/b")
    private WebElement itemNameHeader;

    @FindBy(xpath = " //div[@class[contains(.,'asg-panels-active-item')]]//p[@class='name-and-type']/span")
    private WebElement itemType;

    @FindBy(xpath = "//table[@class='table table-responsive table-condensed cf']//tbody//tr/td[4]")
    private List<WebElement> listOfItemTypesIntableOfItemsFound;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-block')]][1]//div[@class[contains(.,'asg-comments-body')]]//button[contains(.,'delete')]")
    private WebElement commentDeleteButton;

    @FindBy(xpath = "//button[contains(text(),'Yes')]")
    private WebElement AlertYes;

    @FindBy(xpath = "//button[contains(text(),'Yes')]")
    private List<WebElement> AlertYesInList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-body')]]//button[contains(.,'edit')]")
    private WebElement EditCommentButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-block')]][1]//button[@class='asg-comments-reply-btn']")
    private WebElement firstCommentReplyButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-body-edit')]]//textarea")
    private WebElement editCommentTextBox;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-body-edit')]]//button[contains(text(),'save')]")
    private WebElement saveButtonofeditCommentTextox;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-block')]][1]//span[3]")
    private WebElement firstCommentText;

    @FindBy(xpath = "//textarea[@placeholder='Write a reply']")
    private WebElement replyToConmmentBox;

    @FindBy(xpath = "(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'ID')])//following-sibling::span[@class='list-group-item-right']//span)[2]")
    private WebElement functionid;

    @FindBy(xpath = "(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'ID')])//following-sibling::span[@class='list-group-item-right']//span)[3]")
    private WebElement lineageid;

    @FindBy(xpath = "//textarea[@placeholder='Write a reply']//following::button")
    private WebElement sendButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-inner-comment clearfix')]][1]//span[3]")
    private WebElement textOfFirstReplyOfComment;

    @FindBy(xpath = "//div[@class[contains(.,'asg-comments-body')]]//span[@class='float-right asg-comments-gray']")
    private WebElement timeStampOfComment;

    @FindBy(xpath = "//div[@class='asg-comments-container']//div[@class='asg-comments-img']")
    private WebElement imgaeIconOfComment;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//button[@class='exit-btn']")
    private WebElement closeButton;

    @FindBy(css = "div[class='asg-search-flat-list-widget asg-item-checked']>div>div>div>label[for='BigData']")
    private WebElement bigDataFacetCheckbox;

    @FindBy(xpath = "//div[@title='BigData']//preceding::label[@for][1]")
    private WebElement bigDataFacetEmptyCheckBox;

    @FindBy(xpath = "//div[@title='Table']//preceding::label[@for][1]")
    private WebElement tableFacetEmptyCheckBox;

    @FindBy(xpath = "//div[@title='Database']//preceding::label[1]")
    private WebElement databaseFacetEmptyCheckBox;

    //@FindBy(xpath ="//div[@class='asg-facet-tree-item-holder text-left asg-facet-item-ellipsis'][contains(text(),' [Database]')]" )
    @FindBy(css = "td.asg-item-list-ellipsis.asg-item-name")
    private List<WebElement> dataBaseList;

    @FindBy(xpath = "//label[@for='Table']")
    private WebElement tableFacetCheckbox;

    @FindBy(xpath = "//i[@class='fa fa-floppy-o']/..")
//    @FindBy (xpath = "//div[@class='asg-actions-panel result']//following::i[@class='fa fa-floppy-o']")
    private WebElement saveSearchButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//div[@class='create-quicklink-save']/button")
    private WebElement quickLinkSave;

    @FindBy(xpath = "//input[@placeholder='Enter name of quicklink']")
    private WebElement searchName;

    @FindBy(xpath = "//textarea[@placeholder='Enter description text of quicklink']")
    private WebElement searchDescription;

    @FindBy(xpath = "//div[@class='catalog-link']/table//td/span[contains(.,'BigData')]/preceding::td[1]//label[@for='asg-custom-checkbox']")
    private WebElement bigDataWidgetselectionCheckbox;

    @FindBy(xpath = "//button[@type='submit']")
    private WebElement SearchSaveButton;

    @FindBy(xpath = "//button[@class='btn btn-primary dropdown-toggle selectedDropItem']")
    private WebElement searchCatalogTopic;

    @FindBy(xpath = "//div[@class='asg-search-facet-box-wrapper']/div[contains(text(),'Rating')]")
    private WebElement ratingFacet;

    @FindBy(xpath = "//div[@class='catalog-link']/table//td/span[contains(.,'Search Catalog')]/preceding::td[1]//label[@class]")
    private WebElement searchWidgetCheckbox;

    @FindBy(css = "div[class='asg-search-rating-widget']")
    private List<WebElement> ratingFacetList;
    @FindBy(xpath = "//div[@class='asg-panels-item-caption clearfix scrollable']//following::div[@class[contains(.,'alert alert-danger')]]")
    private WebElement duplicateLink;

    @FindBy(css = "div[class='asg-search-rating-widget']>div>div[class='asg-facet-item-count']")
    private List<WebElement> ratingFacetCount;

    @FindBy(css = "div[class='asg-search-rating-widget asg-item-checked']>div>div[class='asg-facet-item-count']")
    private List<WebElement> checkedRatingFacetCount;

    @FindBy(xpath = "//input[@type='checkbox'][@id='[1,2)']//following::label[@for='asg-custom-checkbox'][1]")
    private WebElement ratingOneCheckbox;

    @FindBy(xpath = "//input[@type='checkbox'][@id='[2,3)']//following::label[@for='asg-custom-checkbox'][1]")
    private WebElement ratingTwoCheckbox;

    @FindBy(xpath = "//input[@type='checkbox'][@id='[3,4)']//following::label[@for='asg-custom-checkbox'][1]")
    private WebElement ratingThreeCheckbox;

    @FindBy(xpath = "//input[@type='checkbox'][@id='[4,5)']//following::label[@for='asg-custom-checkbox'][1]")
    private WebElement ratingFourCheckbox;

    @FindBy(xpath = "//input[@type='checkbox'][@id='[5,5]']//following::label[@for='asg-custom-checkbox'][1]")
    private WebElement ratingFiveCheckbox;

    @FindBy(xpath = "//li[@class[contains(.,'nav-item')]]/a[contains(.,'ALERTS')]")
    private WebElement alertsLink;

    @FindBy(xpath = "//a[@class='asg-search-list-item-name text-truncate']")
    private List<WebElement> itemNames;

    @FindBy(css = "div [class='alert alert-danger']")
    private WebElement invalidSolrError;

    @FindBy(css = "button[class='btn asg-btn-primary-sm selected-drop-item dropdown-toggle']")
    private WebElement searchCatalogDropDown;

    @FindBy(css = "div[class='asg-breadcrumb-content']>span")
    private WebElement breadcrumbLink;

    @FindBy(css = "div[class='asg-breadcrumb-content']>span>ul>li>a")
    private List<WebElement> breadcrumbList;

    @FindBy(css = "p[class='rating-caption']")
    private List<WebElement> ratingHeadingList;

    @FindBy(css = "p[class='asg-item-view-rating-widget-caption']")
    private WebElement ratingHeading;

    @FindBy(css = "div.right-content > p:nth-child(1)")
    private WebElement myRatingHeading;

    @FindBy(css = "div[class='input-group']>input")
    private WebElement searchText;

    @FindBy(css = "div[class='asg-panels-item-caption clearfix']>div")
    private List<WebElement> titleList;

    @FindBy(xpath = "//table[@class='table table-responsive table-condensed cf']//tbody/tr[1]/td[2]/a")
    private WebElement firstTableData;

    @FindBy(xpath = "//app-asg-panels/div/div[3]/div/div[1]/button[3]/i")
    private WebElement windowMaximize;

    @FindBy(xpath = "//div[@title='Trustworthy']//preceding::label[@for='asg-custom-checkbox'][1]")
    private WebElement tagText;

    @FindBy(xpath = "//div[@title='Trustworthy']//preceding::label[@for='asg-custom-checkbox'][1]")
    private WebElement clickFacetTag;

    @FindBy(xpath = "//td[@class[contains(.,'asg-item-list-tag-count')]]")
    private WebElement openItemTagCountFromList;

    @FindBy(xpath = "//td[@class='asg-item-list-ellipsis asg-item-name']//following::td[@class='asg-item-list-tag-count']")
    private WebElement openItemTagCountFromSpecificTag;

    @FindBy(xpath = "//input[@placeholder='Start typing for search...']")
    private WebElement enterTagName;

    @FindBy(xpath = "//ul[@class='nav nav-stacked']//li/a/span[contains(text(),'Trustworthy')]")
    private WebElement selectTagName;

    @FindBy(xpath = "//span[text()='Metadata']/following::ul[@class='list-groups properties-widget']//li")
    private List<WebElement> numberOfMetadataItems;

    public void Click_CreateNewTagButton() {
        synchronizationVisibilityofElement(driver, createNewTag);
        clickonWebElementwithJavaScript(driver, createNewTag);
    }

    @FindBy(xpath = "//button[contains(.,'Create new tag')]")
    private WebElement createNewTag;

    @FindBy(xpath = "//li//span[contains(text(),'Trustworthy')]//following::span[@class='fa fa-times']")
    private WebElement unAssignTag;

    @FindBy(xpath = "//div[@class='asg-facet-tree-item-holder text-left asg-facet-item-ellipsis'][@title='Data Analysis']")
    private WebElement facetMaintag;

    @FindBy(xpath = "//td[@class='asg-item-list-ellipsis asg-item-name']//following::td[@class='asg-item-list-tag-count']")
    private List<WebElement> itemList;

    private String dynamicAttributeRetrival = "//span[contains(text(),'$DYN$')]";

    @FindBy(css = ".asg-item-list-tag-count>a")
    private List<WebElement> listOfTagsInItemList;

    @FindBy(xpath = "//span[contains(.,'Create new tag')]")
    private WebElement createNewTagButton;

    @FindBy(xpath = "//div[@class='assigned-tags']//li/a/span[1]")
    private List<WebElement> assignedTagsList;

    @FindBy(xpath = "//div[@class='assigned-tags']//li/a/span[2]")
    private List<WebElement> assignedTagsStatusList;

    @FindBy(css = ".assign-unassign-tags-save>button")
    private WebElement assignUnassignTagsSaveButton;

    //@FindBy(xpath = "//div[@class='btn-group asg-notifications-workflow-actions-drop-down dropup']//button[1]")
    @FindBy(xpath = "//div[@class='btn-group asg-notifications-workflow-actions-drop-down dropup']/button/span/i")
    private WebElement workflowpossibleActionsButton;

    //@FindBy(xpath = "//div[@class='asg-notifications-workflow-possible-actions']//ul//li/a/span")
    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu show')]]/li")
    private List<WebElement> workflowActionsList;

    @FindBy(xpath = "//div[@class[contains(.,'item-view-taglist-widget')]]//span")
    private List<WebElement> tagsList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-notifications-workflow-approval')]]/div[contains(.,'Approval required')]")
    private WebElement approvalRequiredTextElement;

    @FindBy(css = "#tagStatus")
    private WebElement tagStatus;

    @FindBy(css = "#tagDefinition")
    private WebElement tagDefinition;

    @FindBy(css = "#tagName")
    private WebElement tagName;

    @FindBy(css = "#createdAt")
    private WebElement tagCreatedAt;

    @FindBy(css = "#createdBy")
    private WebElement tagCreatedBy;

    @FindBy(css = "#modifiedBy")
    private WebElement tagModifiedBy;

    @FindBy(css = "#modifiedAt")
    private WebElement tagModifiedAt;

    @FindBy(css = ".asg-notifications-workflow-no-comments")
    private WebElement tagNoCommentsText;

    @FindBy(xpath = "//button[contains(.,'Add comment')]")
    private WebElement addCommentButton;

    @FindBy(xpath = "//textarea[@placeholder='Leave comment']")
    private WebElement leaveCommentTextArea;

    @FindBy(xpath = "//div[@class='asg-comments-container']//span[3]")
    private List<WebElement> listOfCommentsAdded;

    public WebElement getDynamicAttributeRetrival(String element) {
        String finalDynamicAttributeRetrival = dynamicAttributeRetrival.replace("$DYN$", String.valueOf(element));
        return driver.findElement(By.xpath(finalDynamicAttributeRetrival));
    }

    public WebElement getGetBreadcrumbItems(String itemName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//following::span[@title='"+itemName+"']"));
    }

    public WebElement getWindowMaximize() {
        return windowMaximize;
    }

    public WebElement getFirstTableData() {
        return firstTableData;
    }

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]]")
    private List<WebElement> facetHeaderList;

//    @FindBy(css = "span[class='link-text']")
    @FindBy(css ="li[class='d-inline ng-star-inserted']")
    private List<WebElement> breadcrumbItems;

    @FindBy(xpath = "//ol[@class='breadcrumb d-inline-block']//li")
    private List<WebElement> breadCrumbList;

    @FindBy(xpath = "//ol[@class='breadcrumb d-inline-block']//li//a")
    private List<WebElement> breadCrumbLinkList;


    @FindBy(css = "a[class='fa fa-ellipsis-h hide-default-toggle dropdown-toggle']")
    private WebElement breadcrumbHiddenItemsOptions;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//button[3]")
    private WebElement itemViewResizeButton;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu')]]/li/a")
    private List<WebElement> breadcrumbHiddenItemsDropdownMenu;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-view-caption-name-and-type')]]/b")
    private List<WebElement> namesOfBreadcrumbsOpened;

    @FindBy(xpath = "//label[@for='File']")
    private WebElement fileCheckBox;

    public WebElement getFileCheckBox() {
        return fileCheckBox;
    }

    @FindBy(xpath = "//div[@class='item-list']//td[@class[contains(.,'asg-item-list-ellipsis')]][@data-title='type']")
    private WebElement facettypeColumn;

    @FindBy(xpath = "//div[@class='asg-search-facet-box']//*[@for='Table']")
    private WebElement facettypeTable;

    @FindBy(xpath = "//div[contains(text(),'foodmart')]//preceding-sibling::div[@class='asg-custom-checkbox-holder']//following-sibling::*[2]")
    private WebElement foodMartfacet;

    @FindBy(xpath = "//div[@class='item-list']//td[@class[contains(.,'asg-item-list-ellipsis')]][@data-title='type']")
    private List<WebElement> searchResulttypeColumnValues;

    @FindBy(css = ".asg-panels-item-caption-ellipsis>b")
    private List<WebElement> panelTitle;

    @FindBy(xpath = "//ol[@class='breadcrumb d-inline-block']/li/a")
    private List<WebElement> topBreadCrumbLinkList;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-scrollbar')]]/span[1]")
    private WebElement clickOnRightSideScroll;


    @FindBy(xpath = "//div[@class[contains(.,'asg-comment-add asg-comment-add-full-size clearfix')]]")
    private WebElement commentsBlockOfItem;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-view-table-widget-body table-responsive table-wrapper')]]//table/thead/tr[1]//th[1]")
    private WebElement dataoftypeName;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-view-table-widget-body table-responsive table-wrapper')]]//table/thead/tr[1]//th[2]")
    private WebElement dataoftypeType;

    @FindBy(xpath = "//div[@class='builder-item']//p[@class='asg-item-view-taglist-widget-title']")
    private WebElement tagsOfItemsLabel;

    @FindBy(xpath = "//p[contains(.,'COLUMNS')]//following::tr[@class[contains(.,'item')]]/td/span[1]")
    private List<WebElement> listOfItemsInHasColumnsSection;

    @FindBy(xpath = "//p[contains(.,'SIMILAR')]//following::tr[@class[contains(.,'item')]]/td[1]/span")
    private List<WebElement> listOfItemsInSimilarSection;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-list-content-body d-flex text-truncate')]]/div/div[1]/span[1]")
    private List<WebElement> itemNameLinks;

    @FindBy(xpath = "//p[contains(.,'SIMILAR')]//following::div[@class='asg-item-view-table-widget-body table-responsive table-wrapper']")
    private WebElement similiarSection;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-view-caption-name-and-type')]]/b")
    private WebElement headerName;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]][contains(text(),'Type')]")
    private WebElement TypeFacet;

    @FindBy(xpath = "//button[@class='form-control sort-by-dropdown hide-default-toggle dropdown-toggle']")
    private WebElement sortItemResults;

    public WebElement getTypeFacet() {
        return TypeFacet;
    }

    public WebElement getHeaderName() {
        return headerName;
    }

    @FindBy(xpath = "//p[contains(.,'COLUMNS')]/..//tbody/tr/td[2]")
    private WebElement dataTableElement;

    public WebElement getDataTableElement() {
        return dataTableElement;
    }

    public WebElement getLeftScrollClick() {
        return leftScrollClick;
    }

    // @FindBy(xpath = "//div[@class='asg-panels-scrollbar']/span[1]")
    @FindBy(css = "div.asg-panels-scrollbar span")
    private WebElement leftScrollClick;

    @FindBy(xpath = "//p[contains(.,'FIELDS')]/ancestor::div[@class='builder-item']//tbody//td[1]//span")
    private List<WebElement> listOfItemsInHasFieldSection;

    @FindBy(xpath = "//li[@class='pagination-next page-item disabled']/a")
    private WebElement disabledPaginationNextPageButton;

    @FindBy(xpath = "//li[@class='pagination-prev page-item disabled']")
    private WebElement disabledPaginationPrevPageButton;

    //@FindBy(xpath = "//p[contains(.,'METADATA')]/ancestor::div[contains(@class,'asg-panels-item asg-item-view asg-panels-active-item')]//ul//li[@class='list-group-item']/b")
    @FindBy(xpath = "//div[contains(@class,'asg-panels-active-item full-size-item')]//following::p[contains(.,'METADATA')]//following::span[@class='list-group-item-left']")
    private List<WebElement> listOfMetadata;

    @FindBy(xpath = "//div[@class='asg-facet-item-count']")
    private List<WebElement> facetItemCountList;

    @FindBy(xpath = "//div[@class='asg-facet-list-wrapper']//div[@class='asg-search-facet-header']")
    private List<WebElement> facetHeadersList;

    @FindBy(css = ".btn.asg-modal-confirm-btn.pull-right")
    private WebElement multiplePanelPopUpOk;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-active-item')]]//button[@class='exit-btn']")
    private WebElement panelExitButton;

    @FindBy(xpath = "//div[@class='asg-panels-item-dynamic-caption']//following::button/i[@class='fa fa-times'][1]")
    private WebElement panelCloseButton;

    @FindBy(xpath = "//button[@class='asg-notifications-workflow-submit']")
    private WebElement workflowActionsSubmitButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]][contains(text(),'Type')]//following::div[@class[contains(.,'asg-show-more-facet')]][1]/button")
    private WebElement typeFacetShowAll;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]][contains(text(),'Tag')]//following::div[@class[contains(.,'asg-show-more-facet')]][1]//button")
    private WebElement tagFacetShowAll;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//following::button[@class='top-btn']/i[@class='glyphicon glyphicon-resize-small']")
    private WebElement previewResizeIcon;

    @FindBy(xpath = "//div[@class[contains(.,'no-more-tables')]]//table/tbody/tr/td[3]")
    private List<WebElement> itemTypeClick;

    //@FindBy(xpath = "//div[@class='catalog-link']/table//td/span[contains(.,'Quick Link')]/preceding::td[1]//label[@for='asg-custom-checkbox']")
    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//label[@for='asg-custom-checkbox']")
    private WebElement quickLinkWidgetselectionCheckbox;

    @FindBy(xpath = "//ul[@class='nav nav-tabs dashboard-tabs-panel']//a[contains(.,'QUICK LINK')]")
    private WebElement quickLinkDashboard;

    @FindBy(xpath = "//div/p[contains(text(),'List of saved quicklinks')]")
    private WebElement quickLinkPanelLabel;

    @FindBy(xpath = "//div/ul/li[contains(text(),'Name')]")
    private WebElement quickLinkNameLabel;

    @FindBy(xpath = "//div/ul[@class='asg-available-quicklinks-list']/li/a")
    private List<WebElement> quickLinkListFromMySearchPanel;

    @FindBy(xpath = "//div[@class[contains(.,'asg-panels-item asg-item-view asg-panels-active-item')]]//following::button[contains(.,'Join the discussion')]")
    private WebElement joinTheDiscussionButton;

    @FindBy(xpath = "//iframe[@src[contains(.,'IDC/swagger-ui/')]]")
    private WebElement iframeWidgetSwagger;

    @FindBy(css = "button[class='btn authorize unlocked']")
    private WebElement authorizeButton;

    @FindBy(xpath = "//p[contains(.,'MOST FREQUENT VALUES')]//following::th[contains(.,'VALUE')]//following::tr/td[1]")
    private List<WebElement> mostFrequentValues;

    @FindBy(xpath = "//div[@class[contains(.,'scrollable-content')]]//div/a")
    private List<WebElement> SearchitemList;

    @FindBy(css = "button[class='btn btn-default']>span[class='fa fa-database']")
    private WebElement createNewDataSet;

    @FindBy(xpath = "//div[@title='NEW DATA SET']//following::input[@id='dataset-name']")
    private WebElement dataSetName;

    @FindBy(xpath = "//li[@class[contains(.,'nav-item')]]/a/span[contains(.,'REQUEST')]")
    private WebElement requestsLink;

    @FindBy(xpath = "//div[@class='no-more-tables']//th[@class='checkbox-cell']")
    private WebElement headerCheckBox;


    @FindBy(xpath = "//ul[contains(@class,'nav nav-tabs')]//li/a")
    private List<WebElement> itemViewTabs;

    @FindBy(xpath = "//div[@class='asg-item-view-lazy-load-table-widget-body table-wrapper']//table/thead//tr//th")
    private List<WebElement> dataSamplingTableHeaders;

    @FindBy(xpath = "//div[@class='item-list']//tbody/tr/td[2]/a")
    private List<WebElement> itemNameList;

    @FindBy(xpath = "//div[@class[contains(.,'item-list-total-number')]]/div")
    private WebElement totalitemCount;

    @FindBy(css = "i[class='fa fa-trash-o']")
    private WebElement deleteitem;

    @FindBy(css = "ul[class='list-group properties-widget']>li>span:nth-child(1)")
    private List<WebElement> metadataResults;

    @FindBy(xpath = "//div[@class='asg-search-list-item']//div[@class='flex-grow-1 d-flex flex-wrap text-truncate']/span[1]")
    private List<WebElement> listOfItemNameFound;


    @FindBy(xpath = "//li[@class='dropdown-item cursor-pointer']//a")
    private List<WebElement> itemResultSortValues;

    @FindBy(xpath ="//div[contains(text(),'No data found')]")
    private WebElement noDataFound;

    //10.3 New UI

    @FindBy(xpath = "(//span[text()='Search Results']/../following::div[@class[contains(.,'asg-item-list-filter-container')]]/div//span)[1]")
    private WebElement itemCount;

    @FindBy(xpath = "//div[@class[contains(.,'item-list-total-number')]]")
    private WebElement searchitemCount;

    @FindBy(xpath = "//div[@class='item-content-section d-flex align-items-center flex-wrap text-truncate']//div[@class='item-name-type-section d-flex align-items-center text-truncate']/a")
    private List<WebElement> listOfItemNamesIntableOfItemsFound;

    @FindBy(xpath = "//div[contains(@class,'content-center')]//following::span[contains(.,'Metadata')]//following::div[contains(@class,'list-caption')] ")
    private List<WebElement> listOfMetadataCaptions;

    @FindBy(xpath = "//div[@class[contains(.,'list-caption')]]")
    private List<WebElement> detailsAttributes;

    @FindBy(xpath = "//ul//li[@class[contains(.,'nav-item')]]")
    private List<WebElement> multiAttributeWidgets;

    @FindBy(xpath = "//label[@class[contains(.,'asg-dyn-form-property-label')]]")
    private List<WebElement> infoLabelsInItemView;

    @FindBy(xpath = "//ol[@class='breadcrumb d-inline-block']//li")
    private List<WebElement> hierarchyList;

    @FindBy(css = "div[class='asg-search-header-ellipsis']")
    private WebElement catalogDropDown;

    @FindBy(xpath = "//ul[@class='schema-dropdown-menu dropdown-menu show']//li")
    private List<WebElement> catalogList;

    @FindBy(xpath = "//span[@class='input-group-addon search-addon'][1]/span")
    private WebElement topSearchIcon;

    @FindBy(xpath = "//input[contains(@placeholder,'Search...')]")
    private WebElement topItemSearchField;

    @FindBy(xpath = "//ul[@class='list-groups properties-widget']//li/div/div/pre")
    private WebElement analysisLogtext;

    @FindBy(xpath = "//li[@class[contains(.,'breadcrumb-item')]]/a")
    //@FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//button[@class='exit-btn']")
    private WebElement itemFullViewPageCloseButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-box-wrapper')]][contains(.,'Tags')]//following::div[@class[contains(.,'asg-facet-tree-item-holder')]][1]")
    private List<WebElement> searchPageTagList;

    @FindBy(xpath = "//li[@class='ng-star-inserted']/div")
    private List<WebElement> BusinessOwnerList;

    @FindBy(xpath = "(//em[@class='fal fa-times pl-1 remove-item invisible cursor-pointer'])[1]")
    private WebElement RemoveBusinessOwnerIcon;

    @FindBy(xpath = "(//span[@class='username px-2'])[1]")
    private WebElement BusinessOwnerFirstItem;


    @FindBy(css = "span[class='cursor-pointer text-nowrap']")
    private List<WebElement> tableHeaders;

    @FindBy(xpath = "//span[@class='asg-search-list-item-field-key']")
    private List<WebElement> listOfItemTypeandcatalog;

    @FindBy(xpath = "//li[contains(@class,'breadcrumb-item')]//a[text()='Search - Default']")
    private List<WebElement> Breadcrumbsearchcatalog;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[1]")
    private WebElement oneStaravgRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[2]")
    private WebElement twoStaravgRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[3]")
    private WebElement threeStaravgRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[4]")
    private WebElement fourStaravgRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[5]")
    private WebElement fiveStaravgRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[11]")
    private WebElement oneStarRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[12]")
    private WebElement twoStarRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[13]")
    private WebElement threeStarRatingItemViewPage;

    @FindBy(xpath = "(//ngb-rating[@class='d-inline-flex']//span[@class='ng-star-inserted'])[14]")
    private WebElement fourStarRatingItemViewPage;

    @FindBy(xpath = "(//div[@class='asg-item-view-rating-stars d-inline']//span[@class='ng-star-inserted'])[15]")
    private WebElement fiveStarRatingItemViewPage;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-view-rating-widget-body')]]")
    private WebElement ratingfacetitemview;

    @FindBy(xpath = "//a[contains(text(),'Test_ABA_RATING')]")
    private WebElement firstItemofTable;

    @FindBy(css = "div.d-flex.text-break.item-list-total-number > div > app-asg-checkbox > div > label")
    private WebElement selectAllCheckbox;

    @FindBy(xpath = "//div[@class[contains(.,'item-list-total-number')]]/div[contains(.,'Select all')]")
    private WebElement selectAllLabel;

    @FindBy(xpath = "//div[@class[contains(.,'show-all')]]")
    private WebElement showAllLabel;

    @FindBy(xpath = "//div[@class[contains(.,'cursor-pointer show-selected')]][contains(.,'Show 1 selected items only')]")
    private WebElement selectedItemsOnlyLabel;

    @FindBy(xpath = "//div[@class[contains(.,'recent-search-btns d-flex align-items-center')]]/button[contains(.,' ASSIGN/UNASSIGN TAGS ')]")
    private List<WebElement> assignUnassignTags;

    @FindBy(xpath = "//button[contains(.,'SAVE SEARCH')]")
    public WebElement saveSearch;

    @FindBy(css = "div[class='btn-group asg-item-list-soryby dropdown']")
    public WebElement sortByIcon;

    @FindBy(css = "div.scrollable-content > div:nth-child(1) > div > div > div > app-asg-checkbox > div > label")
    private WebElement firstItemCheckbox;

    @FindBy(xpath = "//button[@class='spinner-btn'][contains(.,'SAVE')]")
    private WebElement assignTagSaveButton;

    @FindBy(xpath = "//button[@class='spinner-btn'][contains(.,'ASSIGN')]")
    private WebElement assignButton;

    @FindBy(css = "a[class='fa fa-ellipsis-v hide-default-toggle cursor-pointer dropdown-icon text-center rounded-circle dropdown-toggle']")
    private WebElement tabsMenuIcon;

    @FindBy(css = "ul[class='list-menu dropdown-menu show']")
    private WebElement tabsMenuSubMenuContainer;

    @FindBy(css = "div.scrollable-content > div:nth-child(1) > div > div > div > div.item-avatar.d-flex.flex-grow-0.flex-shrink-0.align-items-center.justify-content-center.rounded-circle")
    private WebElement typeIcon;

    @FindBy(css = "div[class='asg-item-view-hierarchy-tree rounded']")
    private WebElement hierarchyWidget;

    @FindBy(xpath = "//div[@class[contains(.,'item-view-taglist-widget')]][1]")
    private WebElement tagsWidget;

    @FindBy(xpath = "//div[@class='asg-item-view-hierarchy-tree rounded']/ul/li//a")
    private List<WebElement> hierarchyItemlinks;

    @FindBy(xpath="//div[@class='asg-search-list-item ml-1 ng-star-inserted active'][1]")
    private WebElement highlightedFirstItemInSerachResult;

    @FindBy(xpath="//div[@class='asg-search-list-item ml-1 ng-star-inserted'][2]")
    private WebElement unHighlightedFirstItemInSerachResult;

    @FindBy(xpath="//span[@class='cursor-pointer'][contains(.,'Save')]")
    private WebElement baAttributesSaveButton;

    @FindBy(xpath="//em[@id='item-view-edit-btn']")
    private WebElement EditBAName;

    @FindBy(xpath="//em[@id='item-view-save-btn']")
    private WebElement SaveBAName;

    @FindBy(xpath="//em[@class='fal fa-ban pr-1']")
    private WebElement CanelBAName;

    @FindBy(xpath="(//span[contains(@class, 'manage-search mr-3 fa fa-search')])[1]")
    private WebElement SearchTagicon;

    @FindBy(xpath="//span[contains(@class, 'manage-search-close mr-2')]")
    private WebElement CloseTagicon;

    @FindBy(xpath = "//span[@class='tagLabel'][contains(.,'Type')]//following::span[1]/i")
    private WebElement tagIconInItemViewPage;

    @FindBy(xpath = "//em[@class='far link fa-ellipsis-h cursor-pointer']")
    private WebElement ItemAction;

    @FindBy(xpath = "//em[@class='fa fa-check save-cancel-icon']")
    private WebElement BAItemRenameSave;

    @FindBy(xpath = "//em[@class='fa fa-times save-cancel-icon']")
    private WebElement BAItemRenameCancel;

    @FindBy(xpath = "//input[contains(@class,'form-control asg-item-view-edit-caption-name')]")
    private WebElement BAItemtext;

    @FindBy(xpath = "//div[@class='score position-absolute']")
    private WebElement TrustScore;

    @FindBy(xpath = "(//span[contains(text(),'Governance')]//preceding::div[@class='score text-right'])[1]")
    private WebElement ChartLegendGovernaceScore;

    @FindBy(xpath = "(//span[contains(text(),'Governance')]//following::div[@class='score text-right'])[1]")
    private WebElement ChartLegendTechnicalScore;

    @FindBy(xpath = "(//span[contains(text(),'Technical')]//following::div[@class='score text-right'])[1]")
    private WebElement ChartLegendIntelligenceScore;

    @FindBy(xpath = "//p[@class='widget-title mb-0 pt-2 pb-1 trust']")
    private WebElement BackgroundColorBA;

    @FindBy(xpath = "(//span[contains(text(),'[BusinessApplication]')]//following::span[contains(@class,'asg-caret-icon-toggle fa cursor-pointer')])[1]")
    private WebElement TrustScoreDownArrow;

    @FindBy(xpath = "//li[contains(@class,'dropdown-item')]//following::span[contains(text(),'Rename')]")
    private WebElement BARename;

    @FindBy(xpath = "//li[contains(@class,'dropdown-item')]//following::span[contains(text(),'Delete')]")
    private WebElement BADelete;


    @FindBy(xpath = "//span[@title='Name']//following::td[@class[contains(.,'text-truncate align-middle')]][1]")
    private WebElement nameColumnValue;

    @FindBy(xpath = "//span[@title='Imported Itemtype']//following::td[@class[contains(.,'text-truncate align-middle')]][2]")
    private WebElement itemTypeColumnValue;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate align-middle')]][1]")
    private List<WebElement> nameColumnList;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate align-middle')]][2]")
    private List<WebElement> itemTypeColumnList;

    @FindBy(xpath = "//span[@class='input-group-addon search-addon'][1]/span")
    private WebElement searchIcon;

    @FindBy(xpath = "(//app-asg-select[@formcontrolname='factor'])[2]//ul/li//a//span")
    private  List<WebElement> TrustPolicyAddRulesFactor;

    @FindBy(xpath = "(//input[@formcontrolname='label'])[2]")
    private WebElement TrustPolicyAddRulesLabel;

    @FindBy(xpath = "//span[@class='mr-3 far fa-save']")
    private WebElement TrustPolicyRulesSave;

    @FindBy(xpath = "(//app-asg-select[@formcontrolname='factor'])[2]")
    private WebElement TrustPolicyFactor;

    @FindBy(xpath = "(//p[@class='widget-title mb-0 pt-2 pb-1 trust']//following::span[contains(@class,'asg-caret-icon-toggle fa cursor-pointer')])[1]")
    private WebElement TrustScoreExpand;

    @FindBy(xpath = "//button[@class='form-control hide-default-toggle dropdown-toggle']")
    private WebElement TagCategoryDropdown;

    @FindBy(css = "input[formcontrolname='fileName']")
    private WebElement excelImporterTextbox;

    @FindBy(css = "input[formcontrolname='sheetColumnHeader']")
    private WebElement excelImporterCheckbox;

    @FindBy(xpath = "//div[@class[contains(.,'ql-editor')]]")
    private WebElement descriptionContentInItemViewPage;

    @FindBy(xpath = "//input[@name='mappingType'][2]")
    private WebElement advancedmappingradioButton;

    @FindBy(xpath = "//table[@class[contains(.,'mapping-grid table')]]/tbody/tr/td/strong")
    private List<WebElement> excelImportColumnList;

    @FindBy(css = "span[id='item-view-edit-btn']")
    private List<WebElement> itemViewBAEditButton;

    @FindBy(xpath = "//button[@class[contains(.,'item-action-btn border')]]/em")
    private List<WebElement> itemViewBAShowMoreIcon;

    @FindBy(xpath = "//div[@class[contains(.,'business-owner-container')]]")
    private WebElement BAItemBusinessOwnerContainer;

    @FindBy(xpath = "//div[@class[contains(.,'asg-item-view-html-edit-container')]]")
    private WebElement BAItemDescriptionContainer;

    @FindBy(css = "em[id='item-view-save-btn']")
    private WebElement BAItemSaveButton;

    @FindBy(xpath = "//span[@class[contains(.,'link cursor-pointer')]][1]")
    private WebElement BAItemCancelButton;

    @FindBy(xpath = "//span[@class[contains(.,'username')]]")
    private List<WebElement> businessOwnersList;

    @FindBy(xpath = "//a[contains(.,'Show the data elements in a list')]")
    private WebElement dataElementsLink;

    @FindBy(xpath = "//div[@class='asg-dynamic-form-property-label-container'][contains(.,'Last execution')]//following::div[1]")
    private WebElement lastExecutionAfterPluginRun;

    @FindBy(xpath = "//input[@formcontrolname='fileName']")
    private WebElement excelName;

    @FindBy(xpath = "//div[@class='tooltip-inner']//a")
    private List<WebElement> BAListInItemViewTopSection;

    @FindBy(xpath = "//*[@class[contains(.,'tick')]]")
    private List<WebElement> captureTabChartTypes;

    @FindBy(xpath = "//div[@class[contains(.,'inline-block')]]/span")
    private List<WebElement> dataTableColumnsInCaptureTab;

    @FindBy(xpath = "//tr/td[@class[contains(.,'border-bottom')]][1]")
    private List<WebElement> nameColumnInCaptureTab;

    @FindBy(xpath = "//tr/td[@class[contains(.,'border-bottom')]][2]")
    private List<WebElement> countColumnInCaptureTab;

    @FindBy(xpath = "//div[@class='schemas-content']//div[@class='text-left w-50']//span[@class='status-align icon-padding']")
    private List<WebElement> customAttributesItemtypes;

    @FindBy(xpath = "//textarea[@placeholder='Enter values (seperated by commas)']")
    private WebElement valueList;

    @FindBy(xpath = "//span[@class='switch switch-small']")
    private WebElement customAttributesBooleantoggleSwitch;

    @FindBy(xpath = "//span[@class='switch switch-small checked']")
    private WebElement customAttributesBooleantoggledSwitch;

    @FindBy(xpath = "//div[@class[contains(.,'list-data')]]//preceding::div[@class[contains(.,'list-group-items-container')]]/div[1]")
    private List<WebElement> itemViewFields;

    @FindBy(xpath = "//li[@class[contains(.,'list-group-items-wrapper')]]/div//following-sibling::div[@class[contains(.,'list-data')]]/*/div/button//preceding::div[@class[contains(.,'list-caption')]][1]")
    private List<WebElement> itemViewDropdownFields;

    @FindBy(xpath = "//div[@class[contains(.,'list-group-items-container')]]/div[1]//following-sibling::div")
    private List<WebElement> itemViewInputBox;

    @FindBy(xpath = "//div[@class[contains(.,'dropdown-menu show')]]//button[@role='menuitem']")
    private List<WebElement> itemViewDropdownMenu;

    @FindBy(xpath = "//li[@class[contains(.,'list-group-items-wrapper')]]/div//following-sibling::div[@class[contains(.,'list-data')]]/input")
    private List<WebElement> itemViewTextField;

    @FindBy(xpath = "//li[@class[contains(.,'list-group-items-wrapper')]]/div//following-sibling::div[@class[contains(.,'list-data')]]/*/div/button")
    private List<WebElement> itemViewDropdownField;

    @FindBy(xpath = "//*[@class[contains(.,'dropdown-menu show')]]")
    private WebElement itemViewDropdownBox;

    @FindBy(xpath = "//div[contains(@class,'item-nav')]/div/div/button/span")
    private List<WebElement> itemViewShowMoreDropdown;

    @FindBy(xpath = "//span[@class[contains(.,'assign-icon fa fa-plus-square')]]")
    private WebElement assignDataButton;

    @FindBy(xpath = "//span[@class='link'][contains(.,'Add to Data Set')]")
    private List<WebElement> addToDataSetButton;

    @FindBy(xpath = "//th[@class[contains(.,'checkbox-selectable-cell')]][1]//div[1]/input[1]")
    private WebElement selectAllTheDataItem;

    @FindBy(xpath = "//tr[1]/th/span/span[@class='select-none']")
    private List<WebElement> itemViewColumnNamesInTable;

    public SubjectArea(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized SubjectArea page");
    }

    public WebElement getViewLinkForMetadataField(String itemName,String fieldName) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+itemName+"')]//following::div[contains(@class,'list-caption')][contains(.,'"+fieldName+"')]//following::a[contains(.,'View')]"));
    }

    public WebElement getViewLinkForMetadataWidgetField(String itemName,String widgetName,String fieldName) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+itemName+"')]/../../../../..//span[text()='"+widgetName+"']/..//following::div[contains(@class,'list-caption')][contains(.,'"+fieldName+"')]//following::a[contains(.,'View')]"));
    }

    public String getViewLinkdataForMetadataField(String itemName,String fieldName){

        return driver.findElement(By.xpath("//span[contains(text(),'"+itemName+"')]//following::div[contains(text(),'"+fieldName+"')]/following::div[@class='popover-body']/pre")).getText();

    }
    public String getViewLinkdataForMetadataWidgetField(String itemName,String widgetName,String fieldName){
        return driver.findElement(By.xpath("//span[contains(text(),'"+itemName+"')]/../../../../..//span[text()='"+widgetName+"']/..//following::div[contains(text(),'"+fieldName+"')]/following::div[@class='popover-body']/pre")).getText();
    }

    public WebElement getExcelImporterHintMessage(String Message) {
        return driver.findElement(By.xpath("//p[text()=' " + Message + " ']"));
    }
    public WebElement getExcelImporterAlertMessage(String Message) {
        return driver.findElement(By.xpath("//div[contains(@class,'or mt-2')][' "+Message+" ']"));
    }
    public WebElement getExcelImporterPopupMessage(String Message) {
        return driver.findElement(By.xpath("//div[@class='modal-body']//p[text()='"+Message+"']"));
    }
    public WebElement getExcelImporterErrorMessage(String Message) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'error text')]][contains(.,'"+Message+"')]"));
    }
    public WebElement getExcelImporterSuccessMessage(String Message) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-alert ng-star-inserted')]//span[text()=' "+Message+" ']"));
    }
    public WebElement getExcelImporterpageDropdownButtonOfTheField(String LabelName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+LabelName+"')]//following::button[@class='dropdown-toggle form-control hide-default-toggle']"));
    }
    public WebElement getExcelImporterMapDropdownButtonOfTheField(String FieldName) {
        return driver.findElement(By.xpath("//td//div[contains(text(),'"+FieldName+"')]//following::button[@class='form-control clearfix hide-default-toggle dropdown-toggle'][1]"));
    }
    public WebElement getAttributeExcelImporterInDropdown(String filterName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+filterName+"')][1]//following::li[@class[contains(.,'dropdown-item')]]/a/span[contains(text(),'"+option+"')]"));
    }
    public WebElement getAttributeExcelImporterMapInDropdown(String filterName, String option) {
        return driver.findElement(By.xpath("//td//div[contains(text(),'"+filterName+"')]/../following-sibling::td//span[contains(text(),'"+option+"')][1]"));
    }
    public WebElement getDetailsDropdownButtonOfTheField(String LabelName) {
        return driver.findElement(By.xpath("(//div[text()=' "+LabelName+" ']//following::em[@class='fa fa-chevron-down'])[1]"));
    }
    public WebElement getDetailsAttributeDropdown(String filterName, String option) {
        return driver.findElement(By.xpath("(//div[text()=' " + filterName + " ']//following::a//span[text()='" + option + "'])[1]"));
    }
    public WebElement getExcelImporterpageScopeDropdownButton(String ColumnName, String fieldName) {
            return driver.findElement(By.xpath("//td[@class[contains(.,'form-group text-left border-right')]]/div[contains(.,'"+ColumnName+"')]//following::label[text()='"+fieldName+"']//following::div[@class[contains(.,'form-field-element')]]//following::em"));
    }
    public WebElement getExcelImporterpageScopeDropdownAttributes(String ColumnName, String fieldName, String option) {
        return driver.findElement(By.xpath("//td[@class[contains(.,'form-group text-left border-right')]]/div[contains(.,'"+ColumnName+"')]//following::label[text()='"+fieldName+"']//following::ul/li[contains(.,'"+option+"')]"));
    }
    public WebElement getExcelImporterpageScopeDropdownAttributesList(String ColumnName, String fieldName, String option) {
        return driver.findElement(By.xpath("//td[@class[contains(.,'form-group text-left border-right')]]/div[contains(.,'"+ColumnName+"')]//following::label[text()='"+fieldName+"']//following::ul[@class[contains(.,'dropdown-menu')]]/li[contains(.,'"+option+"')]"));
    }
    public WebElement getExcelImporterCheckbox() {
        return driver.findElement(By.xpath("//div[contains(@class,'d-flex align-items-center')]//input[contains(@class,'ng-valid')]"));
    }
    public WebElement getExcelImportNameField() {
        return driver.findElement(By.xpath("//input[@formcontrolname='fileName']"));
    }
    public WebElement getProfileSettingSaveButton() {
        return driver.findElement(By.xpath("//button[contains(.,'SAVE')]"));
    }
    public WebElement getTagFrameRight(String Message) {
        return driver.findElement(By.xpath("//div[contains(@class,'split-container mr-3')]//span[contains(@class,'title')]"));
    }
    public WebElement getTagFrameLeft(String Message) {
        return driver.findElement(By.xpath("//div[@class='split-container']//span[contains(@class,'title')]"));
    }
    public WebElement getSuccessLabelInfo(String Section,String Selected_Tag) {
        return driver.findElement(By.xpath("//span[text()=' "+Section+" ']//following::span[contains(.,'"+Selected_Tag+"')]//following::span[contains(.,'added')]"));
    }
    public WebElement getAssignedtags(String ItemName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'item-view-taglist-widget')]]//ul//li//span[contains(.,'"+ItemName+"')]"));
    }
    public WebElement getConfigDetails(String ItemName) {
        return driver.findElement(By.xpath("//div[contains(@class,'accordion-container')]//span[contains(.,'"+ItemName+"')]"));
    }

    public WebElement gettotalitemCount() {
        synchronizationVisibilityofElement(driver, totalitemCount);
        return totalitemCount;
    }

    public WebElement getItemAction() {
        synchronizationVisibilityofElement(driver, ItemAction);
        return ItemAction;
    }

    public List<WebElement> getBreadCrumbLinkList() {
        synchronizationVisibilityofElementsList(driver, breadCrumbLinkList);
        return breadCrumbLinkList;
    }

    public List<WebElement> getTopBreadCrumbLinkList() {
        synchronizationVisibilityofElementsList(driver, topBreadCrumbLinkList);
        return topBreadCrumbLinkList;
    }

    public WebElement getBAItemText() {
        synchronizationVisibilityofElement(driver, BAItemtext);
        return BAItemtext;
    }

    public WebElement getBAItemRenameSave() {
        synchronizationVisibilityofElement(driver, BAItemRenameSave);
        return BAItemRenameSave;
    }

    public WebElement getBAItemRenameCancel() {
        synchronizationVisibilityofElement(driver, BAItemRenameCancel);
        return BAItemRenameCancel;
    }

    public WebElement getTechnicalChartLegendTrustScore() {
        synchronizationVisibilityofElement(driver, ChartLegendTechnicalScore);
        return ChartLegendTechnicalScore;
    }

    public WebElement getIntelligenceChartLegendTrustScore() {
        synchronizationVisibilityofElement(driver, ChartLegendIntelligenceScore);
        return ChartLegendIntelligenceScore;
    }

    public WebElement getBackgroundColorBA() {
        synchronizationVisibilityofElement(driver, BackgroundColorBA);
        return BackgroundColorBA;
    }

    public WebElement getTrustScoreDown() {
        synchronizationVisibilityofElement(driver, TrustScoreDownArrow);
        return TrustScoreDownArrow;
    }

    public WebElement getBARename() {
        synchronizationVisibilityofElement(driver, BARename);
        return BARename;
    }

    public WebElement getBADelete() {
        synchronizationVisibilityofElement(driver, BADelete);
        return BADelete;
    }

    public WebElement getTrustScore() {
        synchronizationVisibilityofElement(driver, TrustScore);
        return TrustScore;
    }
    public WebElement getGovernaceChartLegendTrustScore() {
        synchronizationVisibilityofElement(driver, ChartLegendGovernaceScore);
        return ChartLegendGovernaceScore;
    }


    public void selectExcelImporterpageDropdown(String fieldName, String option) throws Exception {
        scrolltoElement(driver, getExcelImporterpageDropdownButtonOfTheField(fieldName), true);
        clickonWebElementwithJavaScript(driver, getExcelImporterpageDropdownButtonOfTheField(fieldName));
        waitForAngularLoad(driver);
        scrolltoElement(driver, getAttributeExcelImporterInDropdown(fieldName, option), true);
        clickOn(driver, getAttributeExcelImporterInDropdown(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void selectExcelImporterpageScopeDropdown(String colunName, String fieldName, String option) throws Exception {
        scrolltoElement(driver, getExcelImporterpageScopeDropdownButton(colunName,fieldName), true);
        clickonWebElementwithJavaScript(driver, getExcelImporterpageScopeDropdownButton(colunName,fieldName));
        waitForAngularLoad(driver);
        scrolltoElement(driver, getExcelImporterpageScopeDropdownAttributes(colunName,fieldName, option), true);
        clickOn(driver, getExcelImporterpageScopeDropdownAttributes(colunName,fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void selectExcelImporterpageScopeDropdownChild(String colunName, String fieldName, String option) throws Exception {
        scrolltoElement(driver, getExcelImporterpageScopeDropdownButton(colunName,fieldName), true);
        clickonWebElementwithJavaScript(driver, getExcelImporterpageScopeDropdownButton(colunName,fieldName));
        waitForAngularLoad(driver);
        scrolltoElement(driver, getExcelImporterpageScopeDropdownAttributesList(colunName,fieldName, option), true);
        clickOn(driver, getExcelImporterpageScopeDropdownAttributesList(colunName,fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void VerifyExcelImporterpageDropdown(String fieldName, String option) throws Exception {
        moveToElement(driver, getExcelImporterpageDropdownButtonOfTheField(fieldName));
        clickonWebElementwithJavaScript(driver, getExcelImporterpageDropdownButtonOfTheField(fieldName));
        waitForAngularLoad(driver);
        moveToElement(driver, getAttributeExcelImporterInDropdown(fieldName, option));
        Assert.assertEquals(option,getElementText(getAttributeExcelImporterInDropdown(fieldName, option)));
        clickonWebElementwithJavaScript(driver, getExcelImporterpageDropdownButtonOfTheField(fieldName));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }
    public void selectExcelImporterMapDropdown(String fieldName, String option) throws Exception {
        moveToElement(driver, getExcelImporterMapDropdownButtonOfTheField(fieldName));
        clickonWebElementwithJavaScript(driver, getExcelImporterMapDropdownButtonOfTheField(fieldName));
        waitForAngularLoad(driver);
        scrolltoElement(driver, getAttributeExcelImporterMapInDropdown(fieldName, option),true);
        clickOn(driver, getAttributeExcelImporterMapInDropdown(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public WebElement getDeleteitem() {
        synchronizationVisibilityofElement(driver, deleteitem);
        return deleteitem;
    }

    public void click_bigDataCheckbox() {

        synchronizationVisibilityofElement(driver, bigDataCheckbox);
        clickonWebElementwithJavaScript(driver, bigDataCheckbox);
    }

    public void click_firstItemListTag() {

        synchronizationVisibilityofElement(driver, itemListTag);
        clickOn(itemListTag);
    }

    public WebElement verifyWarningMessage() {

        synchronizationVisibilityofElement(driver, mutliplePanelWarning);
        return mutliplePanelWarning;

    }

    public WebElement verifyWarningMessageForClosePanel() {
        synchronizationVisibilityofElement(driver, mutliplePanelWarning_text);
        return mutliplePanelWarning_text;
    }

    public void click_acceptWarning() {

        synchronizationVisibilityofElement(driver, acceptWarning);
        clickonWebElementwithJavaScript(driver, acceptWarning);

    }

    public WebElement tabPaginationNextButton(String tabValue) {
        return driver.findElement(By.xpath("//p[@class='asg-item-view-table-widget-header']/span[text()='" + tabValue + "']/../..//li[@class='page-item']/a [@aria-label='Next']"));
    }

    public void click_dismissWarning() {

        synchronizationVisibilityofElement(driver, dismissWarning);
        clickOn(dismissWarning);

    }

    public void dismissWarning_ifdisplayed() {

        try {
            waitForAngularLoad(driver);
            if (isElementPresent(dismissWarning) == false) {
            } else try {
                if (isElementPresent(dismissWarning) == true) {
                    click_dismissWarning();
                }
            } catch (Exception e) {
                new DashBoardPage(driver).Click_profileLogoutButton();
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                Assert.fail(e.getMessage());
            }

        } catch (Exception e) {
            click_dismissWarning();
        }
    }

    public WebElement verifyStructure() {

        synchronizationVisibilityofElement(driver, resultsVerification);
        return resultsVerification;

    }

    public WebElement returnItemListTable() {

        synchronizationVisibilityofElement(driver, itemListTable);
        return itemListTable;

    }

    public WebElement returnTagStructure() {

        synchronizationVisibilityofElement(driver, subjectAreaTagStructure);
        return subjectAreaTagStructure;

    }

    public List<WebElement> returnitemListPagination() {

        synchronizationVisibilityofElementsList(driver, itemListPagination);
        return itemListPagination;

    }

    public WebElement functionid() {

        synchronizationVisibilityofElement(driver, functionid);
        return functionid;

    }

    public WebElement lineageid() {

        synchronizationVisibilityofElement(driver, lineageid);
        return lineageid;

    }

    public List<WebElement> returnitemListPaginationClassNames() {

        synchronizationVisibilityofElementsList(driver, itemListPaginationClassNames);
        return itemListPaginationClassNames;
    }

    public WebElement returndataAnalysisTagCollapsingTriangleButton() {

        synchronizationVisibilityofElement(driver, dataAnalysisTagCollapsingTriangleButton);
        return dataAnalysisTagCollapsingTriangleButton;

    }

    public WebElement returnfirstItemIntableOfItems() {
        return itemsFound;
    }

    public WebElement similiarSection() {
        scrollToWebElement(driver, similiarSection);
        return similiarSection;
    }

    public List<WebElement> returnfirstItemIntableOfItemsFound() {

        synchronizationVisibilityofElementsList(driver, listOfItemNamesIntableOfItemsFound);
        return listOfItemNamesIntableOfItemsFound;

    }

    public WebElement getItemText() {
        return itemText;
    }

    public List<WebElement> returndataAnalysisSubTags() {

        synchronizationVisibilityofElementsList(driver, dataAnalysisSubTags);
        return dataAnalysisSubTags;
    }

    public WebElement returndataAnalysisTagExpandingTriangleButton() {

        synchronizationVisibilityofElement(driver, dataAnalysisTagExpandingTriangleButton);
        return dataAnalysisTagExpandingTriangleButton;

    }

    public WebElement returnitemPreviewPage() {

        synchronizationVisibilityofElement(driver, itemPreviewPage);
        return itemPreviewPage;
    }

    public WebElement returnfirstItemListName() {

        synchronizationVisibilityofElement(driver, firstItemListName);
        waitForAngularLoad(driver);
        return firstItemListName;

    }


    public WebElement returnsort() {

        synchronizationVisibilityofElement(driver, returnsort);
        return returnsort;

    }

    public WebElement returnqualityLabel() {
        return qualityLabel;

    }

    public WebElement returnqualityLabelInCurrentpanel() {
        return qualityLabelInCurrentpanel;

    }


    public WebElement returnitemFullViewPage() {

        synchronizationVisibilityofElement(driver, itemFullViewPage);
        return itemFullViewPage;

    }

    public WebElement returnDatasamplingtable() {

        synchronizationVisibilityofElement(driver, DataSamplingTable);
        return DataSamplingTable;
    }

    public WebElement returnfirstItemType() {
        synchronizationVisibilityofElement(driver, firstItemType);
        return firstItemType;
    }


    public WebElement returnItemCheckBoxIntableOfItemsFound(String itemName) {

        return driver.findElement(By.xpath("//a[contains(text(),'" + itemName + "')]/preceding::td[1]"));

    }

    public List<WebElement> returnlistOfItemCheckboxes(String itemName) {
        return driver.findElements(By.xpath("//a[contains(.,'" + itemName + "')]/preceding::td"));

    }

    public List<WebElement> tootltiptext() {

        synchronizationVisibilityofElementsList(driver, datatooltip);
        return datatooltip;

    }

    public WebElement returnitemListPageTitle() {

        synchronizationVisibilityofElement(driver, itemListPageTitle);
        return itemListPageTitle;

    }

    public WebElement returnitemOverviewAccessPoint() {

        synchronizationVisibilityofElement(driver, itemOverviewAccessPoint);
        return itemOverviewAccessPoint;

    }

    public WebElement returnitemDataSamplingAccessPoint() {

        synchronizationVisibilityofElement(driver, itemDataSamplingAccessPoint);
        return itemDataSamplingAccessPoint;

    }

    public WebElement returnitemLineageAccessPoint() {

        synchronizationVisibilityofElement(driver, itemLineageAccessPoint);
        return itemLineageAccessPoint;

    }

    public WebElement returnitemCommentsAccessPoint() {

        synchronizationVisibilityofElement(driver, itemCommentsAccessPoint);
        return itemCommentsAccessPoint;

    }

    public WebElement returnqualityColorNotApply() {

        synchronizationVisibilityofElement(driver, qualityColorNotApply);
        return qualityColorNotApply;

    }

    public List<WebElement> returnpreviewPageItemFullQualifiedName() {

        synchronizationVisibilityofElementsList(driver, previewPageItemFullQualifiedName);
        return previewPageItemFullQualifiedName;

    }

    public List<WebElement> returnfullviewPageItemFullQualifiedName() {

        synchronizationVisibilityofElementsList(driver, fullviewPageItemFullQualifiedName);
        return fullviewPageItemFullQualifiedName;

    }


    public void click_paginationPreviousButton() {

        synchronizationVisibilityofElement(driver, paginationPreviousButton);
        clickOn(paginationPreviousButton);
    }

    public WebElement getPaginationPreviousButton() {

        synchronizationVisibilityofElement(driver, paginationPreviousButton);
        return paginationPreviousButton;
    }
    public void click_paginationNextButton() {

        synchronizationVisibilityofElement(driver, paginationNextButton);
        clickOn(paginationNextButton);
    }

    public WebElement getpaginationNextButton() {

        synchronizationVisibilityofElement(driver, paginationNextButton);
        return paginationNextButton;
    }

    public WebElement getActivepaginationNextButton() {

        synchronizationVisibilityofElement(driver, paginationNextButton_Active);
        return paginationNextButton_Active;
    }

    public boolean getActivepaginationNextButton_Status() {

        boolean status = isElementPresent(paginationNextButton_Active);
        return status;
    }

    public WebElement getpaginationNextButtonWithoutSync() {

        return paginationNextButton;
    }

    public void click_paginationFirstButton() {

        synchronizationVisibilityofElement(driver, paginationFirstButton);
        clickOn(paginationFirstButton);
    }

    public WebElement click_paginationLastButton() {
        return paginationLastButton;
    }


    public WebElement clickSortbyName() {
        return paginationLastButton;
    }

    public void click_paginationSecondPageButton() {

        synchronizationVisibilityofElement(driver, paginationSecondPageButton);
        clickOn(paginationSecondPageButton);

    }

    public void click_dataAnalysisTagCollapsingTriangleButton() {

        synchronizationVisibilityofElement(driver, dataAnalysisTagCollapsingTriangleButton);
        clickOn(dataAnalysisTagCollapsingTriangleButton);

    }

    public void click_dataAnalysisTagExpandingTriangleButton() {

        synchronizationVisibilityofElement(driver, dataAnalysisTagExpandingTriangleButton);
        clickOn(dataAnalysisTagExpandingTriangleButton);

    }

    public WebElement retrunsearchBox() {
        synchronizationVisibilityofElement(driver, searchBox);
        return searchBox;
    }

    public WebElement retrunsearchButton() {
        synchronizationVisibilityofElement(driver, searchButton);
        return searchButton;
    }

    public boolean getShowAllButtonInDashboardPage() {
        boolean status = isElementPresent(ShowAll_facet_Button);
        return status;
    }

    public WebElement returnqulityColorBar() {
        synchronizationVisibilityofElement(driver, qualityColorBar);
        return qualityColorBar;
    }

    public WebElement returnqulityLabelDescription() {
        synchronizationVisibilityofElement(driver, qualityLabelDescription);
        return qualityLabelDescription;
    }

    public WebElement returnqualityColorRed() {
        synchronizationVisibilityofElement(driver, qualityColorRed);
        return qualityColorRed;
    }

    public WebElement returnqualityColorGreen() {
        synchronizationVisibilityofElement(driver, qualityColorGreen);
        return qualityColorGreen;
    }

    public WebElement returnqualityColorYellow() {
        synchronizationVisibilityofElement(driver, qualityColorYellow);
        return qualityColorYellow;
    }

    public WebElement returnfullScreenButton() {
        synchronizationVisibilityofElement(driver, fullScreenButton);
        return fullScreenButton;
    }

    public WebElement getCompressScreenButton() {
        synchronizationVisibilityofElement(driver, compressScreenButton);
        return compressScreenButton;
    }

    public void enterTextAndClickSearch() {
        enterText(new SubjectArea(driver).searchBox, new JsonRead().readJSon("subjectAreaSearchText", "SearchTextForComment"));
        clickOn(new SubjectArea(driver).searchButton);

    }

    public void click_lineageSource() {
        synchronizationVisibilityofElement(driver, lineagesource);
        clickonWebElementwithJavaScript(driver,lineagesource);
        waitForAngularLoad(driver);
    }

    public void click_lineagetarget() {
        synchronizationVisibilityofElement(driver, lineagetarget);
        clickonWebElementwithJavaScript(driver,lineagetarget);
        waitForAngularLoad(driver);
    }

    public WebElement getitemFullViewPageCloseButton() {
        synchronizationVisibilityofElement(driver, itemFullViewPageCloseButton);
        return itemFullViewPageCloseButton;
    }

    public void click_clusterDemoCheckbox() {
        synchronizationVisibilityofElement(driver, dataAnalysisCheckbox);
        clickOn(dataAnalysisCheckbox);
    }

    public WebElement returncommentLabel() {
        synchronizationVisibilityofElement(driver, commentLabel);
        return commentLabel;
    }

    public boolean returnnoCommentsLabel() {
        return (isElementPresent(noCommentsLabel));
    }

    public WebElement returnleaveCommentButton() {
        synchronizationVisibilityofElement(driver, leaveCommentButton);
        return leaveCommentButton;
    }

    public void click_leaveCommentButton() {
        synchronizationVisibilityofElement(driver, leaveCommentButton);
        clickOn(leaveCommentButton);
    }

    public WebElement returncommentTextBox() {
        synchronizationVisibilityofElement(driver, commentTextBox);
        return commentTextBox;
    }

    public WebElement returnpostCommentButtom() {
        synchronizationVisibilityofElement(driver, postCommentButton);
        return postCommentButton;
    }


    public WebElement itemComments() {
        synchronizationVisibilityofElement(driver, itemComments);
        return itemComments;
    }

    public WebElement itemCommentsCount() {
        if (isElementPresent(itemCommentsCount)) {
            synchronizationVisibilityofElement(driver, itemCommentsCount);
            return itemCommentsCount;
        } else
            return itemCommentsCount;

    }


    public void click_viewAllComments() {
        synchronizationVisibilityofElement(driver, viewAllComments);
        clickOn(viewAllComments);
    }

    public WebElement viewAllComments() {
        synchronizationVisibilityofElement(driver, viewAllComments);
        return viewAllComments;
    }

    public void enter_comments(String comment) {
        synchronizationVisibilityofElement(driver, enterComments);
        enterText(enterComments, comment);
    }

    public WebElement getEnterCommentsSection() {
        synchronizationVisibilityofElement(driver, enterComments);
        return enterComments;
    }

    public void click_postComments() {
        synchronizationVisibilityofElement(driver, postComments);
        clickOn(postComments);
    }

    public WebElement get_commentsContainer() {
        synchronizationVisibilityofElement(driver, commentsContainer);
        return commentsContainer;
    }

    public WebElement get_showComments() {
        synchronizationVisibilityofElement(driver, showCommentText);
        return showCommentText;
    }

    public void click_commentsDropdownButton() {
        synchronizationVisibilityofElement(driver, commentsDropdownButton);
        clickOn(commentsDropdownButton);
    }

    public List<WebElement> get_CommentsDropdown() {
        synchronizationVisibilityofElementsList(driver, commentsDropdownList);
        return commentsDropdownList;
    }

    public List<WebElement> get_commentsList() {

        synchronizationVisibilityofElementsList(driver, commentsList);
        return commentsList;

    }

    public WebElement get_commentBody() {

        synchronizationVisibilityofElement(driver, commentBody);
        return commentBody;

    }

    public List<WebElement> returnfullviewPageItemPropertiesList() {

        synchronizationVisibilityofElementsList(driver, fullviewPageItemPropertiesList);
        return fullviewPageItemPropertiesList;

    }

    public List<WebElement> returnpreviewPageItemPropertiesList() {

        synchronizationVisibilityofElementsList(driver, previewPageItemPropertiesList);
        return previewPageItemPropertiesList;

    }

    public WebElement returnpreviewPageItemPropertiesTitle() {
        synchronizationVisibilityofElement(driver, previewPageMetaDataTitle);
        return previewPageMetaDataTitle;
    }

    public WebElement returnfullviewPageItemPropertiesTitle() {
        synchronizationVisibilityofElement(driver, fullviewPageItemPropertiesTitle);
        return fullviewPageItemPropertiesTitle;
    }


    public WebElement returnItemNameHeader() {
        synchronizationVisibilityofElement(driver, itemNameHeader);
        return itemNameHeader;
    }

    public WebElement returnitemType() {
        synchronizationVisibilityofElement(driver, itemType);
        return itemType;
    }

    public List<WebElement> returnlistOfItemTypesIntableOfItemsFound() {

        synchronizationVisibilityofElementsList(driver, listOfItemTypesIntableOfItemsFound);
        return listOfItemTypesIntableOfItemsFound;

    }

    public WebElement returnpaginationNextButton() {


        return paginationNextButton;
    }


    public WebElement returncommentDeleteButton() {
        synchronizationVisibilityofElement(driver, commentDeleteButton);
        return commentDeleteButton;
    }

    public WebElement returncommentDeleteButtonWithNoSync() {
        return commentDeleteButton;
    }

    public WebElement returnfirstCommentReplyButton() {
        return firstCommentReplyButton;
    }

    public WebElement returneditCommentTextBox() {
        return editCommentTextBox;
    }


    public WebElement returnsaveButtonofeditCommentTextox() {
        return saveButtonofeditCommentTextox;
    }

    public WebElement returnfirstCommentText() {
        synchronizationVisibilityofElement(driver, firstCommentText);
        return firstCommentText;

    }

    public WebElement returnreplyToConmmentBox() {
        synchronizationVisibilityofElement(driver, replyToConmmentBox);
        return replyToConmmentBox;
    }

    public WebElement returnsendButton() {
        synchronizationVisibilityofElement(driver, sendButton);
        return sendButton;
    }

    public WebElement returntextOfFirstReplyOfComment() {
        synchronizationVisibilityofElement(driver, textOfFirstReplyOfComment);
        return textOfFirstReplyOfComment;
    }

    public WebElement returnEditCommentButton() {
        return EditCommentButton;
    }

    public WebElement returnEditCommentButtonwithoutSync() {

        return EditCommentButton;
    }

    public WebElement returntimeStampOfComment() {
        synchronizationVisibilityofElement(driver, timeStampOfComment);
        return timeStampOfComment;
    }

    public WebElement returnimgaeIconOfComment() {
        synchronizationVisibilityofElement(driver, imgaeIconOfComment);
        return imgaeIconOfComment;
    }

    public WebElement returnfirstCommentTextWithNoSync() {
        return firstCommentText;
    }

    public WebElement returncloseButton() {
        synchronizationVisibilityofElement(driver, closeButton);
        return closeButton;
    }

    public WebElement returnAlertYes() {
        synchronizationVisibilityofElement(driver, AlertYes);
        return AlertYes;
    }

    public List<WebElement> returnAlertYesInList() {
        synchronizationVisibilityofElementsList(driver, AlertYesInList);
        return AlertYesInList;
    }

    public List<WebElement> returndataAnalysisSubTagsWithNoSync() {

        return dataAnalysisSubTags;
    }

    public void click_commentsSection() {
        synchronizationVisibilityofElement(driver, commentsSection);
        clickOn(commentsSection);
    }

    public WebElement returntableFacetSelectionCheckbox() {
        synchronizationVisibilityofElement(driver, tableFacetSelectionCheckbox);
        return tableFacetSelectionCheckbox;
    }

    public WebElement returnbigDataFacetCheckbox() {
        synchronizationVisibilityofElement(driver, bigDataFacetCheckbox);
        return bigDataFacetCheckbox;
    }

    public WebElement returntableFacetCheckbox() {
        synchronizationVisibilityofElement(driver, tableFacetCheckbox);
        return tableFacetCheckbox;
    }

    public WebElement returnsaveSearchButton() {
        synchronizationVisibilityofElement(driver, saveSearchButton);
        return saveSearchButton;
    }

    public WebElement returnsearchName() {
        synchronizationVisibilityofElement(driver, searchName);
        return searchName;
    }

    public WebElement returnsearchDescription() {
        synchronizationVisibilityofElement(driver, searchDescription);
        return searchDescription;
    }

    public WebElement returnSearchSaveButton() {
        synchronizationVisibilityofElement(driver, saveSearchButton);
        return SearchSaveButton;
    }

    public WebElement returnbigDataWidgetselectionCheckbox() {
        synchronizationVisibilityofElement(driver, bigDataWidgetselectionCheckbox);
        return bigDataWidgetselectionCheckbox;
    }

    public WebElement retrunsearchCatalogTopic() {
        synchronizationVisibilityofElement(driver, searchCatalogTopic);
        return searchCatalogTopic;
    }

    public List<WebElement> retrunsearchItemResults() {

        return searchItemResults;
    }

    public List<WebElement> returnmetadataResults() {

        return metadataResults;
    }

    public WebElement getRatingFacet() {
        synchronizationVisibilityofElement(driver, ratingFacet);
        return ratingFacet;
    }

    public WebElement returnBigDataemptyCheckbox() {

        synchronizationVisibilityofElement(driver, bigDataFacetEmptyCheckBox);
        return bigDataFacetEmptyCheckBox;
    }

    public List<WebElement> getRatingFacetList() {

        synchronizationVisibilityofElementsList(driver, ratingFacetList);
        return ratingFacetList;
    }

    public WebElement returnTableemptyCheckbox() {
        synchronizationVisibilityofElement(driver, tableFacetEmptyCheckBox);
        return tableFacetEmptyCheckBox;
    }

    public List<WebElement> getRatingFacetCountList() {

        synchronizationVisibilityofElementsList(driver, ratingFacetCount);
        return ratingFacetCount;
    }

    public WebElement returndatabaseFacetEmptyCheckBox() {
        synchronizationVisibilityofElement(driver, databaseFacetEmptyCheckBox);
        return databaseFacetEmptyCheckBox;
    }

    public List<WebElement> getDataBaseList() {
        synchronizationVisibilityofElementsList(driver, dataBaseList);
        return dataBaseList;
    }

    public List<WebElement> getCheckedRatingFacetCountList() {

        synchronizationVisibilityofElementsList(driver, checkedRatingFacetCount);
        return checkedRatingFacetCount;
    }

    public WebElement returnsearchWidgetCheckbox() {
        synchronizationVisibilityofElement(driver, searchWidgetCheckbox);
        return searchWidgetCheckbox;
    }

    public WebElement ratingOneCheckbox() {
        scrollToWebElement(driver, ratingOneCheckbox);
        return ratingOneCheckbox;
    }

    public WebElement returnduplicateLink() {

        synchronizationVisibilityofElement(driver, duplicateLink);
        return duplicateLink;
    }

    public WebElement ratingTwoCheckbox() {
        scrollToWebElement(driver, ratingTwoCheckbox);
        return ratingTwoCheckbox;
    }

    public WebElement ratingThreeCheckbox() {
        scrollToWebElement(driver, ratingThreeCheckbox);
        return ratingThreeCheckbox;
    }

    public WebElement ratingFourCheckbox() {
        scrollToWebElement(driver, ratingFourCheckbox);
        return ratingFourCheckbox;
    }

    public WebElement ratingFiveCheckbox() {
        scrollToWebElement(driver, ratingFiveCheckbox);
        return ratingFiveCheckbox;
    }

    public void clickAlertsLink() {
        waitForAngularLoad(driver);
        waitandFindElement(driver, alertsLink, 5, false);
        clickOn(alertsLink);
    }

    public List<WebElement> getItemNames() {

        synchronizationVisibilityofElementsList(driver, itemNames);
        return itemNames;
    }

    public WebElement getInvalidSolrError() {
        synchronizationVisibilityofElement(driver, invalidSolrError);
        return invalidSolrError;
    }

    public WebElement getsearchCatalogDropDown() {
        synchronizationVisibilityofElement(driver, searchCatalogDropDown);
        return searchCatalogDropDown;
    }

    public void click_breadcrumbLink() {
        synchronizationVisibilityofElement(driver, breadcrumbLink);
        clickOn(breadcrumbLink);
    }

    public List<WebElement> getBreadCrumbList() {

        synchronizationVisibilityofElementsList(driver, breadCrumbList);
        return breadCrumbList;
    }

    public List<WebElement> getBreadcrumbList() {

        synchronizationVisibilityofElementsList(driver, breadcrumbList);
        return breadcrumbList;
    }

    public List<WebElement> getRatingHeadingList() {

        synchronizationVisibilityofElementsList(driver, ratingHeadingList);
        return ratingHeadingList;
    }

    public WebElement getRatingHeading() {
        synchronizationVisibilityofElement(driver, ratingHeading);
        return ratingHeading;
    }

    public WebElement getMyRatingHeading() {
        synchronizationVisibilityofElement(driver, myRatingHeading);
        return myRatingHeading;
    }

    public WebElement getSearchText() {
        synchronizationVisibilityofElement(driver, searchText);
        return searchText;
    }

    public List<WebElement> getTitleList() {

        synchronizationVisibilityofElementsList(driver, titleList);
        return titleList;
    }

    public List<WebElement> getFacetHeaderList() {

        synchronizationVisibilityofElementsList(driver, facetHeaderList);
        return facetHeaderList;
    }

    public WebElement clickTypeAsColumn() {
        synchronizationVisibilityofElement(driver, facettypeColumn);
        return facettypeColumn;
    }

    public WebElement clickTypeAsTable() {
        synchronizationVisibilityofElement(driver, facettypeTable);
        return facettypeTable;
    }

    public WebElement clickFoodMartFacet() {
        synchronizationVisibilityofElement(driver, foodMartfacet);
        return foodMartfacet;
    }

    public List<WebElement> getTypeColumnValues() {
        synchronizationVisibilityofElementsList(driver, searchResulttypeColumnValues);
        return searchResulttypeColumnValues;
    }

    public List<WebElement> getbreadcrumbItems() {

        synchronizationVisibilityofElementsList(driver, breadcrumbItems);
        return breadcrumbItems;
    }

    public WebElement getbreadcrumbHiddenItemsOptions() {

        synchronizationVisibilityofElement(driver, breadcrumbHiddenItemsOptions);
        return breadcrumbHiddenItemsOptions;
    }

    public WebElement getitemViewResizeButton() {

        synchronizationVisibilityofElement(driver, itemViewResizeButton);
        return itemViewResizeButton;
    }

    public List<WebElement> getbreadcrumbHiddenItemsDropdownMenu() {

        synchronizationVisibilityofElementsList(driver, breadcrumbHiddenItemsDropdownMenu);
        return breadcrumbHiddenItemsDropdownMenu;
    }

    public List<WebElement> getnamesOfBreadcrumbsOpened() {

        synchronizationVisibilityofElementsList(driver, namesOfBreadcrumbsOpened);
        return namesOfBreadcrumbsOpened;
    }

    public WebElement getdynamicItemName(String arg1) {

        return driver.findElement(By.xpath("//b[contains(.,'" + arg1 + "')]"));
    }

    public WebElement getTagText(String tagText) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@title='" + tagText + "']//preceding::label[@for='asg-custom-checkbox'][1]")));
        return driver.findElement(By.xpath("//div[@title='" + tagText + "']//preceding::label[@for='asg-custom-checkbox'][1]"));
    }

    public boolean checkTagPresence() {
        return isElementPresent(clickFacetTag);
    }

    public WebElement clickItemTagCountFromList() {
        synchronizationVisibilityofElement(driver, openItemTagCountFromList);
        return openItemTagCountFromList;
    }

    public WebElement clickItemTagCountFromSpecificTag() {
        synchronizationVisibilityofElement(driver, openItemTagCountFromSpecificTag);
        return openItemTagCountFromSpecificTag;
    }

    public WebElement getRatingWidget(String Message) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-rating-widget-content')]//span[text()=' " + Message + " ']"));
    }
    public WebElement getTrustScoreWidget(String Message) {
        return driver.findElement(By.xpath("//div[contains(@class,'chart-wrapper')]//div[text()='" + Message + "']"));
    }

    public WebElement getParentAndChildTag(String parent, String child) {
        return driver.findElement(By.xpath("(//div[@class[contains(.,'asg-facet-tree-item-holder')]][1][contains(.,'"+parent+"')]//following::div[@class='asg-item-except-count-part'][contains(.,'"+child+"')])[1]"));
    }

    public boolean getChildTag(String child) {
        boolean flag = false;
        try {
            WebElement ele = driver.findElement(By.xpath("//div[@class='asg-search-facet-widget-body']//div[contains(text(),'" + child + "')]"));
            flag = true;
        } catch (Exception ex) {
            flag = false;
        }
        return flag;
    }

    public boolean getWidgetExpand(String Section) {
        boolean flag = false;
        try {
            WebElement ele = driver.findElement(By.xpath("//span[text()='" + Section + "']//span[contains(@class,'fa-caret-down')]"));
            flag = true;
        } catch (Exception ex) {
            flag = false;
        }
        return flag;
    }

    public boolean getUserandRoles(String Section) {
        boolean flag = false;
        try {
            WebElement ele = driver.findElement(By.xpath("//td[contains(@title,'"+Section+"')]"));
            flag = true;
        } catch (Exception ex) {
            flag = false;
        }
        return flag;
    }
    public boolean getWidgetCollapse(String Section) {
        boolean flag = false;
        try {
            WebElement ele = driver.findElement(By.xpath("//span[text()='" + Section + "']//span[contains(@class,'fa-caret-right')]"));
            flag = true;
        } catch (Exception ex) {
            flag = false;
        }
        return flag;
    }

    public boolean verifyTagFrameRightPresence(String actionItem) {
        boolean flag = false;
        String Value = getElementText(getTagFrameRight(actionItem));
        if (Value.contains(actionItem)) {
            flag = true;
        } else {
            flag = false;
        }
        return flag;
    }

    public boolean verifyTagFrameLeftPresence(String actionItem) {
        boolean flag = false;
        String Value = getElementText(getTagFrameLeft(actionItem));
        if (Value.contains(actionItem)) {
            flag = true;
        } else {
            flag = false;
        }
        return flag;
    }

    public WebElement enterTagName() {
        synchronizationVisibilityofElement(driver, enterTagName);
        return enterTagName;
    }

    public WebElement selectTagName(String tagName) {
        return driver.findElement(By.xpath("//ul[@class='nav nav-stacked']//li/div/div/span/span[contains(text(),'" + tagName + "')]"));
    }

    public WebElement getInformationMessage(String Message) {
        return driver.findElement(By.xpath("//div[@class='d-block text-center'][text()=' " + Message + "']"));
    }

    public WebElement assignTagSaveButton() {
        synchronizationVisibilityofElement(driver, assignTagSaveButton);
        return assignTagSaveButton;
    }

    public WebElement unAssignTag() {
        synchronizationVisibilityofElement(driver, unAssignTag);
        return unAssignTag;
    }

    public WebElement clickFacetTag() {
        synchronizationVisibilityofElement(driver, clickFacetTag);
        return clickFacetTag;
    }

    public WebElement clickFacetMenu() {
        synchronizationVisibilityofElement(driver, facetMaintag);
        return facetMaintag;
    }

    public List<WebElement> getItemList() {
        synchronizationVisibilityofElementsList(driver, itemList);
        return itemList;

    }


    public WebElement getcommentsBlockOfItem() {

        scrollToWebElement(driver, commentsBlockOfItem);
        return commentsBlockOfItem;
    }

    public WebElement getdataoftypeName() {

        synchronizationVisibilityofElement(driver, dataoftypeName);
        return dataoftypeName;
    }

    public WebElement getdataoftypeType() {

        synchronizationVisibilityofElement(driver, dataoftypeType);
        return dataoftypeType;
    }

    public WebElement gettagsOfItemsLabel() {

        synchronizationVisibilityofElement(driver, tagsOfItemsLabel);
        return tagsOfItemsLabel;
    }


    public List<WebElement> getPaneltitle() {
        synchronizationVisibilityofElementsList(driver, panelTitle);
        return panelTitle;
    }


    public WebElement getDynamicCheckBoxInParentHierarchy(String text) {

        return driver.findElement(By.xpath("//div[@title='" + text + "']/ancestor::div[@class='asg-item-except-count-part']//div[@class='asg-custom-checkbox']"));
    }

    public WebElement getDynamicCheckBoxInType(String text) {

        return driver.findElement(By.xpath("//div[@title='"+text+"']/ancestor::div[@class[contains(.,'asg-facet-item-body')]]//div[@class='asg-checkbox-small']/input"));
    }

    public WebElement getDynamicChildCheckBoxInTags(String text) {

        return driver.findElement(By.xpath("//div[@title='" + text + "']/ancestor::div[@class='asg-item-unchecked asg-item-childless asg-tree-root-node']//div[@class='asg-custom-checkbox-holder']"));
    }

    public WebElement getDynamicCheckedChildCheckBoxInTags(String text) {

        return driver.findElement(By.xpath("//div[@title='" + text + "']//preceding::label[@for][1]"));
    }

    public WebElement getFacetCheckbox(String text) {
        return driver.findElement(By.xpath("//div[@title='" + text + "']//preceding::label[@for][1]"));
    }

    public WebElement getDynamicCheckBoxInCatalog(String text) {

        return driver.findElement(By.xpath("//div[@title='" + text + "']//preceding::label[@for][1]"));
    }

    public WebElement getDynamicElementInFacet(String facetHeader, String facetItem) {

        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-search-facet-header')]][contains(.,'" + facetHeader + "')]/ancestor::div[@class[contains(.,'asg-search-facet-box-wrapper')]]//div[@title='" + facetItem + "']"));
    }

    public WebElement getDynamicFacetHeader(String text) {

        return driver.findElement(By.xpath("//div[@class='asg-facet-list-wrapper']//div[@class='asg-search-facet-header'][contains(.,'" + text + "')]"));
    }

    public String getFullQualifiedName(String databaseName, String tableName) {

        return "Cluster Demo [Cluster] => HIVE [Service] => " + databaseName + " => " + tableName;
    }

    public List<WebElement> getlistOfItemsInHasColumnsSection() {
        synchronizationVisibilityofElementsList(driver, listOfItemsInHasColumnsSection);
        return listOfItemsInHasColumnsSection;

    }

    public List<WebElement> getlistOfItemsInSimilarSection() {
        synchronizationVisibilityofElementsList(driver, listOfItemsInSimilarSection);
        return listOfItemsInSimilarSection;

    }

    public WebElement getClickOnRightSideScroll() {
        return clickOnRightSideScroll;
    }

    public List<WebElement> getlistOfItemsInHasFieldSection() {
        synchronizationVisibilityofElementsList(driver, listOfItemsInHasFieldSection);
        return listOfItemsInHasFieldSection;

    }

    public WebElement getdisabledPaginationNextPageButton() {

        synchronizationVisibilityofElement(driver, disabledPaginationNextPageButton);
        return disabledPaginationNextPageButton;
    }

    public WebElement getdisabledPaginationPrevPageButton() {

        synchronizationVisibilityofElement(driver, disabledPaginationPrevPageButton);
        return disabledPaginationPrevPageButton;
    }

    public List<WebElement> getlistOfMetadata() {

        synchronizationVisibilityofElementsList(driver, listOfMetadata);
        return listOfMetadata;
    }

    public List<WebElement> getfacetItemCountList() {

        synchronizationVisibilityofElementsList(driver, facetItemCountList);
        return facetItemCountList;
    }

    public List<WebElement> getfacetHeadersList() {

        synchronizationVisibilityofElementsList(driver, facetHeadersList);
        return facetHeadersList;
    }

    public WebElement rateDynamically(String text) {

        return driver.findElement(By.xpath("//div[@class='asg-item-view-rating-stars']/ngb-rating/span[" + text + "]"));
    }

    public List<WebElement> getlistOfTagsInItemList() {

        synchronizationVisibilityofElementsList(driver, listOfTagsInItemList);
        return listOfTagsInItemList;
    }

    public List<WebElement> clickTagWithItemName(String itemName) {
        return driver.findElements(By.xpath("//a[contains(.,'" + itemName + "')]//following::td[@class='asg-item-list-tag-count']"));
    }

    public WebElement getcreateNewTagButton() {
        synchronizationVisibilityofElement(driver, createNewTagButton);
        return createNewTagButton;
    }

    public List<WebElement> getassignedTagsList() {

        synchronizationVisibilityofElementsList(driver, assignedTagsList);
        return assignedTagsList;
    }

    public List<WebElement> getassignedTagsStatusList() {

        synchronizationVisibilityofElementsList(driver, assignedTagsStatusList);
        return assignedTagsStatusList;
    }

    public WebElement getassignUnassignTagsSaveButton() {

        synchronizationVisibilityofElement(driver, assignUnassignTagsSaveButton);
        return assignUnassignTagsSaveButton;
    }


    public WebElement getOlderNotificationOpenLink(String arg1) {
        WebElement element = driver.findElement(By.xpath("//div[@class='asg-older-notifications']//div[@class='asg-notifications-text-block']/span/b[contains(.,'" + arg1 + "')]/ancestor::div[@class='asg-notifications-text-block']//a[contains(.,'Open notification')]"));
        synchronizationVisibilityofElement(driver, element);
        return element;
    }

    public WebElement getNewNotificationOpenLink(String arg1) {
        WebElement element = driver.findElement(By.xpath("//div[@class='asg-new-notifications']//div[@class='asg-notifications-text-block']/span/b[contains(.,'" + arg1 + "')]/ancestor::div[@class='asg-notifications-text-block']//a[contains(.,'Open')]"));
        synchronizationVisibilityofElement(driver, element);
        return element;
    }

    public List<WebElement> getworkflowActionsList() {

        synchronizationVisibilityofElementsList(driver, workflowActionsList);
        return workflowActionsList;
    }

    public WebElement getapprovalRequiredTextElement() {

        synchronizationVisibilityofElement(driver, approvalRequiredTextElement);
        return approvalRequiredTextElement;
    }

    public WebElement gettagStatus() {

        synchronizationVisibilityofElement(driver, tagStatus);
        return tagStatus;
    }

    public WebElement gettagDefinition() {

        synchronizationVisibilityofElement(driver, tagDefinition);
        return tagDefinition;
    }

    public WebElement gettagName() {

        synchronizationVisibilityofElement(driver, tagName);
        return tagName;
    }

    public WebElement gettagCreatedAt() {

        synchronizationVisibilityofElement(driver, tagCreatedAt);
        return tagCreatedAt;
    }

    public WebElement gettagCreatedBy() {

        synchronizationVisibilityofElement(driver, tagCreatedBy);
        return tagCreatedBy;
    }

    public WebElement gettagModifiedBy() {

        synchronizationVisibilityofElement(driver, tagModifiedBy);
        return tagModifiedBy;
    }

    public WebElement gettagModifiedAt() {

        synchronizationVisibilityofElement(driver, tagModifiedAt);
        return tagModifiedAt;
    }

    public WebElement gettagNoCommentsText() {

        synchronizationVisibilityofElement(driver, tagNoCommentsText);
        return tagNoCommentsText;
    }

    public WebElement getaddCommentButton() {

        synchronizationVisibilityofElement(driver, addCommentButton);
        return addCommentButton;
    }

    public WebElement getleaveCommentTextArea() {

        synchronizationVisibilityofElement(driver, leaveCommentTextArea);
        return leaveCommentTextArea;
    }

    public List<WebElement> getlistOfCommentsAdded() {

        synchronizationVisibilityofElementsList(driver, listOfCommentsAdded);
        return listOfCommentsAdded;
    }

    public WebElement getmultiplePanelPopUpOk() {

        synchronizationVisibilityofElement(driver, multiplePanelPopUpOk);
        return multiplePanelPopUpOk;
    }

    public WebElement getworkflowpossibleActionsButton() {
        synchronizationVisibilityofElement(driver, workflowpossibleActionsButton);
        return workflowpossibleActionsButton;
    }

    public WebElement getworkflowpossibleActionsButtonWitoutSync() {
        return workflowpossibleActionsButton;
    }

    public WebElement getpanelExitButton() {

        synchronizationVisibilityofElement(driver, panelExitButton);
        return panelExitButton;
    }

    public WebElement getpanelCloseButton() {

        synchronizationVisibilityofElement(driver, panelCloseButton);
        return panelCloseButton;
    }

    public WebElement getworkflowActionsSubmitButton() {

        synchronizationVisibilityofElement(driver, workflowActionsSubmitButton);
        return workflowActionsSubmitButton;
    }

    public List<WebElement> getlistOfItemNameLink() {

        synchronizationVisibilityofElementsList(driver, itemNameLinks);
        return itemNameLinks;
    }

    public List<WebElement> getlistOfTagNames() {

        synchronizationVisibilityofElementsList(driver, tagsList);
        return tagsList;
    }

    public WebElement getTypeFacetShowAll() {
        synchronizationVisibilityofElement(driver, typeFacetShowAll);
        return typeFacetShowAll;
    }

    public WebElement getTagFacetShowAll() {
        return tagFacetShowAll;
    }

    public WebElement getQuickLinkSave() {
        scrollToWebElement(driver, quickLinkSave);
        return quickLinkSave;
    }

    public WebElement getItemPreviewResizeIcon() {
        return previewResizeIcon;
    }

    public List<WebElement> clickOnItemType() {
        synchronizationVisibilityofElementsList(driver, itemTypeClick);
        return itemTypeClick;
    }

    public WebElement returnquickLinkWidgetselectionCheckbox() {
        synchronizationVisibilityofElement(driver, quickLinkWidgetselectionCheckbox);
        return quickLinkWidgetselectionCheckbox;
    }

    public WebElement returnquickLinkDashboard() {
        scrollToWebElement(driver, quickLinkDashboard);
        return quickLinkDashboard;
    }

    public WebElement retrunWidgetSelectionBox(String widgetName) {
        return driver.findElement(By.xpath("//div[@class='catalog-link']/table//td/span[contains(.,'" + widgetName + "')]/preceding::td[1]//label[@for='asg-custom-checkbox']"));
    }

    public WebElement retrunAcceptWarning() {
        synchronizationVisibilityofElement(driver, acceptWarning);
        return acceptWarning;
    }

    public List<WebElement> getAcceptWarning() {
        synchronizationVisibilityofElementsList(driver, acceptWarningPopup);
        return acceptWarningPopup;
    }

    public boolean getAcceptWarning_Status() {
        Boolean status = isElementPresent(acceptWarning);
        return status;
    }

    public WebElement returnSearchPageTopMenyButtons(String menuName) {
        return driver.findElement(By.xpath("//button/span[contains(text(),'" + menuName + "')]"));
    }

    public WebElement returnQuicklinkLabel() {
        synchronizationVisibilityofElement(driver, quickLinkPanelLabel);
        return quickLinkPanelLabel;
    }

    public WebElement returnQuicklinkNameLabel() {
        synchronizationofElementTobeClickable(driver, quickLinkNameLabel);
        return quickLinkNameLabel;
    }

    public WebElement returnEditDeleteButtonForQuickLink(String buttonName, String linkName) {
        return driver.findElement(By.xpath("//a[contains(.,'" + linkName + "')]/following::div/span[@class='fa fa-" + buttonName + "']"));
    }

    public List<WebElement> retrunQuickLinkListFromMySearchPanel() {
        return quickLinkListFromMySearchPanel;
    }

    public WebElement getJoinTheDiscussionButton() {
        synchronizationVisibilityofElement(driver, joinTheDiscussionButton);
        return joinTheDiscussionButton;
    }

    public List<WebElement> lineageName() {
        return driver.findElements(By.xpath("(//div[@class='builder-item']//table//tr//td//span[contains(.,'LineageHop')]//ancestor::tr//td[1]//span)"));
    }
    public WebElement getSwaggerIframeWidget() {
        synchronizationVisibilityofElement(driver, iframeWidgetSwagger);
        return iframeWidgetSwagger;
    }

    public WebElement getSwaggerIAuthorizeButton() {
        synchronizationVisibilityofElement(driver, authorizeButton);
        return authorizeButton;
    }

    public List<WebElement> getMostFrequentValues() {
        synchronizationVisibilityofElementsList(driver, mostFrequentValues);
        return mostFrequentValues;
    }

    public WebElement getTagLinkForItem(String itemName) {
        return driver.findElement(By.xpath("//div[@class='item-list']//tbody/tr/td[contains(.,'" + itemName + "')]//following::td[@class='asg-item-list-tag-count'][1]/a"));
    }

    public WebElement getUnassignTag(String tagName) {
        return driver.findElement(By.xpath("//div[@class='assigned-tags']/div//ul//li/a[contains(.,'" + tagName + "')]/span/span[2]"));
    }

    public WebElement getItemTooltip(String typeName) {
        return driver.findElement(By.xpath("//td[@class[contains(.,'asg-item-list-ellipsis asg-item-name')]][1]//following::div[contains(text(),'" + typeName + "')][1]"));
    }


    public WebElement getItemAttributeRetrivel(String typeName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'link-with-arrow')]]//following::span[contains(.,'" + typeName + "')][1]"));
    }

    public void clickItemCheckbox(String itemName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//span[contains(text(),'" + itemName + "')]//preceding::div[@class='asg-custom-checkbox'][1]/input")));
    }

    public void clickShowAllButton(String facet) {
        clickOn(driver.findElement(By.xpath("//div[@class='asg-search-facet-header'][contains(text(),'" + facet + "')]//following::div[@class='asg-show-more-facet'][1]/button")));
    }

    public List<WebElement> getSearchItemList() {
        synchronizationVisibilityofElementsList(driver, SearchitemList);
        return SearchitemList;
    }

    public void enableFilterBy(String facet, String value) {
        clickOn(driver.findElement(By.xpath("//div[@class='asg-search-facet-header'][contains(.,'" + facet + "')]//following::div[@title='" + value + "']//preceding::label[@for][1]")));
    }

    public WebElement getHeaderOptions(String headerButtonName) {
        return driver.findElement(By.xpath("//span[contains(.,'" + headerButtonName + "')]/.."));
    }

    public WebElement HeaderCheckBox() {
        synchronizationVisibilityofElement(driver, headerCheckBox);
        return headerCheckBox;
    }

    public WebElement getShowAllButtonIn_DashboardPage() {
        synchronizationVisibilityofElement(driver, ShowAll_facet_Button);
        return ShowAll_facet_Button;
    }

    public WebElement clickType(String typeName) {
        return driver.findElement(By.xpath("//span[@class='asg-facet-toggle-sign ng-star-inserted']//following::strong[contains(text(),'Metadata Type')]//following::div//div//div//following-sibling::div[contains(text(),'" + typeName + "')]"));
    }

    public void clickHeaderOption(String option) {
        clickOn(driver.findElement(By.xpath("//button[@class='btn btn-primary']/span[contains(.,'" + option + "')]")));
    }

    public WebElement getItemTypes(String facetName, String itemName) {
        return driver.findElement(By.xpath("//div[@class='asg-search-facet-header clearfix'][contains(.,'"+facetName+"')]//following::div[@title='"+itemName+"']"));
    }

    public List<WebElement> getFilterByChildsForFacet(String facetName, String itemName) {
        return driver.findElements(By.xpath("//div[@class='asg-search-facet-box-wrapper'][contains(.,'" + facetName + "')]/div[@class='asg-search-facet-box']//div/div/div[contains(.,'" + itemName + "')]"));
    }

    public WebElement getWidgetItemName(String widgetName, String itemName) {
        return driver.findElement(By.xpath("//p[@class='asg-item-view-table-widget-title'][contains(.,'" + widgetName + "')]//following::div//span[contains(.,'" + itemName + "')]"));
    }

    public List<WebElement> getItemTypesList(String facetName, String itemName) {
        return driver.findElements(By.xpath("//div[@class='asg-search-facet-header'][contains(.,'" + facetName + "')]//following::div[@title='" + itemName + "']"));
    }

    public boolean getBAItemFullViewPage() {
        boolean flag = false;
        try {
            WebElement ele = driver.findElement(By.xpath("//div[contains(@class,'app-asg-item-view')]"));
            flag = true;
        } catch (Exception ex) {
            flag = false;
        }
        return flag;
    }

    public WebElement getDetailsWidgetValue(String ItemName, String Value) {
        return driver.findElement(By.xpath("//div[contains(@class,'list-caption')][contains(text(),'" + ItemName + "')]//following::span[contains(text(),'" + Value + "')]"));
    }
    public void clickonRequestLink() {
        clickOn(requestsLink);
    }


    public WebElement showAllFacetButton(String facetSection) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-search-facet-header')][contains(.,'" + facetSection + "')]//following-sibling::div[@class='asg-search-facet-box']//following-sibling::div[contains(@class,'asg-show-more-facet')][contains(.,'Show All')]/button"));
    }

    public List<WebElement> tagsShowAllFacetButton() {
        return driver.findElements(By.xpath("//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'Tags')]//following::div[@class[contains(.,'asg-show-more-facet')]][1]/span[contains(.,'Show More')][1]"));
    }

    public WebElement itemViewClick(String dataType, String itemName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item'][contains(.,'" + dataType + "')]//following::tr/td[1][contains(.,'" + itemName + "')]/span"));
    }

    public List<WebElement> getAttributeList(String facetSection) {
        return driver.findElements(By.xpath("//strong[@class='asg-facet-toggle-header'][contains(.,'"+facetSection+"')]//following::div[@class='asg-search-facet-widget-body'][1]//following::div[1]/div/div[1]//div[@class[contains(.,'asg-facet-tree-item-holder')]]"));
    }

    public List<WebElement> getItemViewPageDataAssetLabels( ) {
        return driver.findElements(By.xpath("//span[contains(., '')]"));
    }

    public List<WebElement> getAttributesListFromFacet(String facetSection) {
        return driver.findElements(By.xpath("//div[@class='asg-search-facet-box']//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'" + facetSection + "')]/../following::div[@class='asg-search-facet-widget-body'][1]//div[contains(@class,'asg-facet-item-holder')]"));
    }

    public List<WebElement> getTaglistfromsearch(String facetSection) {
        return driver.findElements(By.xpath("//div[@class='table mb-0']//span[contains(text(),' "+facetSection+"')]"));
    }
    public List<WebElement> getConfigListFromSearch(String facetSection) {
        return driver.findElements(By.xpath("//div[contains(@class,'list p-3')]//span[contains(text(),'"+facetSection+"')]"));
    }
    public List<WebElement> getAssignedtag(String facetSection) {
        return driver.findElements(By.xpath("//span[contains(text(),'"+facetSection+"')]//following::div[contains(@class,'select-none')]/span[1]"));
    }
    public List<WebElement> getManageConfigPlugin(String section,String plugin) {
        return driver.findElements(By.xpath("//span[contains(.,'"+section+"')]/../following::div//div[contains(@class,'accordion-container')]//span[contains(.,' "+plugin+" ')]"));
    }
    public List<WebElement> getAssignedlist() {
        return driver.findElements(By.xpath("//tr//td[1]//span[text()]"));
    }
    public WebElement getAssignedTags(String Section,String ItemName) {
        return driver.findElement(By.xpath("//span[contains(.,'"+Section+"')]//following::div[contains(@class,'list p-3')]//span/span[contains(.,'"+ItemName+"')]"));
    }
    public List<WebElement> getTagList(String facetName){
        return driver.findElements(By.xpath("//div[@class='asg-search-facet-header'][contains(.,'"+facetName+"')]//following-sibling::div[@class='asg-search-facet-box']//following-sibling::div/div[1]/div[@title]"));
    }
    public WebElement getFacetCheckedTypeCount() {

        return driver.findElement(By.xpath("//div[@class='asg-search-flat-list-widget asg-item-checked']//div[@class='asg-facet-item-count']"));
    }

    public List<WebElement> getItemViewTabs() {
        return itemViewTabs;
    }

    public List<WebElement> getDataSamplingTableHeaders() {
        return dataSamplingTableHeaders;
    }


    public WebElement getItemNameExactText(String itemName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-search-list-item')]]//div[@class='flex-grow-1 d-flex flex-wrap text-truncate']/a[contains(text(),'"+itemName+"')]"));
    }

    public WebElement getItemViewSections(String sectionName) {
        return driver.findElement(By.xpath("//div[@class='item']//div[@class='builder-item']//div[1]/p[contains(.,'" + sectionName + "')]"));
    }

    public WebElement getItemViewTableSections(String sectionName) {
        return driver.findElement(By.xpath("//div[contains(@class,position-relative)]//p/span[contains(.,'" + sectionName + "')]"));
    }

    public List<WebElement> getWidgetContainer(String widgetName) {
        return driver.findElements(By.xpath("//p[contains(@class,'widget-title')]//span[text()='"+widgetName+"']/../../.."));
    }

    public List<WebElement> getChartWidgetContainer(String widgetName) {
        return driver.findElements(By.xpath("//p[contains(@class,'widget-title')]//span[text()='"+widgetName+"']/../../../div//div[contains(@class,'ngx-charts')]//*[name()='svg']//*[name()='g']"));
    }

    public WebElement getItem(String itemValue) {
        return driver.findElement(By.xpath("//td[@class='asg-item-list-ellipsis asg-item-name']/a[contains(text(),'" + itemValue + "')]"));
    }

    public void clickTagAddButton() {
        clickOn(driver.findElement(By.xpath("//span[@class='tags-widget-edit-button span-common fa fas fa-plus']")));
    }

    public WebElement clickItemViewtab(String Tab) {
        return driver.findElement(By.xpath("//div[@class='asg-item-view-tabs']//li/a[contains(text(), '" + Tab + "')]"));
    }

    public WebElement clickFirstcolumn() {
        return driver.findElement(By.xpath("//span[@class='cursor-pointer text-nowrap']"));
    }

    public WebElement removeAttributesFromThePanel(String panelName, String attribute) {
        return driver.findElement(By.xpath("//b[contains(.,'" + panelName + "')]//following::span[contains(.,'" + attribute + "')]//following::button[@class='close'][1]"));
    }

    public WebElement getNoDataFound() {
        return noDataFound;
    }
    public WebElement getFunctions(String itemValue) {
        return driver.findElement(By.xpath("//div[@class='builder-item']//table//tr//td//span[contains(.,'" + itemValue + "')]"));

    }


    public WebElement lineagefrom(String itemValue) {
        return driver.findElement(By.xpath("//div[@class='asg-item-view-table-widget-container']//p//span[contains(text(),'LINEAGE TARGET')]//following::div//span[1]"));
    }

    public String lineagesourceid() {
        return driver.findElement(By.xpath("(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'ID')])//following-sibling::span[@class='list-group-item-right']//span)[4]")).getText();
    }

    public WebElement lineagesourcelocationname() {
        return driver.findElement(By.xpath("(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'Location')])//following-sibling::span[@class='list-group-item-right']//span)"));
    }

    public boolean LineageNameisDisplayed() {

        boolean flag = false;

        try {
            WebElement ele = driver.findElement(By.xpath("(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'Location')])//following-sibling::span[@class='list-group-item-right']//span)"));
            flag = true;
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            flag = false;
        }
        return flag;
    }


    public WebElement lineagetargetlocationname() {
        return driver.findElement(By.xpath("(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'Location')])//following-sibling::span[@class='list-group-item-right']//span)"));
    }

    public String lineagetargetid() {
        return driver.findElement(By.xpath("(((//div[@class='item-view-wrapper item-view-wrapper-full-size'])//ul//li//span[contains(text(),'ID')])//following-sibling::span[@class='list-group-item-right']//span)[4]")).getText();
    }

    //10.3 New UI

    public WebElement selectFacetType(String facetSection, String attribute) {
        return driver.findElement(By.xpath("(//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'"+facetSection+"')]//following::div[@class='asg-checkbox-small']//following::div[@title='"+attribute+"'])[1]"));
    }

    public WebElement getItemCount() {
        synchronizationVisibilityofElement(driver, itemCount);
        return itemCount;
    }

    public WebElement getSearchItemCount() {
        synchronizationVisibilityofElement(driver, searchitemCount);
        return searchitemCount;
    }

    public List<WebElement> returnlistOfItemNamesIntableOfItemsFound() {

        synchronizationVisibilityofElementsList(driver, listOfItemNamesIntableOfItemsFound);
        return listOfItemNamesIntableOfItemsFound;

    }

    public WebElement getdynamicPropertyInMetadataWidget(String propertyName) {
        WebElement element = driver.findElement(By.xpath("//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//b[contains(.,'log')]//following::li/span[contains(.,'"+propertyName+"')]//following::span"));
        return element;
    }

    public WebElement getdynamicPropertyInMetadata(String ItemName, String PropertyName) {
        WebElement element = driver.findElement(By.xpath("//div[contains(@class,'d-flex align-items-center')]//following::span[contains(.,'"+ItemName+"')]//following::div[contains(@class,'list-group-items-container')]/div[contains(@class,'list-caption')][contains(.,'"+PropertyName+"')]//following::span"));
        //WebElement element = driver.findElement(By.xpath("//div//following::span[contains(.,'"+ItemName+"')]//following::div/div[text()=' "+PropertyName+" ']//following::div[1]"));
        return element;
    }

    public WebElement getdynamicPropertyInMetadataWidget(String itemName, String widgetName, String fieldName) {
        WebElement element = driver.findElement(By.xpath("//div//following::span[contains(.,'"+itemName+"')]/../../../../..//span[text()='"+widgetName+"']/..//following::div/div[text()=' "+fieldName+" ']//following::div[1]"));
        return element;
    }

    public WebElement getPropertyMetadata(String PropertyName) {
        WebElement element = driver.findElement(By.xpath("//div[contains(@class,'list-group-items-container')]/div[contains(@class,'list-caption')][contains(.,'"+PropertyName+"')]//following::span[1]"));
        return element;
    }

    public WebElement getdynamicPropertyHostMetadata(String ItemName, String PropertyName) {
        WebElement element = driver.findElement(By.xpath("//div[contains(@class,'asg-panels-item asg-item-view')]//span[contains(.,'" + PropertyName + "')]/following-sibling::span"));
        return element;
    }

    public WebElement getdynamicPropertyInMetadata(String itemName, String itemType, String PropertyName) {
        return driver.findElement(By.xpath("//b[contains(@title,'" + itemName + "')]/following::span[contains(text(),'[" + itemType + "]')]/ancestor::div[contains(@class,'asg-panels-active-item full-size-item')]//span[contains(.,'" + PropertyName + "')]/following-sibling::span"));
    }

    public WebElement showMoreFacetButton(String facetSection) {
        return driver.findElement(By.xpath("//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'"+facetSection+"')]/../following-sibling::div//div[@class[contains(.,'asg-show-more-facet')]][1]/span[contains(.,'Show More')][1]"));
    }

    public WebElement assignBusinessAppl(String facetSection) {
        return driver.findElement(By.xpath("//a[contains(.,'"+facetSection+"')]"));
    }

    public WebElement showRelevantFacetButton(String facetSection) {
        return driver.findElement(By.xpath("//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'"+facetSection+"')]/../following-sibling::div//div[@class[contains(.,'asg-show-more-facet')]][1]/span[contains(.,'Show Relevant')][1]"));
    }

    public WebElement getFacetFilters() {
        return driver.findElement(By.xpath("//div[@hidden]"));
    }

    public WebElement getHeaderCount(){
        return driver.findElement(By.xpath("//strong[contains(.,' Metadata Type ')]//span[contains(.,'(2)')]"));
    }

    public WebElement getFacetCaretRight(){
        return driver.findElement(By.xpath("//em[@class='fa fa-caret-right']"));
    }

    public WebElement getFacetCaretDown(){
        return driver.findElement(By.xpath("//em[@class='fa fa-caret-down']"));
    }

    public List<WebElement> showMoreFacetButtonList(String facetSection) {
        return driver.findElements(By.xpath("//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'"+facetSection+"')]//following::div[@class[contains(.,'asg-show-more-facet')]][1]/span[contains(.,'Show More')][1]"));
    }

    public List<WebElement> getScrollItemList() {
        return driver.findElements(By.xpath("//a[@class[contains(.,'asg-search-list-item-name text-truncate')]]"));
    }

    public List<WebElement> MetadataCaptions() {
        synchronizationVisibilityofElementsList(driver, listOfMetadataCaptions);
        return listOfMetadataCaptions;
    }

    public WebElement getTopItemSearchField() {
        synchronizationVisibilityofElement(driver, topItemSearchField);
        return topItemSearchField;
    }

    public WebElement getTopSearchIcon() {
        synchronizationVisibilityofElement(driver, topSearchIcon);
        return topSearchIcon;
    }

    public List<WebElement> listOfItemsInTab(String tabValue) {
        return driver.findElements(By.xpath("//span[contains(.,'" + tabValue + "')]//following::div[@class='asg-item-view-lazy-load-table-widget-body table-responsive table-wrapper'][1]//table[1]/tbody/tr/td[1]"));
    }

    public WebElement logtext() {
        return analysisLogtext;
    }

    public WebElement getItemName(String itemName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-search-list-item')]][1]//div[@class='flex-grow-1 d-flex flex-wrap text-truncate']/a[contains(text(),'"+itemName+"')]"));
    }

    public void click_itemFullViewPageCloseButton() {
        synchronizationVisibilityofElement(driver, itemFullViewPageCloseButton);
        clickOn(itemFullViewPageCloseButton);
        waitForAngularLoad(driver);
    }

    public List<WebElement> getListOfTagsinSearchResult(String itemName){
        return driver.findElements(By.xpath("(//a[contains(.,'"+itemName+"')])[1]/../following-sibling::div[2]/div/div"));
    }

    public List<WebElement> getMetadataAttributesList(String widgetName) {
        return driver.findElements(By.xpath("//div[contains(@class,'content-center')]//following::span[contains(.,'"+widgetName+"')]/../../..//div[contains(@class,'list-caption')]"));
    }

    public List<WebElement> getSearchPagetagList() {
        return searchPageTagList;
    }

    public List<WebElement> DetailsAttributes() {
        synchronizationVisibilityofElementsList(driver, detailsAttributes);
        return detailsAttributes;
    }

    public List<WebElement> getBAMultiAttributeWidgets() {
        synchronizationVisibilityofElementsList(driver, multiAttributeWidgets);
        return multiAttributeWidgets;
    }

    public List<WebElement> getItemViewPageInfoLabels() {
        return infoLabelsInItemView;
    }

    public List<WebElement> getTableHeaders() {
        return tableHeaders;
    }


    public WebElement getMetaDataAttributes(String sectionName, String itemName) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-multi-properties-widget')]//span[text()='"+sectionName+"']//following::div[contains(@class,'asg-item-view-multi-properties-widget-body')]//div//ul//li//div//div[contains(text(),'" + itemName + "')]"));
    }


    public WebElement getMetaDataAttributeValues(String sectionName, String itemName) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-multi-properties-widget')]//span[text()='" + sectionName + "']//following::div[contains(@class,'asg-item-view-multi-properties-widget')]//div//ul//li//div//div[contains(text(),' " + itemName + " ')]//following::span[1]"));
    }

    public WebElement getTypeColorCode() {
        return typeIcon;
    }

    public WebElement getSelectAllCheckbox() {
        return selectAllCheckbox;
    }

    public WebElement getSelectAllLabel() {
        return selectAllLabel;
    }

    public WebElement getSelectedItemOnlyLabel() {
        return selectedItemsOnlyLabel;
    }

    public List<WebElement> getAssignUnassignTags() {
        return assignUnassignTags;
    }

    public WebElement getSaveSearchButton() {
        return saveSearch;
    }

    public WebElement getSortByIcon() {
        return sortByIcon;
    }

    public WebElement getShowAllLabel() {
        return showAllLabel;
    }

    public WebElement getFirstItemCheckbox() {
        synchronizationVisibilityofElement(driver, firstItemCheckbox);
        return firstItemCheckbox;
    }

    public WebElement getAssignTagSaveButton() {
        synchronizationVisibilityofElement(driver, assignTagSaveButton);
        return assignTagSaveButton;
    }

    public WebElement getAssignTagButton() {
        synchronizationVisibilityofElement(driver, assignButton);
        return assignButton;
    }

    public List<WebElement> selectcheckbox(String itemName) {
        return driver.findElements(By.xpath("//a[contains(.,'"+itemName+"')]//preceding::*[@class='flex-grow-0 flex-shrink-0'][1]/div/label"));
    }

    public WebElement getTabsMenuIcon() {
        synchronizationVisibilityofElement(driver, tabsMenuIcon);
        return tabsMenuIcon;
    }

    public WebElement getTabsMenuSubMenuContainer(){
        return tabsMenuSubMenuContainer;
    }

    public List<WebElement> getHierarchyItemsList(){
        return hierarchyItemlinks;
    }

    public WebElement getHighlightedFirstItemInSerachResult(){
        return highlightedFirstItemInSerachResult;
    }

    public WebElement getUnHighlightedFirstItemInSerachResult(){
        return unHighlightedFirstItemInSerachResult;
    }

    public List <WebElement> getTrustPolicyAddrulesFactor() {
//      synchronizationVisibilityofElement(driver, TrustPolicyAddRulesFactor);
        return TrustPolicyAddRulesFactor;
    }

    public WebElement getHierarchyWidget(){
        return hierarchyWidget;
    }

    public WebElement getTagsWidget(){
        return tagsWidget;
    }

    public List<WebElement> getLineageStatisticsWidget(String widgetName) {
        return driver.findElements(By.xpath("//span[contains(.,'"+widgetName+"')][1]//following::div[@class[contains(.,'widget-body')]][1]"));
    }

    public WebElement getTypeCountInNumberOfItemsWidget() {
        return driver.findElement(By.xpath("//span[contains(.,'Number of Items')][1]//following::div[@class[contains(.,'widget-body')]][1]//following::*[@class='bar']"));
    }

    public List<WebElement> getTableCountFromDiagram() {
        return driver.findElements(By.xpath("//*[@class='nodetspan'][contains(.,'Table')]"));
    }

    public WebElement getNameColumnValue() {
        return nameColumnValue;
    }

    public WebElement getImportedItemTypeColumnValue() {
        return itemTypeColumnValue;
    }

    public List<WebElement> getNameColumnList() {
        return nameColumnList;
    }

    public List<WebElement> getItemTypeColumnList() {
        return itemTypeColumnList;
    }

    public WebElement returngetTopSearchIcon() {
        synchronizationVisibilityofElement(driver, searchIcon);
        return searchIcon;
    }
    public WebElement getFieldTextBox(String textbox){
        return driver.findElement(By.xpath("//div[@class[contains(.,'list-group-items-container')]][contains(.,'"+textbox+"')]//input[@type='text']"));
    }

    public WebElement getTagTextbox(){
        return driver.findElement(By.xpath("//input[@id='asgManageSearch']"));
    }

    public WebElement getTabCompletenessValue(String tabName) {
        return driver.findElement(By.xpath("//div[@class='category-name text-truncate'][contains(.,'"+tabName+"')]/following-sibling::div/div"));
    }

    public WebElement getBAAttributesSaveButton(){
        return baAttributesSaveButton;
    }

    public WebElement getEditBAName(){
        return EditBAName;
    }

    public WebElement getSaveBAName(){
        return SaveBAName;
    }
    public WebElement getCanelBAName(){
        return CanelBAName;
    }
    public WebElement getSearchTagicon(){
        return SearchTagicon;
    }
    public WebElement getCloseTagicon(){
        return CloseTagicon;
    }
    public WebElement getCompletenessExpandButton(String expandButton) {
        return driver.findElement(By.xpath("//span[contains(.,'"+expandButton+"')]/../span"));
    }
    public WebElement getTagCategoryAndType(String labelName) {
        return driver.findElement(By.xpath("//span[@class='tagLabel'][contains(.,'"+labelName+"')]//following::span[1]"));
    }

    public WebElement getTagIconInItemViewPage(){
        return tagIconInItemViewPage;
    }

    public WebElement getTagIconColor(String labelName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'taglist-widget-tag span-common')]][contains(.,'"+labelName+"')]/i"));
    }

    public WebElement getTagIconInSearchResultsPage(String tagName){
        return driver.findElement(By.xpath("//div[contains(.,'"+tagName+"')]/em"));
    }

    public WebElement getTrustPolicyAddrulesLabel() {
        synchronizationVisibilityofElement(driver, TrustPolicyAddRulesLabel);
        return TrustPolicyAddRulesLabel;
    }

    public WebElement getTrustPolicyrulesSave() {
        synchronizationVisibilityofElement(driver, TrustPolicyRulesSave);
        return TrustPolicyRulesSave;
    }

    public WebElement getTrustPolicyFactor() {
        synchronizationVisibilityofElement(driver, TrustPolicyFactor);
        return TrustPolicyFactor;
    }

    public WebElement getTrustScoreExpand() {
        synchronizationVisibilityofElement(driver, TrustScoreExpand);
        return TrustScoreExpand;
    }

    public WebElement getBABusinessTabDetails(String LabelName) {
        return driver.findElement(By.xpath("(//div[contains(text(),'" + LabelName + "')]//following::button[@class='form-control hide-default-toggle dropdown-toggle'])[1]"));
    }

    public WebElement getBABusinessTabDetailsdropdown(String LabelName, String option) {
        return driver.findElement(By.xpath("//div[contains(text(),'" + LabelName + "')]//following::span[contains(text(),'" + option + "')]"));
    }

    public WebElement getChartLegend(String Message) {
        return driver.findElement(By.xpath("//span[contains(text(),'" + Message + "')]"));
    }

    public WebElement getBusinessApplicationPolicyRules(String title) {
        return driver.findElement(By.xpath("//div[@class='ml-3']//span[@class='title'][contains(text(),'" + title + "')]"));
    }

    public WebElement getEditIconBusinessTab(String Icon) {
        return driver.findElement(By.xpath("//em[@class='fal fa-edit pr-1']"));
    }

    public WebElement getTagCategoryDropdown() {
        synchronizationVisibilityofElement(driver, TagCategoryDropdown);
        return TagCategoryDropdown;
    }

    public WebElement getTagCategoryValue(String name) {
        return driver.findElement(By.xpath("//li[contains(text(),'"+name+"')]"));
    }
    public WebElement getExcelImportMenuButton(String excelImportName, String buttonName) {
        return driver.findElement(By.xpath("//td[@class[contains(.,'text-truncate')]][contains(.,'"+excelImportName+"')]//following::span[@title='"+buttonName+"']"));
    }

    public WebElement getExcelImporterTextbox(){
        return excelImporterTextbox;
    }

    public WebElement getExcelImporterFirstRowCheckbox(){
        return excelImporterCheckbox;
    }

    public WebElement getExcelImportPrepopulatedValue(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+fieldName+"')]//following::div/button[1]/span[1]"));
    }

    public WebElement getColumnMappingPrepopulatedValue(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='label'][contains(.,'"+fieldName+"')]//following::td//div[@class[contains(.,'btn-group form-group')]]"));
    }

    public WebElement getDescriptionContent(){
        return descriptionContentInItemViewPage;
    }

    public WebElement getAdvancedmappingradioButton(){
        return advancedmappingradioButton;
    }

    public WebElement getMappingHeader(String mappingName) {
        return driver.findElement(By.xpath("//table[@class[contains(.,'mapping-grid table')]]/thead/tr/th/strong[contains(.,'"+mappingName+"')]"));
    }

    public List<WebElement> getExcelImportColumnList() {
        return excelImportColumnList;
    }

    public WebElement getMappingRadioButton(String columnName, int inputValue) {
        return driver.findElement(By.xpath("//td[@class[contains(.,'form-group text-left border-right')]]/div[contains(.,'"+columnName+"')]//following::td[1]/div[1]/input["+inputValue+"]"));
    }

    public WebElement getScopeLevelTextbox(String columnName){

        return driver.findElement(By.xpath("//td[@class[contains(.,'form-group text-left border-right')]]/div[contains(.,'"+columnName+"')]//following::div[@class[contains(.,'form-group advance-mapping-element')]]/input"));
    }

    public WebElement getExcelImporterName(String name) {
        return driver.findElement(By.xpath("//td[@title='"+name+"']"));
    }

    public WebElement getExcelImporterFunctionality(String name,String functionality) {
        return driver.findElement(By.xpath("(//td[@title='"+name+"']//following::span[@title='"+functionality+"'])[1]"));
    }

    public WebElement returnTimeStampOfExcelImport(String ImportName) {
        return driver.findElement(By.xpath("//div[@class='table']//td[contains(.,'" +ImportName+ "')]//following::td/span[contains(.,'20')]"));
    }

    public List<WebElement> getItemViewBAEditButton() {
        return itemViewBAEditButton;
    }

    public List<WebElement> getItemViewBAShowMoreIcon() {
        return itemViewBAShowMoreIcon;
    }

    public WebElement getBAItemDetailsTextbox(String attributeName) {
        return driver.findElement(By.xpath("//div[@class='list-caption for-edit text-right'][contains(.,'"+attributeName+"')][1]//following::input[1]"));
    }

    public WebElement getBAItemDetailsTextboxDisabled() {
        return driver.findElement(By.xpath("//div[@class='list-caption text-right']//following::span[1]"));
    }

    public WebElement getBAItemBusinessOwnerContainer() {       return BAItemBusinessOwnerContainer;    }
    public WebElement getBAItemDescriptionContainer() {       return BAItemDescriptionContainer;    }

    public WebElement getBAItemSaveButton() {       return BAItemSaveButton;    }
    public WebElement getBAItemCancelButton() {       return BAItemCancelButton;    }

    public WebElement getBAItemViewTabs(String tabName) {
        return driver.findElement(By.xpath("//li[@class[contains(.,'nav-item')]]/a[contains(.,'"+tabName+"')]"));
    }

    public WebElement getBusinessOwnerSuggestion(String suggestionName) {
        return driver.findElement(By.xpath("//span[@class='list-details text-truncate'][contains(.,'"+suggestionName+"')]"));
    }

    public List<WebElement> getBusinessOwnersList() {
        return businessOwnersList;
    }

    public WebElement getDataTabLabelInfo(String info) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'text-content')]][contains(.,'"+info+"')]"));
    }

    public List<WebElement> getPluginAccordion(String pluginAccordion) {
        return driver.findElements(By.xpath("//span[@class='config-detail'][contains(.,'"+pluginAccordion+"')]"));
    }

    public WebElement getMenuButtonForTheItem(String itemName,String menuName) {
        return driver.findElement(By.xpath("//*[contains(.,'"+itemName+"')]//following::span[@title='"+menuName+"']"));
    }

    public WebElement getPluginAccordionDataContent(String dataContent) {
        return driver.findElement(By.xpath("//label[contains(.,'Data')]//following::div[@class[contains(.,'chart-container')]][contains(.,'"+dataContent+"')]"));
    }

    public WebElement getDataElementsLink(){
        return dataElementsLink;
    }

    public WebElement getExpandcollapseLink(String Name) {
        return driver.findElement(By.xpath("//a[contains(.,'"+Name+"')]"));
    }
    public WebElement getFacetCloseIcon() {
        return driver.findElement(By.xpath("//em[@class[contains(.,'fal fa-times remove-tag')]]"));
    }

    public WebElement getHirerachyHeader() {
        return driver.findElement(By.xpath("(//div[@id='asg.parentTypeNamePathHierarchy_ss']//following::input[@id='undefined'])[1]"));
    }
    public WebElement getAccordionPluginStatus(String pluginConfigName,String status) {
        return driver.findElement(By.xpath("//span[@class='config-detail'][contains(.,'"+pluginConfigName+"')]//following-sibling::span/span[@class[contains(.,'status-container')]]/span/img[@src[contains(.,'"+status+"')]]"));
    }

    public WebElement getAccordionIconPresent(String pluginConfigName,String Pluginame) {
        return driver.findElement(By.xpath("//span[contains(.,' "+pluginConfigName+" ')]/../div[@class='expand-collapse-icon-container']//span[contains(.,'"+Pluginame+"')]/img"));
    }

    public WebElement getPluginHeadercolor(String Configname,String color ) {
        return driver.findElement(By.xpath("//span[text()='"+Configname+"']/../../div[@style='background-color: rgb("+color+");']"));
    }

    public WebElement getPluginAccordionFieldValues(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::div"));
    }

    public WebElement getLastExecutionAfterPluginRun(){
        return lastExecutionAfterPluginRun;
    }

    public WebElement getPluginAccordionChartType(String chartType) {
        return driver.findElement(By.xpath("//*[@class[contains(.,'"+chartType+"')]]"));
    }

    public WebElement getPopUpSectionSortButton(String section) {
        return driver.findElement(By.xpath("//span[contains(.,'"+section+"')]//following::div[1]/div/button[@type='button'][1]"));
    }

    public WebElement getPopUpSectionAscendingSortOption(String section) {
        return driver.findElement(By.xpath("//span[contains(.,'"+section+"')]//following::button//span[2]/em[@class[contains(.,'fa fa-sort-alpha-down')]][1]"));
    }

    public WebElement getPopUpSectionDesendingSortOption(String section) {
        return driver.findElement(By.xpath("//span[contains(.,'"+section+"')]//following::button//span[2]/em[@class[contains(.,'fa-sort-alpha-up-alt')]]"));
    }

    public WebElement getPopUpSectionDefaultSortOption(String section) {
        return driver.findElement(By.xpath("//span[contains(.,'"+section+"')]//following::button//span[2]/span/em[@class[contains(.,'fa fa-sort-alpha-down fa-stack')]]"));
    }

    public List<WebElement> getTopbarSectionValues(String itemName, String field) {
        return driver.findElements(By.xpath("//span[@class[contains(.,'asg-item-view-item-name')]][contains(.,'"+itemName+"')]//following::label[contains(.,'"+field+"')]//following::*"));
    }

    public WebElement getItemViewPageTitle(String itemName){
        return driver.findElement(By.xpath("//span[@class[contains(.,'asg-item-view-item-name')]][contains(.,'"+itemName+"')]"));
    }


    public WebElement getTechnologyName (String TechnologyName) {
        return driver.findElement(By.xpath("//*[@class='tick ng-star-inserted'][contains(.,'"+TechnologyName+"')]"));
    }
    public WebElement getOwnersName(String Name){
        return driver.findElement(By.xpath("//span[@class[contains(., 'text-capitalize font-weight')]][contains(., '"+Name+"')]"));
    }

    public WebElement getAvatarIcon(){
        return driver.findElement(By.xpath("//div[@class[contains(., 'avatar d-inline-flex')]]"));
    }

    public WebElement getBAownerName(String Name){
        return driver.findElement(By.xpath("//span[@class[contains(., 'username px-2')]][contains(., '"+Name+"')]"));
    }

    public WebElement getUserInfoPanel(){
        return driver.findElement(By.xpath("//div[@class[contains(., 'drawer-wrapper position-fixed')]]"));
    }

    public WebElement getEmailaddressinfo(String Name){
        return driver.findElement(By.xpath("//div[@class[contains(., 'drawer-wrapper position-fixed')]]//following::div[contains(.,'"+Name+"')]"));
    }

    public WebElement getTagCategoryDefault(String name) {
        return driver.findElement(By.xpath("//div[@class='w-100 form-field-element dropdown']//span[contains(text(),'" + name + "')]"));
    }

    public WebElement getTagItemView(String name) {
        return driver.findElement(By.xpath("(//span[contains(text(),'"+name+"')])[1]"));
    }

    public WebElement getFieldTextExcelName() {
        synchronizationVisibilityofElement(driver, excelName);
        return excelName;
    }

    public WebElement getExcelImporterStatus(String name, String status) {
        return driver.findElement(By.xpath("//td[@title='"+name+"']//following::img[@src='assets/statusIcons/status-"+status+".svg']"));
    }

    public WebElement getExcelImporterSavedAlert(String Message) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+Message+"')]"));
    }

    public WebElement getExcelImporterError(String Message) {
        return driver.findElement(By.xpath("(//div[contains(text(),'"+Message+"')])[1]"));
    }

    public WebElement getBreadcrumbLinkText(String name) {
        return driver.findElement(By.xpath("//div[@class='content']//following::a[contains(text(),'"+name+"')]"));
    }
    public WebElement getSectionTextbox(String section) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'title')]][contains(.,'"+section+"')]//following::input[1]"));
    }

    public List<WebElement> getBAListInItemViewTopSection(){
        return BAListInItemViewTopSection;
    }


    public List<WebElement> getSortTypeForFacet(String facetName, String sortType){
        return driver.findElements(By.xpath("//strong[@class='asg-facet-toggle-header'][contains(.,'"+facetName+"')]/following-sibling::span[@class[contains(.,'"+sortType+"')]]"));
    }

    public List<WebElement> getFacetNumericOrder(String facetName){
        return driver.findElements(By.xpath("//strong[@class='asg-facet-toggle-header'][contains(.,'"+facetName+"')]//following::div[@class='asg-search-facet-widget-body'][1]//div[@class='asg-facet-item-count']"));
    }

    public List<WebElement> getFacetAlphaOrder(String facetName){
        return driver.findElements(By.xpath("//strong[@class='asg-facet-toggle-header'][contains(.,'"+facetName+"')]//following::div[@class='asg-search-facet-widget-body'][1]//div[@class[contains(.,'asg-facet-item-holder')]]"));
    }

    public List<WebElement> getCaptureTabChartTypes() {
        return captureTabChartTypes;
    }

    public WebElement getTabularViewInCaptureTab(String labelName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+labelName+"')]//following::div[@class[contains(.,'accordion-table')]]"));
    }

    public List<WebElement> getDataTableColumnsInCaptureTab(){
        return dataTableColumnsInCaptureTab;
    }

    public WebElement getMetadataTypeAndCount(String typeName) {
        return driver.findElement(By.xpath("//td[contains(.,'"+typeName+"')]/following-sibling::td"));
    }

    public List<WebElement> getNameColumnInCaptureTab() {
        return nameColumnInCaptureTab;
    }

    public List<WebElement> getCountColumnInCaptureTab() {
        return countColumnInCaptureTab;
    }

    public List<WebElement> returncustomAttributesItemtypes() {
        synchronizationVisibilityofElementsList(driver, customAttributesItemtypes);
        return customAttributesItemtypes;
    }

    public WebElement getItemtypesTab(String ItemType,String Tab) {
        return driver.findElement(By.xpath("//div[@class='schemas-content']//div[@class='text-left w-50']//span[contains(text(),'"+ItemType+"')]//following::a[contains(text(),'"+Tab+"')]"));
    }

    public WebElement getItemtypesTabColumn(String ItemType,String Tab,String column) {
        return driver.findElement(By.xpath("//div[@class='schemas-content']//div[@class='text-left w-50']//span[contains(text(),'"+ItemType+"')]//following::a[contains(text(),'"+Tab+"')]//following::span[@id='"+column+"']"));
    }
    public WebElement getItemtypesTabValue(String Tab) {
        return driver.findElement(By.xpath("//a[contains(text(),'"+Tab+"')]"));
    }

    public WebElement getAddCustomAttributes(String button) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+button+"')]"));
    }

    public WebElement getAddCustomAttributesDropdown(String name) {
        return driver.findElement(By.xpath("//button[contains(@class,'form-control hide-default-toggle')]//span[contains(text(),'"+name+"')]"));
    }

    public WebElement getCustomAttributeTextArea() {
        synchronizationVisibilityofElement(driver, valueList);
        return valueList;
    }

    public WebElement getAddCustomAttributesBAText(String name,String Type) {
        return driver.findElement(By.xpath("//span[contains(text(),'Custom')]//following::div[contains(text(),'"+name+"')]//following::input[@type='"+Type+"'][1]"));
    }

    public WebElement getCustomAttributeToggleswitch() {
        synchronizationVisibilityofElement(driver, customAttributesBooleantoggleSwitch);
        return customAttributesBooleantoggleSwitch;
    }

    public WebElement getCustomAttributeToggledswitch() {
        synchronizationVisibilityofElement(driver, customAttributesBooleantoggledSwitch);
        return customAttributesBooleantoggledSwitch;
    }

    public List<WebElement> getItemViewFields() {
        return itemViewFields;
    }

    public List<WebElement> getItemViewDropdownFields() {  return itemViewDropdownFields;  }

    public List<WebElement> getItemViewInputBox() {
        return itemViewInputBox;
    }

    public List<WebElement> getItemViewDropdownMenu() {
        return itemViewDropdownMenu;
    }

    public List<WebElement> getItemViewTextField() {
        return itemViewTextField;
    }

    public List<WebElement> getItemViewDropdownField() { return itemViewDropdownField;  }

    public WebElement getItemViewDropdownBox() { return itemViewDropdownBox;  }

    public WebElement getItemViewWidgetCount(String widgetName){
        return driver.findElement(By.xpath("//span[@class='title text-capitalize position-relative font-weight-bold'][contains(.,'"+widgetName+"')]"));
    }

    public WebElement getFacetsInSearchScreen(String facetName){
        return driver.findElement(By.xpath("//div[@class='asg-search-facet-widget-body']/preceding-sibling::*/strong[contains(.,'"+facetName+"')]"));
    }

    public WebElement getAssignDataButton() { return assignDataButton;  }

    public List<WebElement> getAddToDataSetButton() { return addToDataSetButton;  }

    public WebElement getAddItemToDSInDropdownButton() {
        return driver.findElement(By.xpath("//label[contains(.,'Data Set')]//following::em[@class='fa fa-chevron-down'][1]"));
    }
    public WebElement getAddItemToDSInDropdown(String option) {
        return driver.findElement(By.xpath("//label[contains(.,'Data Set')]//following::div[@role]//button/span[contains(.,'"+option+"')]"));
    }

    public WebElement getAddItemToDSADDButton(String option) {
        return driver.findElement(By.xpath("(//button[@class[contains(.,'spinner-btn')]][contains(.,'"+option+"')])[1]"));
    }

    public List<WebElement> getItemViewShowMoreDropdown() { return itemViewShowMoreDropdown;  }

    public WebElement getDataItemCheckBox(String itemName) {
        return driver.findElement(By.xpath("//div[@class='text-truncate'][contains(.,'"+itemName+"')]/../../../th[@scope='row'][1]//div[1]"));
    }

    public WebElement selectAllDataItem() {
        return selectAllTheDataItem;
    }

    public WebElement getTechnologyColumnValueInItemView(String itemName) {
        return driver.findElement(By.xpath("//div[@class='text-truncate'][contains(.,'"+itemName+"')]/..//..//following-sibling::td[2]"));
    }

    public List<WebElement> getItemViewColumnNamesInTable() { return itemViewColumnNamesInTable;  }

    public WebElement getAccessRequestValueInItemView(int count) {
        return driver.findElement(By.xpath("//tr[1]/th/span/span[@class='select-none']//following::td["+count+"]"));
    }

    public WebElement getAccessRequestOption(String accessName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'access-action')]][contains(.,'"+accessName+"')][1]"));
    }

    public List<WebElement> getToggleList(String facetName) {
        return driver.findElements(By.xpath("//strong[contains(.,'" + facetName + "')]//following::div[contains(@class,'asg-search-facet-widget-body')][1]//button//*[@class='fa fa-chevron-right']"));
    }

    public WebElement getToggleButton(String facetName) {
        return driver.findElement(By.xpath("//strong[contains(.,'" + facetName + "')]//following::div[contains(@class,'asg-search-facet-widget-body')][1]//button//*[@class='fa fa-chevron-right']"));
    }

    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void enterActions(String elementType, String... text) {
        try {
            switch (elementType) {
                case "enter tag details":
                    actionSendKeys(driver, new SubjectAreaManagement(driver).returnTagName(), jsonRead.readJSon("tagWorkFlow", "tagName"));
                    actionSendKeys(driver, new SubjectAreaManagement(driver).returnTagDefinition(), "tagDefinition");
                    new SubjectAreaManagement(driver).click_tagSave();
                    sleepForSec(200);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericClick(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "showAll_Button":
                    clickonWebElementwithJavaScript(driver, getShowAllButtonIn_DashboardPage());
                    break;
                case "Data Sample":
                    clickonWebElementwithJavaScript(driver,clickItemViewtab(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "FirstColumn":
                    clickonWebElementwithJavaScript(driver,clickFirstcolumn());
                    waitForAngularLoad(driver);
                    break;
                case "type":
                    clickonWebElementwithJavaScript(driver, clickType(dynamicItem[0]));
                    sleepForSec(1000);
                    break;
                case "Assign/Unassign Tags":
                    clickHeaderOption(elementName);
                    sleepForSec(200);
                    break;
                case "select tag name":
                    clickonWebElementwithJavaScript(driver, selectTagName(dynamicItem[0]));
                    sleepForSec(500);
                    break;
                case "tagPanelSaveButton":
                    clickonWebElementwithJavaScript(driver, assignTagSaveButton);
                    sleepForSec(1500);
                    break;
                case "create new tag":
                    Click_CreateNewTagButton();
                    break;
                case "item view click":
                    clickOn(itemViewClick(dynamicItem[0], dynamicItem[1]));
                    waitForAngularLoad(driver);
                    break;
                case "Item Full View Close":
                    clickOn(getitemFullViewPageCloseButton());
                    sleepForSec(2000);
                    break;
                case "navigatesToTab":
                    waitForAngularLoad(driver);
                    waitUntilJSReady(driver);
                    traverseListContainsElementAndClick(driver, getItemViewTabs(), dynamicItem[0]);
                    waitUntilJSReady(driver);
                    waitForAngularLoad(driver);
                    break;
                case "Delete":
                    clickOn(getDeleteitem());
                    break;

                case "dynamic item click":
                    List<String> previousPage1 = new ArrayList<>();
                    List<String> currentPage1 = new ArrayList<>();
                    String count1 = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
                    List <WebElement> listValue1 = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
                    for (WebElement ele : listValue1){
                        currentPage1.add(ele.getText());
                    }
                    if(new SubjectArea(driver).scrolListContainsDynamicElementAndClick(driver,listValue1,dynamicItem[0]) != true){
                        if(Integer.parseInt(count1)== currentPage1.size()){
                            Assert.fail("Not able to find the element before scroll ");
                        }
                        while(true){
                            List<WebElement> elements=getScrollItemList();
                            previousPage1.clear();
                            previousPage1.addAll(currentPage1);
                            currentPage1.clear();
                            scrollDownUsingJS(driver,elements,1);
                            waitForAngularLoad(driver);
                            if(new SubjectArea(driver).scrolListContainsDynamicElementAndClick(driver,listValue1,dynamicItem[0]) == true) {
                                break;
                            }
                            for (WebElement ele : new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound()){
                                currentPage1.add(ele.getText());
                            }
                            if(previousPage1.equals(currentPage1)){
                                Assert.fail("Failed to find Element");
                            }
                        }

                    }
                    break;
                case "Previous":
                    if (isElementPresent(disabledPaginationPrevPageButton)) {
                        LoggerUtil.logLoader_info(this.getClass().getName(), "Previous page button is disabled");
                    } else if (isElementPresent(paginationPreviousButton)) {
                        click_paginationPreviousButton();
                    } else {
                        LoggerUtil.logLoader_info(this.getClass().getName(), "Previous page button is not displayed");
                    }

                case "definite facet selection":
                      try {
                        waitForAngularLoad(driver);
                        sleepForSec(1500);
                        if (showMoreFacetButton(dynamicItem[1]).isDisplayed() == true) {
                            waitForAngularLoad(driver);
                            clickOn(showMoreFacetButton(dynamicItem[1]));
                            sleepForSec(1000);
                            moveToElement(driver, selectDefiniteFacetType(dynamicItem[1], dynamicItem[0]));
                            takeScreenShot(this.getClass().getName(), driver);
                            clickOn(driver, selectDefiniteFacetType(dynamicItem[1], dynamicItem[0]));
                            waitForAngularLoad(driver);
                            sleepForSec(1000);
                        } else {
                            throw new Exception();
                        }
                    } catch (Exception e) {
                        clickOn(driver, selectDefiniteFacetType(dynamicItem[1], dynamicItem[0]));
                        takeScreenShot(this.getClass().getName(), driver);
                        waitForAngularLoad(driver);
                        sleepForSec(1500);
                    }

                    break;

                case "add tag button":
                    clickTagAddButton();
                    waitForAngularLoad(driver);
                    break;
                //10.3 New UI
                case "facet selection":
                    try {
                        if (showMoreFacetButton(dynamicItem[1]).isDisplayed() == true) {
                            sleepForSec(2000);
                            clickOn(showMoreFacetButton(dynamicItem[1]));
                            sleepForSec(2000);
                            moveToElement(driver, selectFacetType(dynamicItem[1], dynamicItem[0]));
                            takeScreenShot(this.getClass().getName(), driver);
                            int size = getToggleList(dynamicItem[1]).size();
                            if (getToggleList(dynamicItem[1]).size() != 0) {
                                while (size > 0) {
                                    clickOn(driver, getToggleButton(dynamicItem[1]));
                                    size = getToggleList(dynamicItem[1]).size();
                                    if (size == 0) {
                                        break;
                                    }
                                }
                            }
                            clickOn(driver, selectFacetType(dynamicItem[1], dynamicItem[0]));
                            sleepForSec(3000);

                        } else {
                            throw new Exception();
                        }
                    } catch (Exception e) {

                         sleepForSec(2000);
                        int size = getToggleList(dynamicItem[1]).size();
                        if (getToggleList(dynamicItem[1]).size() != 0) {
                            while (size > 0) {
                                clickOn(driver, getToggleButton(dynamicItem[1]));
                                size = getToggleList(dynamicItem[1]).size();
                                if (size == 0) {
                                    break;
                                }
                            }
                        }
                        clickOn(driver, selectFacetType(dynamicItem[1], dynamicItem[0]));
                        takeScreenShot(this.getClass().getName(), driver);
                        sleepForSec(2000);
                    }

                    break;

                case "item click":
                    List<String> previousPage = new ArrayList<>();
                    List<String> currentPage = new ArrayList<>();
                    String count = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
                    List <WebElement> listValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
                    WebElement scrollBar = driver.findElement(By.xpath("//div[@class[contains(.,'scrollable-content')]]//div/a"));
                    for (WebElement ele : listValue){
                        waitForAngularLoad(driver);
                        currentPage.add(ele.getText());
                        moveToElement(driver, ele);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),""+currentPage.toString());
                    }
                    if(new SubjectArea(driver).scrolListContainsElementAndClick(driver,listValue,dynamicItem[0]) != true){
                        if(Integer.parseInt(count)== currentPage.size()){
                            Assert.fail("Not able to find the element before scroll ");
                        }
                        while(true){
                            List<WebElement> elements=getScrollItemList();
                            previousPage.clear();
                            previousPage.addAll(currentPage);
                            currentPage.clear();
//                            scrollDownUsingJS(driver,elements,4);
                            scrollUsingKeys(scrollBar, "PAGE_DOWN", 1);
                            waitForAngularLoad(driver);
                            if(new SubjectArea(driver).scrolListContainsElementAndClick(driver,listValue,dynamicItem[0]) == true) {
                                waitandFindElement(driver,headerName,30,false);
                                break;
                            }
                            for (WebElement ele : new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound()){
                                currentPage.add(ele.getText());
                            }
                            if(previousPage.equals(currentPage)){
                                Assert.fail("Failed to find Element");
                            }
                        }

                    }
                    break;

                case "latest analysis click":
                    List<String> previousPageLog = new ArrayList<>();
                    List<String> currentPageLog = new ArrayList<>();
                    String query = "SELECT  name from public.items where type='Analysis' and name like '" + dynamicItem[0] + "'  ORDER By  asg_modifiedat DESC LIMIT 1;";
                    String logWithTimeStamp = dbHelper.returnStringValue("APPDBPOSTGRES", query, "name");
                    String logCount = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
                    List<WebElement> logListValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
                    for (WebElement ele : logListValue) {
                        currentPageLog.add(ele.getText());
                        moveToElement(driver, ele);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "" + currentPageLog.toString());
                    }
                    if (new SubjectArea(driver).scrolListContainsElementAndClick(driver, logListValue,logWithTimeStamp) != true) {
                        if (Integer.parseInt(logCount) == currentPageLog.size()) {
                            Assert.fail("Not able to find the element before scroll ");
                        }
                        while (true) {
                            List<WebElement> elements = getScrollItemList();
                            previousPageLog.clear();
                            previousPageLog.addAll(currentPageLog);
                            currentPageLog.clear();
                            scrollDownUsingJS(driver, elements, 4);
                            waitForAngularLoad(driver);
                            if (new SubjectArea(driver).scrolListContainsElementAndClick(driver, logListValue,logWithTimeStamp) == true) {
                                waitandFindElement(driver, headerName, 30, false);
                                break;
                            }
                            for (WebElement ele : new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound()) {
                                currentPageLog.add(ele.getText());
                            }
                            if (previousPageLog.equals(currentPageLog)) {
                                Assert.fail("Failed to find Element");
                            }
                        }

                    }
                    break;
                case "checkbox selection":
                    clickOn(driver, selectcheckbox(dynamicItem[0]).get(0));
                    waitForAngularLoad(driver);
                    break;

                case "Show More Button":
                    clickOn(driver, showMoreFacetButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "click and switch tab":
                    try {
                        clickAndSwitchTab(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(dynamicItem[0], dynamicItem[1]), Duration.ofSeconds(2000), dynamicItem[2]);
                        break;
                    } catch (Exception e) {
                        Assert.fail("Element is not clicked ");
                    }
                    break;
                case "Select All checkbox":
                    clickOn(driver, getSelectAllCheckbox());
                    waitForAngularLoad(driver);
                    break;
                case "Show only selected item":
                    clickOn(driver, getSelectedItemOnlyLabel());
                    break;
                case "Show All Button":
                    clickOn(driver, getShowAllLabel());
                    break;
                case "firstItemCheckbox":
                    clickonWebElementwithJavaScript(driver, getFirstItemCheckbox());
                    sleepForSec(500);
                    break;
                case "Assign/UnAssign Tags":
                    clickonWebElementwithJavaScript(driver, getAssignUnassignTags().get(0));
                    sleepForSec(500);
                    break;
                case "Assign/UnAssign Save":
                    clickonWebElementwithJavaScript(driver, getAssignTagSaveButton());
                    sleepForSec(500);
                    break;
                case "Assign Tag":
                    clickonWebElementwithJavaScript(driver, getAssignTagButton());
                    sleepForSec(500);
                    break;
                case "Tabs Menu Icon":
                    clickOn(driver, getTabsMenuIcon());
                    sleepForSec(500);
                    break;
                case "Edit the excel import":
                    moveToElement(driver,traverseListContainsElementReturnsElement(getNameColumnList(),dynamicItem[0]));
                    clickOn(driver, getExcelImportMenuButton(dynamicItem[0],elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Delete the configuration":
                case "Delete the excel import":
                    moveToElement(driver,traverseListContainsElementReturnsElement(getNameColumnList(),dynamicItem[0]));
                    clickOn(driver, getExcelImportMenuButton(dynamicItem[0],elementName));
                    waitForAngularLoad(driver);
                    break;
                case "first row as column name checkbox":
                    clickOn(driver, getExcelImporterFirstRowCheckbox());
                    waitForAngularLoad(driver);
                    break;
                case "Advanced Mapping radio button":
                    clickOn(driver, getAdvancedmappingradioButton());
                    waitForAngularLoad(driver);
                    break;
                case "Show the data elements in a list link":
                    clickOn(driver, getDataElementsLink());
                    waitForAngularLoad(driver);
                    break;
                case "Assigned to Business Application":
                    clickOn(driver, assignBusinessAppl(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Collapse All":
                case "Expand All":
                    clickOn(driver,getExpandcollapseLink(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Facet close icon":
                    clickOn(driver,getFacetCloseIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Select item":
                    new QuickStartActions(driver).SearchText(dynamicItem[0]);
                    waitUntilAngularReady(driver);
                    sleepForSec(1500);
                    genericClick("firstItemCheckbox");
                    waitUntilAngularReady(driver);
                    break;
                case "Add to Data Set":
                    clickOn(driver,getAddToDataSetButton().get(0));
                    waitForAngularLoad(driver);
                    break;
                case "Hirerachy Header":
                    clickOn(driver, getHirerachyHeader());
                    waitForAngularLoad(driver);
                    break;
            }
        } catch (Exception | AssertionError e) {
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public boolean verifyMetadatavaluesWithJson (String filePath, String jsonPath, String metadataSection) throws Exception {
        boolean flag = false;
        try {
            //int noItems = numberOfMetadataItems.size();
            int noItems = getMetadataItemsSectionWise(metadataSection).size();
            Map<String, String> ActualMap = new HashMap<>();
            int c= driver.findElements(By.xpath("//span[text()='"+metadataSection+"']/../../following-sibling::div//ul")).size();
            for(int j=1; j<=c; j++) {
                int a = driver.findElements(By.xpath("//span[text()='"+metadataSection+"']/../../following-sibling::div//ul["+j+"]/li")).size();
                for (int i = 1; i <= a; i++) {
                    String metadataAttribute = driver.findElement(By.xpath("//span[text()='" + metadataSection + "']/../../following-sibling::div//ul[" + j + "]/li[" + i + "]//div/div[1]")).getText();
                    String metadataValue = driver.findElement(By.xpath("//span[text()='" + metadataSection + "']/../../following-sibling::div//ul[" + j + "]/li[" + i + "]//div/div[2]")).getText();
                    ActualMap.put(metadataAttribute, metadataValue);
                }
            }
            Map<String, String> ExpectedMap = jsonRead.returnMapFromJsonObject(Constant.REST_PAYLOAD + filePath, jsonPath);
            if (ActualMap.entrySet().containsAll(ExpectedMap.entrySet()) && ExpectedMap.size() != 0 && ActualMap.size() != 0) {
                flag = true;
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail(e.getMessage() + "Metadata validation failed for expected values in " + filePath + " with json path " + jsonPath + "  " + e.getMessage());
        }
        return flag;
    }


    public boolean verifyLineageHopValuesWithJson(String filePath,String jsonPath)throws Exception{
        boolean flag=false;
        try{
            List<String> sourcesList= new ArrayList<>();
            List<String> targetList=new ArrayList<>();
            Map<String, List<String>> ExpectedMap = jsonRead.returnMapWithListFromJsonObject(Constant.REST_PAYLOAD+filePath,jsonPath);
            Map<String,List<String>> ActualMap=new HashMap<>();
            List<WebElement> sources= driver.findElements(By.xpath("(//span[contains(text(),'Lineage Source')])[2]/../following-sibling::*//a"));
            scrollToWebElementParamFalse(driver,driver.findElement(By.xpath("(//span[contains(text(),'Lineage Target')])[2]/../following-sibling::*//a")));
            List<WebElement> target= driver.findElements(By.xpath("(//span[contains(text(),'Lineage Target')])[2]/../following-sibling::*//a"));
            for(WebElement sourceEle:sources){
                sourcesList.add(sourceEle.getText());
            }
            Collections.sort(sourcesList);
            for(WebElement targetEle:target){
                targetList.add(targetEle.getText());
            }
            Collections.sort(targetList);
            ActualMap.put("source",sourcesList);
            ActualMap.put("target",targetList);



            if(ActualMap.equals(ExpectedMap)){
                flag=true;
            }
        }catch(Exception e){
            takeScreenShot(this.getClass().getName(),driver);
            Assert.fail("Lineage hops source and target data failed for data with "+filePath+"with jsonpath "+jsonPath+""+e.getMessage());
        }
        return flag;
    }




    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Type":
                    Assert.assertTrue(isElementPresent(getItemTypes(elementName, dynamicItem[0])));
                    break;
                case "LINEAGE HOPS":
                    Assert.assertTrue(isElementPresent(getWidgetItemName(elementName, dynamicItem[0])));
                    break;
                case "Tags":
                    Assert.assertTrue(isElementPresent(getItemTypes(elementName, dynamicItem[0])));
                    break;
                case "Item Full view page":
                    Assert.assertTrue(isElementPresent(new SubjectArea(driver).returnitemFullViewPage()));
                    break;
                case "select All checkbox":
                    Assert.assertTrue(isElementPresent(HeaderCheckBox()));
                    break;
                case "less than":
                    String itemCount = commonUtil.getNUMfromString(new SubjectArea(driver).getItemCount().getText());
                    Assert.assertTrue(Integer.parseInt(itemCount) < 2500);
                    break;
                case "greater than":
                    String searchItemCount = commonUtil.getNUMfromString(new SubjectArea(driver).getItemCount().getText());
                    Assert.assertTrue(Integer.parseInt(searchItemCount) > 2500);
                    break;
                case "widget presence":
                    Assert.assertTrue(isElementPresent(getWidgetContainer(dynamicItem[0]).get(0)));
                    break;
                //10.3 New UI Implementations
                case "verify analysis log contains":
                    switchToChildWindow(driver);
                    String actulText = logtext().getText();
                    if (verifyContains(actulText, dynamicItem[0]) == true) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Text is dsiplayed in Log of IDC UI");
                    } else {
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Text is not displayed in Log of IDC UI");
                        throw new Exception();
                    }
                    break;
                case "verify breadcrumb contains":
                    Assert.assertTrue(isElementPresent(getGetBreadcrumbItems(dynamicItem[0])));
                    break;
                case "DataSamplingTable":
                    Assert.assertTrue(isElementPresent(returnDatasamplingtable()));
                    break;
                case "verify widget contains":
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(dynamicItem[0], dynamicItem[1])));
                    break;
                case "Tag":
                    Assert.assertEquals(getElementText(new AnalysisPage(driver).getWidgetContainerName()),dynamicItem[0]);
                    break;
                case "Search page Improvements":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSelectAllLabel()));
                    Assert.assertTrue(isElementPresent(getSelectedItemOnlyLabel()));
                    Assert.assertTrue(isElementPresent(getAssignUnassignTags().get(0)));
                    Assert.assertTrue(isElementPresent(getSaveSearchButton()));
                    Assert.assertTrue(isElementPresent(getSortByIcon()));
                    break;
                case "Single Item Result":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertEquals(getItemList().size(), 1);
                    break;
                case "Show All Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getShowAllLabel()));
                    break;
                case "Assign/UnAssign Tags":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getAssignUnassignTags().get(0)));
                    break;
                case "Tabs Menu Icon":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getTabsMenuIcon()));
                    break;
                case "Tabs submenus":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getTabsMenuSubMenuContainer()));
                    break;
                case "Lineage Hops":
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(dynamicItem[0], dynamicItem[1])));
                    break;
                case "Lineage Source":
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(dynamicItem[0], dynamicItem[1])));
                    break;
                case "Lineage Target":
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(dynamicItem[0], dynamicItem[1])));
                    break;
                case "Hierarchy widget":
                    Assert.assertTrue(isElementPresent(getHierarchyWidget()));
                    break;
                case "Tags widget":
                    Assert.assertTrue(isElementPresent(getTagsWidget()));
                    break;
                case "section presence":
                    Assert.assertTrue(isElementPresent(getSection(dynamicItem[0])));
                    break;
                case "chart widget presence":
                    Assert.assertTrue(isElementPresent(getChartWidgetContainer(dynamicItem[0]).get(0)));
                    break;
                case "Item view page title":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getItemViewPageTitle(dynamicItem[0])));
                    break;
                case "Metadata facet is pre-selected":
                    takeScreenShot(elementName + " is captured", driver);
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    if (showMoreFacetButton("Metadata Type").isDisplayed() == true) {
                        waitForAngularLoad(driver);
                        clickOn(showMoreFacetButton("Metadata Type"));
                        sleepForSec(1000);
                        Assert.assertTrue(isElementSelected(getDynamicCheckBoxInType(dynamicItem[0])));
                    } else {
                        Assert.assertTrue(isElementSelected(getDynamicCheckBoxInType(dynamicItem[0])));
                        waitForAngularLoad(driver);
                        sleepForSec(1500);
                    }
                    break;
                case "Show Relevant Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(showRelevantFacetButton(dynamicItem[0])));
                    break;
                case "Facets filters":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getFacetFilters()));
                    break;
                case "Header Count":
                    takeScreenShot(elementName + "is captured",driver);
                    Assert.assertTrue(isElementPresent(getHeaderCount()));
                    break;
                case "Facet presence":
                    takeScreenShot(elementName + "is captured",driver);
                    Assert.assertTrue(isElementPresent(getFacetsInSearchScreen(dynamicItem[0])));
                    break;
                case "Add to Data Set":
                    takeScreenShot(elementName + "is captured",driver);
                    Assert.assertTrue(isElementPresent(getAddToDataSetButton().get(0)));
                    break;
                case "Facets caret Right":
                    takeScreenShot(elementName + "is captured",driver);
                    Assert.assertTrue(isElementPresent(getFacetCaretRight()));
                    break;
                case "Facets caret Down":
                    takeScreenShot(elementName + "is captured",driver);
                    Assert.assertTrue(isElementPresent(getFacetCaretDown()));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementNotPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "select All checkbox":
                    Assert.assertTrue(HeaderCheckBox().isEnabled());
                    break;
                case "Type":
                    Boolean isPresent = getFilterByChildsForFacet(elementName, dynamicItem[0]).size() > 0;
                    Assert.assertFalse(isPresent);
                    break;
                case "widget not present":
                    Boolean isNotPresent = getWidgetContainer(dynamicItem[0]).size() > 0;
                    Assert.assertFalse(isNotPresent);
                    break;
                case "Assign/UnAssign Tags":
                    Assert.assertFalse(getAssignUnassignTags().size() > 0);
                    break;
                case "Facets filters":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isNotElementPresent(getHierarchyWidget()));
                    break;
                case "section not present":
                    try{
                       if(isElementPresent(getSection(dynamicItem[0]))){
                           Assert.fail("Section name is Present in Item View Page");
                       }
                    }catch (Exception e){
                        e.getMessage();
                    }
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }


    public void genericVerifyEquals(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "items count":
                    dynamicItem[0] = CommonUtil.getText();
                    Assert.assertEquals(getItemCount().getText().split(" Results")[0], dynamicItem[0]);
                    break;
                case "search first item":
                    Assert.assertEquals(getSearchItemList().get(0).getText().trim(), dynamicItem[0].trim());
                    break;
                case "file count":
                    dynamicItem[0] = CommonUtil.getText();
                    Assert.assertEquals(commonUtil.getNUMfromString(getItemCount().getText()), dynamicItem[0]);
                    break;
                case "search result":
                    dynamicItem[0] = CommonUtil.getText();
                    Assert.assertEquals(commonUtil.getExactNumfromUISearchResults(getItemCount().getText()), dynamicItem[0]);
                    break;
                case "search item count":
                    Assert.assertEquals(getElementText(getItemCount()), dynamicItem[0]);
                    break;
                case "verify equals":
                    Assert.assertEquals(getAttributeValue(dynamicItem[0], dynamicItem[1]),CommonUtil.getTemporaryText());
                    break;
                case "verify not equals":
                    String staticValue = getAttributeValue(dynamicItem[0], dynamicItem[1]);
                    CommonUtil.storeText(dynamicItem[1]);
                    Assert.assertNotEquals(FileUtil.readAllBytesInFile(Constant.LocalDirectory),staticValue);
                    break;

            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void deleteMultipleItems(String... dynamicItem) throws Throwable {
        List<String> deleteValueList = new ArrayList<String>();
        RESTAPIDefinition restObj = new RESTAPIDefinition();
        List<String> url = new ArrayList<>();
        restObj.initializeRestAPI("IDC");
        String multiDeleteQuery;
        String singleDeleteQuery;
        String deleteID = null;
        restObj.a_query_param_with_and_and_supply_authorized_users_contentType_and_Accept_headers(dynamicItem[4], dynamicItem[5]);
        try {
            switch (dynamicItem[0]) {
                case "MultipleIDDelete":
                    if (dynamicItem[1].contains("ExternalPackage")) {
                        multiDeleteQuery = "SELECT  id from public.items where type='" + dynamicItem[1] + "' and asg_scopeid isnull";
                    }
                    if (dynamicItem[1].contains("DataPackage")) {
                        multiDeleteQuery = "SELECT  id from public.items where type='" + dynamicItem[1] + "' and asg_scopeid isnull";
                    } else if (dynamicItem[1].contains("Analysis")) {
                        multiDeleteQuery = "SELECT  id from public.items where type='" + dynamicItem[1] + "' and name like '" + dynamicItem[3] + "'";
                    } else {
                        multiDeleteQuery = "SELECT  id from public.items where type='" + dynamicItem[1] + "' and name like '" + dynamicItem[3] + "'";
                    }
                    deleteValueList = dbHelper.returnRowValuesInList(dbHelper.returnQueryMap("APPDBPOSTGRES", multiDeleteQuery), "id");
                    for (int i = 0; i < deleteValueList.size(); i++) {
                        url.add("items/Default/" + dynamicItem[2] + "" + "." + dynamicItem[1] + ":::" + deleteValueList.get(i));
                        restObj.invokeDeleteRequest(url.get(i));
                        restObj.status_code_must_be_returned(204);
                    }
                    break;
                case "SingleItemDelete":
                    if (dynamicItem[1].contains("Analysis")) {
                        singleDeleteQuery = "SELECT  id from public.items where type='" + dynamicItem[1] + "' and name like '" + dynamicItem[3] + "' ORDER By  asg_modifiedat DESC LIMIT 1;";
                    } else {
                        singleDeleteQuery = "SELECT  id from public.items where type='" + dynamicItem[1] + "' and name = '" + dynamicItem[3] + "'";
                    }
                    deleteID = dbHelper.returnStringValue("APPDBPOSTGRES", singleDeleteQuery, "id");
                    if (deleteID != null) {
                        url.add("items/Default/" + dynamicItem[2] + "" + "." + dynamicItem[1] + ":::" + deleteID);
                        restObj.invokeDeleteRequest(url.get(0));
                        restObj.status_code_must_be_returned(204);
                    }
                    break;
            }
            url.clear();
            deleteValueList.clear();

        } catch (Exception e) {
            takeScreenShot("Not deleted items", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "items/Default/" + dynamicItem[2] + "" + "." + dynamicItem[1] + ":::" + deleteID + "is wrong, check the TYPE and NAME combination in feature file");
            Assert.fail("check the TYPE and NAME combination in feature file");
        }
    }

    public boolean isDataSetElementPresentInMap(List<Map<String, String>> values, String... arg) throws Exception {
        boolean flag = false;
        switch (arg[0]) {
            case "verify metadata property values":
                for (Map<String, String> metadataMap : values) {
                    for (Map.Entry<String, String> entry : metadataMap.entrySet()) {
                        Assert.assertEquals(new SubjectArea(driver).getdynamicPropertyInMetadata(arg[1], entry.getKey()).getText(), entry.getValue());
                    }
                }
                break;

            case "verify metadata attributes":
                List<String> expectedAttributes = new ArrayList<>();
                List<String> actualAttributes = new ArrayList<>();
                for (Map<String, String> metadataMap : values) {
                    expectedAttributes.add(metadataMap.get("metaDataAttribute"));
                }
                for (Map<String, String> metadataMap : values) {
                    if (!getMetaDataAttributes(metadataMap.get("widgetName"), metadataMap.get("metaDataAttribute")).isDisplayed() || getMetaDataAttributeValues(metadataMap.get("widgetName"), metadataMap.get("metaDataAttribute")).getText().equals(null)) {
                        flag = false;
                        break;
                    } else {
                        actualAttributes.add(getMetaDataAttributes(metadataMap.get("widgetName"), metadataMap.get("metaDataAttribute")).getText().trim());
                    }
                }
                Collections.sort(expectedAttributes);
                Collections.sort(actualAttributes);
                if (expectedAttributes.equals(actualAttributes)) {
                    flag = true;
                }
                break;


            case "Data Sample":
                List<String> actualValues = new ArrayList<String>();
                List<String> expectedValues = new ArrayList<String>();
                Set<String> dataHeader = new HashSet<>();
                for (Map<String, String> metadataMap : values) {
                    for (Map.Entry<String, String> entry : metadataMap.entrySet()) {
                        expectedValues.add(entry.getValue());
                    }
                }

                for(int i = 0; i<values.size();i++){
                    for(Map.Entry<String,String> entry : values.get(i).entrySet()){
                        dataHeader.add(entry.getKey().toString());
                    }
                }

                for (String value : dataHeader) {
                    for (int r = 1; r <= tableRows().size(); r++) {
                        int c = getLowerCaseTextListFromElementsList(getDataSamplingTableHeaders()).indexOf(value.toLowerCase()) + 1;
                        actualValues.add(getTableValue(value, r, c).getText());
                    }
                }


                if (CommonUtil.compareLists(expectedValues, actualValues) == true) {
                    flag = true;
                } else {
                    Assert.fail("Check both the list Expected List \r\n"+expectedValues+" and Actual List \r\n"+actualValues);
                    throw new Exception();
                }
                break;
        }
        return flag;
    }


    public boolean verifyElementNotPresent(String elementType, String... arg) throws Exception {
        boolean flag = false;
        switch (elementType) {
            case "catalog not contains":
                try {
                    if (isElementPresent(selectFacetType(arg[1], arg[0])) == true) {
                        flag = true;
                        Assert.fail(arg[0] + " is displyaed in UI");
                    }
                    break;
                } catch (Exception e) {
                    takeScreenShot(arg[0] + " is not displayed in UI", driver);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg[0] + " is not displayed in UI");
                }
                break;

            case "verify logtext not contains":
                try {
                    if (verifyContains(new AnalysisPage(driver).logtext(), arg[0]) == false) {
                        flag = true;
                    }
                    break;
                } catch (NoSuchElementException e) {
                    takeScreenShot(arg[0] + " is displayed in logtext", driver);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg[0] + " is not displayed in UI");
                }
                break;

        }
        return flag;
    }

    public void genericVerifyElementIsEnabled(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Add to Data Set Button":
                    Assert.assertTrue(isElementPresent(getAddToDataSetButton().get(0)));
                    break;
            }
        } catch (org.openqa.selenium.NoSuchElementException e) {
            //Assert.fail(e.getMessage() + "Element not found ");
            LoggerUtil.logLoader_info("Element Not found" + e.getMessage(), e.getLocalizedMessage());
        }

    }

    public void genericVerifyElementIsDisabled(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Add to Data Set Button":
                    Assert.assertFalse(isElementPresent(getAddToDataSetButton().get(0)));
                    break;
            }
        } catch (org.openqa.selenium.NoSuchElementException e) {
            //Assert.fail(e.getMessage() + "Element not found ");
            LoggerUtil.logLoader_info("Element Not found" + e.getMessage(), e.getLocalizedMessage());
        }

    }


    public List<WebElement> returnDynamicItemName(String itemName) {
        List<WebElement> dynamicItemValue = driver.findElements(By.xpath("//span[@class='asg-search-list-item-name text-truncate'][contains(.,'"+itemName+"')]"));
        return dynamicItemValue;
    }

    @FindBy(xpath = "//td[@class='asg-item-list-ellipsis asg-item-name']/a")
    private List<WebElement> itemResultList;

    @FindBy(xpath = "//div[@class='builder-item']//table//tr//td//span[contains(.,'Function')]//ancestor::tr//td[1]//span")
    private List<WebElement> functiontList;

    @FindBy(css = "//tbody//tr//td//span[contains(@title,'[Function]')]")
    private WebElement functionttoscroll;

    @FindBy(xpath = "//div[@class='builder-item']//table//tr//td//span[contains(.,'LineageHop')]//ancestor::tr//td[1]//span")
    private List<WebElement> lineagelist;

    public List<WebElement> itemResultList() {
        synchronizationVisibilityofElementsList(driver, itemResultList);
        return itemResultList;
    }

    @Override
    public List<WebElement> getTemporaryList() {
        return super.getTemporaryList();
    }

    public List<WebElement> FunctionList() {
        synchronizationVisibilityofElementsList(driver, functiontList);
        return functiontList;
    }

    public WebElement Functiontoscroll() {
        scrollToWebElement(driver, functionttoscroll);
        return functionttoscroll;
    }

    public List<WebElement> LineageList() {
        synchronizationVisibilityofElementsList(driver, lineagelist);
        return lineagelist;
    }

    public void scrollToItemInSearchResult(String... dynamicItem) {
        String a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
        String b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
        List<WebElement> listValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
        List<WebElement> elements = getScrollItemList();
        int y1 = 0;
        int y2 = 0;
        while (true) {
            if (traverseListContainsDynamicElementText(listValue, dynamicItem[0]) == true) {
                break;
            } else {
                a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                y1 = Integer.parseInt(commonUtil.getNUMfromString(a));
                scrollDownUsingJS(driver, elements, 1);
                waitForAngularLoad(driver);
                sleepForSec(2000);
                b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                y2 = Integer.parseInt(commonUtil.getNUMfromString(b));

                if (y1 == y2) {
                    if (traverseListContainsDynamicElementText(listValue, dynamicItem[0]) == true) {
                        break;
                    } else {
                        Assert.fail(dynamicItem[0] + " not found");
                    }

                }
            }
        }
    }

    public void clickElementonanyPageination(List<WebElement> List, String text) {
        try {
            waitForAngularLoad(driver);
            if (isElementPresent(getpaginationNextButton()) == false) {
            } else try {
                if (isElementPresent(getpaginationNextButton()) == true && isElementPresent(getPaginationPreviousButton()) == true) {
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver, getPaginationPreviousButton());
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver, getpaginationNextButton());
                    waitForAngularLoad(driver);
                    trversePaginationAndClickOnItemThatIsDynamic(driver, List, text, getpaginationNextButton());
                }
            } catch (Exception e) {
                if (isElementPresent(getpaginationNextButton()) == false) {
                } else try {
                    if (isElementPresent(getpaginationNextButton()) == true) {
                        waitForAngularLoad(driver);
                        trversePaginationAndClickOnItemThatIsDynamic(driver, List, text, getpaginationNextButton());

                    }
                } catch (Exception h) {
                    new DashBoardPage(driver).Click_profileLogoutButton();
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                    Assert.fail(h.getMessage());
                }
            }

        } catch (Exception e) {
            try {
                if (isElementPresent(getPaginationPreviousButton()) == false) {

                } else try {
                    if (isElementPresent(getPaginationPreviousButton()) == true) {
                        waitForAngularLoad(driver);
                        trversePaginationAndClickOnItemThatIsDynamic(driver, List, text, getPaginationPreviousButton());
                    }
                } catch (Exception a) {
                    if (isElementPresent(getpaginationNextButton()) == false) {
                    } else try {
                        if (isElementPresent(getpaginationNextButton()) == true) {
                            waitForAngularLoad(driver);
                            trversePaginationAndClickOnItemThatIsDynamic(driver, List, text, getpaginationNextButton());
                            new SubjectArea(driver).dismissWarning_ifdisplayed();
                        }
                    } catch (Exception h) {
                        new DashBoardPage(driver).Click_profileLogoutButton();
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                        Assert.fail(h.getMessage());
                    }
                }
            } catch (Exception f) {
                if (traverseListContainsDynamicElementText(List, text)) {
                    WebElement element = traverseListContainsDynamicElementTextReturnsElement(List, text);
                    waitandFindElement(driver, element, 3, false);
                    clickonWebElementwithJavaScript(driver,element);
                }
            }
        }
    }


    public List<String> returnListTextfromSection(String elementName, String tabName) {
        List<String> itemResults = new ArrayList<>();
        switch (elementName) {
            case "returnListText":

                try {
                    if (tabPaginationNextButton(tabName).isDisplayed()) {
                        try {
                            while (tabPaginationNextButton(tabName).isDisplayed()) {
                                itemResults.addAll(itemResults.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                                clickOn(tabPaginationNextButton(tabName));
                                waitForAngularLoad(driver);
                            }
                        } catch (Exception e) {
                            itemResults.addAll(itemResults.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                        }
                    }
                } catch (Exception e) {
                    itemResults.addAll(itemResults.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                }
                break;

        }
        return itemResults;
    }

    public boolean verifyTagPresenceForFileName(String... arg) {
        //arg[0] = catalog Name; arg[1]=name; arg[2]=Tags; args[3]=facettype; arg[4]=fileName
        boolean flag = false;
        try {
            //select the Catalog, type and Value form Item results
            clickonWebElementwithJavaScript(driver,new PluginManager(driver).catalogDropDown());
            sleepForSec(2000);
            WebElement catalogname = traverseListContainsElementReturnsElement(new PluginManager(driver).catalogList(), arg[0]);
            clickOn(catalogname);
            waitandFindElement(driver, new SubjectArea(driver).verifyStructure(), 30, false);
            genericClick("facet selection", arg[1], arg[3]);
            waitForAngularLoad(driver);
            genericClick("item click",arg[4]);
            //clickOn(returnfirstItemListName());
            waitForPageLoads(driver, 10);
            waitandFindElement(driver, new AnalysisPage(driver).verifyAnalysisPage(), 30, false);
            String formatedTypeName =  getTypeNameInItemView(arg[1]).getText().replaceAll("[\\[|\\]]","");
            //Verifying the Tag
            if(formatedTypeName.equalsIgnoreCase(arg[1])) {
                //get the Expected Value
                List<String> expected = new ArrayList<>();
                String[] exp = arg[2].split(",");
                for (String value : exp) {
                    expected.add(value);
                }

                //get the actual value
                List<String> actual = new ArrayList<>();
                actual.addAll(getStringListFromElementsList(new AnalysisPage(driver).getListOFTags()));

                //Check if the expected list is present in actual list
                int acutalSize = actual.size();
                int expectedSize = expected.size();
                if (expectedSize <= acutalSize) {
                    for (int i = 0; i < expectedSize; i++) {
                        Iterator<String> e = expected.iterator();
                        if (traverseListContainsString(actual, expected.get(i)) == false) {
                            flag = false;
                            break;
                        }
                        flag = true;
                        e.next();
                    }

                }
            }
        } catch (Exception e) {
            e.getMessage();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Exception captured for "+ arg[1] + ":" +e.getMessage());
        }
        return flag;
    }

    public boolean verifyTagPresenceInSearchResult(String... arg) {
        //arg[0] = catalog Name; arg[1]=name; arg[2]=Tags; args[3]=facettype; arg[4]=fileName
        boolean flag = false;
        try {
//            new DashboardActions(driver).genericActions("click", "Global Search Icon");
//            new CommonActions(driver).selectCatalogAndSearchItems("All Catalogs", arg[0]);
            new QuickStartActions(driver).SearchText(arg[5]);

            genericClick("definite facet selection", arg[1], arg[3]);
            scrollToItemInSearchResult(arg[4]);
            waitForAngularLoad(driver);

            //get the actual value
            List<String> actual = new ArrayList<>();
            actual.addAll(getStringListFromElementsList(getListOfTagsinSearchResult(arg[4])));

            List<String> expected = new ArrayList<>();
            String[] exp = arg[2].split(",");
            for (String value : exp) {
                expected.add(value);
            }
            if (arg[1].equals("Cluster") || arg[1].equals("Service") || arg[1].equals("Host")) {
                int acutalSize = actual.size();
                int expectedSize = expected.size();
                if (expectedSize <= acutalSize) {
                    for (int i = 0; i < expectedSize; i++) {
                        Iterator<String> e = expected.iterator();
                        if (traverseListContainsString(actual, expected.get(i)) == false) {
                            flag = false;
                            break;
                        }
                        flag = true;
                        e.next();
                    }
                }
            } else {
                int acutalSize = actual.size();
                int expectedSize = expected.size();
                String shs = expected.get(0).toString();
                Assert.assertEquals(actual.size(), expected.size() );
                Collections.sort(actual);
                Collections.sort(expected);
                Assert.assertTrue(CommonUtil.compareLists(expected, actual));
                if (CommonUtil.compareLists(expected, actual) == true) {
                    flag = true;
                }
            }
//            genericClick("item click", arg[4]);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg[4] + " Tag verification");
            e.getMessage();
        }

        return flag;
    }

    public boolean verifyTagNonPresenceInSearchResult(String... arg) {
        //arg[0] = catalog Name; arg[1]=name; arg[2]=Tags; args[3]=facettype; arg[4]=fileName
        boolean flag = false;
        try {
            new QuickStartActions(driver).SearchText(arg[5]);
//            new CommonActions(driver).selectCatalogAndSearchItems("All Catalogs", arg[0]);
            genericClick("definite facet selection", arg[1], arg[3]);
            scrollToItemInSearchResult(arg[4]);
            waitForAngularLoad(driver);

            //get the actual value
            List<String> actual = new ArrayList<>();
            actual.addAll(getStringListFromElementsList(getListOfTagsinSearchResult(arg[4])));

            List<String> expected = new ArrayList<>();
            String[] exp = arg[2].split(",");
            for (String value : exp) {
                expected.add(value);
            }
            int acutalSize = actual.size();
            int expectedSize = expected.size();
            for (String tag : expected) {
                if (actual.contains(tag) == true) {
                    flag = true;
                    break;
                }
            }
//            genericClick("item click", arg[4]);
        } catch (Exception e) {
            e.getMessage();
        }

        return flag;
    }

    public boolean verifyWindowNonPresence(String... arg) {
        //        arg[0]= catalogName, arg[1]= facetName, arg[2]= facet, arg[3]= itemName, arg[4]= windowName
        boolean flag = false;
        try {
            new QuickStartActions(driver).SearchText(arg[3]);
//            new CommonActions(driver).selectCatalogAndSearchItems("All Catalogs", arg[0]);
            genericClick("facet selection", arg[1], arg[2]);
            scrollToItemInSearchResult(arg[3]);
            waitForAngularLoad(driver);
            genericClick("item click", arg[3]);

            if (new AnalysisPage(driver).getDynamicWindNumbers(arg[4]) == 0) {
                flag = true;
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg[4] +" window is not available");
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg[4] +" window is available");
                Assert.fail(arg[4] +" window is available");
            }
        } catch (Exception e) {
            e.getMessage();
        }

        return flag;
    }

    public boolean verifyTagPresence_1(String arg, String item) {
        boolean flag = false;
        try {
            //select the Catalog, type and Value form Item results


            List<String> expected = new ArrayList<>();
            String[] exp = arg.split(",");
            for (String value : exp) {
                expected.add(value);
            }

            //get the actual value
            List<String> actual = new ArrayList<>();
            List<WebElement> actualElement = new AnalysisPage(driver).getListOFTagsNew(item);
            for (int i = 0; i < actualElement.size(); i++) {
                actual.add(actualElement.get(i).getText());
            }
            //Compare actual and expected list
            if (CommonUtil.compareLists(actual, expected) == true) {
                flag = true;
            }

        } catch (Exception e) {
            e.getMessage();
        }
        return flag;
    }

    public Map<String, String> getMapValueFromJson(String filePath, String jsonPath) {
        Map<String, String> value = new TreeMap<>();
        try {
            List<String> test = JsonRead.returnJsonObjectAsList(Constant.REST_PAYLOAD + filePath, jsonPath);
            Object obj = test.get(0);
            String objectString = obj.toString();
            String[] splitString = objectString.split(",");
            List<String> valueList = new SortedArrayList<>();
            for (String val : splitString) {
                valueList.add(val);
            }
            for (String val : valueList) {
                String[] arrayValue = val.split(":", 2);
                value.put(arrayValue[0].replaceAll("\"", "").replace("{", ""), arrayValue[1].replaceAll("\"", "").replace("}", ""));
            }

        } catch (Exception e) {
            e.getMessage();
        }
        return value;
    }

    public boolean verifyValue(String... arg) {
        boolean flag = false;
        try {
            switch (arg[0].toLowerCase()) {
                case "value":
                    String actualValue = JsonRead.getJsonValue(Constant.REST_PAYLOAD + arg[1], arg[2]);
                    String value = actualValue.replace("[\"", "").replace("\"]", "");
                    if (value.equals(arg[3])) {
                        flag = true;
                    }
                    break;

                case "file value":
                    String actualFileValue = JsonRead.getJsonValue(Constant.REST_PAYLOAD + arg[1], arg[2]);
                    String fileValue = actualFileValue.replace("[\"", "").replace("\"]", "");
                    FileUtil.deleteFile(Constant.REST_PAYLOAD + arg[1]);
                    FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + arg[1], fileValue);
                    flag = FileUtil.fileCompare(Constant.REST_PAYLOAD + arg[1], Constant.REST_PAYLOAD + arg[4]);
                    break;
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return flag;
    }


    public boolean verifyListElementNotPresent(List<String> itemNames, String... arg) throws Exception {
        boolean flag = false;
        switch (arg[0]) {
            case "Items List":
                String a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                String b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                List<String> currentPage = new ArrayList<>();
                List<WebElement> listValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
                List<WebElement> elements = getScrollItemList();
                int y1 = 0;
                int y2 = 0;

                for (String item : itemNames) {
                    while (true) {
                        if (traverseListContainsDynamicElementText(listValue, item) == true) {
                            flag = true;
                            break;
                        } else {
                            a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                            y1 = Integer.parseInt(commonUtil.getNUMfromString(a));
                            scrollDownUsingJS(driver, elements, 1);
                            waitForAngularLoad(driver);
                            sleepForSec(2000);
                            b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                            y2 = Integer.parseInt(commonUtil.getNUMfromString(b));

                            if (y1 == y2) {
                                if (traverseListContainsDynamicElementText(listValue, item) == true) {
                                    flag = true;
                                    break;
                                }
                                return flag;
                            }
                        }
                    }
                }
                break;

            case "Type":
                try {
                    for (String value : itemNames) {
                        if (traverseListContainsDynamicElementText(getAttributeList(arg[0]), value)) {
                            flag = true;
                        }
                    }
                } catch (org.openqa.selenium.NoSuchElementException e) {
                    e.printStackTrace();
                }
                break;

            case "metadata list not contains":
                for (String item : itemNames) {
                    try {
                        if (traverseListContainsElement(returnmetadataResults(), item) == true) {
                            flag = true;
                            break;
                        }
                    } catch (NoSuchElementException e) {
                        takeScreenShot(arg[0] + " is displayed in metadatalist", driver);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg[0] + " is displayed in UI");
                    }
                }
                break;
            case "item view section":
                for (String property : itemNames) {
                    try {
                        if (isElementPresent(getItemViewSections(property)) == true) {
                            flag = true;
                        }
                    } catch (org.openqa.selenium.NoSuchElementException e) {
                        flag = false;
                    }
                    if (flag == true) {
                        break;
                    }
                }
                break;
            case "Tag list not contains":
                flag = false;
                if (tagsShowAllFacetButton().isEmpty() == false) {
                    waitForAngularLoad(driver);
                    clickOn(tagsShowAllFacetButton().get(0));
                }
                for (String property : arg) {
                    try {
                        if (traverseListContainsElement(getSearchPagetagList(), property) == true) {
                            flag = false;
                            break;
                        } else {
                            throw new Exception();
                        }
                    } catch (Exception e) {
                        flag = false;
                    }
                }
                return flag;
            case "Absence of Tag":
                for (String property : itemNames) {
                    try {
                        if (traverseListContainsElement(getAssignedtag(arg[0]), property) == true) {
                            flag = false;
                            break;
                        } else {
                            throw new Exception();
                        }
                    } catch (Exception e) {
                        flag = true;
                    }
                }
                return flag;
        }
        return flag;
    }

    public void getAwsFileCount(String bucketName, String dirPath) {
        int s3Value = new S3Util(propLoader.prop.getProperty("s3AccessKey"), propLoader.prop.getProperty("s3SecretKey"), Regions.valueOf(propLoader.prop.getProperty("s3Region"))).initS3FoldertoScanFiles(bucketName, dirPath).getObjectItemCount();
        CommonUtil.storeText(String.valueOf(s3Value));
    }

    public void writeMetaDataValueToFile(Map<String, String> dataTable) {
        try {
            if (dataTable.containsKey("itemName")) {
                if (!dataTable.containsKey("widgetName")) {
                    if (getAttributeValue(getViewLinkForMetadataField(dataTable.get("itemName"), dataTable.get("attributeName")), "href").contains("javascript:void")) {
                        clickOn(driver, getViewLinkForMetadataField(dataTable.get("itemName"), dataTable.get("attributeName")));
                        FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + dataTable.get("actualFilePath"), getViewLinkdataForMetadataField(dataTable.get("itemName"), dataTable.get("attributeName")));
                        performESCbutton(driver);

                    } else
                        FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + dataTable.get("actualFilePath"), getdynamicPropertyInMetadata(dataTable.get("itemName"), dataTable.get("attributeName")).getText());
                } else {
                    if (getAttributeValue(getViewLinkForMetadataWidgetField(dataTable.get("itemName"), dataTable.get("widgetName"), dataTable.get("attributeName")), "href").contains("javascript:void")) {
                        clickOn(driver, getViewLinkForMetadataWidgetField(dataTable.get("itemName"), dataTable.get("widgetName"), dataTable.get("attributeName")));
                        FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + dataTable.get("actualFilePath"), getViewLinkdataForMetadataWidgetField(dataTable.get("itemName"), dataTable.get("widgetName"), dataTable.get("attributeName")));
                        performESCbutton(driver);

                    } else
                        FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + dataTable.get("actualFilePath"), getdynamicPropertyInMetadataWidget(dataTable.get("itemName"), dataTable.get("widgetName"), dataTable.get("attributeName")).getText());

                }


            } else {
                FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + dataTable.get("actualFilePath"), getPropertyMetadata(dataTable.get("attributeName")).getText());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public boolean isDataSetElementNotPresentInList(List<String> listValues, String... elementType) throws Exception {
        boolean flag = false;
        for (String property : listValues) {
            try {
                if (traverseListContainsElement(MetadataCaptions(), property) == true) {
                    flag = false;
                    break;
                } else {
                    throw new Exception();
                }
            } catch (Exception e) {
                flag = true;
            }
        }
        return flag;
    }

    public boolean isMetadataAttributeNotAvailable(String metaDataAttribute, String widgetName) throws Exception {
        boolean flag = false;
        try {
            if (traverseListContainsElement(getMetadataAttributesList(widgetName), metaDataAttribute) == false) {
                flag = false;
            } else {
                throw new Exception();
            }
        } catch (Exception e) {
            flag = true;
        }

        return flag;
    }

    public void isDataSetElementContainsInList(String propertyName, String... elementType) throws Exception {
       Assert.assertTrue(getdynamicPropertyInMetadataWidget(propertyName).getText().contains(elementType[0]));
    }


    public WebElement selectDefiniteFacetType(String facetSection, String attribute) {
        return driver.findElement(By.xpath("(//strong[contains(@class,'asg-facet-toggle-header')][contains(.,'"+facetSection+"')]//following::div[@class='asg-checkbox-small']//following::div[@title='"+attribute+"'])[1]"));
    }

    public WebElement getItemListName(String value) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'no-more-tables')]]//table/tbody/tr[" + value + "]/td[2]/a"));
    }

    public WebElement getTypeNameInItemView(String name){
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-caption-name-and-type')][contains(.,'"+name+"')]/span"));
    }

    public List<WebElement> getScrollItemList(String value) {
        return driver.findElements(By.xpath("//span[contains(text(),'"+value+"')]"));
    }

    public List<WebElement> getMetadataItemsSectionWise(String metadataSection) {
        return driver.findElements(By.xpath("//span[text()='"+metadataSection+"']/../../../div/div/ul/li"));
    }

    public WebElement itemResultsSort(){
        synchronizationVisibilityofElement(driver,sortItemResults);
        return sortItemResults;
    }

    public List<WebElement> getItemResultSortValues(){
        synchronizationVisibilityofElementsList(driver,itemResultSortValues);
        return itemResultSortValues;
    }

    public boolean sortItemsInResultPage(String value) throws Exception{
        boolean flag = false;
        clickOn(itemResultsSort());
        if(traverseListContainsElementText(getItemResultSortValues(),value)== true){
            traverseListContainsElementAndClick(driver,getItemResultSortValues(),value);
            waitForAngularLoad(driver);
            flag = true;
        }
        return flag;
    }

    public List<WebElement> tableRows(){
        return driver.findElements(By.xpath("//table//../../../tbody/tr"));
    }

    public WebElement getTableValue(String columnName, int rowNumber, int columnNumber) {
        WebElement ele = null;
        try {
            if (isElementPresent(driver.findElement(By.xpath("//table//th//span/span[contains(text(),'" + columnName.toLowerCase() + "')]/../../following::tbody//tr[" + rowNumber + "]//td[" + columnNumber + "]")))) {
                ele = driver.findElement(By.xpath("//table//th//span/span[contains(text(),'" + columnName.toLowerCase() + "')]/../../following::tbody//tr[" + rowNumber + "]//td[" + columnNumber + "]"));
            }
        } catch (Exception e) {
            try {
                ele = driver.findElement(By.xpath("//table//th//span/span[contains(text(),'" + columnName + "')]/../../following::tbody//tr[" + rowNumber + "]//td[" + columnNumber + "]"));
            } catch (Exception a) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
                Assert.fail(a.getMessage());
            }
        }
        return ele;
    }


    public void removeAttribute(String panelName, List<String> listValues) {
        for (String attributeName : listValues) {
            clickOn(removeAttributesFromThePanel(panelName, attributeName));
            if (returnAlertYesInList().size() > 0) {
                clickOn(returnAlertYes());
            }
            waitForAngularLoad(driver);
        }
    }


    public boolean verifyMapElementNotPresent(Map<String, String> mapValues, String... arg) throws Exception {
        boolean flag = true;
        switch (arg[0]) {
            case "Empty Values":
//                new DashBoardPage(driver).getGlobalSeacrhIcon().click();
                for (Map.Entry<String, String> data : mapValues.entrySet()) {
//                    new QuickStartActions(driver).returntopSearchBox().clear();
                new QuickStartActions(driver).enterTextToTopSearchBox(data.getKey());
                genericClick("globalSearchButton");
                waitForAngularLoad(driver);
                try {
                    if (getNoDataFound().getText().equals(data.getValue())) {
                        flag = false;
                    }
                } catch (Exception e) {
                    throw new Exception("Values displayed in UI");

                    }
                }
                break;
        }
        return flag;
    }

    public boolean verifyMapElementNotPresent(List<Map<String, String>> mapValues, String... arg) throws Exception {
        boolean flag = true;
        String pluginPasswordName = null;
        String filePath = null;
        String jsonKey = null;
        switch (arg[0]) {
            case "password encrypted":
                for (Map<String, String> dataTable : mapValues) {
                    pluginPasswordName = dataTable.get("pluginConfigPassword");
                    filePath = Constant.REST_PAYLOAD + dataTable.get("passwordFilePath");
                    jsonKey = dataTable.get("jsonpath");
                }
                switch (pluginPasswordName) {
                    case "BITBUCKET_PASSWORD":
                        try {
                            if (!JsonRead.getJsonValue(filePath, jsonKey).equals(propLoader.prop.getProperty("BITBUCKET_PASSWORD"))) {
                                flag = false;
                            }
                        } catch (Exception e) {
                            throw new Exception("Password not encrypted");
                        }
                        break;
                    case "ambariPassword":
                        try {
                            if (!JsonRead.getJsonValue(filePath, jsonKey).equals(propLoader.prop.getProperty("ambariPassword"))) {
                                flag = false;
                            }
                        } catch (Exception e) {
                            throw new Exception("Password not encrypted");
                        }
                        break;
                    case "oraclepassword":
                        try {
                            if (!JsonRead.getJsonValue(filePath, jsonKey).equals(propLoader.prop.getProperty("oraclepassword"))) {
                                flag = false;
                            }
                        } catch (Exception e) {
                            throw new Exception("Password not encrypted");
                        }
                        break;
                }
        }
        return flag;
    }

    //10.3  New UI Implementations:

    public boolean assertDBValuesAndUIValues(String actionType, String itemName, String dbValues, List<String> listValues) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionType) {
            case "metadata property values":
                switch (dbValues) {
                    case "hashMap":
                        if (itemName.equals("Host")) {
                            for (String property : listValues) {
                                expected.add(getdynamicPropertyHostMetadata(itemName, property).getText());
                            }
                        } else {
                            for (String property : listValues) {
                                expected.add(getdynamicPropertyInMetadata(itemName, property).getText());
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(),""+expected.toString());
                            }
                        }

                        for (Map.Entry<String, List<String>> hm : CommonUtil.gettempSingleKeyMultipleValueList().entrySet()) {
                            for (String values : hm.getValue()) {
                                actual.add(values);
                            }
                        }
                        Collections.sort(expected);
                        Collections.sort(actual);
                        try {
                            if (expected.equals(actual) == true) {
                                flag = true;
                            }
                        } catch (Exception e) {
                            throw new Exception();
                        }
                        break;

                    case "jsonHashMap":
                        waitForAngularLoad(driver);
                        for (String property : listValues) {
                            if (getdynamicPropertyInMetadata(itemName, property).getText().contains("Bytes")) {
                                expected.add(getdynamicPropertyInMetadata(itemName, property).getText().toString().substring(0, getdynamicPropertyInMetadata(itemName, property).getText().indexOf('.')));
                            } else if (getdynamicPropertyInMetadata(itemName, property).getText().contains("KB")) {
                                expected.add(CommonUtil.fileSizeConversion(getdynamicPropertyInMetadata(itemName, property).getText(), "MB"));
                            } else {
                                expected.add(getdynamicPropertyInMetadata(itemName, property).getText().toString().replaceAll("\\s", ""));
                            }
                        }

                        for (Map.Entry<String, List<String>> hm : CommonUtil.gettempSingleKeyMultipleValueList().entrySet()) {
                            for (String values : hm.getValue()) {
                                actual.add(values.toString().replaceAll("\\s", ""));
                            }
                        }
                        Collections.sort(expected);
                        Collections.sort(actual);
                        if (CommonUtil.compareLists(expected, actual) == true) {
                            flag = true;
                        } else {
                            throw new Exception();
                        }
                        break;

                    case "hashMapWithBigDecimals":
                        for (String property : listValues) {
                            expected.add(getdynamicPropertyInMetadata(itemName, property).getText().toString().replaceAll("\\s", ""));
                        }

                        Map<String, List<String>> treeMap = CommonUtil.gettempSingleKeyMultipleValueList().entrySet().stream().collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (oldValue, newValue) -> newValue, TreeMap::new));
                        for (int i = 0; i < expected.size(); i++) {
                            String expectedValue = expected.get(i);
                            String[] ExpectedarrayValue = expectedValue.split("\\.");
                            int afterDecimalExpCount = ExpectedarrayValue[1].length();
                            for (Map.Entry<String, List<String>> hm : treeMap.entrySet()) {
                                for (String values : hm.getValue()) {
                                    String[] Values = values.split("\\.");
                                    int afterDecimalActualCount = Values[1].length();
                                    if (afterDecimalActualCount > afterDecimalExpCount) {
                                        String actualValue = CommonUtil.roundOffDecimalValueUsingHalfUP(values, afterDecimalExpCount);
                                        actual.add(actualValue);
                                    } else {
                                        actual.add(values);
                                    }
                                }
                                treeMap.remove(hm.getKey(), hm.getValue());
                                break;
                            }
                        }
                        if (CommonUtil.compareLists(expected, actual) == true) {

                            flag = true;
                        } else {
                            throw new Exception();
                        }
                        break;

                    case "map":
                        for (String property : listValues) {
                            expected.add(getdynamicPropertyInMetadata(itemName, property).getText().toString().replaceAll("\\s", "").replaceAll("\\n", ""));
                        }
                        for (Map.Entry<String, List<String>> hm : CommonUtil.gettempSingleKeyMultipleValueList().entrySet()) {
                            for (String values : hm.getValue()) {
                                actual.add(values.replaceAll("\\s", "").replaceAll("\\n", ""));
                            }
                        }
                        Collections.sort(expected);
                        Collections.sort(actual);
                        try {
                            if (expected.equals(actual) == true) {
                                flag = true;
                            }
                        } catch (Exception e) {
                            throw new Exception();
                        }
                        break;

                }
                CommonUtil.gettempSingleKeyMultipleValueList().entrySet().clear();
                break;
        }
        return flag;
    }

    public boolean isDataSetElementPresentInList(List<String> listValues, String... elementType) throws Exception {
        boolean flag = false;
        switch (elementType[0]) {
            case "verify metadata properties":
                for (String property : listValues) {
                    if (traverseListContainsElement(MetadataCaptions(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;

            case "Tag List":
                for (String property : listValues) {
                    if (traverseListContainsElementText(getlistOfTagNames(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;

            case "Items List":
                try {
                    List<String> datatable = new ArrayList<>();
                    if (listValues.contains("tempStoredValue")) {
                        datatable.addAll(CommonUtil.getTemporaryList());
                    } else {
                        datatable.addAll(listValues);
                    }
                    LinkedList<String> searchList = new LinkedList<>();
                    List<WebElement> currentList = driver.findElements(By.xpath("//div[@class[contains(.,'scrollable-content')]]//div/a"));
                    WebElement scrollBar = driver.findElement(By.xpath("//div[@class[contains(.,'scrollable-content')]]//div/a"));
                    int itemCount = Integer.parseInt(commonUtil.getNUMfromString(gettotalitemCount().getText()));
                    while (true) {
                        sleepForSec(1500);
                        currentList = driver.findElements(By.xpath("//a[@class[contains(.,'asg-search-list-item-name text-truncate')]]"));
                        List<String> previousList = new ArrayList<>();
                        previousList = convertWebElementListIntoStringList(currentList);
                        List<WebElement> finalList = null;
                        for (WebElement element1 : currentList) {
                            for (String pageValue : datatable) {
                                if (element1.getText().equals(pageValue)) {
                                    datatable.remove(pageValue);
                                    break;
                                }
                            }
                            if (datatable.size() == 0) {
                                return true;
                            }
                        }
                        scrollUsingKeys(scrollBar, "PAGE_DOWN", 1);
                        waitForAngularLoad(driver);
                        sleepForSec(1500);
                        finalList = driver.findElements(By.xpath("//a[@class[contains(.,'asg-search-list-item-name text-truncate')]]"));
                        if (previousList.equals(convertWebElementListIntoStringList(finalList)) && datatable.size() != 0) {
                            LoggerUtil.logInfo("Element not present");
                            return false;
                        }
                        if (convertWebElementListIntoStringList(currentList).equals(convertWebElementListIntoStringList(finalList)) && datatable.size() == 0) {
                            return true;
                        }
                    }
                } catch (Exception e) {
                    e.getMessage();
                    Assert.fail("Exception: " + e.getMessage());
                }
                break;

            case "Item Value":
                String a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                String b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                List<String> currentPage = new ArrayList<>();
                List<WebElement> listValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
                List<WebElement> elements = getScrollItemList();
                int y1 = 0;
                int y2 = 0;

                for (String item : listValues) {
                    while (true) {
                        if (traverseListContainsDynamicElementText(listValue, item) == true) {
                            flag = true;
                            break;
                        } else {
                            a = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                            y1 = Integer.parseInt(commonUtil.getNUMfromString(a));
                            scrollDownUsingJS(driver, elements, 1);
                            waitForAngularLoad(driver);
                            sleepForSec(3000);
                            b = driver.findElement(By.xpath("//div[@class='scrollable-content']")).getAttribute("style");
                            y2 = Integer.parseInt(commonUtil.getNUMfromString(b));

                            if (y1 == y2) {
                                if (traverseListContainsDynamicElementText(listValue, item) == true) {
                                    flag = true;
                                    break;
                                }
                                return flag;
                            }
                        }
                    }
                }
                break;

            case "presence of facets":
                List<String> attributeValues = new ArrayList<>();
                List<String> expectedValues = new ArrayList<>();
                try {
                    if (showMoreFacetButton(elementType[1]).isDisplayed()) {
                        clickOn(showMoreFacetButton(elementType[1]));
                    }
                }catch(Exception e){
                    e.getMessage();
                }
                for (WebElement values : getAttributesListFromFacet(elementType[1])) {
                    attributeValues.add(values.getText());
                }
                for (String type : listValues) {
                    expectedValues.add(type);
                }
                if (CommonUtil.compareLists(attributeValues,expectedValues) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Presence of Search Tag":
                List<String> Actual = new ArrayList<>();
                List<String> Expected = new ArrayList<>();
                for (WebElement values : getTaglistfromsearch(elementType[1])) {
                    Actual.add(values.getText());
                }
                for (String type : listValues) {
                    Expected.add(type);
                }
                if (CommonUtil.compareLists(Actual, Expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Presence of Search Configuration":
                List<String> Act = new ArrayList<>();
                List<String> Exp = new ArrayList<>();
                for (WebElement values : getConfigListFromSearch(elementType[1])) {
                    Act.add(values.getText());
                }
                for (String type : listValues) {
                    Exp.add(type);
                }
                if (CommonUtil.compareLists(Act, Exp) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Presence of Assigned Tag":
                List<String> Actual_tag = new ArrayList<>();
                List<String> Expected_tag = new ArrayList<>();
                waitForAngularLoad(driver);
                for (WebElement values : getAssignedtag(elementType[1])) {
                    Actual_tag.add(values.getText());
                }
                for (String type : listValues) {
                    Expected_tag.add(type);
                }
                for (int i = 0; i < Expected_tag.size(); i++) {
                    String tag = Expected_tag.get(i);
                    if (Actual_tag.contains(tag)) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Presence of Sorted Tag":
                List<String> Actual_Sorted_tag = new ArrayList<>();
                List<String> Expected_Sorted_tag = new ArrayList<>();
                waitForAngularLoad(driver);
                for (WebElement values : getAssignedtag(elementType[1])) {
                    Actual_Sorted_tag.add(values.getText());
                }
                for (String type : listValues) {
                    Expected_Sorted_tag.add(type);
                }
                if (Actual_Sorted_tag.equals(Expected_Sorted_tag)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Presence of Sorted list":
                List<String> Actual_Sorted_list = new ArrayList<>();
                List<String> Expected_Sorted_list = new ArrayList<>();
                for (WebElement values : getAssignedlist()) {
                    Actual_Sorted_list.add(values.getText());
                }
                for (String type : listValues) {
                    Expected_Sorted_list.add(type);
                }
                if (Actual_Sorted_list.equals(Expected_Sorted_list)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "presence of Tag facets":
                List<String> attributeValues1 = new ArrayList<>();
                List<String> expectedValues1= new ArrayList<>();
                for (WebElement values : getAttributeList(elementType[1])) {
                    attributeValues1.add(values.getText());
                }
                for (String type : listValues) {
                    expectedValues1.add(type);
                }
                Collections.sort(expectedValues1);
                Collections.sort(attributeValues1);
                if (expectedValues1.equals(attributeValues1)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;

            case "breadcrumb":
                TreeMap<String, String> expected = new TreeMap<>();
                TreeMap<String, String> actual = new TreeMap<>();
                for (int i = 0; i < listValues.size(); i++) {
                    expected.put(String.valueOf(i+1), listValues.get(i));
                }
                for (int i = 0; i < breadCrumbList.size(); i++) {
                    actual.put(String.valueOf(i), breadCrumbList.get(i).getText());
                }
                CommonUtil.removeValuefromMap(actual,"Search");
                if (expected.equals(actual)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;

            case "item view section":
                for (String property : listValues) {
                    if (isElementPresent(getItemViewTableSections(property)) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;

            case "Most frequent values":
                List<String> mostFrequentValues = new ArrayList<>();
                for (WebElement values : getMostFrequentValues()) {
                    mostFrequentValues.add(values.getText().trim());
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "" + mostFrequentValues.toString());
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "" + listValues.toString());
                }
                if (listValues.equals(mostFrequentValues)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "hierarchy":
                TreeMap<String, String> expectedHierarchy  = new TreeMap<>();
                TreeMap<String, String> actualHierarchy = new TreeMap<>();
                for (int i = 0; i < listValues.size(); i++) {
                    expectedHierarchy.put(String.valueOf(i+1), listValues.get(i));
                }
                for (int i = 0; i < hierarchyList.size(); i++) {
                    actualHierarchy.put(String.valueOf(i), hierarchyList.get(i).getAttribute("innerHTML"));
                }
                CommonUtil.removeValuefromMap(actualHierarchy,"Search");
                if (expectedHierarchy.equals(actualHierarchy)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "verify Item View page attributes":
                for (String property : listValues) {
                    if (traverseListContainsElement(DetailsAttributes(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "verify multiAttribute widgets for BA":
                for (String property : listValues) {
                    if (traverseListContainsElement(getBAMultiAttributeWidgets(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "verify Item View page Info labels":
                for (String property : listValues) {
                    if (traverseListContainsElement(getItemViewPageInfoLabels(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "verify Column widget headers":
                for (String property : listValues) {
                    if (traverseListContainsElement(getTableHeaders(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Tag List in facet":
                for (String property : listValues) {
                    if (traverseListContainsElementText(getAttributeList(elementType[1]), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Plugin accordion labels under Data Tab":
                for (String property : listValues) {
                    if (traverseListContainsText(getItemViewPageInfoLabels(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Plugin accordion labels under DataAsset Tab":
                for (String property : listValues) {
                    if (traverseListContainsText(getItemViewPageDataAssetLabels(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "BA Item view frozen tabs List":
                for (String tabs : listValues) {
                    Assert.assertTrue(getBAItemViewTabs(tabs).getAttribute("class").contains("disabled"));
                }
                flag = true;
                break;
            case "non presence of facets":
                List<String> attributeValue = new ArrayList<>();
                List<String> expectedValue = new ArrayList<>();
                try {
                    if (showMoreFacetButton(elementType[1]).isDisplayed()) {
                        clickOn(showMoreFacetButton(elementType[1]));
                    }
                } catch (Exception e) {
                    e.getMessage();
                }
                for (WebElement values : getAttributesListFromFacet(elementType[1])) {
                    attributeValue.add(values.getText());
                }
                for (String type : listValues) {
                    expectedValue.add(type);
                    if (traverseListContainsString(attributeValue, type))
                        flag = true;
                }
                break;
            case "presence of accordion in manage config":
                List<String> Actual_Manage_congiflist = new ArrayList<>();
                List<String> Expected_Manage_congiflist = new ArrayList<>();
                waitForAngularLoad(driver);
                for (WebElement values : getAssignedtag(elementType[1])) {
                    Actual_Manage_congiflist.add(values.getText());
                }
                for (String type : listValues) {
                    Expected_Manage_congiflist.add(type);
                }
                if (Actual_Manage_congiflist.equals(Expected_Manage_congiflist)) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;

            case "BA List in Top Section bar":
                for (String businessApplication : listValues) {
                    if (traverseListContainsElementText(getBAListInItemViewTopSection(), businessApplication) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
        }
        return flag;
    }

    public boolean verifyTagPresence(String... arg) {
        //arg[0] = catalog Name; arg[1]=name; arg[2]=Tags; args[3]=facettype
        boolean flag = false;
        try {
            //select the Catalog, type and Value form Item results
            clickonWebElementwithJavaScript(driver, catalogDropDown);
            clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(catalogList, arg[0]));
            sleepForSec(2000);
            enterText(getTopItemSearchField(), arg[0]);
            sleepForSec(2000);
            clickOn(driver, getTopSearchIcon());
            waitForAngularLoad(driver);
            genericClick("facet selection", arg[1], arg[3]);
            waitForAngularLoad(driver);
            clickOn(returnfirstItemListName());
            waitForAngularLoad(driver);
            sleepForSec(1000);
            String formatedTypeName = getTypeNameInItemView(arg[1]).getText().replaceAll("[\\[|\\]]", "");

            //Verifying the Tag
            if(formatedTypeName.equalsIgnoreCase(arg[1])) {
                //get the Expected Value
                List<String> expected = new ArrayList<>();
                String[] exp = arg[2].split(",");
                for (String value : exp) {
                    expected.add(value);
                }

                //get the actual value
                List<String> actual = new ArrayList<>();
                actual.addAll(getStringListFromElementsList(new AnalysisPage(driver).getListOFTags()));
                Collections.sort(actual);
                Collections.sort(expected);
                //Check if the expected list is present in actual list
                int acutalSize = actual.size();
                int expectedSize = expected.size();
                if (expectedSize < acutalSize) {
                    for (int i = 0; i <= expectedSize; i++) {
                        Iterator<String> e = expected.iterator();
                        if (traverseListContainsString(actual, expected.get(i)) == false) {
                            flag = false;
                            break;
                        }
                        flag = true;
                        e.next();
                    }
                } else if (expected.equals(actual)) {
                    flag = true;
                }
            }
        } catch (Exception e) {
            e.getMessage();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Exception captured for "+ arg[1] + ":" +e.getMessage());
        }
        return flag;
    }

    public boolean compareValuesfromDBandUI(String elementName, String tabName) {
        boolean flag = false;
        try {
            switch (elementName) {
                case "list":
                    List<String> itemResult = new ArrayList<>();
                    itemResult.addAll(getStringListFromElementsList(listOfItemsInTab(tabName)));
                    if (CommonUtil.compareLists(itemResult, CommonUtil.getTemporaryList()) == true && itemResult.size()!=0 && CommonUtil.getTemporaryList().size()!=0) {
                        flag = true;
                        CommonUtil.getTemporaryList().clear();
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "List compare between UI and DB matches");
                    }
                    break;

                case "retainslist":
                    List<String> retainItemResult = new ArrayList<>();
                    try {
                        if (isElementPresent(tabPaginationNextButton(tabName))) {
                            try {
                                while (isElementPresent(tabPaginationNextButton(tabName))) {
                                    retainItemResult.addAll(retainItemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                                    clickOn(tabPaginationNextButton(tabName));
                                    waitForAngularLoad(driver);
                                }
                            } catch (Exception e) {
                                retainItemResult.addAll(retainItemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                            }
                        }
                    } catch (Exception e) {
                        retainItemResult.addAll(retainItemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                    }


                    if (CommonUtil.getTemporaryList().size() != 0 && retainItemResult.size() != 0) {
                        retainItemResult.retainAll(CommonUtil.getTemporaryList());
                    }

                    if (CommonUtil.compareLists(retainItemResult, CommonUtil.getTemporaryList()) == true) {
                        flag = true;
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "List compare between UI and DB matches");
                    }
                    break;

                case "returnListText":
                    List<String> itemResults = new ArrayList<>();
                    try {
                        if (tabPaginationNextButton(tabName).isDisplayed()) {
                            try {
                                while (tabPaginationNextButton(tabName).isDisplayed()) {
                                    itemResults.addAll(itemResults.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                                    clickOn(tabPaginationNextButton(tabName));
                                    waitForAngularLoad(driver);
                                }
                            } catch (Exception e) {
                                itemResults.addAll(itemResults.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                            }
                        }
                    } catch (Exception e) {
                        itemResults.addAll(itemResults.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                    }
                    break;
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        }
        return flag;
    }

    public boolean facetListVerification(String elementName, List<String> list) throws Exception{
        boolean flag = false;
        if (new SubjectArea(driver).showMoreFacetButtonList(elementName).size()>0) {
            clickOn(driver, new SubjectArea(driver).showMoreFacetButton(elementName));
            waitForAngularLoad(driver);
        }
        for (String facetValue: list) {
            Assert.assertTrue(isElementPresent(getItemTypes(elementName, facetValue)));
            flag = true;
        }
        return flag;
    }


    public WebElement getFacetTypeCount(String facetType, String sectionName) {
        return driver.findElement(By.xpath("//strong[contains(text(),'" + sectionName + "')]/following::div[@title='" + facetType + "']/following::div[1]"));
    }

    public String getItemCountInSearchResultsPage(){
        String count ="";
        try{
            count = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
        }catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        }
        return count;
    }


    public boolean verifyRelationship(String elementType, String elementName, List<Map<String, String>> mapValues) throws Exception {
        boolean flag = false;
        try {
            RestAPIWrapper restExecution = new RestAPIWrapper();
            String url = null;
            String apiSourceValue = null, apiSourceID = null;
            List<String> apiTargetValues = null;
            String uiSourceValue = null;
            String uiTargetValue = null;
            String typeValue = null;
            TreeMap<String, String> uiMap = new TreeMap<>();
            TreeMap<String, String> apiMap = new TreeMap<>();

            LinkedList<String> header = new LinkedList<>();
            for (Map<String, String> getHeader : mapValues) {
                if (header.size() == getHeader.size()) {
                    break;
                }
                for (Map.Entry<String, String> entry : getHeader.entrySet()) {
                    header.add(entry.getKey());
                    if (entry.getKey().equalsIgnoreCase(elementType)) {
                        typeValue = entry.getValue();
                    }
                }
            }

            switch (elementType.toLowerCase()) {
                case "constraint":
                    //Get the Value from API
                    try {
                        for (String value : header) {
                            if (value.equalsIgnoreCase("constraint")) {
                                uiSourceValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(typeValue, "ID"));
                                String[] splitValue = uiSourceValue.split(":::");
                                apiSourceID = new CommonUtil().getNUMfromString(splitValue[1]);
                                String formatedCatalogName = elementName.replaceAll(" ", "%20");
                                url = propLoader.prop.getProperty("qaURL") + "services/searches/" + formatedCatalogName + "/query/queryDiagramOut/" + formatedCatalogName + ".Constraint%3A%3A%3A" + apiSourceID + "?what=id,type,name,catalog";
                                String credentials = propLoader.prop.getProperty("TestSystemUser");
                                restExecution.initializeRestAPI("IDC");
                                restExecution.multiHeader(credentials, "application/json", "application/json");
                                restExecution.resetRestAPI();
                                restExecution.invokeGetRequest(url);
                                apiSourceValue = uiSourceValue;
                            } else {
                                String apiFormatType = value.substring(0, 1).toLowerCase() + value.substring(1, value.length());
                                apiTargetValues = restExecution.getJsonResponseValuesInList("$..edges.[?(@.type=='" + apiFormatType + "')].target");
                                for (String apiValue : apiTargetValues) {
                                    apiMap.put(apiValue, apiSourceValue);
                                }
                            }
                        }
                    } catch (Exception e) {
                        takeScreenShot(this.getClass().getName(), driver);
                        e.printStackTrace();
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through API " + e.getMessage());
                        e.printStackTrace();
                    }

                    //Get the value from UI and store it to a Map
                    try {
                        for (Map<String, String> mapUI : mapValues) {
                            for (Map.Entry<String, String> entry : mapUI.entrySet()) {
                                if (entry.getKey().equalsIgnoreCase("constraint")) {
                                    uiSourceValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                } else if (entry.getKey().equalsIgnoreCase("linkcolumn") || entry.getKey().equalsIgnoreCase("columns")) {
                                    try {
                                        clickAndSwitchTab(driver, new AnalysisPage(driver).getdynamicItemFromDynamicHasTable(entry.getKey().toLowerCase(), entry.getValue()), Duration.ofSeconds(2000), "");
//                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
//                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    switchToWindowIndex(driver, 0);
//                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                } else if (entry.getKey().equalsIgnoreCase("index")) {
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), entry.getKey(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                } else if (entry.getKey().equalsIgnoreCase("parent")) {
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                }
                            }
                        }
                        break;
                    } catch (Exception e) {
                        takeScreenShot(this.getClass().getName(), driver);
                        e.printStackTrace();
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through UI " + e.getMessage());
                        e.printStackTrace();
                    }

                case "index":
                    //Get the Value from API
                    try {
                        for (String value : header) {
                            if (value.equalsIgnoreCase("index")) {
                                uiSourceValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(typeValue, "ID"));
                                String[] splitValue = uiSourceValue.split(":::");
                                apiSourceID = new CommonUtil().getNUMfromString(splitValue[1]);
                                String formatedCatalogName = elementName.replaceAll(" ", "%20");
                                url = propLoader.prop.getProperty("qaURL") + "services/searches/" + formatedCatalogName + "/query/queryDiagramOut/" + formatedCatalogName + ".Index%3A%3A%3A" + apiSourceID + "?what=id,type,name,catalog";
                                String credentials = propLoader.prop.getProperty("TestSystemUser");
                                restExecution.initializeRestAPI("IDC");
                                restExecution.multiHeader(credentials, "application/json", "application/json");
                                restExecution.resetRestAPI();
                                restExecution.invokeGetRequest(url);
                                apiSourceValue = uiSourceValue;
                            } else {
                                String apiFormatType = value.substring(0, 1).toLowerCase() + value.substring(1, value.length());
                                apiTargetValues = restExecution.getJsonResponseValuesInList("$..edges.[?(@.type=='" + apiFormatType + "')].target");
                                for (String apiValue : apiTargetValues) {
                                    apiMap.put(apiValue, apiSourceValue);
                                }
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        takeScreenShot(this.getClass().getName(), driver);
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through API " + e.getMessage());
                    }

                    //Get the value from UI and store it to a Map
                    try {
                        for (Map<String, String> mapUI : mapValues) {
                            for (Map.Entry<String, String> entry : mapUI.entrySet()) {
                                if (entry.getKey().equalsIgnoreCase("index")) {
                                    uiSourceValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                } else if (entry.getKey().equalsIgnoreCase("linkcolumn")) {
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                } else if (entry.getKey().equalsIgnoreCase("referencedtable")) {
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                }
                            }
                        }
                        break;
                    } catch (Exception e) {
                        e.printStackTrace();
                        takeScreenShot(this.getClass().getName(), driver);
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through UI " + e.getMessage());
                    }

                case "function":
                    //Get the Value from API
                    try {
                        for (String value : header) {
                            if (value.equalsIgnoreCase("function")) {
                                uiSourceValue = getItemIDfromURL(driver);
                                apiSourceID = new CommonUtil().getNUMfromString(uiSourceValue).replace(".", "");
                                String formatedCatalogName = elementName.replaceAll(" ", "%20");
                                url = propLoader.prop.getProperty("qaURL") + "services/searches/" + formatedCatalogName + "/query/queryDiagramOut/" + formatedCatalogName + ".Function%3A%3A%3A" + apiSourceID + "?what=id,type,name,catalog";
                                String credentials = propLoader.prop.getProperty("TestSystemUser");
                                restExecution.initializeRestAPI("IDC");
                                restExecution.multiHeader(credentials, "application/json", "application/json");
                                restExecution.resetRestAPI();
                                restExecution.invokeGetRequest(url);
                                apiSourceValue = uiSourceValue;
                            } else {
                                String apiFormatType = value.substring(0, 1).toLowerCase() + value.substring(1, value.length());
                                apiTargetValues = restExecution.getJsonResponseValuesInList("$..edges.[?(@.type=='" + apiFormatType + "')].target");
                                for (String apiValue : apiTargetValues) {
                                    apiMap.put(apiValue, apiSourceValue);
                                }
                            }
                        }
                    } catch (Exception e) {
                        takeScreenShot(this.getClass().getName(), driver);
                        e.printStackTrace();
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through UI " + e.getMessage());
                    }

                    //Get the value from UI and store it to a Map
                    try {
                        for (Map<String, String> mapUI : mapValues) {
                            for (Map.Entry<String, String> entry : mapUI.entrySet()) {
                                if (entry.getKey().equalsIgnoreCase("function")) {
                                    uiSourceValue = getItemIDfromURL(driver);
                                } else if (entry.getKey().equalsIgnoreCase("uses")) {
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick_SwitchTab(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getItemIDfromURL(driver);
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    waitForAngularLoad(driver);
                                }
                            }
                        }
                        break;
                    } catch (Exception e) {
                        takeScreenShot(this.getClass().getName(), driver);
                        e.printStackTrace();
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through UI " + e.getMessage());
                    }

                case "relationship":
                    //Get the Value from API
                    try {
                        for (String value : header) {
                            if (value.equalsIgnoreCase("relationship")) {
                                uiSourceValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(typeValue, "ID"));
                                String[] splitValue = uiSourceValue.split(":::");
                                apiSourceID = new CommonUtil().getNUMfromString(splitValue[1]);
                                String formatedCatalogName = elementName.replaceAll(" ", "%20");
                                url = propLoader.prop.getProperty("qaURL") + "services/searches/" + formatedCatalogName + "/query/queryDiagramOut/" + formatedCatalogName + ".Relationship%3A%3A%3A" + apiSourceID + "?what=id,type,name,catalog";
                                String credentials = propLoader.prop.getProperty("TestSystemUser");
                                restExecution.initializeRestAPI("IDC");
                                restExecution.multiHeader(credentials, "application/json", "application/json");
                                restExecution.resetRestAPI();
                                restExecution.invokeGetRequest(url);
                                apiSourceValue = uiSourceValue;
                            } else {
                                String apiFormatType = value.substring(0, 1).toLowerCase() + value.substring(1, value.length());
                                apiTargetValues = restExecution.getJsonResponseValuesInList("$..edges.[?(@.type=='" + apiFormatType + "')].target");
                                for (String apiValue : apiTargetValues) {
                                    apiMap.put(apiValue, apiSourceValue);
                                }
                            }
                        }
                    } catch (Exception e) {
                        takeScreenShot(this.getClass().getName(), driver);
                        e.printStackTrace();
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through UI " + e.getMessage());
                    }

                    //Get the value from UI and store it to a Map
                    try {
                        for (Map<String, String> mapUI : mapValues) {
                            for (Map.Entry<String, String> entry : mapUI.entrySet()) {
                                if (entry.getKey().equalsIgnoreCase("relationship")) {
                                    uiSourceValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                } else if (entry.getKey().equalsIgnoreCase("From") || entry.getKey().equalsIgnoreCase("To")) {
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(entry.getKey().toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                } else if (entry.getKey().equalsIgnoreCase("has_Field")) {
                                    String tabName = "Fields";
                                    try {
                                        trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).listOfItemsInTab(tabName.toUpperCase()), entry.getValue(), new SubjectArea(driver).tabPaginationNextButton(entry.getKey().toUpperCase()));
                                    } catch (Exception e) {
                                        traverseListContainsElementAndClick(driver, new SubjectArea(driver).listOfItemsInTab(tabName.toUpperCase()), entry.getValue());
                                    }
                                    waitForAngularLoad(driver);
                                    uiTargetValue = getElementText(new SubjectArea(driver).getdynamicPropertyInMetadata(entry.getValue(), "ID"));
                                    uiMap.put(uiTargetValue, uiSourceValue);
                                    new SubjectArea(driver).click_itemFullViewPageCloseButton();
                                    waitForAngularLoad(driver);
                                }
                            }
                        }
                        break;
                    } catch (Exception e) {
                        e.printStackTrace();
                        takeScreenShot(this.getClass().getName(), driver);
                        Assert.fail("No Relationship is found for " + elementType + " while traversing through UI " + e.getMessage());
                    }


            }

            if (apiMap.entrySet().containsAll(uiMap.entrySet()) && uiMap.size() != 0 && apiMap.size() != 0) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Relationship validation failed for " + elementType + e.getMessage());
        }

        return flag;
    }
    public void Itemviewpagevalidations(String actionType, String actionItem,String ItemName,String Section) throws Exception {
        try{
        switch (actionType)
        {
            case "Verifies Section Displayed":
                Assert.assertEquals(getElementText(new AnalysisPage(driver).getWidgetcontainername(actionItem)),actionItem);
                break;
            case "Select Dropdown":
                selectDetailsDropdown(actionItem,ItemName);
                break;
            case "Verify Widget Presence":
                Assert.assertTrue(getElementText(new AnalysisPage(driver).getWidgetname(actionItem)).contains(actionItem));
                break;
            case "Verify Tab Presence":
                Assert.assertEquals(getElementText(new AnalysisPage(driver).getTabsName(actionItem)), actionItem);
                break;
            case "Verifies Item Presence":
                if (actionItem.equalsIgnoreCase("Description")) {
                    String text = getElementText(new AnalysisPage(driver).adddescriptionvalue(actionItem));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is displayed under the Description Widget");
                    Assert.assertEquals(ItemName, text.trim());
                } else {
                    String text = getElementText(new AnalysisPage(driver).getWidgetValues());
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is displayed under the Description Widget");
                    Assert.assertEquals(ItemName, text.trim());
                }
                break;
            case "Verifies Information Message":
                if (Section.equalsIgnoreCase("Tags")) {
                    Assert.assertEquals(actionItem, getElementText(getInformationMessage(actionItem)));
                } else if (Section.equalsIgnoreCase("Trust Score")) {
                    Assert.assertEquals(actionItem, getElementText(getTrustScoreWidget(actionItem)));
                } else if (Section.equalsIgnoreCase("Rating")) {
                    Assert.assertEquals(actionItem, getElementText(getRatingWidget(actionItem)));
                }
                break;
            case "Icon not Present":
                if (actionItem.equalsIgnoreCase("Expand Icon")) {
                    Assert.assertFalse(getWidgetExpand(Section));
                } else if (actionItem.equalsIgnoreCase("Collapse Icon")) {
                    Assert.assertFalse(getWidgetCollapse(Section));
                }
                break;
            case "Verify Scroll Bar":
                moveToElement(driver,new AnalysisPage(driver).getTagstoAssign(Section,actionItem));
                clickOn(new AnalysisPage(driver).getTagstoAssign(Section,actionItem));
                break;
            case "Verify Frame Presence":
                if (actionItem.equalsIgnoreCase("Available")) {
                    Assert.assertTrue(verifyTagFrameRightPresence(actionItem));
                } else if (actionItem.equalsIgnoreCase("Assigned")) {
                    Assert.assertTrue(verifyTagFrameLeftPresence(actionItem));
                } else {
                    throw new Exception();
                }
                break;
            case "Verify Label Presence":
                Assert.assertEquals(ItemName, getElementText(getSuccessLabelInfo(Section,actionItem)));
                break;
            case "Verify Tag Presence":
                Assert.assertEquals(actionItem, getElementText(getAssignedtags(actionItem)));
                break;
            case "Verify Config Presence":
                Assert.assertEquals(actionItem, getElementText(getConfigDetails(actionItem)));
                break;
            case "Verify Item Full View":
                Assert.assertTrue(getBAItemFullViewPage());
                break;
            case"Collapse":
                clickOn(new AnalysisPage(driver).getArrowDownIcon(actionItem));
                break;
            case"Expand":
                clickOn(new AnalysisPage(driver).getArrowRightIcon(actionItem));
                break;
            case "Verify Edit Icon":
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getEditIcon(actionItem)));
                break;
            case "Click Edit Icon":
                waitForAngularLoad(driver);
                clickOn(new AnalysisPage(driver).getEditIcon(actionItem));
                break;
            case "Enter Description":
                enterText(new AnalysisPage(driver).adddescriptionvalue(actionItem),ItemName);
                break;
            case "Enter Tag Name":
                enterText(new AnalysisPage(driver).adddescriptionvalue(actionItem),ItemName);
                break;
            case "Enter Business Owner":
                waitForAngularLoad(driver);
                enterText(new AnalysisPage(driver).addBusinessvalue(actionItem), ItemName);
                waitForAngularLoad(driver);
                clickOn(getBusinessOwnerSuggestion(ItemName));
                waitForAngularLoad(driver);
                break;
            case "Verify Hint Message":
                waitForAngularLoad(driver);
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getHintMessage(actionItem)));
                break;
            case "Enter Text":
                if(actionItem.equalsIgnoreCase("BA Attribute textbox")){
                enterText(getFieldTextBox(ItemName), Section);
                } else if (actionItem.equalsIgnoreCase("Tag Text box")) {
                    enterText(getTagTextbox(),Section);
                }else if(actionItem.equalsIgnoreCase("Excel Name")) {
                    enterText(getFieldTextExcelName(), Section);
                    enterText(getTagTextbox(), Section);
                }else if(actionItem.equalsIgnoreCase("Tag Search box")){
                    enterText(getSectionTextbox(Section),ItemName);
                }else {
                    enterUsingActions(driver, new AnalysisPage(driver).addtagName(), actionItem);
                    waitForAngularLoad(driver);
                }
                break;
            case "Search":
                CommonUtil.storeText(actionItem);
                enterText(new AnalysisPage(driver).SearchTagValues(),actionItem);
                break;
            case "Searchconfig":
                CommonUtil.storeText(actionItem);
                enterText(new AnalysisPage(driver).searchConfigValues(),actionItem);
                break;
            case "Search In Node":
                CommonUtil.storeText(actionItem);
                enterText(new AnalysisPage(driver).searchinNode(),actionItem);
                break;
            case "Verify Information Message":
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getInformationMessage(actionItem)));
                break;
            case "Verify Plugin Information Message":
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getPluginInformationMessage(actionItem)));
                break;
            case "Tag Selection":
                clickOn(new AnalysisPage(driver).getTagstoAssign(Section,actionItem));
                break;
            case "mouse hover":
                waitForAngularLoad(driver);
                moveToElement(driver,getAssignedTags(Section,ItemName));
                sleepForSec(1000);
                break;
            case "Remove Tag":
                clickOn(new AnalysisPage(driver).getRemoveButton(Section,ItemName));
                break;
            case "Click":
                waitForAngularLoad(driver);
                if (actionItem.equalsIgnoreCase("Add Tag Button")) {
                    clickOn(new AnalysisPage(driver).getAddTagButton());
                } else if (actionItem.equalsIgnoreCase("Create a tag Button")) {
                    waitForAngularLoad(driver);
                    clickOn(new AnalysisPage(driver).getCreateTagButton());
                } else if (actionItem.equalsIgnoreCase("Search Icon")) {
                    clickOn(new AnalysisPage(driver).getSearchIcon());
                } else if (actionItem.equalsIgnoreCase("Close")) {
                    clickOn(new AnalysisPage(driver).getCloseButton());
                } else if (actionItem.equalsIgnoreCase("Tag")) {
                    clickOn(new AnalysisPage(driver).getTagButton(Section));
                }else if (actionItem.equalsIgnoreCase("Configselection")) {
                    clickOn(new AnalysisPage(driver).getConfigButton(Section));
                } else if (actionItem.equalsIgnoreCase("BA Attributes Save Button")) {
                    clickOn(getBAAttributesSaveButton());
                }  else if (actionItem.equalsIgnoreCase("EditBAName")) {
                    clickOn(getEditBAName());
                }else if(actionItem.equalsIgnoreCase("SaveBAName")){
                    clickOn(getSaveBAName());
                }else if(actionItem.equalsIgnoreCase("CancelBAName")){
                    clickOn(getCanelBAName());
                }else if(actionItem.equalsIgnoreCase("Search")){
                    clickOn(getSearchTagicon());
                }else if(actionItem.equalsIgnoreCase("Search Close")){
                    clickOn(getCloseTagicon());
                } else if (actionItem.equalsIgnoreCase("Completeness")) {
                    clickOn(getCompletenessExpandButton(ItemName));
                } else if (actionItem.equalsIgnoreCase("Item view Edit Button")) {
                    clickOn(driver,getItemViewBAEditButton().get(0));
                } else if (actionItem.equalsIgnoreCase("Item view Save Button")) {
                    clickOn(driver,getBAItemSaveButton());
                }else if (actionItem.equalsIgnoreCase("Item view Cancel Button")) {
                    clickOn(driver, getBAItemCancelButton());
                } else if (actionItem.equalsIgnoreCase("Item view Show More Icon")) {
                    clickOn(driver, getItemViewBAShowMoreIcon().get(0));
                }else if (actionItem.equalsIgnoreCase("BAEdit")) {
                    clickOn(new AnalysisPage(driver).getBAInfobutton(ItemName));
                }else if (actionItem.equalsIgnoreCase("BASave")) {
                    clickOn(new AnalysisPage(driver).getBAInfobutton(ItemName));
                }else if (actionItem.equalsIgnoreCase("BACancel")) {
                    clickOn(new AnalysisPage(driver).getBAInfobutton(ItemName));
                }else if (actionItem.equalsIgnoreCase("BAeditdisable")) {
                    clickOn(new AnalysisPage(driver).getBAInfoEditButtonDisable(ItemName));
                }else if (actionItem.equalsIgnoreCase("Assignconfig")) {
                    clickOn(new AnalysisPage(driver).getAssignButton());
                }else if (actionItem.equalsIgnoreCase("OwnerName")) {
                    clickOn(new AnalysisPage(driver).getBAownerName(ItemName));
                    }else if (actionItem.equalsIgnoreCase("OwnerName")) {
                    clickOn(new AnalysisPage(driver).getBAownerName(ItemName));
                }else if (actionItem.equalsIgnoreCase("OwnerCloseIcon")) {
                clickOn(new AnalysisPage(driver).getOwnerCloseicon());
            } else if (actionItem.equalsIgnoreCase("AssignedTags Icon")) {
                    clickOn(new AnalysisPage(driver).getAssignedTagsSearchIcon());
                } else if (actionItem.equalsIgnoreCase("Select a Tag")) {
                    clickOn(new AnalysisPage(driver).SelectAssignTagSearchTag(Section));
                } else if (actionItem.equalsIgnoreCase("Add new Excel Import")) {
                    clickOn(new AnalysisPage(driver).getAddNewxcelImport());
                } else if (actionItem.equalsIgnoreCase("Save")) {
                    clickOn(new AnalysisPage(driver).getSaveIconBusinessApplication());
                    waitForAngularLoad(driver);
                }
                else if (actionItem.equalsIgnoreCase("Unassignconfig")) {
                    clickOn(new AnalysisPage(driver).getUnassignbutton(ItemName));
                } else if(actionItem.equalsIgnoreCase("Item view Show more icons")){
                    traverseListContainsElementAndClick(driver, getItemViewShowMoreDropdown(), ItemName);
                    waitForAngularLoad(driver);
                } else if(actionItem.equalsIgnoreCase("Assign Data Button")){
                    clickOn(driver,getAssignDataButton());
                    waitForAngularLoad(driver);
                } else if(actionItem.equalsIgnoreCase("Grant Access")||actionItem.equalsIgnoreCase("Reject Access")){
                    clickOn(driver, getAccessRequestOption(actionItem));
                    waitUntilAngularReady(driver);
                } else {
                    clickOn(new AnalysisPage(driver).getSaveorcancelbutton(actionItem, ItemName));
                }
                waitForAngularLoad(driver);
                break;
            case "Verify Business Owner Widget value":
                String txt = getElementText(new AnalysisPage(driver).getWidgetcontainervalue(actionItem, ItemName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "No data available");
                Assert.assertEquals(ItemName, txt.trim());
                break;
            case "Verify Edit Widget value":
                String txxt = getAttributeValue(new AnalysisPage(driver).getWidgetcontainereditvalue(actionItem), "placeholder");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Start typing...");
                Assert.assertEquals(ItemName, txxt);
                break;
            case "Verify Details Widget Value":
                Assert.assertEquals(getElementText(getDetailsWidgetValue(actionItem,ItemName)),ItemName);
                break;
            case "Verify Hierarchy items are links":
                for(WebElement itemCount: getHierarchyItemsList()) {
                    Assert.assertNotNull(itemCount.getAttribute("href"));
                }
                break;
            case "Click Hierarchy link":
                clickOn(traverseListContainsElementReturnsElement(getHierarchyItemsList(),actionItem));
                break;
            case "verify selected Item is Highlighted":
                Assert.assertTrue(getHighlightedFirstItemInSerachResult().getCssValue("border-left-color").equals("rgba(147, 218, 73, 1)"));
                break;
            case "verify unselected Item is not Highlighted":
                Assert.assertTrue(getUnHighlightedFirstItemInSerachResult().getCssValue("border-left-color").equals("rgba(0, 0, 0, 0)"));
                break;
            case "Verify Lineage Statistics widgets":
                Assert.assertTrue(isElementPresent(getLineageStatisticsWidget(actionItem).get(0)));
                break;
            case "Verify Lineage Statistics widget content":
                Assert.assertTrue(getElementText(getLineageStatisticsWidget(actionItem).get(0)).contains(ItemName));
                break;
            case "Verify Number of Item types in Number of Items widget":
                int typeCount = getTableCountFromDiagram().size();
                Assert.assertTrue(getTypeCountInNumberOfItemsWidget().getAttribute("aria-label").contains(String.valueOf(typeCount)));
                break;
            case "Verify Lineage Statistics widgets absense":
                Assert.assertTrue(getLineageStatisticsWidget(actionItem).isEmpty());
                break;
            case "Verifies Widget for Metadata type":
                clickOn(returngetTopSearchIcon());
                waitForAngularLoad(driver);
                genericClick("facet selection", actionItem, "Metadata Type");
                waitForAngularLoad(driver);
                clickonWebElementwithJavaScript(driver, returnfirstItemIntableOfItemsFound().get(0));
                waitForAngularLoad(driver);
                String widgets[] = ItemName.split(",");
                for (String widgetsName : widgets) {
                    if (widgetsName.equalsIgnoreCase("Hierarchy")) {
                        Assert.assertTrue(isElementPresent(getHierarchyWidget()));
                    } else if (widgetsName.equalsIgnoreCase("Tags")) {
                        Assert.assertTrue(isElementPresent(getTagsWidget()));
                    } else if (widgetsName.equalsIgnoreCase("Rating")) {
                        Assert.assertTrue(isElementPresent(getRatingfacetitemview()));
                    }
                }
                break;
            case "EditIcon":
                clickOn(new AnalysisPage(driver).getEditIconWidget(actionItem));
                break;
            case "TrustScoreExpand":
                clickOn(new AnalysisPage(driver).getTrustScoreExpand(actionItem));
                break;
            case "TrustScoreCollapse":
                clickOn(new AnalysisPage(driver).getTrustScoreCollapse(actionItem));
                break;
            case "TrustScoreHeader":
                waitForAngularLoad(driver);
                Assert.assertTrue(new AnalysisPage(driver).getTrustscoreHeader(actionItem).isDisplayed());
                break;
            case "BusinessApplicationTabs":
                waitForAngularLoad(driver);
                Assert.assertTrue(new AnalysisPage(driver).getBusinessApplicationTabs(actionItem).isDisplayed());
                break;

            case "click Details in Completeness section":
                new AnalysisPage(driver).click_DetailsInCompletenessSection();
                break;

            case "Progress Bar validation":
                Assert.assertTrue(getAttributeOfProgressBar(actionItem).contains(ItemName));
                break;

            case "click to Tab":
                clickOn(new AnalysisPage(driver).getBusinessApplicationTabName(actionItem));
                break;

            case "Completeness Emotion icon state":
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getCompletenessEmotionIcon(actionItem,ItemName)));
                break;

            case "Select owner from dropdown":
                enterText(new AnalysisPage(driver).addBusinessvalue(actionItem), ItemName);
                sleepForSec(500);
                clickOn(new SubjectArea(driver).getWidgetBusinessOwnerDetails().get(0));
                break;
            case "Store Completeness width":
                String value = getTabCompletenessValue(actionItem).getCssValue("width");
                CommonUtil.storeText(value);
                break;
            case "verifies field is textbox":
                Assert.assertTrue(isElementPresent(getFieldTextBox(actionItem)));
                break;
            case "verify Completeness width is increased":
                String actualWidth = commonUtil.getNUMfromString(getTabCompletenessValue(actionItem).getCssValue("width"));
                String expectedWidth = commonUtil.getNUMfromString(CommonUtil.getText());
                Assert.assertTrue(new Float(actualWidth) > new Float(expectedWidth));
                break;
            case "Verify Tag Presence in Section":
                String[] tags = actionItem.split(",");
                if(actionItem.contains(",")){
                    for(String tagName: tags){
                        Assert.assertTrue(traverseListContainsText(getAssignedtag(Section),tagName));
                    }
                }else{
                    Assert.assertTrue(traverseListContainsText(getAssignedtag(Section),actionItem));
                }
                break;
            case "Verify Tag Absence in Section":
                String[] taggedItem = actionItem.split(",");
                if(actionItem.contains(",")){
                    for(String tagName: taggedItem){
                        Assert.assertFalse(traverseListContainsText(getAssignedtag(Section),tagName));
                    }
                }else{
                    Assert.assertFalse(traverseListContainsText(getAssignedtag(Section),actionItem));
                }
                break;
            case "Verify Tag Category":
                moveToElement(driver, getAssignedtags(ItemName));
                Assert.assertTrue(getElementText(getTagCategoryAndType(actionItem)).equals(Section));
                break;
            case "Verify Tag Type":
                moveToElement(driver, getAssignedtags(ItemName));
                Assert.assertTrue(getElementText(getTagCategoryAndType(actionItem)).equals(Section));
                break;
            case "Verify Tag Icon":
                Assert.assertTrue(getTagIconInItemViewPage().getAttribute("class").contains(ItemName));
                break;
            case "Verify Tag Icon Color":
                String iconColor = getTagIconColor(actionItem).getAttribute("style");
                Assert.assertTrue(CommonUtil.getText().contains(iconColor));
                break;
            case "Verify Tag Icon in Search Results":
                Assert.assertTrue(getTagIconInSearchResultsPage(actionItem).getAttribute("class").contains(ItemName));
                break;
            case "Verify Tag absense in widget":
                Assert.assertFalse(traverseListContainsElementText(getlistOfTagNames(),actionItem));
                break;
            case "Edit Icon BusinessTab":
                waitForAngularLoad(driver);
                actionClick(driver,getEditIconBusinessTab(actionItem));
                break;
            case "Select Dropdown of Details":
                moveToElement(driver, getBABusinessTabDetails(actionItem));
                clickonWebElementwithJavaScript(driver, getBABusinessTabDetails(actionItem));
                waitForAngularLoad(driver);
                moveToElement(driver, getBABusinessTabDetailsdropdown(actionItem, ItemName));
                clickOn(driver, getBABusinessTabDetailsdropdown(actionItem, ItemName));
                waitUntilJSReady(driver);
                waitForAngularLoad(driver);
                break;
            case "Select Category":
                clickonWebElementwithJavaScript(driver,getTagCategoryDropdown());
                waitForAngularLoad(driver);
                moveToElement(driver,getTagCategoryValue(actionItem));
                doubleClick(driver,getTagCategoryValue(actionItem));
                break;
            case "Verify Description Content":
                Assert.assertEquals(getElementText(getDescriptionContent()), actionItem);
                break;
            case "VerifyErrorMessage":
                if (actionItem.equalsIgnoreCase("Add PostProcessor Config")) {
                    Assert.assertEquals(new AnalysisPage(driver).getLicenseError().getText(),ItemName);
                }else if(actionItem.equalsIgnoreCase("Add DataSource Config"))
                {
                    Assert.assertEquals(new AnalysisPage(driver).getLicenseError().getText(),ItemName);
                }
                break;
            case "Verify Presence":
                if (actionItem.equalsIgnoreCase("Item view Edit Button")) {
                    Assert.assertTrue(isElementPresent(getItemViewBAEditButton().get(0)));
                } else if (actionItem.equalsIgnoreCase("Item view Show More Icon")) {
                    Assert.assertTrue(isElementPresent(getItemViewBAShowMoreIcon().get(0)));
                } else if (actionItem.equalsIgnoreCase("Item view BA Save Button")) {
                    Assert.assertTrue(isElementPresent(getBAItemSaveButton()));
                } else if (actionItem.equalsIgnoreCase("Item view BA Cancel Button")) {
                    Assert.assertTrue(isElementPresent(getBAItemCancelButton()));
                } else if (actionItem.equalsIgnoreCase("Rename Option under Show more Icon")) {
                    Assert.assertTrue(isElementPresent(getBARename()));
                } else if (actionItem.equalsIgnoreCase("Assign Data Button")) {
                    Assert.assertTrue(isElementPresent(getAssignDataButton()));
                } else if(actionItem.equalsIgnoreCase("Options under the Show more icon")){
                    if (ItemName.contains(",")) {
                        String[] fieldValue = ItemName.split(",");
                        for (String showMoreOptions : fieldValue) {
                            Assert.assertTrue(traverseListContainsElementText(getItemViewShowMoreDropdown(),showMoreOptions));
                        }
                    } else {
                        Assert.assertTrue(traverseListContainsText(getItemViewShowMoreDropdown(),ItemName));
                    }
                    break;
                }else {
                    throw new Exception();
                }
                break;
            case "Verify Absence":
                if (actionItem.equalsIgnoreCase("Item view Edit Button")) {
                    Assert.assertTrue(getItemViewBAEditButton().isEmpty());
                } else if (actionItem.equalsIgnoreCase("Item view Show More Icon")) {
                    Assert.assertTrue(getItemViewBAShowMoreIcon().isEmpty());
                } else if (actionItem.equalsIgnoreCase("Business Owners")) {
                    Assert.assertFalse(traverseListContainsElementText(getBusinessOwnersList(), ItemName));
                } else if (Section.equalsIgnoreCase("Widget Save/Cancel Button")) {
                    Assert.assertTrue(new AnalysisPage(driver).getSaveorcancelWidgetButton(actionItem, ItemName).isEmpty());
                } else {
                    throw new Exception();
                }
                break;
            case "Verify Disabled":
                if (actionItem.equalsIgnoreCase("Item view Edit Button")) {
                    Assert.assertFalse(verifyElementProperties(getItemViewBAEditButton().get(0), "isContentEditable"));
                } else if (actionItem.equalsIgnoreCase("Grant Access") || actionItem.equalsIgnoreCase("Reject Access")) {
                    Assert.assertFalse(verifyElementProperties(getAccessRequestOption(actionItem), "isContentEditable"));
                } else {
                    throw new Exception();
                }
                break;
            case "Verify BA Item widgets are Editable":
                Assert.assertFalse(verifyElementProperties(getBAItemDetailsTextbox("Application ID"),"readOnly"));
                Assert.assertFalse(verifyElementProperties(new AnalysisPage(driver).addBusinessvalue("Business Owners"), "readOnly"));
                Assert.assertFalse(verifyElementProperties(getDescriptionContent(), "readOnly"));
                break;
            case "Verify BA Item widgets are read only":
                Assert.assertFalse(verifyElementProperties(getBAItemDetailsTextboxDisabled(),"isContentEditable"));
                Assert.assertFalse(verifyElementProperties(getBAItemBusinessOwnerContainer(),"isContentEditable"));
                Assert.assertFalse(verifyElementProperties(getBAItemDescriptionContainer(),"isContentEditable"));
                break;
            case "topbar":
                if (Section.equalsIgnoreCase("N/A")) {
                    Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getTopbar(ItemName, Section)));
                } else {
                    if (ItemName.equalsIgnoreCase("Business Application")) {
                        Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getBusinessapplpage(ItemName, Section)));
                        clickOn(new AnalysisPage(driver).getBusinessapplpage(ItemName, Section));
                    } else {
                        Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getTopbardata(ItemName, Section)));
                    }
                }
                break;
            case "Verify Data Tab Label Presence":
                Assert.assertTrue(isElementPresent(getDataTabLabelInfo(actionItem)));
                break;
            case "Verify Plugin Configuration Values":
                if (actionItem.equalsIgnoreCase("Last execution after plugin run")) {
                    String currentDate = CommonUtil.getCurrentDateFormatted();
                    Assert.assertTrue(getElementText(getLastExecutionAfterPluginRun()).contains(currentDate));
                } else if (actionItem.equalsIgnoreCase("Data")) {
                    Assert.assertTrue(isElementPresent(getPluginAccordionChartType(ItemName)));
                } else if (actionItem.equalsIgnoreCase("Technology")) {
                    Assert.assertTrue(isElementPresent(getTechnologyName(ItemName)));
                } else if (actionItem.equalsIgnoreCase("Missing Chart type")) {
                    Assert.assertFalse(traverseListContainsElement(getCaptureTabChartTypes(),ItemName));
                } else {
                    Assert.assertTrue(getElementText(getPluginAccordionFieldValues(actionItem)).contains(ItemName));
                }
                waitForAngularLoad(driver);
                waitUntilJSReady(driver);
                break;
            case "Verify Itemview Owners":
                if (actionItem.equalsIgnoreCase("Owners")) {
                    Assert.assertTrue(isElementPresent(getOwnersName(ItemName)));
                } else if (actionItem.equalsIgnoreCase("OwnersIcon")) {
                    Assert.assertTrue(isElementPresent(getAvatarIcon()));
                }else if (actionItem.equalsIgnoreCase("OwnerName")) {
                    Assert.assertTrue(isElementPresent(getBAownerName(ItemName)));
                }else if (actionItem.equalsIgnoreCase("User Info Panel")) {
                    Assert.assertTrue(isElementPresent(getUserInfoPanel()));
                }else if (actionItem.equalsIgnoreCase("OwnerEmail")) {
                    Assert.assertTrue(isElementPresent(getEmailaddressinfo(ItemName)));
                }
                waitForAngularLoad(driver);
                break;

            case "Plugin Configuration Accordion":
                waitForAngularLoad(driver);
                if (actionItem.equalsIgnoreCase("Accordion presence")) {
                    Assert.assertTrue(isElementPresent(getPluginAccordion(ItemName).get(0)));
                } else if (actionItem.equalsIgnoreCase("Accordion absence")) {
                    Assert.assertTrue(getPluginAccordion(ItemName).isEmpty());
                } else if (actionItem.equalsIgnoreCase("Expand Accordion")) {
                    clickOn(getPluginAccordion(ItemName).get(0));
                    scrollToWebElement(driver,getPluginAccordion(ItemName).get(0));
                } else if (actionItem.equalsIgnoreCase("Verify Header Menu options")) {
                    String[] headerIcons = ItemName.split(",");
                    for (String icon : headerIcons) {
                        Assert.assertTrue(isElementPresent(getMenuButtonForTheItem(Section, icon)));
                    }
                } else if (actionItem.equalsIgnoreCase("Data Content")) {
                    Assert.assertTrue(isElementPresent(getPluginAccordionDataContent(ItemName)));
                } else if (actionItem.equalsIgnoreCase("Click Header Menu options")) {
                    clickOn(getMenuButtonForTheItem(Section, ItemName));
                } else if (actionItem.equalsIgnoreCase("Store Dataelements Count")) {
                    CommonUtil.storeText(getElementText(getPluginAccordionFieldValues(ItemName)));
                } else if (actionItem.equalsIgnoreCase("Verify accordion item and Search count are same")) {
                    int itemCount = Integer.parseInt(commonUtil.getNUMfromString(gettotalitemCount().getText()));
                    Assert.assertTrue(String.valueOf(itemCount).equals(CommonUtil.getText()));
                } else if (actionItem.equalsIgnoreCase("Verify Accordion Plugin Status")) {
                    Assert.assertTrue(isElementPresent(getAccordionPluginStatus(ItemName, Section)));
                }else if(actionItem.equalsIgnoreCase("Verify Accordion Plugin Status")){
                    Assert.assertTrue(isElementPresent(getAccordionPluginStatus(ItemName,Section)));
                } else if(actionItem.equalsIgnoreCase("Verify accordion Icon")) {
                    Assert.assertTrue(isElementPresent(getAccordionIconPresent(ItemName, Section)));
                } else if(actionItem.equalsIgnoreCase("Verify Configuration Header")) {
                    Assert.assertTrue(isElementPresent(getPluginHeadercolor(ItemName, Section)));
                }
                else {
                    throw new Exception();
                }
                sleepForSec(700);
                waitForAngularLoad(driver);
                break;
            case "Verify Trust Score Value":
                String Trust_value = commonUtil.getNUMfromString(new AnalysisPage(driver).getTrustScoreValue(ItemName).getText());
                Assert.assertEquals(Trust_value, actionItem);
                break;
            case "Sort Section":
                clickOn(getPopUpSectionSortButton(Section));
                waitForAngularLoad(driver);
                if (actionItem.equalsIgnoreCase("Ascending")) {
                    clickOn(getPopUpSectionAscendingSortOption(Section));
                } else if (actionItem.equalsIgnoreCase("Descending")) {
                    clickOn(getPopUpSectionDesendingSortOption(Section));
                } else {
                    clickOnWithJavascript(driver, getPopUpSectionDefaultSortOption(Section));
                }
                waitUntilAngularReady(driver);
                break;
            case "Verify Top bar section":
                if (ItemName.contains(",")) {
                    String[] fieldValue = ItemName.split(",");
                    for (String tagValue : fieldValue) {
                        Assert.assertTrue(traverseListContainsElementText(getTopbarSectionValues(Section, actionItem),tagValue));
                    }
                } else {
                    Assert.assertTrue(traverseListContainsText(getTopbarSectionValues(Section, actionItem),ItemName));
                }
                break;
            case "Click Top bar section":
                clickOn(getTopbarSectionValues(Section, actionItem).get(0));
                waitForAngularLoad(driver);
                break;
            case "Verify Tag Icon in Itemviewpage":
                String tagIcon = getTagIconColor(actionItem).getAttribute("class");
                Assert.assertTrue(tagIcon.contains(ItemName));
                break;
            case "Verify Tag in Itemviewpage":
                Assert.assertTrue((getTagItemView(actionItem).getAttribute("class").contains(ItemName)));
                break;
            case "Click Dropdown element":
                keyPressEvent(driver, Keys.ESCAPE);
                scrollToWebElement(driver, new AnalysisPage(driver).getBAArchitectureTabDropdown(actionItem));
                actionClick(driver, new AnalysisPage(driver).getBAArchitectureTabDropdown(actionItem));
                break;
            case "Select Multiple dropdown values of Widgets":
                waitForAngularLoad(driver);
                moveToElement(driver, new AnalysisPage(driver).getBAArchitectureTabDropdownValue(ItemName));
                actionClick(driver, new AnalysisPage(driver).getBAArchitectureTabDropdownValue(ItemName));

                break;
            case "Verify presence of Dropdown Values":
                waitForAngularLoad(driver);
                scrolltoElement(driver,new AnalysisPage(driver).getArchtectureDropdownValues(actionItem, ItemName),true);
                Assert.assertTrue(isElementPresent(new AnalysisPage(driver).getArchtectureDropdownValues(actionItem, ItemName)));
                break;
            case "Verify Default Category":
                waitForAngularLoad(driver);
                Assert.assertTrue(isElementPresent(getTagCategoryDefault(actionItem)));
                break;
            case "Verify Tabular View":
                Assert.assertTrue(isElementPresent(getTabularViewInCaptureTab(actionItem)));
                break;
            case "Verify Data table":
                if (ItemName.contains(",")) {
                    String[] fieldValue = ItemName.split(",");
                    for (String columnName : fieldValue) {
                        Assert.assertTrue(traverseListContainsElementText(getDataTableColumnsInCaptureTab(), columnName));
                    }
                } else {
                    Assert.assertTrue(traverseListContainsElementText(getDataTableColumnsInCaptureTab(), ItemName));
                }
                break;
            case "Verify Data table Column Value":
                Assert.assertTrue(getElementText(getMetadataTypeAndCount(actionItem)).equalsIgnoreCase(ItemName));
                break;
            case "Verify the Sorting Order":
                boolean flag = false;
                List<String> actual = new ArrayList<>();
                traverseListContainsElementAndClick(driver, getDataTableColumnsInCaptureTab(), ItemName);
                if (ItemName.equalsIgnoreCase("Name") && actionItem.equalsIgnoreCase("Ascending")) {
                    for (WebElement datasource : nameColumnInCaptureTab) {
                        actual.add(datasource.getText());
                    }
                    flag = Ordering.natural().isOrdered(actual);
                } else if (ItemName.equalsIgnoreCase("Name") && actionItem.equalsIgnoreCase("Descending")) {
                    for (WebElement datasource : nameColumnInCaptureTab) {
                        actual.add(datasource.getText());
                    }
                    flag = Ordering.natural().reverse().isOrdered(actual);
                } else if (ItemName.equalsIgnoreCase("Count") && actionItem.equalsIgnoreCase("Ascending")) {
                    for (WebElement numericSort : countColumnInCaptureTab) {
                        actual.add(numericSort.getText());
                        System.out.println(actual);
                    }
                    flag = Ordering.natural().isOrdered(actual);
                } else if (ItemName.equalsIgnoreCase("Count") && actionItem.equalsIgnoreCase("Descending")) {
                    for (WebElement numericSort : countColumnInCaptureTab) {
                        actual.add(numericSort.getText());
                    }
                    flag = Ordering.natural().reverse().isOrdered(actual);
                }
                Assert.assertTrue(flag);
                break;
            case "Navigate to field and select using key":
                driver.navigate().refresh();
                waitUntilAngularReady(driver);
                sleepForSec(1500);
                clickOn(driver, getItemViewBAEditButton().get(0));
                waitUntilAngularReady(driver);
                clickOn(getItemViewInputBox().get(0));
                for (WebElement fieldName : getItemViewFields()) {
                    String fieldDropdown = fieldName.getText();
                    if (fieldDropdown.equals(actionItem)) {
                        waitUntilAngularReady(driver);
                        keyPressEvent(driver, Keys.ENTER);
                        waitUntilAngularReady(driver);
                        keyPressEvent(driver, Keys.ARROW_DOWN);
                        waitUntilAngularReady(driver);
                        for (WebElement menuOption : getItemViewDropdownMenu()) {
                            String fieldValue = menuOption.getText().toString();
                            if (fieldValue.equalsIgnoreCase(ItemName)) {
                                keyPressEvent(driver, Keys.ENTER);
                            } else {
                                keyPressEvent(driver, Keys.ARROW_DOWN);
                            }
                        }
                        break;
                    } else {
                        if (fieldDropdown.equalsIgnoreCase("Profile Date")) {
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }
                    }
                }
                break;
            case "Verify Key Navigation hightlights field":
                clickOn(getItemViewInputBox().get(0));
                for (int i = 0; i < getItemViewFields().size(); i++) {
                    if (getItemViewFields().get(i).getText().equalsIgnoreCase(ItemName)) {
                        break;
                    } else {
                        if (getItemViewFields().get(i).getText().equalsIgnoreCase("Profile Date")) {
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }                    }
                }
                if(actionItem.equalsIgnoreCase("Dropdown field")) {
                    for (int i = 0; i < getItemViewDropdownFields().size(); i++) {
                        if (getItemViewDropdownFields().get(i).getText().equalsIgnoreCase(ItemName)) {
                            Assert.assertTrue(getItemViewDropdownField().get(i).getCssValue("border-bottom-color").equals("rgba(60, 203, 218, 1)"));
                            break;
                        } else {
                            if (getItemViewDropdownFields().get(i).getText().equalsIgnoreCase("Profile Date")) {
                            } else {
                                keyPressEvent(driver, Keys.TAB);
                            }
                        }
                    }
                } else {
                    for (int i = 0; i < getItemViewFields().size(); i++) {
                        if (getItemViewFields().get(i).getText().equalsIgnoreCase(ItemName)) {
                            Assert.assertTrue(getItemViewTextField().get(i).getCssValue("border-bottom-color").equals("rgba(60, 203, 218, 1)"));
                            break;
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }
                    }
                }
                break;
            case "Verify dropdown is opened when enter is pressed":
                clickOn(getItemViewInputBox().get(0));
                for (WebElement fieldName : getItemViewFields()) {
                    String fieldDropdown = fieldName.getText().toString();
                    if (fieldDropdown.equals(actionItem)) {
                        keyPressEvent(driver, Keys.ENTER);
                        Assert.assertTrue(isElementPresent(getItemViewDropdownBox()));
                        break;
                    } else {
                        if (fieldDropdown.equalsIgnoreCase("Profile Date")) {
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }
                    }
                }
                break;
            case "Verify first option in dropdown is highlighted":
                driver.navigate().refresh();
                waitUntilAngularReady(driver);
                sleepForSec(1500);
                clickOn(driver, getItemViewBAEditButton().get(0));
                waitUntilAngularReady(driver);
                clickOn(getItemViewInputBox().get(0));
                for (WebElement fieldName : getItemViewFields()) {
                    String fieldDropdown = fieldName.getText().toString();
                    if (fieldDropdown.equals(actionItem)) {
                        keyPressEvent(driver, Keys.ENTER);
                        sleepForSec(500);
                        Assert.assertTrue(getItemViewDropdownMenu().get(0).getCssValue("background-color").equals("rgba(229, 229, 229, 1)"));
                        break;
                    } else {
                        if (fieldDropdown.equalsIgnoreCase("Profile Date")) {
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }
                    }
                }
                break;
            case "Verify selected option is highlighted":
                clickOn(getItemViewInputBox().get(0));
                for (WebElement fieldName : getItemViewFields()) {
                    String fieldDropdown = fieldName.getText().toString();
                    if (fieldDropdown.equals(actionItem)) {
                        keyPressEvent(driver, Keys.ENTER);
                        for (WebElement menuOption : getItemViewDropdownMenu()) {
                            String fieldValue = menuOption.getText().toString();
                            if (fieldValue.equalsIgnoreCase(ItemName)) {
                                Assert.assertTrue(menuOption.getCssValue("background-color").equals("rgba(229, 229, 229, 1)"));
                            } else {
                                keyPressEvent(driver, Keys.ARROW_DOWN);
                            }
                        }
                        break;
                    } else {
                        if (fieldDropdown.equalsIgnoreCase("Profile Date")) {
                        } else {
                            keyPressEvent(driver, Keys.TAB);
                        }
                    }
                }
                break;
            case "Verify Widget Item Count":
                String itemCount = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemViewWidgetCount(actionItem).getText());
                Assert.assertTrue(ItemName.equals(itemCount));
                break;
            case "Verify page title":
                waitForAngularLoad(driver);
                Assert.assertEquals(driver.getTitle(), Section);
                break;
            case "Verifies Item view tabs":
                if (actionItem.contains(",")) {
                    String[] fieldValue = actionItem.split(",");
                    for (String tabs : fieldValue) {
                        Assert.assertTrue(isElementPresent(getBAItemViewTabs(tabs)));
                    }
                } else {
                    Assert.assertTrue(isElementPresent(getBAItemViewTabs(actionItem)));
                }
                break;
            case "Assign Data":
                if(getAssignDataButton().isDisplayed()) {
                    clickOn(driver, getAssignDataButton());
                }
                waitForAngularLoad(driver);
                if (actionItem.contains(",")) {
                    String[] fieldValue = actionItem.split(",");
                    for (String itemName : fieldValue) {
                        new QuickStartActions(driver).SearchText(itemName);
                        waitForAngularLoad(driver);
                        clickOn(driver, getSelectAllCheckbox());
                        waitForAngularLoad(driver);
                        break;
                    }
                } else {
                    waitUntilAngularReady(driver);
                    new QuickStartActions(driver).SearchText(actionItem);
                    waitUntilAngularReady(driver);
                    sleepForSec(1500);
                    genericClick("firstItemCheckbox");
                    waitUntilAngularReady(driver);
                }
                clickOn(getAddToDataSetButton().get(0));
                waitForAngularLoad(driver);
                clickOn(getAddItemToDSInDropdownButton());
                waitForAngularLoad(driver);
                clickOn(getAddItemToDSInDropdown(ItemName));
                waitForAngularLoad(driver);
                clickOn(getAddItemToDSADDButton(Section));
                break;
            case "Check Item and select option":
                clickOn(driver, getDataItemCheckBox(actionItem));
                waitForAngularLoad(driver);
                clickOn(new SubjectArea(driver).getItemAction());
                waitForAngularLoad(driver);
                traverseListContainsElementAndClick(driver, getItemViewDropdownMenu(), ItemName);
                break;
            case "Check Item":
                clickOn(driver, getDataItemCheckBox(actionItem));
                waitForAngularLoad(driver);
                break;
            case "Verify option":
                WebElement element = traverseListContainsElementReturnsElement(getItemViewDropdownMenu(), ItemName);
                if(actionItem.equalsIgnoreCase("Enabled")){
                    Assert.assertTrue(isElementEnabled(element));
                } else if(actionItem.equalsIgnoreCase("Disabled")){
                    Assert.assertFalse(isElementEnabled(element));
                } else {
                    throw new Exception();
                }
            case "Select All items and select option":
                clickOnWithJavascript(driver, selectAllDataItem());
                waitForAngularLoad(driver);
                clickOn(new SubjectArea(driver).getItemAction());
                waitForAngularLoad(driver);
                traverseListContainsElementAndClick(driver, getItemViewDropdownMenu(), actionItem);
                break;
            case "Verify Column Value for Items":
                int count = 1;
                    for (WebElement colName : getItemViewColumnNamesInTable()) {
                        if (!getElementText(colName).equals(Section)) {
                            count++;
                        } else {
                            break;
                        }
                    }
                Assert.assertTrue(getElementText(getAccessRequestValueInItemView(count)).equalsIgnoreCase(ItemName));
                break;
            case "Verify column names inside table":
                waitForAngularLoad(driver);
                String[] fieldValue = actionItem.split(",");
                for (String column : fieldValue) {
                    traverseListContainsElement(getItemViewColumnNamesInTable(), column);
                }
                break;
        }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Validation on case " + actionItem + " failed");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Validation on case " + actionItem + " failed");

        }
    }

    public void ExcelImporterPageValidations(String actionType, String actionItem, String ItemName, String Section, String Attribute) throws Exception {
        switch (actionType) {
            case "Verify Hint Message":
                Assert.assertEquals(actionItem, getElementText(getExcelImporterHintMessage(actionItem)));
                break;
            case "Verify Alert Message":
                waitForAngularLoad(driver);
                Assert.assertEquals(actionItem, getElementText(getExcelImporterAlertMessage(actionItem)));
                break;
            case "Verify PopUp Message":
                Assert.assertEquals(actionItem, getElementText(getExcelImporterPopupMessage(actionItem)));
                break;
            case "Verify Error Message":
                Assert.assertEquals(actionItem, getElementText(getExcelImporterErrorMessage(actionItem)));
                break;
            case "Verify Success Message":
                Assert.assertEquals(actionItem, getElementText(getExcelImporterSuccessMessage(actionItem)));
                break;
            case "Verify Dropdown Values":
                VerifyExcelImporterpageDropdown(actionItem,ItemName);
                break;
            case "Select Dropdown":
                if (Section.equalsIgnoreCase("As Input")) {
                    selectExcelImporterpageDropdown(actionItem, ItemName);
                } else if (Section.equalsIgnoreCase("In Mapping Value")) {
                    selectExcelImporterMapDropdown(actionItem, ItemName);
                } else {
                    throw new Exception();
                }
                break;
            case "Click":
                if (actionItem.equalsIgnoreCase("Checkbox")) {
                    clickOnWithJavascript(driver, getExcelImporterCheckbox());
                } else if (actionItem.equalsIgnoreCase("Save")) {
                    waitForAngularLoad(driver);
                    clickOn(driver, getProfileSettingSaveButton());
                } else {
                    throw new Exception();
                }
                break;
            case "verify column value":
                if (actionItem.equalsIgnoreCase("Name")) {
                    Assert.assertTrue(getElementText(getNameColumnValue()).contains(ItemName));
                } else if (actionItem.equalsIgnoreCase("Imported Itemtype")) {
                    Assert.assertTrue(getElementText(getImportedItemTypeColumnValue()).contains(ItemName));
                }else {
                    throw new Exception();
                }
                break;
            case "Verify Column Value Contains":
                if (actionItem.equalsIgnoreCase("Name")) {
                    Assert.assertTrue(traverseListContainsText(getNameColumnList(), ItemName));
                } else if (actionItem.equalsIgnoreCase("Imported Itemtype")) {
                    Assert.assertFalse(traverseListContainsText(getItemTypeColumnList(), ItemName));
                }else {
                    throw new Exception();
                }
                break;
            case "verify column list not contains":
                Assert.assertFalse(traverseListContainsText(getNameColumnList(), actionItem));
                break;
            case "Verify Menu Buttons":
                moveToElement(driver,traverseListContainsElementReturnsElement(getNameColumnList(),actionItem));
                Assert.assertTrue(isElementPresent(getExcelImportMenuButton(actionItem, ItemName)));
                break;
            case "Verify prepopulated value":
                if (actionItem.equalsIgnoreCase("Name")) {
                    String readonly = getExcelImporterTextbox().getAttribute("readonly");
                    Assert.assertNotNull(readonly);
                } else if (actionItem.equalsIgnoreCase("Sheet Name") || actionItem.equalsIgnoreCase("Item Type")) {
                    Assert.assertTrue(getElementText(getExcelImportPrepopulatedValue(actionItem)).equalsIgnoreCase(ItemName));
                }else {
                    throw new Exception();
                }
                break;
            case "Verify prepopulated column value":
                Assert.assertTrue(getElementText(getColumnMappingPrepopulatedValue(actionItem)).equalsIgnoreCase(ItemName));
                break;
            case "Verify prepopulated column field":
                if (ItemName.equalsIgnoreCase("Attribute")) {
                    Assert.assertTrue(isElementSelected(getMappingRadioButton(actionItem, 1)));
                }
                break;
            case "Verify Mapping Table":
                Assert.assertTrue(isElementPresent(getMappingHeader(actionItem)));
                break;
            case "Verify Mapping Columns":
                String[] ColumnList = actionItem.split(",");
                for (String columnns : ColumnList) {
                    Assert.assertTrue(traverseListContainsText(getExcelImportColumnList(), columnns));
                }
                break;
            case "Input Item Attributes":
                //Selecting the type
                if (actionItem.equalsIgnoreCase("Attribute")) {
                    clickOn(driver, getMappingRadioButton(ItemName, 1));
                } else if (actionItem.equalsIgnoreCase("Scope")) {
                    clickOn(driver, getMappingRadioButton(ItemName, 2));
                } else if (actionItem.equalsIgnoreCase("LinkScope")) {
                    clickOn(driver, getMappingRadioButton(ItemName, 3));
                } else if (actionItem.equalsIgnoreCase("Link")) {
                    clickOn(driver, getMappingRadioButton(ItemName, 4));
                } else if (actionItem.equalsIgnoreCase("Tags")) {
                    clickOn(driver, getMappingRadioButton(ItemName, 5));
                } else {
                    throw new Exception();
                }
                break;
            case "Select Scope Values Parent":
                // Setting the Parent Scope Values
                waitForAngularLoad(driver);
                selectExcelImporterpageScopeDropdown(Section,actionItem,ItemName);
                waitForAngularLoad(driver);
                sleepForSec(500);
                break;
            case "Select Scope Values Child":
                // Setting the Child Scope Values
                waitForAngularLoad(driver);
                selectExcelImporterpageScopeDropdownChild(Section,actionItem,ItemName);
                waitForAngularLoad(driver);
                sleepForSec(500);
                break;
            case "Enter text":
                //Selecting the type
                if (actionItem.equalsIgnoreCase("Scope Level")) {
                    enterText(getScopeLevelTextbox(Section), ItemName);
                    sleepForSec(500);
                } else {
                    throw new Exception();
                }
                break;
            case "Enter Excel Importer Name":
                enterText(getExcelImportNameField(),ItemName);
                break;
            case "Verify Edit,Clone,Run and Delete":
                moveToElement(driver,getExcelImporterName(actionItem));
                Assert.assertTrue(isElementPresent(getExcelImporterFunctionality(actionItem,ItemName)));
                waitForAngularLoad(driver);
                break;
            case "Click Edit,Clone,Run and Delete":
                moveToElement(driver,getExcelImporterName(actionItem));
                actionClick(driver,getExcelImporterFunctionality(actionItem,ItemName));
                break;
            case "Verify Status":
                if(Section.equalsIgnoreCase("Image")) {
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(getExcelImporterStatus(actionItem,ItemName)));
                }else if(Section.equalsIgnoreCase("Icon")){
                    moveToElement(driver,getExcelImporterStatus(actionItem,ItemName));
                    Assert.assertTrue(isElementPresent(getExcelImporterStatus(actionItem,ItemName)));
                }
                break;
            case "Verify Imported Alert Message":
                Assert.assertTrue(isElementPresent(getExcelImporterSavedAlert(actionItem)));
                break;
            case "Verify Tooltip of Run":
                moveToElement(driver,getExcelImporterName(actionItem));
                moveToElement(driver,getExcelImporterFunctionality(actionItem,ItemName));
                String tooltip=getAttributeValue(getExcelImporterFunctionality(actionItem,ItemName),"title");
                Assert.assertEquals(ItemName,tooltip);
                break;
            case "Click Edit,Clone,Run,Download and Delete":
                moveToElementUsingJavaScript(driver,getExcelImporterName(actionItem));
                clickonWebElementwithJavaScript(driver,getExcelImporterFunctionality(actionItem,ItemName));
                waitUntilJSReady(driver);
                waitForAngularLoad(driver);
                break;
            case "Verify Name":
                waitForAngularLoad(driver);
                Assert.assertTrue(isElementPresent((getExcelImportNameField())));
                break;
            case "Click Status":
                moveToElement(driver,getExcelImporterName(actionItem));
                actionClick(driver,getExcelImporterStatus(actionItem,ItemName));
                break;
            case "Validate error Message":
                waitForAngularLoad(driver);
                Assert.assertTrue(isElementPresent(getExcelImporterError(actionItem)));
                waitUntilJSReady(driver);
                waitForAngularLoad(driver);
                break;
        }
    }

    public List<WebElement> getWidgetBusinessOwnerDetails() {
        synchronizationVisibilityofElementsList(driver, BusinessOwnerList);
        return BusinessOwnerList;
    }
    public WebElement getRemoveBusinesOwner() {
        synchronizationVisibilityofElement(driver, RemoveBusinessOwnerIcon);
        return RemoveBusinessOwnerIcon;
    }
    public WebElement getBusinesOwnerFirstItem() {
        synchronizationVisibilityofElement(driver,BusinessOwnerFirstItem);
        return BusinessOwnerFirstItem;

    }




    //Old Page Object copied from QADev for 10.3 Changes
    public boolean isValuesPresnetinTabSection(String tabName,List<String> listValues){
        boolean flag = false;
        try {
            List<String> itemResult = new ArrayList<>();
            List<String> expectedValues = new ArrayList<>();
            expectedValues.addAll(listValues);
            try {
                if (tabPaginationNextButton(tabName).isDisplayed()) {
                    try {
                        while (tabPaginationNextButton(tabName).isDisplayed()) {
                            itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                            clickOn(tabPaginationNextButton(tabName));
                            waitForAngularLoad(driver);
                        }
                    } catch (Exception e) {
                        itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                    }
                }
            } catch (Exception e) {
                itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
            }
            if(itemResult.size()==0){
                throw new Exception("Tab "+tabName+" is not presnet in itemView Page");
            }
            itemResult.retainAll(expectedValues);
            if (CommonUtil.compareLists(itemResult,expectedValues) == true) {
                flag = true;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean isValuesNotPresnetinTabSection(String tabName,List<String> listValues){
        boolean flag = false;
        try {
            List<String> itemResult = new ArrayList<>();
            List<String> expectedValues = new ArrayList<>();
            expectedValues.addAll(listValues);
            try {
                if (tabPaginationNextButton(tabName).isDisplayed()) {
                    try {
                        while (tabPaginationNextButton(tabName).isDisplayed()) {
                            itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                            clickOn(tabPaginationNextButton(tabName));
                            waitForAngularLoad(driver);
                        }
                    } catch (Exception e) {
                        itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                    }
                }
            } catch (Exception e) {
                itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
            }
            if(itemResult.size()==0){
                throw new Exception("Tab "+tabName+" is not presnet in itemView Page");
            }
            if (!itemResult.containsAll(expectedValues)) {
                flag = true;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    public WebElement getonestarRatingitemview() {
        synchronizationVisibilityofElement(driver, oneStarRatingItemViewPage);
        return oneStarRatingItemViewPage;
    }

    public WebElement gettwostarRatingitemview() {
        synchronizationVisibilityofElement(driver, twoStarRatingItemViewPage);
        return twoStarRatingItemViewPage;
    }

    public WebElement getthreestarRatingitemview() {
        synchronizationVisibilityofElement(driver, threeStarRatingItemViewPage);
        return threeStarRatingItemViewPage;
    }

    public WebElement getfourstarRatingitemview() {
        synchronizationVisibilityofElement(driver, fourStarRatingItemViewPage);
        return fourStarRatingItemViewPage;
    }

    public WebElement getfivestarRatingitemview() {
        synchronizationVisibilityofElement(driver, fiveStarRatingItemViewPage);
        return fiveStarRatingItemViewPage;
    }

    public WebElement rateDynamicallyItemviewpage(String text) {
        return driver.findElement(By.xpath("(//div[@class='asg-item-view-rating-stars d-inline']//span)["+text+"]"));
    }

    public WebElement getfirstItemName(String itemName) {
        // synchronizationVisibilityofElement(driver, firstItemofTable);
        return driver.findElement(By.xpath("//a[contains(text(),'"+itemName+"')]"));
    }

    public WebElement getonearavgRatingitemview() {
        //   synchronizationVisibilityofElement(driver, oneStaravgRatingItemViewPage);
        return oneStaravgRatingItemViewPage;
    }

    public WebElement gettwotaravgRatingitemview() {
        // synchronizationVisibilityofElement(driver, twoStaravgRatingItemViewPage);
        return twoStaravgRatingItemViewPage;
    }

    public WebElement getthreetaravgRatingitemview() {
        //  synchronizationVisibilityofElement(driver, threeStaravgRatingItemViewPage);
        return threeStaravgRatingItemViewPage;
    }

    public WebElement getfouraravgRatingitemview() {
        // synchronizationVisibilityofElement(driver, fourStaravgRatingItemViewPage);
        return fourStaravgRatingItemViewPage;
    }

    public WebElement getfivearavgRatingitemview() {
        //   synchronizationVisibilityofElement(driver, fiveStaravgRatingItemViewPage);
        return fiveStaravgRatingItemViewPage;

    }
    public WebElement getRatingfacetitemview() {
        //       synchronizationVisibilityofElement(driver, ratingfacetitemview);
        return ratingfacetitemview;
    }
    public WebElement getManageaccessUserandgroupsdropdown(String FieldName) {
        return driver.findElement(By.xpath("//div[@class='dropdown-filter text-truncate'][contains(text(),'"+FieldName+"')]"));
    }
    public WebElement getManageaccessUserandgroupsrolesdropdown(String FieldName) {
        return driver.findElement(By.xpath("//button[contains(@class,'dropdown-item')]//span[contains(text(),'"+FieldName+"')]"));
    }

    public void ExcelUIComparison(String FileName, String Option, String Sheet_Number) throws Exception {
        try {
            boolean flag = false;
            List<String> previousPage = new ArrayList<>();
            List<String> currentPage = new ArrayList<>();
            List<String> Expected = new ArrayList<>();
            String count = new CommonUtil().getNUMfromString(new SubjectArea(driver).getItemCount().getText());
            List<WebElement> listValue = new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound();
            for (WebElement ele : listValue) {
                currentPage.add(ele.getText());
                moveToElement(driver, ele);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "" + currentPage.toString());
            }
            int Size = Integer.parseInt(count);
            int CP_Size = currentPage.size();
            if (Size >= 9) {
                while (true) {
                    List<WebElement> elements = getScrollItemList();
                    previousPage.clear();
                    previousPage.addAll(currentPage);
                    currentPage.clear();
                    scrollDownUsingJS(driver, elements, 4);
                    waitForAngularLoad(driver);
                    for (WebElement ele : new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound()) {
                        currentPage.add(ele.getText());
                    }
                    currentPage.addAll(previousPage);
                    List<String> Actual = currentPage.stream().distinct().collect(Collectors.toList());
                    String ListCount = String.valueOf(Actual.size());
                    if (count.equals(ListCount)) {
                        for (String ExcelValues : ExcelUtil.getExcelValues(FileName, Option, Sheet_Number)) {
                            Expected.add(ExcelValues);
                        }
                        for (int i = 0; i < Expected.size(); i++) {
                            String tag = Expected.get(i);
                            if (Actual.contains(tag)) {
                                flag = true;
                            } else {
                                throw new Exception();
                            }
                        }
                        break;
                    } else {
                        continue;
                    }
                }
            } else {
                if (Size == CP_Size) {
                    for (String ExcelValues : ExcelUtil.getExcelValues(FileName, Option, Sheet_Number)) {
                        Expected.add(ExcelValues);
                    }
                    for (int i = 0; i < Expected.size(); i++) {
                        String tag = Expected.get(i);
                        if (currentPage.contains(tag)) {
                            flag = true;
                        } else {
                            Assert.fail(tag + " Imported Value not avilable in UI");
                        }
                    }
                }
            }
            driver.navigate().refresh();
        } catch (Exception e) {
            throw new Exception();
        }
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

    public List<WebElement> getMetadataAttributes(String sectionName) {
        return driver.findElements(By.xpath("//div[@class='asg-item-view-multi-properties-widget']//span[text()='" + sectionName + "']/../../..//div[contains(@class,'list-caption')]"));
    }

    public boolean isDataSetElementNotPresentInListMap(List<Map<String, String>> listValues, String elementType) throws Exception {
        boolean flag = false;
        for (Map<String, String> property : listValues) {
            try {
                if (traverseListContainsElement(getMetadataAttributes(property.get("widgetName")), property.get("metadDataAttriubte")) == true) {
                    flag = false;
                    break;
                } else {
                    throw new Exception();
                }
            } catch (Exception e) {
                flag = true;
            }
        }
        return flag;
    }


    public boolean searchPageValidations(String action, String fieldName, String inputText, String option) throws Exception {
        boolean flag = false;
        String actual = "";
        try {
            waitForAngularLoad(driver);
            clickOn(showMoreFacetButton("Metadata Type"));
            sleepForSec(1000);
            moveToElement(driver, selectDefiniteFacetType("Metadata Type", option));
            takeScreenShot(this.getClass().getName(), driver);
            clickOn(driver, selectDefiniteFacetType("Metadata Type", option));
            waitForAngularLoad(driver);
            sleepForSec(1000);
            takeScreenShot(action + " is captured", driver);
            switch (action) {
                case "Color code for each type":
                    actual = getTypeColorCode().getCssValue(fieldName);
                    LoggerUtil.logLoader_info(this.getClass().getName(),fieldName+" is not present");
                    Assert.assertEquals(actual, inputText);
                    break;
                case "Short name for each type":
                    actual = getTypeColorCode().getText();
                    LoggerUtil.logLoader_info(this.getClass().getName(),fieldName+" is not present");
                    Assert.assertEquals(actual, inputText);
                    break;
            }
            new DashboardActions(driver).genericClick("top Search Icon");
            flag = true;
        } catch (Exception e) {

            e.printStackTrace();
        }
        return flag;
    }


    public String getAttributeOfProgressBar(String eleName){
        String value = null;
        try {
            if(eleName.equalsIgnoreCase("Completeness")){
                value = getAttributeValue(new AnalysisPage(driver).getProgressBarCompletenessSection(eleName),"style");
             }
             else{
                value = getAttributeValue(new AnalysisPage(driver).getProgressBarDetailsSection(eleName),"style");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(),"Attribute value is not returned");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Attribute value is not returned");
        }
        return value;
    }


    public void validateProgressBarWidthPercentage(String fieldName,String header, String eleName){
        try {
            // Capturing the percentage of width before removing the parameter
            storeTemporaryText(getAttributeValue(new AnalysisPage(driver).getProgressBarDetailsSection(eleName),"style"));
            String val1[] = getTemporaryText().substring(7).split("%");
            int width1= Integer.parseInt(val1[0]);
            clickOn(new AnalysisPage(driver).getBusinessApplicationField(header,fieldName));
            keyPressEvent(driver, Keys.BACK_SPACE);
            keyPressEvent(driver, Keys.BACK_SPACE);
            clickOn(new AnalysisPage(driver).getSaveorcancelbutton(header,"Save"));
            sleepForSec(1000);
            // Capturing the percentage of width after removing the parameter
            storeTemporaryText(getAttributeValue(new AnalysisPage(driver).getProgressBarDetailsSection(eleName),"style"));
            String val2[] = getTemporaryText().substring(7).split("%");
            int width2= Integer.parseInt(val2[0]);
            Assert.assertTrue(width1>width2);
        } catch (NumberFormatException e) {
            LoggerUtil.logLoader_info(this.getClass().getName(),"Attribute value is not returned");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Attribute value is not returned");
        }
    }

    public WebElement getSection(String sectionName) {
        return driver.findElement(By.xpath("//p[contains(@class,'widget-title')]//span[text()='"+sectionName+"']"));
    }

    public void selectDetailsDropdown(String fieldName, String option) throws Exception {
        moveToElement(driver, getDetailsDropdownButtonOfTheField(fieldName));
        clickonWebElementwithJavaScript(driver, getDetailsDropdownButtonOfTheField(fieldName));
        waitForAngularLoad(driver);
        waitForAngularLoad(driver);
        moveToElement(driver, getDetailsAttributeDropdown(fieldName, option));
        clickonWebElementwithJavaScript(driver, getDetailsAttributeDropdown(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }


        public void trustPolicyRulesValidations(String actionItem, String ItemName, String Section) throws Exception {
            switch (actionItem) {
                case "SelectFactor":
                    waitForAngularLoad(driver);
                    clickOn(getTrustPolicyFactor());
                    if(traverseListContainsElementText( getTrustPolicyAddrulesFactor(),ItemName)==true) {
                        traverseListContainsElementAndClick(driver, getTrustPolicyAddrulesFactor(), ItemName);
                        waitForAngularLoad(driver);
                    }
                    else {
                        throw new Exception();
                    }
                    break;
                case "TrustPolicyLabel":
                    textClear(getTrustPolicyAddrulesLabel());
                    doubleClick(driver, getTrustPolicyAddrulesLabel());
                    keyPressEvent(driver, Keys.BACK_SPACE);
                    enterUsingActions(driver, getTrustPolicyAddrulesLabel(), ItemName);
                    break;
                case "TrustPolicySave":
                    clickOn(getTrustPolicyrulesSave());
                    waitForAngularLoad(driver);
                    break;
                case "Verify ChartLegend Authoritative Trust Score zero":
                    waitForAngularLoad(driver);
                    boolean flag = false;
                    try {
                        String chartlegend = getElementText(getChartLegend(ItemName));
                        String Chartlegendauthoritative = chartlegend.substring(22, 23);
                        System.out.println(Chartlegendauthoritative);
                        int trustscr = Integer.parseInt(Chartlegendauthoritative);
                        if (trustscr == 0) {
                            flag = true;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    Assert.assertTrue(flag);
                case "Verify ChartLegend Label":
                    waitForAngularLoad(driver);
                    boolean flag1 = false;
                    try {
                        String chartlegend1 = getElementText(getChartLegend(ItemName));
                        System.out.println(chartlegend1);
                        String policyChartlegend = chartlegend1.substring(0, 20);
                        if (policyChartlegend.equalsIgnoreCase(ItemName)) {
                            flag1 = true;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    Assert.assertTrue(flag1);
            }
    }

    @FindBy(xpath = "//div[contains(@class,'item-view-taglist')]//li/span")
    private List<WebElement> itemViewTags;

    public boolean tagValueVerification(String... arg){
        boolean flag=false;
        List<String> actual = new ArrayList<>();
        List<String> expected = new ArrayList<>();

        switch (arg[0]){
            case "TagAssigned":
                actual.addAll(getStringListFromElementsList(itemViewTags));

                String[] exp = arg[1].split(",");
                for (String value : exp) {
                    expected.add(value);
                }

                int acutalSize = actual.size();
                int expectedSize = expected.size();
                if (expectedSize <= acutalSize) {
                    for (int i = 0; i < expectedSize; i++) {
                        Iterator<String> e = expected.iterator();
                        if (traverseListContainsString(actual, expected.get(i)) == false) {
                            flag = false;
                            break;
                        }
                        flag = true;
                        e.next();
                    }
                }
                break;
            case "TagNotAssigned":
                actual.addAll(getStringListFromElementsList(itemViewTags));

                String[] str = arg[1].split(",");
                for (String value : str) {
                    expected.add(value);
                }

                int acutalListSize = actual.size();
                int expectedListSize = expected.size();

                for (int i = 0; i < expectedListSize; i++) {
                    Iterator<String> e = expected.iterator();
                    if (traverseListContainsString(actual, expected.get(i)) == true) {
                        flag = false;
                        break;
                    }
                    flag = true;
                    e.next();
                }

                break;
        }
        return flag;
    }

    public String getAttributeValue(String itemName, String attributeName) {
        return getdynamicPropertyInMetadata(itemName,attributeName).getText();
    }

    public String getItemIDfromURL(WebDriver driver){
        String itemID = null;
        String url = driver.getCurrentUrl();
        itemID = url.split("item-view/")[1].split("\\?catalogs=")[0];
        return itemID;
    }

    public boolean caeLineageGeneration(List<String> list1, List<String> list2, String... args) throws Exception {
        //args[0]=firstHierarchyItem, args[1]=lineage for column/datafield, args[2]=filepath, args[3]=tagsFilePath, args[4]=URL, args[5]=URL2, args[6]=jsonPath1, args[7]=jsonPath2,args[8]=jsonValue
        boolean flag = false;
        try {
            String sourceQuery = "select id from public.items where name='" + list1.get(0) + "' and type='" + args[0] + "'";
            int asg_scopeid = Integer.parseInt(dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery, "id"));
            list1.remove(0);

            for (String item : list1) {
                String sourceQuery1 = "select id from public.items where name='" + item + "' and asg_scopeid=" + asg_scopeid;
                asg_scopeid = Integer.parseInt(dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery1, "id"));
            }

            List<String> tableID = new ArrayList<>();
            for (String item : list2) {
                String sourceQuery1 = "select id from public.items where name='" + item + "' and asg_scopeid=" + asg_scopeid;
                tableID.add(dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery1, "id"));
//                asg_scopeid = Integer.parseInt(dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery1, "id"));
            }

            List<String> columnIDs = new ArrayList<>();
            List<String> columnPayloadIDs = new ArrayList<>();
            for (String item : tableID) {
                String sourceQuery2 = "select id from public.items where asg_scopeid=" + item + " and type='" + args[1] + "'";
                columnIDs.addAll(dbHelper.returnRecordInlist("STRUCTURED", "APPDBPOSTGRES", sourceQuery2, "id"));
                for (String payloadItem : columnIDs) {
                    columnPayloadIDs.add("\"Default." + args[1] + ":::" + payloadItem + "\"");
                }
                columnIDs.clear();
//                asg_scopeid = Integer.parseInt(dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery1, "id"));
            }

            JsonBuildUpdateUtil.addStringValueToFile(REST_DIR + args[2], columnPayloadIDs.toString());

            RestAPIWrapper restAPIWrapper = new RestAPIWrapper();
            restAPIWrapper.initializeRestAPI("IDC");
            restAPIWrapper.setBodyContent(args[2]);
            restAPIWrapper.setAcceptFormat(propLoader.prop.getProperty("TestSystemUser"), "application/json");
            restAPIWrapper.setContentType("application/json");
            restAPIWrapper.invokePostRequest(args[4]);
//            String response= restAPIWrapper.returnRestResponse();
            JsonBuildUpdateUtil.addStringValueToFile(REST_DIR + args[3], restAPIWrapper.returnRestResponse());

            JsonBuildUpdateUtil.updateJsonNode(REST_DIR + args[3], args[6], args[8]);
            JsonBuildUpdateUtil.updateJsonNode(REST_DIR + args[3], args[7], args[8]);

//            restAPIWrapper.resetRestAPI();
//            restAPIWrapper.initializeRestAPI("IDC");
            restAPIWrapper.setBodyContent(args[3]);
            restAPIWrapper.invokePostRequest(args[5]);
            Assert.assertEquals(204,restAPIWrapper.returnStatusCode());
            flag = true;

        } catch (Exception e) {
            flag = false;
            e.getMessage();
        }
        return flag;
    }

    public List<String> getItemNamesInUI(String elementName, String tabName) {
        List<String> itemResult = new ArrayList<>();
        try {
            switch (elementName) {
                case "list":

                    try {
                        if (tabPaginationNextButton(tabName).isDisplayed()) {
                            try {
                                while (tabPaginationNextButton(tabName).isDisplayed()) {
                                    itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                                    clickOn(tabPaginationNextButton(tabName));
                                    waitForAngularLoad(driver);
                                }
                            } catch (Exception e) {
                                itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                            }
                        }
                    } catch (Exception e) {
                        itemResult.addAll(itemResult.size(), getStringListFromElementsList(listOfItemsInTab(tabName)));
                    }
                    break;

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Element not found");
        }
        return itemResult;
    }

    public void FacetsActionsInSearchResultsPage(String actionType, String actionItem, String ItemName, String Attribute, String Section) throws Exception {
        try {
            List<String> actual = new ArrayList<>();
            switch (actionType) {
                case "Verify sort is active":
                    Assert.assertFalse(getSortTypeForFacet(actionItem,ItemName.toLowerCase()).get(0).getAttribute("class").contains("inactive"));
                    break;
                case "Verify sort is inactive":
                    Assert.assertTrue(getSortTypeForFacet(actionItem,ItemName.toLowerCase()).get(0).getAttribute("class").contains("inactive"));
                    break;
                case "Verify order is Descending":
                    if (ItemName.equalsIgnoreCase("Numeric")) {
                        for (WebElement numericSort : getFacetNumericOrder(actionItem)) {
                            actual.add(numericSort.getText());
                        }
                        Assert.assertFalse(Ordering.natural().isOrdered(actual));
                    } else {
                        for (WebElement numericSort : getFacetAlphaOrder(actionItem)) {
                            actual.add(numericSort.getText());
                        }
                        Assert.assertFalse(Ordering.natural().isOrdered(actual));
                    }
                    break;
                case "Verify order is Ascending":
                    if (ItemName.equalsIgnoreCase("Numeric")) {
                        for (WebElement numericSort : getFacetNumericOrder(actionItem)) {
                            actual.add(numericSort.getText());
                        }
                        Assert.assertTrue(Ordering.natural().isOrdered(actual));
                    } else {
                        for (WebElement numericSort : getFacetAlphaOrder(actionItem)) {
                            actual.add(numericSort.getText());
                        }
                        Assert.assertTrue(Ordering.natural().isOrdered(actual));
                    }
                    break;
                case "Click Sort":
                    clickOn(getSortTypeForFacet(actionItem,ItemName.toLowerCase()).get(0));
                    break;
                case "Verify sort absence":
                    String[] sortTypes = ItemName.split(",");
                    for (String sortName : sortTypes) {
                        Assert.assertTrue(getSortTypeForFacet(actionItem,sortName.toLowerCase()).isEmpty());
                    }
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Facet Validation is not performed");
            Assert.fail(e.getMessage());
        }

    }

    public void dataModalPageValidations(String actionType, String actionItem, String ItemName, String Section,String actionName) throws Exception {
        try {
            switch (actionType) {
                case "Validate ItemTypes":
                    Assert.assertTrue(traverseListContainsElementText(returncustomAttributesItemtypes(), actionItem));
                    break;
                case "Click ItemTypes":
                    scrolListContainsElementAndClick(driver, returncustomAttributesItemtypes(), actionItem);
                    break;
                case "Click ItemTypes Tab":
                    if (ItemName.equalsIgnoreCase("Tabvalue")) {
                        clickOn(getItemtypesTabValue(actionItem));
                    } else {
                        clickOn(getAddCustomAttributes(actionItem));
                    }
                    break;
                case "Validate Itemtype Tab":
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(getItemtypesTab(actionItem, ItemName)));
                    break;
                case "Validate Itemtype Column":
                    Assert.assertTrue(isElementPresent(getItemtypesTabColumn(actionItem, ItemName, Section)));
                    break;
                case "Select Dropdown":
                    if (Section.equalsIgnoreCase("DataType")) {
                        waitForAngularLoad(driver);
                        moveToElement(driver, getAddCustomAttributesDropdown(actionItem));
                        clickOn(getAddCustomAttributesDropdown(actionItem));
                        selectmanageaccessusersandgroupsroles(ItemName);
                    } else {
                        waitForAngularLoad(driver);
                        moveToElement(driver, getAddCustomAttributesDropdown(actionItem));
                        clickOn(getAddCustomAttributesDropdown(actionItem));
                        selectmanageaccessusersandgroupsroles(ItemName);
                    }
                    break;
                case "Enter and Edit":
                    if (Section.equalsIgnoreCase("EnterText")) {
                        waitForAngularLoad(driver);
                        enterText(getCustomAttributeTextArea(), ItemName);
                    }
                    else if(Section.equalsIgnoreCase("BA Edit")) {
                        waitForAngularLoad(driver);
                        scrollToWebElement(driver,getAddCustomAttributesBAText(actionName,actionItem));
                        enterText(getAddCustomAttributesBAText(actionName,actionItem),ItemName);
                    }
                    else if(Section.equalsIgnoreCase("BA Edit and click")) {
                        waitForAngularLoad(driver);
                        scrollToWebElement(driver, getAddCustomAttributesBAText(actionName, actionItem));
                        clickOn(driver, getAddCustomAttributesBAText(actionName, actionItem));
                    }
                    else if(Section.equalsIgnoreCase("BA Edit and  click Toggle")) {
                        waitForAngularLoad(driver);
                        scrollToWebElement(driver, getCustomAttributeToggleswitch());
                        clickOn(driver, getCustomAttributeToggleswitch());
                    }
                    break;
                case "Validate customAttributes Itemview Dropdown":
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(getAddCustomAttributesDropdown(actionItem)));
                    break;

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Validation on case " + actionItem + " failed");
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Validation on case " + actionItem + " failed");

        }
    }
}
