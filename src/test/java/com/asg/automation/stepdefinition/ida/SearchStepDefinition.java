package com.asg.automation.stepdefinition.ida;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageactions.idc.QuickStartActions;
import com.asg.automation.pageactions.idc.SearchDefinitionActions;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.JsonRead;
import com.asg.automation.utils.LoggerUtil;
import cucumber.api.PendingException;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

/**
 * Created by Nirmal.Balasundaram on 8/7/2017.
 */
public class SearchStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;

    @Before("@webtest")
    public void beforeScenario() {

        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            propertyLoader();
            jsonRead = new JsonRead();
        }catch (Exception e){
            Assert.fail("Driver not initialized"+e.getMessage());
        }
    }

    @After("@webtest")
    public void close() throws Exception {

        destroyDriver();
    }

    @When("^user enters the search text \"([^\"]*)\" and clicks on search$")
    public void user_enters_the_search_text_and_clicks_on_search(String searchtext) throws Throwable {
        try {
            waitForAngularLoad(driver);
            new QuickStartActions(driver).SearchText(searchtext);
            waitForAngularLoad(driver);
            sleepForSec(1000);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search text :" + searchtext + " has been entered");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
        }
    }

    @Then("^user should be able to see the \"([^\"]*)\" button$")
    public void userShouldBeAbleToSeeTheButton(String serachResultPageMenuName) {
        try {
            if(propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")){
                sleepForSec(1000);
                Assert.assertTrue(isElementPresent(new SubjectArea(driver).returnSearchPageTopMenyButtons(serachResultPageMenuName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search Menu button :" + serachResultPageMenuName + " is visible in search result page");
            }else {
                Assert.assertTrue(isElementPresent(new SubjectArea(driver).returnSearchPageTopMenyButtons(serachResultPageMenuName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search Menu button :" + serachResultPageMenuName + " is visible in search result page");
                takeScreenShot("Search Menu button :" + serachResultPageMenuName + " is visible in search result page", driver);
            }
        } catch (Exception e) {
            takeScreenShot("search menu button : " + serachResultPageMenuName + "is not available", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search menu button : " + serachResultPageMenuName + "is not available" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "search menu button : " + serachResultPageMenuName + "is not available");
        }
    }

    @And("^user clicks on \"([^\"]*)\" button from search result page$")
    public void userClicksOnButtonFromSearchResultPage(String menuButtonName) {
        try {
            clickOn(new SubjectArea(driver).returnSearchPageTopMenyButtons(menuButtonName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), menuButtonName + " has been clicked");
        } catch (Exception e) {
            takeScreenShot("search menu button : " + menuButtonName + "is not available", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("search menu button : " + menuButtonName + "is not available" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "search menu button : " + menuButtonName + " is not available");
        }
    }

    @Then("^user should be seeing My Searches label$")
    public void userShouldBeSeeingMySearchesLabel() {
        try {
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).returnQuicklinkLabel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "List of Quick link label is visible");
            Assert.assertTrue(isElementPresent(new SubjectArea(driver).returnQuicklinkNameLabel()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quick link Name label is visible");
            takeScreenShot("Quick link Name label is visible", driver);
        } catch (Exception e) {
            takeScreenShot("My Quicklinks label is not available", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("My Quicklinks label is not available" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "My Quicklinks label is not available");
        }
    }

    @Then("^user should be seeing the quick link \"([^\"]*)\"$")
    public void userShouldBeSeeingTheQuickLink(String linkName) {
        try {
            Assert.assertTrue(isElementPresent(new DashBoardPage(driver).returnLinkElement(linkName)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link : " + linkName + "is found");
            sleepForSec(3000);
            takeScreenShot("Link : " + linkName + "is found", driver);
        } catch (Exception e) {
            takeScreenShot("Quicklink" + linkName + " is not available", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink" + linkName + " is not available   " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink" + linkName + " is not available");
        }
    }

    @And("^user cliks on quick link \"([^\"]*)\"$")
    public void userCliksOnQuickLink(String linkName) {
        try {
            clickOn(new DashBoardPage(driver).returnLinkElement(linkName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Link : " + linkName + "is Clicked");
        } catch (Exception e) {
            takeScreenShot("Quicklink" + linkName + " is not clicked", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail("Quicklink" + linkName + " is not clicked   " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink" + linkName + " is not cliked");
        }
    }

    @And("^user verifies the items count is \"([^\"]*)\" \"([^\"]*)\" in search view$")
    public void userVerifiesTheItemsCountIs(String arg0, String itemCount) throws Throwable {
        try {
            new SearchDefinitionActions(driver).genericVerifyElementPresent(arg0,itemCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), arg0 + " is checked on item count button");
        } catch (Exception e) {
            takeScreenShot("Error in verifying the item count", driver);
            Assert.fail("Error in verifying the item count");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }
}
