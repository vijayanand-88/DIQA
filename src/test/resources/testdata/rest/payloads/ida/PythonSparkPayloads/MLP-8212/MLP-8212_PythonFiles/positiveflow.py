from pyspark.sql import SparkSession

def basic_datasource_example(spark):
	
	parquetFile1 = spark.read.parquet("hdfs:///python/sourceVJ/users1.parquet")
	parquetFile1.write.parquet("hdfs:///python/target/Names")
	csvFile = spark.read.csv("hdfs:///python/sourceVJ/spark1.csv")
	csvFile.select("_c0", "_c1").write.csv("hdfs:///python/target/names.csv")
	csvFile1 = spark.read.csv("hdfs:///python/sourceVJ/spark2.csv")
	csvFile1.write.csv("hdfs:///python/target/Names2")
	comb1 = spark.read.csv("hdfs:///python/sourceVJ/spark3.csv")
	comb1.write.parquet("hdfs:///python/target/combination1")
	comb2 = spark.read.parquet("hdfs:///python/sourceVJ/sample.parquet")
	comb2.write.csv("hdfs:///python/target/combination2")
			
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    basic_datasource_example(spark)
    spark.stop()
	
