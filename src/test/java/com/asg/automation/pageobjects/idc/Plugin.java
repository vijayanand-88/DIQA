package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.jmxUtil.Neo4jBase;
import com.asg.automation.wrapper.UIWrapper;
import org.neo4j.driver.v1.Driver;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class Plugin extends UIWrapper {

    private WebDriver driver;

    @FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'PLUGIN MANAGER')]")
    private WebElement pluginManagement;

    @FindBy(xpath = "//a[@href='/IDC/plugin-management;edit=LocalNode']")
    private WebElement localNodeLink;

    @FindBy(xpath = "//div[@title='LOCALNODE']")
    private WebElement localNodePane;

    @FindBy(xpath = "//*[@id=\"asgNodeAssignedPlugins\"]//td[@title='GemfireCataloger']")
    private WebElement assignedGemFirePlugin;

    @FindBy(xpath = "//table//th[text()='CONFIGURATION NAME']/../../../tbody//td")
    private WebElement configuration;

    @FindBy(xpath = "//b[text()='PLUGIN CONFIGURATION']")
    private WebElement configPage;

    @FindBy(xpath = "//button[@id='catalogName']")
    private WebElement catalogName;

    @FindBy(xpath = "//button[text()=' APPLY ']")
    private WebElement pluginApplyParent;

    @FindBy(xpath = "//input[@type='password']/../../../../../..//button[text()=' APPLY ']")
    private WebElement neo4jPluginApplyChild;

    @FindBy(xpath="//*[@id='fromLastRun']/../../../../../..//button[text()=' APPLY ']")
    private WebElement gemfirePluginApplyChild;


    @FindBy(xpath = "//button[text()='SAVE ']")
    private WebElement save;

    @FindBy(xpath = "//td[@title='LocalNode']/../td[@class='asg-nodes-table-plugins-actions']//button")
    private WebElement localNodeActionButton;

    @FindBy(xpath = "//td[@title='LocalNode']/../td[@class='asg-nodes-table-plugins-actions']//button")
    private WebElement LocalNodeActionButton;


    @FindBy(xpath = "//a[@title='Monitor']")
    private WebElement monitorLink;

    @FindBy(xpath = "//div[@title='MONITOR']")
    private WebElement monitorPane;

    @FindBy(xpath = "//div[text()='GemfireCataloger']/../../div[@class='asg-plugin-monitor-status-block']//div[@class='asg-plugin-monitor-status-box asg-gray']")
    private WebElement GemfireStatusIdleCheck;

    @FindBy(xpath="//div[text()='GemfireCataloger']/../../div[@class='asg-plugin-monitor-config-action-buttons']/button[@class='btn asg-plugin-monitor-start-btn']")
    private WebElement GemfireStartButton;

    @FindBy(xpath="//div[@class='asg-plugin-monitor-status-box asg-green asg-plugin-management-shimmering']")
    private WebElement statusRunningCheck;


    @FindBy(xpath="//div[text()='Neo4jCataloger']/../../div[@class='asg-plugin-monitor-status-block']//div[@class='asg-plugin-monitor-status-box asg-gray']")
    private WebElement Neo4jStatusIdleCheck;


    @FindBy(xpath="//div[text()='Neo4jCataloger']/../../div[@class='asg-plugin-monitor-config-action-buttons']/button[@class='btn asg-plugin-monitor-start-btn']")
    private WebElement Neo4jStartButton;

    @FindBy(xpath="//div[@class='input-group']")
    private WebElement searchBar;

    @FindBy(xpath = "//input[contains(@placeholder,'Search...')]")
    private WebElement topSearchBox;

    @FindBy(xpath="//span[@class='fa fa-search searchIcon']")
    private WebElement searchIcon;

    @FindBy(xpath="//div[@title='Cluster']")
    private WebElement Cluster;

    @FindBy(xpath="//span[text()=' Cluster ']")
    private WebElement Clusterresult;

    @FindBy(xpath="//td/span[text()=' Cluster ']")
    private WebElement ClusterLink;

    @FindBy(xpath="//span[text()=' [Cluster] ']")
    private WebElement ClusterPage;

    @FindBy(xpath="//pre")
    private WebElement techData;

    @FindBy(xpath="//li[@class='list-group-item']/span[text()='Application Version']/../span[2]/span")
    private WebElement VersionData;

    @FindBy(xpath = "//span[@title='Gemfire [Cluster] => Gemfire [Service] => Gemfire [Database]']")
    private WebElement DatabaseLink;

    @FindBy(xpath = "//span[@title='[Database]']")
    private WebElement DatabasePage;

    @FindBy(xpath="//p[text()='TABLES']")
    private WebElement Tables;

    @FindBy(xpath = "//tr[@class='item']/td/span[text()=' pincode ']")
    private WebElement TableName;

    @FindBy(xpath = "//div[@title='Analysis']")
    private WebElement Analysis;

    @FindBy(xpath = "//span[@title='[Content]']")
    private WebElement LogContent;

    @FindBy(xpath="//div[@title='Host']")
    private WebElement HostLink;

    @FindBy(xpath="//span[text()=' Host ']")
    private WebElement Hostresult;


    @FindBy(xpath = "//div[@title='RESULTS']/../button[@class='exit-btn']")
    private WebElement ExitButton;

    @FindBy(xpath = "//span[@class='asg-dynamic-form-select-drop-down-icon float-right']")
    private WebElement pluginVersionDropDown;

    @FindBy(xpath = "//span[text()=' LATEST ']")
    private WebElement pluginVersionToSelect;

    @FindBy(xpath = "//span[text()=' 9.8.0.RC1-SNAPSHOT ']")
    private WebElement gempluginVersionToSelect;


    @FindBy(xpath = "//div[@title='Service']")
    private WebElement serviceLink;

    @FindBy(xpath = "//span[text()=' Service ']")
    private WebElement serviceResult;

    @FindBy(xpath = "//span[@title='[Service]']")
    private WebElement servicePage;

    @FindBy(xpath = "//td/span[text()='Host']")
    private WebElement host;

    @FindBy(xpath = "//span[@title='[Host]']")
    private WebElement hostPage;

    @FindBy(xpath = "//div[@class='item-list-total-number']/b")
    private WebElement resultItemCount;

    @FindBy(xpath = "//td[@data-title='name']/a")
    private List<WebElement> resultNames;

    @FindBy(xpath = "//span[text()='Application Version']/../span[@class='list-group-item-right']/span")
    private WebElement appVersion;

    @FindBy(xpath = "//span[text()='Description']/../span[@class='list-group-item-right']/span")
    private WebElement description;

    @FindBy(xpath = "//button[text()=' Show All ']")
    private WebElement showAll;

    @FindBy(xpath = "//div[@title='Table']")
    private WebElement tableLink;

    @FindBy(xpath = "//span[text()=' Table ']")
    private WebElement tableResult;

    @FindBy(xpath = "//span[@title='[Table]']")
    private WebElement tablePage;

    @FindBy(xpath="//div[@title='Database']")
    private WebElement databaseLink;

    @FindBy(xpath = "//span[text()=' Database ']")
    private WebElement databaseResult;

    @FindBy(xpath = "//span[@title='[Database]']")
    private WebElement databasePage;

    @FindBy(xpath="//span[text()=' [Table] ']/../../../../../../../button[@class='exit-btn']")
    private WebElement tablePageExit;

    @FindBy(xpath="//span[text()=' [Host] ']/../../../../../../../button[@class='exit-btn']")
    private WebElement hostPageExit;


    @FindBy(xpath="//span[@title='Column']/../../td[1]/span")
    private List<WebElement> tableColumns;

    @FindBy(xpath="//input[@id='HostName']")
    private WebElement hostName;

    @FindBy(xpath="//input[@id='locatorPort']")
    private WebElement locatorPort;

    @FindBy(xpath="//input[@id='JMXPort']")
    private WebElement jmxPort;


    @FindBy(xpath="//input[@id='Sample Data Limit']")
    private WebElement sampleDataLimit;

    @FindBy(xpath = "//input[@id='name']")
    private WebElement pluginName;

    @FindBy(xpath="//input[@id='repositoryURL']")
    private WebElement repositoryUrl;

    @FindBy(xpath="//input[@id='repositoryUser']")
    private WebElement repositoryUser;

    @FindBy(xpath="//input[@type='password']")
    private WebElement repositoryPassword;


    @FindBy(xpath="//a[text()='Data Sample']")
    private WebElement dataSample;

    @FindBy(xpath="//h4[text()='ERROR:']/../button/span")
    private WebElement errorClose;

    @FindBy(xpath="//p[text()='DATASAMPLING']")
    private WebElement dataSamplingTitle;

    @FindBy(xpath="//p[text()='DATASAMPLING']/../div/table//th")
    private List<WebElement> dataSampleColumn;

    @FindBy(xpath = "//ul[@class='dropdown-menu show']/li/a/span")
    private List<WebElement> dropdownValues;

    public Plugin(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized Plugin page");
    }

    public void clickPluginManager()
    {

        scrollToWebElement(driver, pluginManagement);
        clickonWebElementwithJavaScript(driver,pluginManagement);

    }


    public void clickLocalNode()
    {


        clickonWebElementwithJavaScript(driver,localNodeLink);
        synchronizationVisibilityofElement(driver, localNodePane);

        synchronizationVisibilityofElement(driver, assignedGemFirePlugin);
        clickonWebElementwithJavaScript(driver,assignedGemFirePlugin);


    }


    public String updatePluginConfig()
    {

        String CatalogName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        CatalogName = "gem"+CatalogName;
        synchronizationVisibilityofElement(driver, configuration);
        clickonWebElementwithJavaScript(driver,configuration);
        clickonWebElementwithJavaScript(driver,pluginVersionDropDown);
        clickonWebElementwithJavaScript(driver,pluginVersionToSelect);
        enterText(catalogName,CatalogName);
        // synchronizationVisibilityofElement(driver,pluginApplyChild);

        //clickonWebElementwithJavaScript(driver,pluginApplyChild);
        clickonWebElementwithJavaScript(driver,pluginApplyParent);
        clickonWebElementwithJavaScript(driver,save);

        return CatalogName;

    }

    public void monitorPlugin()
    {

        synchronizationVisibilityofElement(driver, localNodeActionButton);
        clickonWebElementwithJavaScript(driver, localNodeActionButton);
        synchronizationVisibilityofElement(driver, monitorLink);
        clickonWebElementwithJavaScript(driver, monitorLink);
        synchronizationVisibilityofElement(driver, monitorPane);

        synchronizationVisibilityofElement(driver, GemfireStatusIdleCheck , 60);
        clickonWebElementwithJavaScript(driver , GemfireStartButton);
        synchronizationVisibilityofElement(driver , statusRunningCheck);

        synchronizationVisibilityofElement(driver, GemfireStatusIdleCheck , 120);

    }


    public void searchCatalog(String searchText)
    {
        synchronizationVisibilityofElement(driver , topSearchBox);
        enterText(topSearchBox , searchText);
        clickOn(searchIcon);
    }

    public void checkSearchCatalogIsPresent(String catalogName)
    {
        synchronizationVisibilityofElement(driver , driver.findElement(By.xpath("//div[@title='"+catalogName+"']")));
    }

    public void clickOnCluster()
    {
        clickOn(Cluster);
        synchronizationVisibilityofElement(driver , Clusterresult);
        clickonWebElementwithJavaScript(driver , ClusterLink);
        //  clickOn(ClusterLink);
        synchronizationVisibilityofElement(driver , ClusterPage);
    }

    public String getClusterTechData()
    {
        String text =  getElementText(techData);

        return text;
    }


    public void getHostData()


    {

        //span[text()='Host']/../../td/span
//scrollToWebElement(driver , host);

        clickOn(ExitButton);
        clickOn(ExitButton);

        synchronizationVisibilityofElement(driver, HostLink);
        clickOn( HostLink);


        synchronizationVisibilityofElement(driver, Hostresult);
        clickOn( Hostresult);

        synchronizationVisibilityofElement(driver,hostPage);

    }



    public String getHostTechData()
    {
        String text =  getElementText(techData);

        return text;
    }

    public WebElement getHostName()
    {
        synchronizationVisibilityofElement(driver, hostName);
        return hostName;
    }


    public WebElement getServiceLink()
    {
        synchronizationVisibilityofElement(driver, serviceLink);
        return serviceLink;
    }

    public WebElement getHostLink()
    {
        synchronizationVisibilityofElement(driver, HostLink);
        return HostLink;
    }

    public WebElement getHostResult()
    {
        synchronizationVisibilityofElement(driver, Hostresult);
        return Hostresult;
    }

    public WebElement getServiceResult()
    {
        synchronizationVisibilityofElement(driver, serviceResult);
        return serviceResult;
    }

    public WebElement getServicePage()
    {
        synchronizationVisibilityofElement(driver, servicePage);
        return servicePage;
    }

    public WebElement getAppVersion()
    {
        synchronizationVisibilityofElement(driver, appVersion);
        return appVersion;
    }

    public WebElement getDescription()
    {
        synchronizationVisibilityofElement(driver, description);
        return description;
    }

    public WebElement getDatabaseLink()
    {
        synchronizationVisibilityofElement(driver, databaseLink);
        return databaseLink;
    }

    public WebElement getDatabaseResult()
    {
        synchronizationVisibilityofElement(driver, databaseResult);
        return databaseResult;
    }

    public WebElement getDatabasePage()
    {
        synchronizationVisibilityofElement(driver, databasePage);
        return databasePage;
    }

    public WebElement getTableLink()
    {
        synchronizationVisibilityofElement(driver, tableLink);
        return tableLink;
    }

    public WebElement getClusterLink()
    {
        synchronizationVisibilityofElement(driver, ClusterLink);
        return ClusterLink;
    }
    public WebElement getClusterResult()
    {
        synchronizationVisibilityofElement(driver, Clusterresult);
        return Clusterresult;
    }
    public WebElement getCluster()
    {
    synchronizationVisibilityofElement(driver, Cluster);
        return Cluster;
}

    public WebElement getClusterPage()
    {
        synchronizationVisibilityofElement(driver, ClusterPage);
        return ClusterPage;
    }


    public WebElement getTableResult()
    {
        synchronizationVisibilityofElement(driver, tableResult);
        return tableResult;
    }

    public WebElement getTablePage()
    {
        synchronizationVisibilityofElement(driver, tablePage);
        return tablePage;
    }

    public WebElement getTechData()
    {
        synchronizationVisibilityofElement(driver, techData);
        return techData;
    }

    public WebElement getShowAll()
    {
        synchronizationVisibilityofElement(driver, showAll);
        return showAll;
    }

    public WebElement getResultItemCount()
    {
        synchronizationVisibilityofElement(driver, resultItemCount);
        return resultItemCount;
    }

    public WebElement getExitButton()
    {
        synchronizationVisibilityofElement(driver, ExitButton);
        return ExitButton;
    }

    public WebElement getTableExitButton()
    {
        synchronizationVisibilityofElement(driver, tablePageExit);
        return tablePageExit;
    }

    public WebElement getHostExitButton()
    {
        synchronizationVisibilityofElement(driver, hostPageExit);
        return hostPageExit;
    }

    public WebElement getPluginName()
    {
        synchronizationVisibilityofElement(driver, pluginName);
        return pluginName;
    }

    public WebElement gethostName()
    {
        synchronizationVisibilityofElement(driver, hostName);
        return hostName;
    }

    public WebElement getLocatorPort()
    {
        synchronizationVisibilityofElement(driver, locatorPort);
        return locatorPort;
    }

    public WebElement getJmxPort()
    {
        synchronizationVisibilityofElement(driver, jmxPort);
        return jmxPort;
    }

    public WebElement getSampleDataLimit()
    {
        synchronizationVisibilityofElement(driver, sampleDataLimit);
        return sampleDataLimit;
    }

    public WebElement getRepositoryUrl()
    {
        synchronizationVisibilityofElement(driver, repositoryUrl);
        return repositoryUrl;
    }

    public WebElement getRepositoryUser()
    {
        synchronizationVisibilityofElement(driver, repositoryUser);
        return repositoryUser;
    }

    public WebElement getRepositoryPassword()
    {
        synchronizationVisibilityofElement(driver, repositoryPassword);
        return repositoryPassword;
    }

    public WebElement getConfiguration()
    {
        synchronizationVisibilityofElement(driver, configuration);
        return configuration;
    }

    public WebElement getConfigurationPage()
    {
        synchronizationVisibilityofElement(driver, configPage);
        return configPage;
    }

    public WebElement getCatalogNameField()
    {
        synchronizationVisibilityofElement(driver, catalogName);
        return catalogName;
    }

    public WebElement getPluginVersionDropdown()
    {
        synchronizationVisibilityofElement(driver, pluginVersionDropDown);
        return pluginVersionDropDown;
    }

    public WebElement getPluginVersionSelect()
    {
        synchronizationVisibilityofElement(driver, pluginVersionToSelect);
        return pluginVersionToSelect;
    }

    public WebElement getGemFirePluginVersionSelect()
    {
        synchronizationVisibilityofElement(driver, gempluginVersionToSelect);
        return gempluginVersionToSelect;
    }


    public WebElement getPluginApplyChild()
    {
        synchronizationVisibilityofElement(driver, neo4jPluginApplyChild);
        return neo4jPluginApplyChild;
    }

    public WebElement getgemPluginApplyChild()
    {
        synchronizationVisibilityofElement(driver, gemfirePluginApplyChild);
        return gemfirePluginApplyChild;
    }

    public WebElement getPluginApplyParent()
    {
        synchronizationVisibilityofElement(driver, pluginApplyParent);
        return pluginApplyParent;
    }

    public WebElement getSaveButton()
    {
        synchronizationVisibilityofElement(driver, save);
        return save;
    }

    public WebElement getLocalNodeActionButton() {
        synchronizationVisibilityofElement(driver, LocalNodeActionButton);
        return LocalNodeActionButton;
    }
    public WebElement getMonitorLink()
    {
        synchronizationVisibilityofElement(driver, monitorLink);
        return monitorLink;
    }

    public WebElement getMonitorPane()
    {
        synchronizationVisibilityofElement(driver, monitorPane);
        return monitorPane;
    }

    public WebElement getStatusIdleCheck(String pluginName)
    {

        WebElement statusIdleCheck = driver.findElement(By.xpath("//div[@class='asg-plugin-monitor-text-container'][contains(text(),'"+pluginName+"')]/../..//div[contains(@class,'asg-plugin-monitor-status-box asg-gray')][contains(text(),'IDLE')]"));
        synchronizationVisibilityofElement(driver, statusIdleCheck);
        return statusIdleCheck;

    }

    public WebElement getPluginStartButton(String pluginName)
    {

        WebElement pluginStart = driver.findElement(By.xpath("//div[@class='asg-plugin-monitor-text-container'][contains(text(),'"+pluginName+"')]/../../div[@class='asg-plugin-monitor-config-action-buttons']/button[@class='btn asg-plugin-monitor-start-btn']"));
        synchronizationVisibilityofElement(driver, pluginStart);
        return pluginStart;

    }
    public WebElement getRunningStatusCheck()
    {
        synchronizationVisibilityofElement(driver, statusRunningCheck);
        return statusRunningCheck;
    }

    public WebElement getErrorClose()
    {
        synchronizationVisibilityofElement(driver, errorClose);
        return errorClose;
    }

    public WebElement getSampleDataLink()
    {
        synchronizationVisibilityofElement(driver, dataSample);
        return dataSample;
    }

    public WebElement getSampleDataTitle() {
        synchronizationVisibilityofElement(driver, dataSamplingTitle);
        return dataSamplingTitle;
    }
    public List<WebElement> getSampleDataColumns()
    {
        synchronizationVisibilityofElementsList(driver, dataSampleColumn);
        return dataSampleColumn;
    }

    public List<WebElement> getDropdownValues() {
        synchronizationVisibilityofElementsList(driver, dropdownValues);
        return dropdownValues;
    }

    public WebElement getStatusRunningCheck(String pluginName) {

        WebElement statusRunningCheck = driver.findElement(By.xpath("//div[text()='" + pluginName + "']/../../div[@class='asg-plugin-monitor-status-block']//div[@class='asg-plugin-monitor-status-box asg-green asg-plugin-management-shimmering']"));
        synchronizationVisibilityofElement(driver, statusRunningCheck);
        return statusRunningCheck;

    }

    public void clickItemValue(String itemValue) {
        if (isElementPresent(new SubjectArea(driver).getpaginationNextButtonWithoutSync())) {
            trversePaginationAndClickOnDynamicItem(driver, new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), itemValue, new SubjectArea(driver).getpaginationNextButton());
            waitForAngularLoad(driver);
        } else {
            WebElement element = traverseListContainsElementReturnsElement(new SubjectArea(driver).returnlistOfItemNamesIntableOfItemsFound(), itemValue);
            clickOn(driver, element);
            waitForAngularLoad(driver);
        }
    }
}



