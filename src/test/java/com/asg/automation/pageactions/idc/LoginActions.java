package com.asg.automation.pageactions.idc;

import com.asg.automation.pageobjects.idc.LoginPage;
import org.openqa.selenium.WebDriver;

/**
 * Created by Muthuraja.Ramakrishn on 01/22/2019.
 */
public class LoginActions extends LoginPage {

    public LoginActions(WebDriver driver) {
        super(driver);
    }


    /**
     * @param username
     * @param password Login page functionality with customized user
     */
    public void loginToIDCPage(String username, String password) {
        //highlightElement(driver,usernameField);
        enterActions("Username", username);
        //highlightElement(driver,passwordField);
        enterActions("Password", password);
        //highlightElement(driver,loginButton);
        clickActions("LOGIN");
    }

    public void signAsADifferentUser(){
        clickActions("signAsADifferentUser");
    }

    public void clickLogOutButton() {
        clickActions("LogOut button");  }

    public void genericActions(String actionType, String elementName, String... dynamicItem){
        switch (actionType.toLowerCase()) {
            case "verifies displayed":
                genericVerifyElementPresent(elementName);
                break;


        }
    }
}
