package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.CommonPage;
import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.SubjectArea;
import org.openqa.selenium.WebDriver;

/**
 * Created by Divya.Bharathi on 01/31/2019.
 */
public class QuickStartActions extends DashBoardPage {

    public QuickStartActions(WebDriver driver) {
        super(driver);
    }


    public void SearchText(String text) {
//        genericClick("Global Search Icon");
        enterTextToTopSearchBox(text);
        genericClick("globalSearchButton");
    }

    public void clickFirstItemCheckbox() {
        genericClick("firstItemCheckbox");
    }

    public void genericActions(String actionType, String elementName, String... argu) {
        switch (actionType.toLowerCase()) {
            case "click":
                genericClick(elementName);
                break;

            case "double click":
                break;

            case "verify not displayed":
                break;

            case "verify not equals":
                break;

            case "verify displayed":
                genericVerifyElementPresent(elementName);
                break;

        }
    }
}
