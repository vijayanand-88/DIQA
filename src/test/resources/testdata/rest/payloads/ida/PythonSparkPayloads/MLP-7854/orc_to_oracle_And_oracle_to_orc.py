from pyspark.sql import SparkSession
from pyspark.sql import Row


def orc_oracle_oraclto_orc_example(spark):
    csvtooracle = spark.read.orc("TestOrcFile.columnProjection.orc")
    csvtooracle.write.format("jdbc").mode('overwrite').option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.ORCTOORACLE").option("user", "testuser").option("password", "admin345").save()
    oracletocsv = spark.read.jdbc("jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C", "COLLECTOR.ORCTOORACLE",properties={"user": "testuser", "password": "admin345","driver": "oracle.jdbc.driver.OracleDriver"})
    oracletocsv.write.orc("/oracletoorc.orc")
   
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    orc_oracle_oraclto_orc_example(spark)
    spark.stop()
