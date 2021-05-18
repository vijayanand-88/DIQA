from __future__ import print_function

from pyspark.sql import SparkSession
from pyspark.sql import Row


def jdbc_mssql_format_NoSourceandTarget(spark):
    mssqlDF1 = spark.read.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.EMPLOYEE1").option("user", "sa").option("password", "qwer1234$").load()
    mssqlDF1.filter(mssqlDF1.AGE>18).select("NAME","AGE","EMPID").write.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.EMPLOYEE2").option("user", "sa").option("password", "qwer1234$").save()
    
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_mssql_format_NoSourceandTarget(spark)
    spark.stop()