from pyspark.sql import SparkSession
from pyspark import Row


def CSV_To_SnowFlake(spark):
	csvToSnowFlake = spark.read.csv("spark.csv")
	csvToSnowFlake.write.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.CSVTOSNOWFLAKE").option("user", "SENTHIL").option("password", "Asg-2019").save()

if __name__ == "__main__":

	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	CSV_To_SnowFlake(spark)
	spark.stop()
