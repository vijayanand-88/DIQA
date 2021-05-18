from pyspark.sql import SparkSession
from pyspark.sql import Row


def parquet_oracle_example(spark):
    parqtooracle = spark.read.parquet("userdata1.parquet")
    parqtooracle.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.PARQUETTOORACLE").option("user", "testuser").option("password", "admin345").save()
    
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    parquet_oracle_example(spark)
    spark.stop()
