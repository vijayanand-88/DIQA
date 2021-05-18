from pyspark.sql import SparkSession

def basic_datasource_example(spark):
	df1 = spark.read.load("python/file1.parquet")
	df1.write.save("python/file2.parquet")
	
	df2 = spark.read.load("python/file1.parquet")
	df2.write.save("python/file3.parquet")
	
	df3 = spark.read.load("python/file1.parquet")
	df3.write.save("python/usersTest.parquet")
	
	df4 = spark.read.load("python/file1.parquet")
	df4.write.save("python/SampleFile.parquet")
	
	df5 = spark.read.load("python/file1.parquet")
	df5.write.save("python/product_sample.parquet")
	
	df6 = spark.read.load("python/file4.parquet")
	df6.write.save("python/file1.parquet")
	
	df7 = spark.read.load("python/file5.parquet")
	df7.write.save("python/file1.parquet")
	
	df8 = spark.read.load("python/file6.parquet")
	df8.write.save("python/file1.parquet")
	
	df9 = spark.read.load("python/sample1.parquet")
	df9.write.save("python/file1.parquet")
	
	df10 = spark.read.load("python/sample2.parquet")
	df10.write.save("python/file1.parquet")
	
	df11 = spark.read.load("python/file7.parquet")
	df11.write.save("python/file8.parquet")
	
	df12 = spark.read.load("python/file8.parquet")
	df12.write.save("python/sample3.parquet")
	
	df13 = spark.read.load("python/sample3.parquet")
	df13.write.save("python/sample4.parquet")
	
	df14 = spark.read.load("python/sample4.parquet")
	df14.write.save("python/sample5.parquet")
	
	df15 = spark.read.load("python/sample5.parquet")
	df15.write.save("python/file7.parquet")
	
	
	
	
	
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    basic_datasource_example(spark)
    spark.stop()