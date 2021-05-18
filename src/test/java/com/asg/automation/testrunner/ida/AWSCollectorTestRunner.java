package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


/**
 * Created by Jayasree on 03/31/2020.
 */

    @CucumberOptions(
            features = {"src/test/resources/features/ida/awsplugins/AWSCollector.feature"},
            glue = {"com.asg.automation.stepdefinition"},
            plugin = {"json:target/cucumber.json", "html:target/cucumber-html-reports"})
    public class AWSCollectorTestRunner extends AbstractTestNGCucumberTests {
        @Parameters({"project","env_HostName","ambari_HostName","browserName","executionType","seleniumHub"})
        @BeforeSuite
        public void init(String project, String env_HostName, String ambari_HostName, String browserName
                ,String executionType,String seleniumHub)
        {
            if(project.equalsIgnoreCase("ida")) {
                DynamicPropertyLoader dynamicPropertyLoader = new DynamicPropertyLoader();
                dynamicPropertyLoader.DynamicLoader(project, env_HostName, ambari_HostName, browserName,
                        executionType,seleniumHub);
            }
    }

    }

