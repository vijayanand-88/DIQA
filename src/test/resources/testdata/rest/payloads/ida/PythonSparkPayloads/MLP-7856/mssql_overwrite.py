from __future__ import print_function
 
from pyspark.sql import SparkSession
from pyspark.sql import Row
 
 
def jdbc_mssql_overwrite(spark):
    mssqlDF5 = spark.read.format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.authors").option("user", "sa").option("password", "qwer1234$").load()
    mssqlDF5.filter(mssqlDF5.state=='CA').write.mode('overwrite').format("jdbc").option("url", "jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs").option("driver","com.microsoft.sqlserver.jdbc.SQLServerDriver").option("dbtable", "dbo.canada_author").option("user", "sa").option("password", "qwer1234$").save()
     
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_mssql_overwrite(spark)
    spark.stop()