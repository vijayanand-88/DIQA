from pyspark.sql import SparkSession

def jdbc_oracle_example1(spark):

       oracleDF = spark.read.jdbc("jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C", "COLLECTOR.UPPERSALARYPEOPLES_3COLUMNS",properties={"user": "testuser", "password": "admin345","driver": "oracle.jdbc.driver.OracleDriver"})
       oracleDF.select("FIRST_NAME","LAST_NAME","EMAIL").write.jdbc("jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C", "COLLECTOR.UPPERSALARYPEOPLES_NOFILTER",properties={"user": "testuser", "password": "admin345","driver": "oracle.jdbc.driver.OracleDriver"})

if __name__ == "__main__":
       spark = SparkSession.builder.appName("jdbc_api").getOrCreate()
       jdbc_oracle_example1(spark)
       spark.stop()