from pyspark.sql import SparkSession
from pyspark import Row

def jdbc_SFtoCSV_JDBC_example(spark):
	SF_To_CSV = spark.read.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.EMPLOYEE_DATA_FOR_CSV",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})
	SF_To_CSV.write.csv("SnowFlaketocsvfile.csv")

if __name__ == "__main__":

	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	jdbc_SFtoCSV_JDBC_example(spark)
	spark.stop()