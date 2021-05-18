import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row


def alias_distinct(spark):

    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    df2_forSelect=jdbcDF.alias("df2_forSelect")
    df3=df2_forSelect.select("JOB_ID").distinct()
    df3.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.UPPERSALARYPEOPLES").option("user", "testuser").option("password", "admin345").save()


if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    alias_distinct(spark)
    spark.stop()
