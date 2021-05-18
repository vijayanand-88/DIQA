package com.asg.automation.pageobjects.idc;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.wrapper.UIWrapper;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

/**
 * Created by mohankumar.boopalan on 11/6/2017.
 */
public class WebDataConnectorSimulator extends UIWrapper {

    private WebDriver driver;

    @FindBy(id = "address-input")
    private WebElement connectorURLTextBox;

    @FindBy(id = "interactive-btn")
    private WebElement startInteractivePhaseButton;

    @FindBy (xpath = "//div[@class='results-tables col-md-12']/div[@class='table-section']/div")
    private List<WebElement> tablesListPreview;

    @FindBy (id = "user-name")
    private WebElement simulatorUserName;

    @FindBy (id="password")
    private WebElement simulatorPassword;

    @FindBy (id ="catalog-name")
    private WebElement simulatorCatalogName;

    @FindBy (id="submitButton")
    private WebElement simulatorGetDataButton;

    @FindBy (xpath = "//div[@class='results-tables col-md-12']/div[@class='table-section']/div[1]")
    private WebElement firstTableFromResult;

    @FindBy (xpath = "//div[@class='table-section']/div/h4[contains(.,'Database')]/following-sibling::button[contains(.,'Fetch Table Data')]")
    private WebElement databaseTableFetchDataButton;

    @FindBy (xpath = "//table[@class='table table-striped table-bordered table-condensed']/tbody/tr/td[contains(.,'BigData.Database:::1')]")
    private List<WebElement> databaseTableContents;

    @FindBy (xpath = "//div/h4[contains(.,'Database')]/following::table/tbody/tr[@class='data-row']/td[1]")
    private List<WebElement> databaseList;

    @FindBy (xpath = "//div[@class='table-section']/div/h4[contains(.,'DataSample')]/following-sibling::button[contains(.,'Fetch Table Data')]")
    private WebElement datasampleTableFetchDataButton;

    @FindBy (xpath = "//table[@class='table table-striped table-bordered table-condensed']/tbody/tr/td[contains(.,'BigData.DataSample:::1')]")
    private List<WebElement> datasampleTableContents;

    @FindBy (xpath = "//div/h4[contains(.,'DataSample')]/following::table/tbody/tr[@class='data-row']/td[1]")
    private List<WebElement> datasampleList;

    @FindBy (xpath = "//div[@class='table-section']/div/h4[contains(.,'Directory')]/following-sibling::button[contains(.,'Fetch Table Data')]")
    private WebElement directoryTableFetchDataButton;

    @FindBy (xpath = "//table[@class='table table-striped table-bordered table-condensed']/tbody/tr/td[contains(.,'BigData.Directory:::1')]")
    private List<WebElement> directotyTableContents;

    @FindBy (xpath = "//div/h4[contains(.,'Directory')]/following::table/tbody/tr[@class='data-row']/td[1]")
    private List<WebElement> directoriesList;


    public WebDataConnectorSimulator(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "---Intialized Web Data Connector simulator page---");
    }

    public WebElement returnConnectorURLTextBox() {
        synchronizationVisibilityofElement(driver, connectorURLTextBox);
        return connectorURLTextBox;
    }

   public WebElement returnStartInteractivePhaseButton(){
       synchronizationVisibilityofElement(driver, startInteractivePhaseButton);
       return startInteractivePhaseButton;
   }

   public List<WebElement> returntablesListPreview(){
       return tablesListPreview;
   }

   public WebElement returnSimulatorUserName(){
       synchronizationVisibilityofElement(driver, simulatorUserName);
       return simulatorUserName;
   }

    public WebElement returnSimulatorPassword(){
        synchronizationVisibilityofElement(driver, simulatorPassword);
        return simulatorPassword;
    }

    public WebElement returnSimulatorCatalogName(){
        synchronizationVisibilityofElement(driver, simulatorCatalogName);
        return simulatorCatalogName;
    }

    public WebElement returnsimulatorGetDataButton(){
        synchronizationVisibilityofElement(driver, simulatorGetDataButton);
        return simulatorGetDataButton;
    }

    public WebElement retrunfirstTableFromResult(){
        synchronizationVisibilityofElement(driver,firstTableFromResult);
        return firstTableFromResult;
    }

    public List<WebElement> returndatabaseTableContents(){
        return databaseTableContents;

    }

    public WebElement returndatabaseTableFetchDataButton(){
        synchronizationVisibilityofElement(driver,databaseTableFetchDataButton);
        return databaseTableFetchDataButton;
    }

    public List<WebElement> returnDatabaseList(){
        return databaseList;
    }

    public WebElement returndatasampleTableFetchDataButton(){
        synchronizationVisibilityofElement(driver,datasampleTableFetchDataButton);
        return datasampleTableFetchDataButton;
    }

    public List<WebElement> returndatasampleTableContents(){
        return datasampleTableContents;
    }

    public List<WebElement> returndatasampleList(){
        return datasampleList;
    }

    public WebElement returndirectoryTableFetchDataButton(){
        synchronizationVisibilityofElement(driver,directoryTableFetchDataButton);
        return directoryTableFetchDataButton;
    }

    public List<WebElement> returndirectotyTableContents(){
        return directotyTableContents;
    }

    public List<WebElement> returndirectoriesList(){
        return directoriesList;
    }
}
