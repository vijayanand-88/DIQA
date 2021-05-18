from pyspark.sql import SQLContext 
from pyspark import SparkContext 

def jdbc_ParquettoSF_JDBC_example(spark):
    Parq_To_SF = spark.read.parquet("userdata1.parquet")
    Parq_To_SF.write.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.PARQUETTOSNOWFLAKE").option("user", "SENTHIL").option("password", "Asg-2019").save()
    
if __name__ == "__main__":
       
       spark = SQLContext(sc) 
       jdbc_ParquettoSF_JDBC_example(spark)