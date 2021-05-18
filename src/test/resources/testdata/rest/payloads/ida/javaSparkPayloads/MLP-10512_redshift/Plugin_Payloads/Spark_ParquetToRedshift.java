package com.java.lineage.redshift;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

public class Spark_ParquetToRedshift {

	public void doReadParquetToRedshift() {
		SparkSession spark = SparkSession.builder().appName("Java Spark Redshift basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();

		Dataset<Row> jdbcDF_r6 = null;
		jdbcDF_r6 = spark.read().parquet("hdfs:///user/root/java/source/nation.parquet");
		//jdbcDF_r6 = spark.read().parquet("C:/Raghav/LineageSource/Java/nation.parquet");

		jdbcDF_r6.write().mode(SaveMode.Overwrite)
				.format("jdbc")
				.option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world")
				.option("driver","com.amazon.redshift.jdbc.Driver")
				.option("dbtable", "testschema.qa_java_parquettoredshift")
				.option("user", "master")
				.option("password", "Asg-2019").save();

		spark.stop();
	}

	public static void main(String[] args) {
		new Spark_ParquetToRedshift().doReadParquetToRedshift();
	}
}