from pyspark.sql import SparkSession
from pyspark import Row

def jdbc_SFtoParquet_JDBC_example(spark):
	SF_To_Parquet = spark.read.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.EMPLOYEE_DATA_FOR_PARQUET",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})
	SF_To_Parquet.write.parquet("SnowFlaketoparquetfile.parquet")

if __name__ == "__main__":

	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	jdbc_SFtoParquet_JDBC_example(spark)
	spark.stop()