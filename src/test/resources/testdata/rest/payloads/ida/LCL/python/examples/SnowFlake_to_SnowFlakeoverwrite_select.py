from pyspark.sql import SQLContext 
from pyspark import SparkContext 
 
 
def jdbc_SFtoSF_Overwrite_example(spark):
    SFtoSF_DF = spark.read.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.CUSTOMERS").option("user", "SENTHIL").option("password", "Asg-2019").load()
    SFtoSF_DF.filter(SFtoSF_DF.AGE>30).select("NAME","AGE","ID").write.mode('overwrite').format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.NEW_CUSTOMERS").option("user", "SENTHIL").option("password", "Asg-2019").save()
     
if __name__ == "__main__":
       
    spark = SQLContext(sc) 
    jdbc_SFtoSF_Overwrite_example(spark)