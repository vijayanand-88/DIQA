from pyspark.sql import SparkSession

def jdbc_mssql_jdbc_api(spark):

       mssqlDF2 = spark.read.jdbc("jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs", "dbo.titles",properties={"user": "sa", "password": "qwer1234$","driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"})
       mssqlDF2.write.jdbc("jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs", "dbo.business_tag",properties={"user": "sa", "password": "qwer1234$","driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"})

if __name__ == "__main__":
       spark = SparkSession.builder.appName("jdbc_api").getOrCreate()
       jdbc_mssql_jdbc_api(spark)
       spark.stop()