package com.java.lineage.oracle;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

public class Spark_CsvToOracle {

	public void doReadCsvToOracle() {
		SparkSession spark = SparkSession.builder().appName("Java Spark MSSQL basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();
		
		Dataset<Row> jdbcDF_ms5 = null;
		jdbcDF_ms5 = spark.read().csv("hdfs:///user/root/java/source/spark.csv");
		//jdbcDF = spark.read().csv("C:/RedShift/Raghav/LineageSourceFiles/user/root/java/QASource/spark.csv");
		
		jdbcDF_ms5.write().mode(SaveMode.Overwrite)
			.format("jdbc")
			.option("url", "jdbc:oracle:thin:@gechcae-col1.asg.com:1521:col2")
			.option("driver","oracle.jdbc.driver.OracleDriver")
			.option("dbtable", "COLLECTOR.qa_csvtomssqla")
			.option("user", "collector")
			.option("password", "collector1").save();
		
		spark.stop();	
	}
	
	public static void main(String[] args) {
		new Spark_CsvToOracle().doReadCsvToOracle();
	}
}