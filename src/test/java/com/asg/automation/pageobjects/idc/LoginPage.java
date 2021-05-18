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

/**
 * Created by muthuraja.ramakrishn on 4/7/2017.
 * This page holds login object repository
 */
@SuppressWarnings("DefaultFileTemplate")
public class LoginPage extends UIWrapper {

    private WebDriver driver;

    @FindBy(xpath = "//span[contains(.,'Sign into Data Discovery')]")
    private WebElement loginTitle;

    @FindBy(xpath = "//p[contains(.,'Intelligent Data Catalog Documentation')]")
    private WebElement documentTitle;

    @FindBy(xpath = "//p[contains(.,'Learn more about ASG')]")
    private WebElement LearnMoreElement;

    @FindBy(xpath = "//div[@class='content']//app-login-footer")
    private WebElement copyRightsElement;

    @FindBy(xpath = "//p[contains(.,'Quickly discover, curate and understand enterprise data using intelligent self-service tools.')]")
    private WebElement loginContent;

    public WebElement getUsernameField() {
        return usernameField;
    }

    @FindBy(id = "username")
    private WebElement usernameField;

    @FindBy(xpath = "//label[contains(.,'Username')]")
    private WebElement usernameLabel;

    @FindBy(xpath="//input[@type='password']")
    private WebElement passwordField;

    @FindBy(xpath = "//label[contains(.,'Password')]")
    private WebElement passwordLabel;

    @FindBy(xpath = "//button[@type='submit']")
    private WebElement loginButton;

    @FindBy(xpath = "//span[contains(.,'Data Steward')]")
    private WebElement VerifyDataAdmin;

    @FindBy(xpath = "//span[contains(.,'System Administrator')]")
    private WebElement VerifySystemAdmin;

    @FindBy(xpath = "//a[@class[contains(.,'navbar-brand p-0 d-inline-flex align-items-center')]]/img")
    private WebElement expectedLogo;

    @FindBy(xpath = "//a[contains(.,'INTELLIGENT DATA CATALOG')]")
    private WebElement asgLogoAndIDCName;

    @FindBy(xpath = "//p[contains(.,'ASG - Newsroom')]")
    private WebElement asgNewsLoginPage;

    @FindBy(xpath = "//p[contains(.,'Intelligent Data Catalog Documentation')]")
    private WebElement asgDocumentationLoginPage;

    @FindBy(xpath = "//b[contains(.,'TestGuestUser')]")
    private WebElement verifyInformationUser;

    @FindBy(xpath = "//h2[contains(.,'ASG News Room')]")
    private WebElement asgNewsRoom;

    public WebElement getAsgNewsRoom() {
        synchronizationVisibilityofElement(driver, asgNewsRoom, 10);
        return asgNewsRoom;
    }

    @FindBy(xpath = "//h1[contains(.,'ASG-Intelligent Data Catalog Online Documentation')]")
    private WebElement OnlineDocPage;

    @FindBy(xpath = "//span[@class='sign-in-error field-right']")
    private WebElement loginFailed;

    @FindBy(xpath = "//div[contains(.,'Unknown username or incorrect password')]")
    private WebElement loginFailedErrorMessage;

    @FindBy(css = "button[class='btn authorize unlocked']")
    private WebElement swaggerAuthorizeButton;


    @FindBy(css = "input[name='username']")
    private WebElement swaggerUsername;

    @FindBy(css = "input[name='password']")
    private WebElement swaggerPassword;

    @FindBy(css = "button[class='download-url-button button']")
    private WebElement swaggerExploreButton;

    @FindBy(xpath = "//a[contains(.,'Sign in as Different User')]")
    private WebElement signInAsADifferentUserLink;

    @FindBy(xpath = "//h3[contains(.,'Welcome back TestService!')]")
    private WebElement welcomeMessage;

    @FindBy(xpath = "//button/a[contains(.,'Sign Out')]")
    private WebElement profileLogoutButton;

    @FindBy(xpath = "//div/img[@class='profile-icon img-circle hide-default-toggle dropdown-toggle']")
    private WebElement settingsButton;

    public LoginPage(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Intialized Login page");
    }

    public WebElement returnasgLogoAndIDCNameElement() {

        synchronizationVisibilityofElement(driver, asgLogoAndIDCName);
        return asgLogoAndIDCName;
    }

    public WebElement returnLoginTitleElement() {

        synchronizationVisibilityofElement(driver, loginTitle);
        return loginTitle;
    }

    public WebElement returnDocumentElement() {

        synchronizationVisibilityofElement(driver, documentTitle);
        return documentTitle;
    }

    public WebElement returnLearMoreElement() {
        synchronizationVisibilityofElement(driver, LearnMoreElement);
        return LearnMoreElement;
    }

    public WebElement returncopyRightsElement() {
        synchronizationVisibilityofElement(driver, copyRightsElement);
        return copyRightsElement;
    }

    public WebElement returnloginContent() {
        synchronizationVisibilityofElement(driver, loginContent);
        return loginContent;
    }


    public WebElement returnUsernameElement() {

        synchronizationVisibilityofElement(driver, usernameField);
        return usernameField;
    }

    public WebElement returnUsernameLabelElement() {

        synchronizationVisibilityofElement(driver, usernameLabel);
        return usernameLabel;
    }

    public WebElement returnPasswordElement() {

        synchronizationVisibilityofElement(driver, passwordField);
        return passwordField;
    }

    public WebElement returnPasswordLabelElement() {

        synchronizationVisibilityofElement(driver, passwordLabel);
        return passwordLabel;
    }

    public WebElement returnLoginButton() {

        synchronizationVisibilityofElement(driver, loginButton);
        return loginButton;
    }

    public WebElement returnVerifyDataAdmin() {

        synchronizationVisibilityofElement(driver, VerifyDataAdmin);
        return VerifyDataAdmin;
    }

    public WebElement returnVerifySystemAdmin() {

        synchronizationVisibilityofElement(driver, VerifySystemAdmin);
        return VerifySystemAdmin;
    }

    public WebElement returnExpectedLogo() {

        synchronizationVisibilityofElement(driver, expectedLogo);
        return expectedLogo;
    }


    /*public void loginToIDCPage(String username, String password) {
        //highlightElement(driver,usernameField);
        enterText(usernameField, username);
        //highlightElement(driver,passwordField);
        enterText(passwordField, password);
        //highlightElement(driver,loginButton);
        clickOn(loginButton);
    }*/

    public void loginToIDCSwaggerPage(String username, String password) {
        enterText(swaggerUsername, username);
        //highlightElement(driver,passwordField);
        enterText(swaggerPassword, password);
        //highlightElement(driver,loginButton);
        clickOn(swaggerExploreButton);

    }

    public void Click_asgNewsLoginPage() {
        scrollToWebElement(driver, asgNewsLoginPage);
        clickOn(asgNewsLoginPage);
    }

    public void Click_asgDocumentation_LoginPage() {
        synchronizationVisibilityofElement(driver, asgDocumentationLoginPage);
        clickOn(asgDocumentationLoginPage);
    }

    public WebElement returnverifyInformationUser() {

        synchronizationVisibilityofElement(driver, verifyInformationUser);
        return verifyInformationUser;
    }

    public WebElement returnOnlineDocPage() {
        synchronizationVisibilityofElement(driver, OnlineDocPage);
        return OnlineDocPage;
    }

    public WebElement returnloginFailed() {
        synchronizationVisibilityofElement(driver, loginFailed);
        return loginFailed;
    }

    public WebElement returnloginFailedErrorMessage() {
        synchronizationVisibilityofElement(driver, loginFailedErrorMessage);
        return loginFailedErrorMessage;
    }

    public WebElement getswaggerUsername() {
        synchronizationVisibilityofElement(driver, swaggerUsername);
        return swaggerUsername;
    }

    public WebElement getswaggerPassword() {
        synchronizationVisibilityofElement(driver, swaggerPassword);
        return swaggerPassword;
    }

    public WebElement getswaggerExploreButton() {
        synchronizationVisibilityofElement(driver, swaggerExploreButton);
        return swaggerExploreButton;
    }

    public WebElement getSwaggerAuthorizeButton() {
        synchronizationVisibilityofElement(driver, swaggerAuthorizeButton);
        return swaggerAuthorizeButton;
    }

    public WebElement getsignInAsADifferentUserLink() {
        synchronizationVisibilityofElement(driver, signInAsADifferentUserLink);
        return signInAsADifferentUserLink;
    }

    public WebElement getWelcomeMessage() {
        return welcomeMessage;
    }

    public void Click_profileLogoutButton() {

        synchronizationVisibilityofElement(driver, profileLogoutButton);
        clickonWebElementwithJavaScript(driver, profileLogoutButton);
    }

    public void Click_settingsButton() {

        synchronizationVisibilityofElement(driver, settingsButton);
        clickonWebElementwithJavaScript(driver, settingsButton);
    }

    public WebElement loginErrorMessage(String errorMessage) {
        return driver.findElement(By.xpath("//span[@class[contains(.,'sign-in-error')]][contains(.,'"+errorMessage+"')]"));
    }

    //=============================================================
    //=======================Page Actions==========================
    //=============================================================

    public void enterActions(String elementType, String text) {
        try {
            switch (elementType) {
                case "Username":
                    enterText(getUsernameField(), text);
                    break;
                case "Password":
                    enterText(returnPasswordElement(), text);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void clickActions(String elementType) {
        try {
            switch (elementType) {
                case "LOGIN":
                    clickOn(returnLoginButton());
                    sleepForSec(1000);
                    break;
                case "signAsADifferentUser":
                    clickOn(getsignInAsADifferentUserLink());
                    break;
                case "Settings button":
                    Click_settingsButton();
                    break;
                //10.3 New UI
                case "LogOut button":
                    Click_profileLogoutButton();
                    sleepForSec(2000);
                    break;
            }
        } catch (Exception | AssertionError e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }
    }

    public void genericVerifyElementPresent(String elementName, String... dynamicItem) {
        try {
            switch (elementName) {
                case "LICENSE-0007: Product license expired":
                    String actualText = getElementText(loginFailed);
                    Assert.assertTrue(actualText.equalsIgnoreCase(elementName));
                    break;
            }
        } catch (Exception e) {
            Assert.fail(e.getMessage() + "Element not found ");
        }

    }

    public boolean visibilityOfSignInAsDifferentUser() {
        boolean status = isElementPresent(signInAsADifferentUserLink);
        return status;
    }
}
