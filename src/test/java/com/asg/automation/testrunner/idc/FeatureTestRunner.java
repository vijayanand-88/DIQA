package com.asg.automation.testrunner.idc;


import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;



/*
 * Created by muthuraja.r on 05-19-2017.N
 */


@CucumberOptions(
        features = {"src/test/resources/features/idc/idcnewuifeature/"},

        glue = {"com.asg.automation.stepdefinition"},
        plugin = {"json:target/cucumber.json", "html:target/cucumber-html-reports"},
        tags = {"~@MLP-18397","~@MLP-23675","~@MLP-21077","~@MLP-23708","~@MLP-25375","~@MLP-23704","~@MLP_24156"})

public class FeatureTestRunner extends AbstractTestNGCucumberTests {

    @Parameters({"project", "env_HostName", "ambari_HostName", "browserName","executionType","seleniumHub"})
    @BeforeSuite
    public void init(String project, String env_HostName, String ambari_HostName, String browserName
    ,String executionType,String seleniumHub) {
        new DynamicPropertyLoader().DynamicLoader(project, env_HostName, ambari_HostName, browserName,
                executionType,seleniumHub );

    }

}

