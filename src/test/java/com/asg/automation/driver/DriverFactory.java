package com.asg.automation.driver;

import com.asg.automation.wrapper.UIWrapper;
import com.asg.utils.driverconfig.DriverInit;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;
import org.openqa.selenium.remote.DesiredCapabilities;

/**
 * Created by muthuraja.r on 04-17-2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class DriverFactory extends UIWrapper {
    protected static WebDriver driver;
    private DesiredCapabilities caps;

    protected synchronized WebDriver getDriver() {
        try {
            /* Verifying execution type is local */
            if (propLoader.prop.getProperty("executionType").equalsIgnoreCase("local")) {
                if (driver == null && (propLoader.prop.getProperty("browserName").equalsIgnoreCase("chrome"))) {
                    driver = new DriverInit().initializeLocalDriver(propLoader.prop.getProperty("browserName"));
                    windowMaximize(driver);
                } else if (driver == null && (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox"))) {
                    System.setProperty("webdriver.gecko.driver", "src/test/resources/geckodriver.exe");
                    driver = new FirefoxDriver(new DriverInit().getDCFirefoxWithAcceptCertificate());
                } else if (driver == null && (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge"))) {
                    System.setProperty("webdriver.edge.driver", "src/test/resources/MicrosoftWebDriver.exe");
                    driver = new DriverInit().initializeLocalDriver(propLoader.prop.getProperty("browserName"));
                }
            }
            /* Verifying execution type is Remote on Docker*/
            else if (propLoader.prop.getProperty("executionType").equalsIgnoreCase("remoteExecutioninDocker")
                    && (driver == null)) {
                driver = new DriverInit().initalizeRemoteDriver(propLoader.prop.getProperty("browserName"),
                        propLoader.prop.getProperty("hubHostName"),
                        propLoader.prop.getProperty("portName"));
            }

            /* Verifying execution type is Remote on specific Node*/
            else if (propLoader.prop.getProperty("executionType").equalsIgnoreCase("remoteExecutiononNode")
                    && (driver == null)) {
                driver = new DriverInit().initializeDockerRemoteDriver(propLoader.prop.getProperty("browserName"),
                        propLoader.prop.getProperty("hubHostName"),
                        propLoader.prop.getProperty("portName"));
            }
            /* Verifying execution type is SauceLab */
            else if (propLoader.prop.getProperty("executionType").equalsIgnoreCase("saucelab_desktop")
                    && (driver == null)) {
                driver = new DriverInit().initalizeSauceLabDesktopBrowser(propLoader.prop.getProperty("browserName"),
                        propLoader.prop.getProperty("platformType"));
            }
            windowMaximize(driver);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return driver;
    }

    /* quit driver*/
    protected void destroyDriver() {
        try {
//            driver.close();
            driver.quit();
            driver = null;
        } catch (Exception e) {

        }
    }


}

