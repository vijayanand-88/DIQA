package com.asg.automation.testrunner.idc;


import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;



/*
 * Created by muthuraja.r on 05-19-2017.
 */


@CucumberOptions(
        features = {"src/test/resources/features/idc/olduifeatures/idcdiagrammingfeature"},
        glue = {"com.asg.automation.stepdefinition"},
        format = {"pretty", "html:target/cucumber-html-report", "pretty:target/cucumber-report.json"})

public class DiagrammingTestRunner extends AbstractTestNGCucumberTests {

    @Parameters({"project", "env_HostName", "ambari_HostName", "browserName"})
    @BeforeSuite

    public void init(String project, String env_HostName, String ambari_HostName, String browserName) {
        DynamicPropertyLoader dynamicPropertyLoader = new DynamicPropertyLoader();
        dynamicPropertyLoader.DynamicLoader(project, env_HostName, ambari_HostName, browserName);

    }

}

