import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):
  bucket = "nonamecpp"
  prefix = "dataset.json"
  filename = "hdfs:///python/source/Sequence/part-00001".format(bucket, prefix)
  lines = sc.hadoopFile(filename,"org.apache.hadoop.mapred.TextInputFormat","org.apache.hadoop.io.Text","org.apache.hadoop.io.DoubleWritable")
  lines.saveAsHadoopFile("hdfs:///python/Target/hadoopfileSpecific_to_saveasHadoopformat","org.apache.hadoop.mapred.TextOutputFormat","org.apache.hadoop.io.compress.GzipCodec")

if __name__ == "__main__":
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
