package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.BundleManager;
import com.gargoylesoftware.htmlunit.ElementNotFoundException;
import org.openqa.selenium.ElementNotSelectableException;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.List;
import java.util.Map;

public class BundleManagerActions extends BundleManager {

    public BundleManagerActions(WebDriver driver){super(driver);}

    public void verifyPresenceOfElement(String actionType, String elementName, List<Map<String,String>> valuesList) throws Exception {
        switch (actionType.toLowerCase())
        {
            case "verify presence":
                if(elementListPresent(elementName,valuesList)== false){
                    throw new Exception();
                }
        }
    }

}