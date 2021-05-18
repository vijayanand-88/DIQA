from pyspark.sql import SparkSession

#valid,read as json or orc, write as json or orc
def basic_datasource_testexample1(spark):

#file to Directory combination - file2dir catalog name

	path = "hdfs:///python/sourceVJ01/people.json"
	peopleDF = spark.read.json(path)
	peopleDF.write.json("hdfs:///python/peopleTarget")
	peopleDF.write.orc("hdfs:///python/peopleTarget1")

	path1 = "hdfs:///python/sourceVJ01/shapes.orc"
	peopleDF1 = spark.read.orc(path1)
	peopleDF1.write.orc("hdfs:///python/shapesTarget")
	peopleDF1.write.json("hdfs:///python/shapesTarget1")

	peopleDF2= peopleDF1
	peopleDF2= spark.read.orc(path1)
	peopleDF2.write.json("hdfs:///python/studentTarget")

if __name__ == "__main__":
	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	basic_datasource_testexample1(spark)
	spark.stop()