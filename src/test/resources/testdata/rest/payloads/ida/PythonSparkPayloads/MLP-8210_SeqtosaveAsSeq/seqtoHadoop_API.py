import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):
  lines = sc.sequenceFile("hdfs:///python/source/Sequence")
  lines.saveAsHadoopFile("hdfs:///python/Target/SequenceFile_to_Hadoopformat","org.apache.hadoop.mapred.TextOutputFormat","org.apache.hadoop.io.compress.GzipCodec")

if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
