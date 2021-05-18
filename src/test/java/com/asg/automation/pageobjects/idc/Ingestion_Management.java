package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.JsonRead;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindAll;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

/**
 * Created by muthuraja.ramakrishn on 4/13/2017.
 */

@SuppressWarnings("DefaultFileTemplate")
public class Ingestion_Management extends UIWrapper {

    private WebDriver driver;

    @FindBy(xpath = "//span[contains(.,'Cluster Test')]")
    private WebElement ClusterTest;

    @FindBy(xpath = "//span[@class='scanner-name'][1]")
    private WebElement IngestionConfigurationFirstTitle;

    @FindBy(xpath = "//b[contains(.,'EDIT INGESTION CONFIGURATION')]")
    private WebElement IngestionScannerSettings;

    @FindBy(xpath = "//button//span[contains(.,'Create')]")
    private WebElement CreateIngestionButton;

    @FindBy(xpath = "//b[contains(.,'NEW INGESTION CONFIGURATION')]")
    private WebElement NewIngestionConfigPanel;

    @FindBy(xpath = "//label[contains(.,'Name')]")
    private WebElement LabelName;

    @FindBy(xpath = "//label[contains(.,'Type')]")
    private WebElement LabelType;

    @FindBy(xpath = "//label[contains(.,'Catalog')]")
    private WebElement LabelSubjectArea;

    @FindBy(id = "ingestionType")
    private WebElement ingestionType;

    @FindBy(xpath = "//div/label[contains(.,'Catalog')]/following::button[@class='btn dropdown-toggle']")
    private WebElement subjectAreaDropDown;

    @FindBy(xpath = "//div/label[contains(.,'Catalog')]/following::ul[@class='dropdown-menu']//li/a/span")
    private List<WebElement> catalogListFromIngestion;

    //@FindBy(id = "scannerName")
    @FindBy(css="#scannerName")
    private WebElement ingestionName;

    @FindBy(id = "catalogerNameHive")
    private WebElement hiveCatalogerName;

    @FindBy(id = "database")
    private WebElement databaseName;

    @FindBy(id = "deltaTimeHive")
    private WebElement deltaTime;

    @FindBy(xpath = "//caption[contains(.,'CATALOGERS')]/span[contains(.,'+Add')]")
    private WebElement addLink;

    @FindBy(xpath = "//caption[contains(.,'FILTERS')]/span[contains(.,'+Add')]")
    private WebElement addLinkinCataloger;

    @FindBy(id = "data.name")
    private WebElement catalogerDropDown;

    @FindBy(id = "name")
    private WebElement filtername;

    @FindBy(xpath = "//td//div/label[@for='item-list-header14']")
    private WebElement bigDataTag;

    @FindBy(xpath = "//td//div/label[@for='item-list-header13']")
    private WebElement analyticsTag;

    @FindBy(xpath = "//td//div/label[@for='item-list-header0']")
    private WebElement dataAnalyticsTag;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']/div//div[2]/form/div[@class='submit']/button")
    private WebElement saveButtonAtFilter;

    @FindBy(xpath = "//form[@class='ng-valid ng-dirty ng-touched']//button")
    private WebElement saveButtonAtCatalogers;

    //@FindBy(xpath = "//form[@class='ng-dirty ng-touched ng-valid']/div/button")
    @FindBy(css=".submit>button")
    private WebElement saveButtonAtIngestionConfig;

    @FindBy(id = "catalogerNameHDFS")
    private WebElement HDFSName;

    @FindBy(xpath = "//caption[contains(.,'CATALOGERS')]//following::td[contains(.,'HiveCataloger')]")
    private WebElement hiveCatalogSetting;

    @FindBy(xpath = "//caption[contains(.,'CATALOGERS')]//following::td[contains(.,'HdfsCataloger')]")
    private WebElement hdfsCatalogSetting;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-panels-active-item']//button[@class='exit-btn']")
    private WebElement closebutton;

    @FindBy(xpath = "//div/label[contains(.,'Catalog')]/following::ul[@class='dropdown-menu']//li/a/span[contains(.,'BigData')]")
    private WebElement BigDataDropDown;

    @FindBy(xpath = "//div[@class='data-content']/form/div/div/following::button[@class='btn dropdown-toggle selectedDropItem']")
    private WebElement ingTypeDropDown;

    @FindBy(xpath = "//span[contains(.,'Hive Cataloger')]")
    private WebElement hiveOption;

    @FindBy(xpath = "//span[contains(.,'Hdfs Cataloger')]")
    private WebElement hdfsOption;

    @FindAll(@FindBy(how = How.XPATH, using="//span[contains(text(),'Cluster Demo')]/ancestor::tr/td[3]/div/span"))
    private List<WebElement> clusterDemoIngestionStatus;

    @FindBy(xpath = "//button[contains(.,'Refresh')]")
    private WebElement ingestionRefreshButton;


    public Ingestion_Management(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initialized Ingestion Management page");
    }


    public WebElement getClusterTest() {
        synchronizationVisibilityofElement(driver, ClusterTest);
        return ClusterTest;
    }

    public WebElement getIngestionConfigurationFirstTitle() {
        synchronizationVisibilityofElement(driver, IngestionConfigurationFirstTitle);
        return IngestionConfigurationFirstTitle;
    }

    public WebElement getIngestionScannerSettings() {
        synchronizationVisibilityofElement(driver, IngestionScannerSettings);
        return IngestionScannerSettings;
    }

    public WebElement getCreateIngestionButton() {
        synchronizationVisibilityofElement(driver, CreateIngestionButton);
        return CreateIngestionButton;
    }

    public WebElement getNewIngestionConfigPanel() {
        synchronizationVisibilityofElement(driver, NewIngestionConfigPanel);
        return NewIngestionConfigPanel;
    }

    public WebElement getLabelName() {
        synchronizationVisibilityofElement(driver, LabelName);
        return LabelName;
    }

    public WebElement getLabelType() {
        synchronizationVisibilityofElement(driver, LabelType);
        return LabelType;
    }

    public WebElement getLabelSubjectArea() {
        synchronizationVisibilityofElement(driver, LabelSubjectArea);
        return LabelSubjectArea;
    }

    public WebElement getingestionType() {
        synchronizationVisibilityofElement(driver, ingestionType);
        return ingestionType;
    }


    public WebElement getsubjectAreaDropDown() {
        synchronizationVisibilityofElement(driver, subjectAreaDropDown);
        return subjectAreaDropDown;
    }

    public WebElement getingestionName() {
        synchronizationVisibilityofElement(driver, ingestionName);
        return ingestionName;
    }

    public WebElement gethiveCatalogerName() {
        synchronizationVisibilityofElement(driver, hiveCatalogerName);
        return hiveCatalogerName;
    }

    public WebElement getdatabaseName() {
        synchronizationVisibilityofElement(driver, databaseName);
        return databaseName;
    }

    public WebElement getdeltaTime() {
        synchronizationVisibilityofElement(driver, deltaTime);
        return deltaTime;
    }

    public WebElement getaddLink() {
        synchronizationVisibilityofElement(driver, addLink);
        return addLink;
    }

    public WebElement getCatalogerDropDown() {
        synchronizationVisibilityofElement(driver, catalogerDropDown);
        return catalogerDropDown;
    }

    public WebElement getFiltername() {
        synchronizationVisibilityofElement(driver, filtername);
        return filtername;
    }

    public WebElement getBigDataTag() {
        synchronizationVisibilityofElement(driver, bigDataTag);
        return bigDataTag;
    }

    public WebElement getDataAnalyticsTag() {
        synchronizationVisibilityofElement(driver, dataAnalyticsTag);
        return dataAnalyticsTag;
    }

    public WebElement getSaveButtonAtFilter() {
        synchronizationVisibilityofElement(driver, saveButtonAtFilter);
        return saveButtonAtFilter;
    }

    public WebElement getSaveButtonAtCatalogers() {
        synchronizationVisibilityofElement(driver, saveButtonAtCatalogers);
        return saveButtonAtCatalogers;
    }

    public WebElement getSaveButtonAtIngestionConfig() {
        synchronizationVisibilityofElement(driver, saveButtonAtIngestionConfig);
        return saveButtonAtIngestionConfig;
    }

    public WebElement getAddLinkinCataloger() {
        synchronizationVisibilityofElement(driver, addLinkinCataloger);
        return addLinkinCataloger;
    }

    public WebElement getHDFSName() {
        synchronizationVisibilityofElement(driver, HDFSName);
        return HDFSName;
    }

    public WebElement getAnalyticsTag() {
        synchronizationVisibilityofElement(driver, analyticsTag);
        return analyticsTag;
    }

    public WebElement getHiveCatalogSetting() {
        synchronizationVisibilityofElement(driver, hiveCatalogSetting);
        return hiveCatalogSetting;
    }

    public WebElement getHdfsCatalogSetting() {
        synchronizationVisibilityofElement(driver, hdfsCatalogSetting);
        return hdfsCatalogSetting;
    }

    public WebElement getClosebutton() {
        synchronizationVisibilityofElement(driver, closebutton);
        return closebutton;
    }


    public WebElement getNewlyCreatedCatalogName() {

        return driver.findElement(By.xpath("//td//span[contains(text(),'Cluster 3')]"));
    }

    public WebElement getHiveCatalogerRunLink() {

        return driver.findElement(By.xpath("//span[contains(text(),'" + new JsonRead().readJSon("HiveCatalogerCreation", "ClusterName") + "')]//following::td[3]//div[1]//span//span[contains(.,'Run')]"));
    }

    public WebElement getHDFSCatalogerRunLink() {

        return driver.findElement(By.xpath("//span[contains(text(),'" + new JsonRead().readJSon("HiveCatalogerCreation", "ClusterName") + "')]//following::td[3]//div[2]//span//span[contains(.,'Run')]"));
    }


    public boolean returnClusterTest() {
        try {
            synchronizationVisibilityofElement(driver, ClusterTest);
            highlightElement(driver, ClusterTest);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<WebElement> retruncatalogListFromIngestion() {
        return catalogListFromIngestion;
    }

    public WebElement retrunBigDataDropDown() {
        synchronizationVisibilityofElement(driver, BigDataDropDown);
        return BigDataDropDown;
    }

    public WebElement getingTypeDropDown() {
        synchronizationVisibilityofElement(driver, ingTypeDropDown);
        return ingTypeDropDown;
    }

    public WebElement gethiveOption() {
        synchronizationVisibilityofElement(driver, hiveOption);
        return hiveOption;
    }


    public WebElement gethdfsOption() {
        synchronizationVisibilityofElement(driver, hdfsOption);
        return hdfsOption;
    }

    public List<WebElement> getclusterDemoIngestionStatus() {
        synchronizationVisibilityofElementsList(driver, clusterDemoIngestionStatus);
        return clusterDemoIngestionStatus;
    }

    public WebElement getingestionRefreshButton() {
        synchronizationVisibilityofElement(driver, ingestionRefreshButton);
        return ingestionRefreshButton;
    }
}
