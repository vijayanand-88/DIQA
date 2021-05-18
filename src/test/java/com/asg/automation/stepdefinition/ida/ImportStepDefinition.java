package com.asg.automation.stepdefinition.ida;

import com.asg.automation.driver.DriverFactory;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.SubjectArea;
import com.asg.automation.utils.JsonRead;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;
import org.testng.annotations.Parameters;

/**
 * Created by Nirmal.Balasundaram on 8/7/2017.
 */
public class ImportStepDefinition extends DriverFactory {
    private WebDriver driver;
    private JsonRead jsonRead;

    @Before("@webtest")

    public void beforeScenario() {
        try {
            this.driver = getDriver();
            Assert.assertNotNull(driver);
            jsonRead = new JsonRead();
            propertyLoader();

        } catch (Exception e) {
            Assert.fail("Driver not initialized");
        }
    }

    @After("@webtest")
    public void close() {

        destroyDriver();
    }

    @Given("^verify the imported content \"([^\"]*)\" in IDC UI$")
    public void verify_the_imported_content_in_IDC_UI(String content) {
        try {
            verifyEquals(content, new SubjectArea(driver).returnfirstItemListName().getText());
        } catch (Exception e) {
            takeScreenShot("IDA Import Data Validation of browserdata", driver);
            new DashBoardPage(driver).Click_profileLogoutButton();
            Assert.fail(e.getMessage());
        }
    }
}
