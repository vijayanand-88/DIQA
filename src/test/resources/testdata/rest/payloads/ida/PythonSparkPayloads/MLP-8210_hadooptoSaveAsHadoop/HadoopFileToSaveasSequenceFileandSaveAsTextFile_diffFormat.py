import sys

from pyspark import SparkContext
from pyspark import SparkConf
  # read input text file to RDD
def basic_datasource_example1(sc):
  bucket = "nonamecpp"
  prefix = "dataset.json"
  filename = "hdfs:///python/source/hadoopfileSpecific_to_saveasHadoopformatandTextFile"
  lines = sc.hadoopFile(filename,"org.apache.hadoop.mapred.TextInputFormat","org.apache.hadoop.io.Text","org.apache.hadoop.io.LongWritable")
  lines.saveAsTextFile("hdfs:///python/Target/HadoopFile_to_saveAsTextFile")
  lines.saveAsSequenceFile("hdfs:///python/Target/SequenceFile_multipleRDD")

if __name__ == "__main__":
 
  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Read Text to RDD - Python")
  sc = SparkContext(conf=conf)
  basic_datasource_example1(sc)
