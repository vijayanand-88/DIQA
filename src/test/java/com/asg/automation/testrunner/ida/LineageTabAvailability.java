package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


/**
 * Created by Siddharthan.G on 12/15/2020.
 */

@CucumberOptions(
        features = {"src/test/resources/features/ida/idauifeature/LineageUIFeatures/MLP_31379_Lineage tab availability at data and structure levels.feature"},
        glue = {"com.asg.automation.stepdefinition"},
        plugin = {"json:target/cucumber.json", "html:target/cucumber-html-reports"})

public class LineageTabAvailability extends AbstractTestNGCucumberTests {
    @Parameters({"project", "env_HostName", "ambari_HostName", "browserName", "executionType", "seleniumHub"})
    @BeforeSuite
    public void init(String project, String env_HostName, String ambari_HostName, String browserName, String executionType, String seleniumHub) {
        if (project.equalsIgnoreCase("ida")) {
            DynamicPropertyLoader dynamicPropertyLoader = new DynamicPropertyLoader();
            dynamicPropertyLoader.DynamicLoader(project, env_HostName, ambari_HostName, browserName, executionType, seleniumHub);
        }
    }

}

