from pyspark.sql import SparkSession


#valid,load as csv, save as parquet
def basic_datasource_example3(spark):
	usersDF13 = spark.read.load("hdfs:///pythonA/automation/source1/customer.json",format="json")
	usersDF13.write.save("hdfs:///pythonA/automation/load/target1/customerTarget",format="parquet")
	
	usersDF14 = spark.read.format("json").load("hdfs:///pythonA/automation/source1/people.json")
	usersDF14.write.save("hdfs:///pythonA/automation/load/target1/peopleTarget",format="json")
	
	usersDF15 = spark.read.format("text").load("hdfs:///pythonA/automation/source1/namesAndFavColors.text")
	usersDF15.write.save("hdfs:///pythonA/automation/load/target1/namesAndFavColorsTarget")
	
	usersDF16 = spark.read.load("hdfs:///pythonA/automation/source1/namesAndFavColors.text",format="text")
	usersDF16.write.save("hdfs:///pythonA/automation/load/target1/namesAndFavColorsTarget1",format="text")
	
	usersDF17 = spark.read.load("hdfs:///pythonA/automation/source1/marathon.parquet")
	usersDF17.write.format("orc").save("hdfs:///pythonA/automation/load/target1/shapesTarget1")
	
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example3").getOrCreate()
    basic_datasource_example3(spark)
    spark.stop()
