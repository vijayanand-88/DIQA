from pyspark.sql import SQLContext 
from pyspark import SparkContext 

def jdbc_SFtoSF_JDBC_Select_example(spark):

       SF_to_SF_jdbc = spark.read.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.CUSTOMERS",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})
       SF_to_SF_jdbc.select("NAME","AGE","ID").write.jdbc("jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB", "TESTSCHEMA.CUSTOMERS_MANY",properties={"user": "SENTHIL", "password": "Asg-2019","driver": "net.snowflake.client.jdbc.SnowflakeDriver"})

if __name__ == "__main__":
       
       spark = SQLContext(sc) 
       jdbc_SFtoSF_JDBC_Select_example(spark)