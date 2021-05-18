package com.asg.automation.utils.jmxUtil;

import com.asg.automation.utils.LoggerUtil;
import com.asg.automation.utils.PropertyLoader;
import com.asg.automation.utils.SSHBean;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.concurrent.TimeUnit;

public class GemfireCreateData {

    public Boolean createData(String gemfireLocation, String gemfireCommandFile) {
        PropertyLoader propLoader = new PropertyLoader();
        propLoader.loadProperty();

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "inside gemfire data creation");

        BufferedReader inputReader = null;

        String inputLine = null;

        Boolean flag = false;
        int count = 0;

        try {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "inside data creation#####");
            //String command = "cmd.exe /c cd \"C:\\Users\\wiproida\\Downloads\\pivotal-gemfire-9.6.0\\pivotal-gemfire-9.6.0\\bin\" && gfsh run --file=C:\\Users\\wiproida\\Downloads\\DI_Cucumber_BDD\\DI_Cucumber_BDD\\src\\test\\resources\\testdata\\gemfire\\commands.gfsh";
            String command = "cmd /c start cmd.exe /K \"cd C:\\Users\\chella.mohanmari\\Downloads\\pivotal-gemfire-9.7.0\\pivotal-gemfire-9.7.0\\pivotal-gemfire-9.7.0\\bin && gfsh run --file=C:\\Projects\\IDA_Oracle\\DI_Cucumber_BDD\\src\\test\\resources\\testdata\\gemfire\\gemfireCommands.gfsh\"";
            Process p = Runtime.getRuntime().exec(command);
            p.waitFor(360, TimeUnit.SECONDS);
            int exitval = p.exitValue();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Exit Status=" + exitval);
            if (exitval == 0) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Execution Successfull");
                flag = true;
            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Execution Failed ::: " + command);
            }
// read output from cmd
            inputReader = new BufferedReader(new InputStreamReader(p.getInputStream()));
            inputLine = inputReader.readLine();
            while (inputLine != null) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), inputLine);
                inputLine = inputReader.readLine();

            }

            inputReader.close();
            p.destroy();
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "exception  ::::: " + e.toString());
        }


        return flag;

    }

}
