import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row

def summary_limit_describe_sample_fillna(spark):

    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    df2_forSelect=jdbcDF.alias("df2_forSelect").summary()
    df3=df2_forSelect.select("JOB_ID").limit(2).describe()
    df4=df3.sample(False,0.5,40)
    df5=df4.fillna({'JOB_ID': 2})
    df5.write.mode('overwrite').format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.TABLES_SUMMARY_DESCRIBE_SAMP").option("user", "testuser").option("password", "admin345").save()


if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    summary_limit_describe_sample_fillna(spark)
    spark.stop()
