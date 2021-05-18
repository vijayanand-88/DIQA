import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):
  lines = sc.textFile("hdfs:///python/source/commands.txt")
  lines.saveAsTextFile("hdfs:///python/Target/sid/textFile.txt")
  lines1 = sc.textFile("hdfs:///python/source/spark.csv")
  lines1.saveAsTextFile("hdfs:///python/Target1/sid/csvFile.csv")
  lines2 = sc.textFile("hdfs:///python/source1")
  lines2.saveAsTextFile("hdfs:///python/Target2/sid/WholeDirectory.json")
  lines3 = sc.textFile("hdfs:///python/source2")
  lines3.saveAsTextFile("hdfs:///python/Target3")
  

if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
 
