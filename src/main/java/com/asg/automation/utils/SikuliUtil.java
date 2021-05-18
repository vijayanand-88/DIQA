package com.asg.automation.utils;

import cucumber.api.DataTable;
import org.sikuli.script.FindFailed;
import org.sikuli.script.Pattern;
import org.sikuli.script.Screen;
import java.util.Map;

/**
 * Created by muthuraja.ramakrishn on 07/10/2018.
 */
public class SikuliUtil {

    private Screen screen;
    private Pattern pattern;
    private String actionType="Action";
    private String path = "Path";
    private String percentage = "Percentage";
    PropertyLoader propLoader = new PropertyLoader();

    /**
     * Screen initalizaton
     */
    public SikuliUtil() {
        screen = new Screen();
        propLoader.loadProperty();

    }

    /**
     *  Instantiate Patern class with image so that it object available through this class
     * @param imagePath supply image path
     * @return
     */
    public SikuliUtil initializeImage(String imagePath) {
        pattern = new Pattern(imagePath);
        return this;
    }


    /**
     * Image is exist or not
     * @param waitTime supply waitTime
     * @return
     */
    public Boolean verifyImageExist(double waitTime) {
        boolean flag = false;
        if (screen.exists(pattern, waitTime) != null) {
            flag = true;
        }
        return flag;
    }

//Verify image presence with percentage
    public boolean verifySimilarityofImage(double waitTime, float percentage){
        boolean flag = false;
        if(screen.exists(pattern.similar(percentage),waitTime)!= null){
            flag=true;
        }
        return flag;
    }


    /**
     * Screenwait for Imageload or sychnroization of your application loaded
     * @param waitTime
     * @return
     */
    public SikuliUtil screenWait(double waitTime) {
        screen.wait(waitTime);
        return this;
    }

    /**
     * Enter text on the image
     * @param text
     * @return
     * @throws FindFailed
     */
    public SikuliUtil enterText(String text) throws FindFailed {
        screen.type(pattern, text);
        return this;
    }

    /**
     * Click on the image
     * @return
     * @throws FindFailed
     */
    public SikuliUtil clickAction() throws FindFailed {
        screen.click(pattern);
        return this;
    }

    /**
     * Double click on the  image
     * @return
     * @throws FindFailed
     */
    public SikuliUtil doubleClickAction() throws FindFailed {
        screen.doubleClick(pattern);
        return this;
    }

    /**
     * Execute action using Datadriven approach
     * use method name for first column and its value for second column
     * @param tableFields
     */
    public boolean sikuliOperation(DataTable tableFields) {
        boolean flag = false;
        try {
            for (Map<String, String> data : tableFields.asMaps(String.class, String.class)) {
                switch (data.get("Method")) {
                    case "initializeImage":
                        initializeImage(propLoader.prop.getProperty(data.get(path)) + data.get(actionType));
                        break;
                    case "verifyImageExist":
                        if (verifyImageExist(Double.parseDouble(data.get(actionType))))
                            flag = true;
                        break;

                    case "enterText":
                        enterText(data.get(actionType));
                        break;

                    case "clickAction":
                        clickAction();
                        break;

                    case "doubleClickAction":
                        doubleClickAction();
                        break;

                    case "verifySimilarityofImage":
                        if(verifySimilarityofImage(Double.parseDouble(data.get(actionType)),Float.parseFloat(data.get(percentage))))
                            flag=true;
                        break;
                    default:
                }
            }
        } catch (Exception e) {
            LoggerUtil.log.info("Sikuli Exception" + e.getMessage());
        }
        return flag;
    }

    public static void main(String[] args) throws FindFailed {
        SikuliUtil sikuliUtil=new SikuliUtil();
        //path of omages to be loaded first and then followed by actions
        sikuliUtil.initializeImage("path").enterText("").clickAction();
    }
}
