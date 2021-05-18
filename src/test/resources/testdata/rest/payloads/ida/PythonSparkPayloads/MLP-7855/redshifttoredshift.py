from __future__ import print_function
 
from pyspark.sql import SparkSession
from pyspark.sql import Row
 
 
def jdbc_dataset_example(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.employee").option("user", "master").option("password", "Asg-2019").load()
    jdbcDF.write.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.employee1").option("user", "master").option("password", "Asg-2019").save()
     
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_dataset_example(spark)
    spark.stop()