import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):
  lines = sc.sequenceFile("hdfs:///python/source/Sequence/part-00000","org.apache.hadoop.io.Text", "org.apache.hadoop.io.DoubleWritable")
  lines.saveAsSequenceFile("hdfs:///python/Target/SequenceFile_diffArgs")

if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
