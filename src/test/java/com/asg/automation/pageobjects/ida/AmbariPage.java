package com.asg.automation.pageobjects.ida;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

/**
 * Created by venkata.mulugu on 7/13/2017.
 */
public class AmbariPage extends UIWrapper {

    private WebDriver driver;

    @FindBy(xpath = "//input[@class='ember-view ember-text-field login-user-name span4']")
    private WebElement ambariUname;

    @FindBy(xpath = "//input[@class='ember-view ember-text-field login-user-password span4']")
    private WebElement ambariPword;

    @FindBy(xpath = "//button[contains(.,'Sign in')]")
    private WebElement ambariLoginButton;

    @FindBy(xpath = "(//span[contains(text(),'Cataloger')])[2]")
    private WebElement catalogerButton;

    @FindBy(xpath = "//a[contains(.,' Configs')]")
    private WebElement catalogerConfigsTab;

    @FindBy(xpath = "//a[contains(.,'Catalogers Settings')]")
    private WebElement catalogerCatalogersSettingsTab;

    @FindBy(xpath = "//span[@class='bootstrap-switch-handle-on bootstrap-switch-success']")
    private WebElement enableQueryYesButton;

    @FindBy(xpath = " //span[@class='bootstrap-switch-handle-off bootstrap-switch-default']")
    private WebElement enableQueryNoButton;

    @FindBy(xpath = "//button[contains(.,'Save')]")
    private WebElement catalogerSaveButton;

    @FindBy(xpath = " //textarea[@placeholder='What did you change?']")
    private WebElement changeMessageTextBox;

    @FindBy(xpath = "//button[contains(.,'Restart')]")
    private WebElement catalogerRestartButton;

    @FindBy(xpath = "//a[contains(.,'Restart All Affected')]")
    private WebElement catalogerRestartAllEffectedButton;

    @FindBy(xpath = "//button[contains(.,'Confirm Restart All')]")
    private WebElement confirmRestartAllButton;

    @FindBy(xpath = "//div[@id='service-info']/div[1]//div[@class='host-progress-num'][contains(.,'100')]")
    private WebElement restartProgressButton;

    @FindBy(xpath = "//div[contains(.,'Save Configuration Changes')]//div[@class='modal-footer']//button[@class='btn btn-success']")
    private WebElement saveConfigurationChangesOkButton;

    @FindBy(xpath = "//div[@class='modal-footer']//button[@class='btn btn-success']")
    private WebElement saveConfigurationSaveButton;

    @FindBy(xpath = "//i[@class='icon-th']")
    private WebElement servicesIconDropDown;

    @FindBy(xpath = "//p[contains(.,'Hive View')]")
    private WebElement hiveViewIconButton;

    @FindBy(xpath = "//button[contains(.,'OK')]")
    private WebElement restartSuccessOkButton;

    @FindBy(id = "code-mirror")
    private WebElement hiveQueryEditor;

    @FindBy(xpath = "//button[contains(.,'Execute')]")
    private WebElement executeQueryButton;

    @FindBy(xpath = "//div[@class='bootstrap-switch-container']/..")
    private  WebElement ToogleButton;

    @FindBy(xpath = "//*[@id='ember756']/div/div[6]/div[1]/div/div/div/div[5]/div/pre")
    private WebElement Queryspace;

    @FindBy(xpath = "//iframe[@seamless='seamless']")
    private WebElement frame;

    @FindBy(xpath = "//div[@class='query-results-tools']/following::table/thead/tr")
    private WebElement queryResultsTable;

    @FindBy(xpath = "//strong[contains(text(),'Query Process Results (Status: SUCCEEDED)')]")
    private WebElement successFlag;

    public AmbariPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized Login page");
    }
    public WebElement getQueryResultsTable() {
        return queryResultsTable;
    }
    public WebElement gettoogleButton() {
        return ToogleButton;
    }

    public WebElement getframe() {
        return frame;
    }

    public WebElement getQueryspace() {
        return Queryspace;
    }

    public WebElement getambariUname() {
        return ambariUname;
    }

    public WebElement getambariPword() {
        return ambariPword;
    }

    public void loginToAmbariPage(String username, String password) {
        //highlightElement(driver,usernameField);
        enterText(ambariUname, username);
        //highlightElement(driver,passwordField);
        enterText(ambariPword, password);
        //highlightElement(driver,loginButton);
        clickOn(ambariLoginButton);

    }
    public WebElement getSuccessFlag() {
        return successFlag;
    }

    public void Click_catalogerButton() {

        synchronizationVisibilityofElement(driver, catalogerButton);
        clickonWebElementwithJavaScript(driver,catalogerButton);
    }

    public void Click_HiveViewer() {

        synchronizationVisibilityofElement(driver, servicesIconDropDown);
        clickonWebElementwithJavaScript(driver,servicesIconDropDown);
    }
    public void Click_catalogerConfigsTab() {

        synchronizationVisibilityofElement(driver, catalogerConfigsTab);
        clickonWebElementwithJavaScript(driver,catalogerConfigsTab);
    }

    public void Click_catalogerCatalogersSettingsTab() {

        synchronizationVisibilityofElement(driver, catalogerCatalogersSettingsTab);
        clickonWebElementwithJavaScript(driver,catalogerCatalogersSettingsTab);
    }


    public WebElement return_enableQueryYesButton() {
        return enableQueryYesButton;

    }

    public WebElement return_enableQueryNoButton() {
        return enableQueryNoButton;
    }

    public void Click_catalogerSaveButton() {

        synchronizationVisibilityofElement(driver, catalogerSaveButton);
        clickonWebElementwithJavaScript(driver,catalogerSaveButton);
    }

    public WebElement return_changeMessageTextBox() {
        synchronizationVisibilityofElement(driver, changeMessageTextBox);
        return changeMessageTextBox;
    }

    public void Click_catalogerRestartButton() {

        synchronizationVisibilityofElement(driver, catalogerRestartButton);
        clickonWebElementwithJavaScript(driver,catalogerRestartButton);
    }

    public void Click_confirmRestartAllButton() {

        synchronizationVisibilityofElement(driver, confirmRestartAllButton);
        clickonWebElementwithJavaScript(driver,confirmRestartAllButton);
    }

    public WebElement return_restartProgressButton() {
        synchronizationVisibilityofElement(driver, restartProgressButton);
        return restartProgressButton;
    }

    public void Click_saveConfigurationChangesOkButton() {

        synchronizationVisibilityofElement(driver, saveConfigurationChangesOkButton);
        clickonWebElementwithJavaScript(driver,saveConfigurationChangesOkButton);
    }

    public void Click_saveConfigurationSaveButton() {

        synchronizationVisibilityofElement(driver, saveConfigurationSaveButton);
        clickonWebElementwithJavaScript(driver,saveConfigurationSaveButton);
    }

    public WebElement return_catalogerSaveButton() {
        return catalogerSaveButton;
    }

    public void Click_catalogerRestartAllEffectedButton() {

        synchronizationVisibilityofElement(driver, catalogerRestartAllEffectedButton);
        clickonWebElementwithJavaScript(driver,catalogerRestartAllEffectedButton);
    }

    public void Click_hiveViewIconButton() {

        synchronizationVisibilityofElement(driver, hiveViewIconButton);
        clickonWebElementwithJavaScript(driver,hiveViewIconButton);
    }

    public WebElement return_servicesIconDropDown() {
        return servicesIconDropDown;
    }

    public void Click_restartSuccessOkButton() {

        synchronizationVisibilityofElement(driver, restartSuccessOkButton);
        clickonWebElementwithJavaScript(driver,restartSuccessOkButton);
    }

    public void enterText_hiveQueryEditor(String text){
        enterText(hiveQueryEditor,text);
    }

    public void Click_executeQueryButton(){
        synchronizationVisibilityofElement(driver, executeQueryButton);
        clickonWebElementwithJavaScript(driver,executeQueryButton);
    }

    public WebElement return_hiveQueryEditor(){
        synchronizationVisibilityofElement(driver, hiveQueryEditor);
        return hiveQueryEditor;
    }


}
