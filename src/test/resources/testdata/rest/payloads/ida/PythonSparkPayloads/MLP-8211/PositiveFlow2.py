from pyspark.sql import SparkSession

#valid,load as csv, save as parquet
def basic_datasource_example2(spark):
	usersDF7 = spark.read.load("hdfs:///pythonA/automation/source1/country.csv",format="csv")
	usersDF7.write.save("hdfs:///pythonA/automation/load/target1/countrytarget")

	usersDF8 = spark.read.load("hdfs:///pythonA/automation/source1/soccer.orc",format="orc")
	usersDF8.write.save("hdfs:///pythonA/automation/load/target1/soccerTarget")
	
	usersDF9 = spark.read.format("parquet").load("hdfs:///pythonA/automation/source1/marathon.parquet")
	usersDF9.write.save("hdfs:///pythonA/automation/load/target1/marathonTarget")
	
	usersDF10 = spark.read.format("csv").load("hdfs:///pythonA/automation/source1/chocolate.csv")
	usersDF10.write.save("hdfs:///pythonA/automation/load/target1/chocolatetarget")
	
	usersDF11 = spark.read.format("orc").load("hdfs:///pythonA/automation/source1/gender.orc")
	usersDF11.write.save("hdfs:///pythonA/automation/load/target1/genderTarget")
	
	usersDF12 = spark.read.load("hdfs:///pythonA/automation/source1/account.parquet")
	usersDF12.write.format("parquet").save("hdfs:///pythonA/automation/load/target1/accountTarget")

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example2").getOrCreate()
    basic_datasource_example2(spark)
    spark.stop()
