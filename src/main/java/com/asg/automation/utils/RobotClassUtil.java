package com.asg.automation.utils;

import cucumber.api.DataTable;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.util.Map;

/**
 * Created by muthuraja.ramakrishn on 6/8/2018.
 */
public class RobotClassUtil {
    Robot robot;
    StringSelection copiedText;

    public RobotClassUtil() throws AWTException {
        robot = new Robot();
    }

    public RobotClassUtil(String text) throws AWTException {
        robot = new Robot();
        copiedText = new StringSelection(text);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(copiedText, null);

    }

    public RobotClassUtil selectAFile(String fileName) throws AWTException {
        String dir = System.getProperty("user.dir");
        copiedText = new StringSelection(dir + Constant.EXCEL_UPLOAD_PATH + fileName);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(copiedText, null);
        return this;
    }

    public RobotClassUtil selectOSGIFile(String fileName) throws AWTException {
        String dir = System.getProperty("user.dir");
        copiedText = new StringSelection(dir + Constant.OSGI_BUNDLES_UPLOAD_PATH + fileName);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(copiedText, null);
        return this;
    }

    public RobotClassUtil selectExcelFile(String fileName) throws AWTException {
        String dir = System.getProperty("user.dir");
        copiedText = new StringSelection(dir + Constant.EXCEL_UPLOAD_PATH + fileName);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(copiedText, null);
        return this;
    }

    public RobotClassUtil selectPluginFile(String fileName) throws AWTException {
        String dir = System.getProperty("user.dir");
        copiedText = new StringSelection(dir + Constant.PLUGIN_BUNDLES_UPLOAD_PATH + fileName);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(copiedText, null);
        return this;
    }

    public RobotClassUtil keyPress(String text) {
        robot.keyPress(returnKey(text.trim()));
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), text + "Key Pressed");
        return this;
    }

    public RobotClassUtil keyRelease(String text) {
        robot.keyRelease(returnKey(text.trim()));
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), text + "Key Released");
        return this;
    }

    public RobotClassUtil setDelay(int delay) {
        robot.setAutoDelay(delay);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), delay + "secs delayed");
        return this;
    }

    public int returnKey(String keyValue) {
        int returnKey = 0;
        switch (keyValue.toUpperCase()) {
            case "C":
                returnKey = KeyEvent.VK_C;
                break;
            case "V":
                returnKey = KeyEvent.VK_V;
                break;
            case "ENTER":
                returnKey = KeyEvent.VK_ENTER;
                break;
            case "CONTROL":
                returnKey = KeyEvent.VK_CONTROL;
                break;
            default:
                break;

        }
        return returnKey;
    }

    public void robotClassOperation(DataTable tableFields) {
        try {
            for (Map<String, String> data : tableFields.asMaps(String.class, String.class)) {
                switch (data.get("Method")) {
                    case "keyPress":
                        keyPress(data.get("Action"));
                        break;

                    case "keyRelease":
                        keyRelease(data.get("Action"));
                        break;

                    case "setAutoDelay":
                        setDelay(Integer.parseInt(data.get("Action")));
                        break;

                    case "selectAFile":
                        selectAFile(data.get("Action"));
                        break;

                    case "selectOSGIFile":
                        selectOSGIFile(data.get("Action"));
                        break;

                    case "selectExcelFile":
                        selectExcelFile(data.get("Action"));
                        break;

                    case "selectPluginFile":
                        selectPluginFile(data.get("Action"));
                        break;
                    default:
                        break;
                }
            }
        } catch (Exception e) {
            LoggerUtil.log.info("RobotClass Exception" + e.getMessage());
        }
    }

    public static void main(String[] args) throws AWTException {
        RobotClassUtil robotClassUtil = new RobotClassUtil();

        robotClassUtil.keyPress("CONTROL").keyPress("C").keyRelease("CONTROL").keyRelease("V").setDelay(1000);

    }
}
