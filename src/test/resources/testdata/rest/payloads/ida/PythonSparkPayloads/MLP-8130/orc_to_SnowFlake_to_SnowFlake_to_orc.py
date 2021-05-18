from pyspark.sql import SQLContext 
from pyspark import SparkContext 

def ORC_To_SnowFlake_SnowFlake_To_ORC(spark):
    OrcToSnowFlake = spark.read.orc("TestOrcFile.columnProjection.orc")
    OrcToSnowFlake.write.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.SNOWFLAKETOORACLE").option("user", "SENTHIL").option("password", "Asg-2019").save()
    SnowFlakeToORC = spark.read.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.SNOWFLAKETOORACLE",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})
    SnowFlakeToORC.write.orc("SnowFlaketoorc.orc")
   
if __name__ == "__main__":
       
       spark = SQLContext(sc) 
       ORC_To_SnowFlake_SnowFlake_To_ORC(spark)