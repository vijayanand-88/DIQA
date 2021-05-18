from pyspark.sql import SparkSession

#valid,load as csv, save as parquet
def basic_datasource_example1(spark):
	usersDF = spark.read.load("hdfs:///pythonA/automation/source1/emp.csv",format="csv")
	usersDF.write.save("hdfs:///pythonA/automation/load/target1/empTarget",format="parquet")
	
	usersDF2 = spark.read.load("hdfs:///pythonA/automation/source1/students.orc",format="orc")
	usersDF2.write.save("hdfs:///pythonA/automation/load/target1/studentsTarget",format="parquet")
	
	usersDF3= spark.read.load("hdfs:///pythonA/automation/source1/city.csv",format="csv")
	usersDF3.write.save("hdfs:///pythonA/automation/load/target1/citytarget",format="csv")
	
	usersDF4 = spark.read.load("hdfs:///pythonA/automation/source1/shapes.orc",format="orc")
	usersDF4.write.save("hdfs:///pythonA/automation/load/target1/shapesTarget",format="orc")
	
	usersDF5 = spark.read.load("hdfs:///pythonA/automation/source1/system.parquet")
	usersDF5.write.save("hdfs:///pythonA/automation/load/target1/systemTarget")
	
	usersDF6 = spark.read.load("hdfs:///pythonA/automation/source1/rubiks.parquet",format="parquet")
	usersDF6.write.save("hdfs:///pythonA/automation/load/target1/rubiksTarget")
	
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example1").getOrCreate()
    basic_datasource_example1(spark)
    spark.stop()
