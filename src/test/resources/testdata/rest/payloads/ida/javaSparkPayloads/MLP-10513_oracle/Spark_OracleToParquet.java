package com.java.lineage.oracle;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

public class Spark_OracleToParquet {

	public void doReadOracleToParquet() {
		SparkSession spark = SparkSession.builder().appName("Java Spark MSSQL basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();
		
		Dataset<Row> jdbcDF_ms7 = null;
		jdbcDF_ms7 = spark.read().format("jdbc")
				.option("url", "jdbc:oracle:thin:@gechcae-col1.asg.com:1521:col2")
				.option("driver","oracle.jdbc.driver.OracleDriver")
				.option("dbtable", "COLLECTOR.publishersa")
				.option("user", "collector")
				.option("password", "collector1").load();
		
		jdbcDF_ms7.write().parquet("hdfs:///user/root/java/target/QA_JAVA_mssqltoparquetfile.parquet");
		//jdbcDF.write().parquet("C:/RedShift/Raghav/LineageTargetFiles/user/root/java/QATarget/QA_JAVA_mssqltoparquetfile.parquet");
		
		spark.stop();
	}
	
	public static void main(String[] args) {
		new Spark_OracleToParquet().doReadOracleToParquet();
	}
}