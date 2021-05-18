from pyspark.sql import SparkSession

def basic_datasource_example(spark):
	
	parquetFile1 = spark.read.parquet("hdfs:///python/sourceVJ/users2.parquet")
	parquetFile1.write.parquet("hdfs:///python/target/Negative")

			
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    basic_datasource_example(spark)
    spark.stop()
	
