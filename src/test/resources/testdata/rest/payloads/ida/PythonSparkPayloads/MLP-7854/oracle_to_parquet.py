from pyspark.sql import SparkSession
from pyspark.sql import Row


def oracle_toparquet_example(spark):
    oracletocsv = spark.read.jdbc("jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C", "COLLECTOR.UPPERSALARYPEOPLES_3COLUMNS",properties={"user": "testuser", "password": "admin345","driver": "oracle.jdbc.driver.OracleDriver"})
    oracletocsv.write.parquet("/oracletoparquetfile.parquet")

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    oracle_toparquet_example(spark)
    spark.stop()
