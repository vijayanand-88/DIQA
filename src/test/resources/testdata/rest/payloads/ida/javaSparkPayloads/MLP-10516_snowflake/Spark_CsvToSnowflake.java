package com.java.lineage.snowflake;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

public class Spark_CsvToSnowflake {

	public void doReadCsvToSnowflake() {
		SparkSession spark = SparkSession.builder().appName("Java Spark Snowflake basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();
		
		Dataset<Row> jdbcDF_sf5 = null;
		jdbcDF_sf5 = spark.read().csv("hdfs:///user/root/java/source/spark.csv");
		//jdbcDF = spark.read().csv("C:/Blue Boy R/IDA/R10.1.0/Java Parser/LineageSourceFiles/user/root/java/QASource/spark.csv");
		
		jdbcDF_sf5.write().mode(SaveMode.Overwrite)
			.format("jdbc")	
			.option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB")
			.option("driver", "net.snowflake.client.jdbc.SnowflakeDriver")
			.option("dbtable", "TESTSCHEMA.QA_JAVA_CSV_TO_SNOWFLAKE")
			.option("user", "SENTHIL")
			.option("password", "Asg-2019").save();
		
		spark.stop();
	}
	
	public static void main(String[] args) {
		new Spark_CsvToSnowflake().doReadCsvToSnowflake();
	}
}
