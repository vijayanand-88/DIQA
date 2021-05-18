package com.java.lineage.oracle;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

public class Spark_ParquetToOracle {

	public void doReadParquetToOracle() {
		SparkSession spark = SparkSession.builder().appName("Java Spark MSSQL basic example")
				.config("spark.some.config.option", "some-value").getOrCreate();
		
		Dataset<Row> jdbcDF_ms6 = null;
		jdbcDF_ms6 = spark.read().parquet("hdfs:///user/root/java/source/userdata1.parquet");
		//jdbcDF = spark.read().parquet("C:/RedShift/Raghav/LineageSourceFiles/user/root/java/QASource/userdata1.parquet");
		
		jdbcDF_ms6.write().mode(SaveMode.Overwrite)
			.format("jdbc")
			.option("url", "jdbc:oracle:thin:@gechcae-col1.asg.com:1521:col2")
			.option("driver","oracle.jdbc.driver.OracleDriver")
			.option("dbtable", "COLLECTOR.qa_parquettomssqla")
			.option("user", "collector")
			.option("password", "collector1").save();		

		spark.stop();
	}
	
	public static void main(String[] args) {
		new Spark_ParquetToOracle().doReadParquetToOracle();
	}
}