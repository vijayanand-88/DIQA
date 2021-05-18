import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):

  Target ="hdfs:///python/Target/hadoopFile_saveAsHadoopFile_Variable"
  filename = "hdfs:///python/source/Sequence/part-00003"
  lines = sc.hadoopFile(filename,"org.apache.hadoop.mapred.TextInputFormat","org.apache.hadoop.io.Text","org.apache.hadoop.io.LongWritable")
  lines.saveAsHadoopFile(Target,"org.apache.hadoop.mapred.TextOutputFormat","org.apache.hadoop.io.compress.GzipCodec")

if __name__ == "__main__":
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
