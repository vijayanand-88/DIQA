package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


/**
 * Created by Venkata Sai on 12/11/2017.
 */

    @CucumberOptions(
            features = {"src/test/resources/features/ida/bigdataplugins/MLAnalyzer.feature"},
            glue = {"com.asg.automation.stepdefinition"},
            format = {"pretty", "html:target/cucumber-html-report", "pretty:target/cucumber-report.json"})
    public class MLAnalyzerTestRunner extends AbstractTestNGCucumberTests {
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

