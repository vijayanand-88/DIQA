from pyspark.sql import SparkSession

#valid,read as json or orc, write as json or orc
def basic_datasource_testexample(spark):

#file to Directory combination - file2dir catalog name
	
	path = "hdfs:///python/sourceVJ02/people.json" 
	peopleDF = spark.read.json(path)
	peopleDF.write.json("hdfs:///python/peopleTargetneg")
	peopleDF.write.orc("hdfs:///python/peopleTarget1neg")

	
if __name__ == "__main__":
	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	basic_datasource_testexample(spark)
	spark.stop()