package com.asg.automation.pageobjects.ida;

import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.stepdefinition.restapi.RESTAPIDefinition;
import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.DBHelper;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.ArrayList;
import java.util.List;

public class AnalysisPage extends UIWrapper {

    private WebDriver driver;
    private DBHelper dbHelper = new DBHelper();


    @FindBy(css = "ul[class='nav nav-tabs dashboard-tabs-panel'] > li:nth-child(2)")
    private WebElement Analysis;

    @FindBy(css = ".asg-area-widget-recent")
    private WebElement VerifyAnalysisWidget;

    @FindBy(xpath = "//li[@class='dashboard-new-widget']//*[contains(text(),'BIGDATA')]")
    private WebElement elementToBeDragged;

   @FindBy(xpath = "//ul/li[@class[contains(.,'dashboard-widget-wraper')]]")
    private List<WebElement> placeToBeDropped;

    @FindBy(xpath = "//ul[2]/li[@class[contains(.,'dashboard-widget-wraper')]]")
    private List<WebElement> placeToBeDropped_secondPage;

    @FindBy(css = "ul[class='dashboard-content edit-mode edge']>li[class='dashboard-widget-wraper']")
    private List<WebElement> placeToBeDropped_Edge;

    @FindBy(xpath = "//span[contains(text(),'SAVE')]")
    private WebElement dashboard_SaveButton;

    @FindBy(xpath = "//a[contains(text(),'ANALYSIS')]")
    private WebElement widgetClick;

    @FindBy(xpath = "//input[@pattern='^[^\\s\\/\\\\]+([\\s]+[^\\s\\/\\\\]+)*$']")
    private WebElement dashboard_Name;

    @FindBy(xpath = "//span[contains(.,'EDIT')]")
    private WebElement dashboard_EditButton;

    @FindBy(xpath = "//div[@class='asg-area-widget-recent-item'][1]//a[contains(@href,'Analysis')]")
    private WebElement Analysis_link;

    @FindBy(xpath = "//a[contains(@title,'Analysis: parser/PythonParser/PythonParser')]")
    private WebElement pythonParserlink;

    @FindBy(xpath = "//a[contains(text(),'Analysis: parser/JavaParser/JavaParser')]")
    private WebElement javaParserlink;

    @FindBy(xpath = "//a[contains(text(),'Analysis: collector/GitCollector/GitJava')]")
    private WebElement gitParserLink;

    @FindBy(xpath = "//a[contains(text(),' lineage/PythonSparkLineage/python Spark Lineage')]")
    private WebElement pythonSparklineage;

    @FindBy(xpath = "//a[contains(@title,'Analysis: linker/PythonPackageLinker/Package_Linker')]")
    private WebElement pythonPackagelinker;

    @FindBy(xpath = "//a[contains(@title,'Analysis: linker/PythonUseFunctionLinker/UseFunctionLinker')]")
    private WebElement pythonUseFunctionlinker;

    @FindBy(xpath = "//a[contains(@title,'Analysis: linker/PythonImportLinker/PythonImportLinker')]")
    private WebElement pythonImportlinker;

    @FindBy(xpath = "//td[@class]//a[contains(.,'log')]")
    private WebElement log;

    @FindBy(xpath = "//span[text()='IMPORTS']")
    private WebElement importtable;


    @FindBy(css = "a[href='/IDC/search;catalog=Analysis;searchQuery=']")
    private WebElement widgetaddition;

    @FindBy(xpath = "//div[text()=' Data ']/..//pre")
    private WebElement logtext;

    @FindBy(xpath = "//ul[@class='list-group properties-widget']//li//pre")
    private WebElement sourcetext;

    @FindBy(xpath = "//ul[@class='nav nav-tabs dashboard-tabs-panel']//a[@class][contains(text(),'IDA')]")
    private WebElement idaDashBoard;

    @FindBy(xpath = "//div[@class='asg-panels-item asg-item-view asg-panels-active-item full-size-item']//b[contains(.,'comments:')]/ancestor::li//span")
    private WebElement metadataComments;

    @FindBy(xpath = "//b[contains(.,'superClasses:')]/following-sibling::span")
    private WebElement superClassesInMetadata;

    @FindBy(xpath = "(//table[@class='table'])[2]/tbody/tr/td[1]/span")
    private List<WebElement> processedItemsOfParser;

    @FindBy(xpath = "(//table[@class='table'])")
    private List<WebElement> processedItemsOfgit;


    @FindBy(xpath = "(//table[contains(@class,'table')])[3]/tbody/tr/td[1]/span")
    private List<WebElement> filestabcolumnlist;


    @FindBy(xpath = "//a[contains(text(),'parser/PythonParser')]")
    private WebElement pythonParserlinkonAnalysis;

    @FindBy(xpath = "//span[contains(text(),'collector/GitCollector')]")
    private WebElement gitCollectorlink;

    @FindBy(xpath = "//span[contains(text(),'cataloger/HdfsCataloger')]")
    private WebElement hdfsCollectorlink;

    @FindBy(xpath = "//span[contains(text(),'cataloger/OracleDBCataloger')]")
    private WebElement oracleCatalogerlink;

    @FindBy(xpath = "//button[@class='btn btn-primary'][not(@disabled)]//span[text()='Assign Data Set']")
    private WebElement AssignDataSet;

    @FindBy(xpath = " //span[@class='title position-relative']")
    private WebElement HeaderofManageAccess;

    @FindBy(xpath = "//span[@class='count ng-star-inserted']")
    private WebElement CountofManageAccess;

    @FindBy(xpath = "//div[@class='w-100 form-field-element']//input[@placeholder='Enter name']")
    private WebElement CreateTestUserName;

    @FindBy(xpath = "//div[@class='password-wrapper']//input[@placeholder='Enter password']")
    private WebElement CreateTestUserPassword;

    @FindBy(xpath = "//div[@class='w-100 form-field-element']//input[@placeholder='Enter email address']")
    private WebElement CreateTestUserEmail;

    @FindBy(xpath = "//div[@class='w-100']//input[@class='form-control']")
    private WebElement CreateTestUserRoles;

    @FindBy(xpath = "//em[@class='add-icon fas fa-plus-square cursor-pointer pt-2']")
    private WebElement CreateTestUserRoleButton;

    @FindBy(xpath = "(//span[@class='far fa-edit cursor-pointer ng-star-inserted'])[1]")
    private WebElement CreateTestUserEditButton;

    @FindBy(xpath = "(//span[@class='tag-close cursor-pointer float-right pr-1'])[1]")
    private WebElement EditTestUserRolecloseButton;

    @FindBy(xpath = "//td[contains(@class,'text-truncate')]//span[text()='System']")
    private WebElement UsersandRolesSystem;

    @FindBy(xpath = "//input[@class='form-control']")
    private WebElement UsersandRolesSearchText;

    @FindBy(xpath = "//button[@type='submit' and contains(text(),' SAVE ')]")
    private WebElement ManageaccessSaveButton;

    @FindBy(xpath = "//a[@class='cancel-btn' and contains(text(),'Cancel')]")
    private WebElement ManageaccessCancelButton;

    @FindBy(xpath = "//div[@class='CodeMirror-scroll']//div[contains(@class,'CodeMirror-lines')]//div[contains(@class,'CodeMirror-code')]/div")
    private List<WebElement> logsList;

    @FindBy(xpath = "//span[contains(text(),'Completeness')]/../../following-sibling::div/div[2]//span[1]")
    private WebElement DetailsInCompletenessSection;

    @FindBy(xpath = "//span[@class='fa fa-plus-square']")
    private WebElement AddNewExcelImport;

    @FindBy(xpath = "//span[@id='item-view-save-btn']")
    private WebElement BASave;

    @FindBy(xpath = "//em[@class='fal fa-ban pr-1']")
    private WebElement BACancel;

    public WebElement logElement(int value) {
        return driver.findElement(By.xpath("//div[@class='CodeMirror-scroll']//div[contains(@class,'CodeMirror-lines')]//div[contains(@class,'CodeMirror-code')]/div[" + value + "]//span"));
    }


    public AnalysisPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intializing Dashboard PageFactory Class");
    }

    public List<WebElement> getprocessedItemsOfParser() {
        synchronizationVisibilityofElementsList(driver, processedItemsOfParser);
        return processedItemsOfParser;
    }


    public List<WebElement> getfilestab() {
        synchronizationVisibilityofElementsList(driver, filestabcolumnlist);
        return filestabcolumnlist;
    }

    public List<WebElement> getprocessedItemsOfgit() {
        synchronizationVisibilityofElementsList(driver, processedItemsOfgit);
        System.out.println(processedItemsOfgit.toString());
        return processedItemsOfgit;
    }

    public void clickProcesseditems(String item) {

        WebElement giveninput = driver.findElement(By.xpath("(//span[contains(text(),'" + item + "')])[2]"));
        synchronizationVisibilityofElement(driver, giveninput);
        clickOn(giveninput);

    }

    public WebElement getsuperClassesInMetadata() {
        synchronizationVisibilityofElement(driver, superClassesInMetadata);
        return superClassesInMetadata;
    }

    public WebElement getmetadataComments() {
        synchronizationVisibilityofElement(driver, metadataComments);
        return metadataComments;
    }

    public List<WebElement> getProcessedItemsFromTable(String tableName) {
        List<WebElement> elementList= driver.findElements(By.xpath("//span[contains(text(),'" + tableName + "')]//following::tbody//tr"));
        return elementList;
    }

    public void clickAnalysisWidget() {

        clickOn(Analysis);
    }

    public WebElement returnAnlysiswidget() {

        synchronizationVisibilityofElement(driver, VerifyAnalysisWidget);
        return VerifyAnalysisWidget;
    }

    public void click_DashboardEditbutton() {
        synchronizationVisibilityofElement(driver, dashboard_EditButton);
        clickOn(dashboard_EditButton);
    }

    public void click_DetailsInCompletenessSection() {
        synchronizationVisibilityofElement(driver, DetailsInCompletenessSection);
        clickonWebElementwithJavaScript(driver, DetailsInCompletenessSection);
    }
    public void widgetDragAndDrop() {

        synchronizationVisibilityofElement(driver, new DashBoardPage(driver).getElementToBeDragged());
        mouseDragAndDrop(driver, new DashBoardPage(driver).getElementToBeDragged(), new DashBoardPage(driver).getPlaceToBeDropped());
        implicit_wait(driver, 5000);
    }

    public WebElement getElementToBeDragged() {
        synchronizationVisibilityofElement(driver, elementToBeDragged);
        return elementToBeDragged;
    }

    public List<WebElement> getPlaceToBeDropped() {
        synchronizationVisibilityofElementsList(driver, placeToBeDropped);
        return placeToBeDropped;
    }

    public List<WebElement> getPlaceToBeDropped_InSecondPage() {
        synchronizationVisibilityofElementsList(driver, placeToBeDropped_secondPage);
        return placeToBeDropped_secondPage;
    }

    public List<WebElement> getPlaceToBeDropped_Edge() {
        return placeToBeDropped_Edge;
    }

    public void click_dashboardSaveButton() {
        synchronizationVisibilityofElement(driver, dashboard_SaveButton);
        clickOn(dashboard_SaveButton);
    }

    public void clickAnalysislink() {
        synchronizationVisibilityofElement(driver, Analysis_link);
        clickOn(Analysis_link);
        sleepForSec(3000);

    }

    public void clickpythonParserlink() {
        synchronizationVisibilityofElement(driver, pythonParserlink);
        clickOn(pythonParserlink);
        waitForAngularLoad(driver);

    }

    public void clickJavaParserlink(){
        synchronizationVisibilityofElement(driver, javaParserlink);
        clickOn(javaParserlink);
        waitForAngularLoad(driver);
    }

    public void clickgitParserlink(){
        synchronizationVisibilityofElement(driver, gitParserLink);
        clickOn(gitParserLink);
        waitForAngularLoad(driver);
    }

    public void clickpythonSparkLineagelink() {
        synchronizationVisibilityofElement(driver, pythonSparklineage);
        waitForAngularLoad(driver);
        waitForAngularLoad(driver);

    }
    public void clickpythonParserlinkonAnalysis() {
        synchronizationVisibilityofElement(driver, pythonParserlinkonAnalysis);
        clickOn(pythonParserlinkonAnalysis);
        waitForAngularLoad(driver);

    }
    public void clickpythonUseFunctionlink() {
        synchronizationVisibilityofElement(driver, pythonUseFunctionlinker);
        clickOn(pythonUseFunctionlinker);
        waitForAngularLoad(driver);

    }

    public void clickpythonPackagelink() {
        synchronizationVisibilityofElement(driver, pythonPackagelinker);
        clickOn(pythonPackagelinker);
        waitForAngularLoad(driver);

    }

    public void clickpythonImportlink() {
        synchronizationVisibilityofElement(driver, pythonImportlinker);
        clickOn(pythonImportlinker);
        waitForAngularLoad(driver);

    }

    public void click_log() {

        synchronizationVisibilityofElement(driver, log);
        clickonWebElementwithJavaScript(driver,log);
        sleepForSec(3000);

    }

    public void validate_Widget_Addition() {
        synchronizationVisibilityofElement(driver, widgetaddition);
        verifyContains("ANALYSIS", widgetaddition.getText());

    }

    public String logtext() {
        return getElementText(logtext);

    }
    public void click_idadashboard() {

        synchronizationVisibilityofElement(driver, idaDashBoard);
        //clickOn(dashboardActiveTab);
        clickonWebElementwithJavaScript(driver, idaDashBoard);
    }

    public void click_widgetname() {

        synchronizationVisibilityofElement(driver, widgetClick);
        clickonWebElementwithJavaScript(driver, widgetClick);
    }

    public void click_dynamicItemInSearchResults(String ItemName, String ItemType) {
        WebElement element = driver.findElement(By.xpath("//a[contains(@title,'" + ItemName + "') and contains(@title,'" + ItemType + "') and contains(.,'" + ItemName + "')]"));
        clickonWebElementwithJavaScript(driver, element);

    }

    public WebElement getdynamicPropertyInMetadata(String ItemName,String PropertyName) {
        WebElement element= driver.findElement(By.xpath("//span[contains(text(),'"+ItemName+"')]//following::div[@class='d-flex']//div[contains(.,'"+PropertyName+"')]//div//span"));
        return element;
    }

    public WebElement rawimportdata(String ItemName, String PropertyName) {

        WebElement element = driver.findElement(By.xpath("//span[contains(.,'"+ ItemName +"')]/following-sibling::span//span[contains(.,'"+PropertyName+"')]"));

        return element;
    }

    public void click_dynamicItemFromParserProcessedItems(String ItemName) {
        WebElement element= driver.findElement(By.xpath("//span[contains(.,'"+ItemName+"')]"));
        clickonWebElementwithJavaScript(driver, element);

    }

    public WebElement getdynamicItemFromDynamicHasTable(String HasTableName,String ItemName) {
        //WebElement element= driver.findElement(By.xpath("//p[text()='"+HasTableName+"']/following-sibling::div//span[contains(.,'"+ItemName+"')]"));
        WebElement element= driver.findElement(By.xpath("//span[contains(.,'"+HasTableName+"')]//following::a[contains(.,'"+ItemName+"')]"));
        return element;
    }
    public WebElement getArrowDownIcon(String Widgetname) {
        return driver.findElement(By.xpath("//span[text()='"+Widgetname+"']//ancestor::p//span[contains(@class,'fa-caret-down')]"));
    }

    public WebElement getTrustScoreExpand(String Widgetname) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+Widgetname+"')]/preceding-sibling::span"));
    }


    public WebElement getTrustScoreCollapse(String Widgetname) {
        return driver.findElement(By.xpath("(//span[contains(text(),'"+Widgetname+"')]//following::span[contains(@class,'asg-caret-icon-toggle fa cursor-pointer')])[1]"));
    }

    public WebElement getArrowRightIcon(String Widgetname) {
        return driver.findElement(By.xpath("//span[text()='"+Widgetname+"']//ancestor::p//span[contains(@class,'fa-caret-right')]"));
    }
    public WebElement getWidgetcontainername(String Widgetname) {
        return driver.findElement(By.xpath("//span[text()='"+Widgetname+"']"));
    }
    public WebElement getWidgetname(String Widgetname) {
        return driver.findElement(By.xpath("//p[contains(@class,'widget-title')]//span[contains(.,'"+Widgetname+"')]"));
    }
    public WebElement getTabsName(String Widgetname) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-tabs')]//following::a[text()='"+Widgetname+"']"));
    }
       public WebElement getWidgetcontainervalue(String Widgetname,String ItemName) {
        return driver.findElement(By.xpath("//span[text()='"+Widgetname+"']//following::div//span[text()='"+ItemName+"']"));
    }
    public WebElement getWidgetcontainereditvalue(String Widgetname) {
        return driver.findElement(By.xpath("//span[text()='"+Widgetname+"']//following::div//input[contains(@class,'shadow-none')]"));
    }
    public WebElement getHintMessage(String Messsage) {
        return driver.findElement(By.xpath("//div[text()='"+Messsage+"']"));
    }
    public WebElement getWidgetValues() {
        return driver.findElement(By.xpath("//div[@class='asg-item-view-html-edit-container w-100 mt-2']//div[contains(@class,'ql-editor')]"));
    }

    public WebElement getBusinessApplicationTabName(String tabName) {
        return driver.findElement(By.xpath("//div[@class='asg-item-view-tabs']/ul/li/a[text()='"+tabName+"']"));
    }

    public WebElement adddescriptionvalue(String WidgetName) {
        return  driver.findElement(By.xpath("//span[text()='"+WidgetName+"']//following::div[contains(@class,'ql-editor')]"));
    }
    public WebElement addBusinessvalue(String WidgetName) {
        return  driver.findElement(By.xpath("(//span[text()='"+WidgetName+"']//following::div//input)[1]"));
    }
    public WebElement addtagName() {
        return driver.findElement(By.cssSelector("input[id='tagName']"));
    }

    public WebElement getSaveorcancelbutton(String actionItem,String Buttonname) {
        return  driver.findElement(By.xpath("//span[text()='"+actionItem+"']//following::span/span[contains(.,'"+Buttonname+"')]"));
    }
    public WebElement getBAInfobutton(String Buttonname) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-right-content')]//div[contains(@class,'item-nav d-flex flex-columns')]//span[contains(text(),'" + Buttonname + "')]"));
    }
    public WebElement getUnassignbutton(String Buttonname) {
        return driver.findElement(By.xpath("//button[contains(.,'"+Buttonname+"')]"));
    }

    public WebElement getBAInfoEditButtonDisable(String Buttonname) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-right-content')]//div[contains(@class,'item-nav d-flex flex-columns')]//span[contains(@class,'cursor-pointer disable-link cursor-not-allowed') and contains(text(),'" + Buttonname + "')]"));
    }
    public WebElement getAssignButton() {
        return driver.findElement(By.xpath("//button[contains(text(),' ASSIGN ')]"));
    }
    public WebElement getBAownerName(String Name){
        return driver.findElement(By.xpath("//span[@class[contains(., 'username px-2')]][contains(., '"+Name+"')]"));
    }
    public WebElement getOwnerCloseicon(){
        return driver.findElement(By.xpath("//div[@class='close-icon cursor-pointer']"));
    }
    public List<WebElement> getSaveorcancelWidgetButton(String actionItem, String Buttonname) {
        return  driver.findElements(By.xpath("//span[text()='"+actionItem+"']//following::span/span[contains(.,'"+Buttonname+"')]"));
    }
    public WebElement SearchTagValues() {
        return  driver.findElement(By.xpath("//div[@class='d-flex']//input[@placeholder='Search...']"));
    }
    public WebElement searchinNode() {
        return  driver.findElement(By.xpath("//div[contains(.,' Configurations ')]/..//input[@placeholder='Search...']"));
    }

    public WebElement searchConfigValues() {
        return  driver.findElement(By.xpath("//input[@placeholder='Search...' and @id='asgManageSearch']"));
    }
    public WebElement getCloseButton() {
        return  driver.findElement(By.xpath("//span[contains(@class,'manage-search-close')]"));
    }
    public WebElement getRemoveButton(String Section,String ItemName) {
        return  driver.findElement(By.xpath("//span[contains(.,'"+Section+"')]//following::span[contains(.,'"+ItemName+"')]//following::span[contains(@class,'remove')][1]"));
    }
    public WebElement getTagButton(String Section) {
        return  driver.findElement(By.xpath("//span[text()=' "+Section+" ']//following::span[contains(@class,'select-none')][text()=' Tag '][1]"));
    }
    public WebElement getConfigButton(String Section) {
        return  driver.findElement(By.xpath("//span[text()='"+Section+"']"));
    }
    public WebElement getTagstoAssign(String Section,String ItemName) {
        return  driver.findElement(By.xpath("//span[contains(.,'"+Section+"')]//following::div[@class[contains(.,'select-none')]]/span[contains(.,'"+ItemName+"')]"));
    }
    public WebElement getTopbar(String ItemName,String Section){
        return driver.findElement(By.xpath("//div[contains(@class,'top-bar-section')]//div[contains(@class,'tag-wrapper')]/div//label[contains(.,'"+ ItemName+"')]/../../../span[contains(text(),'"+ Section +"')]"));
    }
    public WebElement getBusinessapplpage(String ItemName,String Section){
        return driver.findElement(By.xpath("//div[contains(@class,'top-bar-section')]//div[contains(@class,'tag-wrapper')]/div//label[contains(.,'"+ ItemName+"')]/../../../a[contains(text(),'"+ Section +"')]"));
    }
    public WebElement getTopbardata(String ItemName,String Section){
        return driver.findElement(By.xpath("//div[contains(@class,'top-bar-section')]//div[contains(@class,'tag-wrapper')]/div//label[contains(.,'"+ ItemName+"')]/../../../div[contains(text(),'"+ Section +"')]"));
    }
    public WebElement getAddTagButton() {
        return driver.findElement(By.xpath("//div[contains(@class,'fa fa-plus-square cursor-pointer')]"));
    }
    public WebElement getLicenseError() {
        return driver.findElement(By.xpath("//div[@class='modal-body']//p[text()]"));
    }
    public WebElement getTrustScoreValue(String ItemName) {
        return driver.findElement(By.xpath("//div[contains(@class,'details-section')]//following::li//span[contains(.,'"+ItemName+"')]//span"));
    }
    public WebElement getCreateTagButton() {
        return driver.findElement(By.xpath("//div[contains(@class,'cursor-pointer label-color')]"));
    }
    public WebElement getSearchIcon() {
        return driver.findElement(By.xpath("//span[contains(@class,'manage-search')]"));
    }
    public WebElement getEditIcon(String WidgetValue) {
        return driver.findElement(By.xpath("//span[text()='"+WidgetValue+"']/following::span[1]/em[@class='fa fa-edit']"));
    }

    public WebElement getEditIconWidget(String WidgetValue) {
        return driver.findElement(By.xpath("//span[text()='"+WidgetValue+"']//following::span//em[@class='fa fa-edit'][1]"));
    }

    public WebElement getWidgetContainerName() {
        WebElement element= driver.findElement(By.xpath("//p[contains(@class,'asg-item-view-taglist-widget-title')]"));
        return element;
    }
    public WebElement getInformationMessage(String ActionItem) {
        return driver.findElement(By.xpath("//span[contains(.,'Assigned')]//following::div[contains(.,'"+ActionItem+"')]"));
    }

    public WebElement getPluginInformationMessage(String ActionItem) {
        return driver.findElement(By.xpath("//div[contains(text(),' "+ActionItem+" ')]"));
    }

    public WebElement getdynamicItemFromDynamicHasTableifnotavailablediff(String HasTableName, String ItemName) {
        try {
        WebElement element = driver.findElement(By.xpath("//span[text()='"+HasTableName+"']/following::div//a[contains(.,'"+ItemName +"')]"));
        return element;
    }

        catch (Exception e){
        return null;
    }
    }

    public WebElement getdynamicItemFromDynamicHasTableifnotavailable(String HasTableName, String ItemName) {

        try {
            WebElement element = driver.findElement(By.xpath("//span[text()='" + HasTableName + "']/preceding::ng-component[1]/following::div/following::div//following-sibling::span[contains(.,'" + ItemName + "')]"));
            return element;
        }
        catch (Exception e){
            return null;
        }
    }

    public WebElement getdynamicItemFromDynamicHasTablewithdifftagforvalidation(String HasTableName, String ItemName) {


            WebElement element = driver.findElement(By.xpath("//span[text()='" + HasTableName + "']/preceding::ng-component[1]/following::div/following::div//following-sibling::span[contains(.,'" + ItemName + "')]"));
            return element;

    }

    public WebElement getresultsofoperations(String ItemName) {
        WebElement element = driver.findElement(By.xpath("//td[@data-title='name']/a[contains(text(),'"+ItemName+"')]"));
        return element;
    }

    public WebElement getresultsofoperationsforcondition(String ItemName) {
      try {

          WebElement element = driver.findElement(By.xpath("//td[@data-title='name']/a[contains(text(),'" + ItemName + "')]"));
          return element;
      }
                catch (Exception e){
            return null;
        }
    }

//    public List<WebElement> listofCountofOperations() {
//        List<WebElement> listofcount = driver.findElements(By.xpath("//td[@data-title='name']"));
//        String[] str = new String[listofcount.size()];
//        for (int i = 0 ; i<str.length ; i++){
//            str[i] = driver.findElements(By.xpath("//td[@data-title='name']")).get(i).getText();
//        }//for
//        Arrays.sort(str);
//        for(String strr: str){
//            System.out.println(strr);
//        }
//
//        return listofcount;
//    }

    public WebElement TraverseontheOperations(int iteration) {
       try {
           WebElement elementList = driver.findElement(By.xpath("//td[@data-title='name']/a[contains(text(),' Dataframe Operation" + iteration + "')]"));
           return elementList;
       }
        catch (Exception e){
            return null;
        }
    }

    public WebElement exitofResultButton() {
        WebElement element = driver.findElement(By.cssSelector("div.asg-panels-item.asg-item-view.asg-panels-active-item.full-size-item > div >  div.asg-panels-item-caption.clearfix.scrollable > button.exit-btn > i"));
        synchronizationVisibilityofElement(driver,element);
        return element;
    }


    public WebElement getresultsofoperationsifnotavailable(String ItemName) {

        try {
            //return  driver.findElement(By.xpath("//td[@data-title='name']/a[contains(text(),'" + ItemName + "')]"));
            return driver.findElement(By.xpath("//span[contains(text(),'"+ItemName+"')]"));

        }

        catch (Exception e){
        return null;
    }
    }


/*    public WebElement getdynamicItemFromDynamicHasTablefromImportLink(String HasTableName, String ItemName) {

        boolean flag = false;
      if(driver.findElement(By.xpath("//p[text()='" + HasTableName + "']/following-sibling::div//span[contains(.,'" + ItemName + "')]")).isDisplayed()== false);
          element.isDisplayed()
               return element;
    }*/

    public WebElement getdynamicItemtextFromDynamicHasTablefromImportLink(String HasTableName, String ItemName) {
        WebElement element = driver.findElement(By.xpath("//p[text()='" + HasTableName + "']/following-sibling::div//span[contains(.,'" + ItemName + "')]"));
        return element;
    }
//
//    public WebElement importsection (){
//        return importtable;
//    }

    public void click_dynamicItemFromDynamicHasTable1(String HasTableName, String ItemName) {
        WebElement element = driver.findElement(By.xpath("(//span[text()='"+HasTableName+"']/following::div//span[contains(.,'"+ItemName +"')])[7]"));
        clickonWebElementwithJavaScript(driver, element);
    }

    public void click_dynamicItemFromDynamicHasTable(String HasTableName, String ItemName) {
        WebElement element = driver.findElement(By.xpath("(//span[text()='"+HasTableName+"']/following::div//span[contains(.,'"+ItemName +"')])"));
        clickonWebElementwithJavaScript(driver, element);
    }

    public void click_absoluteDynamicItemFromDynamicHasTable(String HasTableName, String ItemName) {
        WebElement element = driver.findElement(By.xpath("//span[text()='"+HasTableName+"']/following::div//a[normalize-space(text())='"+ItemName +"']"));
        clickonWebElementwithJavaScript(driver, element);
    }

    public WebElement returngitCollectorLink() {
        synchronizationVisibilityofElement(driver, gitCollectorlink);
        return gitCollectorlink;
    }

    public WebElement returnhdfsCollectorLink() {
        synchronizationVisibilityofElement(driver, hdfsCollectorlink);
        return hdfsCollectorlink;
    }

    public void clickhdfsCollectorLink() {
        synchronizationVisibilityofElement(driver, hdfsCollectorlink);
        clickOn(hdfsCollectorlink);
        sleepForSec(3000);
    }

    public WebElement returnoracleCatalogerLink() {
        synchronizationVisibilityofElement(driver, oracleCatalogerlink);
        return oracleCatalogerlink;
    }

    public void clickoracleCatalogerLink() {
        synchronizationVisibilityofElement(driver, oracleCatalogerlink);
        clickOn(oracleCatalogerlink);
        sleepForSec(3000);
    }

    public void clickgitCollectorLink() {
        synchronizationVisibilityofElement(driver, gitCollectorlink);
        clickOn(gitCollectorlink);
        sleepForSec(3000);
    }

    public void click_dynamicItemTypeFromDynamicHasTable(String HasTableName, String ItemName) {
        WebElement element= driver.findElement(By.xpath("//p[contains(.,'"+HasTableName+"')]/following-sibling::div//span[contains(.,'"+ItemName+"')]/following::span[1]"));
        clickonWebElementwithJavaScript(driver, element);
    }

    public List<WebElement> getListOFTagsForDynamicItem(String itemName) {
        List<WebElement> elementList= driver.findElements(By.xpath("//b[contains(.,'"+itemName+"')]/ancestor::div[@class='inner-item']//p[contains(.,'TAG')]/following-sibling::div/ul/li/span"));
        return elementList;
    }
    public void clickAnalysisJobLink(String analysisName) {
        driver.findElement(By.xpath("//div[@class='asg-area-widget-recent-item']//a[contains(.,'" + analysisName + "')]")).click();
    }

    public WebElement metaDataWidgetItemValues(String itemName) {
        return driver.findElement(By.xpath("//div[@class[contains(.,'asg-item-view-multi-properties-widget-body')]]//div[contains(text(),'"+itemName+"')]/following::span[1]"));

    }

    public WebElement getMetaDataValues(String propName){
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-multi-properties-widget-body')]//div[text()=' "+propName+" ']/following::span[1]"));
    }

    public WebElement verifyLastlinkeddate(){
        return driver.findElement(By.xpath("//div[@class='asg-item-view-multi-properties-widget-body']/form//ul/li/div/div[contains(text(),'Last linked date')]"));
    }

    public String getLastlinkeddate(){
        return driver.findElement(By.xpath("//div[@class='asg-item-view-multi-properties-widget-body']/form//ul/li/div/div[contains(text(),'Last linked date')]/following::span[1]")).getText();
    }


    public WebElement importsection (){
        return importtable;
    }

    public String logtextuse() {
        return getElementText(logtext);

    }

    public int getSourceTreeWindNumbers(){
        List<WebElement> windowList = driver.findElements(By.xpath("//span[contains(text(),'SOURCE TREE')]"));
        return windowList.size();
    }

    public int getUsesWindNumbers(){
        List<WebElement> windowList = driver.findElements(By.xpath("//span[contains(text(),'USES')]"));
        return windowList.size();
    }

    public int getLineageHopsWindNumbers(){
        List<WebElement> hopWindowList = driver.findElements(By.xpath("//span[text()='LineageHop']"));
        return hopWindowList.size();
    }

    public int getDynamicWindNumbers(String windowName){
        List<WebElement> hopWindowList = driver.findElements(By.xpath("//span[text()='"+windowName+"']"));
        return hopWindowList.size();
    }

    public List<WebElement> getprocesseditemsOfparser() {

        synchronizationVisibilityofElementsList(driver, processedItemsOfParser);
        return processedItemsOfParser;
    }


    public List<WebElement> getListOFTags() {
        List<WebElement> tagList= driver.findElements(By.xpath("//b[contains(.,'')]/ancestor::div[@class='inner-item']//p[contains(.,'TAG')]/following-sibling::div/ul/li/span"));
        return tagList;
    }

    public List<WebElement> getListOFTagsNew(String item) {
        List<WebElement> tagList= driver.findElements(By.xpath("//span[contains(text(),'" +item+ "')]//following::span[contains(text(),'Tags')]//following::div[contains(@class,'item-view-taglist-widget ')]//span"));
        synchronizationVisibilityofElementsList(driver,tagList);
        return tagList;
    }
    public WebElement verifyAnalysisPage() {
        synchronizationVisibilityofElement(driver, AssignDataSet);
        return AssignDataSet;
    }

    public WebElement processedItemsFileNameRow(String fileName, String tableName ) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+ tableName +"')]//following::tbody//tr//td[contains(.,'"+ fileName +"')]"));
    }
    public WebElement processedItemsFileTypeRow(String fileType, String tableName) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+ tableName +"')]//following::tbody//tr//span[@title='"+ fileType +"']"));
    }

    public WebElement getClassNameOfFunction(String functionName){
        return driver.findElement(By.xpath("//strong[text()='Hierarchy']/parent::div//div//ul/li/div[text()='"+functionName+"']/ancestor::ul[2]//li/div/div[2]"));
    }

    public WebElement getMetaDataValuesInItemSection(String propName, String sectionName) {
        return driver.findElement(By.xpath("//div[contains(@class,'asg-item-view-multi-properties-widget')]//span[text()='"+sectionName+"']/../../../div[contains(@class,'asg-item-view-multi-properties-widget-body')]/div/ul/li//div/div[text()=' "+ propName +" ']/../div[2]"));
    }


    public WebElement getTabvalueManageAccess(String ActionItem) {
        return driver.findElement(By.xpath("//ul[@class='nav nav-tabs']//a[contains(text(),'" + ActionItem + "')]"));
    }

    public WebElement getTestUserTabvalues(String ActionItem) {
        return driver.findElement(By.xpath("//td[@title='"+ActionItem+"']//span[contains(text(),'"+ActionItem+"')]"));
    }
    public WebElement getTUsersandgroupsTabvalues(String ActionItem) {
        return driver.findElement(By.xpath("//td[contains(@class,'text-truncate')]//span[text()='" + ActionItem + "']"));
    }
    public WebElement getRolespermission(String ActionItem) {
        return driver.findElement(By.xpath("//tr[contains(@class,'tr-row')]//td//input[@id='"+ActionItem+"']"));
    }

    public WebElement getSectionDisplayedvalue(String ActionItem) {
        return driver.findElement(By.xpath("//span[@class='title position-relative' and text()='" + ActionItem + "')]"));
    }

    public WebElement getTestUserRoleValue(String ActionItem) {
        return driver.findElement(By.xpath("//span[@class='ng-star-inserted' and text()='" + ActionItem + "']"));
    }

    public WebElement getTestUserFilter() {
        return driver.findElement(By.xpath("//div[@class='header w-100 border-bottom-0']//following::span[@class='mr-3 manage-search cursor-pointer position-relative fa fa-filter ng-star-inserted']"));
    }

    public WebElement getcreateTestUser() {
        return driver.findElement(By.xpath("//div[@class='header w-100 border-bottom-0']//following::span[@class='add-data-source mt-3 mr-3 fa fa-plus-square cursor-pointer ng-star-inserted']"));
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
    public WebElement  getManageAccessNameRoleType(String actionItem) {
        return driver.findElement(By.xpath("//span[@class='cursor-pointer' and contains(text(),' " + actionItem + "')]"));
    }
    public WebElement getCreateTestUserName() {
        synchronizationVisibilityofElement(driver, CreateTestUserName);
        return CreateTestUserName;
    }
    public WebElement getCreateTestUserPassword() {
        synchronizationVisibilityofElement(driver, CreateTestUserPassword);
        return CreateTestUserPassword;
    }
    public WebElement getCreateTestUserEmail() {
        synchronizationVisibilityofElement(driver, CreateTestUserEmail);
        return CreateTestUserEmail;
    }
    public WebElement getCreateTestUserRoles() {
        synchronizationVisibilityofElement(driver, CreateTestUserRoles);
        return CreateTestUserRoles;
    }
    public WebElement getCreateTestUserRoleButton() {
        synchronizationVisibilityofElement(driver, CreateTestUserRoleButton);
        return CreateTestUserRoleButton;
    }
    public WebElement getCreateTestUserSave() {
        synchronizationVisibilityofElement(driver, ManageaccessSaveButton);
        return ManageaccessSaveButton;
    }
    public WebElement getCreateTestUserCancel() {
        synchronizationVisibilityofElement(driver, ManageaccessCancelButton);
        return ManageaccessCancelButton;
    }
    public WebElement getCreateTestUserEditButton() {
        synchronizationVisibilityofElement(driver, CreateTestUserEditButton);
        return CreateTestUserEditButton;
    }
    public WebElement getEditTestUserRolecloseButton() {
        synchronizationVisibilityofElement(driver, EditTestUserRolecloseButton);
        return EditTestUserRolecloseButton;
    }
    public WebElement getEditTestUserChangePassword(String actionItem) {
        return driver.findElement(By.xpath("//span[@class='asg-change-password float-left bg-transparent cursor-pointer text-left mt-2 ng-star-inserted' and contains(text(),'" + actionItem +"')]"));
    }
    public WebElement getUsersandRolesSystem() {
        synchronizationVisibilityofElement(driver, UsersandRolesSystem);
        return UsersandRolesSystem;
    }
    public WebElement getUsersandRolessearchText() {
        synchronizationVisibilityofElement(driver, UsersandRolesSearchText);
        return UsersandRolesSearchText;
    }
    public WebElement getusersandgroupsrolevalidation(String actionItem) {
        return driver.findElement(By.xpath("//div[contains(@class,'d-flex tag mr-1 mb-1 p-1 ng-star-inserted')]//span[contains(text(),'"+actionItem+"')]"));
    }
    public WebElement getusersandgroupsrolecancelformpage(String actionItem) {
        return driver.findElement(By.xpath("//button[@class='btn asg-btn-confirm-primary float-right'][contains(text(),'"+actionItem+"')]"));
    }

    public void processedItemsToClick(String tableName, String itemName) {
        WebElement item = driver.findElement(By.xpath("//span[contains(text(),'"+ tableName +"')]//following::tbody//tr//span[contains(text(),'"+itemName+"')]"));
        synchronizationVisibilityofElement(driver, item);
        clickOn(item);
    }

    /* public String getLogsList() {
         String finaltext = "";
         for (int i = 1; i < logsList.size(); i++) {
             waitForAngularLoad(driver);
             moveToElement(driver, logElement(i));
             finaltext = finaltext.concat(logElement(i).getText());
         }
         return finaltext;

     }*/
    public WebElement getTrustscoreHeader(String actionItem) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+actionItem+"')]//following::p[1]"));
    }
    public WebElement getBusinessApplicationTabs(String actionItem) {
        return driver.findElement(By.xpath("//li[contains(@class,'nav-item')]//a[contains(text(),'"+actionItem+"')]"));
    }

    public WebElement getSequenceNumberFromDynamicHasTable(String HasTableName,String ItemName) {
        WebElement element= driver.findElement(By.xpath("//span[text()='"+HasTableName+"']/../../..//a[text()='"+ItemName+"']/../../td[4]"));
        return element;
    }

    public WebElement getProgressBarDetailsSection(String tabName) {
       return driver.findElement(By.xpath("//div[@class[contains(.,'category-name text-truncate')]][contains(.,'"+tabName+"')]//following-sibling::div/div"));
    }

    public WebElement getProgressBarCompletenessSection(String Name) {
        return driver.findElement(By.xpath("(//span[contains(text(),'"+Name+"')]/../../../div[1]//span[1])[1]"));
    }

    public WebElement getCompletenessEmotionIcon(String headerName,String emotionState) {
        return driver.findElement(By.xpath("//span[contains(text(),'"+headerName+"')]/../../../div[1]//span[contains(@class,'absolute fal fa-"+emotionState+"')]"));
    }

    public WebElement getBusinessApplicationField(String headerName,String fieldName) {
        return driver.findElement(By.xpath("//span[text()='"+headerName+"']/../../following-sibling::div//div[contains(text(),'"+fieldName+"')]/..//input[1]"));
    }

    public String getLogsList(String analysisName) throws Throwable {
        RESTAPIDefinition restObj = new RESTAPIDefinition();
        List<String> url = new ArrayList<>();
        String analysisQuery;
        String contentQuery;
        String analysisID = null;
        String contentID = null;
        String encodedValue = null;
        String decodedValue = null;
        restObj.initializeRestAPI("IDC");
        restObj.a_query_param_with_and_and_supply_authorized_users_contentType_and_Accept_headers("", "");
        analysisQuery = "SELECT  id from public.items where type='Analysis' and name like '" + analysisName + "' ORDER By  asg_createdat DESC LIMIT 1;";
        analysisID = dbHelper.returnStringValue("APPDBPOSTGRES", analysisQuery, "id");
        contentQuery = "SELECT  id from public.items where type='Content' and name = 'log' and asg_scopeid ='" + analysisID + "'";
        contentID = dbHelper.returnStringValue("APPDBPOSTGRES", contentQuery, "id");
        url.add("items/Default/Default.Content:::" + contentID);
        restObj.invokeGetRequest(url.get(0));
        encodedValue = restObj.getJsonValueUsingJsonPath("$.asg_binary");
        decodedValue = CommonUtil.stringDecoder(encodedValue);
        return decodedValue;

    }

    public WebElement getBAArchitectureTabDropdown(String fieldName) {
        return driver.findElement(By.xpath("(//div[contains(text(),'"+fieldName+"')])[1]//following::button[@class='form-control hide-default-toggle dropdown-toggle'][1]"));
    }

    public WebElement getBAArchitectureTabDropdownValue(String fieldName) {
        return driver.findElement(By.xpath("//input[@id='"+fieldName+"']"));
    }

    public WebElement getArchtectureDropdownValues(String fieldName,String ItemName) {
        return driver.findElement(By.xpath("//div[contains(text(),'"+fieldName+"')]//following::span[contains(text(),'"+ItemName+"')]"));
    }

    public WebElement getAssignedTagsSearchIcon() {
        return driver.findElement(By.xpath("(//span[contains(.,'Assigned tags')]//following::span[contains(@class,'manage-search')])[1]\"));"));
    }

    public WebElement SelectAssignTagSearchTag(String tag) {
        return  driver.findElement(By.xpath("//span[contains(text(),'"+tag+"')]"));
    }

    public WebElement getAddNewxcelImport() {
        synchronizationVisibilityofElement(driver, AddNewExcelImport);
        return AddNewExcelImport;
    }

    public WebElement getSaveIconBusinessApplication() {
        synchronizationVisibilityofElement(driver, BASave);
        return BASave;
    }

    public WebElement getCancelIconBusinessApplication() {
        synchronizationVisibilityofElement(driver, BACancel);
        return BACancel;
    }

    public String getLogsImportList(String Importname) throws Throwable {
        RESTAPIDefinition restObj = new RESTAPIDefinition();
        List<String> url = new ArrayList<>();
        String importQuery;
        String contentQuery;
        String importID = null;
        String contentID = null;
        String encodedValue = null;
        String decodedValue = null;
        restObj.initializeRestAPI("IDC");
        restObj.a_query_param_with_and_and_supply_authorized_users_contentType_and_Accept_headers("", "");
        importQuery = "SELECT  id from public.items where type='ImportRun' and name like '" + Importname + "' ORDER By  asg_modifiedat DESC LIMIT 1;";
        importID = dbHelper.returnStringValue("APPDBPOSTGRES", importQuery, "id");
        contentQuery = "SELECT  id from public.items where type='Content' and asg_scopeid ='" + importID + "'";
        contentID = dbHelper.returnStringValue("APPDBPOSTGRES", contentQuery, "id");
        url.add("import/spreadsheets/importrun/log?importrunid=Default.ImportRun:::" + importID);
        restObj.invokeGetRequest(url.get(0));
        encodedValue = restObj.getJsonValueUsingJsonPath("$.data");
        decodedValue = CommonUtil.stringDecoder(encodedValue);
        return decodedValue;

    }

}