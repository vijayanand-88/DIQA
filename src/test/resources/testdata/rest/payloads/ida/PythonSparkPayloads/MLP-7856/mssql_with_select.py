from pyspark.sql import SparkSession

def jdbc_mssql_with_select(spark):

       mssqlDF7 = spark.read.jdbc("jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs", "dbo.titleauthor",properties={"user": "sa", "password": "qwer1234$","driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"})
       mssqlDF7.select("au_id","title_id","au_ord").write.jdbc("jdbc:sqlserver://esbcnprodcap02v.asg.com:1433;databaseName=pubs", "dbo.titleauthor_created",properties={"user": "sa", "password": "qwer1234$","driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"})

if __name__ == "__main__":
       spark = SparkSession.builder.appName("jdbc_api").getOrCreate()
       jdbc_mssql_with_select(spark)
       spark.stop()