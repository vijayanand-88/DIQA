package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


/**
 * Created by Nirmal.Balasundaram on 7/31/2017.
 */

@CucumberOptions(
        features = {
                "src/test/resources/features/ida/gitplugins/GitCollector.feature",
                "src/test/resources/features/ida/gitplugins/MLP-1400-Git Collector-I can select folders and subfolders from the branch.feature",
                "src/test/resources/features/ida/gitplugins/MLP_1402_DryRunFeatures.feature",
                "src/test/resources/features/ida/gitplugins/MLP-9840_MaxWorkSize_GITchanges.feature",
                "src/test/resources/features/ida/gitplugins/MLP_3244_ProjectDepth.feature"
        },
        glue = {"com.asg.automation.stepdefinition"},
        plugin = {"json:target/cucumber.json", "html:target/cucumber-html-reports"})
public class IDATestRunner extends AbstractTestNGCucumberTests {


    @Parameters({"project", "env_HostName", "ambari_HostName", "browserName", "executionType", "seleniumHub"})
    @BeforeSuite
    public void init(String project, String env_HostName, String ambari_HostName, String browserName, String executionType, String seleniumHub) {
        if (project.equalsIgnoreCase("ida")) {
            DynamicPropertyLoader dynamicPropertyLoader = new DynamicPropertyLoader();
            dynamicPropertyLoader.DynamicLoader(project, env_HostName, ambari_HostName, browserName, executionType, seleniumHub);
        }
    }

}

