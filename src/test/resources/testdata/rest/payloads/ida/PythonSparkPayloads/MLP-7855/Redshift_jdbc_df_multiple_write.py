from __future__ import print_function

from pyspark.sql import SparkSession
from pyspark.sql import Row


def jdbc_dataset_example1(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.users").option("user", "master").option("password", "Asg-2019").load()
    jdbcDF.select("name","gender","email").write.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.users_created").option("user", "master").option("password", "Asg-2019").save()
    jdbcDF.select("gender","email").write.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.users_onlytwocolumns").option("user", "master").option("password", "Asg-2019").save()
    jdbcDF1 = spark.read.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.employee").option("user", "master").option("password", "Asg-2019").load()
    jdbcDF1.write.format("jdbc").option("url", "jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world").option("driver","com.amazon.redshift.jdbc.Driver").option("dbtable", "demo.employee_underage").option("user", "master").option("password", "Asg-2019").save()

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_dataset_example1(spark)
    spark.stop()