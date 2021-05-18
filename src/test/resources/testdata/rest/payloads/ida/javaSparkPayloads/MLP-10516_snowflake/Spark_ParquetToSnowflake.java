package com.java.lineage.snowflake;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

public class Spark_ParquetToSnowflake {

	public void doReadParquetToSnowflake() {
		SparkSession spark = SparkSession.builder().appName("Java Spark Snowflake basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();
		
		Dataset<Row> jdbcDF_sf6 = null;
		jdbcDF_sf6 = spark.read().parquet("hdfs:///user/root/java/source/userdata1.parquet");
		//jdbcDF = spark.read().parquet("C:/Blue Boy R/IDA/R10.1.0/Java Parser/LineageSourceFiles/user/root/java/QASource/userdata1.parquet");
		
		jdbcDF_sf6.write().mode(SaveMode.Overwrite)
			.format("jdbc")	
			.option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB")
			.option("driver", "net.snowflake.client.jdbc.SnowflakeDriver")
			.option("dbtable", "TESTSCHEMA.QA_JAVA_PARQUET_TO_SNOWFLAKE")
			.option("user", "SENTHIL")
			.option("password", "Asg-2019").save();
		
		spark.stop();
	}
	
	public static void main(String[] args) {
		new Spark_ParquetToSnowflake().doReadParquetToSnowflake();
	}
}
