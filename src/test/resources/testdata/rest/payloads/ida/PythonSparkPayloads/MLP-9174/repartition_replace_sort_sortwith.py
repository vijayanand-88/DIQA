import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row


def repartitionByrange_replace_sort_sortwithpartitions(spark):

    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    df2_forSelect=jdbcDF.alias("df2_forSelect")
    df3=df2_forSelect.repartitionByRange(10000,"SALARY")
    df4=df3.replace(['Steven','Neena'],['Siddharthan','Devi'],'FIRST_NAME')
    df5=df4.sort("SALARY")
    df6=df5.sortWithinPartitions("FIRST_NAME",ascending=False)
    df6.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.LASTPARTITION").option("user", "testuser").option("password", "admin345").save()


if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    repartitionByrange_replace_sort_sortwithpartitions(spark)
    spark.stop()