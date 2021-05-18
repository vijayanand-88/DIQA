package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.DashBoardPage;
import com.asg.automation.pageobjects.idc.DiagrammingPage;
import org.openqa.selenium.WebDriver;

/**
 * Created by Divya.Bharathi on 01/29/2019.
 */
public class DiagrammingActions extends DiagrammingPage {

    public DiagrammingActions(WebDriver driver) {
        super(driver);
    }

    public void genericActions(String actionType, String elementName, String... dynamicItem) {
        switch (actionType.toLowerCase()) {
            case "click":
                if (dynamicItem.length == 0)
                    genericClick(elementName);
                else
                    genericClick(elementName, dynamicItem[0]);
                break;
            case "double click":
                break;

            case "dynamic click":
                break;

            case "verifies displayed":

                break;

            case "verifies not displayed":
                break;

            case "verify equals":

                break;

            case "verify not equals":
                break;

            case "enters text":
                enterActions(elementName, dynamicItem[0]);
                break;
            case "displayed":
                genericVerifyElementPresent(elementName);
                break;
            case "not displayed":
                genericVerifyElementNotPresent(elementName);
                break;


        }
    }

            public void LineageDiagrammingpage(String actionType, String fieldName, String option, String pageName) throws Exception {
                switch (actionType) {
                    case "select dropdown":
                        LineageDiagrammingpage(option);
                        break;
                    case "select options":
                        SelectMenuLineageDiagrammingpage(option);
                        break;
                    case "verifies hop content":
                        verifyLineageDiagrammingPopUpContent(fieldName,option);
                        break;
                }
            }
    }

