package com.asg.automation.testrunner.ida;

import com.asg.automation.utils.DynamicPropertyLoader;
import cucumber.api.CucumberOptions;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;


/**
 * Created by Siddharth on 07/23/2019.
 */

    @CucumberOptions(
            features = {
//                    "src/test/resources/features/ida/pythonplugins/Spark_lineage_HDFS.feature",
//                    "src/test/resources/features/ida/pythonplugins/PythonSparkSQL.feature",
//                    "src/test/resources/features/ida/pythonplugins/Spark_lineage_HBASE.feature",
//                    "src/test/resources/features/ida/pythonplugins/Spark_lineage_HDFS_8890.feature",
//                    "src/test/resources/features/ida/pythonplugins/Spark_lineage_HDFS_8212.feature",
                    "src/test/resources/features/ida/pythonplugins/Spark_lineage_HDFS_8211.feature",
                    "src/test/resources/features/ida/pythonplugins/Spark_lineage_MSSQL_7856.feature"
                        },
            glue = {"com.asg.automation.stepdefinition"},
            plugin = {"json:target/cucumber.json", "html:target/cucumber-html-reports"})
    public class PythonSparkTestRunner extends AbstractTestNGCucumberTests {
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

