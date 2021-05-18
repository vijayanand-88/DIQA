import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row

def withColumnfront(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.PEOPLE").option("user", "testuser").option("password", "admin345").load()
    df1=jdbcDF.withColumn("PHONE",jdbcDF.HEIGHT+2)
    df1.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.TABLEPHONEADDED").option("user", "testuser").option("password", "admin345").save()

def withColumnback(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.TEENAGE").option("user", "testuser").option("password", "admin345").load()
    jdbcDF.withColumn("PHONE",jdbcDF.HEIGHT+2).write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.TABLEPHONEADDEDINCHAIN").option("user", "testuser").option("password", "admin345").save()

	
def withColumnselect(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.PEOPLE").option("user", "testuser").option("password", "admin345").load()
    jdbcDF2 = jdbcDF.select("HEIGHT").withColumn("PHONE",jdbcDF.HEIGHT+2)
    jdbcDF2.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.TABLEADDEDALONGWITHNAME").option("user", "testuser").option("password", "admin345").save()

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    withColumnfront(spark)
    withColumnback(spark)
    withColumnselect(spark)
    spark.stop()