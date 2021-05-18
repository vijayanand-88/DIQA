package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.CommonUtil;
import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import junit.framework.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.*;


/**
 * Created by Sivanandam.Meiya on 12/22/2017.
 */
public class BundleManager extends UIWrapper {
    private WebDriver driver;

    public BundleManager(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intializing Bundle Manager PageFactory Class");
    }

    @FindBy(css = "div[class='asg-bundle-list']>div>span:nth-of-type(1)")
    private List<WebElement> bundlePluginList;


    @FindBy(css = "table[class='table table-hover']>tbody>tr>td:nth-of-type(1)")
    private List<WebElement> bundleVersionCount;

    @FindBy(xpath = "//div[@title='BUNDLE DETAILS']//following::button[@class='exit-btn'][1]")
    private WebElement bundleDetailsCloseButton;

    @FindBy(xpath = "//div[@title='BUNDLE VERSION DETAILS']//following::button[@class='exit-btn'][1]")
    private WebElement bundleDetailsVersionCloseButton;

    @FindBy(css = "button[class='btn btn-default']>span:nth-of-type(1)")
    private WebElement bundleDetailsDelete;


    @FindBy(css = "div[class='asg-bundle-types-list-content']>div>div>div")
    private List<WebElement> bundleTypeList;

    @FindBy(xpath = "//div[@class='asg-bundle-item'][1]")
    private WebElement analysisFirstBundle;

    @FindBy(xpath = "//th[contains(text(),'BUNDLE VERSION')]/following::td[1]")
    private WebElement bundleVersionFirstBundle;

    @FindBy(xpath = "//b[contains(text(),'BUNDLE VERSION DETAILS')]/following::label[contains(text(),'NAME')]")
    private WebElement bundleNameLabel;

    @FindBy(xpath = "//b[contains(text(),'BUNDLE VERSION DETAILS')]/following::label[contains(text(),'TYPE')]")
    private WebElement bundleTypeLabel;

    @FindBy(xpath = "//b[contains(text(),'BUNDLE VERSION DETAILS')]/following::label[contains(text(),'VERSION')]")
    private WebElement bundleVersionLabel;

    @FindBy(xpath = "//b[contains(text(),'BUNDLE VERSION DETAILS')]/following::label[contains(text(),'PLUGINS')]")
    private WebElement bundlePluginsLabel;

    @FindBy(xpath = "//b[contains(text(),'PLUGIN NAME')]/following::span")
    private WebElement bundlePluginNames;

    @FindBy(css = "div[class='alert alert-danger response-error']>div")
    private WebElement invalidBundleUploadError;

    @FindBy(css = "div[class='asg-bundle-list']>div>span:nth-of-type(2)")
    private WebElement bundleManagementPluginVersionCount;

    @FindBy(css = "table[class='table table-hover']>tbody>tr>td:nth-of-type(1)")
    private List<WebElement> bundleVersionPluginCount;

    @FindBy(xpath = "//div[@class='modal-content']//following::button[@class='close float-right']/span")
    private WebElement errorCloseButton;

    public WebElement clickBundleType(String bundleType) {
        return driver.findElement(By.xpath("//div[@class='asg-bundle-type']//span[contains(text(),'" + bundleType + "')]"));
    }

    public WebElement clickBundleName(String bundleName) {
        return driver.findElement(By.xpath("//div[@class='asg-bundle-type']//span[contains(text(),'" + bundleName + "')]"));
    }

    public List<WebElement> getPluginMetadata(String pluginName) {
        return driver.findElements(By.xpath("//span[contains(text(),'" + pluginName + "')]/ancestor::div[@class='asg-plugin-container']//div[@class='asg-plugin-item-name']"));
    }

    public WebElement getSubBundleName(String subBundleName) {
        return driver.findElement(By.xpath("//div[@class='asg-bundle-item']//span[contains(.,'" + subBundleName + "')]"));
    }

    public WebElement getPluginVersion(String pluginVersion) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']//td[@class='float-right' and contains(.,'" + pluginVersion + "')]"));
    }

    public WebElement getBundleVersion() {
        return driver.findElement(By.xpath("//div[@class='content-table']//tr/td[1]"));
    }

    public WebElement getPluginNameDetails(String pluginName) {
        return driver.findElement(By.xpath("//div[@class='asg-plugin-container']//div[@class='asg-plugin']//span[text()='" + pluginName + "']"));
    }

    public WebElement getPluginInformation(String information) {
        return driver.findElement(By.xpath("//div[@class='asg-plugin-content']//div[@class='asg-plugin-item-name' and contains(.,'" + information +"')]"));
    }

    public WebElement pluginListInBundleType(String bundleName) {
        return driver.findElement(By.xpath("//span[contains(text(),'" + bundleName + "')]//following::div[@class='asg-bundle-list']/div/span[1]"));
    }


    public WebElement clickPluginName(String pluginName) {
        return driver.findElement(By.xpath("//div[@class='asg-bundle-list']//div[@class='asg-bundle-item']//span[contains(text(),'" + pluginName + "')]"));
    }

    @FindBy(css = "div[class='actions-bar']>button>span:nth-of-type(1)")
    private WebElement bundleUploadButton;

    @FindBy(css = "span[class='btn btn-default btn-file asg-bundle-upload-btn']")
    private WebElement bundleuploadBrowse;

    @FindBy(css = "div[class='submit']>button[type='submit']")
    private WebElement bundleUploadSubmit;

    @FindBy(css = "div[class='asg-bundle-upload-file-size']>span:nth-of-type(1)")
    private WebElement bundleUploadFileSize;

    @FindBy(xpath = "//div[@title='BUNDLE DETAILS']")
    private WebElement bundleDetailsPanelHeader;

    @FindBy(css = "button[class='btn btn-default asg-bundle-management-top-btns']")
    private WebElement bundleManagementUploadButton;

    @FindBy(xpath = "//b[contains(text(),'UPLOAD BUNDLE')]")
    private WebElement uploadBundlePanelHeader;

    @FindBy(xpath = "//span[contains(.,'Plugin Management')]")
    private WebElement pluginManagementButton;

    @FindBy(xpath = "//span[contains(.,'Download Content')]")
    private WebElement DownloadContentButton;

    @FindBy(css = "div[class='submit'] > button[type='submit']")
    private WebElement submitButton;

    public WebElement getbundleManagementUploadButton() {
        synchronizationVisibilityofElement(driver, bundleManagementUploadButton);
        return bundleManagementUploadButton;
    }

    public WebElement getBundleDetailsPanelHeader() {
        synchronizationVisibilityofElement(driver, bundleDetailsPanelHeader);
        return bundleDetailsPanelHeader;
    }

    public WebElement getUploadBundlePanelHeader() {
        synchronizationVisibilityofElement(driver, uploadBundlePanelHeader);
        return uploadBundlePanelHeader;
    }


    public List<WebElement> bundlePluginList() {
        synchronizationVisibilityofElementsList(driver, bundlePluginList);
        return bundlePluginList;
    }

    public List<WebElement> bundleVersionCount() {
        synchronizationVisibilityofElementsList(driver, bundleVersionCount);
        return bundleVersionCount;
    }

    public WebElement bundleDetailsCloseButton() {
        synchronizationVisibilityofElement(driver, bundleDetailsCloseButton);
        return bundleDetailsCloseButton;
    }

    public WebElement bundleDetailsVersionCloseButton() {
        synchronizationVisibilityofElement(driver, bundleDetailsVersionCloseButton);
        return bundleDetailsVersionCloseButton;
    }

    public List<WebElement> bundleTypeList() {
        synchronizationVisibilityofElementsList(driver, bundleTypeList);
        return bundleTypeList;
    }


    public WebElement bundleDetailsDelete() {
        synchronizationVisibilityofElement(driver, bundleDetailsDelete);
        return bundleDetailsDelete;
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

    public String bundleUploadFileSize() {
        synchronizationVisibilityofElement(driver, bundleUploadFileSize);
        return bundleUploadFileSize.getText().substring(11);
    }


    public WebElement getAnalysisFirstBundle() {
        synchronizationVisibilityofElement(driver, analysisFirstBundle);
        return analysisFirstBundle;
    }

    public WebElement getBundleVersionFirstBundle() {
        synchronizationVisibilityofElement(driver, bundleVersionFirstBundle);
        return bundleVersionFirstBundle;
    }

    public WebElement getBundleNameLabel() {
        synchronizationVisibilityofElement(driver, bundleNameLabel);
        return bundleNameLabel;
    }

    public WebElement getBundleTypeLabel() {
        synchronizationVisibilityofElement(driver, bundleTypeLabel);
        return bundleTypeLabel;
    }

    public WebElement getBundleVersionLabel() {
        synchronizationVisibilityofElement(driver, bundleVersionLabel);
        return bundleVersionLabel;
    }

    public WebElement getBundlePluginsLabel() {
        synchronizationVisibilityofElement(driver, bundlePluginsLabel);
        return bundlePluginsLabel;
    }

    public WebElement getBundlePluginNames() {
        synchronizationVisibilityofElement(driver, bundlePluginNames);
        return bundlePluginNames;
    }

    public WebElement getInvalidBundleUploadError() {
        synchronizationVisibilityofElement(driver, invalidBundleUploadError);
        return invalidBundleUploadError;
    }

    public WebElement getBundleManagementPluginVersionCount() {
        synchronizationVisibilityofElement(driver, bundleManagementPluginVersionCount);
        return bundleManagementPluginVersionCount;
    }

    public List<WebElement> getBundleVersionsPluginCount() {
        synchronizationVisibilityofElementsList(driver, bundleVersionPluginCount);
        return bundleVersionPluginCount;
    }

    public WebElement getPluginManagementtButton() {
        synchronizationVisibilityofElement(driver, pluginManagementButton);
        return pluginManagementButton;
    }

    public WebElement getBundleVersion(String bundle) {
        return driver.findElement(By.xpath("//table[@class='table table-hover']//following::td[contains(.,'" + bundle + "')]"));
    }

    public WebElement getDownloadContentButton() {
        synchronizationVisibilityofElement(driver, DownloadContentButton);
        return DownloadContentButton;
    }

    public WebElement getSubmitButton() {
        synchronizationVisibilityofElement(driver, submitButton);
        return submitButton;
    }

    public WebElement geterrorCloseButton() {
        synchronizationVisibilityofElement(driver, errorCloseButton);
        return errorCloseButton;
    }

    public List<WebElement> getBundlePluginsList(String bundleName) {
        return driver.findElements(By.xpath("//span[starts-with(text(),'" + bundleName + "')]/following::div[1]//child::div[@class='asg-bundle-item']/span[1]"));
    }

    public boolean elementListPresent(String elementName, List<Map<String, String>> valuesList) {
        boolean flag = false;
        String key = null;
        List<String> Expected_Value = new ArrayList<>();
        List<String> Actual_Value = new ArrayList<>();
        switch (elementName.toLowerCase()) {
            case "bundle list":
                for (Map<String, String> valuesMap : valuesList) {
                    for (Map.Entry<String, String> values : valuesMap.entrySet()) {
                        Expected_Value.add(values.getValue());
                        key = values.getKey();
                    }
                }
                List<WebElement> pluginList = getBundlePluginsList(key);
                Iterator<WebElement> i = pluginList.iterator();
                while (i.hasNext()) {
                    WebElement row = i.next();
                    Actual_Value.add(row.getText());
                }
                break;
        }
        //Compares if the Expected List is present in actual List
        int acutalSize = Actual_Value.size();
        int expectedSize = Expected_Value.size();
        if (expectedSize <= acutalSize) {
            for (int i = 0; i < expectedSize; i++) {
                Iterator<String> e = Expected_Value.iterator();
                if (traverseListContainsString(Actual_Value, Expected_Value.get(i)) == false) {
                    flag = false;
                    break;
                }
                flag = true;
                e.next();
            }

        }
        return flag;
    }


    public void bundleManagerDetails(List<Map<String, String>> hm) {
        String inputval = null;
        String inputKey = null;
        for (Map<String, String> value : hm) {
            for (Map.Entry<String, String> values : value.entrySet()) {
                inputKey = values.getKey();
                inputval = values.getValue();
                sleepForSec(4000);
                switch (inputKey){
                    case "SubBundleName":
                       clickonWebElementwithJavaScript(driver, new BundleManager(driver).getSubBundleName(inputval));
                        break;
                    case"BundleVersion":
                        clickonWebElementwithJavaScript(driver, new BundleManager(driver).getBundleVersion());
                         break;
                    case"pluginName":
                       clickonWebElementwithJavaScript(driver, new BundleManager(driver).getPluginNameDetails(inputval));
                        break;
                    case"Description":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                    case"Supported extensions":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                    case"Supported content":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                    case"Supported technologies":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                    case"IDA Node restrictions:":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                    case"Type of analyzer":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                    case "itemtypes":
                        Assert.assertTrue(new BundleManager(driver).getPluginInformation(inputval).isDisplayed());
                        break;
                }

            }
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).bundleDetailsVersionCloseButton());
            clickonWebElementwithJavaScript(driver, new BundleManager(driver).bundleDetailsCloseButton());

            }
        }


}




