from __future__ import print_function
 
from pyspark.sql import SparkSession
from pyspark.sql import Row
 
 
def jdbc_dataset_redshift_example(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.users").option("user", "master").option("password", "Asg-2019").load()
    jdbcDF.filter(jdbcDF.gender=="Male").select("name").write.mode('overwrite').format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.users_created").option("user", "master").option("password", "Asg-2019").save()
     
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_dataset_redshift_example(spark)
    spark.stop()