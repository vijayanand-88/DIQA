import sys

from pyspark import SparkContext

if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf)
  basic_datasource_example2(sc)
 
  # read input text file to RDD
def basic_datasource_example2(sc):
  lines = sc.textFile("hdfs:///python/source/commands1.txt")
  lines.saveAsTextFile("hdfs:///python/Target/textFile.txt")
  lines1 = sc.textFile("hdfs:///python/source4")
  lines1.saveAsTextFile("hdfs:///python/Target9/csvFile.csv")
  
