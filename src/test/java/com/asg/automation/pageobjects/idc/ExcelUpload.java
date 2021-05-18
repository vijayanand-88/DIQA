package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class ExcelUpload extends UIWrapper {

    private WebDriver driver;

    @FindBy(xpath = "//a[@class='asg-base-widget-title'][contains(text(),'EXCEL UPLOAD MANAGER')]")
    private WebElement ExcelUploadManagement;

    @FindBy(xpath="//button/span[contains(text(),'Upload Excel File')]")
    private WebElement uploadExcelButton;

    @FindBy(xpath = "//div/input[@id='fileName']/following::span/span")
    private WebElement browseButton;

    @FindBy(css = "div[class='asg-excel-upload-file-submit'] > button[type='submit']")
    private WebElement submitButton;

    @FindBy(css ="div > label[for='asg-custom-checkbox']" )
    private WebElement allowUpdateCheckBox;

    @FindBy(xpath = "//li[@class='pagination-next page-item']/a")
    private WebElement paginationNextButton;

    @FindBy (css = "div[class='alert alert-danger']")
    private WebElement alertMessage;

    @FindBy (css = "div>ul[class='list-group properties-widget']>li")
    private List<WebElement> UploadDataProd;

    @FindBy (xpath = "//div/form/ul[@class='list-group properties-widget']/li/span[@class[contains(.,'list-group-item-left')]]")
    private List<WebElement> propName;

    @FindBy (xpath = "//div/form/ul[@class='list-group properties-widget']/li/span[@class[contains(.,'list-group-item-right')]]")
    private List<WebElement> propValue;

    public ExcelUpload(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized Excel upload page");
    }

    public void clickExcelUploadManager() {
        scrollToWebElement(driver, ExcelUploadManagement);
        clickonWebElementwithJavaScript(driver,ExcelUploadManagement);
    }
    public WebElement returnUploadExcel(){
        synchronizationVisibilityofElement(driver, uploadExcelButton);
        return uploadExcelButton;
    }

    public WebElement returnBrowseButton(){
        synchronizationVisibilityofElement(driver, browseButton);
        return browseButton;
    }

    public WebElement returnDropDownFromExcelUpload(String labelName){
        synchronizationVisibilityofElement(driver,driver.findElement(By.xpath("//div/label/b[contains(text(),'"+labelName+"')]/following::button[1]")));
        return driver.findElement(By.xpath("//div/label/b[contains(text(),'"+labelName+"')]/following::button[1]"));
    }

    public WebElement returnDropDownElement(String dropDownElement){
        synchronizationVisibilityofElement(driver,driver.findElement(By.xpath("//ul/li/a/span[contains(text(),'"+dropDownElement+"')]")));
        return driver.findElement(By.xpath("//ul/li/a/span[contains(text(),'"+dropDownElement+"')]"));
    }

    public WebElement returnTextBoxElements(String labelName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div/label/b[contains(text(),'" + labelName + "')]/following::input[1]")));
        return driver.findElement(By.xpath("//div/label/b[contains(text(),'" + labelName + "')]/following::input[1]"));
    }

    public WebElement returnExcelUploadSubmit(){
        synchronizationVisibilityofElement(driver,submitButton);
        return submitButton;
    }

    public WebElement returnUploadData(String fileName) {
      synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//table/tbody/tr/td/a[contains(text(),'"+fileName+"')]")),15);
        return driver.findElement(By.xpath("//table/tbody/tr/td/a[contains(text(),'"+fileName+"')]"));
    }

    public List<WebElement> returnUploadDataList(String fileName) {
        return driver.findElements(By.xpath("//table/tbody/tr/td/a[contains(text(),'"+fileName+"')]"));
    }

    public WebElement returnPanelName (String panelName){
        synchronizationVisibilityofElement(driver,driver.findElement(By.xpath("//div/b[contains(text(),'"+panelName+"')]")));
        return driver.findElement(By.xpath("//div/b[contains(text(),'"+panelName+"')]"));
    }

    public WebElement returnallowUpdateCheckBox(){
        synchronizationVisibilityofElement(driver,allowUpdateCheckBox);
        return allowUpdateCheckBox;
    }

    public void click_paginationNextButton() {

        synchronizationVisibilityofElement(driver, paginationNextButton);
        clickOn(paginationNextButton);
    }

    public WebElement returnAlertMessage(){
        synchronizationVisibilityofElement(driver,alertMessage);
        return alertMessage;
    }

    public WebElement returnAlertDropDownElement(String labelName){
        synchronizationVisibilityofElement(driver,driver.findElement(By.xpath("//div/label/b[contains(text(),'"+labelName+"')]" +
                "/following::button[@class='form-control clearfix asg-invalid-form-element']")));
        return driver.findElement(By.xpath("//div/label/b[contains(text(),'"+labelName+"')]" +
                "/following::button[@class='form-control clearfix asg-invalid-form-element']"));
    }

    public WebElement returnAlertTextBoxElements(String labelName) {
        synchronizationVisibilityofElement(driver, driver.findElement(By.xpath("//div/label/b[contains(text(),'" + labelName + "')]" +
                "/following::input[@class='form-control asg-invalid-form-element ng-untouched ng-pristine ng-invalid']")));
        return driver.findElement(By.xpath("//div/label/b[contains(text(),'" + labelName + "')]" +
                "/following::input[@class='form-control asg-invalid-form-element ng-untouched ng-pristine ng-invalid']"));
    }

    public List<WebElement> returnUploadDataProp(){
        return UploadDataProd;
    }

    public List<WebElement> returnPropName(){
        return propName;
    }

    public List<WebElement> returnPropValue(){
        return propValue;
    }


}
