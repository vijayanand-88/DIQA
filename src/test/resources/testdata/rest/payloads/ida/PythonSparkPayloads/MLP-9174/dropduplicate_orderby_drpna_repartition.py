import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row


def drop_duplicates_dropna_orderBy_repartition(spark):

    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    df2_forSelect=jdbcDF.alias("df2_forSelect")
    df3=df2_forSelect.drop_duplicates()
    df4=df3.dropna()
    df5=df4.orderBy("MANAGER_ID")
    df6=df5.repartition(1)
    df6.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.DROP_ORDERBY").option("user", "testuser").option("password", "admin345").save()


if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    drop_duplicates_dropna_orderBy_repartition(spark)
    spark.stop()