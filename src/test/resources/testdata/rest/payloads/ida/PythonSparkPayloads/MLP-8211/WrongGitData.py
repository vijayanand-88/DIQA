from pyspark.sql import SparkSession

#valid,load as csv, save as parquet
def basic_datasource_exampleWrongGit(spark):

	usersDF18= spark.read.load("hdfs:///pythonA/automation/source1/city1.csv",format="csv")
	usersDF18.write.save("hdfs:///pythonA/automation/load/target1/citytarget1",format="csv")

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source exampleWrongGit").getOrCreate()
    basic_datasource_exampleWrongGit(spark)
    spark.stop()
