from pyspark.sql import SparkSession
from pyspark.sql import Row


def json_oracle_oracleto_json_example(spark):
    jsontooracle1 = spark.read.option("multiline", "true").json("hdfs.json")
    jsontooracle1.write.format("jdbc").mode('overwrite').option("url", "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C").option("driver","oracle.jdbc.driver.OracleDriver").option("dbtable", "COLLECTOR.JSONTOORACLE").option("user", "testuser").option("password", "admin345").save()
    oracletojson2 = spark.read.jdbc("jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C", "COLLECTOR.JSONTOORACLES",properties={"user": "testuser", "password": "admin345","driver": "oracle.jdbc.driver.OracleDriver"})
    oracletojson2.write.json("oracletojson.json")
	
if __name__ == "__main__":
    spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
    json_oracle_oracleto_json_example(spark)
    spark.stop()
