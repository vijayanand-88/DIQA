package com.asg.automation.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import static com.asg.automation.utils.Constant.UI_CONFIG;


/**
 * Created by muthuraja.ramakrishn on 4/7/2017.
 * To load all credentials properties
 */
@SuppressWarnings("DefaultFileTemplate")
public class PropertyLoader {
    public Properties prop;



    public void loadProperty() {
        File file = new File(UI_CONFIG);
        FileInputStream fileInput = null;
        try {
            fileInput = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        prop = new Properties();
        //load properties file
        try {
            prop.load(fileInput);
        } catch (IOException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }



}
