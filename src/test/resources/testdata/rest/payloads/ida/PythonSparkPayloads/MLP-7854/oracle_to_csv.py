from pyspark.sql import SparkSession
from pyspark.sql import Row


def oracle_tocsv_example(spark):
    oracletocsv = spark.read.jdbc("jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C", "COLLECTOR.PARQUETTOORACLE",properties={"user": "testuser", "password": "admin345","driver": "oracle.jdbc.driver.OracleDriver"})
    oracletocsv.write.csv("/oracletocsvfile.csv")

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    oracle_tocsv_example(spark)
    spark.stop()
