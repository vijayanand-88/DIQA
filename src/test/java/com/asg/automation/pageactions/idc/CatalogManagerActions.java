package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.SubjectAreaManagement;
import org.openqa.selenium.WebDriver;

/**
 * Created by Divya.Bharathi on 01/31/2019
 */
public class CatalogManagerActions extends SubjectAreaManagement {

    public CatalogManagerActions(WebDriver driver) {
        super(driver);
    }

    public void createCatalog(String catalogName) {
        click_newSubjectAreaCreateButton();
        enterActions("catalog name and description", catalogName);
        click_newSubjectAreaSaveButton();
    }

    public void selectCatalogFromList(String catalogName) {
        genericClick(catalogName);
    }

    public void userCreatesACatalog(String CatalogName, String CatalogDescription) {
        genericClick("Create");
        enterActions("CatalogName", CatalogName);
        enterActions("CatalogDescription", CatalogDescription);
        genericClick("icon");
    }

    public void selectIconfromList(String Icon) {
        enterActions("Icon", "pdf");
    }

    public void genericActions(String actionType, String elementName, String... argu) {
        switch (actionType.toLowerCase()) {
            case "click":
                if (argu.length == 0)
                    genericClick(elementName);
                else
                    genericClick(elementName, argu[0]);
                break;
            case "double click":
                break;

            case "dynamic click":
                break;

            case "verifies displayed":
                if (argu.length == 0)
                    genericVerifyElementPresent(elementName);
                else
                    genericVerifyElementPresent(elementName, argu[0]);
                break;

            case "verifies not displayed":
                break;

            case "verify equals":
                break;

            case "verify not equals":
                break;

        }
    }

}
