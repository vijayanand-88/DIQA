package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


/**
 * Created by Chella M on 29/03/2019.
 */

@CucumberOptions(
        features = {
                "src/test/resources/features/ida/jdbcplugins/sqldb/JDBCAnalyzerOracle_12c_CDB.feature",
                "src/test/resources/features/ida/jdbcplugins/sqldb/JDBCAnalyzerOracle_12c_PDB.feature",
                "src/test/resources/features/ida/jdbcplugins/sqldb/JDBCAnalyzerOracle_12C_PDB_CDB_RDS_PostProcessor.feature"
        },
        glue = {"com.asg.automation.stepdefinition"},
        plugin = {"json:target/cucumber.json", "html:target/cucumber-html-reports"})
public class JDBCOracle12cTestRunner extends AbstractTestNGCucumberTests {
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