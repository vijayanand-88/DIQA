package com.java.lineage.redshift;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;

public class Spark_RedshiftToParquet {

	public void doReadRedshiftToParquet() {
		SparkSession spark = SparkSession.builder().appName("Java Spark Redshift basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();

		Dataset<Row> jdbcDF_r7 = null;
		jdbcDF_r7 = spark.read().format("jdbc")
				.option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world")
				.option("driver","com.amazon.redshift.jdbc.Driver")
				.option("dbtable", "testschema.redshiftpublishers")
				.option("user", "master")
				.option("password", "Asg-2019").load();

		jdbcDF_r7.write().parquet("hdfs:///user/root/java/target/QA_JAVA_redshifttoparquetfile.parquet");
		//jdbcDF_r7.write().parquet("C:/Raghav/LineageTarget/QA_JAVA_redshifttoparquetfile.parquet");

		spark.stop();
	}

	public static void main(String[] args) {
		new Spark_RedshiftToParquet().doReadRedshiftToParquet();
	}
}