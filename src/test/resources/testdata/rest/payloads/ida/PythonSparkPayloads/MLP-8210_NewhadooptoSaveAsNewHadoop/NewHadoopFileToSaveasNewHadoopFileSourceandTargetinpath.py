import sys

from pyspark import SparkContext
from pyspark import SparkConf

  # read input text file to RDD
def basic_datasource_example1(sc):

  Target ="hdfs:///python/Target/Newhadoopfile_to_SaveAsNewHadoop_pathasVariable"
  filename = "hdfs:///python/source/hadoopfileto_saveAsNewHadopFile3"
  lines = sc.newAPIHadoopFile(filename,"org.apache.hadoop.mapreduce.lib.input.TextInputFormat","org.apache.hadoop.io.Text","org.apache.hadoop.io.LongWritable")
  lines.saveAsNewAPIHadoopFile(Target,"org.apache.hadoop.mapreduce.lib.output.TextOutputFormat","org.apache.hadoop.io.Text","org.apache.hadoop.io.LongWritable")

if __name__ == "__main__":
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
