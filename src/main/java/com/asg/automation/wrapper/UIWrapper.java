package com.asg.automation.wrapper;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.PropertyLoader;
import org.apache.commons.io.FileUtils;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.*;
import org.testng.Assert;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.*;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;

import static com.asg.automation.utils.Constant.*;

/**
 * Created by muthuraja.ramakrishn on 4/9/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class UIWrapper {
    public static final long TIME_LIMIT = 5000;
    //public WebDriver driver;
    public String temp;
    protected PropertyLoader propLoader;
    protected LoggerUtil loggerUtil;
    public int tempValue;
    public List<WebElement> tempList;

    public UIWrapper() {
        propertyLoader();
    }

    /**
     * Function Name	: LaunchBrowser with user provided URL
     * Description		: To Launch Browser either Chrome, Firefox, etc.,
     */
    public void launchBrowser(WebDriver driver, String URL) {
        try {
            driver.get(URL);
            if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("firefox")) {
                sleepForSec(WAIT_MILLSECS);
            }
            else  if (propLoader.prop.getProperty("browserName").equalsIgnoreCase("edge")) {
                sleepForSec(WAIT_MILLSECS_EDGE);
            }
            else {
                implicit_wait(driver, WAIT_SECS);
            }

        } catch (Exception e) {
            //UILog.error("Problem in loading browser");
        }
    }

    /**
     * Function Name	: windowMaximize
     * Description		: To Maximize window
     */
    public void windowMaximize(WebDriver driver) {
        driver.manage().window().maximize();
    }


    /**
     * Function Name	: takeScreenShot
     * Description		: To take screenshot of the current webpage
     */
    public void takeScreenShot(String className, WebDriver driver) {
        File screenshotFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
        try {
            FileUtils.copyFile(screenshotFile, new File(SCREENSHOTS + className + ".jpg"));
            //log code
        } catch (IOException e) {
            System.out.println("Screenshot cannot be taken, IOException is thrown" + e.getMessage());
        }
    }

    /**
     * Method Name : sleepForSec
     *
     * @param msecs : Number of seconds to be wait
     */
    public void sleepForSec(long msecs) {
        try {
            Thread.sleep(msecs);
        } catch (InterruptedException e) {
            //LoggerUtil.Log.info("Exception raised on Thread.Sleep method");
        }
    }


    /**
     * Method Name : Close Browser
     * Description : To close browser
     */
    public void closeBrowser(WebDriver driver) {
        try {
            driver.quit();
            //LoggerUtil.Log.info("Launched Browser closed successfully");
        } catch (Exception e) {
            // LoggerUtil.Log.info("Browser cant be closed, exception throws");
        }
    }

    /**
     * Method Name : Comparing String value
     * Description : To compare two different string value
     */
    public boolean verifyEquals(String expected, String actual) {
        try {
            Assert.assertEquals(expected.toLowerCase(), actual.toLowerCase());
            return true;
        } catch (Exception e) {
            return false;

        }
    }


    public boolean verifyEquals(long expected, long actual) {
        try {
            Assert.assertEquals(expected, actual);
            return true;
        } catch (Exception e) {
            return false;

        }
    }

    /**
     * Method Name : Comparing integer value
     * Description : To compare two different integer value
     */
    public boolean verifyEquals(int expected, int actual) {
        try {
            Assert.assertEquals(expected, actual);
            return true;
        } catch (Exception e) {
            return false;

        }
    }

    /**
     * Method Name : Comparing String contains
     * Description : To compare actual string contains in expected string
     */
    public boolean verifyContains(String expected, String actual) {
        try {
            return expected.toLowerCase().contains(actual.toLowerCase());
        } catch (Error err) {
            throw new Error("Verification Error: expected:<" + expected + "> but was:<" + actual + ">");
        }

    }

    /**
     * Method Name : verifyNotEquals
     * Description : To compare not equal of two different string value
     */
    public void verifyNotEquals(String expected, String actual) throws Exception {
        if (expected.equals(actual)) {
            throw new Exception("Verification Error:<" + expected + "> <" + actual + ">");
        }

    }

    /**
     * Method Name : dropdownOptionsCheck
     * Description : To check if an option is present in the dropdown or not
     */
    public void dropdownOptionsCheck(String text, WebElement element) {
        boolean optionexist = false;
        Select dropdownlist = new Select(element);
        List<WebElement> options = dropdownlist.getOptions();
        for (WebElement opt : options) {
            if (opt.getText().equals(text)) {
                optionexist = true;
                break;
            }
        }
        try {
            Assert.assertTrue(optionexist);
        } catch (Exception e) {
            //LoggerUtil.Log.info(text + "is not found in the dropdown");
        }
    }

    /**
     * Method Name : dropdonwOptionslist
     * Description : To get all the options in the dropdown
     */
    public List<WebElement> dropdonwOptionslist(WebElement element) {
        List<WebElement> allOptions;
        Select dropdownlist = new Select(element);
        allOptions = dropdownlist.getOptions();
        return allOptions;
    }

    /**
     * Method Name : DropdownSelectbyText
     * Description : To select dropdown by Text
     */
    public void dropdownSelectbyText(String text, WebElement element) {
        Select dropdownlist = new Select(element);
        dropdownlist.selectByVisibleText(text);
    }

    /**
     * Method Name : DropdownSelectbyText
     * Description : To select dropdown by Text
     */
    public void dropdownSelectbyIndex(int indexNo, WebElement element) {
            Select dropdownlist = new Select(element);
            dropdownlist.selectByIndex(indexNo);
    }


    /**
     * Method Name : DropdownSelectbyText
     * Description : To select dropdown by Text
     */
    public boolean isElementPresent(WebElement element) {
        try {
            element.isDisplayed();

        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    public boolean isElementNotPresent(WebDriver driver,By by) {
        try {
            driver.findElement(by);

        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    public boolean isNotElementPresent(WebElement element) {
        try {
            Assert.assertFalse(element.isDisplayed());

        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    public boolean isElementEnabled(WebElement element) {
        if (element.isEnabled())
            return true;
        else
            return false;
    }

    public boolean isElementSelected(WebElement element) {
        try {
            element.isSelected();

        } catch (Exception ex) {
            return false;
        }
        return true;
    }

    /**
     * Method Name : isElementsListPresent
     * Description : It verifies the list of elements present
     */
    public boolean isElementsListPresent(List<WebElement> list) {

        if (list.isEmpty())
            return false;
        else
            return true;
    }

    /**
     * Method Name : acceptAlert
     * Description : To accept alert
     */
    public void acceptAlert(WebDriver driver) throws Exception {
        try {
            driver.switchTo().alert().accept();
        } catch (Exception e) {
            throw new Exception("No Alert Present");
        }
    }

    /**
     * Method Name : cancelAlert
     * Description : To cancel alert
     */
    public void cancelAlert(WebDriver driver) throws Exception {

        try {

            driver.switchTo().alert().dismiss();
        } catch (Exception e) {
            throw new Exception("No Alert Present");
        }
    }

    /**
     * Method Name : getAlertText
     * Description : To get alert Text
     */
    public String getAlertText(WebDriver driver) throws Exception {
        String text;
        try {

            text = driver.switchTo().alert().getText();
        } catch (Exception e) {
            throw new Exception("No Alert Present");
        }
        return text;
    }


    /**
     * Method Name : clickOn
     * Description : To Click on either button or checkbox for clicking action
     */
    public void clickOn(WebElement element) {
        try {
            element.click();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param element
     * @return
     */
    public boolean clickOnElement(WebElement element) {
        boolean status = false;
        try {
            element.click();
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
            return status;
        }
        return status;
    }

    public void clickOn(WebDriver driver, WebElement element) {
        try {
            driver.manage().timeouts().implicitlyWait(0, TimeUnit.SECONDS);
            waitUntilAngularReady(driver);
            clickOn(element);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean clickOnWithJavascript(WebDriver driver, WebElement element) {
        boolean status = false;
        try {
            JavascriptExecutor executor = (JavascriptExecutor) driver;
            executor.executeScript("arguments[0].click();", element);
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
            return status;
        }
        return status;
    }

    public void enterText(WebElement element, String text) {
        element.clear();
        element.sendKeys(text);
    }

    public void actionClickWithKeys(WebDriver driver, WebElement element) {
        Actions click = new Actions(driver);
        click.click(element).build().perform();
    }

    /**
     * Method Name : enterTextWithoutClear
     * Description : To enter text without clearing the field
     */

    public void enterTextWithoutClear(WebElement element, String text) {
        element.sendKeys(text);
    }

    /**
     * Method Name : implicitWait
     * Description : To Wait till loads all DOM
     */

    public void implicit_wait(WebDriver driver, int time) {
        driver.manage().timeouts().implicitlyWait(time, TimeUnit.SECONDS);
    }

    /**
     * Method Name : implicitWait
     * Description : To Wait Till page load
     */

    public void waitForPageLoads(WebDriver driver, int timeinSeconds) {
        Wait<WebDriver> wait = new WebDriverWait(driver, timeinSeconds);
        wait.until(new Function<WebDriver, Boolean>() {
            public Boolean apply(WebDriver driver) {
                System.out.println("Current Window State       : "
                        + String.valueOf(((JavascriptExecutor) driver).executeScript("return document.readyState")));
                return String
                        .valueOf(((JavascriptExecutor) driver).executeScript("return document.readyState"))
                        .equals("complete");
            }
        });
    }


    /**
     * Method Name : getValue
     * Description : To get attribute value of element
     */
    public String getValue(WebElement element) {
        return element.getAttribute("value");
    }

    /**
     * Method Name : pressKey
     * Description : To press shortcut Key
     */
    public void pressKey(WebElement element, Keys key) {
        element.sendKeys(key);
    }

    public void textClear(WebElement element) {
        element.clear();
    }


    /**
     * Method Name : verifyTrue
     * Description : To Verify condition meet true
     */
    public void verifyTrue(boolean actual) {
        Assert.assertTrue(actual);
    }

    /**
     * Method Name : verifyTrue
     * Description : To Verify condition meet false
     */
    public void verifyFalse(boolean actual) {
        try {
            Assert.assertTrue(!actual);
        } catch (Error err) {
            throw new Error("Verification Error: expected:<false> but was:<true>");
        }
    }

    /**
     * Method Name : verifyTrue
     * Description : To refresh the page
     */
    public void refresh(WebDriver driver) {
        driver.navigate().refresh();
    }

    /**
     * Method Name : verifyTrue
     * Description : Wait till visible of element
     */

    public void synchronizationVisibilityofElement(WebDriver driver, WebElement element) {

        new WebDriverWait(driver, 5).until(ExpectedConditions.visibilityOf(element));

    }
    public WebElement synchronizationVisibilityofTheElement(WebDriver driver, WebElement element) {

        WebElement webElement = new WebDriverWait(driver, 5).until(ExpectedConditions.visibilityOf(element));
        return webElement;
    }

    public void synchronizationVisibilityofElement(WebDriver driver, WebElement element, int timeInSeconds) {

        new WebDriverWait(driver, timeInSeconds).until(ExpectedConditions.visibilityOf(element));

    }

    public void synchronizationofElementTobeClickable(WebDriver driver, WebElement element) {

        new WebDriverWait(driver, 5).until(ExpectedConditions.elementToBeClickable(element));

    }

    public void synchronizationVisibilityofAlert(WebDriver driver) {

        new WebDriverWait(driver, 5).until(ExpectedConditions.alertIsPresent());

    }

    public void synchronizationVisibilityofElementsList(WebDriver driver, List<WebElement> list) {
        int count = 0;
        do {
            try {
                new WebDriverWait(driver, 5).until(ExpectedConditions.visibilityOfAllElements(list));
                break;
            } catch (Exception e) {
                sleepForSec(1000);
                count++;
            }
        } while (count >= 5);


    }

    //Wait for Angular Load
    public static void waitForAngularLoad(WebDriver webDriver) {
        WebDriver jsWaitDriver = webDriver;

        WebDriverWait wait = new WebDriverWait(jsWaitDriver,10);
            //Get Angular is Ready
            ExpectedCondition<Boolean> expectation = driver -> ((JavascriptExecutor) driver).executeAsyncScript(
                    "var callback = arguments[arguments.length - 1];" +
                            "if (document.readyState !== 'complete') {" +
                            "  callback('document not ready');" +
                            "} else {" +
                            "  try {" +
                            "    var testabilities = window.getAllAngularTestabilities();" +
                            "    var count = testabilities.length;" +
                            "    var decrement = function() {" +
                            "      count--;" +
                            "      if (count === 0) {" +
                            "        callback('complete');" +
                            "      }" +
                            "    };" +
                            "    testabilities.forEach(function(testability) {" +
                            "      testability.whenStable(decrement);" +
                            "    });" +
                            "  } catch (err) {" +
                            "    callback(err.message);" +
                            "  }" +
                            "}"
            ).toString().equals("complete");

            try {
                wait.until(expectation);
            } catch (Exception e) {
                new Exception("Timeout waiting for Page Load Request to complete.");
            }
    }

    //Wait Until JS Ready
    public static void waitUntilJSReady(WebDriver driver) {
        WebDriver jsWaitDriver = driver;

        WebDriverWait wait = new WebDriverWait(jsWaitDriver,10);
        JavascriptExecutor jsExec = (JavascriptExecutor) jsWaitDriver;

        //Wait for Javascript to load
        ExpectedCondition<Boolean> jsLoad = driver1 -> ((JavascriptExecutor) jsWaitDriver)
                .executeScript("return document.readyState").toString().equals("complete");
        try {
            wait.until(jsLoad);
        } catch (Exception e) {
            new Exception("Timeout waiting for Page Load Request to complete.");
        }
}

    public static void waitUntilAngularReady(WebDriver driver) {
        WebDriver jsWaitDriver = driver;
        JavascriptExecutor jsExec = (JavascriptExecutor) jsWaitDriver;

        //First check that ANGULAR is defined on the page. If it is, then wait ANGULAR
        Boolean angularUnDefined = (Boolean) jsExec.executeScript("return window.ng === undefined");
        if (!angularUnDefined) {

            //Wait JS Load
            waitUntilJSReady(driver);

            //Wait Angular Load
            waitForAngularLoad(driver);

        }  else {
            System.out.println("Angular is not defined on this site!");
        }
    }

    public void highlightElement(WebDriver driver, WebElement element) throws InterruptedException {
        JavascriptExecutor js = (JavascriptExecutor) driver;

        for (int i = 0; i < 1; i++) {
            js.executeScript("arguments[0].setAttribute('style', arguments[1]);", element, "color: green; border: 5px solid green;");
            Thread.sleep(3000);
            js.executeScript("arguments[0].setAttribute('style', arguments[1]);", element, "");
        }
    }

    public String getElementText(WebElement webElement) {
        String text;
        text = webElement.getText().trim();
        return text;
    }

    public void propertyLoader() {
        propLoader = new PropertyLoader();
        propLoader.loadProperty();
    }

    /**
     * Method Name : checkDateTimeFormat
     * Description : This scenario verified whether the date and time are in required format
     */

    public Boolean checkDateTimeFormat(String text, String dateFormat)
    { String datePattern = dateFormat;
    SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
    try { Date date = sdf.parse(text);
    }
    catch (ParseException e)
    { e.printStackTrace();
    return false;
    } return true;
    }


    /**
     * Method Name : traverseListContainsElement
     * Description : Traverse list and returns true if element is present
     */

    public Boolean traverseListContainsElement(List<WebElement> list, String expected) {
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().toLowerCase().equalsIgnoreCase(expected);
            if (bool) {
                flag = 1;
                break;
            }
        }

        return flag == 1;

    }

    /**
     * Method Name : traverseListContainsElementAndClick
     * Description : Traverse list and clicks element is present
     */

    public void traverseListContainsElementAndClick(WebDriver driver,List<WebElement> list, String expected) throws Exception {
        try {
            WebElement element = traverseListContainsElementReturnsElement(list, expected);
            moveToElement(driver,element);
            clickOn(driver,element);
            waitForPageLoads(driver,30);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No " + list.get(0) + " found");
            throw new Exception();
        }
    }

    /**
     * Method Name : traverseListContainsElementAndClick_SwitchTab
     * Description : Traverse list and clicks element is present
     */

    public void traverseListContainsElementAndClick_SwitchTab(WebDriver driver,List<WebElement> list, String expected) throws Exception {
        try {
            WebElement element = traverseListContainsElementReturnsElement(list, expected);
            scrollToWebElement(driver,element);
            clickAndSwitchTab(driver,element,Duration.ofSeconds(1000),"No");
            waitForPageLoads(driver,30);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No " + list.get(0) + " found");
            throw new Exception();
        }
    }

    /**
     * Method Name : traverseListContainsString
     * Description : Traverse list and returns true if String is present
     */

    public Boolean traverseListContainsString(List<String> list, String expected) {
        int flag = 0;
        for (String string : list) {
            Boolean bool = string.toLowerCase().equalsIgnoreCase(expected);
            if (bool) {
                flag = 1;
                break;
            }
        }

        return flag == 1;

    }

    /**
     * Method Name : traverseListContainsElementReturnsElement
     * Description : Traverse list and if element is present returns the element
     */

    public WebElement traverseListContainsElementReturnsElement(List<WebElement> list, String expected) {
        WebElement element = null;
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().toLowerCase().trim().equalsIgnoreCase(expected);
            if (bool) {
                flag = 1;
                element = ele;
                break;
            }
        }

        if (flag == 1) {
            return element;
        } else return null;

    }

    /**
     * Method Name : traverseListContainsElementReturnsElement
     * Description : Traverse list and if element is present returns the element
     */

    public WebElement traverseListContainsReturnsElement(List<WebElement> list, String expected) {
        WebElement element = null;
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().toLowerCase().trim().contains(expected);
            if (bool) {
                flag = 1;
                element = ele;
                break;
            }
        }

        if (flag == 1) {
            return element;
        } else return null;

    }

    /**
     * Method Name : traverseListContainsElementText
     * Description : Traverse list and returns if element contains the expected text
     */

    public Boolean traverseListContainsElementText(List<WebElement> list, String expected) {
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().toLowerCase().equalsIgnoreCase(expected.toLowerCase());
            if (bool) {
                flag = 1;
                break;
            }
        }

        return flag == 1;

    }


    public Boolean traverseListContainsUpperCaseText(List<WebElement> list) {
        boolean flag = false;
        for (WebElement ele : list) {
            Boolean bool = (ele.getText().trim()).equals(ele.getText().trim().toUpperCase());
            if (bool) {
                flag = true;
                break;
            }
        }

        return flag ;

    }

    /**
     * Method Name : traverseListContainsText
     * Description : Traverse list and check if all the element contains particular text
     */

    public Boolean traverseListContainsText(List<WebElement> list, String expected) {
        boolean flag = false;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().toLowerCase().contains(expected.toLowerCase());

                if (bool) {
                    flag = true;
                    break;
                }
            }

        return flag;

    }

    /**
     * Method Name : storeTemporaryText
     * Description : Storing run time information into temp variable
     */
    public void storeTemporaryText(String text) {
        temp = text;
    }

    /**
     * Method Name : getTemporaryText
     * Description : Getting run time information from temp variable
     */
    public String getTemporaryText() {
        return temp;
    }

    /**
     * Method Name : fluentWait
     * Description : This fluent wait to hanld synchronizaiton issues
     */
    public void fluentWait(WebDriver driver, long MaximumTime, long PollingTime) {
        Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
                .withTimeout(MaximumTime, TimeUnit.SECONDS)
                .pollingEvery(PollingTime, TimeUnit.SECONDS)
                .ignoring(java.util.NoSuchElementException.class);
    }

    public void actionClick(WebDriver driver, WebElement element) {

        Actions builder = new Actions(driver);
        builder.moveToElement(element).click(element).build().perform();

    }

    /**
     * This method to do key press events
     * @param driver
     * @param keysName
     */
    public void keyPressEvent(WebDriver driver,Keys keysName) {

        Actions action = new Actions(driver);
        action.sendKeys(keysName).build().perform();


    }

    /**
     * Method Name : checkDateAndTimeFormat
     * Description : This scenario  compares the date and time format
     */
    public Boolean checkDateAndTimeFormat(String text) {
        String dateFormat = "DD/MM/YYYY, HH:mm";
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        try {
            Date date = sdf.parse(text);
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     * Created by Saranya P Sankar
     * Method Name : switchToChildWindow
     * Description : To Switch to another window
     */

    public void switchToChildWindow(WebDriver driver) {
        Set<String> winHandles = driver.getWindowHandles();
        for (String winHandle : winHandles)
            driver.switchTo().window(winHandle);
    }

    /**
     * Created by Sid
     * Method Name : switchToChildWindow
     * Description : To Switch to another window
     */

    public void switchToWindowIndex(WebDriver driver, int index) {

        Set<String> windowHandles = driver.getWindowHandles();
        List<String> windowStrings = new ArrayList<>(windowHandles);
        String reqWindow = windowStrings.get(index);
        driver.switchTo().window(driver.getWindowHandle()).close();
        driver.switchTo().window(reqWindow);

    }

    public void clickAndSwitchTab(WebDriver driver, WebElement eleToClick, Duration timeTowaitForWindowtoopen, String RetainWindow) {
        Set<String> priorHandles = driver.getWindowHandles();
        String previousWindow = driver.getWindowHandle();
        waitForAngularLoad(driver);
        // To click the element before switching the focus into new window.
        try {
            if (eleToClick.isDisplayed()) {
                scrollToWebElementParamFalse(driver,eleToClick);
                eleToClick.click();
                waitForAngularLoad(driver);
            } else {
                Assert.fail("Element not displayed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            takeScreenShot(this.getClass().getName(), driver);
            Assert.fail("Element not clicked");
        }
        /*// Switching the driver focus into new window after click operation
        try {
            new WebDriverWait(driver, timeTowaitForWindowtoopen.getSeconds()).until(d -> {
                Set<String> newHandles = d.getWindowHandles();
                if (RetainWindow.equalsIgnoreCase("No")) {
                    driver.switchTo().window(previousWindow).close();
                    LoggerUtil.logLoader_info(this.getClass().getName(), "The previous window is closed");
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getName(), "The corresponding window has to be retained");
                }
                if (newHandles.size() > priorHandles.size()) {
                    for (String newHandle : newHandles) {
                        if (!priorHandles.contains(newHandle)) {
                            d.switchTo().window(newHandle);
                            waitForAngularLoad(driver);
                            return true;
                        }
                    }
                    return false;
                } else {
                    return false;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }*/
    }
    /**
     * Created by Divya Bharathi H
     * Method Name : verifyNewTabIsOpened
     * Description : To verify whether new tab is opened
     */

    public boolean verifyNewTabIsOpened(WebDriver driver) {
        boolean flag = false;
        Set<String> allWindowHandles = driver.getWindowHandles();
        ArrayList<String> tabs = new ArrayList<String>(allWindowHandles);
        if (tabs.size() > 1)
            flag = true;
        return flag;

    }

    public String getAttributeValue(WebElement element, String value) {
        return element.getAttribute(value);
    }

    public void mouseDragAndDrop(WebDriver driver, WebElement dragValue, WebElement dropValue) {
        Actions builder = new Actions(driver);
        builder.dragAndDrop(dragValue, dropValue).build().perform();


    }

    public void doubleClick(WebDriver driver, WebElement element) {
        Actions builder = new Actions(driver);
        builder.doubleClick(element).build().perform();
    }

    /**
     * Created by Mohan Kumar
     * Method Name : clickonWebElementwithJavaScript
     * Description : To click on a Element with JavaScript Executor
     */

    public void clickonWebElementwithJavaScript(WebDriver driver, WebElement element) {
        JavascriptExecutor executor = (JavascriptExecutor) driver;
        executor.executeScript("arguments[0].click();", element);
    }

    /**
     * Created by Mohan Kumar
     * Method Name : dragAndDropElementUsingJavaScript
     * Description : To drag a Element with JavaScript Executor
     */

    public void enterTextWithJavaScript(WebDriver driver, String value, WebElement element) {
        JavascriptExecutor executor = (JavascriptExecutor) driver;
        executor.executeScript("arguments[1].value = arguments[0]; ", value, element);
    }

    public void backSpaceTest(WebElement element) {
        element.sendKeys("\u0008");
    }



    public void dragAndDropElementUsingJavaScript(WebDriver driver, WebElement toBeDragged, WebElement toBeDropped) {

        String xto = Integer.toString(toBeDropped.getLocation().x);
        String yto = Integer.toString(toBeDropped.getLocation().y);
        ((JavascriptExecutor) driver).executeScript("function simulate(f,c,d,e){var b,a=null;for(b in eventMatchers)if(eventMatchers[b].test(c)){a=b;break}if(!a)return!1;document.createEvent?(b=document.createEvent(a),a==\"HTMLEvents\"?b.initEvent(c,!0,!0):b.initMouseEvent(c,!0,!0,document.defaultView,0,d,e,d,e,!1,!1,!1,!1,0,null),f.dispatchEvent(b)):(a=document.createEventObject(),a.detail=0,a.screenX=d,a.screenY=e,a.clientX=d,a.clientY=e,a.ctrlKey=!1,a.altKey=!1,a.shiftKey=!1,a.metaKey=!1,a.button=1,f.fireEvent(\"on\"+c,a));return!0} var eventMatchers={HTMLEvents:/^(?:load|unload|abort|error|select|change|submit|reset|focus|blur|resize|scroll)$/,MouseEvents:/^(?:click|dblclick|mouse(?:down|up|over|move|out))$/}; " +
                        "simulate(arguments[0],\"mousedown\",0,0); simulate(arguments[0],\"mousemove\",arguments[1],arguments[2]); simulate(arguments[0],\"mouseup\",arguments[1],arguments[2]); ",
                toBeDragged, xto, yto);
    }

    public void dragAndDrop(WebDriver driver,WebElement dragElement,WebElement dropElement){
        Actions actions=new Actions(driver);
        actions.clickAndHold(dragElement).moveToElement(dropElement).release(dropElement).build().perform();
    }

    public void clearTextWithJavaScript(WebDriver driver, WebElement element) {
        JavascriptExecutor executor = (JavascriptExecutor) driver;
        executor.executeScript("arguments[1].value = arguments[0]; ", " ", element);
    }

    public void moveToElement(WebDriver driver, WebElement element) {
        Actions action = new Actions(driver);
        action.moveToElement(element).build().perform();
    }

    public void performESCbutton(WebDriver driver) {
        Actions action = new Actions(driver);
        action.sendKeys(Keys.ESCAPE).build().perform();
    }

    public void moveToElementUsingJavaScript(WebDriver driver, WebElement element) {
        String mouseOverScript = "if(document.createEvent){var evObj = document.createEvent('MouseEvents');evObj.initEvent('mouseover', true, false); arguments[0].dispatchEvent(evObj);} else if(document.createEventObject) { arguments[0].fireEvent('onmouseover');}";
            ((JavascriptExecutor) driver).executeScript(mouseOverScript, element);

}

    public void moveToElement(WebDriver driver, WebElement element, String query) {
        Actions action = new Actions(driver);
        action.moveToElement(element).click(element).sendKeys(query).build().perform();
    }

    public void moveToElementWithActions(WebDriver driver, WebElement element) {
        Actions builder = new Actions(driver);
        builder.moveToElement(element).perform();
        builder.click(element);
    }

    public void moveToElementUsingAction(WebDriver driver, WebElement element) {
        Actions action = new Actions(driver);
        action.moveToElement(element).build();
    }


    public void clickEventonField(WebDriver driver, WebElement element) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).click().build().perform();
    }

    /**
     * Created by: Muthu
     * Purpose: To handle text field which dom has regular expression, also, enter keys using actions
     *
     * @param driver
     * @param element dom name or id or xpath or css for the field
     * @param value   value to be entered in text field
     */
    public void actionSendKeys(WebDriver driver, WebElement element, String value) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).keyDown(element, Keys.SHIFT).sendKeys(value).keyUp(element, Keys.SHIFT).build().perform();
    }

    /**
     * To enter text in a field using action class without clearing functions
     * @param driver
     * @param element
     * @param value
     */
    public void enterUsingActions(WebDriver driver,WebElement element,String value){
        Actions actions = new Actions(driver);
        actions.sendKeys(element,value).perform();
        //actions.moveToElement(element).contextClick(element).sendKeys(value).build().perform();
    }

     /* Created by: Saranya
     * Purpose: To handle text field which dom has regular expression, also, enter values after clicking inside the TextBox
     *
     * @param driver
     * @param element dom name or id or xpath or css for the field
     * @param value   value to be entered in text field
     */

    public void sendKeysAction(WebDriver driver, WebElement element, String value) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).click().sendKeys(value).build().perform();
    }



    public void keysOperationUsingActions(WebDriver driver, WebElement element, Keys keys) {
        Actions actions = new Actions(driver);
        actions.moveToElement(element).sendKeys(keys).build().perform();
    }




    /***
     *
     * @ created By Sunil Kumar Ketha
     * @ purpose : To Switch to a frame using the Web element
     */
    public void switchToFrame(WebDriver driver, WebElement element) {
        driver.switchTo().frame(element);
    }

    public void clickAndHold(WebDriver driver, WebElement element) {
        Actions builder = new Actions(driver);
        builder.clickAndHold(element).build().perform();
    }

    public void navigateToUrl(WebDriver driver, String url) {
        driver.navigate().to(url);
    }

    public void navigateToPreviousPage(WebDriver driver) {
        driver.navigate().back();
    }

    public String toClickWebTableElement(WebDriver driver, String tableXPath, String XpathofTR, String matchingString) {
        String searchContent = null;
        WebElement table = driver.findElement(By.xpath(tableXPath));
        int RowLength = table.findElements(By.tagName("tr")).size();
        for (int i = 1; i < RowLength; i++) {
            WebElement ColumnCount = driver.findElement(By.xpath(XpathofTR + "[" + i + "]"));
            List<WebElement> tableData = ColumnCount.findElements(By.tagName("td"));
            for (WebElement webElement : tableData) {
                if (webElement.getText().equalsIgnoreCase(matchingString)) {
                    searchContent = webElement.getText();
                    webElement.click();
                    break;
                }
            }
        }
        return searchContent;
    }

    /**
     * Enable to scroll true or false, searching element by scrolling
     *
     * @param driver
     * @param element
     * @param status
     */
    public void scrolltoElement(WebDriver driver, WebElement element, boolean status) {
        if (status) {
            JavascriptExecutor je = (JavascriptExecutor) driver;
            je.executeScript("arguments[0].scrollIntoView(true);", element);
        }
    }

    public boolean waitandFindElement(WebDriver driver, WebElement element, int noofAttempts, boolean scrollRequired) {
        boolean elementVisible = false;
        int i = 1;
        try {
            while (i <= noofAttempts) {
                try {
                    elementVisible = element.isDisplayed();
                    if (elementVisible) {
                        if (scrollRequired) {
                            scrolltoElement(driver, element, scrollRequired);
                        }
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element " + element + " is found");
                        break;
                    } else {
                        i++;
                        sleepForSec(1000);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Trying " + i + "  attempts");
                    }
                    if (i == noofAttempts) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No " + element + " found");
                    }
                } catch (StaleElementReferenceException SE) {
                    i++;
                }

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No " + element + " found");
        }
        return elementVisible;
    }


    /**
     * Method Name : storeTemporaryValue
     * Description : Storing run time information into temp value
     */
    public void storeTemporaryValue(int value) {
        tempValue = value;
    }

    /**
     * Method Name : getTemporaryValue
     * Description : Getting run time information from temp variable
     */
    public int getTemporaryValue() {
        return tempValue;
    }

    /**
     * Method Name : storeTemporaryList
     * Description : Storing run time List of elements  into temp list
     */
    public void storeTemporaryList(List<WebElement> list) {
        for(WebElement ele:list)
        {
            tempList.add(ele);
        }
    }

    /**
     * Method Name : getTemporaryList
     * Description : Getting run time List of elements from temp list
     */
    public List<WebElement> getTemporaryList() {
        return tempList;
    }

    /**
     * Method Name : traverseListRemovesElements
     * Description : Traverse list and removes another list of elements
     */


    public List<String> convertWebElementListIntoStringList(List<WebElement> list) {
        List<String> strings = new ArrayList<String>();
        for (WebElement e : list) {
            strings.add(e.getText().trim());
        }
        return strings;
    }
    public void dragAndDropwithActions(WebDriver driver, WebElement from, WebElement to) {
        Actions builder = new Actions(driver);
         builder.dragAndDropBy(from,to.getLocation().getX(),to.getLocation().getY()).build().perform();
    }

    /**
     * Method Name : EnterKeyPressEvent
     * Description : Enter key will be pressed using this method
     */

    public void pressEnterKey(WebDriver driver){
        try {
            Robot robot = new Robot();
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
        }catch (Exception e){
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    /**
     * Method Name : scrollToWebElement
     * Description : This method will make a browser to scroll till the mentioned element is found
     */
    public void scrollToWebElement (WebDriver driver, WebElement element){
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
    }


    /**
     * Method Name : scrollToWebElementParamFalse
     * Description : This method will make a browser to scroll till the mentioned element is found
     */
    public void scrollToWebElementParamFalse (WebDriver driver, WebElement element){
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(false);", element);
    }

    public Boolean horizantalScrollBarCheck(WebDriver driver){
        JavascriptExecutor javascript = (JavascriptExecutor) driver;
        Boolean horzscrollStatus = (Boolean) javascript.executeScript("return document.documentElement.scrollWidth>document.documentElement.clientWidth;");
    return horzscrollStatus;
    }


    /**
     * Method Name : traverseListContainsElementReturnsElement
     * Description : Traverse list and if element is present returns the element
     */
    public WebElement traverseListContainsElementTextReturnsElement(List<WebElement> list, String expected) {
        WebElement element = null;
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().equalsIgnoreCase(expected);
           if (bool) {
                flag = 1;
                element = ele;
                break;
            }
        }

        if (flag == 1) {
            return element;
        } else return null;

    }

    public WebElement traverseListContainsElementTextReturnsElementText(List<WebElement> list, String expected) {
        WebElement element = null;
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().contains(expected);
            if (bool) {
                flag = 1;
                element = ele;
                break;
            }
        }

        if (flag == 1) {
            return element;
        } else return null;

    }

    /**
     * Method Name : trversePaginationAndClickOnDynamicItem
     * Description : Traverse through pages, finds and clicks on element
     */
    public void trversePaginationAndClickOnDynamicItem(WebDriver driver,List<WebElement> itemList,String itemName,WebElement paginationNextButton) {
        while (true) {
            if (traverseListContainsElementText(itemList,itemName)) {
                WebElement element = traverseListContainsElementTextReturnsElement(itemList, itemName);
                waitandFindElement(driver, element, 3, false);
                clickOn(element);
                break;
            } else {
                if(paginationNextButton.isDisplayed()) {
                    clickOn(paginationNextButton);
                    waitForAngularLoad(driver);
                    sleepForSec(2000);
                }

            }

        }
    }


    public void trversePaginationAndClickOnDynamicItemContainsText(WebDriver driver,List<WebElement> itemList,String itemName,WebElement paginationNextButton) {
        while (true) {
            if (traverseListContainsElementText(itemList,itemName)) {
                WebElement element = traverseListContainsElementTextReturnsElementText(itemList, itemName);
                waitandFindElement(driver, element, 3, false);
                clickOn(element);
                break;
            } else {
                if(paginationNextButton.isDisplayed()) {
                    clickOn(paginationNextButton);
                    waitForAngularLoad(driver);
                    sleepForSec(2000);
                }

            }

        }
    }

    /**
     * Method Name : trversePaginationAndReturnStringList
     * Description : Traverse list from second page and store the text from second pagination
     */
    public List<String> trversePaginationAndReturnStringList(WebDriver driver, List<WebElement> itemList, WebElement paginationNextButton) {
        List<String> gettext = new ArrayList<>();
        try {
            while (true) {
                if (isElementPresent(paginationNextButton) == true) {
                    clickOn(paginationNextButton);
                    waitForAngularLoad(driver);
                    for (WebElement element : itemList) {
                        gettext.add(element.getText());
                    }
                    sleepForSec(2000);
                    continue;
                } else {
                    if (isElementPresent(paginationNextButton) == false) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
        }
        return gettext;
    }

    //Method to get Element text with attribute
    public boolean traverseListContainsElementTextViaAttribute(List<WebElement> list, String expected,String attributeValue) {
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = getAttributeValue(ele,attributeValue).trim().contains(expected);
            if (bool) {
                flag = 1;
                break;
            }
        }

        return flag == 1;

    }

    /**
     * Method Name : ReturnStringListofFirstandTraversedpage
     * Description : Store the Text from first page and traverse to the next to store the text from second
     */
    public List<String> ReturnStringListofFirstandTraversedpage(WebDriver driver, List<WebElement> itemList, WebElement paginationNextButton) {
        List<String> gettext = new ArrayList<>();
        try {
            while (true) {
                for (WebElement element : itemList) {
                    gettext.add(element.getText());
                }
                if (isElementPresent(paginationNextButton) == true) {
                    clickOn(paginationNextButton);
                    waitForAngularLoad(driver);
                    for (WebElement element : itemList) {
                        gettext.add(element.getText());
                    }
                    sleepForSec(2000);
                    continue;
                } else {
                    if (isElementPresent(paginationNextButton) == false) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
        }
        return gettext;
    }

    /**
     * Method Name : ReturnWebelementListofFirstandTraversedpage
     * Description : Resturn the Webelements list from all the pagination place
     */
    public List<WebElement> ReturnWebelementListofFirstandTraversedpage(WebDriver driver, List<WebElement> itemList, WebElement paginationNextButton) {
        List<WebElement> getelement = new ArrayList<>();
        try {
            while (true) {
                for (WebElement element : itemList) {
                    getelement.add(element);
                }
                if (isElementPresent(paginationNextButton) == true) {
                    clickOn(paginationNextButton);
                    waitForAngularLoad(driver);
                    for (WebElement element : itemList) {
                        getelement.add(element);
                    }
                    sleepForSec(2000);
                    continue;
                } else {
                    if (isElementPresent(paginationNextButton) == false) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
        }
        return getelement;
    }

    /**
     *
     * @param element webElement which needs to be scrolled
     * @param action whether to zoom In or zoom Out
     * @param noOfScrols no of In Scroll or Out Scroll
     */
    public void scrollUsingSendKeys(WebElement element, String action, String noOfScrols) {
        switch (action) {
            case "zoomIn":
                for (int i = 0; i <Integer.parseInt(noOfScrols); i++) {
                    element.sendKeys(Keys.chord(Keys.CONTROL, Keys.ADD));
                    sleepForSec(1000);
                }
                break;
            case "zoomOut":
                for (int i = 0; i < Integer.parseInt(noOfScrols); i++) {
                    element.sendKeys(Keys.chord(Keys.CONTROL, Keys.SUBTRACT));
                    sleepForSec(1000);
                    break;
                }
        }
    }

    /**
     *
     * @param driver
     * @param element webelement which position needs to be changed
     * @param width x coordinates of the object
     * @param height y coordinates of the object
     */
    public void moveToCoordinates(WebDriver driver,WebElement element,String width,String height){
        Actions act=new Actions(driver);
        act.clickAndHold(element).moveByOffset(Integer.parseInt(width),Integer.parseInt(height)).release(element).build().perform();
    }

    /**
     *
     * @param driver
     * @param element webelement which position needs to be changed
     * @param width x coordinates of the object
     * @param height y coordinates of the object
     */
    public void moveToCoordinatesAndClick(WebDriver driver,WebElement element,String width,String height){
        Actions act=new Actions(driver);
        act.moveToElement(element).moveByOffset(Integer.parseInt(width),Integer.parseInt(height)).click(element).perform();
    }


    public void trversePaginationAndClickOnItemThatIsDynamic(WebDriver driver,List<WebElement> itemList,String itemName,WebElement paginationNextButton) {
        while (true) {
            if (traverseListContainsDynamicElementText(itemList,itemName)) {
                WebElement element = traverseListContainsDynamicElementTextReturnsElement(itemList, itemName);
                waitandFindElement(driver, element, 3, false);
                clickOn(element);
                break;
            } else {
                if (paginationNextButton.isDisplayed()) {
                    waitForAngularLoad(driver);
                    clickOn(paginationNextButton);
                    waitForAngularLoad(driver);
                    sleepForSec(2000);
                }

            }

        }
    }

    public Boolean traverseListContainsDynamicElementText(List<WebElement> list, String expected) {
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().toLowerCase().contains(expected.toLowerCase());
            if (bool) {
                flag = 1;
                break;
            }
        }

        return flag == 1;

    }

    public WebElement traverseListContainsDynamicElementTextReturnsElement(List<WebElement> list, String expected) {
        WebElement element = null;
        int flag = 0;
        for (WebElement ele : list) {
            Boolean bool = ele.getText().trim().contains(expected);
            if (bool) {
                flag = 1;
                element = ele;
                break;
            }
        }

        if (flag == 1) {
            return element;
        } else return null;

    }

//    public boolean scrolListContainsElementAndClick(WebDriver driver,List<WebElement> list, String expected) throws Exception {
//        boolean flag = false;
//        try {
//
//            WebElement element = traverseListContainsDynamicElementTextReturnsElement(list, expected);
//            if(element != null) {
//                flag=true;
//                moveToElement(driver, element);
//                clickOn(driver, element);
//                waitForAngularLoad(driver);
//            }
//        } catch (Exception e) {
//            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No " + list.get(0) + " found");
//        }
//        return flag;
//    }




    public boolean scrolListContainsElementAndClick(WebDriver driver,List<WebElement> list, String expected) throws Exception {
        boolean flag = false;
        try {
            waitForAngularLoad(driver);
            WebElement element = traverseListContainsElementReturnsElement(list, expected);
            if (element.getText().equals(expected)) {
                if (clickOnWithJavascript(driver, traverseListContainsElementReturnsElement(list, expected)) == true) {
                    flag = true;
                    waitForAngularLoad(driver);
                } else {
                    return flag;
                }

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No " + list.get(0) + " found");
        }
        return flag;
    }

    public boolean scrolListContainsDynamicElementAndClick(WebDriver driver,List<WebElement> list, String expected) throws Exception {
        boolean flag = false;
        try {

            WebElement element = traverseListContainsDynamicElementTextReturnsElement(list, expected);
            if (element != null) {
                flag = true;
                scrolltoElement(driver, element, true);
                if (clickOnElement(traverseListContainsDynamicElementTextReturnsElement(list, expected)) == true) {
                    flag = true;
                    waitForAngularLoad(driver);
                } else {
                    return flag;
                }
                waitForAngularLoad(driver);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No " + list.get(0) + " found");
        }
        return flag;
    }

    public void scrollDownUsingJS(WebDriver driver, List<WebElement> value, int scrollValue){
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'start' });", value.get(value.size()-scrollValue));    }

    //Returns Webelement list value to String List
    public List<String> getStringListFromElementsList(List<WebElement> values){
        List<String> list = new ArrayList<>();
        for(WebElement ele: values){
            list.add(ele.getText());
        }
        return list;
    }

    //Returns Webelement list value to String List
    public List<String> getLowerCaseTextListFromElementsList(List<WebElement> values){
        List<String> list = new ArrayList<>();
        for(WebElement ele: values){
            list.add(ele.getText().toLowerCase());
        }
        return list;
    }
    /**
     * Method Name : Verifying properties
     * Description : To verify whether the given element is read only or not
     */
    public boolean verifyElementProperties(WebElement element, String property) {
        try {
            Assert.assertTrue(getAttributeValue(element, property).equals("true"));
            return true;
        } catch (Exception e) {
            return false;

        }
    }

    //Method to move slider
    public static void setSliderValue(WebDriver driver, WebElement slider, String value)
    {
        int sliderH = slider.getSize().height;
        Actions action = new Actions(driver);
        action.moveToElement(slider, Integer.parseInt(value), sliderH / 2).click().build().perform();
    }

    //Method for handling Tab Focus scenarios

    public static void recursiveKeyPress(WebDriver driver, Integer num, String value) {
        try {
            Actions action = new Actions(driver);

            if (value.equalsIgnoreCase("TAB")) {
                for (int i = 1; i <= num; i++) {
                    action.sendKeys(Keys.valueOf("TAB")).build().perform();
            }
        }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Tab action not performed");
        }

    }
    //find if the key value is presence
    public static boolean containsKeyinMap(final Map<String, String> map, String value){
        boolean flag = false;
        Iterator<String> keySetIterator = map.keySet().iterator();
        while(keySetIterator.hasNext()){
            String key = keySetIterator.next();
            if(key.equalsIgnoreCase(value)){
                flag=true;
            }
        }
        return flag;
    }


    /**
     *
     * @param element - element to scroll
     * @param key - keys that need to be pressed
     * @param numberOfClicks - number of times key to be pressed
     */
    public void scrollUsingKeys(WebElement element, String key, int numberOfClicks) {
        for (int i = 0; i < numberOfClicks; i++) {
            element.sendKeys(Keys.valueOf(key));
            sleepForSec(1000);
        }
    }
}
