from __future__ import print_function

from pyspark.sql import SparkSession
from pyspark.sql import Row


def jdbc_mssql_multiple_write(spark):
    mssqlDF3 = spark.read.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.jobs").option("user", "sa").option("password", "qwer1234$").load()
    mssqlDF3.filter(mssqlDF3.min_lvl<50).select("job_id","job_desc","min_lvl").write.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.jobs_min").option("user", "sa").option("password", "qwer1234$").save()
    mssqlDF3.select("job_id","job_desc").write.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.jobs_onlytwocolumns").option("user", "sa").option("password", "qwer1234$").save()
    mssqlDF3_m2 = spark.read.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.publishers").option("user", "sa").option("password", "qwer1234$").load()
    mssqlDF3_m2.filter(mssqlDF3_m2.country=='USA').write.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.jobs_all").option("user", "sa").option("password", "qwer1234$").save()
    
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_mssql_multiple_write(spark)
    spark.stop()