import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):
  source ="hdfs:///python/source/Hadoopformat"
  Target ="hdfs:///python/Target/SequenceFile_to_NewHadoopformat1"
  lines = sc.sequenceFile(source)
  lines.saveAsNewAPIHadoopFile(Target,"org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat","org.apache.hadoop.io.IntWritable","org.apache.hadoop.io.Text")
if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
