from pyspark.sql import SparkSession
from pyspark import Row

def jdbc_SFtoSF_JDBC_Select_example(spark):

	SF_to_SF_jdbc = spark.read.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.CUSTOMERS",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})
	SF_to_SF_jdbc.select("NAME","AGE","ID").write.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.CUSTOMERS_MANY",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})

if __name__ == "__main__":

	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	jdbc_SFtoSF_JDBC_Select_example(spark)
	spark.stop()