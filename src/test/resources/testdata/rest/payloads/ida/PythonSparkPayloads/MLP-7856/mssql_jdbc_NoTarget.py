from pyspark.sql import SparkSession

def jdbc_mssql_NoTarget(spark):

       mssqlDF4 = spark.read.jdbc("jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs", "dbo.titles",properties={"user": "sa", "password": "qwer1234$","driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"})
       mssqlDF4.write.jdbc("jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs", "dbo.business_tag1",properties={"user": "sa", "password": "qwer1234$","driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"})

if __name__ == "__main__":
       spark = SparkSession.builder.appName("jdbc_api").getOrCreate()
       jdbc_mssql_NoTarget(spark)
       spark.stop()