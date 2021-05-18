package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.Constant;
import com.asg.automation.utils.JsonRead;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import com.google.common.collect.Ordering;
import org.openqa.selenium.*;
import org.openqa.selenium.support.FindAll;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.TreeMap;

/**
 * Created by muthuraja.ramakrishn on 4/7/2017.
 */

@SuppressWarnings("DefaultFileTemplate")
public class DashBoardPage extends UIWrapper {

    private WebDriver driver;
    private JsonRead jsonRead;
    public CommonUtil commonUtil = new CommonUtil();

    @FindBy(xpath = "//img[@class='profile-icon img-circle']")
    private WebElement imgCircle;

    @FindBy(xpath = "//div[@class[contains(.,left-navigation-item)]]//following::span[@class[contains(.,'far fa-home')]]")
    private WebElement homeButton;

    @FindBy(xpath = "//a[contains(.,'PLUGIN MANAGER')]")
    private WebElement ingestionConfiguration;

    //@FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'CATALOG MANAGER')]")
    @FindBy(xpath="//a[@href='/IDC/catalog-management']")
    private WebElement subjectAreaManager;

    @FindBy(xpath="//a[@href='/IDC/catalog-management']")
    private List<WebElement> subjectAreaManagerLink;

    @FindBy(xpath = "//button[@class='btn btn-default profile-settings']")
    private WebElement profileSettingsButton;

    @FindBy(xpath = "//a[contains(.,'Details')]")
    private WebElement detailsTab;

    @FindBy(xpath = "//a[contains(.,'Preferences')]")
    private WebElement preferencesTab;

    @FindBy (css = ".custom-checkbox > label[for='advSearch']")
    private WebElement solrCheckbox;

    @FindBy(xpath = "//div[@class='profile-text']/b[1]")
    private WebElement profileName;

    @FindBy(xpath = "//div[@class='profile-text']/span[1]")
    private WebElement profileRole;

    @FindBy(xpath = "//span[contains(text(),'PROFILE SETTINGS')]/..//button/em")
    private WebElement profileExitButton;

    @FindBy(xpath = "//span[contains(.,'PROFILE SETTINGS')]")
    private WebElement profileSettingsTitle;

    @FindBy(xpath = "(//*[contains(@class,'fa-user-circle') or contains(@class,'profile-icon')])[1]")
    private WebElement profileIcon;

    @FindBy(xpath = "//a[contains(text(),'Sign Out')]")
    private WebElement profileLogoutButton;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-bell')]]")
    private WebElement notificationsIcon;

    //@FindBy(xpath = "//div[@class='asg-notifications-content']//div[@class='asg-new-notifications']//div[@class='asg-notifications-text-block']/div/span")
    @FindBy(xpath = "//div[@class='asg-notifications-content']//div[@class='asg-new-notifications']//div[@class='asg-notification-gray']")
    private List<WebElement> newNotificationsList;

    @FindBy(xpath = "//div[@class='asg-notifications-content']//div[@class='asg-new-notifications']//div[@class='asg-notifications-text-block'][1]/span[3]")
    private List<WebElement> notificationsContentList;

    @FindBy(xpath = "//div[@class='asg-notifications-content']//div[@class='asg-new-notifications']//div[@class='clearfix']")
    private List<WebElement> oldNotificationsList;

    @FindBy(xpath = "//strong[contains(.,'NOTIFICATIONS')]")
    private WebElement NotificationsTitleLabel;

    @FindBy(xpath = "//a[@href='https://www.asg.com/Company/Press.aspx']")
    private WebElement asgNewsWelcomeWidget;

    @FindBy(xpath = "//button[contains(.,'Mark all read')]")
    private WebElement markAllReadNotificationsButton;

    @FindBy(xpath = "//button[contains(.,'Dismiss all')]")
    private WebElement dismissAllNotificationsButton;

    @FindBy(xpath = "//div[@class='tab-content']//tab[contains(@class,'active')]//div[@class='clearfix']/div/i[@class='fa fa-check-circle' or @class='fa fa-minus-circle']//following::div[@class='asg-notifications-text-block'][1]//span/b")
    private List<WebElement> activeUnreadNotificationsList;

    @FindBy(xpath = "//h5[contains(.,'STRUCTURE')]")
    private WebElement structureLabelInSubjectAreaPage;

    //@FindBy (xpath = "//div[@class='asg-panels-item-caption clearfix']/div/b[contains(text(),'PLUGIN MANAGEMENT')]")
    @FindBy (xpath = "//div[@class='asg-panels-item-caption-ellipsis']/b[contains(text(),'SEARCH')]")
       private WebElement catalogHeading;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//div[@class='asg-panels-item-caption clearfix']//span[contains(.,'SUBJECT AREA')]")
    private WebElement subjectAreaTitleInStructurePage;

    @FindBy(xpath = "//div[@class='tab-pane active']//div[@class='asg-new-notifications']//div[@class='asg-notification-item d-flex flex-wrap']/div")
    private List<WebElement> notificationsTimeStamp;

    @FindBy(xpath = "//a[contains(text(),'Data Catalog Documentation')]")
    private WebElement asgDocumentationPage;

    @FindBy(xpath = "//div[@class='clearfix']//div//span//b[contains(.,'Ingestion started!')]")
    private WebElement ingestionStartNotification;

    @FindBy(xpath = "//div[@class='clearfix']//div//span//b[contains(.,'Ingestion succeeded!')]")
    private WebElement ingestionSuccessNotification;

    @FindBy(xpath = "//span[contains(.,'Manage your data ingestion configurations here')]")
    private WebElement Widget_IngestionDescription;

    @FindBy(xpath = "//i[contains(@class,'glyphicon glyphicon-download')]")
    private WebElement WidgetIgestionConfigImageIcon;

    @FindBy(xpath = "//p[contains(text(),'Ingestion manager: edit and execute scanner configurations')]")
    private WebElement Widget_IngestionConfigDefinition;

    @FindBy(xpath = "//p[contains(text(),'Ingestion')]//following::div[3][contains(text(),'QUICK LINKS')]")
    private WebElement Widget_IngestionQuickLinks;

    @FindBy(xpath = "//p[contains(text(),'Ingestion manager')]//following::div[contains(text(),'RECENT')]")
    private WebElement Widget_IngestionRecentLabel;

    @FindBy(xpath = "//p[contains(text(),'Ingestion')]//following::div[4]//a[contains(text(),'Open management')]")
    private WebElement IngestionConfig_OpenManagement;

    @FindBy(xpath = "//p[contains(text(),'Ingestion')]//following::div/a[contains(text(),'Create new configuration')]")
    private WebElement IngestionConfig_OpenNewConfiguration;

    @FindBy(xpath = "//a[contains(text(),'CATALOG MANAGER')]")
    private WebElement Widget_SubjectAreaManager;


    @FindBy(xpath = "//h3[contains(text(),'Quick Links')]")
    private WebElement welcomeWidgetQuickLinks;

    @FindBy(xpath = "//h1[contains(.,'ASG Intelligent Data Catalog')]")
    private WebElement welcomeWidgetDefinition;

    @FindBy(xpath = "//div[@class='welcome-widget']/div/img")
    private WebElement welcomeWidgetImage;

    @FindBy(xpath = "//div[@class='welcome-widget']")
    private WebElement welcomeWidgetDescription;

    @FindBy(xpath = "//h2[contains(.,'Welcome')]")
    private WebElement welcomeWidgetTitle;

    @FindBy(xpath = "//span[contains(.,'Manage catalogs here.')]")
    private WebElement SubjectAreaManager_Description;

    @FindBy(xpath = "//span[contains(@class,'monitor-heart-rate')]")
    private WebElement DashboardButton;

    @FindBy(xpath = "//i[@class='fa fa-tasks']")
    private WebElement SubjectAreaManagerIcon;

    @FindBy(xpath = "//a[contains(.,'CATALOG MANAGER')]//following::p[contains(text(),'specify tags')]")
    private WebElement SubjectAreaManagerDefinition;

    @FindBy(xpath = "//a[contains(.,'CATALOG MANAGER')]//following::div[@class='asg-base-widget-quick-header'][contains(.,'QUICK LINKS')][1]")
    private WebElement SubjectAreaManagerQuickLink;

    @FindBy(xpath = "//a[contains(.,'CATALOG MANAGER')]/following::div[@class='asg-base-widget-recent-header'][contains(.,' RECENT ')][1]")
    private WebElement SubjectAreaManagerRecentLabel;

    @FindBy(xpath = "//p[contains(text(),'existing')]//following::div[4]//a[contains(text(),'Open management')]")
    private WebElement SubjectAreaManagerOpenManagement;

    @FindBy(xpath = "//a[@href='/IDC/catalog-management;new=true']")
    private WebElement SubjectAreaManagerCreateNewArea;

    @FindBy(xpath = "//a[contains(.,'BIGDATA')]")
    private WebElement subjectAreaTitle;

    @FindBy(xpath = "//ul[@class='pagination pager justify-content-center']/li[@class='active']")
    private WebElement paginationFeature;

    @FindBy(xpath = "//ul[@class='pagination pager justify-content-center']/li[2]/button")
    private WebElement lastpage;

    @FindBy(xpath = "//span[contains(.,'MY OPEN TASKS')]")
    private WebElement openMyTaskPagination;

    @FindBy(xpath = "//ul[@class='pagination pager justify-content-center']/li[1]/button")
    private WebElement firstpage;

    //@FindBy(xpath = "//div/a[contains(text(),'BIGDATA')]//following::div/button[2]")
    @FindBy(css=".asg-area-widget-top-btn-block>button:nth-of-type(2)")
    private WebElement editSubjectArea;

    @FindBy(xpath = "//div[@class='asg-area-widget-title-block']//following::input[@id='areaTitle']")
    private WebElement editSubjectAreaName;

    @FindBy(xpath = "//button[@class='btn btn-default pull-right asg-area-widget-save-btn']")
    private WebElement editSubjectAreaSave;

    @FindBy(xpath = "//input[@id='areaDescription']")
    private WebElement editSubjectAreaDescription;

    @FindBy(xpath = "//a[contains(.,'BIGDATA')]/following::span[contains(.,'BigData')]")
    private WebElement subjectAreaDescription;

    @FindBy(xpath = "//select[@class='form-control ng-untouched ng-pristine ng-valid'][1]")
    private WebElement editQuickLinksSubjectArea;

    @FindBy(xpath = "//a[contains(.,'BIGDATA')]//following::a[1]")
    private WebElement getQuickLinkName;

    @FindBy(xpath = "//div[@class='asg-area-widget-quick']/div[contains(text(),' QUICK LINKS')]")
    private WebElement subjectAreaQuickLinkLabel;

    @FindBy(xpath = "//div[@class='asg-area-widget-quick']/div[@class='asg-area-widget-quick-link']")
    private WebElement subjectAreaQuickLinkList;

    @FindBy(xpath = "//div[@class='asg-area-widget-recent']//following::div[contains(text(),'RECENT')]")
    private WebElement subjectAreaRecentLabel;

    @FindBy(xpath = "//div[@class='asg-area-widget-recent-header']//following::div")
    private WebElement subjectAreaRecentList;

    @FindBy(xpath = "//div[@class='asg-area-widget-top-btn-block']//following::button[@id='search-button']")
    private WebElement subjectAreaSearchIcon;

    @FindBy(xpath = "//div[@class='input-group asg-area-widget-search-box dropdown-item']//following::input[@id='searchQuery']")
    private WebElement subjectAreaSearchText;

    @FindBy(xpath = "//span[@class='input-group-btn']/button[@class='btn btn-primary']")
    private WebElement subjectAreaSearch;

    @FindBy(xpath = "//div[@class='btn-group widget-menu dropdown']/button")
    private WebElement widgetSideMenu;

    @FindBy(xpath = "//a[@class='add-new-tab tab-link']")
    private WebElement dashboard_AddButton;

    @FindBy(xpath = "//div[@class='left-side']//input[@type='text']")
    private WebElement dashboard_NewName;

    // @FindBy(xpath = "//a[@class='tab-link save']//span[contains(text(),'SAVE')]")
    @FindBy(css = "span.fa.fa-floppy-o")
    private WebElement dashboard_SaveButton;

    @FindBy(xpath = "//div[@class[contains(.,'dashboard-edit-panel')]]//div[@class='right-side']//ul//li[@title='BIGDATA']")
    private WebElement elementToBeDragged;

    @FindBy(xpath = "//li[@title='SEARCH CATALOG1']//span[@class='icon-caption']")
    private WebElement searchWidget;

    @FindBy(xpath = "//li[@class[contains(.,'dashboard-widget-wraper')]][1]")
    private WebElement placeToBeDropped;

    @FindBy(xpath = "//a[@class[contains(.,'tab-link edit')]]")
    private WebElement dashboard_EditButton;

    @FindBy(xpath = "//a[@class='tab-link edit']")
    private WebElement dashboard_EditButton_Edge;

    @FindBy(xpath = "//span[contains(.,'DELETE')]")
    private WebElement dashboard_DeleteButton;

    @FindBy(xpath = "//span[contains(.,'Delete')]")
    private WebElement quickLinkDeleteButton;

    @FindBy(xpath = "//div[@class='asg-new-notifications']//div[1]//span//b[contains(.,'Comment added')]")
    private WebElement commentsNotification;

    @FindBy(xpath = "//a[@class='tab-link active']")
    private WebElement dashboardActiveTab;

    @FindBy(xpath = "//a[contains(text(),'BIGDATA')]//following::div[@class='btn-group widget-menu'][1]//button")
    private WebElement bigDataDropdownToggle_dashboard;

    @FindBy(xpath = "//ul[@class='dropdown-menu-right dropdown-menu show']/li[@role='menuitem'][1]/a[contains(.,'Remove')]")
    private WebElement removeButton_dashboard;

    @FindBy(xpath = "//div[@class[contains(.,'asg-show-more-facet')]][1]//button[contains(.,'Show All')][1]")
    private WebElement showAllButton;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]]//strong[contains(.,'Type')]//following::span[contains(.,'Show More')]")
    private WebElement ShowAll_facet_Button;

    @FindBy(xpath = "//div[@class[contains(.,'asg-search-facet-header')]][contains(text(),'Catalog')]//following::div[@class[contains(.,'asg-show-more-facet')]][1]/button")
    private WebElement ShowAll_facet_Button_Catalog;

    @FindBy(xpath = "//button[contains(@class,'dropdown-item')]")
    private WebElement suggestionopt;

    @FindBy(xpath = "//span[@class='input-group-addon search-addon'][1]/span")
    private WebElement getTopSearchIcon;

    @FindBy(css = "div.scrollable-content > div:nth-child(1) > div > div > div > app-asg-checkbox > div > label")
    private WebElement firstItemCheckbox;

    @FindBy(xpath = "//ul[@class[contains(.,'pagination pager')]]/li/button[@class='fa fa-plus']")
    private WebElement editDashboardPlusButton;

    @FindBy(xpath = "//a[@class='new-dashboard tab-link active']")
    private WebElement newDashboard;

    //@FindBy(xpath = "//a[contains(text(),'BIGDATA')]/following::div[@class='input-group asg-area-widget-search-box']/button")
    @FindBy(xpath = "//div[@class='asg-area-widget-ellipsis'][contains(@title,'BigData')]//following::div[@class='asg-area-widget-top-btn-block'][1]/button[2]")
    private WebElement bigDataWidgetEditbutton;

    @FindBy(xpath = "//div/div[@title='Search Catalog']/following::div[@class='asg-area-widget-top-btn-block'][1]/button[2]/i")
    private WebElement searchCatalogWidgetEdit;

    @FindBy(xpath = "//div[@class='asg-area-widget-quick-header-edit']/following::select[1]")
    private WebElement quicklinkDropdownOne;

    @FindBy(xpath="//div[@class[contains(.,'asg-area-widget-quick-link-edit')]]//div[@class[contains(.,'btn-group asg-catalog-widget-drop-down')]][1]//button")
    private WebElement quicklinkFirstDropdown;

    @FindBy(css = "ul[class='dropdown-menu show']")
    private WebElement quickLinkFirtDropDownList;

    @FindBy(xpath = "//div[@class='asg-area-widget-quick-link-edit']/div[@class='btn-group asg-catalog-widget-drop-down'][2]/button")
    private WebElement quicklinkSecondDropDown;

    @FindBy(css = "div[class='dropdown show open']>ul>li:nth-child(1) > a:nth-child(1) > span:nth-child(1)")
    private List<WebElement> quicklinkDropdown1;

    @FindBy(css = "div[class='asg-area-widget-body']>div>div[class='asg-area-widget-quick']>div>a:nth-child(1)")
    private WebElement bigDataWidgetfirstQuicklink;

    @FindBy (xpath="//div[@class='dropdown show open']/ul/li/a/span[contains(.,'<empty>')]")
    private WebElement emptyLink;

    @FindBy (css = "div[class='dropdown show open']>ul>li:nth-child(1)")
    private WebElement Quicklink;

    @FindBy(xpath = "//button[@class='btn dropdown-toggle clearfix']")
    private WebElement QuickLinkDropDown;

    @FindBy (xpath ="//div[@class='dropdown show open']/ul/li/a/span[contains(.,'Database list through solr')]")
    private WebElement FirstQuicklink;

    @FindBy (xpath ="//div[@class='dropdown show open']/ul/li/a/span[contains(.,'List of all Databases sample1')]")
    private WebElement multiWidgetQuicklink;

    @FindBy(xpath = "//div[@class[contains(.,'asg-area-widget-footer clearfix')]]/button[contains(.,'Save')]")
    private WebElement WidgetSaveButton;

    @FindBy(xpath = "//div[@class='asg-area-widget-footer clearfix']/button[contains(.,'Discard')]")
    private WebElement WidgetDiscardButton;


    @FindBy (xpath = "//div[@title='Quick Link']/following::div[@class='asg-area-widget-body'][1]/div/div[1]/div[2]/a")
    private WebElement  secondWidgetFirstlink;

    @FindBy (css=".asg-area-widget-quick-link > a")
    private List<WebElement> quicklinkList;

    @FindBy (xpath="//div[@title='Search Catalog']/following::div[@class='asg-area-widget-body'][1]/div/div[1]/div/a[1]")
    private WebElement firstwidegtquicklinkone;

    @FindBy(xpath="//span[contains(text(),'Advanced: Support full Solr syntax.')]")
    private WebElement advanceSlorLabel;

    @FindBy (xpath="//div[contains(text(),'Cluster Demo [Cluster]')]/parent::*/div[3]/div/label")
    private WebElement clusterDemo;

    @FindBy (xpath="//pagination/ul/li[7]/a")
    private WebElement tableNavigation;

    @FindBy (xpath="//b[contains(text(),'queryText:')]/following-sibling::span")
    private WebElement queryText;

    @FindBy (xpath="//p[contains(text(),'INPUT')]/../div/table/tbody")
    private WebElement inputTable;

    @FindBy (xpath="//div[@class='asg-notifications-text-block']//span[@class='asg-notifications-gray asg-notification-ellipsis']")
    private WebElement itemResponseId;

    @FindBy(css=".asg-notifications-dismiss.asg-notifications-green.float-right")
    private WebElement dismissLink;

    @FindBy(xpath = "//div[@class='asg-new-notifications-header']/span[@class='asg-notifications-green notification-length']")
    private WebElement notificationCount;

    @FindBy(xpath = "//div[@class='asg-notifications-text-block']")
    private List<WebElement> notificationListCount;

    @FindBy(css=".btn.asg-modal-reject-btn")
    private WebElement dismissNotificationNo;

    @FindBy(css="button[class='btn asg-modal-confirm-btn float-right']")
    private WebElement dismissNotificationYes;


    // @FindBy(css=".nav.nav-tabs.dashboard-tabs-panel>li:nth-child(2)> a")
    @FindBy(xpath="//a[contains(.,'Administration')]")
    private WebElement administrationDashboard;

    //@FindBy(css="a[href='/IDC/item-view-management']")
    @FindBy(xpath="//a[contains(.,'ITEM AND LIST VIEW MANAGER')]")
    private WebElement itemViewManagement;

    @FindBy(xpath="//i[@class=\"fa fa-pencil\"]")
    private WebElement editWidgetPencil;

    @FindBy(css="#areaDefinition")
    private WebElement widgetDescription;

    @FindBy(css=".asg-area-widget-body>p")
    private WebElement descriptionPara;

    @FindBy(xpath="//span[contains(text(),'Preferences')]")
    private WebElement preference;

    @FindBy(xpath="//span[@class='glyphicon glyphicon-warning-sign']")
    private WebElement warningButton;

    @FindBy(xpath="//ul[@class ='dropdown-menu show' ]//following::li[contains(@role,'menuitem')]//a/span")
    private List<WebElement> serachCatalogDropdownList;

    @FindBy(xpath="//button[@class[contains(.,'dropdown-item')]]")
    private List<WebElement> searchDropdownList;

    @FindBy(xpath="//input[@id='advanced-search-flag']/..")
    private WebElement advanceSearch;

    @FindBy(xpath="//div[@class='widget-catalog-warning-message']//div")
    private WebElement toolTip;

    @FindBy(xpath="//div[@class='advanced-properties-header cursor-pointer']")
    private WebElement advancedSettings;

    //    @FindBy (xpath = "//div[@class='dashboard-widget dashboard_00 welcome-widget-background']/div[@class='btn-group widget-menu']/button")
    @FindBy (xpath = "//div[@class='welcome-widget']/../../..//button[@class='btn btn-primary dropdown-toggle']")
    private WebElement welcomeWidgetSizeMenu;

    @FindBy (xpath = "//ul[@class='dropdown-menu dropdown-menu-right']/li/a[contains(.,'1 x 1')]")
    private WebElement widgetSizeOnebyTwo;

    @FindBy (xpath = "//ul[@class='dropdown-menu dropdown-menu-right']/li/a[contains(.,'1 x 2')]")
    private WebElement widgetsizeTwobyTwo;

    @FindBy(css = "div[class='item-list-total-number']")
    private WebElement itemListCount;

    public WebElement getToolTip() {
        return toolTip;
    }

    @FindBy(xpath="//span[contains(.,'PROFILE SETTINGS')]//following::i[@class='fa fa-times']")
    private WebElement exitButton;

    @FindBy(css="button[class='btn btn-save']")
    private WebElement saveButtonInProfileSettingPage;

    public WebElement getExitButton() {
        return exitButton;
    }

    public WebElement getSaveButton() {
        return saveButtonInProfileSettingPage;
    }

    public WebElement getAdvanceSearch() {
        return advanceSearch;
    }

    public WebElement getSetting() {
        return setting;
    }

    public WebElement getPreference() {
        return preference;
    }

    @FindBy(css="i[class='fa fa-cog']")
    private WebElement setting;

    @FindAll (@FindBy(how = How.XPATH, using ="//pagination/ul/li"))
    private List<WebElement> paginationListLength;

    @FindBy(xpath="//input[@placeholder='Search a widget...']")
    private WebElement searchWidgetBox;

    @FindBy(xpath="//ul[@class='nav nav-tabs dashboard-tabs-panel']/li/a[contains(.,'QuickStart')]")
    //@FindBy(css=".tab-link.active")
    private WebElement quickStartDashboard;

    @FindBy(css=".asg-dashboard-icon-caption")
    private List<WebElement> iconCaptionsList;

    //@FindBy(xpath="//button[@class='fa fa-plus']")
    @FindBy(xpath= "//div[@class[contains(.,'dashboard-add-widget-container')]]/button/i[@class='fa fa-plus']")
    private WebElement plusButton;

    @FindBy(xpath="//ul[@class='dashboard-content edit-mode'][2]/li[@class='dashboard-widget-wraper']")
    private WebElement dropLocationForSecondPage;

    @FindBy(css=".pagination.pager>li>button")
    private List<WebElement> paginationOfDashboard;

    @FindBy(css="span[class='fa fa-times searchIcon']")
    private WebElement removeSearchTextButton;

    @FindBy (xpath = "//div/button/span[@class='float-left']")
    private WebElement blankLink;

    public WebElement getFileDataContent() {
        return fileDataContent;
    }

    @FindBy(xpath ="//span[contains(text(),'Data')]/following::pre")
    private WebElement fileDataContent;

    @FindBy(css = "button[class='asg-iframe-fullsize-btn float-right']")
    private WebElement fullSizeIcon;

    @FindBy(css = "i[class='asg-iframe-widget-btn asg-icon-full-size']")
    private WebElement fullSizeIcon_Edge;

    @FindBy(xpath = "//i[@class[contains(.,'asg-iframe-widget-btn asg-icon-compress')]]")
    private WebElement compressIconButton;

    @FindBy(xpath = "//p[contains(.,'TAG')]/following-sibling::div/div/div/p")
    private WebElement tagSectionText;

    private String xpathWithDynamicValue ="//a[contains(text(),'$DYN$')]";

    private String xpathWithDynamicTableValue="//div[@class='asg-panels-item-caption clearfix scrollable']//following::p[starts-with(.,'$DYN$')]";
    private String tableSize="//div[@class='asg-panels-item-caption clearfix scrollable']//following::p[starts-with(.,'$DYN$')]/..//tbody/tr";
    //"//p[contains(text(),'$DYN$')]/..//tbody/tr";
    private String dynamicSearchValue="//div[@class='asg-panels-item-caption clearfix scrollable']//following::p[starts-with(text(),'$DYN$')]/..//tbody/tr[$NUM$]/td[$TDNUM$]/span";

    private String itemFullViewTable="//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//following::p[starts-with(.,'$DYN$')]";

    private String itemFullViewTableSize="//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//following::p[starts-with(.,'$DYN$')]/..//tbody/tr";

    private String itemFullViewSearchValue="//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//following::*[contains(text(),'$DYN$')]/following::tbody/tr[$NUM$]/td[$TDNUM$]/span";


    @FindBy(css="button[id='button-about']")
    private WebElement informationIcon;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-about')]]/li")
    private List<WebElement> submenulist;

    @FindBy(xpath = "//span[@class='app-version-label']")
    private WebElement versionlabel;

    @FindBy(xpath="//span[@class='app-version']")
    private WebElement versionNumber;

    @FindBy(xpath="//span[@class='app-build-label']")
    private WebElement buildLabel;

    @FindBy(xpath="//span[@class='app-build-info']")
    private WebElement buildInformation;

    @FindBy(xpath="//div[@class='copyright-info']/p")
    private WebElement copyrights;

    @FindBy(xpath="//a[@class='privacy-policy']")
    private WebElement privacy_policy;

    @FindBy(xpath="//a[@target='_blank'][contains(text(),'link')]")
    private WebElement openSourceDocuments;

    @FindBy(xpath="//div[@class='modal-body']/button")
    private WebElement about_Closebutton;

    @FindBy(xpath = "//div[@class='modal-header']/button/span")
    private WebElement Alert_Closebutton;

    @FindBy(xpath="//html//div/div[2]/app-asg-checkbox[1]/div[1]/label[1]")
    private WebElement customNotifictaioncheck;

    @FindBy(xpath="//div[@class='alert alert-danger asg-profile-alert']")
    private WebElement customMenuErrorWarning;

    @FindBy(xpath="//button[@class='btn btn-save']")
    private WebElement preferenceSaveButton;

    /*@FindBy(xpath="//li[@class='form-group'][3]/div[2]")
    private List<WebElement> menuItemList;*/

    @FindBy(xpath="//div[@class='left-navigation-item']")
    private WebElement leftPaneItemValue;

    @FindBy(xpath="//button[@class='form-control clearfix asg-profile-icon-layout-btn']")
    private WebElement layoutSelection;

    @FindBy(css = "button[class='form-control clearfix asg-profile-icon-layout-btn']>span:nth-child(1)")
    private List<WebElement> layoutList;

    @FindBy(xpath = "//ul[@class='dropdown-menu show']//li")
    private List<WebElement> catalogList;


    @FindBy(css = "div[class='asg-search-header-ellipsis']")
    private WebElement catalogDropDown;

    //10.3 New UI page factory

    @FindBy(xpath = "//div[@class[contains(.,'left-navigation-item')]][3]")
    private WebElement settingsIcon;

    @FindBy(xpath = "//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'fas fa-plus-circle')]]")
    private WebElement CreateButton;

    @FindBy(xpath = "//span[contains(text(),  'Data Discovery')]")
    private WebElement appicon;

    @FindBy(xpath = "//a[@class[contains(.,'navbar-brand')]]")
    private WebElement headerText;

    @FindBy(xpath = "//a[@class[contains(.,'navbar-brand')]]")
    private WebElement versionText;

    @FindBy(css = "span[class='fal fa-search search-icon-default cursor-pointer']")
    private WebElement globalSeacrhIcon;

    @FindBy(xpath = "//em[@class='fal fa-bell' and @class='fal-fa-envelope' or @class='fal fa-question-circle']")
    private WebElement headerProfileIcons;

    @FindBy(xpath = "//div[@class='collapse navbar-collapse float-right h-100'][1]/div[1]")
    private WebElement headerSearchBlock;

    @FindBy(xpath = "//input[contains(@placeholder,'Search...')]")
    private List<WebElement> topSearchBoxAsList;

    @FindBy(xpath = "//input[contains(@placeholder,'Search...')]")
    private WebElement topSearchBox;

    @FindBy(css = "button[class='btn asg-btn-primary-sm selected-drop-item dropdown-toggle']")
    private WebElement headerCatalogDropdown;

    @FindBy(css = "span[class='fa fa-times search-icon']")
    private WebElement searchCrossButton;

    @FindBy(css = "span[class='fa fa-search search-icon-align']")
    private WebElement searchButton;

    @FindBy(css = "div.run-search-container.btn-group.asg-filter-btn-group.dropdown > a > span > em")
    private WebElement searchDropdown;

    @FindBy(xpath = "//*[@class='fal fa-search search-icon-default cursor-pointer'][@hidden]")
    private WebElement hiddenGlobalSearchButton;

    @FindBy(xpath = "//*[@class[contains(.,'expandedmenu')]]")
    private List<WebElement> expandedSidebar;

    @FindBy(xpath = "//ul/li[@class[contains(.,'sidebar-submenu')]]")
    private List<WebElement> sidebarSubmenuAsList;

    @FindBy(xpath = "//div//button[@class='dropdown-item']/span")
    private List<WebElement>searchSubmenuAsList;

    @FindBy(xpath = "//label[@class[contains(.,'asg-dyn-form-property-label tooltip-indicator')]][1]")
    private List<WebElement> configurationLabelsAsList;

    @FindBy(xpath = "//div[@class='asg-facet-item-holder text-left asg-facet-item-ellipsis']")
    private List<WebElement> MetadatattypeList;

    @FindBy(xpath = "//div[@class[contains(.,'slideInOut')]][@title='Admin']/div/div/ul/li/a")
    private List<WebElement> sidebarAdminLinks;

    @FindBy(xpath = "//div[@class='content-wrapper']//following::div[@class='welcome-page']/div[contains(.,'Hello, Test System Administrator.')]")
    private WebElement welcomePageUnderSettingsIcon;

    @FindBy(xpath = "//div[@class='content-wrapper']//following::div[@class='manage-config-table']/..")
    private WebElement manageConfigurationsPage;

    @FindBy(xpath = "//div[@class='content-wrapper']//following::div[@class='asg-manage-container']/.")
    private WebElement manageDataSourcesPage;

    @FindBy(xpath = "//div[@class='content-wrapper']//following::div[@class='data-capture-container']/.//div[contains(.,'Manage Excel Imports')]")
    private WebElement manageExcelImportsPage;

    @FindBy(xpath = "//span[@class='fa-lg pr-1 fa fa-plus-square']//following::span[contains(.,'Add Data Source')]")
    private WebElement addSourceButton;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-plus-square')]][1]")
    private WebElement addSourceButtonInManageDataSourcePage;

    @FindBy(xpath = "//span[@class[contains(.,'add-text position-relative')]]")
    private WebElement addBundlesButton;

    @FindBy(xpath = "//div[@class='license-content-block']")
    private WebElement licensePage;

    @FindBy(xpath = "//div[contains(.,'Add Data Source')]/.")
    private WebElement addDataSourcePopup;

    @FindBy(xpath = "//div[@class[contains(.,'child-configuration-container')]]")
    private List<WebElement> addDataSourcePageConfigurations;

    @FindBy(xpath = "//button[contains(.,'SAVE')]")
    private WebElement saveButton;

    @FindBy(xpath = "//button[contains(.,' SAVE AND OPEN ')]")
    private WebElement saveandOPenButton;

    @FindBy(xpath = "//button[contains(.,' ASSIGN ')]")
    private WebElement AssignButton;

    @FindBy(xpath = "//div[@class='save-search-btns']//button[contains(.,'SAVE')]")
    private WebElement SaveSearchSaveButton;

    @FindBy(xpath = "//span[contains(.,'Type')]//following::em[@class='fa fa-chevron-down']")
    private WebElement typeDropdownButton;

    @FindBy(xpath = "//button[contains(.,'NEXT')]")
    private WebElement nextButton;

    @FindBy(xpath = "//button[contains(.,'FINISH')]")
    private WebElement finishButton;

    @FindBy(xpath = "(//a[contains(.,'Cancel')])[1]")
    private WebElement cancelButton;

    @FindBy(xpath = "//button[@class[contains(.,'close')]]/span")
    private WebElement closeButtonInPopUp;

    @FindBy(css = "button[class='test-btn mb-1']")
    private WebElement testConnectionButton;

    @FindBy(css = "button[class='save-btn mb-1']")
    private WebElement testConnectionButtonDisabled;

    @FindBy(xpath="//span[@class[contains(.,'disable-link cursor-not-allowed')]]")
    private WebElement BAEditIconDisabled;

    //@FindBy(xpath = "//div[@class='asg-dynamic-form-property-label-container']/label[contains(.,'Credential ')]//following::input[@id='name']")
    @FindBy(xpath="//div[@class='asg-dynamic-form-property-label-container']//label[contains(.,'Credential')]//following::input[@id='name']")
    private WebElement credentialNameTextbox;

    @FindBy(xpath = "//input[@id='name']")
    private WebElement pipelineNameTextBox;

    @FindBy(xpath = "//textarea[@id='description']")
    private WebElement pipelineDescriptionTextbox;

    @FindBy(xpath = "//button[@class[contains(.,'start-btn mb-1')]]")
    private List<WebElement> WelcomPageStartButton;

//    @FindBy(xpath = "//em[@class[contains(.,'fal fa-user-circle')]]")
//    private WebElement profileImage;

    @FindBy(xpath = "//span[@class[contains(.,'em fal fa-user-circle fa-2x profile-icon-identifier')]]")
    private WebElement profileImage;

    @FindBy(css = "a[href='/DD/profile']")
    private WebElement profileSetting;

    @FindBy(xpath = "//strong[contains(.,'Metadata Type')][1]//following::div[@class='asg-show-more-facet'][1]/button")
    private WebElement ShowAll_facetFilter_Button;

    @FindBy(xpath = "//span[@class='pl-1 ng-tns-c4-0 far fa-file-chart-line ng-star-inserted']")
    private WebElement Reporticon;

    @FindBy(xpath = "//button[@class='close float-right']/span")
    private WebElement Closeicon;

    @FindBy(xpath = "//em[@class[contains(., 'fal fa-sync cursor-pointer')]]")
    private WebElement RefreshIcon;

    @FindBy(xpath = "//div[@class='d-flex select-all-container']")
    private WebElement SelectAll;

    public WebElement getShowAll_facetFilter_Button() {
        synchronizationVisibilityofElement(driver, ShowAll_facetFilter_Button);
        return ShowAll_facetFilter_Button;
    }

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate')]][1]")
    private List<WebElement> isDataSourcePresentInmanageDataSourceList;

    @FindBy(xpath = "//span[contains(.,'Available')]//following::div[@class[contains(.,'select-none')]]")
    private List<WebElement> popSectionList;

    @FindBy(xpath = "//td[@class='ng-star-inserted'][1]")
    private List<WebElement> FirstColumnList;

    @FindBy(xpath = "//span[@class='ng-star-inserted'][1]")
    private List<WebElement> FirstColumnList1;

    @FindBy(xpath = "//td[@class='text-truncate ng-star-inserted sorted-column']")
    private List<WebElement> ValueColumnList;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate')]][2]")
    private List<WebElement> getDataSourceType;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate')]][3]")
    private List<WebElement> getBundleVersion;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate')]][1]")
    private List<WebElement> isCredentialsPresentFromTheList;

    @FindBy(xpath = "//td[@class[contains(.,'text-truncate')]][2]")
    private List<WebElement> isKeywordPresentFromTheList;

    @FindBy(xpath = "//div[@class[contains(.,'test-success')]][contains(.,'Successful connection with data source.')]")
    private WebElement successConnectionMessage;

    @FindBy(xpath = "//div[@class[contains(.,'test-error')]][contains(.,'No connection with data source')]")
    private WebElement failedConnectionMessage;

    @FindBy(xpath = "//span[@class[contains(.,'fa-filter')]]")
    private WebElement filterIcon;

    @FindBy(css = "div[class='toast-msg']")
    public List<WebElement> pluginCompletionPopUp;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-sort')]]")
    private WebElement sortIcon;

    @FindBy(xpath = "//button[contains(.,'SAVE')]")
    public WebElement configSave;

    @FindBy(xpath = "(//button[contains(.,'SAVE')])[2]")
    public WebElement pipelinepluginConfigSave;

    @FindBy(xpath = "//button[contains(.,'SAVE SEARCH')]")
    public WebElement saveSearch;

    @FindBy(xpath = "//input[@id='searchName']")
    private WebElement saveSearchNameTextBox;

    @FindBy(xpath = "//input[@id='asgManageSearch']")
    private WebElement bundlesSearchTextBox;

    @FindBy(xpath = "//input[@id='description']")
    private WebElement saveSearchDescriptionTextBox;

    @FindBy(xpath = "//button[contains(.,'SAVE')]")
    public WebElement SaveSearch;

    @FindBy(xpath = "//div[contains(.,' Save Search ')]//following::button[contains(.,'SAVE')]")
    public WebElement saveSearchResults;

    @FindBy(xpath = "//h4[contains(text(),'Edit Configuration to LocalNode')]")
    private WebElement editConfigurationToLocalNodePage;

    @FindBy(xpath = "//h4[contains(text(),'Clone Configuration to LocalNode')]")
    private WebElement cloneConfigurationToLocalNodePage;

    @FindBy(xpath = "//label[contains(text(),'Plugin')]")
    private WebElement ddNameChangeToPlugin;

    @FindBy(xpath = "//h4[contains(text(),'Clone Credential')]")
    private WebElement cloneCredential;

    @FindBy(xpath = "//h4[contains(text(),'Edit Credential')]")
    private WebElement editCredential;

    @FindBy(xpath="//button[@id='type']")
    private List<WebElement> typeDDList;

    @FindBy(xpath="//button[@id='pluginName']")
    private List<WebElement> configurationPluginDDList;

    @FindBy(xpath = "//h4[contains(text(),'Clone Data Source')]")
    private WebElement cloneDataSource;

    @FindBy(xpath="//h4[contains(text(),'Edit Data Source')]")
    private WebElement editDataSource;

    @FindBy(xpath="//span[@class='float-left placeholder ng-star-inserted']")
    private WebElement placeHolderDD;

    @FindBy(xpath="//span[contains(text(),'All Catalogs')]")
    private WebElement changedName;

    @FindBy(xpath="//span[@class[contains(.,'asg-item-view-item-name text-truncate')]]")
    private WebElement itemViewPageTitle;

    @FindBy(xpath = "//a[@class][contains(.,'Overview')]//following::div[@class='asg-item-view-multi-properties-widget ng-untouched ng-pristine ng-valid ng-star-inserted']")
    private WebElement metadataContainer;

    @FindBy(css = "span[class='title text-capitalize position-relative font-weight-bold']>span")
    private WebElement rowCount;

    @FindBy(xpath = "//span[@class[contains(.,'manage-search')]]")
    private WebElement bundlesSearchButton;

    @FindBy(xpath = "//th[contains(.,'Plugins')]//following::tbody[1]/tr/td[1]/span")
    private List<WebElement> getExpandedPluginList;

    @FindBy(css = "span[class='manage-search-close mr-2 fa fa-close cursor-pointer']")
    private WebElement bundlesSearchExitButton;

    @FindBy(xpath = "//div[@class='asg-manage-container'][1]//div[contains(.,'Add and delete bundles.') and contains(.,'Add and delete bundles.')][1]")
    private WebElement manageBundlesTitleAndDesc;

    @FindBy(xpath = "//button[contains(.,'CANCEL')]")
    private WebElement bundlesCancelButton;

    @FindBy(xpath = "//div[@class='modal-content']//button[@type='button']/span")
    private WebElement popUpXButton;

    @FindBy(xpath = "//button[contains(.,'DELETE')]")
    private WebElement bundlesPopupDeleteButton;

    @FindBy(xpath = "//button[@class[contains(.,'btn asg-btn-confirm-primary float-right')]]")
    private WebElement cancelButtonInPopUp;

    @FindBy(xpath = "//div[@class='asg-item-view-tabs']/ul/li/a")
    private List<WebElement> manageAccessTab;

    @FindBy(css = "span[class='actions float-right']>span[class='fa fa-plus-square cursor-pointer add-user']")
    private WebElement addLocalUserButton;

    @FindBy(css = "p[class='content-wrapper text-center mx-auto']")
    private WebElement contextualMessage;

    @FindBy(xpath = "//div[@class='list-caption']")
    private List<WebElement> detailsAttributes;

    @FindBy(xpath = "//span[contains(.,'Sequence Number')]//following::tbody/tr/td[4]")
    private List<WebElement> SequenceNumberOrder;

    @FindBy(css = "span[class='fa fa-plus-square cursor-pointer nav-icon']")
    private WebElement addPluginConfigButton;

    @FindBy(xpath = "//div[@class[contains(.,'capture-new-data')]]/div/span[2]")
    private WebElement captureNewData;

    @FindBy(xpath = "//span[contains(text(),'Assign existing configuration')]")
    private WebElement assignExistingConfiguration;

    @FindBy(xpath = "//a[@class[contains(.,'nav-link active')]]['Data']//following::div[@class[contains(.,'tagged-row')]]/div[2][@class[contains(.,'inner-details')]]")
    private WebElement dataElementwidget;

    @FindBy(xpath = "//a[@class[contains(.,'nav-link active')]]['Data']//following::div[@class[contains(.,'tagged-row')]]/div[2][@class[contains(.,'inner-details')]]")
    private WebElement catalogedPluginlabels;

    @FindBy(xpath = "//span[@class='fa fa-plus-square']")
    private WebElement addDataSourceButton;

    @FindBy(xpath = "//span[@class='fa fa-plus-square']")
    private WebElement addCredentialButton;

    @FindBy(xpath = "//span[@class[contains(.,'rating-caption')]][contains(.,'Average')]//preceding::span[@class[contains(.,'rating-caption')]][contains(.,'Your Rating')]")
    private WebElement yourRatingOrder;

    @FindBy(xpath = "(//div[@class[contains(.,'asg-search-list-item-fixed d-flex flex-wrap text-truncate')]])[1]/span/span[1]")
    private List<WebElement> catalogValueInSearchResults;

    @FindBy(xpath = "//div[@class[contains(.,'item-list-total-number')]]/div[contains(.,'Select all')]")
    private WebElement selectAllLabel;

    @FindBy(xpath = "//div[@class[contains(.,'cursor-pointer show-selected')]][contains(.,'selected items only')]")
    private WebElement selectedItemsOnlyLabel;

    @FindBy(xpath = "//div[@class[contains(.,'recent-search-btns d-flex align-items-center')]]/button[contains(.,'Assign/Unassign Tags')]")
    private WebElement assignUnassignTags;

    @FindBy(css="li[title='Manage Data Sources']")
    private WebElement manageDataSource;

    @FindBy(xpath = "//li[@title='Manage Data Sources']//a[contains(@class,'active')]")
    private WebElement manageDataSourceActive;

    @FindBy(css = "li[title='Manage Credentials']")
    private WebElement manageCredentials;

    @FindBy(css="li[title='Manage Configurations']")
    private WebElement manageDataConfig;

    @FindBy(xpath = "//ul[@class='list-menu dropdown-menu show']//li[@class[contains(.,'dropdown-item')]]/a")
    private List<WebElement> BAMultiTabSubmenuAsList;

    @FindBy(xpath = "//label[contains(.,' EDI subject area access roles')]/following::div[contains(.,'+Add')]")
    private WebElement addEDIRolesnInManageDataSourcePage;

    @FindBy(xpath = "//label[contains(.,'role')]/following::button[contains(.,'ADD')]")
    private WebElement addRoleBtnInManageDataSourcePage;

    @FindBy(xpath = "//span[contains(@class,'hide-default-toggle cursor-pointer select-none dropdown-toggle active')]")
    private WebElement profileIconActive;

    @FindBy(xpath = "//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'far fa-download')]]")
    private WebElement captureAndImportData;

    @FindBy(xpath = "//span[@class[contains(.,'fa-analytics')]]")
    private WebElement dataScienceAndAnalytics;

    @FindBy(xpath = "//div[@class='page-title-wrapper']")
    private WebElement pageTitle;

    public WebElement getXpathWithDynamicValue(String pageNo) {
        String finalDynamicXpath = xpathWithDynamicValue.replace("$DYN$", String.valueOf(pageNo));
        return driver.findElement(By.xpath(finalDynamicXpath));
    }

    public WebElement getWebTableWithDynamicValue(String tableName){
        String finalDynamicTableValue=xpathWithDynamicTableValue.replace("$DYN$",String.valueOf(tableName));
        return driver.findElement(By.xpath(finalDynamicTableValue));
    }


    public WebElement getItemFullViewTable(String tableName){
        String finalDynamicTableValue=itemFullViewTable.replace("$DYN$",String.valueOf(tableName));
        return driver.findElement(By.xpath(finalDynamicTableValue));
    }

    public List<WebElement> getWebTableSize(String tableName){
        String finalDynamicTableValue=tableSize.replace("$DYN$",String.valueOf(tableName));
        return driver.findElements(By.xpath(finalDynamicTableValue));
    }

    public List<WebElement> getItemFullViewTableSize(String tableName){
        String finalDynamicTableValue=itemFullViewTableSize.replace("$DYN$",String.valueOf(tableName));
        return driver.findElements(By.xpath(finalDynamicTableValue));
    }

    public WebElement getDynamicSearchValue(String tableName,String trIndex, String tdIndex){
        String finalDynamicSearchValue=dynamicSearchValue.replace("$DYN$",String.valueOf(tableName));
        finalDynamicSearchValue=finalDynamicSearchValue.replace("$NUM$",trIndex);
        finalDynamicSearchValue=finalDynamicSearchValue.replace("$TDNUM$",tdIndex);
        return driver.findElement(By.xpath(finalDynamicSearchValue));
    }

    public WebElement getItemFullViewSearchValue(String tableName,String trIndex, String tdIndex){
        String finalDynamicSearchValue=itemFullViewSearchValue.replace("$DYN$",String.valueOf(tableName));
        finalDynamicSearchValue=finalDynamicSearchValue.replace("$NUM$",trIndex);
        finalDynamicSearchValue=finalDynamicSearchValue.replace("$TDNUM$",tdIndex);
        return driver.findElement(By.xpath(finalDynamicSearchValue));
    }

    public List<WebElement> getPaginationListLength() {
        return paginationListLength;
    }


    @FindAll (@FindBy(how = How.XPATH, using ="//table[@class='table table-responsive table-condensed cf']/tbody/tr/td[2]/a"))
    private List<WebElement> resultsTable;

    @FindAll(@FindBy(how = How.XPATH, using="//p[contains(text(),'INPUT')]/../div/table/tbody/tr/td/span"))
    private List<WebElement> inputWebTable;

    @FindAll(@FindBy(how = How.XPATH, using="//p[contains(text(),'OUTPUT')]/../div/table/tbody/tr/td/span"))
    private List<WebElement> outputWebTable;

    @FindAll(@FindBy(how = How.XPATH, using="//p[contains(text(),'HAS_COLUMN')]/parent::*/div/table/tbody/tr/td[1]/span"))
    private List<WebElement> hasColumns;


    @FindBy(xpath = "//table[@class='table table-responsive table-condensed cf']/tbody/tr/td[3]/span")
    private WebElement type_Cluster;

    public WebElement getType_Cluster() {
        return type_Cluster;
    }

    public List<WebElement> getInputWebTable() {
        return inputWebTable;
    }

    public List<WebElement> getOutputWebTable() {
        return outputWebTable;
    }

    public List<WebElement> getResultsTable() {
        return resultsTable;
    }

    public WebElement getClusterDemo() {
        return clusterDemo;
    }

    public WebElement getInputTable() {
        return inputTable;
    }

    public WebElement getQueryText() {
        return queryText;
    }

    public WebElement getTableNavigation() {
        return tableNavigation;
    }

    public List<WebElement> getHasColumns() {
        return hasColumns;
    }

    //@FindBy(xpath="//ul[@class='dashboard-content edit-mode'][1]//button[@class='btn btn-primary dropdown-toggle']")
    @FindBy(xpath="//ul[2]/li/div/div/button[@class='btn btn-primary']")
    private WebElement secondPagewidgetVerticalOptionButton;

    @FindBy(xpath="//div[@class[contains(.,'btn-group widget-menu show dropdown')]]//ul/li/a[contains(.,'Remove')]")
    private WebElement widgetRemoveOption;

    @FindBy(css=".btn.asg-modal-confirm-btn.pull-right")
    private WebElement confirmDeleteYesButton;

    @FindBy(css=".navbar-toggler")
    private WebElement navigationBarToggleButton;

    @FindBy(xpath="//b[contains(@title,'TestData')]")
    private WebElement testData;

    @FindBy(xpath="//div[@class='asg-new-notifications']//div[@class[contains(.,'clearfix')]][1]//button[contains(.,'Dismiss')]")
    private WebElement firstNotificationDismissButton;

    @FindBy(xpath="//div[@class='asg-new-notifications']//div[@class='clearfix'][1]//span[2]")
    private WebElement firstNotificationTimestamp;

    @FindBy(xpath="//a[contains(.,'CATALOG MANAGER')]/ancestor::div[@class='asg-base-widget-container']//div[@class='asg-base-widget-recent']//a")
    private List<WebElement> catalogManagerRecentLinksList;

    @FindBy(xpath="//b[contains(.,'EDIT CATALOG')]")
    private WebElement editCatalogPageTitle;

    public WebElement getTobeDragged() {
        return tobeDragged;
    }

    @FindBy(xpath = "//ul[@class='dashboard-content edit-mode']/li[@class='dashboard-widget-wraper']")
    private WebElement tobeDragged;

    public WebElement getTobeDraggedOnPage2() {
        return tobeDraggedOnPage2;
    }

    @FindBy(xpath = "//app-asg-dashboard/ul[2]/li")
    private WebElement tobeDraggedOnPage2;


    @FindBy (xpath = "//a[@class='asg-base-widget-title'][contains(text(),'BUNDLE MANAGER')]")
    private WebElement widget_BundleManager;

    @FindBy (xpath = "//a[contains(text(),'BUNDLE MANAGER')]/following::span[contains(text(),'Manage bundles here')]")
    private WebElement bundleManagerDefinition;

    @FindBy (xpath = "//a[contains(text(),'BUNDLE MANAGER')]/following::p[contains(text(),' Upload new and configure existing bundles ')]")
    private WebElement bundleManagerDescription;

    @FindBy (xpath = "//a[contains(text(),'BUNDLE MANAGER')]/following::div[contains(text(),'QUICK LINKS')]")
    private WebElement bundleManagerQuickLinks;

    @FindBy (xpath = "//a[contains(text(),'BUNDLE MANAGER')]/following::div[contains(text(),'RECENT')]")
    private WebElement bundleManagerRecent;

    @FindBy (xpath = "//a[contains(text(),'BUNDLE MANAGER')]/following::a[contains(text(), 'Upload new bundle')]")
    private WebElement bundleManagerUploadQuickLink;


    @FindBy (xpath = "//a[@class='asg-base-widget-title'][contains(text(),'BUNDLE MANAGER')]/following::div[@class='asg-base-widget-recent-item'][1]/a")
    private WebElement bundleManagerRecentFirstLink;

    @FindBy (partialLinkText = "collector/GitCollector/GitCollector")
    private WebElement catalogRecentFirstLink;

    @FindBy (xpath = "//li[@class[contains(.,'dashboard-widget-wraper')]]/div[@class[contains(.,'welcome-widget')]]")
    private WebElement dashboardWidget;

    @FindBy (css = "li[class='dashboard-widget-wraper']")
    private List<WebElement> quickstartPageWidget;

    @FindBy (css = "ul[class='nav nav-tabs item-view-categories']")
    private WebElement tabHeightInItenFullView;

    @FindBy (css = "i[@class='asg-catalog-widget-delete-quicklink fa fa-trash pull-right']")
    private WebElement widgetDeleteButton;

    @FindBy (css = "div[class='asg-panels-item-dynamic']")
    private List<WebElement> totalPanelDisplayed;

    @FindBy (xpath = "//ul[@class[contains(.,'nav nav-tabs item-view-categories')]]/li/a")
    private List<WebElement> itemFullViewTabs;

    @FindBy(css="span[class='fa fa-times searchIcon']")
    private List<WebElement> searchIcon;

    @FindBy(xpath="//div[@class[contains(.,'asg-panels-item-dynamic-caption')]]//following::i[@class='fa fa-compress']")
    private WebElement minimizeIcon;

    @FindBy(xpath = "//button[@class[contains(.,'btn asg-btn-confirm-secondary asg-btn-space-right')]]")
    private WebElement confirmDeleteButton;

    public WebElement getRunSearchListResults(String searchName) {
        return driver.findElement(By.xpath("//tr[contains(.,'"+searchName+"')]//following::td[@class[contains(.,'ng-star-inserted')]][1]"));
    }

    public WebElement getDeleteSearchListResults(String searchName) {
        return driver.findElement(By.xpath("//tr[contains(.,'"+searchName+"')]//following::span[@class[contains(.,'trash')]][1]"));
    }

    @FindBy(xpath = "//button[contains(.,'RUN')]")
    public WebElement runSearchResult;

    @FindBy(xpath = "//div[@class[contains(.,'ng-star-inserted')]]//following::button[contains(.,'DELETE')]")
    public WebElement deleteSavedSearchResult;

    @FindBy(xpath = "//button[@class='spinner-btn']")
    public WebElement BundleSaveButton;

    @FindBy(xpath = "//button[@class='spinner-btn'][contains(.,'SAVE')]")
    public WebElement manageTagSaveButton;

    @FindBy(xpath = "//button[@class[contains(.,'dropdown-item')]]//following::span[1]")
    public WebElement searchSuggestionText;

    @FindBy(xpath = "//button[@class[contains(.,'dropdown-item')]]//following::span[2]")
    public WebElement DataAssetBar;

    public WebElement getButtonpopup(String button) {
        return driver.findElement(By.xpath("//button[contains(text(),'"+ button +"')]"));
    }

    public WebElement getSimiliarwidget(String widgetName) {
        return driver.findElement(By.xpath("//span[contains(text(), '"+widgetName+"')]"));
    }

    public WebElement getMFVwidgetTable(String columnName) {
        return driver.findElement(By.xpath("//span[contains(text(), 'Most frequent values')]//following::span[@title='" + columnName + "']"));
    }

    @FindBy(css = "div[class='browse-button-container position-relative overflow-hidden d-inline-block mt-2 mb-3']")
    public WebElement Browsefiles;

    @FindBy(xpath = "//div[@class[contains(.,'drag-and-drop-container')]]")
    public WebElement DragAndDropFrame;

    @FindBy(css = "div[class='page-title-wrapper']")
    public WebElement pageTitleHeader;

    @FindBy(xpath = "//span[@class='dropdown-icon float-right']/em")
    private WebElement dashboardDropdown;

    @FindBy(xpath = "//ul[@class[contains(.,'dropdown-menu show')]]/li/a/span")
    private List<WebElement> dashboardList;

    @FindBy(xpath = "//div[@class='dashboard-grid-item-heading']/..")
    private List<WebElement> dashboardWidgetList;

    @FindBy(xpath = "//div[@class[contains(.,'active')]]//div/span[@class[contains(.,'pre-configured-widget')]]")
    private List<WebElement> selectWidgetList;

    @FindBy(xpath = "//em[@class[contains(.,'settings-icon fal fa-cog')]]")
    private WebElement dashboardSettingsIcon;

    @FindBy(css = "em[class='fal fa-times cursor-pointer text-right']")
    private WebElement selectWidgetPanelCloseButton;

    @FindBy(css = "input[placeholder='Enter dashboard name']")
    private WebElement dashboardNameTextbox;

    @FindBy(css = "input[placeholder='Enter name']")
    private WebElement testUserNameTextbox;

    @FindBy(css = "input[name='group']")
    private WebElement userOrGroupNameFieldTextBox;

    @FindBy(xpath = "//span[@class[contains(.,'fa fa-plus-square')]][1]//following::span[contains(.,'Add new rules')][2]")
    private WebElement addNewRulesButton;

    @FindBy(xpath = "//span[@class[contains(.,'cursor-pointer fa fa-plus-square')]][1]")
    private WebElement addNewPolicyButton;

    @FindBy(xpath = "//div[@class[contains(.,'table-row-border')]]//following::form")
    private WebElement addNewRuleForm;

    @FindBy(xpath = "//div[@class[contains(.,'flex-row d-flex align-items-center border-bottom')]]/div/span[2]")
    private List<WebElement> predefinedTypeForRule;

    @FindBy(xpath = "//div[@class[contains(.,'flex-column table-row-border')]]//div[@class[contains(.,'flex justify-content-between')]]/*[1]")
    private List<WebElement> predefinedTypeForRuleFactors;

    @FindBy(xpath = "//span[@class[contains(.,'far fa-save')]]")
    private WebElement ruleFormSaveButton;

    @FindBy(xpath = "//span[@class[contains(.,'far fa-times')]]")
    private WebElement factorDeleteButton;

    @FindBy(xpath = "//div[@class[contains(.,'inline-flex justify-content-between')]]")
    private List<WebElement> factorRowUnderRuleForm;

    @FindBy(xpath = "//span[@class[contains(.,'far fa-trash-alt')]]")
    private WebElement ruleDeleteButton;

    @FindBy(xpath = "//th[@class[contains(.,'text-truncate')]]/span[@title]")
    private List<WebElement> tableColumnNameList;

    @FindBy(xpath = "//th[@class[contains(.,'text-nowrap')]]/div/span ")
    private List<WebElement> BAWidgetColumnNameList;

    @FindBy(xpath = "//span[@title='Name']//following::td[@class[contains(.,'text-truncate align-middle')]][1]")
    private WebElement nameColumnValue;

    @FindBy(xpath = "//span[@title='Imported Itemtype']//following::td[@class[contains(.,'text-truncate align-middle')]][2]")
    private WebElement itemTypeColumnValue;

    @FindBy(xpath = "//input[@placeholder='Enter title']")
    private WebElement widgetTitleTextbox;

    @FindBy(xpath = "//input[@placeholder='Enter description']")
    private WebElement widgetDescriptionTextbox;

    @FindBy(xpath = "//div[contains(@class,'dashboard-widget-right-content')]//following::div[text()]")
    private WebElement widgetFieldErrorMessage;

    @FindBy(css = "input[formcontrolname='fileName']")
    private WebElement excelImporterNameTextbox;

    @FindBy(xpath = "//em[@title='Save Dashboard']")
    private WebElement dashboardConfigSaveButton;

    @FindBy(xpath = "//div[@class[contains(.,'dashboard-widget-right-content')]]")
    private WebElement configDashboardWidgetPanel;

    @FindBy(xpath = "//th[@class[contains(.,'text-nowrap')]]/div[1]/span[1]")
    private WebElement tableWidgetSortIcon;

    @FindBy(xpath = "//span[contains(.,'Name')]//following::tbody/tr/td[1]")
    private List<WebElement> widgetColumnBAItems;


    @FindBy(xpath = "//strong[contains(., 'Trust Score')]//following::div[@class='asg-search-flat-list-widget ng-star-inserted']")
    private List<WebElement> getTrustScoreFacetslist;

    @FindBy(xpath = "//span[@class[contains(.,'cursor-pointer d-inline-flex align-items-center')]]//span")
    private WebElement addCategoryButton;

    @FindBy(xpath = "//span[contains(.,'PII')]//following::span[@class[contains(.,'far fa-plus')]][1]")
    private WebElement addPIICategoryButton;

    @FindBy(xpath = "//button[@class[contains(.,'icon-holder')]]")
    private WebElement iconHolder;

    @FindBy(css = "input[formcontrolname='isProtected']")
    private WebElement protectedCheckbox;

    @FindBy(xpath = "//button[@class='spinner-btn'][contains(.,'SAVE')]")
    private WebElement addCategorySaveButton;

    @FindBy(xpath = "//button[@class='spinner-btn'][contains(.,'APPLY')]")
    private WebElement addCategoryApplyButton;

    @FindBy(xpath = "//a[@class='cancel-btn'][contains(.,'Cancel')]")
    private WebElement addCategoryCancelButton;

    @FindBy(xpath = "//div[@class[contains(.,'configuration-btns')]]//a[@class='cancel-btn'][contains(.,'Cancel')]")
    private WebElement categoryPopupCancelButton;

    @FindBy(xpath = "//span[@class[contains(.,'add-text cursor-pointer')]]//span")
    private WebElement addRoleButton;

    @FindBy(xpath = "//*[@class='color-palette']")
    private WebElement colorPalette;

    @FindBy(xpath="//td[1]//span[@class='select-none']")
    private List<WebElement> permissionsList;

    @FindBy(css = "canvas[class='color-slider']")
    private WebElement selectColorIcon;

    @FindBy(xpath = "//div[@class[contains(.,'input-wrapper')]]/div")
    private WebElement selectedColor;

    @FindBy(xpath="//div[@class[contains(.,'tag-row border-tag')]]/span[1]")
    private List<WebElement> manageTagsList;

    @FindBy(xpath = "//div[@class[contains(.,'error text-left')]]")
    private WebElement trustPolicyPageValidationMessage;

    @FindBy(xpath = "//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'Tags')]//following::input[1]")
    private WebElement taggingPolicyTagTextbox;

    @FindBy(xpath = "//div[@class[contains(.,'c-grey')]][contains(.,'Technologies')]//following::input[1]")
    private WebElement taggingPolicyTechnologiesTextbox;

    @FindBy(xpath = "//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'Data Pattern')]//following::textarea")
    private WebElement taggingPolicyDataPatternTextbox;

    @FindBy(xpath = "//div[@class[contains(.,'flex-column table-row-border')]]")
    private WebElement tagRuleForm;

    @FindBy(xpath = "//div[@class[contains(.,'flex-column table-row-border')]]//div[@class[contains(.,'flex justify-content-between')]]/div")
    private List<WebElement> trustPolicyLabels;

    @FindBy(xpath = "//*[@class[contains(.,'asg-dyn-form-property-label')]]")
    private List<WebElement> taggingPolicyLabels;

    @FindBy(xpath = "//div[@class[contains(.,'data-container dropdown-menu')]]//following::p")
    private List<WebElement> excelImportScopeAttributeValues;

    @FindBy(xpath = "//td[@class[contains(.,'form-group text-left border-right')]]/div[contains(.,'Cluster')]//following::div[@class[contains(.,'drop-down form-field-element')]]")
    private WebElement excelImportScopeAttributeTextBox;

    @FindBy(xpath = "//em[@class[contains(.,'fal fa-bell')]]/span")
    private WebElement notificationBellIcon;

    @FindBy(css = "div[class='notifications']")
    private WebElement notificationpage;

    @FindBy (xpath="//div[@class='notifications']//div[@class='left-panel']/div[3]/div[@class[contains(.,'notification')]]")
    private List<WebElement> notificationList;

    @FindBy (xpath="//div[@class='notifications']//div[@class='left-panel']/div[3]/div[@class[contains(.,'notification')]]/div//div[@class[contains(.,'mark-as-read rounded-circle')]]")
    private List<WebElement> blueCircleIconInNotification;

    @FindBy (xpath="//div[@class='notifications']//div[@class='left-panel']/div[3]/div[@class[contains(.,'notification')]][1]/div//div[@class[contains(.,'mark-as-read rounded-circle')]]")
    private List<WebElement> firstblueCircleIconInNotification;

    @FindBy (xpath="//div[@class[contains(.,'notification-dropdown')]]/button/div/span[1]")
    private List<WebElement> notificationFilterLabels;

    @FindBy(xpath = "(//div[@class[contains(.,'notification-dropdown')]])[3]")
    private WebElement markAsReadDropDown;

    @FindBy(xpath = "//div[@class='notifications']//div[@class='left-panel']/div[3]/div[@class[contains(.,'noti-border-top active')]][1]")
    private WebElement activeGreenLabelForNotification;

    @FindBy(css = "div[class='title font-weight-bold']")
    private WebElement notificationTitle;

    @FindBy(xpath = "//div[@class[contains(.,'right-panel')]]/div/div[@class[contains(.,'content')]]")
    private WebElement notificationContent;

    @FindBy(xpath = "//div[@class='notifications']//div[@class='left-panel']/div[3]/div[@class[contains(.,'notification')]][1]")
    private WebElement openAreaLinksInNotifications;

    @FindBy(xpath = "//div[@class[contains(.,'link text-center')]]/a")
    private WebElement businessApplicationLinkInContent;

    @FindBy(xpath = "//div[@class[contains(.,'default-msg')]]/div[contains(.,'Select an item to read')]")
    private WebElement notifcationDefaultContent;

    @FindBy(xpath = "(//button[@class[contains(.,'form-control hide-default-toggle dropdown-toggle')]])[3]")
    private WebElement markAsReadDropdownButton;

    @FindBy(xpath = "//label[contains(.,'Color')]/following::div[@class[contains(.,'rounded-circle color-indicator')]]")
    private WebElement colorIconInAddCategory;

    @FindBy(css = "input[id='color']")
    private WebElement colorTextBoxInAddCategory;

    @FindBy(xpath = "//a[@class='cancel-btn'][contains(.,'Cancel')]")
    private WebElement popupCancelButton;

    @FindBy(xpath = "//div[@class='d-flex flex-column flex-fill']//following::label[contains(.,'Data Pattern')]//following::textarea")
    private List<WebElement> dataPatternInTaggingPolicy;

    @FindBy(xpath = "//span[@class[contains(.,'far fa-times cursor-pointer')]]")
    private List<WebElement> policyDeleteInTaggingPolicy;

    @FindBy(xpath = "//em[@class[contains(.,'far link fa-ellipsis')]]")
    private WebElement searchResultsShowMoreIcon;

    @FindBy(xpath = "//em[@class[contains(.,'far link fa-ellipsis')]]")
    private WebElement adminIcon;

    @FindBy(xpath = "//span[contains(text(),'General')]//span[2][text()='[Default]']")
    private WebElement defaultTag;

    @FindBy(xpath = "//input[@name='isDefault']")
    private WebElement defaultTagCheckBox;

    @FindBy(xpath = "//input[@name='isProtected']")
    private WebElement protectedTagCheckBox;

    @FindBy(xpath = "//input[@id='color']")
    private WebElement selectColorTextBox;


    @FindBy(xpath = "//*[@class='color-slider']")
    private WebElement colorslider;

    @FindBy(xpath = "//*[contains(text(),'SAVE')]//following::a[@class='cancel-btn']")
    private WebElement manageTagsCancelButton;

    @FindBy(xpath = "//ul[contains(@class,'tag-search-result position-absolute')]/li")
    private List<WebElement> addConfigurationsTags;

    @FindBy(xpath = "//label[contains(text(),' Data Source')]//following::label[contains(text(),'Tags')]//following::div[@class='mr-1 tag-name text-truncate']")
    private List<WebElement> addConfigurationsDataSourceTags;

    @FindBy(xpath = "//span[@class='switch switch-small']")
    private WebElement taggingPolicyWholewordMatch;

    @FindBy(xpath = "//input[@name='isDefault']")
    private WebElement defaultCheckboxDisabled;

    @FindBy(xpath = "//span[@class[contains(.,'status-align')]]")
    private List<WebElement> licenseList;

    @FindBy(xpath = "//label[@class[contains(.,'asg-dyn-form-property-label')]]")
    private List<WebElement> licenseFieldList;

    @FindBy(xpath = "//div[@class='table']//th/span")
    private List<WebElement> auditTableHeaders;

    @FindBy(xpath = "//input[@name='isDefault' and @disabled]")
    private WebElement dashboardEllipsis;

    @FindBy(xpath = "//div[@class[contains(.,'tag-section border-tag-bottom')]]//div[@class[contains(.,'header-title')]]")
    private List<WebElement> rootTags;

    @FindBy(xpath = "//div[@data-placeholder]")
    private WebElement descriptionTextBoxInCreatePopup;

    @FindBy(xpath = "//div[@class[contains(.,'table-row')]]/div/span[2]/strong[1]")
    private List<WebElement> accessRequestsList;

    @FindBy(xpath = "//div[@class[contains(.,'cursor-pointer')]]/div[2][@class[contains(.,'content')]]/div[2]")
    private List<WebElement> notificationByContent;

    @FindBy(xpath = "//div[@class[contains(.,'link text-center')]]/a")
    private WebElement clickHereLinkInNotification;

    public DashBoardPage(WebDriver driver) {
        jsonRead =new JsonRead();
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intializing Dashboard PageFactory Class");
    }

    public WebElement imgCircleField() {
        return imgCircle;
    }

    public WebElement getsubjectAreaManagerLink() {
        return subjectAreaManager;
    }

    public WebElement getIngestionConfigurationField() {
        return ingestionConfiguration;
    }

    public WebElement getProfileSettingsButton() {
        return profileSettingsButton;
    }

    public WebElement getProfileSettingsTitle() {
        return profileSettingsTitle;
    }

    public WebElement getdetailsTab() {
        synchronizationVisibilityofElement(driver, detailsTab);
        return detailsTab;
    }

    public WebElement getpreferencesTab() {
        return preferencesTab;
    }

    public WebElement getprofileImage() {
        synchronizationVisibilityofElement(driver, profileImage);
        return profileImage;
    }

    public WebElement getprofileName() {
        return profileName;
    }

    public WebElement getprofileRole() {
        synchronizationVisibilityofElement(driver, profileRole);
        return profileRole;
    }

    public WebElement getnotificationsIcon() {
        return notificationsIcon;
    }


    public List<WebElement> getnewNotificationsList() {
        synchronizationVisibilityofElementsList(driver,newNotificationsList);
        return newNotificationsList;
    }

    public List<WebElement> getActiveUnreadNotificationList() {
        synchronizationVisibilityofElementsList(driver, activeUnreadNotificationsList);
        return activeUnreadNotificationsList;
    }

    public List<WebElement> getnewNotificationsContentList() {
        synchronizationVisibilityofElementsList(driver,notificationsContentList);
        return notificationsContentList;
    }


    public List<WebElement> getoldNotificationsList() {

        return oldNotificationsList;
    }

    public WebElement returnstructureLabelInStructurePage() {
        synchronizationVisibilityofElement(driver, structureLabelInSubjectAreaPage);
        return structureLabelInSubjectAreaPage;
    }

    public WebElement returnsubjectAreaTitleInStructurePage() {
        synchronizationVisibilityofElement(driver, subjectAreaTitleInStructurePage);
        return subjectAreaTitleInStructurePage;
    }

    public WebElement returnfirstNotificationsTimeStamp() {
        return notificationsTimeStamp.get(0);
    }

    public void click_markAllReadNotificationsButton() {
        synchronizationVisibilityofElement(driver, markAllReadNotificationsButton);
        clickOn(markAllReadNotificationsButton);
    }

    public void click_dismissAllNotificationsButton() {
        synchronizationVisibilityofElement(driver, dismissAllNotificationsButton);
        clickOn(dismissAllNotificationsButton);
    }

    public WebElement returncatalogHeading(){
        synchronizationVisibilityofElement(driver,catalogHeading);
        return catalogHeading;
    }


    public void Click_ingestionConfiguration() {

        scrollToWebElement(driver, ingestionConfiguration);
        clickOn(ingestionConfiguration);
    }

    public void Click_subjectAreaManager() {
        //synchronizationVisibilityofElement(driver,subjectAreaManager,10);
        scrollToWebElement(driver, subjectAreaManager);
        clickonWebElementwithJavaScript(driver,subjectAreaManager);
    }

    public List<WebElement> getSubjectAreaManagerLink() {
        return subjectAreaManagerLink;
    }

    public WebElement getWidgetManagerLink(String widgetName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//a[@class='asg-base-widget-title'][contains(.,'"+widgetName+"')]")));
        return driver.findElement(By.xpath("//a[@class='asg-base-widget-title'][contains(.,'"+widgetName+"')]"));
    }
    public WebElement getLicenseChartUsage(String WidgetName,int index){
        return driver.findElement(By.xpath("(//div[@class[contains(.,'dashboard-grid-item')]][contains(.,'"+WidgetName+"')]//following::*[name()='rect'])["+index+"]"));
    }
    public void Click_profileSettingsButton() {

        synchronizationVisibilityofElement(driver, profileSettingsButton);
        clickonWebElementwithJavaScript(driver, profileSettingsButton);
    }

    public void Click_profileExitButton() {

        synchronizationVisibilityofElement(driver, profileExitButton);
        clickonWebElementwithJavaScript(driver, profileExitButton);
    }


    public void Click_profileLogoutButton() {
        synchronizationVisibilityofElement(driver, profileIcon);
        clickonWebElementwithJavaScript(driver,profileIcon);
        synchronizationVisibilityofElement(driver, profileLogoutButton);
        clickonWebElementwithJavaScript(driver,profileLogoutButton);
    }

    public WebElement Click_notificationsIcon() {

        synchronizationVisibilityofElement(driver, notificationsIcon);
        return notificationsIcon;
    }

    public WebElement returnNotificationLabel() {

        //AngularPageWait(driver);
        synchronizationVisibilityofElement(driver, NotificationsTitleLabel);
        return NotificationsTitleLabel;
    }

    public void Click_asgNews_WelcomeWidget() {
        synchronizationVisibilityofElement(driver, asgNewsWelcomeWidget);
        clickOn(asgNewsWelcomeWidget);
    }

    public void Click_asgDocumentation_WelcomeWidget() {
        synchronizationVisibilityofElement(driver, asgDocumentationPage);
        clickOn(asgDocumentationPage);
    }

    public WebElement getHomeButton() {
        synchronizationVisibilityofElement(driver,homeButton);
        return homeButton;
    }

    public WebElement getIngestionStartNotification() {
        return ingestionStartNotification;
    }

    public WebElement getIngestionSuccessNotification() {
        return ingestionSuccessNotification;
    }

    public WebElement getWidget_IngestionConfiguration() {
        synchronizationVisibilityofElement(driver, ingestionConfiguration);
        return ingestionConfiguration;
    }

    public WebElement getWidget_IngestionDescription() {
        synchronizationVisibilityofElement(driver, Widget_IngestionDescription);
        return Widget_IngestionDescription;
    }

    public WebElement getWidget_IngestionImageIcon() {
        synchronizationVisibilityofElement(driver, WidgetIgestionConfigImageIcon);
        return WidgetIgestionConfigImageIcon;
    }

    public WebElement getWidget_IngestionDefinition() {
        synchronizationVisibilityofElement(driver, Widget_IngestionConfigDefinition);
        return Widget_IngestionConfigDefinition;
    }

    public WebElement getWidget_IngestionQuickLinks() {
        synchronizationVisibilityofElement(driver, Widget_IngestionQuickLinks);
        return Widget_IngestionQuickLinks;
    }

    public WebElement getWidget_IngestionRecentLabel() {
        synchronizationVisibilityofElement(driver, Widget_IngestionRecentLabel);
        return Widget_IngestionRecentLabel;
    }

    public WebElement getIngestionConfig_OpenManagement() {
        synchronizationVisibilityofElement(driver, IngestionConfig_OpenManagement);
        return IngestionConfig_OpenManagement;
    }

    public WebElement getIngestionConfig_OpenNewConfiguration() {
        synchronizationVisibilityofElement(driver, IngestionConfig_OpenNewConfiguration);
        return IngestionConfig_OpenNewConfiguration;
    }

    public WebElement getWidget_SubjectAreaManager() {
        synchronizationVisibilityofElement(driver, Widget_SubjectAreaManager);
        return Widget_SubjectAreaManager;
    }

    public WebElement getWelcomeWidgetQuickLinks() {
        synchronizationVisibilityofElement(driver, welcomeWidgetQuickLinks);
        return welcomeWidgetQuickLinks;
    }

    public WebElement getWelcomeWidgetDefinition() {
        scrollToWebElement(driver, welcomeWidgetDefinition);
        return welcomeWidgetDefinition;
    }


    public WebElement getWelcomeWidgetImage() {
        synchronizationVisibilityofElement(driver, welcomeWidgetImage);
        return welcomeWidgetImage;
    }

    public WebElement getWelcomeWidgetDescription() {
        synchronizationVisibilityofElement(driver, welcomeWidgetDescription);
        return welcomeWidgetDescription;
    }

    public WebElement getWelcomeWidgetTitle() {
        scrollToWebElement(driver, welcomeWidgetTitle);
        return welcomeWidgetTitle;
    }

    public WebElement getSubjectAreaManager_Description() {
        synchronizationVisibilityofElement(driver, SubjectAreaManager_Description);
        return SubjectAreaManager_Description;
    }

    public WebElement getSubjectAreaManager_Icon() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagerIcon);
        return SubjectAreaManagerIcon;
    }


    public WebElement getDashboradButton() {
        synchronizationVisibilityofElement(driver, DashboardButton);
        return DashboardButton;
    }

    public WebElement getSubjectAreaManager_Definition() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagerDefinition);
        return SubjectAreaManagerDefinition;
    }

    public WebElement getSubjectAreaManager_QuickLink() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagerQuickLink);
        return SubjectAreaManagerQuickLink;
    }

    public WebElement getSubjectAreaManagerRecentLabel() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagerRecentLabel);
        return SubjectAreaManagerRecentLabel;
    }

    public WebElement getSubjectAreaManager_OpenManagement() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagerOpenManagement);
        return SubjectAreaManagerOpenManagement;
    }

    public WebElement getSubjectAreaManager_CreateNewArea() {
        synchronizationVisibilityofElement(driver, SubjectAreaManagerCreateNewArea);
        return SubjectAreaManagerCreateNewArea;
    }

    public void click_subjectAreaTitle() {
        scrollToWebElement(driver, subjectAreaTitle);
        clickonWebElementwithJavaScript(driver, subjectAreaTitle);
    }

    public WebElement getSubjectAreaTitle() {
        return subjectAreaTitle;
    }


    public WebElement getDashboard_PaginationFeature() {
        scrollToWebElement(driver, paginationFeature);
        String classValue = getAttributeValue(paginationFeature, "class");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "The Attribute value is:" + classValue);
        return paginationFeature;
    }

    public void Click_Dashboard_LastPage() {
        scrollToWebElement(driver, lastpage);
        clickonWebElementwithJavaScript(driver,lastpage);
    }

    public WebElement getLastPageValue_Dashboard() {
        synchronizationVisibilityofElement(driver, openMyTaskPagination);
        return openMyTaskPagination;
    }

    public void click_Dashboard_FirstPage() {
        synchronizationVisibilityofElement(driver, firstpage);
        clickOn(firstpage);
    }

    public WebElement get_subjectAreaTitle() {
        synchronizationVisibilityofElement(driver, subjectAreaTitle);
        return subjectAreaTitle;
    }

    public void click_editSubjectArea() {
        synchronizationVisibilityofElement(driver, editSubjectArea);
        //clickOn(editSubjectArea);
        clickonWebElementwithJavaScript(driver,editSubjectArea);
    }

    public void edit_SubjectAreaName(String value) {
        synchronizationVisibilityofElement(driver, editSubjectAreaName);
        enterText(editSubjectAreaName, value);
    }

    public void click_EditSubjectAreaSave() {
        synchronizationVisibilityofElement(driver, editSubjectAreaSave);
        clickOn(editSubjectAreaSave);
    }

    public void edit_SubjectAreaDescription(String value) {
        synchronizationVisibilityofElement(driver, editSubjectAreaDescription);
        enterText(editSubjectAreaDescription, value);
    }

    public WebElement get_subjectAreaDescription() {
        synchronizationVisibilityofElement(driver, subjectAreaDescription);
        return subjectAreaDescription;
    }

    public WebElement get_editSubjectAreaQuicklinks() {
        synchronizationVisibilityofElement(driver, editQuickLinksSubjectArea);
        return editQuickLinksSubjectArea;
    }

    public WebElement get_QuicklinksName() {
        synchronizationVisibilityofElement(driver, getQuickLinkName);
        return getQuickLinkName;
    }

    public WebElement get_SubjectAreaQuicklinksLabel() {
        synchronizationVisibilityofElement(driver, subjectAreaQuickLinkLabel);
        return subjectAreaQuickLinkLabel;
    }

    public WebElement get_SubjectAreaQuicklinksList() {
        synchronizationVisibilityofElement(driver, subjectAreaQuickLinkList);
        return subjectAreaQuickLinkList;
    }

    public WebElement get_SubjectAreaRecentList() {
        synchronizationVisibilityofElement(driver, subjectAreaRecentList);
        return subjectAreaRecentList;
    }

    public WebElement get_SubjectAreaRecentLabel() {
        synchronizationVisibilityofElement(driver, subjectAreaRecentLabel);
        return subjectAreaRecentLabel;
    }

    public void click_SubjectAreaSearchButton() {
        synchronizationVisibilityofElement(driver, subjectAreaSearchIcon);
        clickOn(subjectAreaSearchIcon);
    }

    public void enter_SubjectAreaSearchText(String value) {
        synchronizationVisibilityofElement(driver, subjectAreaSearchText);
        enterText(subjectAreaSearchText, value);
    }

    public void click_SubjectAreaSearch() {
        synchronizationVisibilityofElement(driver, subjectAreaSearch);
        clickOn(subjectAreaSearch);
    }

    public void click_dashboardAddButton() {
        synchronizationVisibilityofElement(driver, dashboard_AddButton);
        // System.out.println(dashboard_AddButton.getText());
        clickOn(dashboard_AddButton);

    }

    public WebElement getdashboard_AddButton() {
        synchronizationVisibilityofElement(driver, dashboard_AddButton);
        return dashboard_AddButton;
    }

    public void enter_NewDashboardName(String value) {
        synchronizationVisibilityofElement(driver, dashboard_NewName);
        enterText(dashboard_NewName, value);
    }

    public void click_dashboardSaveButton() {
        //synchronizationVisibilityofElement(driver, dashboard_SaveButton);
        clickOn(dashboard_SaveButton);
    }

    public WebElement getdashboardSaveButton() {
        synchronizationVisibilityofElement(driver, dashboard_SaveButton);
        return dashboard_SaveButton;
    }

    public void click_DashboardEditbutton() {
        synchronizationVisibilityofElement(driver, dashboard_EditButton);
        clickOn(dashboard_EditButton);
    }

    public WebElement getDashboardEditbutton() {
        synchronizationVisibilityofElement(driver, dashboard_EditButton);
        return dashboard_EditButton;
    }

    public WebElement getDashboardEditbutton_Edge() {
        synchronizationVisibilityofElement(driver, dashboard_EditButton_Edge);
        return dashboard_EditButton_Edge;
    }

    public void click_DashboardDeleteButton() {
        synchronizationVisibilityofElement(driver, dashboard_DeleteButton);
        clickOn(dashboard_DeleteButton);
    }

    public WebElement getDashboardDeleteButton() {
        synchronizationVisibilityofElement(driver, dashboard_DeleteButton);
        return dashboard_DeleteButton;
    }

    public WebElement returnNewDashboardName() {
        synchronizationVisibilityofElement(driver, dashboard_NewName);
        return dashboard_NewName;
    }

    public WebElement getcommentsNotification() {
        synchronizationVisibilityofElement(driver, commentsNotification);
        return commentsNotification;
    }

    public void click_dashboardActiveTab() {

        synchronizationVisibilityofElement(driver, dashboardActiveTab);
        //clickOn(dashboardActiveTab);
        sleepForSec(1000);
        clickonWebElementwithJavaScript(driver, dashboardActiveTab);


    }

    public void WidgetDragAndDrop() {

        synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getElementToBeDragged());
        mouseDragAndDrop(driver, new DashBoardPage(driver).getElementToBeDragged(), new DashBoardPage(driver).getPlaceToBeDropped());
        implicit_wait(driver, 5000);
    }

    public void click_dropdownToggleDashboard() {
        synchronizationVisibilityofElement(driver, bigDataDropdownToggle_dashboard);
        clickOn(bigDataDropdownToggle_dashboard);
    }

    public WebElement getwidgetSideMenu() {
        synchronizationVisibilityofElement(driver, widgetSideMenu);
        return widgetSideMenu;
    }

    public void click_removeButton_dashboard() {
        synchronizationVisibilityofElement(driver, removeButton_dashboard);
        clickOn(removeButton_dashboard);
    }

    public WebElement getElementToBeDragged() {
        synchronizationVisibilityofElement(driver, elementToBeDragged);
        return elementToBeDragged;
    }

    public WebElement getPlaceToBeDropped() {
        synchronizationVisibilityofElement(driver, placeToBeDropped);
        return placeToBeDropped;
    }

    public void click_EditDashboardPlusButton() {
        synchronizationVisibilityofElement(driver, editDashboardPlusButton);
        clickOn(editDashboardPlusButton);
    }

    public WebElement getNewDashboard() {
        synchronizationVisibilityofElement(driver, newDashboard);
        return (newDashboard);
    }

    public WebElement returngetTopSearchIcon() {
        synchronizationVisibilityofElement(driver, getTopSearchIcon);
        return getTopSearchIcon;
    }

    public WebElement getFirstItemCheckbox() {
        synchronizationVisibilityofElement(driver, firstItemCheckbox);
        return firstItemCheckbox;
    }

    public WebElement returnbigDataWidgetEditbutton() {
        synchronizationVisibilityofElement(driver, bigDataWidgetEditbutton);
        return bigDataWidgetEditbutton;
    }

    public List<WebElement> returnquicklinkDropdown1() {

        return quicklinkDropdown1;
    }

    public WebElement retrunquicklinkDropdownOne() {
        synchronizationVisibilityofElement(driver, quicklinkDropdownOne);
        return quicklinkDropdownOne;
    }

    public WebElement returnbigDataWidgetfirstQuicklink() {
        synchronizationVisibilityofElement(driver, bigDataWidgetfirstQuicklink);
        return bigDataWidgetfirstQuicklink;
    }

    public WebElement returnWidgetSaveButton() {
        synchronizationVisibilityofElement(driver, WidgetSaveButton);
        return WidgetSaveButton;
    }

    public WebElement returnquicklinkFirstDropdown(){
        synchronizationVisibilityofElement(driver,quicklinkFirstDropdown);
        return  quicklinkFirstDropdown;
    }

    public WebElement returnQuickLinkFirtDropDownList(){
        synchronizationVisibilityofElement(driver,quickLinkFirtDropDownList);
        return  quickLinkFirtDropDownList;
    }
    public WebElement returnquickLink(){
        synchronizationVisibilityofElement(driver,Quicklink);
        return Quicklink;
    }

    public WebElement returnquickLinkDropdown(){
        synchronizationVisibilityofElement(driver,QuickLinkDropDown);
        return QuickLinkDropDown;
    }

    public WebElement returnsearchWidget(){
        synchronizationVisibilityofElement(driver,searchWidget);
        return searchWidget;
    }

    public WebElement returnmultiWidgetQuicklink(){
        synchronizationVisibilityofElement(driver,multiWidgetQuicklink);
        return multiWidgetQuicklink;
    }

    public WebElement returnsearchCatalogWidgetEdit(){
        synchronizationVisibilityofElement(driver,searchCatalogWidgetEdit);
        return searchCatalogWidgetEdit;
    }

    public List<WebElement> returnquicklinkList(){
        //synchronizationVisibilityofElement(driver,quicklinkList);
        return quicklinkList;
    }

    public WebElement returnfirstwidegtquicklinkone(){
        synchronizationVisibilityofElement(driver,firstwidegtquicklinkone);
        return firstwidegtquicklinkone;
    }

    public WebElement returnsecondWidgetFirstlink(){
        synchronizationVisibilityofElement(driver,secondWidgetFirstlink);
        return secondWidgetFirstlink;
    }

    public WebElement returnsolrCheckbox(){
        synchronizationVisibilityofElement(driver,solrCheckbox);
        return solrCheckbox;
    }

    public WebElement returnFirstQuicklink(){
        synchronizationVisibilityofElement(driver,FirstQuicklink);
        return FirstQuicklink;
    }

    public WebElement returnemptyLink(){
        synchronizationVisibilityofElement(driver,emptyLink);
        return emptyLink;
    }
    public WebElement returnAdvanceSlorLabel(){
        return advanceSlorLabel;
    }
    public void enterTextToTopSearchBox(String text){
        topSearchBox.clear();
        topSearchBox.sendKeys(text);
        topSearchBox.sendKeys(Keys.ENTER);
    }

    public WebElement returnItemCreatedList() {
        synchronizationVisibilityofElement(driver,itemResponseId);
        return itemResponseId;
    }

    public WebElement returndashboardActiveTab(){
        return dashboardActiveTab;
    }

    public void Click_administrationDashboard() {
        synchronizationVisibilityofElement(driver,administrationDashboard );
        clickonWebElementwithJavaScript(driver, administrationDashboard);

    }

    public WebElement returnAdministration(){
        return administrationDashboard;
    }

    public WebElement returnItemViewManagement(){
        synchronizationVisibilityofElement(driver,itemViewManagement );
        return itemViewManagement;
    }

    public void Click_editWidgetDashboard() {
        synchronizationVisibilityofElement(driver,editWidgetPencil );
        clickonWebElementwithJavaScript(driver, editWidgetPencil);

    }

    public void Click_editWidgetDashboard_chrome() {
        synchronizationVisibilityofElement(driver,editWidgetPencil );
        clickOn( editWidgetPencil);

    }

    public WebElement returnWidgetDescription(){
        synchronizationVisibilityofElement(driver,widgetDescription);
        return widgetDescription;
    }

    public WebElement returnDescriptionPara(){
        synchronizationVisibilityofElement(driver,descriptionPara);
        return descriptionPara;
    }

    public WebElement returnwarningButton(){
        synchronizationVisibilityofElement(driver,warningButton);
        return warningButton;
    }

    public List<WebElement> returnserachCatalogDropdownList() {
        synchronizationVisibilityofElementsList(driver, serachCatalogDropdownList);
        return serachCatalogDropdownList;
    }

    public WebElement getsearchWidgetBox(){
        synchronizationVisibilityofElement(driver,searchWidgetBox);
        return searchWidgetBox;
    }

    public WebElement getquickStartDashboard(){
        synchronizationVisibilityofElement(driver,quickStartDashboard);
        return quickStartDashboard;
    }

    public List<WebElement> geticonCaptionsList() {
        synchronizationVisibilityofElementsList(driver, iconCaptionsList);
        return iconCaptionsList;
    }

    public WebElement getplusButton(){
        sleepForSec(1000);
        synchronizationVisibilityofElement(driver,plusButton);
        return plusButton;
    }

    public boolean getplusButtonStatus(){
        sleepForSec(1000);
        Boolean status = isElementPresent(plusButton);
        return status;
    }

    public WebElement getDynamicElementToBeDragged(String arg) {
        WebElement element =driver.findElement(By.xpath("//span[contains(.,'"+arg+"')]"));
        synchronizationVisibilityofElement(driver, element);
        return element;
    }

    public WebElement getdropLocationForSecondPage(){
        synchronizationVisibilityofElement(driver,dropLocationForSecondPage);
        return dropLocationForSecondPage;
    }

    public List<WebElement> getpaginationOfDashboard() {
        synchronizationVisibilityofElementsList(driver, paginationOfDashboard);
        return paginationOfDashboard;
    }

    public WebElement getsecondPagewidgetVerticalOptionButton(String widgetName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-area-widget-ellipsis')]]/a[contains(text(),'"+widgetName+"')]//following::button[3]"));
//        synchronizationVisibilityofElement(driver, secondPagewidgetVerticalOptionButton);
//        return secondPagewidgetVerticalOptionButton;
    }

    public WebElement getwidgetRemoveOption() {
        synchronizationVisibilityofElement(driver, widgetRemoveOption);
        return widgetRemoveOption;
    }

    public List<WebElement> getpaginationOfDashboardWithoutSync() {
        return paginationOfDashboard;
    }

    public WebElement getconfirmDeleteYesButton() {
        synchronizationVisibilityofElement(driver, confirmDeleteYesButton);
        return confirmDeleteYesButton;
    }

    public List<WebElement> getNotificationsListCount(){
        synchronizationVisibilityofElementsList(driver, notificationListCount);
        return notificationListCount;
    }

    public WebElement getNotificationsCount(){
        synchronizationVisibilityofElement(driver, notificationCount);
        return notificationCount;
    }

    public void  clickDismissLink(){
        synchronizationVisibilityofElement(driver, dismissLink);
        clickOn(dismissLink);
    }

    public WebElement notificationDismissNo(){
        synchronizationVisibilityofElement(driver, dismissNotificationNo);
        return dismissNotificationNo;
    }
    public WebElement notificationDismissYes(){
        synchronizationVisibilityofElement(driver, dismissNotificationYes);
        return dismissNotificationYes;
    }


    public WebElement getnavigationBarToggleButton() {
        synchronizationVisibilityofElement(driver, navigationBarToggleButton);
        return navigationBarToggleButton;
    }

    public WebElement getremoveSearchTextButton() {
        synchronizationVisibilityofElement(driver, removeSearchTextButton);
        return removeSearchTextButton;
    }

    public WebElement getremoveSearchTextButtonWithoutSync() {
        return removeSearchTextButton;
    }

    public WebElement getfirstNotificationDismissButton() {
        synchronizationVisibilityofElement(driver, firstNotificationDismissButton);
        return firstNotificationDismissButton;
    }

    public WebElement getfirstNotificationTimestamp() {
        synchronizationVisibilityofElement(driver, firstNotificationTimestamp);
        return firstNotificationTimestamp;
    }

    public WebElement getfirstNotificationTimestampWithoutSync() {
        return firstNotificationTimestamp;
    }

    public List<WebElement> getcatalogManagerRecentLinksList() {
        synchronizationVisibilityofElementsList(driver, catalogManagerRecentLinksList);
        return catalogManagerRecentLinksList;
    }

    public WebElement geteditCatalogPageTitle() {
        synchronizationVisibilityofElement(driver, editCatalogPageTitle);
        return editCatalogPageTitle;
    }

    public WebElement getwelcomeWidgetSizeMenu(){
        synchronizationVisibilityofElement(driver,welcomeWidgetSizeMenu);
        return welcomeWidgetSizeMenu;
    }

    public WebElement getwidgetSizeOnebyTwo(){
        synchronizationVisibilityofElement(driver,widgetSizeOnebyTwo);
        return widgetSizeOnebyTwo;
    }

    public WebElement getwidgetsizeTwobyTwo(){
        synchronizationVisibilityofElement(driver,widgetsizeTwobyTwo);
        return widgetsizeTwobyTwo;
    }

    public WebElement getquicklinkSecondDropDown(){
        synchronizationVisibilityofElement(driver,quicklinkSecondDropDown);
        return quicklinkSecondDropDown;
    }

    public WebElement getWidget_BundleManager() {
        scrollToWebElement(driver, widget_BundleManager);
        return widget_BundleManager;
    }

    public WebElement getBundleManagerDefinition() {
        synchronizationVisibilityofElement(driver, bundleManagerDefinition);
        return bundleManagerDefinition;
    }

    public WebElement getBundleManagerDescription() {
        synchronizationVisibilityofElement(driver, bundleManagerDescription);
        return bundleManagerDescription;
    }

    public WebElement getBundleManagerQuickLinksLabel() {
        synchronizationVisibilityofElement(driver, bundleManagerQuickLinks);
        return bundleManagerQuickLinks;
    }

    public WebElement getBundleManagerRecentLabel() {
        synchronizationVisibilityofElement(driver, bundleManagerRecent);
        return bundleManagerRecent;
    }

    public void click_bundleManagerUploadQuickLink() {
        synchronizationVisibilityofElement(driver, bundleManagerUploadQuickLink);
        clickOn(bundleManagerUploadQuickLink);
    }

    public WebElement get_bundleManagerRecentFirstLink() {
        scrollToWebElement(driver, bundleManagerRecentFirstLink);
        return bundleManagerRecentFirstLink;
    }

    public WebElement clickDashBoardWidget(String widgetName) {
        return driver.findElement(By.xpath("//a[contains(.,'"+widgetName+"')]"));
    }

    public WebElement clickType(String typeName) {
        return driver.findElement(By.xpath("//div[@class='asg-checkbox-small']//input[@id='"+typeName+"']"));
    }

    public WebElement get_CatalogRecentLink() {
        synchronizationVisibilityofElement(driver, catalogRecentFirstLink);
        return catalogRecentFirstLink;
    }
    public WebElement returnWidgetEditButton(String widgetName){
        return driver.findElement(By.xpath("//div/div[@title='"+widgetName+"']/following::div[@class='asg-area-widget-top-btn-block']/button[2]/i"));
    }

    public WebElement returnQuickLink(String quickLinkName){
        return driver.findElement(By.xpath("//div[@class='dropdown show open']/ul/li/a/span[contains(.,'"+quickLinkName+"')]"));
    }

    public WebElement returnLinkElement(String linkName){
        return driver.findElement(By.xpath("//span[contains(.,'"+linkName+"')]"));
    }

    public WebElement getShowAllElement(String Name){
        return driver.findElement(By.xpath("//div[@class[contains(., 'link-section')]]/a[contains(., '"+Name+"')]"));
    }

    public WebElement getCompletenessWidget(){
        return driver.findElement(By.xpath("(//div[@class[contains(., 'completeness-widget-body')]]//following::span[@class[contains(., 'fa cursor-pointer fa-caret-down')]])[1]"));
    }

    public WebElement getCloseIcon(){
        return driver.findElement(By.xpath("(//div[@class[contains(., 'close-icon cursor-pointer')]]"));
    }

    public WebElement getWidgetCollapseIcon(){
        return driver.findElement(By.xpath("(//span[@class[contains(., 'fa-caret-down')]])[1]"));
    }

    public WebElement getWidgetExpandIcon(){
        return driver.findElement(By.xpath("(//span[@class[contains(., 'fa-caret-right')]])[1]"));
    }

    public WebElement getcompletenessWigdetName(String Name){
        return driver.findElement(By.xpath("//div[@class='details-body w-100']//div[@title='"+Name+"']"));
    }

    public WebElement getNoDataInfotext(String Name){
        return driver.findElement(By.xpath("//div[@class[contains(., 'widget-content')]][contains(., '"+Name+"')]"));
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

    public WebElement getDataModelItemTypesTable(String Name){
        return driver.findElement(By.xpath("//div[@class[contains(., 'header-title')]]/span[contains(., '"+Name+"')]"));
    }

    public WebElement getDataModelItemsCount(){
        return driver.findElement(By.xpath("//div[@class[contains(., 'header-title')]]//span[@class[contains(., 'count ng-star-inserted')]]"));
    }

    public WebElement returnActiveDashboard(){
        synchronizationVisibilityofElement(driver, dashboardActiveTab);
        return dashboardActiveTab;
    }

    public WebElement getAnalysisRunResult(String widget, String plugin) {
        return driver.findElement(By.xpath("//a[contains(.,'"+widget+"')]//following::a[contains(.,'Analysis: "+plugin+"')]"));
    }

    public WebElement returnDeleteButtonForQuicklink(String linkName){
        return driver.findElement(By.xpath("//div/button/span[contains(.,'"+linkName+"')]//following::i[@class[contains(.,'asg-catalog-widget-delete-quicklink fa fa-trash pull-right')]][1]"));
    }

    public WebElement returnblankLink(){
        synchronizationVisibilityofElement(driver,blankLink);
        return blankLink;
    }

    public WebElement returnWidgetDiscardButton(){
        synchronizationofElementTobeClickable(driver,WidgetDiscardButton);
        return WidgetDiscardButton;
    }

    public WebElement returnQuicklinkbutton(String widgetName) {
        return driver.findElement(By.xpath("//div/div[@title='" + widgetName + "']//following::div/button/span[@class='float-left'][1]"));
    }

    public WebElement returnquicklinkfromwidget(String linkName,String widgetName){
        return driver.findElement(By.xpath("//div/div/div[@title='"+widgetName+"']//following::div/a[contains(text(),'"+linkName+"')]"));
    }

    public WebElement returnquickLinkDeleteButton(){
        synchronizationVisibilityofElement(driver,quickLinkDeleteButton);
        return quickLinkDeleteButton;
    }

    public WebElement getDashboardWidget(){
        return dashboardWidget;
    }

    public boolean getDashboardWidgetStatus(){
        boolean status = isElementPresent(dashboardWidget);
        return status;
    }

    public WebElement getRootAndChildTagText(String childTag, String rootTag) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div[@title='"+childTag+"']//preceding::div[contains(.,'"+rootTag+"')][1]")));
        return driver.findElement(By.xpath("//div[@title='"+childTag+"']//preceding::div[contains(.,'"+rootTag+"')][1]"));
    }

    public WebElement getFullSizeIcon(){
        synchronizationVisibilityofElement(driver,fullSizeIcon);
        return fullSizeIcon;
    }

    public WebElement getFullSizeIcon_Edge(){
        return fullSizeIcon_Edge;
    }

    public WebElement getCompressIconButton(){
        return compressIconButton;
    }

    public WebElement getTabDisplayedAndActive(String tabName){
        return driver.findElement(By.xpath("//div[@class='itemview-detail-navbar full-size']/ul/li/a[contains(.,'"+tabName+"')]"));
    }

    public WebElement getItemLabelsWithContainer(String labelName){
        return driver.findElement(By.xpath("//p[contains(.,'"+labelName+"')]/following-sibling::div"));
    }

    public WebElement getTextInTagSection(){
        synchronizationVisibilityofElement(driver,tagSectionText);
        return tagSectionText;
    }

    public WebElement getItemFullViewTab(String tabName){
        return driver.findElement(By.xpath("//li[@role='presentation']//a[contains(.,'"+tabName+"')]"));
    }

    public WebElement getTabHeightInItemFullView(){
        synchronizationVisibilityofElement(driver,tabHeightInItenFullView);
        return tabHeightInItenFullView;
    }

    public int getTabHeight(){
        Dimension dim = getTabHeightInItemFullView().getSize();
        return dim.height;
    }


    public WebElement getWidgetDeleteButton(){
        return widgetDeleteButton;
    }

    public List<WebElement> getWidgetName(String widget){
        return driver.findElements(By.xpath("//li[@class[contains(.,'dashboard-widget-wraper')]]//a[contains(.,'"+widget+"')]"));
    }

    public List<WebElement> getQuickstartPageWidget() {
        return quickstartPageWidget;
    }

    public WebElement click_InformationIcon(){
        synchronizationVisibilityofElement(driver,informationIcon);
        return informationIcon;
    }

    public List<WebElement> getSubmenus(){
        return submenulist;
    }
    public WebElement getversion_Label(){
        synchronizationVisibilityofElement(driver,versionlabel);
        return versionlabel;

    }
    public WebElement getversionNumber(){
        synchronizationVisibilityofElement(driver,versionNumber);
        return versionNumber;

    }

    public WebElement getbuildLabel(){
        synchronizationVisibilityofElement(driver,buildLabel);
        return buildLabel;
    }

    public WebElement getbuildNumber(){
        synchronizationVisibilityofElement(driver,buildInformation);
        return buildInformation;
    }

    public WebElement getcopyrights(){
        synchronizationVisibilityofElement(driver,copyrights);
        return copyrights;
    }

    public void click_privacyplicy(){
        synchronizationVisibilityofElement(driver,privacy_policy);
        clickOn(privacy_policy);

    }
    public void click_OpenSourceDocument(){
        synchronizationVisibilityofElement(driver,openSourceDocuments);
        clickOn(openSourceDocuments);
    }

    public void click_AboutClose(){
        synchronizationVisibilityofElement(driver,about_Closebutton);
        clickOn(about_Closebutton);
    }

    public WebElement getAlertCloseButton(){
        synchronizationVisibilityofElement(driver,Alert_Closebutton);
        return Alert_Closebutton;
    }

    public void click_AlertCloseButton(){
        synchronizationVisibilityofElement(driver,Alert_Closebutton);
        clickOn(Alert_Closebutton);
    }

    public WebElement getProfileSettingsButton(String buttonName){
        return driver.findElement(By.xpath("//div[@class='save-button-block']/button[contains(.,'"+buttonName+"')]"));
    }

    public List<WebElement> getSearchDropDownList() {
        return searchDropdownList;
    }

    public WebElement returnDashboardLink(String dashboardName){
        return driver.findElement(By.xpath("//ul[@class='nav nav-tabs dashboard-tabs-panel']/li/a[contains(.,'"+dashboardName+"')]"));
    }

    public WebElement getShowAllButton(String buttonName){
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-show-more-facet')]]/button[contains(.,'"+buttonName+"')][1]"));
    }

    public List<WebElement> getShowAllButtonInDashboardPage(String buttonName) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'asg-show-more-facet')]]/button[contains(.,'"+buttonName+"')][1]"));
    }

    public List<WebElement> getAuditTableHeaders() {
        return auditTableHeaders;
    }

    public List<WebElement> catalogList() {
        synchronizationVisibilityofElementsList(driver, catalogList);
        return catalogList;
    }

    public boolean getShowAllButtonInDashboardPage() {
        boolean status = isElementPresent(ShowAll_facet_Button);
        return status;
    }

    public boolean getShowAllButtonForCatalogInDashboardPage() {
        boolean status = isElementPresent(ShowAll_facet_Button_Catalog);
        return status;
    }

    public WebElement getShowAllButtonIn_DashboardPage() {
        synchronizationVisibilityofElement(driver, ShowAll_facet_Button);
        return ShowAll_facet_Button;
    }

    public WebElement getShowAllButtonForCatalog() {
        synchronizationVisibilityofElement(driver, ShowAll_facet_Button_Catalog);
        return ShowAll_facet_Button_Catalog;
    }

    public List<WebElement> getTotalPanelDisplayed(){
        return totalPanelDisplayed;
    }
    public WebElement returnVerticalWidgetButton(String widgetName){
        return driver.findElement(By.xpath("//a[contains(text(),'"+widgetName+"')]//following::div[@class='btn-group widget-menu'][1]//button"));
    }

    public WebElement get_removeButton_dashboard() {
        synchronizationVisibilityofElement(driver, removeButton_dashboard);
        return removeButton_dashboard;
    }

    public WebElement getItemListCount(){
        synchronizationVisibilityofElement(driver, itemListCount);
        return itemListCount;
    }

    public WebElement click_AboutmenuButtons(String AboutSubMenu){
        return driver.findElement(By.xpath("//ul//li[@role='menuitem'][contains(.,'"+AboutSubMenu+"')]"));
    }

    public WebElement click_SubmenuButtons(String submenuName){
        return driver.findElement(By.xpath("//ul//li[@role='menuitem']/a[contains(text(),'"+submenuName+"')]"));
    }

    public WebElement getTypeUnderContainer(String containerName, String type){
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-panels-item-dynamic-caption')]]//following::p[contains(.,'"+containerName+"')]//following::span[contains(.,'"+type+"')][1]"));
    }

    public List<WebElement> getItemFullViewTabs(){
        synchronizationVisibilityofElementsList(driver,itemFullViewTabs);
        return itemFullViewTabs;
    }



    public WebElement getItemTabs(String tabName){
        return driver.findElement(By.xpath("//a[contains(.,'"+tabName+"')]/parent::li/a"));
    }

    public List<WebElement> getSearchIcon(){
        synchronizationVisibilityofElementsList(driver,searchIcon);
        return searchIcon;
    }
    public WebElement getContentUnderContainer(String containerName, String content){
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//following::p[contains(.,'"+containerName+"')]//following::pre[contains(.,'"+content+"')][1]"));
    }

    public void clickOnTypeUnderContainer(String containerName, String type){
        clickonWebElementwithJavaScript(driver,getTypeUnderContainer(containerName,type));
    }

    public void clickMinimizeIcon(){
        clickOn(minimizeIcon);
    }

    public void clickMinimizeIcon_Firefox(){
        clickonWebElementwithJavaScript(driver,minimizeIcon);
    }

    public WebElement catalogDropDown() {

        synchronizationVisibilityofElement(driver, catalogDropDown);
        return catalogDropDown;
    }

    public void clickOnOpenStatisticLinkForTheNotification(String notificationHeader){
        clickOn(driver.findElement(By.xpath("//div[@class='asg-notifications-text-block']//b[contains(.,'"+notificationHeader+"')]//following::a[contains(.,'Open statistic')][1]")));
    }
    public WebElement getdynamicPropertyInNotificationDetailsPanel(String notificationTitle, String panelSection, String propertyName){
        return driver.findElement(By.xpath("//span[contains(.,'"+notificationTitle+"')]//following::b[contains(.,'"+panelSection+"')]//following::span[contains(.,'"+propertyName+"')]/following-sibling::span"));
    }

    public WebElement getsectionDataContentInNotificationPanel(String notificationTitle, String panelSection, String expectedText){
        return driver.findElement(By.xpath("//span[contains(.,'"+notificationTitle+"')]//following::b[contains(.,'"+panelSection+"')]//following::pre[contains(.,'"+expectedText+"')]"));
    }

    public List<WebElement> getNotificationLabels(String section){
        return driver.findElements(By.xpath("//b[contains(.,'"+section+"')]//following::span[@class='statistics-label']"));
    }

    public WebElement getLinkInNotificationPanel(String linkName) {
        return driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//b[contains(.,'DETAILS')]//following::a[contains(.,'"+linkName+"')][1]"));
    }

    public void clickLinkFromOpenNotificationPanel(String linkName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='asg-panels-item asg-panels-active-item']//b[contains(.,'DETAILS')]//following::a[contains(.,'"+linkName+"')][1]")));
    }

    /*
   10.3 Page Objects
    */
    public void clickSettingsIcon() {
        clickOn(settingsIcon);
    }

    public WebElement getSettingsIcon() {
        return settingsIcon;
    }

    public void clickPageTitle() {
        clickOn(driver, pageTitleHeader);
    }

    public WebElement getCreateButton() {
        return CreateButton;
    }

    public WebElement getappicon() {
        return appicon;
    }

    public void clickLicenseButton(String buttonName) {
        clickOn(driver, driver.findElement(By.xpath("//div[@class='license-content-block']//div[@class='license-buttons-panel'][contains(.,'" + buttonName + "')]")));
    }

    public WebElement getWelcomePage() {
        synchronizationVisibilityofElement(driver, welcomePageUnderSettingsIcon);
        return welcomePageUnderSettingsIcon;
    }

    public WebElement getManageConfigurationsPage() {
        synchronizationVisibilityofElement(driver, manageConfigurationsPage);
        return manageConfigurationsPage;
    }

    public WebElement getManageDataSourcesPage() {
        synchronizationVisibilityofElement(driver, manageDataSourcesPage);
        return manageDataSourcesPage;
    }

    public WebElement getManageExcelImportsPage() {
        synchronizationVisibilityofElement(driver, manageExcelImportsPage);
        return manageExcelImportsPage;
    }

    public WebElement getAddSourceButton() {
        synchronizationVisibilityofElement(driver, addSourceButton);
        return addSourceButton;
    }

    public WebElement getAddSourceButtonInManageDataSourcePage() {
        synchronizationVisibilityofElement(driver, addSourceButtonInManageDataSourcePage);
        return addSourceButtonInManageDataSourcePage;
    }

    public WebElement getAddBundlesButton() {
        synchronizationVisibilityofElement(driver, addBundlesButton);
        return addBundlesButton;
    }

    public WebElement getLicensePage() {
        synchronizationVisibilityofElement(driver, licensePage);
        return licensePage;
    }

    public WebElement returnSaveSearchNameTextBox() {
        synchronizationVisibilityofElement(driver, saveSearchNameTextBox);
        return saveSearchNameTextBox;
    }

    public WebElement returnBundlesSearchTextBox() {
        return bundlesSearchTextBox;
    }

    public WebElement returnSaveSearchDescriptionTextBox() {
        synchronizationVisibilityofElement(driver, saveSearchDescriptionTextBox);
        return saveSearchDescriptionTextBox;
    }

    public WebElement returntopSearchBox() {
        synchronizationVisibilityofElement(driver, topSearchBox);
        return topSearchBox;
    }

    public WebElement returnAdvancedSettings() {
        synchronizationVisibilityofElement(driver, advancedSettings);
        return advancedSettings;
    }


    public WebElement getHeaderText() {
        synchronizationVisibilityofElement(driver, headerText);
        return headerText;
    }

    public WebElement getVersionText() {
        synchronizationVisibilityofElement(driver, versionText);
        return versionText;
    }

    public WebElement getReporticon() {
        synchronizationVisibilityofElement(driver, Reporticon);
        return Reporticon;
    }

    public WebElement getCloseicon() {
        synchronizationVisibilityofElement(driver, Closeicon);
        return Closeicon;
    }

    public WebElement getRefreshIcon() {
        synchronizationVisibilityofElement(driver, RefreshIcon);
        return RefreshIcon;
    }

    public WebElement getSelectAll() {
        synchronizationVisibilityofElement(driver, SelectAll);
        return SelectAll;
    }

    public WebElement getGlobalSeacrhIcon() {
        synchronizationVisibilityofElement(driver, globalSeacrhIcon);
        return globalSeacrhIcon;
    }

    public WebElement getHeaderProfileIcons() {
        synchronizationVisibilityofElement(driver, headerProfileIcons);
        return headerProfileIcons;
    }

    public WebElement getHeaderSearchBlock() {
        synchronizationVisibilityofElement(driver, headerSearchBlock);
        return headerSearchBlock;
    }

    public List<WebElement> getHeaderSearchAreakAsList() {
        synchronizationVisibilityofElementsList(driver, topSearchBoxAsList);
        return topSearchBoxAsList;
    }

    public WebElement getHeaderCatalogDropDown() {
        synchronizationVisibilityofElement(driver, headerCatalogDropdown);
        return headerCatalogDropdown;
    }

    public WebElement getSearchCrossButton() {
        synchronizationVisibilityofElement(driver, searchCrossButton);
        return searchCrossButton;
    }

    public WebElement getSearchButton() {
        synchronizationVisibilityofElement(driver, searchButton);
        return searchButton;
    }

    public WebElement getSearchDropdownButton() {
        synchronizationVisibilityofElement(driver, searchDropdown);
        return searchDropdown;
    }

    public WebElement getHiddenGlobalSearchButton() {
        return hiddenGlobalSearchButton;
    }

    public List<WebElement> getExpandedSidebar() {
        synchronizationVisibilityofElementsList(driver, expandedSidebar);
        return expandedSidebar;
    }

    public List<WebElement> getSidebarSubMenuAsList() {
        synchronizationVisibilityofElementsList(driver, sidebarSubmenuAsList);
        return sidebarSubmenuAsList;
    }

    public List<WebElement> getSearchSubMenuAsList() {
        synchronizationVisibilityofElementsList(driver, searchSubmenuAsList);
        return searchSubmenuAsList;
    }

    public List<WebElement> getConfigurationLabelsAsList() {
        synchronizationVisibilityofElementsList(driver, configurationLabelsAsList);
        return configurationLabelsAsList;
    }

    public List<WebElement> getMetadatattypeList() {
        synchronizationVisibilityofElementsList(driver, MetadatattypeList);
        return MetadatattypeList;
    }

    public WebElement getAdminLinks(String linkName) {
        return driver.findElement(By.xpath("//li[@class[contains(.,'sidebar-submenu')]]/a[contains(.,'" + linkName + "')]"));
    }

    public WebElement getAdminSettingsIcon() {
        return driver.findElement(By.xpath("//div[contains(@class,'icon-block')]//span[contains(@class,'far fa-cog')]"));
    }

    public WebElement getAddExcelImportButton(String value) {
        return driver.findElement(By.xpath("//span[@title='"+value+"']"));
    }

    public WebElement getCreateButtonLink() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'fas fa-plus-circle')]]"));
    }

    public WebElement getAddDataSourcePopUp() {
        synchronizationVisibilityofElement(driver, addDataSourcePopup);
        return addDataSourcePopup;
    }

    public WebElement getDropdownButtonOfTheField(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+fieldName+"')]//following::button[1]/span[@class[contains(.,'float-left')]]"));
    }

    public WebElement getCreatepageDropdownButtonOfTheField() {
        return driver.findElement(By.xpath("//div/button[@type='button']/span//em"));
    }

    public WebElement getOwnersInCreatePage(String textbox,String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textbox+"')]//following::input[1]/../../div//ul//div//span[contains(.,'"+ option +"')]"));
    }

    public WebElement deleteOwnersInCreatePage(String textbox,String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textbox+"')]//following::input[1]/../../div//span[contains(.,'"+option+"')]/../../em"));
    }

    public WebElement getAttributeInDropdown(String filterName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+filterName+"')][1]//following::div[@role='menu']/button/span[contains(.,'"+option+"')]"));
    }

    public WebElement getDropdownButtonOfTheTypeFieldInDSPage(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'"+fieldName+"')]//following::button/span[@class='asg-dynamic-form-select-drop-down-icon float-right']/em"));
    }

    public WebElement getTypeFromDropdownInDSPage(String filterName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'"+filterName+"')][1]//following::li[@class[contains(.,'dropdown-item')]][contains(.,'"+option+"')]"));
    }

    public WebElement getDropdownButtonOfTheTypeFieldInBundlePage(String fieldName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-filter-group')]]/span[contains(.,'"+fieldName+"')]//following::div/button/span[2]/em"));
    }

    public WebElement getTypeFromDropdownInBundlePage(String filterName, String option) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-filter-group')]]//span[contains(.,'"+filterName+"')][1]//following::li[@class[contains(.,'dropdown-list cursor-pointer dropdown-item')]]/div[contains(.,'"+option+"')]"));
    }

    public WebElement getDropdownButtonOfTheTypeFieldInManageDSPage(String fieldName) {
        return driver.findElement(By.xpath("//span[contains(.,'"+fieldName+"')]//following::button/span[@class='asg-filter-btn-icon']/em"));
    }

    public WebElement getTypeFromDropdownInManageDSPage(String filterName, String option) {
        return driver.findElement(By.xpath("//span[contains(.,'"+filterName+"')][1]//following::li[@class[contains(.,'dropdown-item')]][contains(.,'"+option+"')]"));
    }

    public WebElement getDropdownButtonOfBAAttributesInItemViewPage(String fieldName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'list-caption')]][contains(.,'"+fieldName+"')]//following-sibling::div//div/button/span/em"));
    }

    public WebElement getAttributesOptionInItemViewPage(String fieldName, String option) {
        return driver.findElement(By.xpath("//div[contains(.,'"+fieldName+"')]//following-sibling::ul[1]/li[@class[contains(.,'dropdown-item')]]/a/span[contains(.,'"+option+"')]"));
    }


    public List<WebElement> getConfigurationPropertiesInAddDataSourcePae() {
        synchronizationVisibilityofElementsList(driver, addDataSourcePageConfigurations);
        return addDataSourcePageConfigurations;
    }

   public WebElement getConfirmDeleteButton() {
        synchronizationVisibilityofElement(driver, confirmDeleteButton);
        return confirmDeleteButton;
    }

    public WebElement getTextBoxInManageDataSources(String textbox) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textbox+"')]//following::input[1]"));
    }

    public WebElement getTextBoxInCreatePage(String textbox) {
        return driver.findElement(By.xpath("//label[contains(.,'"+textbox+"')]//following::input[1]"));
    }

    public WebElement getDescriptionTextBoxInCreatePopup() {
        return descriptionTextBoxInCreatePopup;
    }

    public WebElement getCredentialNameTextBox() {
        synchronizationVisibilityofElement(driver, credentialNameTextbox);
        return credentialNameTextbox;
    }

    public WebElement getPipelineNameTextBox() {
        synchronizationVisibilityofElement(driver, pipelineNameTextBox);
        return pipelineNameTextBox;
    }

    public WebElement getPipelineDescriptionTextbox() {
        synchronizationVisibilityofElement(driver, pipelineDescriptionTextbox);
        return pipelineDescriptionTextbox;
    }


    public WebElement textBoxInAddDataSourcePage() {
        synchronizationVisibilityofElement(driver, topSearchBox);
        return topSearchBox;
    }

    public WebElement getDataSourcesAndCredentialsSaveButton() {
        synchronizationVisibilityofElement(driver, saveButton);
        return saveButton;
    }

    public WebElement getTagPageAssignButton() {
        synchronizationVisibilityofElement(driver, AssignButton);
        return AssignButton;
    }

    public WebElement getSaveandOPenButton() {
        synchronizationVisibilityofElement(driver, saveandOPenButton);
        return saveandOPenButton;
    }

    public WebElement getProfileSettingSaveButton() {
        synchronizationVisibilityofElement(driver, saveButton);
        return saveButton;
    }

    public WebElement getFinishButton(){
        return finishButton;
    }

    public WebElement getCancelButton(){
        synchronizationVisibilityofElement(driver, cancelButton);
        return cancelButton;
    }

    public WebElement getCloseButtonInpopUp() {
        return closeButtonInPopUp;
    }

    public WebElement getStep1popUpNextButton() {
        synchronizationVisibilityofElement(driver, nextButton);
        return nextButton;
    }

    public WebElement getTestConnectionButton() {
        synchronizationVisibilityofElement(driver, testConnectionButton);
        return testConnectionButton;
    }

    public WebElement getTestConnectionButtonDisabled() {
        synchronizationVisibilityofElement(driver, testConnectionButtonDisabled);
        return testConnectionButtonDisabled;
    }

    public WebElement getBAEditIconDisabled() {
        synchronizationVisibilityofElement(driver, BAEditIconDisabled);
        return BAEditIconDisabled;
    }

    public List<WebElement> getWelcomePageStartButton() {
        synchronizationVisibilityofElementsList(driver, WelcomPageStartButton);
        return WelcomPageStartButton;
    }

    public WebElement getPopupTitle(String popUpName) {
      return  driver.findElement(By.xpath("//h4[contains(.,'"+popUpName+"')]/.."));
    }

    public WebElement getProfileImage() {
        synchronizationVisibilityofElement(driver, profileImage);
        return profileImage;
    }

    public WebElement getProfileSetting() {
        synchronizationVisibilityofElement(driver, profileSetting);
        return profileSetting;
    }

    public WebElement getDropdownButtonOfTheFieldInProfileSetting(String fieldName) {
        return driver.findElement(By.xpath("//span[contains(.,'"+fieldName+"')]//following::button[@class='btn selected-drop-item dropdown-toggle']"));
    }

    public WebElement getAttributeInDropdownInProfileSetting(String filterName, String option) {
        return driver.findElement(By.xpath("//span[contains(.,'"+filterName+"')][1]//following::li[@class[contains(.,'dropdown-item')]]/span[contains(.,'"+option+"')]"));
    }

    public WebElement getAlertMessageInProfileSetting(String option) {
        return driver.findElement(By.xpath("//span[@class='alert-text'][contains(.,'"+option+"')]"));
    }

    public WebElement getPluginType(String actionItem,String itemName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'"+actionItem+"')]][contains(.,'"+itemName+"')]"));
    }
    public WebElement getconfigurationType(String option) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'tab py-1 w-50 text-center')]][contains(.,'"+option+"')]"));
    }
    public WebElement getconfingpiplineButtons(String actionItem, String itemName) {
        return driver.findElement(By.xpath("//div[contains(.,'"+actionItem+"')]//following::span[@title='"+itemName+"']"));
    }

    public WebElement getPipelineListinfo(String actionItem, String itemName) {
        return driver.findElement(By.xpath("//label[contains(., '"+actionItem+"')]//following::div[contains(.,'"+itemName+"')]"));
    }

    public WebElement getConfingInPipline(String option) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'content px-3 py-2')]]//following::div[contains(.,'"+option+"')]"));
    }

    public WebElement getRemovepipelineconfig(String option) {
        return driver.findElement(By.xpath("//button[contains(.,' "+option+" ')]"));
    }

    public WebElement getPluginName(String actionItem,String itemName) {
        return driver.findElement(By.xpath("//span[contains(., '"+actionItem+"')]//following::div[contains(.,'"+itemName+"')]"));
    }

    public List<WebElement> getDataSourceList() {
        synchronizationVisibilityofElementsList(driver, isDataSourcePresentInmanageDataSourceList);
        return isDataSourcePresentInmanageDataSourceList;
    }

    public List<WebElement> getBundleVersionList() {
        synchronizationVisibilityofElementsList(driver, getBundleVersion);
        return getBundleVersion;
    }

    public List<WebElement> getFirstColumnList() {
        synchronizationVisibilityofElementsList(driver, FirstColumnList);
        return FirstColumnList;
    }

    public List<WebElement> getFirstColumnList1() {
        synchronizationVisibilityofElementsList(driver, FirstColumnList1);
        return FirstColumnList1;
    }

    public List<WebElement> getValueColumnList() {
        synchronizationVisibilityofElementsList(driver, ValueColumnList);
        return ValueColumnList;
    }

    public List<WebElement> getCredentialsList() {
        synchronizationVisibilityofElementsList(driver, isCredentialsPresentFromTheList);
        return isCredentialsPresentFromTheList;
    }

    public List<WebElement> getKeywordList() {
        synchronizationVisibilityofElementsList(driver, isKeywordPresentFromTheList);
        return isKeywordPresentFromTheList;
    }

    public WebElement getSuccessConnectionMessage() {
        synchronizationVisibilityofElement(driver, successConnectionMessage);
        return successConnectionMessage;
    }

    public WebElement getFailureConnectionMessage() {
        synchronizationVisibilityofElement(driver, failedConnectionMessage);
        return failedConnectionMessage;
    }

    public List<WebElement> getPluginCompletionPopUp() {
        return pluginCompletionPopUp;
    }

    public WebElement getFilterIconInDSPage() {
        synchronizationVisibilityofElement(driver, filterIcon);
        return filterIcon;
    }

    public WebElement getBrowsefilesbutton() {
        synchronizationVisibilityofElement(driver, Browsefiles);
        return Browsefiles;
    }

    public WebElement getDragAndDropFrame() {
        synchronizationVisibilityofElement(driver, DragAndDropFrame);
        return DragAndDropFrame;
    }

    public WebElement getBundleSavebutton() {
        synchronizationVisibilityofElement(driver, BundleSaveButton);
        return BundleSaveButton;
    }

    public WebElement getFieldValidationMesssage(String pageName, String fieldName) {
        return driver.findElement(By.xpath("//div/h4[contains(.,'"+pageName+"')]//following::label[contains(.,'"+fieldName+"')][1]//following::div[@class[contains(.,'alert alert-danger')]][1]"));
    }

    public WebElement getcatalogName(String name) {
        return driver.findElement(By.xpath("//div[@class='d-flex text-break item-list-total-number']//span[contains(text(),'" + name + "')]"));
    }

    public WebElement getDropdowncatalogName(String CatalogName) {
        return driver.findElement(By.xpath("//ul[@class='schema-dropdown-menu dropdown-menu show']/li/span[contains(., '"+CatalogName+"')]"));
    }

    public boolean getShowAllButtonFilterPage() {
        boolean status = isElementPresent(ShowAll_facetFilter_Button);
        return status;
    }

    public void clickfilterType(String typeName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='asg-checkbox-small']//input[@id='" + typeName + "']")));

    }

    public void clickHierarcyType(String typeName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='asg-item-except-count-part']//div[contains(.,'" + typeName + "')]")));

    }

    public WebElement getTagType(String Name) {
        return driver.findElement(By.xpath("(//div[@class[contains(.,'asg-facet-tree-item-holder')]][contains(., '"+Name+"')]//following::div[@class[contains(., 'asg-facet-tree-item-count')]])[1]"));
    }

    public void clickTagType(String TagName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='asg-facet-tree-item-holder text-left asg-facet-item-ellipsis'][contains(., '"+TagName+"')]")));

    }

    public void clickflatfilterType(String typeName) {
        clickonWebElementwithJavaScript(driver, driver.findElement(By.xpath("//div[@class='asg-facet-item-body clearfix showMore ng-star-inserted']//div[contains(.,'" + typeName + "')]")));

    }

    public WebElement Searchresultscount(String count) {
        return driver.findElement(By.xpath("//div[@class='asg-item-list-filter-container']//div[contains(.,'" + count + "')]"));
    }

    public WebElement GetSortOptions(String Sort) {
        return driver.findElement(By.xpath("//button[@class='form-control hide-default-toggle dropdown-toggle']//span[contains(., '"+Sort+"')]"));
    }

    public WebElement getRunRecentTableContent() {
        return driver.findElement(By.xpath("//div[@class='run-table-content']/../div"));
    }


    public WebElement getSearchType(String searchType) {
        return driver.findElement(By.xpath("//button[@class='dropdown-item']/span[contains(.,'"+searchType+"')]"));
    }

    public WebElement getSortIcon() {
        return sortIcon;
    }

    public WebElement GetViewicon() {
        return driver.findElement(By.xpath("//button[@class='fa cursor-pointer show-pass fa-eye']"));
    }

    public WebElement getBackgroundcolor(String PageName) {
        return driver.findElement(By.xpath("//body[@class='modal-open']"));
    }

    public WebElement getSearchSuggestionText() {
        return searchSuggestionText;
    }

    public WebElement getDataAssetBar(String Name) {
        return driver.findElement(By.xpath("//div[@class='details-body w-100']//div[@title='"+Name+"']//following::div[@class[contains(.,'progress-bar')]]"));
    }

    public WebElement getRoundIcon() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'color-div rounded-circle')]]"));
    }

    public WebElement getTableBackgroundcolor(String PageName) {
        return driver.findElement(By.xpath("//div[@class='header']"));
    }

    public WebElement getCatalogSearchResult(String catalogName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-item-list-filter-container')]][contains(.,'"+catalogName+"')]"));
    }


    public WebElement getSelectedAttributesInSearchResult(String filterName, String attribute) {
        return driver.findElement(By.xpath("//strong[contains(.,'"+filterName+"')]//following::input[@id='"+attribute+"']"));
    }

    public WebElement getSaveSearchButton(){
        return saveSearch;
    }

    public WebElement getSaveSearchSaveButton(){
        return SaveSearchSaveButton;
    }

    public WebElement getTypeDropDownButton(){
        return typeDropdownButton;
    }

    public List<WebElement> getTypeList() {
        synchronizationVisibilityofElementsList(driver, typeDDList);
        return typeDDList;
    }

    public List<WebElement> getConfigPluginList() {
        synchronizationVisibilityofElementsList(driver, configurationPluginDDList);
        return configurationPluginDDList;
    }

    public WebElement getTableHeadercolor() {
        return driver.findElement(By.xpath("//div[@class='table-container']//div[@class[contains(.,'header')]]"));

    }

    public WebElement getRunSearchResultButton() {
        synchronizationVisibilityofElement(driver, runSearchResult);
        return runSearchResult;
    }

    public WebElement deleteSavedSearchButton() {
        synchronizationVisibilityofElement(driver, deleteSavedSearchResult);
        return deleteSavedSearchResult;
    }

    public WebElement getEditConfigurationHeader() {
        synchronizationVisibilityofElement(driver,editConfigurationToLocalNodePage);
        return editConfigurationToLocalNodePage;
    }

    public WebElement getCloneConfigurationHeader() {
        synchronizationVisibilityofElement(driver,cloneConfigurationToLocalNodePage);
        return cloneConfigurationToLocalNodePage;
    }

    public WebElement getChangedDDName_Plugin() {
        synchronizationVisibilityofElement(driver,ddNameChangeToPlugin);
        return ddNameChangeToPlugin;
    }

    public WebElement getCloneCredentialHeader() {
        synchronizationVisibilityofElement(driver,cloneCredential);
        return cloneCredential;
    }

    public WebElement getEditCredentialHeader() {
        synchronizationVisibilityofElement(driver,editCredential);
        return editCredential;
    }

    public WebElement getContextualMessage(String contextualMessage) {
        return  driver.findElement(By.xpath("//p[contains(.,'"+contextualMessage+"')]"));
    }
    public WebElement getFieldErorMessage(String FieldName, String Message){
        return  driver.findElement(By.xpath("//label[contains(.,'"+FieldName+"')]//following::div[@class[contains(.,'error text-left')]][contains(.,'"+Message+"')]"));
    }

    public WebElement getdropdownPlaceholdermessage() {
        return  driver.findElement(By.xpath("//span[@class='float-left placeholder']"));
    }

    public WebElement gettextboxPlaceholdermessage(String message) {
        return  driver.findElement(By.xpath("//input[@placeholder='"+message+"']"));
    }

    public WebElement getCloneDataSourceHeader() {
        synchronizationVisibilityofElement(driver,cloneDataSource);
        return cloneDataSource;
    }

    public WebElement getEditDataSourceHeader() {
        synchronizationVisibilityofElement(driver,editDataSource);
        return editDataSource;
    }
    public WebElement getPlaceHolderText(){
        synchronizationVisibilityofElement(driver,placeHolderDD);
        return placeHolderDD;
    }
    public WebElement getChangedName(){
        synchronizationVisibilityofElement(driver,changedName);
        return changedName;
    }

    public WebElement getTextBoxInSaveSearchPage(String textbox) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-dynamic-form-property-label-container')]][1]//following::label[contains(.,'" + textbox + "')][1]//following::input[1]"));
    }


    public WebElement getViewLinkForMetadataField(String fieldName) {
        return driver.findElement(By.xpath("//div[@class='list-caption text-right'][contains(.,'"+fieldName+"')]//following::a[contains(.,'View')]"));
    }

    public List<WebElement> getTooltipContentInItemViewPage() {
        return driver.findElements(By.xpath("//pre[@class='popup-json-content']"));
    }

    public WebElement getItemViewPageTitle(){
        synchronizationVisibilityofElement(driver,itemViewPageTitle);
        return itemViewPageTitle;
    }

    public WebElement getCollapseButton(String fieldName) {
        return driver.findElement(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'"+fieldName+"')]/preceding-sibling::span"));
    }

    public WebElement getUncollapseButton(String fieldName) {
        return driver.findElement(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'"+fieldName+"')]/preceding-sibling::span"));
    }

    public WebElement getWidgetCollapseButton(String widgetName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'ml-1 select-none')]][contains(.,'" + widgetName + "')]/preceding-sibling::span"));
    }

    public WebElement getMetadataContainer() {
        return metadataContainer;
    }

    public WebElement getRowCount() {
        return rowCount;
    }

    public WebElement getItemViewWidget(String widgetName) {
        return driver.findElement(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'" + widgetName + "')]"));
    }

    public List<WebElement> getItemViewWidgetHeaderTitle(String widgetName) {
        return driver.findElements(By.xpath("//span[@class='title text-capitalize position-relative font-weight-bold'][contains(.,'"+widgetName+"')]"));
    }

    public WebElement getWidegtBelongingLink(String widgetName, String belongingName) {
        return driver.findElement(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'" + widgetName + "')]//following::a[contains(.,'" + belongingName + "')]"));
    }

    public WebElement getFirstWidgetBelonging(String widgetName) {
        return driver.findElement(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'" + widgetName + "')]//following::a[1]"));
    }

    public WebElement getNameSortIcon(String widgetName) {
        return driver.findElement(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'" + widgetName + "')]//following::span[@class='cursor-pointer text-nowrap'][contains(.,'Name')][1]"));
    }

    public List<WebElement> getWidgetBelongingList(String widgetName) {
        return driver.findElements(By.xpath("//span[@class='text-capitalize font-weight-bold pl-1'][contains(.,'" + widgetName + "')]//following::tbody[1]/tr/td/a"));
    }

    public WebElement getBundlesSearchButton() {
        return bundlesSearchButton;
    }

    public WebElement getBundleExpandButton(String bundleName) {
        return driver.findElement(By.xpath("//span[contains(.,'"+bundleName+"')]/preceding::span[@class[contains(.,'fa-caret-right')]][1]"));
    }

    public WebElement getBundleCollapseButton(String bundleName) {
        return driver.findElement(By.xpath("//span[contains(.,'"+bundleName+"')]/preceding::span[@class[contains(.,'fa-caret-down')]][1]"));
    }

    public WebElement getBundleSearchExitButton() {
        return bundlesSearchExitButton;
    }

    public WebElement getManageBundlesTitle() {
        synchronizationVisibilityofElement(driver, manageBundlesTitleAndDesc);
        return manageBundlesTitleAndDesc;
    }

    public WebElement getManageBundlesHeaderCount(String bundleCount) {
        return driver.findElement(By.xpath("//div[@class='header w-100 border-bottom-0 d-flex justify-content-between align-items-center header-title'][contains(.,'"+bundleCount+"')]"));
    }

    public WebElement getBundleSortIcon(String fieldName) {
        return driver.findElement(By.xpath("//th[@class[contains(.,'border-0 text-capitalize')]][contains(.,'"+fieldName+"')]//span"));
    }

    public List<WebElement> getExpandedPluginList() {
        return getExpandedPluginList;
    }

    public WebElement getBundle(String bundleName) {
        return driver.findElement(By.xpath("//tr[@class[contains(.,'tr-row cursor-pointer')]]//td[@class][contains(.,'"+bundleName+"')][1]"));
    }

    public WebElement getBundleDeleteButton(String bundleName) {
        return driver.findElement(By.xpath("//td//span[contains(.,'"+bundleName+"')][1]//following::span[@class[contains(.,'far fa-trash')]][1]"));
    }

    public WebElement clickSlidebarfor(String fieldName) {
        return driver.findElement(By.xpath("//ui-switch[@id[contains(.,'" + fieldName + "')]]//span"));
    }

    public WebElement getBundlesCancelButton() {
        synchronizationVisibilityofElement(driver, bundlesCancelButton);
        return bundlesCancelButton;
    }

    public WebElement getPopUpXButton() {
        synchronizationVisibilityofElement(driver, popUpXButton);
        return popUpXButton;
    }

    public WebElement getBundlesPopupDeleteButton() {
        synchronizationVisibilityofElement(driver, bundlesPopupDeleteButton);
        return bundlesPopupDeleteButton;
    }

    public WebElement getCancelButtonInPopUp(){
        return cancelButtonInPopUp;
    }

    public List<WebElement> getManageAccessTab() {
        synchronizationVisibilityofElementsList(driver, manageAccessTab);
        return manageAccessTab;
    }

    public WebElement getAddLocalUserButton() {
        return addLocalUserButton;
    }

    public WebElement getContextualMessage() {
        synchronizationVisibilityofElement(driver, contextualMessage);
        return contextualMessage;
    }

    public WebElement getDataElementwidget() {
        synchronizationVisibilityofElement(driver, dataElementwidget);
        return dataElementwidget;
    }

    public WebElement getBundleEditButton(String userName) {
        return driver.findElement(By.xpath("//td//span[contains(.,'"+userName+"')][1]//following::span[@class[contains(.,'far fa-edit cursor-pointer')]][1]"));
    }

    public WebElement getManageAccessTitle() {
        return driver.findElement(By.xpath("//div[@class='asg-manage-container']//div/div[contains(.,'Manage Access')][1]"));
    }

    public List<WebElement> getLeftMenus(String menuName){
        return driver.findElements(By.xpath("//div[@class[contains(.,'left-navigation-item')]][@title='"+menuName+"']"));
    }

    public WebElement getAssignExistingConfiguration() {
        return assignExistingConfiguration;
    }

    @FindBy(xpath = "//strong[text()='NOTIFICATIONS']/../button[@class='exit-btn']")
    private WebElement notificationExtBtn;

    public WebElement Click_NotificationExtBtn() {

        synchronizationVisibilityofElement(driver, notificationExtBtn);
        return notificationExtBtn;
    }

    public WebElement getWelcomePageButtons(String buttonName) {
        return driver.findElement(By.xpath("//button[contains(.,'" + buttonName + "')]"));
    }

    public WebElement getItemViewEditButtons(String buttonName) {
        return driver.findElement(By.xpath("//span[contains(.,'" + buttonName + "')]//following::em[@class='fa fa-edit'][1]"));
    }

    public WebElement getAttributeTextbox(String attributeName) {
        return driver.findElement(By.xpath("//div[@class='list-caption for-edit text-right'][contains(.,'"+attributeName+"')][1]//following::input[1]"));
    }

    public WebElement getItemViewPageTabs(String tabName) {
        return driver.findElement(By.xpath("//ul//li[@class[contains(.,'nav-item')]][contains(.,'" + tabName + "')]"));
    }

    public List<WebElement> getItemViewPageTabsinList() {
        return driver.findElements(By.xpath("//ul//li[@class[contains(.,'nav-item')]]"));
    }

    public List<WebElement> getWidgetContainer(String widgetName) {
        return driver.findElements(By.xpath("//span[contains(.,'" + widgetName + "')]//following::div[@class='asg-item-view-multi-properties-widget-body ng-untouched ng-pristine ng-valid']"));
    }

    public List<WebElement> getTableWidgetContainer(String widgetName) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'asg-item-view-lazy-load-table-widget-body')]][1]/preceding-sibling::span[contains(.,'" + widgetName + "')]"));
    }


    public List<WebElement> getWidgetContainerHidden(String widgetName) {
        return driver.findElements(By.xpath("//span[contains(.,'" + widgetName + "')]//following::div[@class='asg-item-view-multi-properties-widget-body ng-untouched ng-pristine ng-valid'][@hidden]"));
    }

    public WebElement getRowlistCount(String widgetName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'font-weight-bold pl-1')]][contains(.,'" + widgetName + "')]//following::span[@class='count']"));
    }

    public WebElement getAddPluginConfigurationButton() {
        return addPluginConfigButton;
    }

    public WebElement getCaptureNewDataButton() {
        return captureNewData;
    }

    public WebElement getPluginConfigTitle(String pluginName) {
        return driver.findElement(By.xpath("//span[@title='" + pluginName + "']"));
    }

    public WebElement getPluginConfigElementCount(String pluginName) {
        return driver.findElement(By.xpath("//span[contains(.,'" + pluginName + "')]//following::span[contains(.,'Data Elements')]/preceding-sibling::span/.."));
    }

    public WebElement getWidgetCatalogedItemlabels(String labelName) {
        return driver.findElement(By.xpath("//span[@class='item-label'][contains(.,'" + labelName + "')]"));
    }

    public WebElement getPluginDataElement(String pluginName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'ml-1 select-none')]][contains(.,'" + pluginName + "')]//following::span[@class[contains(.,'total-count')]]"));
    }

    public WebElement getDefaultSelectedOption(String fieldName, String option) {
        return driver.findElement(By.xpath("//span[contains(.,'"+fieldName+"')]//following::div[@class[contains(.,'default-view-dropdown show dropdown')]]/button/div[contains(.,'"+option+"')]"));
    }

    public WebElement getBADefaultSelectedOption(String fieldName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'list-group-items-container')]][contains(.,'"+fieldName+"')]/div/span"));
    }

    public WebElement getBADefaultSelectedItemType(String fieldName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'form-group d-flex justify-content-center')]][contains(.,'" + fieldName + "')]/div"));
    }
    public WebElement getBADefaultSelectedOption(String fieldName, String option) {
        return driver.findElement(By.xpath("//div[contains(.,'" + fieldName + "')]//following::button[@class[contains(.,'form-control hide-default-toggle dropdown-toggle')]]/span[contains(.,'" + option + "')]"));
    }

    public WebElement getYourRatingAboveAverageRating() {
        return yourRatingOrder;
    }

    public List<WebElement> getCatalogvalueInSearchResults() {
        return catalogValueInSearchResults;
    }


    public WebElement getSelectAllLabelDisplayed() {
        return selectAllLabel;
    }

    public WebElement getSelectedItemOnlyLabel() {
        return selectedItemsOnlyLabel;
    }

    public WebElement getAssignUnassignTags() {
        return assignUnassignTags;
    }

    public WebElement getManageDataSourceSubMenu(){
        synchronizationVisibilityofElement(driver,manageDataSource);
        return manageDataSource;
    }

    public WebElement getManageCredentialsSubMenu(){
        synchronizationVisibilityofElement(driver,manageCredentials);
        return manageCredentials;
    }

    public WebElement getManageDataConfigSubMenu() {
        synchronizationVisibilityofElement(driver, manageDataConfig);
        return manageDataConfig;
    }

    public WebElement getPageTitleHeader(){
        return pageTitleHeader;
    }
    public List<WebElement> getBAMultiTabMenuAsList() {
        synchronizationVisibilityofElementsList(driver, BAMultiTabSubmenuAsList);
        return BAMultiTabSubmenuAsList;
    }

    public WebElement getPageTitle(String pageName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'title')]][contains(.,'"+pageName+"')]"));
    }

    public WebElement getWelcomePage(String welcomePage) {
        return driver.findElement(By.xpath("//div[@class='welcome-page']//div[@class='header-content' and contains(.,'"+welcomePage+"')]"));
    }

    public List<WebElement> getSubMenuAsList(String parentMenu) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'left-navigation-item')]][@title='" + parentMenu + "']//ul/li"));
    }

    public List<WebElement> getSidebarAdminLinks() {
        return sidebarAdminLinks;
    }

    public WebElement getDashboardDropdown() {
        return dashboardDropdown;
    }

    public List<WebElement> getDashboardList() {
        return dashboardList;
    }

    public List<WebElement> getDashboardWidgetList() {
        return dashboardWidgetList;
    }

    public List<WebElement> getSidebarLink(String sidebarName) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'left-navigation-item')]][@title='" + sidebarName + "']"));
    }

    public WebElement getDashboardSettingsIcon() {
        return dashboardSettingsIcon;
    }

    public WebElement getDashboardToolbarIcons(String toolName) {
        return driver.findElement(By.xpath("//em[@title='" + toolName + "']"));
    }

    public WebElement getDashboardAddWidgetIcon() {
        return driver.findElement(By.xpath("//em[@title='Add Widget']"));
    }

    public WebElement getDashboardConfigSaveButton() {
        return dashboardConfigSaveButton;
    }

    public List<WebElement> getSelectWidgetList() {
        return selectWidgetList;
    }

    public WebElement getSelectWidget(String widgetName){
        return driver.findElement(By.xpath("//div[@class[contains(.,'pre-configured-widget-container')]]/span[contains(.,'"+widgetName+"')]"));
    }

    public WebElement getSelectWidgetPanelCloseButton() {
        return selectWidgetPanelCloseButton;
    }

    public WebElement getDashboardNameTextbox() {
        return dashboardNameTextbox;
    }

    public WebElement getWidgetDeleteButton(String widgetName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'dashboard-grid-item')]]//span[contains(.,'"+widgetName+"')][1]//following::em[@title='Remove'][1]"));
    }

    public WebElement getAddNewRulesButton() {
        return addNewRulesButton;
    }

    public WebElement getAddNewPolicyButton() {
        return addNewPolicyButton;
    }

    public WebElement getNewRuleForm() {
        return addNewRuleForm;
    }

    public List<WebElement> getPredefinedItemTypeForRules() {
        return predefinedTypeForRule;
    }

    public WebElement getPredefinedItemTypeForRules(String ruleName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'flex-row d-flex align-items-center border-bottom')]]/div/span[contains(.,'"+ruleName+"')]"));
    }

    public List<WebElement> getPredefinedRuleFactors() {
        return predefinedTypeForRuleFactors;
    }

    public WebElement getRuleItemTypeDropdwon(String dropdownName) {
        return driver.findElement(By.xpath("//*[@formcontrolname='" + dropdownName + "']"));
    }

    public WebElement getRuleItemTypeDropdwonAttribute(String attributeName) {
        return driver.findElement(By.xpath("//*[@formcontrolname='itemtype']//following::ul/li/a/span[contains(.,'"+attributeName+"')]"));
    }

    public WebElement getRuleItemTypeTextbox(String dropdownName) {
        return driver.findElement(By.xpath("//input[@formcontrolname[contains(.,'" + dropdownName + "')]]"));
    }
    public WebElement getUpdateRuleItemTypeTextbox(String dropdownName) {
        return driver.findElement(By.xpath("(//input[@formcontrolname[contains(.,'"+dropdownName+"')]])[2]"));
    }
    public WebElement getRuleFormSaveButton() {
        return ruleFormSaveButton;
    }

    public WebElement getFactorDeleteButton() {
        return factorDeleteButton;
    }

    public List<WebElement> getFactorRowUnderRule() {
        return factorRowUnderRuleForm;
    }

    public WebElement getRuleDeleteButton() {
        return ruleDeleteButton;
    }

    public WebElement getPageSubtitle(String subtitle) {
        return driver.findElement(By.xpath("//div[@class='sub-title'][contains(.,'" + subtitle + "')]"));
    }

    public List<WebElement> getColumnListInTable() {
        return tableColumnNameList;
    }

    public List<WebElement> getBAWidgetColumnList() {
        return BAWidgetColumnNameList;
    }

    public WebElement getAddDashboardIcon(String iconName) { return driver.findElement(By.xpath("//em[@title ='"+iconName+"']")); }

    public List<WebElement> getWidget(String widgetName) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'dashboard-grid-item')]][contains(.,'"+widgetName+"')][1]"));
    }

    public WebElement getWidgetLabels(String widgetName,String LabelName){
        return driver.findElement(By.xpath("//div[@class[contains(.,'dashboard-grid-item')]][contains(.,'"+widgetName+"')][1]//following::*[name()='g']//*[name()='text'][contains(.,'"+LabelName+"')]"));
    }
    public WebElement getConfigWidgetLabels(String LabelName){
        return driver.findElement(By.xpath("//div[contains(@class,'asg-dynamic-form-property-label-container')]//label[contains(.,'"+LabelName+"')]"));
    }
    public WebElement getPreConfiguredWidgets(String widgetName){
        return driver.findElement(By.xpath("//div[@class='heading'][contains(.,'"+widgetName+"')]"));
    }

    public WebElement getWidgetType(String widgetName, String widgetType){
        return driver.findElement(By.xpath("//span[contains(.,'"+widgetName+"')]//following::*[@class[contains(.,'"+widgetType+"')]]"));
    }

    public WebElement getTrustScore(String widgetName, String itemName){
        return driver.findElement(By.xpath("//span[contains(.,'"+widgetName+"')]//following::tbody/tr/td[contains(.,'"+itemName+"')]//following-sibling::td[1]"));
    }

    public WebElement getBusinessTrustScoreBAItem(String itemName) {
        return driver.findElement(By.xpath("//span[contains(.,'Business Applications with Trust')]//following::tbody/tr/td[contains(.,'"+itemName+"')]/a"));
    }

    public WebElement getWidgetSettingIcon(String widgetName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'dashboard-grid-item')]][contains(.,'"+widgetName+"')]/div/div/span/em[2]"));
    }

    public WebElement getWidgetRemoveIcon(String widgetName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'dashboard-grid-item')]][contains(.,'"+widgetName+"')]/div/div/span/em[1]"));
    }

    public WebElement getWidgetTitleTextbox() {
        return widgetTitleTextbox;
    }
    public WebElement getWidgetDescription() {
        return widgetDescriptionTextbox;
    }
    public WebElement getWidgetFieldErrorMessage() {
        return widgetFieldErrorMessage;
    }
    public WebElement getExcelImporterNameTextbox() {
        return excelImporterNameTextbox;
    }

    public WebElement getScopeLevelTextbox1() {
        return excelImportScopeAttributeTextBox;
    }

    public WebElement getConfigDashboardWidgetPanel() {
        return configDashboardWidgetPanel;
    }

    public WebElement getItemViewPageTitle(String itemName){
        return driver.findElement(By.xpath("//span[@class[contains(.,'asg-item-view-item-name')]][contains(.,'"+itemName+"')]"));
    }

    public WebElement getTableWidgetSortIcon(){
        return tableWidgetSortIcon;
    }

    public WebElement getDropdownButtonOfDashboardConfig(String fieldName) {
        return driver.findElement(By.xpath("//label[contains(.,'" + fieldName + "')]//following::em[@class='fa fa-chevron-down'][1]"));
    }

    public WebElement getDashboardConfigAttributes(String fieldName, String option) {
        return driver.findElement(By.xpath("//label[contains(.,'" + fieldName + "')]//following::ul/li/a/span[contains(.,'" + option + "')]"));
    }

    public WebElement getTrustPolicyValidationMessage() {
        return trustPolicyPageValidationMessage;
    }

    public WebElement getTagsTextbox() {
        return taggingPolicyTagTextbox;
    }

    public WebElement getDataPatternTextbox() {
        return taggingPolicyDataPatternTextbox;
    }

    public WebElement getTaggingPolicyTechnologiesTextbox() {
        return taggingPolicyTechnologiesTextbox;
    }

    public WebElement getSuggestedOptionInTaggingPage(String option) {
        return driver.findElement(By.xpath("//li[@class[contains(.,'tag-search-result-item')]][contains(.,'"+option+"')]"));
    }

    public List<WebElement> getDefaultOptionInTaggingpolicy(String fieldName) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'c-grey')]][contains(.,'"+fieldName+"')]//following::select[1]/option"));
    }

    public WebElement getOptionsInTaggingpolicyDropdown(String fieldName, String option) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::div[1]/ul//a/span[contains(.,'"+option+"')]"));
    }

    public WebElement getOptionsInTaggingpolicyDropdownForCategory(String fieldName, String option) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::ul[1]/li/span[contains(.,'"+option+"')]"));
    }

    public WebElement getTagRuleForm() {
        return tagRuleForm;
    }

    public WebElement getTaggingPolicyDropDown(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::button[1]/span/em"));
    }

    public WebElement getDisabledTaggingDropdown(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::button[1]"));
    }

    public WebElement getTaggingPolicyTextboxes(String fieldName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::input[1]"));
    }

    public WebElement getTaggingPolicyCheckbox(String fieldName) {
        return driver.findElement(By.xpath("//ui-switch[@formcontrolname='"+fieldName+"']/span/small"));
    }

    public List<WebElement> getTrustPolicyLabels(){
        return  trustPolicyLabels;
    }

    public List<WebElement> getTaggingPolicyLabels(){
        return  taggingPolicyLabels;
    }

    public List<WebElement> getmanageTagsList() {
        return manageTagsList;
    }
    public WebElement getEDIRolesAddButton() {
        return addEDIRolesnInManageDataSourcePage;
    }

    public WebElement getRoleAddButton() {
        return addRoleBtnInManageDataSourcePage;
    }

    public WebElement getAddDataSourceButton(){
        return addDataSourceButton;
    }

    public WebElement getAddCredentialButton(){
        return addCredentialButton;
    }

    public WebElement getDashboardWidgetConfigure(String Widgetname) {
        return driver.findElement(By.xpath("(//span[contains(text(),'" + Widgetname + "')]//following::em[@title='Configure'])[1]"));
    }

    public WebElement getTagCategoryIcon() {
        return driver.findElement(By.xpath("//span[@class='fa fa-tag']"));
    }

    public WebElement getHelperIcon() {
        return driver.findElement(By.xpath("//em[@class[contains(.,'fal fa-question-circle')]]"));
    }

    public WebElement getDocumentationLink(String Link) {
        return driver.findElement(By.xpath("//a[contains(.,'"+Link+"')]"));
    }
    public WebElement getTagCategoryColorIcon(String Page) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'tag-row border-tag')]]//span[contains(.,'"+Page+"')]//span"));
    }

    public WebElement getTagCategorySearchIcon() {
        return driver.findElement(By.xpath("//div[@class='searchbox-container w-100 m-2 text-right pr-5']//span[@class[contains(.,'fa fa-search')]]"));
    }

    public WebElement getTagSearchclose() {
        return driver.findElement(By.xpath("//em[@class='fa fa-close']"));
    }
    public WebElement getProfileIcon() {
        synchronizationVisibilityofElement(driver, profileIcon);
        return profileIcon;
    }

    public WebElement getProfileIconActive() {
        synchronizationVisibilityofElement(driver, profileIconActive);
        return profileIconActive;
    }

    public WebElement getAddCategoryButton() {
        return addCategoryButton;
    }

    public WebElement getAddPIICategoryButton() {
        return addPIICategoryButton;
    }

    public WebElement getAddCategoryTextBox(String textboxName) {
        return driver.findElement(By.xpath("//input[@id='"+textboxName+"']"));
    }

    public WebElement getTagIconSearchTextbox() {
        return driver.findElement(By.xpath("//input[@id='asgManageSearch']"));
    }

    public WebElement getIconHolderButton(){ return iconHolder; }

    public WebElement getIcon(String iconName) {
        return driver.findElement(By.xpath("//span[@class='"+iconName+"']/.."));
    }

    public WebElement getProtectedCheckbox() {
        return protectedCheckbox;
    }

    public WebElement getAddCategorySaveButton(){ return addCategorySaveButton; }

    public WebElement getAddCategoryAPPLYButton(){ return addCategoryApplyButton; }

    public WebElement getAddCategoryCancelButton(){ return addCategoryCancelButton; }

    public WebElement getCategoryPopupCancelButton(){ return categoryPopupCancelButton; }

    public WebElement getLeftNavigationMenuTooltip(String tooltipName) {
        return driver.findElement(By.xpath("//*[@role='tooltip'][contains(.,'"+tooltipName+"')]"));
    }

    public WebElement getDashboardSidebarLink() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'far fa-monitor')]]"));
    }

    public WebElement getTrustScoreFacetslist() {
        return driver.findElement(By.xpath("//div[@class='asg-facet-item-body clearfix showMore ng-star-inserted']//div[contains(.,'Upto 25')]"));
    }

    public WebElement GetProfileRole(String roleName) {
        return driver.findElement(By.xpath("//div[@title[contains(.,'"+roleName+"')]]"));
    }

    public WebElement getNewRolesName (String NewRole) {
        return driver.findElement(By.xpath("//span[@title='"+NewRole+"']"));
    }

    public WebElement getTechnoloyDataCount() {
        return driver.findElement(By.xpath("//*[@class='textDataLabel']"));
    }
    public WebElement getAlertText (String alertText) {
        return driver.findElement(By.xpath(""+alertText+""));
    }

    public WebElement getAdminSidebarLink() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'far fa-cog')]]"));
    }

    public WebElement getHomeSidebarLink() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'far fa-home')]]"));
    }

    public WebElement getCaptureAndImportDataSidebarLink() {
        return driver.findElement(By.xpath("//div[@class[contains(.,'left-navigation-item')]]/div/div/span[@class[contains(.,'far fa-download')]]"));
    }

    public WebElement getAddRoleButton() {
        return addRoleButton;
    }

    public List<WebElement> returnPermissionsList() {
        return permissionsList;
    }

    public WebElement getColorPalette() {
        return colorPalette;
    }

    public WebElement getSelectColorIcon() {
        return selectColorIcon;
    }

    public WebElement getSelectedColor() {
        return selectedColor;
    }


    public WebElement getTagIcon(String tagName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'tag-row border-tag')]]/span[1][contains(.,'"+tagName+"')]/span"));
    }

    public WebElement getCategoryMenuButtons(String tagName, String buttonName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'tag-row border-tag')]][contains(.,'"+tagName+"')]/span[2]/span[@title='"+buttonName+"']"));
    }

    public WebElement getVerifyTagIconResults(String tagName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'"+tagName+"')]]"));
    }

    public WebElement getTagExpandCollapseButton(String tagName) {
        return driver.findElement(By.xpath("//span[contains(.,'"+tagName+"')]/div/span"));
    }

    public List<WebElement> getSubTagsList(String tagName) {
        return driver.findElements(By.xpath("//span[contains(.,'"+tagName+"')]//following::div[@class[contains(.,'trigger-expandCollapse')]]/div"));
    }

    public WebElement getProtectedTagLockIcon(String tagName) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'fa fa-lock')]]/preceding::span[contains(.,'"+tagName+"')]"));
    }

    public WebElement getTagsInManageTagsPage(String tagName){
        return driver.findElement(By.xpath("//div[@class[contains(.,'tag-row border-tag')]]/span[1][contains(.,'"+tagName+"')]"));
    }

    public List<WebElement> getTagsInManageTagsPageDrop(String tagName){
        return driver.findElements(By.xpath("//div[@class[contains(.,'tag-row border-tag')]]/span[1][contains(.,'"+tagName+"')]"));
    }

    public WebElement getDashboardWidgets(String ItemName) {
        return driver.findElement(By.xpath("(//span[contains(@title,'" + ItemName + "')])[1]"));
    }

    public WebElement getSaveTag() {
        return driver.findElement(By.xpath("//button[@class='spinner-btn'][contains(text(),'SAVE')]"));
    }

    public WebElement getDropdownOptionsInPolicyRules(String fieldName, String option){
        return driver.findElement(By.xpath("//*[@formcontrolname='"+fieldName+"']/div/ul/li/a/span[contains(.,'"+option+"')]"));
    }

    public WebElement dataSourcefield(String fieldName) {
        return driver.findElement(By.xpath("(//label[contains(@class,'asg-dyn-form-property-label tooltip-indicator')][contains(text(),'"+fieldName+"')])"));
    }


    public WebElement getNotificationBellIcon() {
        return notificationBellIcon;
    }

    public WebElement getNotificationpage() {
        return notificationpage;
    }

    public List<WebElement> getnotificationList() {
        synchronizationVisibilityofElementsList(driver, notificationList);
        return notificationList;
    }

    public WebElement returnFirstOpenAreaLinkInNotification() {
        synchronizationVisibilityofElement(driver, openAreaLinksInNotifications,10);
        return openAreaLinksInNotifications;
    }

    public List<WebElement> getBlueCircleIconInnotification() {
        synchronizationVisibilityofElementsList(driver, blueCircleIconInNotification);
        return blueCircleIconInNotification;
    }

    public List<WebElement> getFirstBlueCircleIconInnotification() {
        synchronizationVisibilityofElementsList(driver, firstblueCircleIconInNotification);
        return firstblueCircleIconInNotification;
    }

    public WebElement getnotificationRightpanel(String itemName) {
        return driver.findElement(By.xpath("//div[@class='notifications']//div[@class[contains(.,'right-panel')]]//div[@class[contains(.,'"+itemName+"')]]"));
    }

    public List<WebElement> getNotificationFilterLabels(){
        return  notificationFilterLabels;
    }

    public WebElement getMarkAsReadDropDown() {
        return markAsReadDropDown;
    }

    public WebElement getActiveGreenLabelForNotification() {
        return activeGreenLabelForNotification;
    }

    public WebElement returnNotificationContent(String notiTitle, String notiContent){
        return driver.findElement(By.xpath("//div[@class[contains(.,'right-panel')]]/div/div[contains(.,'"+notiTitle+"')]//following::div[@class[contains(.,'content')]][contains(.,'"+notiContent+"')]"));
    }

    public WebElement getNotification(String notification) {
        return driver.findElement(By.xpath("//div[@class='notifications']//div[@class='left-panel']/div[3]/div[@class[contains(.,'notification')]][contains(.,'"+notification+"')][1]"));
    }

    public WebElement getBusinessApplicationLinkInContent() {
        return businessApplicationLinkInContent;
    }

    public WebElement getNotificationAvatar(String notification) {
        return driver.findElement(By.xpath("//div[@class='title'][contains(.,'"+notification+"')]//following-sibling::div/*[@class[contains(.,'avatar')]]"));
    }

    public WebElement getNotifcationDefaultContent() {
        return notifcationDefaultContent;
    }

    public WebElement getNotificationDropdownButton(String notificationfilter) {
        return driver.findElement(By.xpath("//span[contains(.,'"+notificationfilter+"')]//following::span/em"));
    }

    public WebElement getNotificationMarkAsReadDropdownButton() {
        return markAsReadDropdownButton;
    }

    public WebElement getLabelsInNotificationPanel(String label) {
        return driver.findElement(By.xpath("//span[contains(.,'"+label+"')]"));
    }

    public WebElement GetTrustScoreAtoZicon(){
        return driver.findElement(By.xpath("//strong[contains(., 'Trust Score')]//following::span[@class='fa float-right cursor-pointer mr-2 fa-sort-alpha-up inactive-state'][1]"));
    }

    public WebElement GetTrustScoreZtoAicon(){
        return driver.findElement(By.xpath("//strong[contains(., 'Trust Score')]//following::span[@class='fa float-right cursor-pointer mr-2 fa-sort-alpha-down-alt'][1]"));
    }
    public WebElement GetTrustScoreCheckbox(){
        return driver.findElement(By.xpath("//strong[contains(., 'Trust Score')]/..//div"));

    }
    public WebElement getExpandCollapseicon(){
        return driver.findElement(By.xpath("//strong[contains(., 'Trust Score')]/..//em"));
    }
    public WebElement GetProfileIcon(){
        return driver.findElement(By.xpath("//span[@class='hide-default-toggle cursor-pointer select-none dropdown-toggle']"));
    }

    public WebElement getEditNewRoles(){
        return driver.findElement(By.xpath("//td[contains(.,'Becubic Build')]//following::span[@class[contains(.,'far fa-edit')]][1]"));
    }

    public WebElement getTagDefault() {
        return defaultTag;
    }

    public WebElement getTagDefaultCheckBox() {
        return defaultTagCheckBox;
    }
    //

    public WebElement getLabelNameInPopUp(String labelName) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+labelName+"')]"));
    }

    public WebElement getColorIconInAddCategory() {
        return colorIconInAddCategory;
    }

    public WebElement getColorTextBoxInAddCategory() {
        return colorTextBoxInAddCategory;
    }

    public WebElement getColorPlate(String colorPlate) {
        return driver.findElement(By.cssSelector("canvas[class='"+colorPlate+"']"));
    }

    public WebElement getManageTagSaveButton() {
        synchronizationVisibilityofElement(driver, manageTagSaveButton);
        return manageTagSaveButton;
    }

    public WebElement getMenuButtonForTheItem(String itemName,String menuName) {
        return driver.findElement(By.xpath("//*[contains(text(),'"+itemName+"')][1]//following::span[@title='"+menuName+"'][1]"));
    }

    public WebElement getPopupCancelButton() {
        synchronizationVisibilityofElement(driver, popupCancelButton);
        return popupCancelButton;
    }

    public WebElement getTestUserNameFieldTextBox() {
        return testUserNameTextbox;
    }

    public WebElement getUserOrGroupNameFieldTextBox() {
        return userOrGroupNameFieldTextBox;
    }

    public List<WebElement> getDataPatternInTaggingPolicy(){
        return dataPatternInTaggingPolicy;
    }

    public List<WebElement> getPolicyDeleteInTaggingPolicy(){
        return policyDeleteInTaggingPolicy;
    }

    public WebElement getSearchResultsShowMoreIcon() {
        return searchResultsShowMoreIcon;
    }

    public WebElement getSearchResultsShowMoreOptions(String option) {
        return driver.findElement(By.xpath("//button[@role='menuitem']/span[contains(.,'"+option+"')]"));
    }

    public WebElement getCaptureandImportDataLink(String linkName) {
        return driver.findElement(By.xpath("//*[@title='"+linkName+"']"));
    }

    public WebElement getCronSchedulerTextbox(String Name){
        return driver.findElement(By.xpath("//input[@formcontrolname='"+Name+"']"));
    }

    public WebElement getAdminIcon() {
        return adminIcon;
    }

    public WebElement getTagsProtectedPopup() {
        return driver.findElement(By.xpath("//h4[contains(text(),'Protected Category')]"));
    }

    public WebElement getProtectedCheckBox() {
        return protectedTagCheckBox;
    }

    public WebElement getSelectColorTextBox() {
        return selectColorTextBox;
    }

    public WebElement getColorSlider() {
        return colorslider;
    }

    public WebElement getManageTagsCancel() {
        synchronizationVisibilityofElement(driver, manageTagsCancelButton);
        return manageTagsCancelButton;
    }

    public WebElement getManageTagsLabels(String label) {
        return driver.findElement(By.xpath("//label[contains(text(),'" + label + "')]"));
    }

    public WebElement getDashboardAttribute(String label) {
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+label+"')]//following::input"));
    }

    public WebElement getDashboardConfigureItemType(String label, String name) {
        return driver.findElement(By.xpath("//label[contains(text(),'" + label + "')]//following::span[contains(text(),'" + name + "')][1]"));
    }

    public WebElement getDashboardConfigureBusinessCriticalityPieChart(String name) {
        return driver.findElement(By.xpath("//div[@class='ngx-charts-outer ng-trigger ng-trigger-animationState']//*[name()='g'][@class='pie-grid chart']/*[name()='g']/*[name()='text'][2][contains(text(),'" + name + "')]"));
    }

    public List<WebElement> getAddConfigurationsTag() {
        return addConfigurationsTags;
    }

    public List<WebElement> getAddConfigurationsDataSourceTag() {
        return addConfigurationsDataSourceTags;
    }

    public WebElement getTaggingPolicyWholeword() {
        synchronizationVisibilityofElement(driver, taggingPolicyWholewordMatch);
        return taggingPolicyWholewordMatch;
    }

    public WebElement getPopup(String popUpName) {
        return driver.findElement(By.xpath("//h4[contains(.,'"+ popUpName +"')]"));
    }

    public void clickCaptureAndImportData() {
        waitForAngularLoad(driver);
        clickonWebElementwithJavaScript(driver,captureAndImportData);
    }

    public void clickDataScienceAndAnalytics() {
        waitForAngularLoad(driver);
        clickonWebElementwithJavaScript(driver, dataScienceAndAnalytics);
    }

    public WebElement getPageTitle() {
        return pageTitle;
    }

    public WebElement getWidgetdropdownValue(String label, String value ){
        return driver.findElement(By.xpath("//label[contains(text(),'"+label+"')]//following::span[contains(text(),'"+value+"')][1]"));
    }

    public WebElement getDefaultcheckboxDisabled() {
        synchronizationVisibilityofElement(driver, defaultCheckboxDisabled);
        return defaultCheckboxDisabled;
    }

    public WebElement getManageExcelImport(String importName ){
        return driver.findElement(By.xpath("//td[@title='"+importName+"']/ancestor::tr"));
    }
    public WebElement getFacetSelection(String type, String Value ){
        return driver.findElement(By.xpath("//div[@class='mx-1 tag-name cursor-pointer']/span[contains(.,'"+type+"')]//following-sibling::span[contains(.,'"+Value+"')]"));
    }
    public WebElement getHelperLayout(){
        return driver.findElement(By.xpath("//div[@class[contains(.,'help-content')]]"));
    }
    public List<WebElement> getLicensesList() {
        return licenseList;
    }

    public List<WebElement> getLicenseFieldList() {
        return licenseFieldList;
    }

    public WebElement getLicenseField(String fieldName ){
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::input[1]"));
    }

    public WebElement getLicenseSaveButton(String licenseName ){
        return driver.findElement(By.xpath("//span[@class='status-align icon-padding'][contains(.,'"+licenseName+"')]//following::span[@id='license_save']"));
    }

    public WebElement getLicenseDropdownButton(String fieldName ){
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::em[@class='fa fa-chevron-down']"));
    }

    public List<WebElement> getLicenseDropdownOptions(String fieldName ){
        return driver.findElements(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::ul/li/a"));
    }

    public WebElement getLicenseErrorMessageForField(String fieldName ){
        return driver.findElement(By.xpath("//label[@class[contains(.,'asg-dyn-form-property-label')]][contains(.,'"+fieldName+"')]//following::div[@class[contains(.,'error text')]]"));
    }

    public WebElement getLicenseStatus(String licenseName ){
        return driver.findElement(By.xpath("//span[@class='status-align icon-padding'][contains(.,'"+licenseName+"')]//following::div[@class[contains(.,'text-right')]]/span[1]"));
    }

    public WebElement getAuditLogSearchButton() {
        return driver.findElement(By.xpath("//span[@class[contains(.,'manage-search mr-3 fa fa-search cursor-pointer ng-star-inserted')]]"));
    }

    public WebElement getAuditLogSearchBox() {
        return driver.findElement(By.xpath("//span[@class[contains(.,'manage-search')]]//following::input"));
    }

    public WebElement getAuditTableSearchValues(String actionItem) {
        return driver.findElement(By.xpath("//div[@class='table']//following::td[@title='"+actionItem+"']"));
    }

    public WebElement getAuditLogRemoveSearchTextButton() {
        return driver.findElement(By.xpath("//span[@class[contains(.,'manage-search-close')]]"));
    }

    public WebElement getAuditLogDownloadLink() {
        return driver.findElement(By.xpath("//em[@class[contains(.,'fa-download')]]//following::span[contains(text(),'Download as CSV')]"));
    }

    public WebElement getAddBtnTaggingQueries(){
        return driver.findElement(By.xpath("//div/label[contains(.,' Tagging queries')]//following::div[contains(.,'Add')]"));
    }

    public WebElement getAuditTableItemTypeValue(String actionItem) {
        return driver.findElement(By.xpath("//div[@class='table']//tr[1]/following::td[@title='"+actionItem+"']//following-sibling::td[1]/span"));
    }
    public WebElement getAuditTableComponentValue(String actionItem) {
        return driver.findElement(By.xpath("//div[@class='table']//tr[1]/following::td[@title='"+actionItem+"']//following-sibling::td[3]/span"));
    }

    public WebElement getDashboardEllipsis() {
        synchronizationVisibilityofElement(driver, dashboardEllipsis);
        return dashboardEllipsis;
    }

    public List<WebElement> getRootTags() {
        return rootTags;
    }

    public List<WebElement> getSubTagsUnderCategory(String rootTag) {
        return driver.findElements(By.xpath("//div[@class[contains(.,'tag-section border-tag-bottom')]]//div[contains(.,'"+rootTag+"')]//following::div[@role='row']"));
    }

    public WebElement getExpandTagHierarchyButton(String tagHierarchy) {
        return driver.findElement(By.xpath("//div[@role='row'][contains(.,'"+tagHierarchy+"')]/span/div[1]"));
    }

    public List<WebElement> getAddIconInTagsPage(String rootTag) {
        return driver.findElements(By.xpath("//span[@class[contains(.,'title')]][contains(.,'"+rootTag+"')]//following-sibling::span/span[@class[contains(.,'add')]]"));
    }

    public WebElement getReadOnlyAccesstextInTagspage(String tagHierarchy) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'tag-row border-tag')]]//span[1][contains(.,'"+tagHierarchy+"')]//following::span[@class[contains(.,'readonly-access')]][1]"));
    }

    public List<WebElement> getAccessRequestsList() {
        return accessRequestsList;
    }

    public WebElement getAccessRequestsCount(String dataSetName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'table-row')]]/div/span[2]/strong[contains(.,'" + dataSetName + "')]/.."));
    }

    public List<WebElement> getNotificationByContent() {
        return notificationByContent;
    }

    public WebElement getClickHereLinkInNotification() {
        return clickHereLinkInNotification;
    }

    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void enterActions(String elementType, String text) {
        switch (elementType) {
            case "Search Area":
                enterUsingActions(driver, returntopSearchBox(), text);
                sleepForSec(800);
                break;
            case "Save Search Name textbox":
                enterUsingActions(driver, returnSaveSearchNameTextBox(), text);
                sleepForSec(800);
                break;
            case "Save Search description textbox":
                enterUsingActions(driver, returnSaveSearchDescriptionTextBox(), text);
                waitForAngularLoad(driver);
                break;
            case "Leading space in Save Search textbox":
                enterUsingActions(driver, returnSaveSearchNameTextBox(), text + " ");
                waitForAngularLoad(driver);
                break;
            case "Trailing space in Save Search textbox":
                enterUsingActions(driver, returnSaveSearchNameTextBox(), " " + text);
                waitForAngularLoad(driver);
                break;
            case "Bundles Search Area":
                enterText(returnBundlesSearchTextBox(), text);
                waitForAngularLoad(driver);
                break;
            case "Application ID":
                enterText(getAttributeTextbox(elementType), text);
                break;
            case "Dashboard Name":
                enterText(getDashboardNameTextbox(), text);
                break;
            case "Widget title textbox":
                enterText(getWidgetTitleTextbox(), text);
                break;
            case "Excel Importer Name":
                enterText(getExcelImporterNameTextbox(), text);
                break;
            case "Advance Mapping Attribute":
                clickOn(driver, getScopeLevelTextbox1());
                enterUsingActions(driver, getScopeLevelTextbox1(), text);
                break;
            case "Test User Name":
                enterText(getTestUserNameFieldTextBox(), text);
                break;
            case "User/Group Name":
                enterText(getUserOrGroupNameFieldTextBox(), text);
                break;
            case "TaggingPolicy":
                enterText(getExcelImporterNameTextbox(), text);
                break;
            case "Item Name":
                enterText(getTextBoxInCreatePage(elementType), text);
                break;
            case "Create Item Name Ignored":
                enterText(getTextBoxInCreatePage("Item Name"), " ");
                getTextBoxInCreatePage("Item Name").sendKeys(Keys.BACK_SPACE);
                break;
            case "Create Item Name with Leading Space":
                enterText(getTextBoxInCreatePage("Item Name"), "Test ");
                break;
            case "Create Item Name with Trailing Space":
                enterText(getTextBoxInCreatePage("Item Name"), " Test");
                break;
            case "Create Item Name with Forward slash":
                enterText(getTextBoxInCreatePage("Item Name"), "\\Test");
                break;
            case "Create Item Name with Backward Slash":
                enterText(getTextBoxInCreatePage("Item Name"), "/Test");
                break;
        }
    }

    public void genericMouseHover(String elementType, String... dynamicItem) {
        switch (elementType) {
            case "Settings Icon":
                moveToElement(driver, getAdminSidebarLink());
                waitForAngularLoad(driver);
                break;
            case "Add Source Button in Manage Data Sources Page":
                moveToElement(driver, getAddSourceButtonInManageDataSourcePage());
                waitForAngularLoad(driver);
                break;
            case "Bundles":
                moveToElement(driver, getBundle(dynamicItem[0]));
                waitForAngularLoad(driver);
                break;
            case "Data Discovery":
                moveToElement(driver,getappicon());
                waitForAngularLoad(driver);
                break;
            case "Sidebar Link":
                if(dynamicItem[0].equalsIgnoreCase("Dashboard")) {
                    moveToElement(driver, getDashboardSidebarLink());
                }else if(dynamicItem[0].equalsIgnoreCase("Admin")) {
                    moveToElement(driver, getAdminSidebarLink());
                }else if(dynamicItem[0].equalsIgnoreCase("Home")) {
                    moveToElement(driver, getHomeSidebarLink());
                }else if(dynamicItem[0].equalsIgnoreCase("Create")) {
                    moveToElement(driver, getCreateButton());
                }else if(dynamicItem[0].equalsIgnoreCase("Capture and Import Data")) {
                    moveToElement(driver, getCaptureAndImportDataSidebarLink());
                }
                waitForAngularLoad(driver);
                break;
            case "Capture And Import Data Icon":
                moveToElement(driver, getCaptureAndImportDataSidebarLink());
                waitForAngularLoad(driver);
                break;
        }
    }

    public void genericClick(String elementName, String... dynamicItem) {

        try {
            switch (elementName) {
                case "Administration":
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver, returnDashboardLink(elementName));
                    while (true) {
                        if (getElementText(returnActiveDashboard()).equals(elementName)) {
                            break;
                        } else {
                            clickonWebElementwithJavaScript(driver, returnDashboardLink(elementName));
                        }
                    }
                    waitUntilJSReady(driver);
                    break;

                case "CreateButton":
                    clickonWebElementwithJavaScript(driver,getCreateButtonLink());
                    sleepForSec(1500);
                    break;

                case "QAAutDashBoard":
                    waitUntilJSReady(driver);
                    clickonWebElementwithJavaScript(driver,returnDashboardLink(elementName));
                    waitUntilJSReady(driver);
                    break;
                case "CATALOG MANAGER":
                    clickOn(driver, getWidgetManagerLink(elementName));
                    break;
                case "ITEM AND LIST VIEW MANAGER":
                    scrolltoElement(driver, getWidgetManagerLink(elementName), true);
                    waitUntilJSReady(driver);
                    clickOn(getWidgetManagerLink(elementName));
                    waitUntilJSReady(driver);
                    break;
                case "PLUGIN MANAGER":
                    scrolltoElement(driver, getWidgetManagerLink(elementName), true);
                    clickOn(driver, getWidgetManagerLink(elementName));
                    waitUntilJSReady(driver);
                    sleepForSec(1000);
                    break;
                case "ROLES AND GROUP MANAGER":
                    scrolltoElement(driver, getWidgetManagerLink(elementName), true);
                    clickOn(driver,getWidgetManagerLink(elementName));
                    break;
                case "globalSearchButton":
                    clickOn(returngetTopSearchIcon());
                    sleepForSec(500);
                    break;
                case "firstItemCheckbox":
                    clickonWebElementwithJavaScript(driver,getFirstItemCheckbox());
                    sleepForSec(500);
                    break;
                case "Home Button":
                    clickOn(getHomeButton());
                    break;
                case "LogOut button":
                    Click_profileLogoutButton();
                    break;
                case "notification_icon":
                    sleepForSec(500);
                    clickOn(driver,Click_notificationsIcon());
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    break;
                case "openFirstNotification":
                    clickOn(returnFirstOpenAreaLinkInNotification());
                    sleepForSec(1000);
                    break;
                case "APPROVE":
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getworkflowpossibleActionsButton());
                    synchronizationVisibilityofElementsList(driver, new SubjectArea(driver).getworkflowActionsList());
                    clickOn(driver,traverseListContainsElementReturnsElement(new SubjectArea(driver).getworkflowActionsList(), elementName));
                    synchronizationVisibilityofElement(driver,new SubjectArea(driver).getworkflowActionsSubmitButton());
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getworkflowActionsSubmitButton());
                    break;
                case "REJECT":
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getworkflowpossibleActionsButton());
                    synchronizationVisibilityofElementsList(driver, new SubjectArea(driver).getworkflowActionsList());
                    clickOn(driver,traverseListContainsElementReturnsElement(new SubjectArea(driver).getworkflowActionsList(), elementName));
                    synchronizationVisibilityofElement(driver,new SubjectArea(driver).getworkflowActionsSubmitButton());
                    clickonWebElementwithJavaScript(driver, new SubjectArea(driver).getworkflowActionsSubmitButton());
                    break;
                case "showAll_Button":
                    clickonWebElementwithJavaScript(driver,getShowAllButtonIn_DashboardPage());
                    break;
                case "type":
                    clickonWebElementwithJavaScript(driver,clickType(dynamicItem[0]));
                    break;
                case "remove Search Text Button":
                    clickonWebElementwithJavaScript(driver,getremoveSearchTextButtonWithoutSync());
                    break;
                case "top Search Icon":
                    clickOn(returngetTopSearchIcon());
                    break;
                case "Spreadsheet import finished!":
                    clickOnOpenStatisticLinkForTheNotification(elementName);
                    break;
                case "close_notificationTab":
                    sleepForSec(500);
                    clickOn(driver,Click_NotificationExtBtn());
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    break;
                //10.3 New UI
                case "Settings Icon":
//                    moveToElement(driver,getSettingsIcon());
//                    sleepForSec(300);
                    clickSettingsIcon();
                    sleepForSec(1500);
                    break;
                case "AGREE":
                    clickLicenseButton(elementName);
                    break;
                case "EXIT":
                    clickLicenseButton(elementName);
                    break;
//                case "Global Search Icon":
//                    clickOn(getGlobalSeacrhIcon());
//                    break;
                case "Search Button":
                    clickOn(getSearchButton());
                    sleepForSec(3000);
                    break;
                case "Search Area":
                    clickOn(returntopSearchBox());
                    waitForAngularLoad(driver);
                case "Advanced Settings":
                    clickOn(returnAdvancedSettings());
                    waitForAngularLoad(driver);
                case "Header text":
                    clickOn(driver, getHeaderText());
                    break;

                case "Manage Configurations":
                    clickOn(driver,getManageDataConfigSubMenu());
                    break;
                case "Manage Data Sources":
                    sleepForSec(1500);
                    synchronizationVisibilityofElement(driver, getManageDataSourceSubMenu());
                    waitForAngularLoad(driver);
                    if (isElementPresent(manageDataSourceActive))
                        break;
                    else
                        clickOn(driver, getManageDataSourceSubMenu());
                    sleepForSec(1500);
                    break;
                case "Manage Credentials":
                    clickOn(driver,getManageCredentialsSubMenu());
                    break;
                case "Manage Bundles":
                case "Manage Access":
                case "Manage Roles":
                case "Manage Users & Groups":
                    clickOn(driver,getAdminLinks(elementName));
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    break;
                case "Excel Importer":
                    clickOn(driver,getAdminLinks(elementName));
                    sleepForSec(1500);
                    break;

                case "Manage Excel Imports":
                    clickOn(driver,getAdminLinks(elementName));
                    sleepForSec(1500);
                    break;

                case "Add Excel Import":
                    clickOn(driver,getAddExcelImportButton(elementName));
                    break;

                case "Trust Policy":
                    clickOn(getAdminLinks(elementName));
                    sleepForSec(1500);
                    break;
                case "Add Source Button":
                    clickOn(getAddSourceButton());
                    break;
                case "Add Data Source Button in Manage Data Sources Page":
                    waitForAngularLoad(driver);
                    clickOn(driver,getAddDataSourceButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add Credentials Button in Manage Credentials Page":
                    clickOn(driver,getAddCredentialButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add Button in Manage Bundles Page":
                case "Add Pipelines Button in Manage Pipelines Page":
                    waitForAngularLoad(driver);
                    clickOn(getAddSourceButtonInManageDataSourcePage());
                    sleepForSec(1500);
                    break;
                case "Add New Rule":
                    clickOn(driver, getAddNewRulesButton());
                    break;
                case "Add New Policy":
                    clickOn(driver,getAddNewPolicyButton());
                    waitForAngularLoad(driver);
                    break;
                case "Save":
                    synchronizationVisibilityofElement(driver, getDataSourcesAndCredentialsSaveButton());
                    clickonWebElementwithJavaScript(driver,getDataSourcesAndCredentialsSaveButton());
                    sleepForSec(1000);
                    break;
                case "Save and Open":
                    synchronizationVisibilityofElement(driver, getDataSourcesAndCredentialsSaveButton());
                    clickOn(getSaveandOPenButton());
                    sleepForSec(1000);
                    break;
                case "START":
                    clickOn(driver, getWelcomePageStartButton().get(0));
                    break;
                case "Profile Image":
                    clickOn(driver,getProfileImage());
                    waitForAngularLoad(driver);
                    break;
                case "Profile":
                    clickOn(driver,getProfileSetting());
                    waitForAngularLoad(driver);
                    break;
                case "Save button":
                    clickOn(getProfileSettingSaveButton());
                    //waitForAngularLoad(driver);
                    break;
                case "Test Connection":
                    clickOn(driver,getTestConnectionButton());
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    break;
                case "Filter Icon":
                    clickOn(getFilterIconInDSPage());
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    break;
                case "Catalog Drop down":
                    clickOn(getHeaderCatalogDropDown());
                    break;
                case "BigData":
                    clickOn(driver, getDropdowncatalogName(elementName));
                    break;
                case "Report":
                    clickOn(driver, getReporticon());
                    break;
                case "Next Button":
                    clickOn(driver, getStep1popUpNextButton());
                    waitForAngularLoad(driver);
                    break;
                case "Finish button":
                    clickOn(driver, getFinishButton());
                    waitForAngularLoad(driver);
                    break;
                case "Cancel button":
                    actionClick(driver, getCancelButton());
                    waitForAngularLoad(driver);
                    break;
                case "Close button":
                    clickOn(driver, getCloseButtonInpopUp());
                    waitForAngularLoad(driver);
                    break;
                case "Search Cross button":
                    clickOn(getSearchCrossButton());
                    waitForAngularLoad(driver);
                    break;
                case "Run Search dropdown":
                    clickonWebElementwithJavaScript(driver,getSearchDropdownButton());
                    waitForAngularLoad(driver);
                    break;
                case "Run Recent Search":
                case "Run Saved Search":
                    clickOn(driver,getSearchType(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Popup Close button":
                    clickOn(driver,getCloseButtonInpopUp());
                    waitForAngularLoad(driver);
                    break;
                case "Sort Icon":
                    clickOn(driver, getSortIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Table Widget Sort Icon":
                    clickOn(driver, getTableWidgetSortIcon());
                    waitForAngularLoad(driver);
                    break;
                case "ConfigSave":
                    clickOn(driver, getAddConfigSaveButton());
                    waitForAngularLoad(driver);
                    sleepForSec(3000);
                    break;
                case "Pipeline plugin Config Save":
                    clickOn(driver,getPipelinepluginConfigSave());
                    waitForAngularLoad(driver);
                    break;
                case "Confirm":
                    clickOn(getConfirmDeleteButton());
                    waitForAngularLoad(driver);
                    sleepForSec(3000);
                    break;
                case "Close":
                    clickOn(driver, getCloseicon());
                    break;
                case "SAVE SEARCH":
                    clickOn(driver, getSaveSearchButton());
                    break;
                case "Type Dropdown":
                    clickOn(driver, getTypeDropDownButton());
                    break;
                case "Save Search Save Button":
                    clickOn(driver,getSaveSearchSaveButton());
                    break;
                case "Save Search Result":
                    clickOn(driver, getSaveSearchResultButton());
                    waitForAngularLoad(driver);
                    break;
                case "Run":
                    clickOn(driver, getRunSearchResultButton());
                    waitForAngularLoad(driver);
                    break;
                case "DELETE SAVED SEARCH":
                    clickOn(driver, deleteSavedSearchButton());
                    waitForAngularLoad(driver);
                    break;
                case "View Link":
                    clickOn(driver, getViewLinkForMetadataField(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Item View Title":
                    clickOn(driver, getItemViewPageTitle());
                    waitForAngularLoad(driver);
                    break;
                case "Collapse":
                    clickOn(driver, getCollapseButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Uncollapse":
                    clickOn(driver, getUncollapseButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "widget belongining":
                    clickOn(driver, getWidegtBelongingLink(dynamicItem[0], dynamicItem[1]));
                    waitForAngularLoad(driver);
                    break;
                case "first widget belongining":
                    clickOn(driver, getFirstWidgetBelonging(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Sort Icon for Name Column in Widgets":
                    clickOn(driver, getNameSortIcon(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Manage Bundles Search":
                    clickOn(driver, getBundlesSearchButton());
                    waitForAngularLoad(driver);
                    break;
                case "Expand Bundle":
                    clickOn(driver, getBundleExpandButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Collapse Bundle":
                    clickOn(driver, getBundleCollapseButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Bundle Search exit":
                    clickOn(driver, getBundleSearchExitButton());
                    waitForAngularLoad(driver);
                    break;
                case "Bundle Sort Icon":
                    clickOn(driver, getBundleSortIcon(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Bundle Delete Button":
                case "Manage Access Delete Button":
                case "Manage Credentials Delete Button":
                    moveToElement(driver, getBundleDeleteButton(dynamicItem[0]));
                    clickOn(driver, getBundleDeleteButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Bundles Cancel button":
                    clickOn(driver, getBundlesCancelButton());
                    waitForAngularLoad(driver);
                    break;
                case "Popup Cancel button":
                    clickOn(driver, getBundlesCancelButton());
                    waitForAngularLoad(driver);
                    break;
                case "PopUp X":
                    clickOn(getPopUpXButton());
                    waitForAngularLoad(driver);
                    break;
                case "Bundles DELETE button in Popup":
                    clickOn(getBundlesPopupDeleteButton());
                    waitForAngularLoad(driver);
                    break;
                case "DELETE":
                    clickOn(getBundlesPopupDeleteButton());
                    waitForAngularLoad(driver);
                    break;
                case "CANCEL":
                    clickOn(getCancelButtonInPopUp());
                    waitForAngularLoad(driver);
                    break;
                case "Manage Access tab":
                    traverseListContainsElementAndClick(driver, getManageAccessTab(), dynamicItem[0]);
                    waitForAngularLoad(driver);
                    break;
                case "Add Local User":
                    clickOn(driver,getAddLocalUserButton());
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    break;
                case "Manage Access Edit Button":
                    moveToElement(driver, getBundleEditButton(dynamicItem[0]));
                    clickOn(driver,getBundleEditButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Manage Access title":
                    clickOn(driver,getManageAccessTitle());
                    waitForAngularLoad(driver);
                    break;
                case "BROWSE FILES":
                    clickOn(driver, getBrowsefilesbutton());
                    waitForAngularLoad(driver);
                    break;
                case "Drag and Drop":
                    clickOn(driver, getDragAndDropFrame());
                    waitForAngularLoad(driver);
                    break;
                case "SAVE":
                    clickOn(driver, getBundleSavebutton());
                    waitForAngularLoad(driver);
                    break;
                case "Add Category Save":
                    clickonWebElementwithJavaScript(driver, getManageTagSaveButton());
                    waitForAngularLoad(driver);
                    break;
                case "No":
                    waitForAngularLoad(driver);
                    actionClick(driver, getButtonpopup(elementName));
                    break;
                case "Yes":
                    clickOn(driver, getButtonpopup(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "UNASSIGN":
                    clickOn(driver, getButtonpopup(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "similar":
                    clickOn(driver,getSimiliarwidget(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Most frequent values":
                    clickOn(driver,getSimiliarwidget(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Assign existing configuration":
                    clickOn(driver, getAssignExistingConfiguration());
                    waitForAngularLoad(driver);
                    break;
                case "Value":
                    clickOn(driver,getMFVwidgetTable(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Assign":
                    waitForAngularLoad(driver);
                    clickOn(driver,getTagPageAssignButton());
                    waitForAngularLoad(driver);
                    break;
                case "Create new Business Application":
                case "Import Business Application via Excel file":
                    clickOn(driver, getWelcomePageButtons(elementName));
                    break;
                case "Item View page Edit Buttons":
                    waitForAngularLoad(driver);
                    clickOn(driver, getItemViewEditButtons(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Item view Tab":
                    clickOn(driver, getItemViewPageTabs(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Capture new data":
                    clickOn(driver, getCaptureNewDataButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add Plugin Configuration button":
                    waitUntilJSReady(driver);
                    sleepForSec(1000);
                    clickOn(driver, getAddPluginConfigurationButton());
                    waitForAngularLoad(driver);
                    break;
                case "plugin widget expand/collapse button":
                    clickOn(getWidgetCollapseButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "plugin data element":
                    clickOn(getPluginDataElement(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Dashboard dropdown":
                    moveToElement(driver, getDashboardDropdown());
                    waitForAngularLoad(driver);
                    clickOn(driver, getDashboardDropdown());
                    waitForAngularLoad(driver);
                    break;
                case "Sidebar Link":
                    waitForAngularLoad(driver);
                    if(dynamicItem[0].equalsIgnoreCase("Dashboard")) {
                        clickOn(driver, getDashboardSidebarLink());
                    }else if(dynamicItem[0].equalsIgnoreCase("Admin")) {
                        clickOn(driver, getAdminSidebarLink());
                    }else if(dynamicItem[0].equalsIgnoreCase("Home")) {
                        clickOn(driver, getHomeSidebarLink());
                    }else if(dynamicItem[0].equalsIgnoreCase("Create")) {
                        clickOn(driver, getCreateButton());
                    }else if(dynamicItem[0].equalsIgnoreCase("Capture and Import data")) {
                        clickCaptureAndImportData();
                       waitForAngularLoad(driver);
                    }else {
                        throw new Exception();
                    }
                    waitForAngularLoad(driver);
                    break;
                case "Dashboard settings Icon":
                    clickOn(driver, getDashboardSettingsIcon());
                    sleepForSec(1000);
                    break;
                case "Dashboard toolbar Icon":
                    clickOn(driver, getDashboardToolbarIcons(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Select Widget":
                    clickonWebElementwithJavaScript(driver,getSelectWidget(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Select widget panel close":
                    clickOn(driver, getSelectWidgetPanelCloseButton());
                    break;
                case "Widget Delete Button":
                    clickOn(driver, getWidgetDeleteButton(dynamicItem[0]));
                    break;
                case "DashBoard":
                    clickonWebElementwithJavaScript(driver, getDashboradButton());
                    waitForAngularLoad(driver);
                    break;
                case "Admin Link":
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    clickOn(driver, getAdminSettingsIcon());
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    scrolltoElement(driver, getAdminLinks(dynamicItem[0]), true);
                    waitForAngularLoad(driver);
                    sleepForSec(1500);
                    clickOn(driver, getAdminLinks(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Add Button in Manage Excel Imports Page":
                    clickOn(getAddSourceButtonInManageDataSourcePage());
                    waitForAngularLoad(driver);
                    break;
                case "Dashboard page Icons":
                    clickOn(driver, getAddDashboardIcon(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Dashboard list":
                    WebElement element = traverseListContainsElementReturnsElement(getDashboardList(),dynamicItem[0]);
                    clickOn(element);
                    waitForAngularLoad(driver);
                    break;
                case "Widget settings Icon":
                    clickOn(driver, getWidgetSettingIcon(dynamicItem[0]));
                    break;
                case "Widget Remove Icon":
                    clickOn(driver, getWidgetRemoveIcon(dynamicItem[0]));
                    break;
                case "Select preconfigured Widget":
                    clickOn(driver, getDashboardAddWidgetIcon());
                    waitForAngularLoad(driver);
                    clickOn(driver,getPreConfiguredWidgets(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver,getSelectWidget(dynamicItem[1]));
                    break;
                case "Business Applications with Trust Score BA Item":
                    clickOn(driver, getBusinessTrustScoreBAItem(dynamicItem[0]));
                    break;
                case "Add Category":
                    clickOn(driver, getAddCategoryButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add PII Category":
                    moveToElement(driver, getAddPIICategoryButton());
                    clickOn(driver, getAddPIICategoryButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add Role":
                    clickOn(driver, getAddRoleButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add Test User":
                    clickOn(driver, getAddRoleButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add User Or Group":
                    clickOn(driver, getAddRoleButton());
                    waitForAngularLoad(driver);
                    break;
                case "Manage Roles Edit Button":
                    moveToElement(driver, getBundleEditButton(dynamicItem[0]));
                    clickOn(driver,getBundleEditButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Expand/Collapse Tag Button":
                    clickOn(getTagExpandCollapseButton(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "SaveTag":
                    clickonWebElementwithJavaScript(driver,getSaveTag());
                    waitForAngularLoad(driver);
                    break;
                case "Add EDIRoles Button":
                    clickOn(getEDIRolesAddButton());
                    break;
                case "Add Role Button":
                    clickOn(getRoleAddButton());
                    break;
                case "Dashboard widget type":
                    clickOn(driver, getPreConfiguredWidgets(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "slide bar":
                    clickOn(driver, clickSlidebarfor(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "field":
                    clickOn(driver, dataSourcefield(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;

                case "Trust score Sort Ascending ":
                    clickonWebElementwithJavaScript(driver,(GetTrustScoreAtoZicon()));
                    waitForAngularLoad(driver);
                    break;
                case "Trust score Sort Descending ":
                    clickonWebElementwithJavaScript(driver,(GetTrustScoreZtoAicon()));
                    waitForAngularLoad(driver);
                    break;
                case "Header Trust score check box":
                    clickonWebElementwithJavaScript(driver,GetTrustScoreCheckbox());
                    waitForAngularLoad(driver);
                    break;
                case "ExpandCollapse icon":
                    clickonWebElementwithJavaScript(driver, getExpandCollapseicon());
                    waitForAngularLoad(driver);
                    break;
                case "Profile Icon":
                    clickonWebElementwithJavaScript(driver,GetProfileIcon());
                    waitForAngularLoad(driver);
                    break;
                case "edit of new roles":
                    clickonWebElementwithJavaScript(driver, getEditNewRoles());
                    waitForAngularLoad(driver);
                    break;
                case "click configuration menu buttons":
                    moveToElementWithActions(driver, getMenuButtonForTheItem(dynamicItem[1], dynamicItem[0]));
                    clickOn(driver, getMenuButtonForTheItem(dynamicItem[1], dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Popup Cancel":
                    scrolltoElement(driver,getPopupCancelButton(),true);
                    clickOn(driver, getPopupCancelButton());
                    waitForAngularLoad(driver);
                    break;
                case "Popup Close":
                    clickOn(driver, getCloseicon());
                    break;
                case "Search Results Show more":
                    clickOn(driver, getSearchResultsShowMoreIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Search Results Show more options":
                    clickOn(driver, getSearchResultsShowMoreIcon());
                    waitForAngularLoad(driver);
                    clickOn(driver, getSearchResultsShowMoreOptions(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Capture And Import Data Icon":
                    clickOn(driver, getCaptureAndImportDataSidebarLink());
                    waitForAngularLoad(driver);
                    break;
                case "Capture and Import Data & Configure":
                    genericClick("Capture And Import Data Icon");
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    scrolltoElement(driver, getCaptureandImportDataLink(dynamicItem[0]), true);
                    waitForAngularLoad(driver);
                    clickOn(driver, getCaptureandImportDataLink(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Refresh":
                    clickOn(driver,getRefreshIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Select All":
                    clickOn(driver, getSelectAll());
                    waitForAngularLoad(driver);
                    break;
                case "Show the data elements in a list":
                    String text1= getElementText(new DashBoardPage(driver).getTechnoloyDataCount());
                    CommonUtil.storeText(text1);
                    clickOn(driver,getShowAllElement(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "completeness Widget":
                    clickOn(driver,getCompletenessWidget());
                    waitForAngularLoad(driver);
                    break;
                case "close  Icon":
                    clickOn(driver, getCloseIcon());
                    waitForAngularLoad(driver);
                    break;
                case "WidgetCollapseIcon":
                    clickOn(driver, getWidgetCollapseIcon());
                    waitForAngularLoad(driver);
                    break;
                case "WidgetExpandIcon":
                    clickOn(driver, getWidgetExpandIcon());
                    waitForAngularLoad(driver);
                    break;
                case "Becubic Build":
                    clickOn(driver, getBAownerName(elementName));
                    waitForAngularLoad(driver);
                    break;
                case "Capture and Import Data Link":
                    genericClick("Capture And Import Data Icon");
                    waitForAngularLoad(driver);
                    sleepForSec(1000);
                    scrolltoElement(driver, getCaptureandImportDataLink(dynamicItem[0]), true);
                    waitForAngularLoad(driver);
                    clickOn(driver, getCaptureandImportDataLink(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    sleepForSec(500);
                    break;
                case "Widget Configure":
                    clickOn(driver, getDashboardWidgetConfigure(dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "DefaultCheckbox":
                    waitForAngularLoad(driver);
                    boolean status=getTagDefaultCheckBox().isSelected();
                    if(status==false){
                        actionClick(driver,getTagDefaultCheckBox());
                    }
                    break;
                case "ProtectedCheckBox":
                    waitForAngularLoad(driver);
                    boolean protectedstatus=getProtectedCheckBox().isSelected();
                    if(protectedstatus==false){
                        actionClick(driver,getProtectedCheckBox());
                    }
                    break;
                case "ManageTagSCancel":
                    actionClick(driver, getManageTagsCancel());
                    break;
                case "TraverseandClickTags":
                    traverseListContainsElementAndClick(driver,new DashBoardPage(driver).getAddConfigurationsTag(),dynamicItem[0]);
                    break;
                case "TaggingPolicyIgnoreEmptyandNull":
                    waitForAngularLoad(driver);
                    actionClick(driver, getTaggingPolicyWholeword());
                    break;
                case "ProfileLogOut":
                    actionClick(driver, getProfileIcon());
                    break;
                case "Add Bundles Button":
                    clickOn(getAddBundlesButton());
                    waitForAngularLoad(driver);
                    break;
                case "Add button in Tagging Queries":
                    clickOn(driver, getAddBtnTaggingQueries());
                    waitForAngularLoad(driver);
                    break;
                case "Item type option":
                    clickOn(driver, getAttributeInDropdown("Item Type", dynamicItem[0]));
                    break;
                case "Verify facet selection":
                    waitForAngularLoad(driver);
                    clickOn(driver, getFacetSelection(dynamicItem[0],dynamicItem[1]));
                    break;
                case "TagIcon":
                    waitForAngularLoad(driver);
                    clickOn(driver, getTagCategoryIcon());
                    break;
                case "Helper":
                    clickOn(driver,getHelperIcon());
                    break;
                case "Data Discovery Documentation":
                    waitForAngularLoad(driver);
                    clickOn(driver,getDocumentationLink(elementName));
                    break;
            }
        } catch (Exception | AssertionError e) {
            LoggerUtil.logLoader_info(this.getClass().getName(),elementName +" case validation failed");
            takeScreenShot(this.getClass().getName(),driver);
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }


    public void genericEnterText(String elementName, String text) {
        try {
            switch (elementName) {
                case "globalSearchBox":
                    enterText(returntopSearchBox(), text);
                    sleepForSec(1000);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyEquals(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Request for Access for SalesDataSets1 DataSet and BigData Catalog has been sent by TestDataConsumer":
                    verifyTrue(traverseListContainsElementText(new DashBoardPage(driver).getnewNotificationsContentList(), elementName));
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }


    public void genericSelect(String elementType, String... arg) {
        try {
            switch (elementType) {
                case "globalCatalogSelect":
                    clickonWebElementwithJavaScript(driver, catalogDropDown);
                    clickonWebElementwithJavaScript(driver, traverseListContainsElementReturnsElement(catalogList, arg[0]));
                    sleepForSec(1000);
                    clickOn(driver, returngetTopSearchIcon());
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Issue in identifying element");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Issue in identifying element");
        }


    }

    public WebElement ItemViewManagement(String elementName) {
        // synchronizationVisibilityofElement(driver, itemViewManagement);
        scrolltoElement(driver, getWidgetManagerLink(elementName), true);
        return getWidgetManagerLink(elementName);
    }

    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "Search":
                    Assert.assertTrue(isElementPresent(returntopSearchBox()));
                    break;
                case "QuickStart":
                    Assert.assertTrue(isElementPresent(getquickStartDashboard()));
                    break;
                //10.3 New UI
                case "Settings Icon":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSettingsIcon()));
                    break;
                case "Create":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getCreateButton()));
                    break;

                case "Welcome message under settings icon":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWelcomePage()));
                    break;
                case "Add Source Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getAddSourceButton()));
                    break;
                case "Add New Rules Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getAddNewRulesButton()));
                    break;
                case "License panel":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getLicensePage()));
                    break;
                case "Header text":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getHeaderText()));
                    break;
//                case "Global Search Icon":
//                    takeScreenShot(elementName+" is captured", driver);
//                    Assert.assertTrue(isElementPresent(getGlobalSeacrhIcon()));
//                    break;
                case "Header profile Icons":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getHeaderProfileIcons()));
                    break;
                case "Search Block":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getHeaderSearchBlock()));
                    break;
                case "Search Area":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(returntopSearchBox()));
                    break;
                case "Catalog dropdown":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getHeaderCatalogDropDown()));
                    break;
                case "Search Cross button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getSearchCrossButton()));
                    break;
                case "Search Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getSearchButton()));
                    break;
                case "Expanded sidebar":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getExpandedSidebar().get(0)));
                    break;
                case "Hidden Global Search Icon":
                    takeScreenShot(elementName+" is captured", driver);
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementEnabled(getHiddenGlobalSearchButton()));
                    break;
                case "Add Data Source pop up":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getAddDataSourcePopUp()));
                    break;
                case "Data Source Configuration properties":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getConfigurationPropertiesInAddDataSourcePae().get(0)));
                    break;
                case "START":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getWelcomePageStartButton().get(0)));
                    break;
                case "Step 1: Add Data Source with Credential":
                case "Step 2: Add Configuration to LocalNode":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getPopupTitle(elementName)));
                    break;
                case "Alert":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getAlertMessageInProfileSetting(dynamicItem[0])));
                    break;
                case "Manage Configurations Page":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageConfigurationsPage()));
                    break;
                case "Manage Data Sources page":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageDataSourcesPage()));
                    break;
                case "Manage Excel Imports page":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageExcelImportsPage()));
                    break;
                case "Successful datasource connection":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getSuccessConnectionMessage()));
                    break;
                case "Failed datasource connection":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getFailureConnectionMessage()));
                    break;
                case "plugin completion popup":
                    takeScreenShot(elementName+" is captured", driver);
                    verifyTrue(isElementPresent(getPluginCompletionPopUp().get(0)));
                    break;
                case "All":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getcatalogName(elementName)));
                    break;
                case "Count":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(Searchresultscount(elementName)));
                    break;
                case "None":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(GetSortOptions(elementName)));
                    break;
                case "Run Recent Search table":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getRunRecentTableContent()));
                    break;
                case "View":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(GetViewicon()));
                    break;
                case "catalog search result":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getCatalogSearchResult(dynamicItem[0])));
                    waitForAngularLoad(driver);
                    break;
                case "verifies the selected attributes":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSelectedAttributesInSearchResult(dynamicItem[0],dynamicItem[1])));
                    waitForAngularLoad(driver);
                    break;
                case "Edit Configuration to LocalNode Page":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getEditConfigurationHeader()));
                    break;
                case "Clone Configuration to LocalNode":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getCloneConfigurationHeader()));
                    break;
                case "Plugin":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getChangedDDName_Plugin()));
                    break;
                case "Clone Credential":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getCloneCredentialHeader()));
                    break;
                case "Edit Credential":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getEditCredentialHeader()));
                    break;
                case "Select the plugin type and enter details to add a configuration.":
                case  "Enter details for a data source and credential. Then test that connection.":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent((getContextualMessage(elementName))));
                    break;
                case  "Enter details to add a category":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent((getContextualMessage(elementName))));
                    break;
                case "Clone Data Source":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent((getCloneDataSourceHeader())));
                    break;
                case "Edit Data Source":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent((getEditDataSourceHeader())));
                    break;
                case "Select plugin":
                case "Select data source type":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(((getPlaceHolderText()))));
                    break;
                case "All Catalogs":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(((getChangedName()))));
                    break;
                case "BETA":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getVersionText()));
                    break;
                case "View Link for metadata field":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getViewLinkForMetadataField(dynamicItem[0])));
                    break;
                case "Valid json in tooltip":
                    takeScreenShot(elementName+" is captured", driver);
                    String actualContent = getTooltipContentInItemViewPage().get(0).getText();
                    Assert.assertTrue(CommonUtil.isJSONValid(actualContent));
                    break;
                case "Metadata widget":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getMetadataContainer()));
                    break;
                case "widget presense":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getItemViewWidget(dynamicItem[0])));
                    break;
                case "Widget Header Title presense":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getItemViewWidgetHeaderTitle(dynamicItem[0]).get(0)));
                    break;
                case "New tab opened":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(verifyNewTabIsOpened(driver));
                    break;
                case "Add Bundles Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getAddBundlesButton()));
                    break;
                case "Manage Bundles Title and description":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageBundlesTitle()));
                    break;
                case "Bundles Header Count":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getManageBundlesHeaderCount(dynamicItem[0])));
                    break;
                case "Bundle Delete Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getBundleDeleteButton(dynamicItem[0])));
                    break;
                case "Contextual message":
                    takeScreenShot(elementName + " is captured", driver);
                    String actuaText = getElementText(getContextualMessage());
                    Assert.assertTrue(actuaText.equalsIgnoreCase(dynamicItem[0]));
                    break;
                case "Create new Business Application":
                case "Import Business Application via Excel file":
                case "Create a configuration and load new data":
                case "List of Business Applications":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWelcomePageButtons(elementName)));
                    break;
                case "Item View Widget":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWidgetContainer(dynamicItem[0]).get(0)));
                    break;
                case "Hidden Item View Widget":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWidgetContainerHidden(dynamicItem[0]).get(0)));
                    break;
                case "Table Widget Container":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getTableWidgetContainer(dynamicItem[0]).get(0)));
                    break;
                case "Row list count":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getRowlistCount(dynamicItem[0])));
                    break;
                case "Data Elements widget":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getDataElementwidget()));
                    break;
                case "Plugin config name title":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPluginConfigTitle(dynamicItem[0])));
                    break;
                case "Plugin Element Count":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPluginConfigElementCount(dynamicItem[0])));
                    break;
                case "Plugin Data Cataloged Labels":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWidgetCatalogedItemlabels(dynamicItem[0])));
                    break;
                case "Your Rating":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getYourRatingAboveAverageRating()));
                    break;
                case "Search page Improvements":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getSelectAllLabelDisplayed()));
                    Assert.assertTrue(isElementPresent(getSelectedItemOnlyLabel()));
                    Assert.assertTrue(isElementPresent(getAssignUnassignTags()));
                    break;
                case "New Rule Form":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getNewRuleForm()));
                    break;
                case "Rule for Item Type":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPredefinedItemTypeForRules(dynamicItem[0])));
                    break;
                case "verifies widgets":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWidget(dynamicItem[0]).get(0)));
                    break;
                case "Verify Label presence":
                    if (dynamicItem[0].equalsIgnoreCase("License Usage") && dynamicItem[2] != "") {
                        if (dynamicItem[1].equalsIgnoreCase("Limit Color")) {
                            takeScreenShot(elementName + "is captured", driver);
                            String Value=getAttributeValue(getLicenseChartUsage(dynamicItem[0], 3),"style");
                            Assert.assertEquals(Value, "fill: " + dynamicItem[2] + ";");
                        } else if (dynamicItem[1].equalsIgnoreCase("Used Color")) {
                            takeScreenShot(elementName + "is captured", driver);
                            String Value=getAttributeValue(getLicenseChartUsage(dynamicItem[0], 3),"style");
                            Assert.assertEquals(Value, "fill: " + dynamicItem[2] + ";");
                        } else {
                            takeScreenShot(elementName + " is captured", driver);
                            Assert.assertTrue(isElementPresent(getWidgetLabels(dynamicItem[0], dynamicItem[1])));
                        }
                    } else {
                        takeScreenShot(elementName + " is captured", driver);
                        Assert.assertTrue(isElementPresent(getConfigWidgetLabels(dynamicItem[0])));
                    }
                    break;
                case "verifies preconfigured widgets":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getPreConfiguredWidgets(dynamicItem[0])));
                    break;
                case "verify Widget chart type":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWidgetType(dynamicItem[0],dynamicItem[1])));
                    break;
                case "verify trust score":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getElementText(getTrustScore(dynamicItem[0],dynamicItem[1])).contains(dynamicItem[2]));
                    break;
                case "Item view page title":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getItemViewPageTitle(dynamicItem[0])));
                    break;
                case "Contextual Message":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getContextualMessage(dynamicItem[0])));
                    break;
                case "Left Menu tootip":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getLeftNavigationMenuTooltip(dynamicItem[0])));
                    break;
                case "Predefined Tagging Rule Type":
                case "Predefined Item Type":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(traverseListContainsText(getPredefinedItemTypeForRules(), dynamicItem[0]));
                    break;
                case "Rule for Plugin Type":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(traverseListContainsText(getPredefinedItemTypeForRules(), dynamicItem[0]));
                    break;
                case "New tab is not opened":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(verifyNewTabIsOpened(driver));
                    break;
                case "Facet filters of Trust":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getTrustScoreFacetslist()));
                    break;
                case "Business Owner":
                case "Technology Owner":
                case "Relationship Owner":
                case "Security Owner":
                case "Compliance Owner":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(GetProfileRole(elementName)));
                    waitForAngularLoad(driver);
                    break;
                case "Property label":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getLabelNameInPopUp(dynamicItem[0])));
                    break;
                case "Color Icon":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getColorIconInAddCategory()));
                    break;
                case "becubic_build":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getNewRolesName(elementName)));
                    waitForAngularLoad(driver);
                    break;
                case "Verify License Widget":
                    String Value = null;
                    if (dynamicItem[1].equalsIgnoreCase("DataSource Color code")) {
                        takeScreenShot(elementName + "is captured", driver);
                        Value=getAttributeValue(getLicenseChartUsage(dynamicItem[0], 3),"style");
                        Assert.assertEquals(Value, "fill: " + dynamicItem[2] + ";");
                    } else if (dynamicItem[1].equalsIgnoreCase("Lineage Color code")) {
                        takeScreenShot(elementName + "is captured", driver);
                        Value=getAttributeValue(getLicenseChartUsage(dynamicItem[0], 3),"style");
                        Assert.assertEquals(Value, "fill: " + dynamicItem[2] + ";");
                    }else {
                        Assert.fail("Element not found" + driver);
                    }
                    break;
                case "Alert text":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getAlertText(dynamicItem[0])));
                    waitForAngularLoad(driver);
                    break;
                case "Technology Count":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getTechnoloyDataCount()));
                    waitForAngularLoad(driver);
                case "Show the data elements in a list":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getShowAllElement(elementName)));
                    break;
                case "Data Asset":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getcompletenessWigdetName(elementName)));
                    break;
                case "No data available":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getNoDataInfotext(elementName)));
                    break;
                case "New Configuration":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getconfigurationType(elementName)));
                    break;
                case"Verify Pipeline Page":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getconfingpiplineButtons(dynamicItem[0],dynamicItem[1])));
                    break;
                case "Verify plugin config in pipeline":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getConfingInPipline(elementName)));
                    break;
                case "Verify Label Items":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getPipelineListinfo(dynamicItem[0],dynamicItem[1])));
                    break;
                    case "Tag Categories":
                    Assert.assertTrue(isElementPresent(getTagDefault()));
                    break;
                case "ProtectedTagCheckBox":
                    Assert.assertTrue(isElementPresent(getProtectedCheckbox()));
                    break;
                case "ProtectedTagPopup":
                    Assert.assertTrue(isElementPresent(getTagsProtectedPopup()));
                    break;
                case "DefinitionIcon":
                    Assert.assertTrue(isElementPresent(getIconHolderButton()));
                    break;
                case "Verify Configure Widget Attribute":
                    String criticality=getAttributeValue(getDashboardAttribute(dynamicItem[0]),"value");
                    Assert.assertEquals(dynamicItem[1],criticality);
                    break;
                case "Verify Configure Widget ItemType":
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(getDashboardConfigureItemType(dynamicItem[0], dynamicItem[1])));
                    break;
                case "Businesscriticality Piechart":
                    Assert.assertTrue(isElementPresent(getDashboardConfigureBusinessCriticalityPieChart(dynamicItem[0])));
                    break;
                case "Popup":
                    waitForAngularLoad(driver);
                    Assert.assertTrue(isElementPresent(getPopup(dynamicItem[0])));
                    break;
                case "verify Widget Dropdown Values":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getWidgetdropdownValue(dynamicItem[0],dynamicItem[1])));
                    break;
                case "Itemtypes":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getDataModelItemTypesTable(elementName)));
                    break;
                case "SchemaCount":
                    takeScreenShot(elementName +" is captured", driver);
                    Assert.assertTrue(isElementPresent(getDataModelItemsCount()));
                    break;
                case "Verify Highlighted Excel Import":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getManageExcelImport(dynamicItem[0]).getCssValue("color").equals(dynamicItem[1]));
                    break;
                case "Verify Dashboard Validation text":
                    enterText(getDashboardNameTextbox(), " ");
                    keyPressEvent(driver, Keys.BACK_SPACE);
                    Assert.assertTrue(getElementText(getTrustPolicyValidationMessage()).contains(dynamicItem[1]));
                    break;
                case "Forbidden validation message":
                    if(dynamicItem[2].equalsIgnoreCase("Leading Space")){
                        enterText(getDashboardNameTextbox(), " Test");
                    } else if (dynamicItem[2].equalsIgnoreCase("Trailing Space")){
                        enterText(getDashboardNameTextbox(), "Test ");
                    } else if (dynamicItem[2].equalsIgnoreCase("Forward Slash")){
                        enterText(getDashboardNameTextbox(), "/Test");
                    } else if (dynamicItem[2].equalsIgnoreCase("Backward Slash")){
                        enterText(getDashboardNameTextbox(), "\\\\Test");
                    }
                    Assert.assertTrue(getElementText(getTrustPolicyValidationMessage()).contains(dynamicItem[1]));
                    break;
                case "Dashboard Ellipsis":
                    Assert.assertTrue(returnblankLink().getCssValue("text-overflow").equals("ellipsis"));
                    break;
                case "Item view Tab":
                    Assert.assertTrue(isElementPresent(getItemViewPageTabs(dynamicItem[0])));
                    waitForAngularLoad(driver);
                    break;
                case "Verify facet selection":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getFacetSelection(dynamicItem[0],dynamicItem[1])));
                    break;
                case "Helper Layout":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(getHelperLayout()));
                    break;
                    }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }

    }

    public void isElementContainsTheNotificationProperties(String panelName, String notificationTitle, String section, String propertyName, String expectedText) throws Exception {
        try {
            switch (panelName) {
                case "NOTIFICATION DETAILS":
                    Assert.assertTrue(getdynamicPropertyInNotificationDetailsPanel(notificationTitle,section,propertyName).getText().contains(expectedText));
                    break;
                case "SPREADSHEET IMPORT ISSUES":
                    String actalText = jsonRead.readJSon("ImportErrorsAndWarnings", expectedText);
                    Assert.assertTrue(isElementPresent(getsectionDataContentInNotificationPanel(notificationTitle,section,actalText)));
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementNotPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                //10.3 New UI
                case "Search Area":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(getHeaderSearchAreakAsList().isEmpty());
                    break;
                case "Expanded sidebar":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(getExpandedSidebar().isEmpty());
                    break;
                case "Data Source Configuration properties":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(getConfigurationPropertiesInAddDataSourcePae().isEmpty());
                    break;
                case "START":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(getWelcomePageStartButton().isEmpty());
                    break;
                case "Search Text":
                    takeScreenShot(elementName +" is captured", driver);
                    String actualText = getElementText(returntopSearchBox());
                    Assert.assertTrue(actualText.equalsIgnoreCase(""));
                    break;
                case "View":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementPresent(GetViewicon()));
                    break;
                case "Valid json in tooltip":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getTooltipContentInItemViewPage().isEmpty());
                    break;
                case "Create":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getLeftMenus(elementName).isEmpty());
                    break;
                case "Admin":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getLeftMenus(elementName).isEmpty());
                    break;
                case "Sidebar Admin Links":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getSidebarAdminLinks().isEmpty());
                    break;
                case "Table Widget Container":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getTableWidgetContainer(dynamicItem[0]).isEmpty());
                    break;
                case "Default Option selected":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementPresent(getDefaultSelectedOption(dynamicItem[0],dynamicItem[1])));
                    break;
                case "Default BA Option selected":
                    takeScreenShot(elementName + " is captured", driver);
                    if(dynamicItem[0].equalsIgnoreCase("Profile Date")){
                        String pattern = "yyyy-MM-dd";
                        String currentDate = CommonUtil.getCurrentDate(pattern);
                        Assert.assertTrue(getElementText(getBADefaultSelectedOption(dynamicItem[0])).equals(currentDate));
                    }
                    Assert.assertTrue(getElementText(getBADefaultSelectedOption(dynamicItem[0])).contains(dynamicItem[1]));
                    break;
                case "Default BA Item type selected":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getElementText(getBADefaultSelectedItemType(dynamicItem[0])).contains(dynamicItem[1]));
                    break;
                case "Catalog type":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(traverseListContainsElement(getCatalogvalueInSearchResults(), "Catalog"));
                    break;
                case "verifies widgets absence":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getWidget(dynamicItem[0]).isEmpty());
                    break;
                case "verifies dashboard absence in dropdown":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(traverseListContainsElement(getDashboardList(),dynamicItem[0]));
                    break;
                case "Configuration dashboard widget panel":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isElementPresent(getConfigDashboardWidgetPanel()));
                    break;
                case "verifies Trust Policy Rules Item Type BA absence":
                    boolean status;
                    try {
                        clickOn(driver, traverseListContainsElementReturnsElement(getPredefinedItemTypeForRules(), dynamicItem[0]));
                        waitForAngularLoad(driver);
                        status = true;
                    } catch (Exception e) {
                        e.printStackTrace();
                        status = false;
                    }
                    Assert.assertFalse(status);
                    break;
                case "Tagging Policy Default Option":
                    takeScreenShot(elementName + " is captured", driver);
                    String actualValue = getElementText(getDefaultOptionInTaggingpolicy(dynamicItem[0]).get(0));
                    Assert.assertTrue((actualValue.equalsIgnoreCase(dynamicItem[1])));
                    break;
                case "Tag Rule form":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(isElementPresent(getTagRuleForm()));
                    break;
                case "verify label absense":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertFalse(traverseListContainsElement(getTaggingPolicyLabels(), dynamicItem[0]));
                    break;
                case "Facet filters of Trust":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(isElementPresent(getTrustScoreFacetslist()));
                    break;
                case "Verify plugin config in pipeline":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertFalse(isElementPresent(getConfingInPipline(elementName)));
                    break;
                case "verifies non mandatory field":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertTrue(traverseListContainsText(getConfigurationLabelsAsList(),dynamicItem[0]));
                    break;
                case "Save Dashboard":
                    takeScreenShot(elementName +"Is captured", driver);
                    Assert.assertFalse(getDashboardToolbarIcons(elementName).getAttribute("class").contains("disabled"));
                    break;
                case "Item view Tab":
                    waitForAngularLoad(driver);
                    Assert.assertFalse(traverseListContainsElementText(getItemViewPageTabsinList(),dynamicItem[0]));
                    waitForAngularLoad(driver);
                    break;
                case "Data Science and Analytics title":
                    Assert.assertTrue(elementName.contains(getElementText(getPageTitle())));
                    break;
                case "Helper Layout":
                    takeScreenShot(elementName + "is captured", driver);
                    Assert.assertFalse(isElementPresent(getHelperLayout()));
                    break;

            }
        } catch (NoSuchElementException e) {
            //Assert.fail(e.getMessage() + "Element not found ");
            LoggerUtil.logLoader_info("Element Not found" + e.getMessage(), e.getLocalizedMessage());
        }

    }

    public void genericVerifyElementIsEnabled(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                //10.3 New UI
                case "Save button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementEnabled(getSaveButton()));
                    break;
                case "Next Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementEnabled(getStep1popUpNextButton()));
                    break;
                case "Test Connection":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertTrue(isElementEnabled(getTestConnectionButton()));
                    break;
                case "Dashboard Save Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getDashboardConfigSaveButton()));
                    break;
                case "Default Checkbox Enabled and not selected":
                    waitForAngularLoad(driver);
                    boolean status;
                    if (isElementPresent(getDefaultcheckboxDisabled())) {
                        status = true;
                    } else {
                        status = false;
                    }
                    Assert.assertTrue(status);
                    Assert.assertTrue(isElementSelected(getTagDefaultCheckBox()));
                    break;
                case "Save and Open Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(isElementEnabled(getSaveandOPenButton()));
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
                case "Save Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getDataSourcesAndCredentialsSaveButton()));
                    break;

                case "Assign Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getTagPageAssignButton()));
                    break;
                case "Save and Open Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getSaveandOPenButton()));
                    break;
                case "Save Search Save Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getSaveSearchSaveButton()));
                    break;
                case "Next Button":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getStep1popUpNextButton()));
                    break;
                case "Test Connection":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getTestConnectionButtonDisabled()));
                    break;
                case "Dashboard Save Button":
                    takeScreenShot(elementName + " is captured", driver);
                    Assert.assertTrue(getDashboardConfigSaveButton().getAttribute("class").contains("disabled"));
                    break;
                case "Color Textbox":
                    takeScreenShot(elementName+" is captured", driver);
                    Assert.assertFalse(isElementEnabled(getColorTextBoxInAddCategory()));
                    break;
                case "Edit Icon":
                    takeScreenShot(elementName +"Is captured", driver);
                    Assert.assertTrue(isElementEnabled(getBAEditIconDisabled()));
                    break;
                    case "Default Checkbox":
                    Assert.assertTrue(isElementPresent(getDefaultcheckboxDisabled()));
                    break;
                case "SelectColor":
                    waitForAngularLoad(driver);
                    Assert.assertFalse(isElementEnabled(getSelectColorTextBox()));
                    break;
                case "Save Dashboard":
                    takeScreenShot(elementName +"Is captured", driver);
                    Assert.assertTrue(getDashboardToolbarIcons(elementName).getAttribute("class").contains("disabled"));
                    break;
            }
        } catch (NoSuchElementException e) {
            Assert.fail(e.getMessage() + "Element not found ");
            LoggerUtil.logLoader_info("Element Not found" + e.getMessage(), e.getLocalizedMessage());
        }

    }

    public boolean isElementListPresentInNotificationPanel(String section, List<String> listValues, String... elementType) throws Exception {
        boolean flag = false;
                for (String property : listValues) {
                    if (traverseListContainsText(getNotificationLabels(section), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
        return flag;
    }

    public boolean doesElementsPresentInList(List<String> listValues, String... elementType) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();
        switch (elementType[0]) {
            case "Admin":
                for (String submenu : listValues) {
                    if (traverseListContainsElement(getSidebarSubMenuAsList(), submenu) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Search":
                for (String submenu : listValues) {
                    if (traverseListContainsElement(getSearchSubMenuAsList(), submenu) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "AmazonRedshiftDataSource":
            case "AmazonS3DataSource":
                for (String expValue : listValues) {
                    expected.add(expValue);
                }
                for (WebElement label : configurationLabelsAsList) {
                    actual.add(label.getText().toString().replaceAll("\\*", ""));
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(),""+expected);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(),""+actual);
                Collections.sort(expected);
                Collections.sort(actual);
                if (CommonUtil.compareLists(actual, expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Add DataSource popup Labels":
                for (String labels : listValues) {
                    if (traverseListContainsText(getConfigurationLabelsAsList(),labels)) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "BA Multi tab":
                for (String submenu : listValues) {
                    if (traverseListContainsElement(getBAMultiTabMenuAsList(), submenu) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "verifies Tree Sructure of Tags":
                for (String subTag : listValues) {
                    if (traverseListContainsElementText(getSubTagsList(elementType[1]), subTag) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "verifies protected lock icon":
                try {
                    for (String tags : listValues) {
                        Assert.assertTrue(isElementPresent(getProtectedTagLockIcon(tags)));
                        flag = true;
                    }
                } catch (Exception e) {
                    throw new Exception();
                }
                break;
            case "Default PII Rules":
                for (String piiRules : listValues) {
                    if (traverseListContainsElementTextViaAttribute(getDataPatternInTaggingPolicy(), piiRules, "value")) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Audit Table Headers":
                for (String property : listValues) {
                    if (traverseListContainsElement(getAuditTableHeaders(), property) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
        }
        return flag;
    }

    public void verifySelectsFilter(String elementName, String... dynamicItem) throws Exception {
        switch (elementName) {
            case "Catalog":
                clickflatfilterType(dynamicItem[0]);
                break;
                case "MetaData Type":
                if (getShowAllButtonFilterPage()) {
                    clickonWebElementwithJavaScript(driver, getShowAll_facetFilter_Button());
                    clickfilterType(dynamicItem[0]);
                } else {
                    sleepForSec(500);
                    clickfilterType(dynamicItem[0]);
                }
                break;
            case "Hierarchy":
            case "PII":
                clickHierarcyType(dynamicItem[0]);
                break;
            case "Tags":
                clickTagType(dynamicItem[0]);
                break;
            case "Last Modified":
            case "Trust Score":
                clickflatfilterType(dynamicItem[0]);
                break;
            case "verifies the selected attributes":
                genericVerifyElementPresent(elementName, dynamicItem[0],dynamicItem[1]);
                break;
            case "Verify facet selection":
                genericVerifyElementPresent(dynamicItem[0],dynamicItem[1]);
                break;
        }
    }

    public void selectAttributesFromTheDropdown(String fieldName, String option) throws Exception {
        waitForAngularLoad(driver);
        sleepForSec(1000);
        if (fieldName.equalsIgnoreCase("Deployment")) {
            moveToElement(driver, getDropdownButtonOfTheField(Constant.NodeFieldNameInAddDataSource));
            clickOn(driver, getDropdownButtonOfTheField(Constant.NodeFieldNameInAddDataSource));
            waitForAngularLoad(driver);
            scrolltoElement(driver, getAttributeInDropdown(Constant.NodeFieldNameInAddDataSource, option), true);
            waitForAngularLoad(driver);
            clickOn(driver, getAttributeInDropdown(Constant.NodeFieldNameInAddDataSource, option));
        } else {
            moveToElement(driver, getDropdownButtonOfTheField(fieldName));
            clickOn(driver, getDropdownButtonOfTheField(fieldName));
            waitForAngularLoad(driver);
            scrolltoElement(driver, getAttributeInDropdown(fieldName, option), true);
            waitForAngularLoad(driver);
            moveToElement(driver, getAttributeInDropdown(fieldName, option));
            clickOn(driver, getAttributeInDropdown(fieldName, option));
            waitUntilJSReady(driver);
            waitForAngularLoad(driver);
        }
    }

    public void selectcreatepageDropdown(String fieldName, String option) throws Exception {
        moveToElement(driver, getCreatepageDropdownButtonOfTheField());
        clickOn(getCreatepageDropdownButtonOfTheField());
        waitForAngularLoad(driver);
        scrolltoElement(driver, getAttributeInDropdown(fieldName, option),true);
        clickOn(driver, getAttributeInDropdown(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void addOwnersInBusinessappl(String fieldName, String option) throws Exception {
        List<String> expected = new ArrayList<>();
        String[] attr = option.split(",");
        for(String exp:attr)
        {
            expected.add(exp);
        }
        int expectedsize= expected.size();
        for(int i=0;i<expectedsize;i++) {
            enterText(getTextBoxInCreatePage(fieldName), expected.get(i));
            clickonWebElementwithJavaScript(driver, getOwnersInCreatePage(fieldName,expected.get(i)));
        }
    }

    public void deleteOwnersInBusinessappl(String fieldName, String option) throws Exception {
        List<String> expected = new ArrayList<>();
        String[] attr = option.split(",");
        for(String exp:attr)
        {
            expected.add(exp);
        }
        int expectedsize= expected.size();
        for(int i=0;i<expectedsize;i++) {
            enterText(getTextBoxInCreatePage(fieldName), expected.get(i));
            clickonWebElementwithJavaScript(driver, deleteOwnersInCreatePage(fieldName,expected.get(i)));
        }
    }

    public void enterTextInAddDataSourcePage(String fieldName, String inputText, String... arg) throws Exception {
        if (fieldName.equalsIgnoreCase("Credential Name")) {
            waitForAngularLoad(driver);
            enterText(getCredentialNameTextBox(), inputText);
            waitForAngularLoad(driver);
        }  else if (arg[0] != null && !arg[0].isEmpty()) {
            if (arg[0].equalsIgnoreCase("PropertyLoader")) {
                waitForAngularLoad(driver);
                enterText(getTextBoxInManageDataSources(fieldName), propLoader.prop.getProperty(inputText));
                waitForAngularLoad(driver);
            }
        }else if (fieldName != null) {
            enterText(getTextBoxInManageDataSources(fieldName), inputText);
            waitForAngularLoad(driver);
        } else {
            throw new Exception();
        }
    }

    public void enterTextInPipelinePage(String fieldName, String actionItem,String inputText, String... arg) throws Exception {
        if (fieldName.equalsIgnoreCase("Name")) {
            waitForAngularLoad(driver);
            enterText(getPipelineNameTextBox(),inputText);
            waitForAngularLoad(driver);
        }else if(fieldName.equalsIgnoreCase("Description")){
            waitForAngularLoad(driver);
            enterText(getPipelineDescriptionTextbox(),inputText);
            waitForAngularLoad(driver);
        }else if(fieldName.equalsIgnoreCase("Verify Cron scheduler")){
            clearTextWithJavaScript(driver,getCronSchedulerTextbox(actionItem));
            enterText(getCronSchedulerTextbox(actionItem),inputText);
            waitForAngularLoad(driver);
        }
    }

    public void clickInPipelinePage(String fieldName, String actionItem, String itemName) throws Exception {
        if (fieldName.equalsIgnoreCase("Select plugin type")) {
            waitForAngularLoad(driver);
            clickOn(getPluginType(actionItem, itemName));
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("Select plugin")) {
            waitForAngularLoad(driver);
            clickOn(getPluginName(actionItem, itemName));
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("configurationType")) {
            clickOn(getconfigurationType(actionItem));
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("verify pipeline page")) {
            clickOn(getconfingpiplineButtons(actionItem, itemName));
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("verify pipeline page")) {
            clickOn(getconfingpiplineButtons(actionItem, itemName));
            waitForAngularLoad(driver);
        } else if (fieldName.equalsIgnoreCase("Remove pipeline config")) {
            clickOn(getRemovepipelineconfig(actionItem));
            waitForAngularLoad(driver);
        }
    }



    public void verifyPlaceHolder(String fieldName, String message,String option) throws Exception {
        if (option.equalsIgnoreCase("Dropdown")) {
            String text = getElementText(getdropdownPlaceholdermessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), message + " validation message is displayed under the field");
            Assert.assertEquals(message,text.trim());
        } else {
           String text = getAttributeValue(gettextboxPlaceholdermessage(message),"placeholder");
            Assert.assertEquals(message,text.trim());
            waitForAngularLoad(driver);
        }
    }

    public void selectAttributeInProfileSettingPageFromTheDropdown(String fieldName, String option) throws Exception {
        moveToElement(driver, getDropdownButtonOfTheFieldInProfileSetting(fieldName));
        clickonWebElementwithJavaScript(driver, getDropdownButtonOfTheFieldInProfileSetting(fieldName));
        waitForAngularLoad(driver);
        clickOn(driver, getAttributeInDropdownInProfileSetting(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void selectDataSourceTypeFromTheDropdown(String fieldName, String option) throws Exception {
        clickOn(driver, getDropdownButtonOfTheTypeFieldInDSPage(fieldName));
        waitForAngularLoad(driver);
        clickOn(driver, getTypeFromDropdownInDSPage(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void selectBundleTypeFromTheDropdown(String fieldName, String option) throws Exception {
        if(fieldName.equalsIgnoreCase("Version")){
            clickOn(driver, getDropdownButtonOfTheTypeFieldInBundlePage(fieldName));
            waitForAngularLoad(driver);
            String value = CommonUtil.getText().replace("-",".");
            clickonWebElementwithJavaScript(driver, getTypeFromDropdownInBundlePage(fieldName, value));
            waitUntilJSReady(driver);
            waitForAngularLoad(driver);
        }else {
            clickOn(driver, getDropdownButtonOfTheTypeFieldInBundlePage(fieldName));
            waitForAngularLoad(driver);
            clickOn(driver, getTypeFromDropdownInBundlePage(fieldName, option));
            waitUntilJSReady(driver);
            waitForAngularLoad(driver);
        }
    }

    public void selectFilterTypeFromTheDropdown(String fieldName, String option) throws Exception {
        clickOn(driver, getDropdownButtonOfTheTypeFieldInManageDSPage(fieldName));
        waitForAngularLoad(driver);
        clickOn(driver, getTypeFromDropdownInManageDSPage(fieldName, option));
        waitUntilJSReady(driver);
        waitForAngularLoad(driver);
    }

    public void unCollapseDropdown(String fieldName, String option) throws Exception {
        clickOn(driver, getDropdownButtonOfTheTypeFieldInDSPage(fieldName));
        waitForAngularLoad(driver);
        moveToElement(driver,getTypeFromDropdownInDSPage(fieldName,option));
        waitForAngularLoad(driver);
    }

    public void selectBAAttributesDropdown(String fieldName, String option) throws Exception {
        clickOn(driver, getDropdownButtonOfBAAttributesInItemViewPage(fieldName));
        waitForAngularLoad(driver);
        clickOn(driver, getAttributesOptionInItemViewPage(fieldName, option));
        waitForAngularLoad(driver);
    }

    public void selectDashboardConfigDropdown(String fieldName, String option) throws Exception {
        clickOn(driver, getDropdownButtonOfDashboardConfig(fieldName));
        waitForAngularLoad(driver);
        clickOn(driver, getDashboardConfigAttributes(fieldName, option));
        waitForAngularLoad(driver);
    }

    public void CreateItem(String fieldName, String attribute, String option, String description) throws Exception {
        clickonWebElementwithJavaScript(driver, getCreatepageDropdownButtonOfTheField());
        waitForAngularLoad(driver);
        clickOn(driver, getAttributeInDropdown("Item Type", fieldName));
        waitForAngularLoad(driver);
        enterText(getTextBoxInCreatePage("Item Type"), attribute);
        sleepForSec(500);
        if (description != null) {
            enterText(getDescriptionTextBoxInCreatePopup(), description);
            waitForAngularLoad(driver);
        }
        if (option.equalsIgnoreCase("Save")) {
            clickOn(getDataSourcesAndCredentialsSaveButton());
            waitForAngularLoad(driver);
        } else {
            clickOn(getSaveandOPenButton());
            waitForAngularLoad(driver);
        }
    }

    public boolean validateElementPresense(String actionToBeVerified, List<String> data) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionToBeVerified) {
            case "DataSource list":
            case "Bundles list":
                for (WebElement label : isDataSourcePresentInmanageDataSourceList) {
                    actual.add(label.getText());
                }
                for (String dataSource : data) {

                    if (traverseListContainsElementText(getDataSourceList(), dataSource) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Manage Access default roles list":
            case "Manage Local Users list":
                for (String expValue : data) {
                    expected.add(expValue);
                }
                for (WebElement label : isDataSourcePresentInmanageDataSourceList) {
                    actual.add(label.getText());
                }
                Collections.sort(expected);
                Collections.sort(actual);
                if (CommonUtil.compareLists(actual, expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Bundles Version all are same":
                for (WebElement bundleVersion : getBundleVersion) {
                    String value = "";
                    if(CommonUtil.getText().contains("-")){
                        value = CommonUtil.getText().replace("-",".");
                    }
                    if (bundleVersion.getText().equals(value)) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "DataSource all are same":
            case "Credentials all are same":
                for (WebElement dataSourceType : getDataSourceType) {
                    if (dataSourceType.getText().equals(data.get(0))) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Credentials List":
                for (String credentials : data) {

                    if (traverseListContainsElementText(getCredentialsList(), credentials) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Filtered Keyword":
                for (String keyword : data) {

                    if (traverseListContainsElementText(getKeywordList(), keyword) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Plugins list for expanded Bundle":
                for (WebElement label : getExpandedPluginList) {
                    actual.add(label.getText());
                }
                for (String pluginList : data) {
                    expected.add(pluginList);
                }
                if (CommonUtil.compareLists(actual, expected) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
                break;
            case "Empty Bundle list":
                takeScreenShot(actionToBeVerified + " is captured", driver);
                Assert.assertTrue(getDataSourceList().isEmpty());
                break;
            case "Empty Plugin list when Bundle Collapsed":
                takeScreenShot(actionToBeVerified + " is captured", driver);
                Assert.assertTrue(getExpandedPluginList().isEmpty());
                break;
            case "Admin page Title":
            case "Capture and Import Data page Title":
                takeScreenShot(actionToBeVerified + " is captured", driver);
                for (String adminPage : data) {
                    Assert.assertTrue(isElementPresent(getPageTitle(adminPage.toString())));
                }
                break;
            case "Admin Welcome Page":
                takeScreenShot(actionToBeVerified + " is captured", driver);
                for (String adminPage : data) {
                    Assert.assertTrue(isElementPresent(getWelcomePage(adminPage.toString())));
                }
                break;
            case "Landed page Title is Bold":
                takeScreenShot(actionToBeVerified + " is captured", driver);
                for (String adminPage : data) {
                    Assert.assertTrue(getAdminLinks(adminPage).getCssValue("font-weight").equals("700"));
                }
                break;
            case "Dashboard dropdown list":
                for (String dashboard : data) {
                    Assert.assertTrue(traverseListContainsElementText(getDashboardList(), dashboard.toString()));
                }
                break;
            case "preselected Dashboard is the first option":
                Assert.assertTrue(getElementText(getDashboardList().get(0)).equals(data.get(0).toString()));
                break;
            case "Dashboard widget count":
                int widgetSize = getDashboardWidgetList().size();
                Assert.assertTrue(String.valueOf(widgetSize).equals(data.get(0).toString()));
                break;
            case "Page Subtitle":
                Assert.assertTrue(isElementPresent(getPageSubtitle(data.get(0))));
                break;
            case "Column Names":
                for (String dashboard : data) {
                    Assert.assertTrue(traverseListContainsElementText(getColumnListInTable(), dashboard.toString()));
                }
                break;
            case "BA Trust score widget Columns":
                for (String dashboardColumns : data) {
                    Assert.assertTrue(traverseListContainsElementText(getBAWidgetColumnList(), dashboardColumns));
                }
                break;
            case "Tags":
                for (String tag : data) {
                    Assert.assertTrue(traverseListContainsText(getmanageTagsList(), tag));
                }
                break;
            case "":
            case "Trust policy Labels list":
                for (String labels : data) {
                    if (traverseListContainsText(getTrustPolicyLabels(), labels) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Tagging policy Labels list":
                for (String labels : data) {
                    if (traverseListContainsText(getTaggingPolicyLabels(), labels) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Notification Filter Labels":
                for (String labels : data) {
                    if (traverseListContainsText(getNotificationFilterLabels(), labels) == true) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                }
                break;
            case "Search results show more options":
                for (String option : data) {
                    Assert.assertTrue(isElementPresent(getSearchResultsShowMoreOptions(option)));
                }
                break;
            case "Search results disabled show more options":
                for (String option : data) {
                    Assert.assertTrue(getSearchResultsShowMoreOptions(option).getAttribute("class").contains("disabled"));
                }
                break;
                case "AddConfigurationTags":
                for (String tag : data) {
                    Assert.assertTrue(traverseListContainsElementText(getAddConfigurationsTag(), tag));
                }
                break;
            case "TagsAddConfiguration":
                waitForAngularLoad(driver);
                for (String tag : data) {
                    Assert.assertTrue(traverseListContainsElementTextViaAttribute(getAddConfigurationsDataSourceTag(),tag,"title"));
                }
                break;
            case "Licenses":
                for (String license : data) {
                    Assert.assertTrue(traverseListContainsElement(getLicensesList(),license));
                }
                break;
            case "verifies License field presence":
                for (String license : data) {
                    Assert.assertTrue(traverseListContainsElement(getLicenseFieldList(),license));
                }
                break;
            case "Item type options":
                clickonWebElementwithJavaScript(driver, getCreatepageDropdownButtonOfTheField());
                waitForAngularLoad(driver);
                for (String itemTypeOptions : data) {
                    Assert.assertTrue(isElementPresent(getAttributeInDropdown("Item Type", itemTypeOptions)));
                    flag = true;
                }
                break;
        }
        return flag;
    }

    public boolean validateSubMenusForSidebar(String actionToBeVerified, List<String> data) throws Exception {
        boolean flag = false;
        try {
            for (String submenu : data) {
                if (traverseListContainsElement(getSubMenuAsList(actionToBeVerified), submenu) == true) {
                    flag = true;
                } else {
                    throw new Exception();
                }
            }
        } catch (Exception e) {
            Assert.fail("Submenu is not present");
        }
        return flag;
    }

    public boolean isDataSetElementNotPresentInList(List<String> listValues, String... elementType) throws Exception {
        boolean flag = false;
        if (elementType.toString().equalsIgnoreCase("Tags")) {
            for (String subTag : listValues) {
                try {
                    if (traverseListContainsElement(getmanageTagsList(), subTag) == true) {
                        flag = false;
                        break;
                    } else {
                        throw new Exception();
                    }
                } catch (Exception e) {
                    flag = true;
                }
            }
        } else if (elementType.toString().equalsIgnoreCase("preconfigured widget")) {
            for (String property : listValues) {
                try {
                    if (traverseListContainsElement(getSelectWidgetList(), property) == true) {
                        flag = false;
                        break;
                    } else {
                        throw new Exception();
                    }
                } catch (Exception e) {
                    flag = true;
                }
            }
        }else {
            for (String property : listValues) {
                try {
                    if (traverseListContainsElement(getDataSourceList(), property) == true) {
                        flag = false;
                        break;
                    } else {
                        throw new Exception();
                    }
                } catch (Exception e) {
                    flag = true;
                }
            }
        }
        return flag;
    }

    public boolean verifySortingOrder(String actionToBeVerified, List<String> data) throws Exception {
        boolean flag = false;
        List<String> expected = new ArrayList<>();
        List<String> actual = new ArrayList<>();

        switch (actionToBeVerified) {
            case "Data sources are in decending order":
            case "Credentials are in decending order":
                for(WebElement datasource : isDataSourcePresentInmanageDataSourceList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Data sources are in ascending order":
            case "Credentials are in ascending order":
                for(WebElement datasource : isDataSourcePresentInmanageDataSourceList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Configuration Types are in Ascending Order":
            case "Credentials Types are in Ascending Order":
                for(WebElement datasource : typeDDList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Plugins are in Ascending Order":
                for(WebElement datasource : configurationPluginDDList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "DataSource Types are in Ascending Order":
                for(WebElement datasource : getDataSourceType){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "FirstColumn are in decending order":
                for(WebElement datasource : getFirstColumnList()){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "FirstColumn are in ascending order":
                for(WebElement datasource : getFirstColumnList()){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Roles are in descending order":
                for(WebElement datasource : getFirstColumnList1()){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Roles are in ascending order":
                for(WebElement datasource : getFirstColumnList1()){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Value are in decending order":
                for(WebElement datasource : getValueColumnList()){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Value are in ascending order":
                for(WebElement datasource : getValueColumnList()){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "BA attributes are in ascending order":
                for (WebElement datasource : detailsAttributes) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Sequence Number is in ascending order":
                for (WebElement datasource : SequenceNumberOrder) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "BA with Trust Score widget are in ascending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "BA with Trust Score widget are in desending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Most Used Tags widget are in ascending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Most Used Tags widget are in desending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Least Used Tags widget are in ascending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Least Used Tags widget are in desending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Number of Tags for each Category widget are in ascending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Number of Tags for each Category widget are in desending order":
                for (WebElement datasource : widgetColumnBAItems) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Trust Score are in ascending order":
                for(WebElement datasource: getTrustScoreFacetslist){
                    actual.add(datasource.getText());
                    }
                    flag=Ordering.natural().isOrdered(actual);
                break;
            case "Trust Score are in Descending order":
                for(WebElement datasource: getTrustScoreFacetslist){
                    actual.add(datasource.getText());
                }
                flag=Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Excel Import Scope Drop Down":
                for (WebElement datasource : excelImportScopeAttributeValues) {
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;

            case "Users and Groups are in decending order":
                for(WebElement datasource : isDataSourcePresentInmanageDataSourceList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Users and Groups are in ascending order":
                for(WebElement datasource : isDataSourcePresentInmanageDataSourceList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Available Section items are in ascending order":
                for(WebElement datasource : popSectionList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().isOrdered(actual);
                break;
            case "Available Section items are in descending order":
                for(WebElement datasource : popSectionList){
                    actual.add(datasource.getText());
                }
                flag = Ordering.natural().reverse().isOrdered(actual);
                break;
            case "Tags Are in Ascending Order":
                for (WebElement Tags : addConfigurationsTags) {
                    actual.add(getElementText(Tags));
                }
                flag = Ordering.natural().isOrdered(actual);
                Assert.assertTrue(flag);
                break;
        }

        return flag;
    }

    public void validateErrorMessageForTheFields(String fieldName, String validationMessage, String pageName) throws Exception {
        String actualText = getElementText(getFieldValidationMesssage(pageName,fieldName));
        Assert.assertEquals(validationMessage, actualText.trim());
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), fieldName + " validation message is displayed under the field");
    }

    public WebElement getAddConfigSaveButton() {
        synchronizationVisibilityofElement(driver, configSave);
        return configSave;
    }

    public WebElement getPipelinepluginConfigSave() {
        synchronizationVisibilityofElement(driver, pipelinepluginConfigSave);
        return pipelinepluginConfigSave;
    }

    public void verifySelects(String actionType, String elementName, String... dynamicItem) throws Exception {
        switch (actionType) {
            case "selects":
                verifySelectsFilter(elementName,dynamicItem[0]);
                break;
        }
    }

    public WebElement getSaveSearchResultButton() {
        synchronizationVisibilityofElement(driver, saveSearchResults);
        return saveSearchResults;
    }

    public boolean isElementPresentinRunSearchList(String action, String searchName) throws Exception {
        boolean flag = false;
        switch (action) {
            case "displayed":
                takeScreenShot(action +" is captured", driver);
                moveToElement(driver,getRunSearchListResults(searchName));
                verifyTrue(isElementPresent(getRunSearchListResults(searchName)));
                clickOn(driver, getRunSearchListResults(searchName));
                break;
            case "deleted":
                takeScreenShot(action +" is captured", driver);
                moveToElement(driver,getRunSearchListResults(searchName));
                verifyTrue(isElementPresent(getRunSearchListResults(searchName)));
                clickOn(driver, getRunSearchListResults(searchName));
                clickOn(driver, getDeleteSearchListResults(searchName));
                break;
        }

        return flag;
    }

    public void enterTextInSaveSearchPage(String fieldName, String inputText) throws Exception {
        if (fieldName.equalsIgnoreCase("Credential Name")) {
            waitForAngularLoad(driver);
            enterText(getCredentialNameTextBox(),inputText);
            waitForAngularLoad(driver);
        } else {
            sleepForSec(5000);
            enterText(getTextBoxInSaveSearchPage(fieldName), inputText);
            waitForAngularLoad(driver);
        }
    }


    public void enterCredentials(String credentialName) throws Exception {
        try{
            switch (credentialName){
                case "GitCollectorDataSource":
                    enterText(getTextBoxInManageDataSources("User Name"), propLoader.prop.getProperty("BITBUCKET_USERNAME"));
                    waitForAngularLoad(driver);
                    enterText(getTextBoxInManageDataSources("Password"), propLoader.prop.getProperty("BITBUCKET_PASSWORD"));
                    waitForAngularLoad(driver);
                    break;
            }

        }catch (Exception e){
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"Credentials not entered");
            Assert.fail(e.getMessage());
        }

        }

    public void TrustPolicypagevalidations(String actionType, String actionItem, String ItemName, String Section) throws Exception {
        switch (actionType) {
            case "Verify predefined rules for ItemType":
                String[] itemTypes = ItemName.split(",");
                for (String factors : itemTypes) {
                    Assert.assertTrue(traverseListContainsText(getPredefinedRuleFactors(), factors));
                }
                break;
            case "Select Rule Option":
                clickOn(driver, getRuleItemTypeDropdwon(actionItem.toLowerCase()));
                waitForAngularLoad(driver);
                clickOn(getDropdownOptionsInPolicyRules(actionItem.toLowerCase(),ItemName));
                waitForAngularLoad(driver);
                break;
            case "Enter rule value":
                if (actionItem.equalsIgnoreCase("Label value for validation")) {
                    enterText(getRuleItemTypeTextbox("label"), " " + ItemName);
                } else {
                    enterText(getRuleItemTypeTextbox(actionItem.toLowerCase()), ItemName);
                }
                waitForAngularLoad(driver);
                break;
            case "Click":
                if (actionItem.equalsIgnoreCase("Save Rule form")) {
                    clickOn(driver, getRuleFormSaveButton());
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Delete Factor")) {
                    clickOn(driver, getFactorDeleteButton());
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Rule")) {
                    waitForAngularLoad(driver);
                    clickOn(driver, getPredefinedItemTypeForRules(ItemName));
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Rule Delete Button")) {
                    clickOn(driver, getRuleDeleteButton());
                    waitForAngularLoad(driver);
                }
                break;
            case "Verify Non Presence":
                if (actionItem.equalsIgnoreCase("Factor Row")) {
                    Assert.assertTrue(getFactorRowUnderRule().isEmpty());
                } else if (actionItem.equalsIgnoreCase("Rule for Item")) {
                    Assert.assertFalse(traverseListContainsElement(getPredefinedItemTypeForRules(), ItemName));
                }
                break;
            case "Verify Validation Message":
                Assert.assertEquals(getElementText(getTrustPolicyValidationMessage()), actionItem);
                break;
            case "Update Rule":
                enterText(getUpdateRuleItemTypeTextbox(actionItem.toLowerCase()), ItemName);
                break;
        }
    }

    public void TaggingPolicypagevalidations(String actionType, String actionItem, String ItemName, String Section) throws Exception {
        switch (actionType) {
            case "Select Rule Option":
                if(actionItem.equalsIgnoreCase("Tag Category")){
                    scrolltoElement(driver, getTaggingPolicyDropDown(actionItem), true);
                    clickOn(getTaggingPolicyDropDown(actionItem));
                    waitForAngularLoad(driver);
                    scrolltoElement(driver, getOptionsInTaggingpolicyDropdownForCategory(actionItem,ItemName), true);
                    clickOn(driver, getOptionsInTaggingpolicyDropdownForCategory(actionItem,ItemName));
                    waitForAngularLoad(driver);
                }else {
                    scrolltoElement(driver, getTaggingPolicyDropDown(actionItem), true);
                    clickOn(getTaggingPolicyDropDown(actionItem));
                    waitForAngularLoad(driver);
                    scrolltoElement(driver, getOptionsInTaggingpolicyDropdown(actionItem, ItemName), true);
                    clickOn(driver, getOptionsInTaggingpolicyDropdown(actionItem, ItemName));
                    waitForAngularLoad(driver);
                    break;
                }
            case "Enter rule value":
                if (actionItem.equalsIgnoreCase("Tags")) {
                    enterText(getTagsTextbox(), ItemName);
                    waitForAngularLoad(driver);
                    clickonWebElementwithJavaScript(driver, getSuggestedOptionInTaggingPage(ItemName));
                } else if (actionItem.equalsIgnoreCase("Data Pattern")) {
                    enterText(getDataPatternTextbox(), ItemName);
                } else if(actionItem.equalsIgnoreCase("Technologies")){
                    String[] itemTypes = ItemName.split(",");
                    for (String factors : itemTypes) {
                        enterText(getTaggingPolicyTechnologiesTextbox(), factors);
                        waitForAngularLoad(driver);
                        clickOn(driver, getSuggestedOptionInTaggingPage(factors));
                    }
                } else if (actionItem.equalsIgnoreCase("Name Pattern")||actionItem.equalsIgnoreCase("Type Pattern")) {
                    enterText(getTaggingPolicyTextboxes(actionItem), ItemName);
                }
                waitForAngularLoad(driver);
                break;
            case "Click":
                if (actionItem.equalsIgnoreCase("Save Rule form")) {
                    clickOn(driver, getRuleFormSaveButton());
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Rule")) {
                    clickOn(driver, getPredefinedItemTypeForRules(ItemName));
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Discard Tagging Rule")) {
                    clickOn(driver, getFactorDeleteButton());
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Rule Delete Button")) {
                    clickOn(driver, getRuleDeleteButton());
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("matchFull")) {
                    clickOn(driver, getTaggingPolicyCheckbox(actionItem));
                    waitForAngularLoad(driver);
                } else if (actionItem.equalsIgnoreCase("Delete New policy")) {
                    int actual_count = getDataPatternInTaggingPolicy().size()-1;
                    clickOn(driver, getPolicyDeleteInTaggingPolicy().get(actual_count));
                } else {
                    throw new Exception();
                }
                break;
            case "Verify Non Presence":
                if (actionItem.equalsIgnoreCase("Rule for Plugin Type")) {
                    Assert.assertFalse(traverseListContainsElement(getPredefinedItemTypeForRules(), ItemName));
                }
                break;
            case "Verify Validation Message":
                Assert.assertEquals(getElementText(getTrustPolicyValidationMessage()), actionItem);
                break;
            case "Verify disabled fields":
                Assert.assertFalse(isElementEnabled(getDisabledTaggingDropdown(actionItem)));
                break;
            case "Verify uploaded analyzer":
                Assert.assertTrue(traverseListContainsElementText(getDefaultOptionInTaggingpolicy(actionItem),ItemName));
                break;
            case "Store Value":
                if (actionItem.equalsIgnoreCase("Policy count")) {
                    CommonUtil.storeText(String.valueOf(getDataPatternInTaggingPolicy().size()));
                } else {
                    throw new Exception();
                }
                break;
            case "Verify increased policy count":
                if (actionItem.equalsIgnoreCase("Policy count")) {
                    String actual_count = String.valueOf(getDataPatternInTaggingPolicy().size());
                    Assert.assertFalse(CommonUtil.getText().equals(actual_count));
                } else {
                    throw new Exception();
                }
                break;
            case "Verify policy count is same":
                if (actionItem.equalsIgnoreCase("Policy count")) {
                    String actual_count = String.valueOf(getDataPatternInTaggingPolicy().size());
                    Assert.assertTrue(CommonUtil.getText().equals(actual_count));
                } else {
                    throw new Exception();
                }
                break;
        }
    }

    public void createTag(String name, String definition, String icon, String colorWidthHeight, String protectedValue) {
        try {
            waitForAngularLoad(driver);
            enterUsingActions(driver, getAddCategoryTextBox("tagName"), name);
            enterUsingActions(driver, getAddCategoryTextBox("definition"), definition);
            clickonWebElementwithJavaScript(driver, getIconHolderButton());
            scrolltoElement(driver, getIcon(icon), true);
            clickonWebElementwithJavaScript(driver, getIcon(icon));
//            clickonWebElementwithJavaScript(driver, getSelectColorIcon());
            String[] widthAndHeight = colorWidthHeight.split(",");
            moveToCoordinatesAndClick(driver, getColorPalette(), widthAndHeight[0], widthAndHeight[1]);
            if (protectedValue.equalsIgnoreCase("true")) {
                waitForAngularLoad(driver);
                clickonWebElementwithJavaScript(driver,getProtectedCheckbox());
            } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Protected is not selected");
            }
            String colorCode = getSelectedColor().getAttribute("style");
            CommonUtil.storeText(colorCode);
            clickonWebElementwithJavaScript(driver, getAddCategoryAPPLYButton());
            waitForAngularLoad(driver);
            clickonWebElementwithJavaScript(driver,getAddCategorySaveButton());
            waitForAngularLoad(driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Issue in Tag Creation");
            Assert.fail(e.getMessage());
        }
    }

    public boolean verifyListElementNotPresent(List<String> itemNames, String... arg) throws Exception {
        boolean flag = false;
        switch (arg[0]) {
            case "permissions":
                for (String property : itemNames) {
                    try {
                        if (traverseListContainsElement(returnPermissionsList(), property) == true) {
                            flag = false;
                            break;
                        } else {
                            throw new Exception();
                        }
                    } catch (Exception e) {
                        flag = false;
                    }
                }
                break;
            case "verifies missing Tags in Tree Sructure":
                for (String subTag : itemNames) {
                    try {
                        if (traverseListContainsElementText(getSubTagsList(arg[1]), subTag) == true) {
                            flag = false;
                            break;
                        } else {
                            throw new Exception();
                        }
                    } catch (Exception e) {
                        flag = false;
                    }
                }
                break;
            case "EnterTagsAddConfigurations":
                for (String tag : itemNames) {
                    try {
                        if (traverseListContainsElementText(getAddConfigurationsTag(), tag) == true) {
                        flag = false;
                        break;
                    }else {
                        throw new Exception();
                    }
                    } catch (Exception e) {
                        flag = false;
                    }
                }

        }
        return flag;
    }

    public void ManageTagsPageValidations(String actionType, String actionItem, String ItemName, String Attribute) throws Exception {
        switch (actionType) {
            case "Verifies Tag Icon":
                Assert.assertTrue(getTagIcon(actionItem).getAttribute("class").contains(ItemName));
                break;
            case "Verifies Tag Icon Color":
                String actualIconColor = getTagIcon(actionItem).getAttribute("style");
                Assert.assertTrue(CommonUtil.getText().contains(actualIconColor));
                break;
            case "Verifies Category Menu buttons":
                if(ItemName.contains(",")){
                    String[] menuButtons = ItemName.split(",");
                    for (String categoryMenuButtons : menuButtons) {
                        Assert.assertTrue(isElementPresent(getCategoryMenuButtons(actionItem, categoryMenuButtons)));
                    }
                } else {
                    Assert.assertTrue(isElementPresent(getCategoryMenuButtons(actionItem, ItemName)));
                }
                break;
            case "Click":
                waitForAngularLoad(driver);
                if(actionItem.equalsIgnoreCase("Category Menu buttons")){
                    moveToElement(driver, getCategoryMenuButtons(ItemName, Attribute));
                    clickonWebElementwithJavaScript(driver, getCategoryMenuButtons(ItemName, Attribute));
                }else if(actionItem.equalsIgnoreCase("Edit category Save Button")){
                    clickonWebElementwithJavaScript(driver,getAddCategorySaveButton());
                } else if(actionItem.equalsIgnoreCase("Add Category Ok button")){
                    clickonWebElementwithJavaScript(driver,getAddCategoryAPPLYButton());
                }else if(actionItem.equalsIgnoreCase("Add Category Cancel button")){
                    clickonWebElementwithJavaScript(driver,getAddCategoryCancelButton());
                }else if(actionItem.equalsIgnoreCase("Category popup Cancel button")){
                    clickonWebElementwithJavaScript(driver,getCategoryPopupCancelButton());
                }else if(actionItem.equalsIgnoreCase("Tag Icon")){
                    clickonWebElementwithJavaScript(driver,getTagCategoryIcon());
                }else if(actionItem.equalsIgnoreCase("Tag Icon Search")){
                    clickonWebElementwithJavaScript(driver,getTagCategorySearchIcon());
                }else if(actionItem.equalsIgnoreCase("Tag Icon Search close")){
                    clickonWebElementwithJavaScript(driver,getTagSearchclose());
                    waitForAngularLoad(driver);
                }
                waitForAngularLoad(driver);
                sleepForSec(1500);
                break;
            case "Enter Text":
                if(actionItem.equalsIgnoreCase("Category Name")|| actionItem.equalsIgnoreCase("Tag Name")){
                    enterUsingActions(driver, getAddCategoryTextBox("tagName"), ItemName);
                }else if(actionItem.equalsIgnoreCase("Tag Definition")){
                    enterUsingActions(driver, getAddCategoryTextBox("definition"), ItemName);
                }else if(actionItem.equalsIgnoreCase("Tag Icon Search Text box")){
                    enterUsingActions(driver, getTagIconSearchTextbox(), ItemName);
                }
                break;
            case "Select Color":
                clickonWebElementwithJavaScript(driver, getSelectColorIcon());
                String[] widthAndHeight = ItemName.split(",");
                moveToCoordinatesAndClick(driver, getColorPlate(actionItem), widthAndHeight[0], widthAndHeight[1]);
                waitForAngularLoad(driver);
                sleepForSec(500);
                String colorCode = getAttributeValue(getSelectedColor(),"style");
                CommonUtil.storeText(colorCode);
                break;
            case "Verify color in color icon":
                String iconColor = getColorIconInAddCategory().getAttribute("style");
                Assert.assertTrue(CommonUtil.getText().contains(iconColor));
                break;
            case "Verify Old Color is retained":
                String oldIconColor = getColorIconInAddCategory().getAttribute("style");
                Assert.assertTrue(oldIconColor.equals(CommonUtil.getText()));
                break;
            case "Verifies Tag Icon Color is same":
                String tagIconColor = getTagIcon(actionItem).getAttribute("style");
                Assert.assertFalse(tagIconColor.equals(CommonUtil.getText()));
                break;
            case "Verify Delete for Default Tag Category":
                moveToElement(driver, getCategoryMenuButtons(ItemName, Attribute));
                Assert.assertFalse(getCategoryMenuButtons(ItemName, Attribute).isEnabled());
                break;
            case "Verifies Tag Icon Color after edit":
                waitForAngularLoad(driver);
                String Icon = getTagIcon(actionItem).getAttribute("style");
                Assert.assertTrue(CommonUtil.getText().equalsIgnoreCase(Icon));
                break;
            case "Verifies Tags labels":
                Assert.assertTrue(isElementPresent(getManageTagsLabels(actionItem)));
                break;
            case "capture Tag icon color before edit":
                String BeforeEditIconcolor=getAttributeValue(getTagIcon(actionItem),"style");
                CommonUtil.storeText(BeforeEditIconcolor);
                break;
            case "Verifies Default Root tags Section":
                String[] rootTags = ItemName.split(",");
                for(String expected: rootTags) {
                    Assert.assertTrue(traverseListContainsElementText(getRootTags(), expected));
                }
                break;
            case "Verify Default Sub tags":
                waitForAngularLoad(driver);
                clickOn(getExpandTagHierarchyButton(actionItem));
                waitForAngularLoad(driver);
                String[] subTags = ItemName.split(",");
                for(String expected: subTags) {
                    sleepForSec(1000);
                    Assert.assertTrue(traverseListContainsElementText(getSubTagsUnderCategory(actionItem), expected));
                }
                break;
            case "Verify tag absence":
                if(ItemName.contains(",")) {
                    String[] tags = ItemName.split(",");
                    for (String expected : tags) {
                        sleepForSec(1000);
                        Assert.assertFalse(traverseListContainsElementText(getSubTagsUnderCategory(actionItem), expected));
                    }
                }else{
                    Assert.assertFalse(traverseListContainsElementText(getSubTagsUnderCategory(actionItem), ItemName));
                }
                break;
            case "Verify tag presence":
                waitForAngularLoad(driver);
                sleepForSec(1000);
                if(ItemName.contains(",")) {
                    String[] tagPresence = ItemName.split(",");
                    for (String expected : tagPresence) {
                        sleepForSec(1000);
                        Assert.assertTrue(traverseListContainsElementText(getSubTagsUnderCategory(actionItem), expected));
                    }
                }else{
                    Assert.assertTrue(traverseListContainsElementText(getSubTagsUnderCategory(actionItem), ItemName));
                }
                break;
            case "Expand tag hierarchy":
                waitForAngularLoad(driver);
                clickOn(getExpandTagHierarchyButton(actionItem));
                waitForAngularLoad(driver);
                break;
            case "Verify Add Hierarchy icon Absence":
                String[] addIcon = actionItem.split(",");
                for(String expected: addIcon) {
                    Assert.assertTrue(getAddIconInTagsPage(expected).isEmpty());
                }
                break;
            case "Click Category Menu buttons":
                moveToElement(driver, getCategoryMenuButtons(ItemName, Attribute));
                clickonWebElementwithJavaScript(driver, getCategoryMenuButtons(ItemName, Attribute));
                waitForAngularLoad(driver);
                break;
            case "Verify Category Menu buttons are disabled":
                Assert.assertTrue(isElementPresent(getCategoryMenuButtons(ItemName, Attribute)));
                break;
            case "Verify readonly text":
                moveToElement(driver, getTagsInManageTagsPage(actionItem));
                Assert.assertTrue(getReadOnlyAccesstextInTagspage(actionItem).getText().equals(ItemName));
                break;
            case "Verify Tag icon Results":
                Assert.assertTrue(isElementPresent(getVerifyTagIconResults(actionItem)));
                break;

        }
    }

    public void ManageNotificationsPageValidations(String actionType, String actionItem, String ItemName, String Attribute, String Section) throws Exception {
        try {
            switch (actionType) {
                case "Click":
                    if (actionItem.equalsIgnoreCase("Notification bell Icon")) {
                        waitForAngularLoad(driver);
                        clickOn(getNotificationBellIcon());
                        sleepForSec(2500);
                    } else if (actionItem.equalsIgnoreCase("First notification in List")) {
                        waitForAngularLoad(driver);
                        clickOn(returnFirstOpenAreaLinkInNotification());
                        sleepForSec(1000);
                    } else if (actionItem.equalsIgnoreCase("Notification")) {
                        clickOn(getNotification(ItemName));
                    } else if (actionItem.equalsIgnoreCase("Business Application Link in notification content")) {
                        clickOn(getBusinessApplicationLinkInContent());
                    } else if (actionItem.equalsIgnoreCase("Notification Filters")) {
                        clickOn(getNotificationDropdownButton(ItemName));
                        sleepForSec(1000);
                        clickOn(getTypeFromDropdownInManageDSPage(ItemName, Attribute));
                    } else if (ItemName.equalsIgnoreCase("Mark As read/Refresh")) {
                        clickOn(getNotificationMarkAsReadDropdownButton());
                        sleepForSec(1000);
                        clickOn(getTypeFromDropdownInManageDSPage("", Attribute));
                    } else if (actionItem.equalsIgnoreCase("Open notification by content")) {
                        traverseListContainsElementAndClick(driver, getNotificationByContent(), ItemName);
                        waitUntilAngularReady(driver);
                        break;
                    } else if (actionItem.equalsIgnoreCase("Click here to open the request for access")) {
                        clickOn(driver, getClickHereLinkInNotification());
                    } else {
                        throw new Exception();
                    }
                    sleepForSec(1500);
                    break;
                case "Enter Text":
                    break;
                case "Verify Presence":
                    if (actionItem.equalsIgnoreCase("Notification bell Icon with notification count")) {
                        Assert.assertTrue(isElementPresent(getNotificationBellIcon()));
                    } else if (actionItem.equalsIgnoreCase("Manage Notifications page")) {
                        Assert.assertTrue(isElementPresent(getNotificationpage()));
                    } else if (actionItem.equalsIgnoreCase("Left panel with Notifications list")) {
                        Assert.assertFalse(getnotificationList().isEmpty());
                    } else if (actionItem.equalsIgnoreCase("Right Panel with Notification content")) {
                        Assert.assertTrue(isElementPresent(getnotificationRightpanel(ItemName)));
                    } else if (actionItem.equalsIgnoreCase("Blue circle Icon for unread notifications")) {
                        Assert.assertTrue(isElementPresent(getBlueCircleIconInnotification().get(0)));
                    } else if (actionItem.equalsIgnoreCase("Mark As read Dropdown")) {
                        Assert.assertTrue(isElementPresent(getMarkAsReadDropDown()));
                    } else if (actionItem.equalsIgnoreCase("Active Green label for notification")) {
                        Assert.assertTrue(isElementPresent(getActiveGreenLabelForNotification()));
                    } else if (actionItem.equalsIgnoreCase("Notification Title and Content")) {
                        String[] titleAndContent = ItemName.split(",");
                        Assert.assertTrue(isElementPresent(returnNotificationContent(titleAndContent[0], titleAndContent[1])));
                    } else if (actionItem.equalsIgnoreCase("Profile Icon")) {
                        Assert.assertTrue(isElementPresent(getNotificationAvatar(ItemName)));
                    } else if (actionItem.equalsIgnoreCase("Default Notification content")) {
                        waitForAngularLoad(driver);
                        Assert.assertTrue(isElementPresent(getNotifcationDefaultContent()));
                    } else if (actionItem.equalsIgnoreCase("Label in Notification list panel")) {
                        Assert.assertTrue(isElementPresent(getLabelsInNotificationPanel(ItemName)));
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Verify Absence":
                    if (actionItem.equalsIgnoreCase("Blue circle Icon for first notification")) {
                        Assert.assertTrue(getFirstBlueCircleIconInnotification().isEmpty());
                    } else if (actionItem.equalsIgnoreCase("Blue Circle Icon in All Notifications")) {
                        Assert.assertTrue(getBlueCircleIconInnotification().isEmpty());
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Verify List contains only unread notification":
                    int unreadCount = getBlueCircleIconInnotification().size();
                    Assert.assertEquals(unreadCount, getnotificationList().size());
                    break;
                case "Store notification count":
                    CommonUtil.storeText(getElementText(getNotificationBellIcon()));
                    break;
                case "Verify the notification with the stored count":
                    Assert.assertTrue(Integer.parseInt(getElementText(getNotificationBellIcon()))> Integer.parseInt(CommonUtil.getText()));
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DashBoard Validation is not performed");
            Assert.fail(e.getMessage());
        }

    }


    public void TagValidation(String elementName, String ItemName) throws Exception {
        try {
            switch (elementName) {
                case "MostUsedTagsDescending":
                    List<WebElement> MostUsedTagsList = driver.findElements(By.xpath("//span[contains(@class,'widget-heading text-truncate')][@title='Most Used Tags']//following::table[@class='w-100'][1]//td[2]"));
                    int sizeMost = MostUsedTagsList.size();
                    System.out.println(sizeMost);
                    for (int i = 0; i < sizeMost; i++) {
                        for (int j = i + 1; j < sizeMost; j++) {
                            boolean status = false;
                            String MostUsedTagString = getElementText(MostUsedTagsList.get(i));
                            int MostUsedTagInteger = Integer.parseInt(MostUsedTagString);
                            String MostUsedTagString1 = getElementText(MostUsedTagsList.get(j));
                            int MostUsedTagInteger1 = Integer.parseInt(MostUsedTagString1);
                            if (MostUsedTagInteger >= MostUsedTagInteger1) {
                                status = true;
                                Assert.assertTrue(status);
                            } else {
                                throw new Exception();
                            }
                        }
                    }
                    break;
                case "SelectDashBoardWidgets":
                    waitForAngularLoad(driver);
                    actionClick(driver, getDashboardWidgets(ItemName));
                    break;
                case "LeastUsedTagsDescending":
                    List<WebElement> LeastUsedTagsList = driver.findElements(By.xpath("//span[contains(@class,'widget-heading text-truncate')][@title='Most Used Tags']//following::table[@class='w-100'][1]//td[2]"));
                    int sizeleast = LeastUsedTagsList.size();
                    System.out.println(sizeleast);
                    for (int i = 0; i < sizeleast; i++) {
                        for (int j = i + 1; j < sizeleast; j++) {
                            boolean status = false;
                            String LeastUsedTagString = getElementText(LeastUsedTagsList.get(i));
                            int LeastUsedTagInteger = Integer.parseInt(LeastUsedTagString);
                            String LeastUsedTagString1 = getElementText(LeastUsedTagsList.get(j));
                            int LeastUsedTagInteger1 = Integer.parseInt(LeastUsedTagString1);
                            if (LeastUsedTagInteger <= LeastUsedTagInteger1) {
                                status = true;
                                Assert.assertTrue(status);
                            } else {
                                throw new Exception();
                            }
                        }
                    }
                    break;
                case "Verify Widget":
                    Assert.assertTrue(isElementPresent(getDashboardWidgets(ItemName)));
                    break;
                case "MostUsedTagsSize":
                    List<WebElement> MostUsedTagsSize = driver.findElements(By.xpath("//span[contains(@class,'widget-heading text-truncate')][@title='Most Used Tags']//following::table[@class='w-100'][1]//tbody//tr"));
                    int SizeofMostUsedTags = MostUsedTagsSize.size();
                    boolean status = false;
                    if (SizeofMostUsedTags <= 10) {
                        status = true;
                    } else {
                        throw new Exception();
                    }
                    Assert.assertTrue(status);
                    break;
                case "LeastUsedTagsSize":
                    List<WebElement> LeastUsedTagsSize = driver.findElements(By.xpath("//span[contains(@class,'widget-heading text-truncate')][@title='Least Used Tags']//following::table[@class='w-100'][1]//tbody//tr"));
                    int SizeofLeastUsedTags = LeastUsedTagsSize.size();
                    boolean flag = false;
                    if (SizeofLeastUsedTags <= 10) {
                        flag = true;
                    } else {
                        throw new Exception();
                    }
                    Assert.assertTrue(flag);
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DashBoard Validation is not performed");
            Assert.fail(e.getMessage());
        }

    }

    public void editTag(String actionType, String definition, String icon, String colorWidthHeight, String protectedValue, String colorWidthHeightslider, String editIcon,String Tempsavecolor) {
        try {
            switch (actionType) {
                case "Color":
                    clickonWebElementwithJavaScript(driver, getSelectColorIcon());
                    String[] widthAndHeight1 = colorWidthHeightslider.split(",");
                    String[] widthAndHeight2 = colorWidthHeight.split(",");
                    doubleClick(driver, getColorSlider());
                    moveToCoordinatesAndClick(driver, getColorSlider(), widthAndHeight1[0], widthAndHeight1[1]);
                    doubleClick(driver, getColorPalette());
                    moveToCoordinatesAndClick(driver, getColorPalette(), widthAndHeight2[0], widthAndHeight2[1]);
                    clickonWebElementwithJavaScript(driver, getAddCategoryAPPLYButton());
                    if(Tempsavecolor.equalsIgnoreCase("true")){
                    String editcolorCode = getSelectedColor().getAttribute("style");
                   String coloreditcode= editcolorCode.replaceAll("background","").replaceAll("-","");
                    CommonUtil.storeText(coloreditcode);
                    }
                    break;
                case "Icon":
                    clickonWebElementwithJavaScript(driver, getIcon(editIcon));
                    scrolltoElement(driver, getIcon(icon), true);
                    clickonWebElementwithJavaScript(driver, getIcon(icon));
                    break;
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit not performed");
            Assert.fail(e.getMessage());
        }
    }

    public void ManageLicensesPageValidations(String actionType, String actionItem, String ItemName, String Attribute, String Section) throws Exception {
        try {
            switch (actionType) {
                case "Expand License":
                    traverseListContainsElementAndClick(driver, getLicensesList(), actionItem);
                    break;
                case "Enter Text":
                    enterText(getLicenseField(actionItem),ItemName);
                    break;
                case "Verify Field Value":
                    Assert.assertTrue(getLicenseField(actionItem).getAttribute("value").equals(ItemName));
                    break;
                case "Click":
                    if (actionItem.equalsIgnoreCase("Save Button")) {
                        clickOn(getLicenseSaveButton(ItemName));
                    } else {
                        throw new Exception();
                    }
                    break;
                case "Store Field Value":
                    CommonUtil.storeText(getLicenseField(actionItem).getAttribute("value"));
                    break;
                case "Verify License limit is increased":
                    int getOldLicenseUsedCount = Integer.parseInt(CommonUtil.getText());
                    Assert.assertTrue(getOldLicenseUsedCount< Integer.parseInt(getLicenseField(actionItem).getAttribute("value")));
                    break;
                case "Verify License limit is decreased":
                    int oldLicenseUsedCount = Integer.parseInt(CommonUtil.getText());
                    Assert.assertTrue(oldLicenseUsedCount > Integer.parseInt(getLicenseField(actionItem).getAttribute("value")));
                    break;
                case "Set license used and license limit as equal":
                    String licenseUsed = getLicenseField(actionItem).getAttribute("value");
                    enterText(getLicenseField(ItemName),licenseUsed);
                    waitForAngularLoad(driver);
                    break;
                case "Select Dropdown":
                    clickOn(getLicenseDropdownButton(actionItem));
                    waitForAngularLoad(driver);
                    traverseListContainsElementAndClick(driver, getLicenseDropdownOptions(actionItem), ItemName);
                    waitForAngularLoad(driver);
                    break;
                case "Set License limit":
                    int licenseUsedCount = Integer.parseInt(getLicenseField(actionItem).getAttribute("value")) - 1;
                    enterText(getLicenseField(ItemName),String.valueOf(licenseUsedCount));
                    waitForAngularLoad(driver);
                    break;
                case "Verify Error Message":
                    Assert.assertTrue(getElementText(getLicenseErrorMessageForField(actionItem)).equalsIgnoreCase(ItemName));
                    break;
                case "Verify Status":
                    Assert.assertTrue(getElementText(getLicenseStatus(actionItem)).equalsIgnoreCase(ItemName));
                    break;
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Edit not performed");
            Assert.fail(e.getMessage());
        }
    }

    public void manageAuditLog(String actionType, String actionItem,String ItemName,String Section) throws Exception {
        switch (actionType) {
            case "Enter Text in Search box":
                clickonWebElementwithJavaScript(driver, getAuditLogSearchButton());
                enterText(getAuditLogSearchBox(), ItemName);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Audit Log page");
                break;
            case "Verifies Item Displayed":
                Assert.assertTrue(getAuditTableSearchValues(actionItem).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is displayed under the Audit Log page");
                break;
            case "Verifies Item not Displayed":
                Assert.assertFalse(getAuditTableSearchValues(actionItem).isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is not displayed under the Audit Log page");
                break;
            case "Remove Text in Search box":
                clickonWebElementwithJavaScript(driver, getAuditLogRemoveSearchTextButton());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Audit Log page");
                break;
            case "Verifies Download Link and Click to Download":
                Assert.assertTrue(getAuditLogDownloadLink().isDisplayed());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is displayed under the Audit Log page");
                clickonWebElementwithJavaScript(driver, getAuditLogDownloadLink());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), actionItem + "Item is displayed under the Audit Log page");
                break;
            case "Verifies Section Values":
                if(Section.equalsIgnoreCase("ItemType")) {
                    Assert.assertEquals(getAuditTableItemTypeValue(actionItem).getText(),ItemName);
                }
                else if(Section.equalsIgnoreCase("Component")) {
                    Assert.assertEquals(getAuditTableComponentValue(actionItem).getText(),ItemName);
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ItemName + "Item is displayed under the Audit Log page");
                break;

        }
    }

    public void ManageAccessRequestsPageValidations(String actionType, String actionItem, String ItemName, String Section) throws Exception {
        try {
            switch (actionType) {
                case "Verify Access Request Presence for DataSet":
                    Assert.assertTrue(traverseListContainsText(getAccessRequestsList(), actionItem));
                    break;
                case "Verify Access Request count for DataSet":
                    String count = commonUtil.getNUMfromString(getElementText(getAccessRequestsCount(actionItem)));
                    Assert.assertTrue(count.equals(ItemName));
                    break;
            }
        } catch (Exception e) {
            takeScreenShot(this.getClass().getName(), driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Action" + actionType + " is not performed in " + "Manage Access Requests");
            Assert.fail(e.getMessage());
        }
    }

}



