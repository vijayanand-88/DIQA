package com.asg.automation.stepdefinition.idc;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.LoginActions;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.LoginPage;
import com.asg.automation.utils.LoggerUtil;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.concurrent.TimeUnit;

/**
 * Created by muthuraja.ramakrishn on 4/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class IDCLoginStepDefinition extends DriverFactory {
    private WebDriver driver;
    @Before("@webtest")
    public void beforeScenario() throws Exception {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
        } catch (Exception e) {
            Assert.fail("Driver not initialized" + e.getMessage());
        }
    }

    @After("@webtest")
    public void close() throws Exception {
        destroyDriver();

    }


    @Given("^User traverse to \"([^\"]*)\" IDC home page$")
    public void user_traverse_to_IDC_home_page(String URL) {
        // Write code here that turns the    phrase above into concrete actions
        try {
            launchBrowser(driver, URL);
            LoggerUtil.log.info("Browser is launched Successfully");
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
            Assert.assertTrue(driver.getTitle().equalsIgnoreCase("Data Discovery - Login"));
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Failed to launch Browser");
        }

    }


    @Given("^User launch browser and traverse to login page$")
    public void user_launch_browser_and_traverse_to_login_page() {
        // Write code here that turns the phrase above into concrete actions
        try {
            launchBrowser(driver, propLoader.prop.getProperty("qaURL"));
//            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Browser launched successfully");
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
            Assert.assertTrue(driver.getTitle().equalsIgnoreCase("Data Discovery - Login"));

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Fail to Launch Browser");
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Failed to launch Browser");
        }
    }

    @When("^user enter credentials for \"([^\"]*)\" role$")
    public void user_enter_credentials_for_role(String role) {
        // Write code here that turns the phrase above into concrete actions
        try {
            if (role.equalsIgnoreCase("Data Administrator")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaDataAdminUserName"), propLoader.prop.getProperty("qaDataAdminPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as DataAdmin User");
            }else if (role.equalsIgnoreCase("Data Consumer")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaDataConsumerUserName"), propLoader.prop.getProperty("qaDataConsumerPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as DataAdmin User");
            }else if (role.equalsIgnoreCase("Data Custodian")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaDataCustodianUserName"), propLoader.prop.getProperty("qaDataCustodianPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as DataAdmin User");
            }else if (role.equalsIgnoreCase("System Administrator")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaSystemAdminUserName"), propLoader.prop.getProperty("qaSystemAdminPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as System User");
            } else if (role.equalsIgnoreCase("Information User")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaInformationUserUserName"), propLoader.prop.getProperty("qaInformationUserPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as Information User");
            } else if (role.equalsIgnoreCase("System Administrator1")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaSystemAdministrator1"), propLoader.prop.getProperty("qaSystemAdmin1Password"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as System Administrator");
            } else if (role.equalsIgnoreCase("Data Admin")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaDataAdminUserUserName"), propLoader.prop.getProperty("qaDataAdminUserPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as System Administrator");
            }
            else if (role.equalsIgnoreCase("Invalid Administrator")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("qaInvalidUserName"), propLoader.prop.getProperty("qaInvalidPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Invalid Credentials Entered");
            }
            else if (role.equalsIgnoreCase("Becubic User")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("BITBUCKET_USERNAME"), propLoader.prop.getProperty("BITBUCKET_PASSWORD"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as Becubic User");
            }
            else if (role.equalsIgnoreCase("TestUSER")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("TestUsername"), propLoader.prop.getProperty("TestUserPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as System Administrator");
            }
            else if (role.equalsIgnoreCase("UserTest")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty("TestUsername"), propLoader.prop.getProperty("UsertestPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as System Administrator");
            }
            sleepForSec(2000);
        } catch (Exception e) {
            //new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }


    @When("^user enter username as \"([^\"]*)\"$")
    public void user_enter_username_as(String userName) {
        // Write code here that turns the phrase above into concrete actions
        try {
            enterText(new LoginPage(driver).returnUsernameElement(), userName);
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("UserName field is not found");
        }
    }

    @When("^user enter password as \"([^\"]*)\"$")
    public void user_enter_password_as(String passwordField) {
        // Write code here that turns the phrase above into concrete actions
        try {
            enterText(new LoginPage(driver).returnPasswordElement(), passwordField);
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
            clickOn(new LoginPage(driver).returnLoginButton());
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Password field is not found");
        }
    }

    @Then("^login must be success and display dashboard$")
    public void login_must_be_success_and_display_dashboard() {
        // Write code here that turns the phrase above into concrete actions
        try {
            synchronizationVisibilityofElement(driver, new LoginPage(driver).returnVerifyDataAdmin());
            Assert.assertTrue(new LoginPage(driver).returnVerifyDataAdmin().isDisplayed());

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^user should be able logoff the IDC$")
    public void user_should_be_able_logoff_the_IDC() {
        try {
            new DashBoardPage(driver).Click_profileLogoutButton();
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Logoff button is not available" + e.getMessage());
        }
    }

    @When("^User type username as \"([^\"]*)\" and Password as \"([^\"]*)\"$")
    public void user_type_username_as_and_Password_as(String userName, String password) {
        // Write code here that turns the phrase above into concrete actions
        try {
            new LoginActions(driver).loginToIDCPage(userName, password);
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^User type username as \"([^\"]*)\" and Password as \"([^\"]*)\" from property file$")
    public void user_type_username_as_and_Password_from_property_file(String userName, String password) {
        // Write code here that turns the phrase above into concrete actions
        try {
            if (userName.equals("BITBUCKET_USERNAME")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty(userName).toUpperCase(), propLoader.prop.getProperty(password));
            } else if (userName.equals("bitbucket_username")) {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty(userName.toUpperCase()), propLoader.prop.getProperty(password));
            } else {
                new LoginActions(driver).loginToIDCPage(propLoader.prop.getProperty(userName), propLoader.prop.getProperty(password));
            }
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on ASG News link in the Login page$")
    public void user_clicks_on_ASG_News_link_in_the_Login_page() {
        try {
            new LoginPage(driver).Click_asgNewsLoginPage();
            switchToChildWindow(driver);
            scrollToWebElement(driver, new LoginPage(driver).getAsgNewsRoom());
            Assert.assertTrue(isElementPresent(new LoginPage(driver).getAsgNewsRoom()));

        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @When("^User clicks on Documentation link link in the Login page$")
    public void user_clicks_on_Documentation_link_link_in_the_Login_page() {
        try {
            new LoginPage(driver).Click_asgDocumentation_LoginPage();
            switchToChildWindow(driver);
            isElementPresent(new LoginPage(driver).returnOnlineDocPage());

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }


    @Then("^login must be successful for all users$")
    public void login_must_be_successful_for_all_users() {
        // Write code here that turns the phrase above into concrete actions
        try {
            waitForAngularLoad(driver);
            synchronizationVisibilityofElement(driver, new LoginPage(driver).returnExpectedLogo());
            Assert.assertTrue(new LoginPage(driver).returnExpectedLogo().isDisplayed());
            waitForPageLoads(driver, 3);

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^login page should display with all labels$")
    public void login_page_should_display_with_all_labels() {
        try {
            synchronizationVisibilityofElement(driver, new LoginPage(driver).returnasgLogoAndIDCNameElement());
            Assert.assertTrue(new LoginPage(driver).returnasgLogoAndIDCNameElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnLoginTitleElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnUsernameLabelElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnUsernameElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnPasswordLabelElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnPasswordElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnLoginButton().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnDocumentElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnLearMoreElement().isDisplayed());
            Assert.assertTrue(new LoginPage(driver).returnloginContent().isDisplayed());
            takeScreenShot("MLP_524_Verification of all labels in Login page", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_524_Verification of all labels in Login page", driver);

            Assert.fail(e.getMessage());
        }

    }

    @Then("^logout must be success and display login page$")
    public void logout_must_be_success_and_display_login_page() {
        try {
            synchronizationVisibilityofElement(driver, new LoginPage(driver).returnLoginTitleElement());
            Assert.assertTrue(new LoginPage(driver).returnLoginTitleElement().isDisplayed());
            takeScreenShot("MLP_524_Verification of logout", driver);
        } catch (Exception e) {
            takeScreenShot("MLP_524_Verification of logout", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }

    @Then("^login must be success for Information User and display dashboard$")
    public void login_must_be_success_for_Information_User_and_display_dashboard() {
        try {
            synchronizationVisibilityofElement(driver, new LoginPage(driver).returnverifyInformationUser());
            Assert.assertTrue(new LoginPage(driver).returnverifyInformationUser().isDisplayed());

        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }

    }

    @Then("^login must be failed and display error message$")
    public void login_must_be_failed_and_display_error_message() throws Throwable {
        try {
            isElementPresent(new LoginPage(driver).returnloginFailed());
            isElementPresent(new LoginPage(driver).returnloginFailedErrorMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verification of login failed error message");
            takeScreenShot("Verification of login failed error message", driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Verification of login failed error message", driver);
        }

    }

    @Then("^login must be failed and displays error message \"([^\"]*)\"$")
    public void login_must_be_failed_and_displays_error_message(String errorMessage) throws Throwable {
        try {
            isElementPresent(new LoginPage(driver).returnloginFailed());
            isElementPresent(new LoginPage(driver).loginErrorMessage(errorMessage));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verification of login failed error message");
            takeScreenShot("Verification of login failed error message", driver);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
            takeScreenShot("Verification of login failed error message", driver);
        }

    }

    @Then("^the connection of the URL must be secure$")
    public void the_connection_of_the_URL_must_be_secure() throws Throwable {
        try {
            verifyTrue(driver.getCurrentUrl().contains("https"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connection is secured");
            takeScreenShot("Secure Connection", driver);
        } catch (Exception e) {
            takeScreenShot("Connection is not secured", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Given("^User launch browser and traverse to IDC Swagger UI login page$")
    public void user_launch_browser_and_traverse_to_IDC_Swagger_UI_login_page() throws Throwable {
        try {
            launchBrowser(driver, propLoader.prop.getProperty("qaSwaggerURL"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "IDC Swagger UI launched successfully");
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Fail to Launch Browser");
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Failed to launch Browser");
        }
    }

    @When("^user enter credentials for \"([^\"]*)\" role in swagger UI$")
    public void user_enter_credentials_for_role_in_swagger_UI(String role) throws Throwable {
        try {
            clickOn(new LoginPage(driver).getswaggerExploreButton());
            clickOn(new LoginPage(driver).getSwaggerAuthorizeButton());
            if (role.equalsIgnoreCase("System Administrator")) {
                new LoginPage(driver).loginToIDCSwaggerPage(propLoader.prop.getProperty("qaSystemAdminUserName"), propLoader.prop.getProperty("qaSystemAdminPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as SystemAdmin User");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @Given("^User launch browser and traverse to IDC Rabbit MQ login page$")
    public void user_launch_browser_and_traverse_to_IDC_Rabbit_MQ_login_page() throws Throwable {
        try {
            launchBrowser(driver, propLoader.prop.getProperty("qaSwaggerURL"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "IDC Swagger UI launched successfully");
            driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Fail to Launch Browser");
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Failed to launch Browser");
        }
    }

    @When("^user enter credentials for \"([^\"]*)\" role in IDC Rabbit MQ login page$")
    public void user_enter_credentials_for_role_in_IDC_Rabbit_MQ_login_page(String role) throws Throwable {
        try {
            if (role.equalsIgnoreCase("System Administrator")) {
                new LoginPage(driver).loginToIDCSwaggerPage(propLoader.prop.getProperty("qaSystemAdminUserName"), propLoader.prop.getProperty("qaSystemAdminPassword"));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Logged in & as SystemAdmin User");
            }
        } catch (Exception e) {
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @Given("^user clicks on sign in as a different user link$")
    public void user_clicks_on_sign_in_as_a_different_user_link() throws Throwable {
        try {
            waitandFindElement(driver, new LoginPage(driver).getsignInAsADifferentUserLink(), 3, false);
            new LoginActions(driver).signAsADifferentUser();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "sign in as a different user link is clicked");

        } catch (Exception e) {
            takeScreenShot("sign in as a different user link is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @And("^user verifies Welcome back message is not displayed$")
    public void user_verifies_welcome_back_message_is_not_displayed() throws Throwable {
        try {
            if (new LoginPage(driver).getWelcomeMessage().isDisplayed()) {
                Assert.fail("Welcome back message is displayed");
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Welcome back message is not displayed");
            takeScreenShot("Welcome back message is not displayed", driver);
        } catch (NoSuchElementException el) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), el.toString());
        } catch (Exception e) {
            takeScreenShot("Welcome back message is displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail("Welcome back message is displayed" + e.getMessage());
        }

    }

    @And("^user verifies the coyprights as \"([^\"]*)\" on login page$")
    public void user_verifes_the_copyrights(String Copyright) throws Throwable {
        try {

            verifyEquals(Copyright, new LoginPage(driver).returncopyRightsElement().getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Copyrights found");

        } catch (Exception e) {
            takeScreenShot("Copyrights not found", driver);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Copyrights not found");
            Assert.fail("Exception" + e.getMessage());
        }
    }

    @And("^user \"([^\"]*)\" value \"([^\"]*)\" in \"([^\"]*)\"$")
    public void userValueIn(String actionType, String elementValue, String pageName) throws Throwable {
        try {
            sleepForSec(1000);
            new LoginActions(driver).genericActions(actionType, elementValue,pageName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),  elementValue + " is displayed");
        } catch (Exception e) {
            takeScreenShot( elementValue + " is not displayed", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(elementValue + " is not displayed" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(),  elementValue + " is not displayed");
        }
    }

}
