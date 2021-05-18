from pyspark.sql import SparkSession

def basic_datasource_example(spark):
	df = spark.read.load("python/examples/resources/users.parquet")
	df.select("name", "favorite_color").write.save("namesAndFavColors.parquet")
	
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    basic_datasource_example(spark)
    spark.stop()
