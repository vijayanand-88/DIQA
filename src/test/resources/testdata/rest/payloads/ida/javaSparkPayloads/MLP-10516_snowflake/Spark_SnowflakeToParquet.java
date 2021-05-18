package com.java.lineage.snowflake;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

public class Spark_SnowflakeToParquet {

	public void doReadSnowflakeToParquet() {
		SparkSession spark = SparkSession.builder().appName("Java Spark Snowflake basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();
		
		Dataset<Row> jdbcDF_sf7 = null;
		jdbcDF_sf7 = spark.read().format("jdbc")
				.option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB")
				.option("driver", "net.snowflake.client.jdbc.SnowflakeDriver")
				.option("dbtable", "TESTSCHEMA.EMPLOYEE_DATA")
				.option("user", "SENTHIL")
				.option("password", "Asg-2019").load()
				.select("EMPLOYEE_ID","EMAIL","SSN","GENDER");
		
		jdbcDF_sf7.write().parquet("hdfs:///user/root/java/target/QA_JAVA_snowflaketoparquetfile.parquet");
		//jdbcDF.write().parquet("C:/Blue Boy R/IDA/R10.1.0/Java Parser/LineageTargetFiles/user/root/java/QATarget/QA_JAVA_snowflaketoparquetfile.parquet");
		
		spark.stop();
	}
	
	public static void main(String[] args) {
		new Spark_SnowflakeToParquet().doReadSnowflakeToParquet();
	}
}
