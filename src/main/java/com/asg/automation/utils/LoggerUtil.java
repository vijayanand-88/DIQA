package com.asg.automation.utils;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.openqa.selenium.interactions.Actions;


/**
 * Created by muthuraja.ramakrishn on 5/9/2017.
 */


@SuppressWarnings("ALL")
public class LoggerUtil {

    public static org.apache.log4j.Logger log;

    private LoggerUtil() {
        throw new IllegalStateException("Utility class");
    }

    public static void logLoader_info(String className, String message)
    {
        log= Logger.getLogger(className);
        PropertyConfigurator.configure("log4j.properties");
        log.info(message);
    }

    public static void logLoader_error(String className, String message)
    {
        log= Logger.getLogger(className);
        PropertyConfigurator.configure("log4j.properties");
        log.error(message);
    }

    public static void logInfo(String message)
    {
        log= Logger.getLogger(Actions.class.getName());
        PropertyConfigurator.configure("log4j.properties");
        log.info(message);
    }

}
