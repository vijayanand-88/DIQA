from __future__ import print_function
 
from pyspark.sql import SparkSession
from pyspark.sql import Row
 
 
def jdbc_dataset_example(spark):
    oracleDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    oracleDF.filter(oracleDF.SALARY>15000).select("FIRST_NAME","LAST_NAME","EMAIL").write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.UPPERSALARYPEOPLES_3COLUMNS").option("user", "testuser").option("password", "admin345").save()
     
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    jdbc_dataset_example(spark)
    spark.stop()