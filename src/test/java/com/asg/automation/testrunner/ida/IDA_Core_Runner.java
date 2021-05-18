package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


@CucumberOptions(
        features = {"src/test/resources/features/ida/idauifeature/Plugin_Auto_Start.feature",
                "src/test/resources/features/ida/idauifeature/Hot_Reloading_of_plugins.feature",
                "src/test/resources/features/ida/idauifeature/Plugin_Start_Stop.feature",
                "src/test/resources/features/ida/idauifeature/MLP-4239-Provide_Plugin_Metadata_within_a_plugin.feature"},
        glue = {"com.asg.automation.stepdefinition"},
        format = {"pretty", "html:target/cucumber-html-report", "pretty:target/cucumber-report.json"})
public class IDA_Core_Runner extends AbstractTestNGCucumberTests {
    @Parameters({"project","env_HostName","ambari_HostName","browserName","executionType","seleniumHub"})
    @BeforeSuite
    public void init(String project,String env_HostName, String ambari_HostName,String browserName,String executionType,String seleniumHub)
    {
        if(project.equalsIgnoreCase("ida")) {
            DynamicPropertyLoader dynamicPropertyLoader = new DynamicPropertyLoader();
            dynamicPropertyLoader.DynamicLoader(project,env_HostName, ambari_HostName,browserName,executionType,seleniumHub);
        }
}

}

