package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.PluginManager;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;

import java.util.List;
import java.util.Map;

/**
 * Created by Divya.Bharathi on 01/29/2019
 */
public class PluginManagerActions extends PluginManager {

    public WebDriver driver;

    public PluginManagerActions(WebDriver driver) {
        super(driver);
    }

    public void clickAnalysisPluginFromList(String pluginName) {
        genericClick("Analysis plugin label");
        genericClick("select plugin", pluginName);
    }

    public void clickmultipleAnalysisPluginFromList(String pluginName) {
        //  genericClick("Analysis plugin label");
        genericClick("select plugin", pluginName);
    }

    public void selectCatalogFromTheList(String catalogName) {
        genericClick("catalog dropdown button");
        genericClick("select catalog in plugin configuration", catalogName);
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

            case "verify not displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementNotPresent(elementName);
                else
                    genericVerifyElementNotPresent(elementName, dynamicItem[0]);
                break;

            case "verify not equals":
                break;

            case "verify displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementPresent(elementName);
                else
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                break;

            case "verify equals":
                genericVerifyEquals(elementName, dynamicItem[0]);
                break;

            case "verifies enabled":
                genericVerifyEnabled(elementName);
                break;

            case "verifies disabled":
                genericVerifyDisabled(elementName);
                break;

            case "enters text":
                enterActions(elementName, dynamicItem[0]);
                break;

            //10.3 New UI
            case "displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementPresent(elementName);
                else
                    genericVerifyElementPresent(elementName, dynamicItem[0]);
                break;

            case "not displayed":
                if (dynamicItem.length == 0)
                    genericVerifyElementNotPresent(elementName);
                else
                    genericVerifyElementNotPresent(elementName, dynamicItem[0]);
                break;

            case "enabled":
                genericVerifyElementIsEnabled(elementName);
                break;

            case "disabled":
                genericVerifyElementIsDisabled(elementName);
                break;
            case "expand accordion":
                genericClick(actionType, elementName, dynamicItem[0], dynamicItem[1]);
                break;
            case "expand accordion and click menu option":
                genericClick(actionType, elementName, dynamicItem[0], dynamicItem[1],dynamicItem[2]);
                break;
        }
    }

    public void navigateToPluginConfigPage(String actionType, String... dynamicItem) throws Exception {
        switch (actionType) {
            case "navigates":
                navigateToPluginConfig(dynamicItem[0], dynamicItem[1]);
                break;
        }
    }

    public void navigateToPluginConfigListPage(String actionType, String... dynamicItem) throws Exception {
        navigateToPluginConfigListPage(dynamicItem[0]);
    }

    public void validatePluginConfigErrorMessage(String actionType, List<Map<String, String>> data) throws Exception {
        Assert.assertTrue(isElementpresentInPluginConfig(actionType, data));

    }

    public void validateValuesInMap(String actionType, Map<String, String> data) throws Exception {
        Assert.assertTrue(isMapElementpresentInPluginConfig(actionType, data));

    }

    public void validatePluginConfigCaptions(String actionType, List<String> data) throws Exception {
        Assert.assertTrue(isCaptionsPresentInPluginConfig(actionType, data));

    }

    public void selectAttributeFromTheFilterDropdown(String filterName, String option) throws Exception {
        selectAttributeFromTheDropdown(filterName, option);
    }

    public void getPluginConfigurationStatusForDeployment(String deploymentName, String status) throws Exception {
        getPluginConfigurationStatus(deploymentName, status);
    }

    public void getPluginConfigurationStatusCountForDeployment(String deploymentName, String status, String count) throws Exception {
        getPluginConfigurationStatusCount(deploymentName, status, count);
    }

    public void validateElementsInManageConfigPage(String actionType, String actionToBeverified, List<String> data) throws Exception {
        switch (actionType) {
            case "verifies presence":
                validateElementPresense(actionToBeverified, data);
                break;
            case "verifies not presence":
                validateElementNotPresense(actionToBeverified, data);
                break;
            case "verifies sorting order":
                verifySortingOrder(actionToBeverified, data);
                break;
        }
    }

    public void addManageConfigurationsPageConfigurations(String actionType, String fieldName, String option, String pageName) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectAttributesFromTheDropdown(fieldName, option);
                break;
            case "enter text":
                enterTextInAddConfigurationPage(fieldName, option);
                break;
            case "Validate the field Error Message":
                validateErrorMessageForTheFields(fieldName, option, pageName);
                break;
            case "select type":
                genericClick(actionType, fieldName);
                break;
            case "click":
                genericClick(fieldName,option);
                break;
        }
    }

    public void addAndManageConfigurations(String actionType, String fieldName, String option) throws Exception {
        switch (actionType) {
            case "select dropdown":
                selectAttributesFromTheDropdown(fieldName, option);
                break;
            case "enter text":
                enterTextInAddOrUpdateConfigurationPage(fieldName,option);
                break;
            case "enter properties text":
                enterPropertiesTextInAddConfigurationPage(fieldName,option);
                break;
        }
    }

    public void validateElementsInAddConfigPage(List<String> itemList, String... actionType) throws Exception {
        switch (actionType[0]) {
            case "Dynamic form":
                Assert.assertTrue(isElementsPresentInList(itemList, actionType[1]));
                break;
            case "Newly added item":
            case "verify duplicate item is added":
                Assert.assertTrue(isElementsPresentInList(itemList, actionType[0], actionType[1]));
                break;
            case "Default Option selected":
                genericVerifyElementPresent(actionType[0], actionType[1], itemList.get(0));
                break;
            case "Default BA Option selected":
                genericVerifyElementPresent(actionType[0], itemList.get(0));
                break;
            case "Diagram Order":
                Assert.assertTrue(isElementsPresentInList(itemList, actionType[0]));
                break;
        }
    }

    public void pluginConfigurationsPageConfigurations(String actionType, String buttonName, String pluginName) throws Exception {
        switch (actionType) {
            case "displayed":
                validateElementPresenseForPluginConfigurations(buttonName, pluginName);
                break;
        }
    }
    public void validateProjectItems(String actionType, List<String> data) throws Exception {
        Assert.assertTrue(isProjectItemsPresent(actionType, data));

    }

}
