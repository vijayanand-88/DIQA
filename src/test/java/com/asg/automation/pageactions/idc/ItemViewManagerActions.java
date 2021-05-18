package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.ItemViewManagement;
import org.openqa.selenium.WebDriver;

import java.util.List;
import java.util.Map;

/**
 * Created by Divya.Bharathi on 01/31/2019
 */
public class ItemViewManagerActions extends ItemViewManagement {

    public ItemViewManagerActions(WebDriver driver) {
        super(driver);
    }

    public void selectItemFromListAndClickVisualComposer(String itemviewName) {
        genericClick("select item name from list",itemviewName);
        genericClick("Visual Composer");
    }

    public void clickLogoutButton() {
        genericClick("LogOut button");
    }


    public void resizeWidgetInItemViewManager(String widgetName, String resizeValue){
        genericClick(widgetName);
        genericClick(resizeValue);
        genericClick("apply_button");
        genericClick("SaveButton");
    }

    public void genericActions(String actionType, String elementName, String... dynamicItem){
        switch (actionType.toLowerCase()) {
            case "click":
                genericClick(elementName);
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

        }
    }

    public void itemViewConfigurations(List<Map<String, String>> dataTable, String... field) {
        genericClick(field[0], field[1]);
        genericActionsMap(dataTable, field[0],field[1]);


    }

}
