import findspark
findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import Row

def columnrenamedfront(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    jdbcDF.withColumnRenamed("FIRST_NAME","FIRSTNAME").write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMP_RENAMED").option("user", "testuser").option("password", "admin345").save()

def columnrenamedback(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    jdbcDF2 = jdbcDF.withColumnRenamed("LAST_NAME","LASTNAME")
    jdbcDF2.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMP_RENAMEDSECONDLINE").option("user", "testuser").option("password", "admin345").save()

def columnrenamedselect(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMPLOYEE_DETAILS").option("user", "testuser").option("password", "admin345").load()
    jdbcDF2 = jdbcDF.select("MANAGER_ID","DEPARTMENT_ID").withColumnRenamed("MANAGER_ID","MANAGERID")
    jdbcDF2.write.format("jdbc").option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.EMP_RENAMEDWITHSELECT").option("user", "testuser").option("password", "admin345").save()

if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    columnrenamedfront(spark)
    columnrenamedback(spark)
    columnrenamedselect(spark)
    spark.stop()