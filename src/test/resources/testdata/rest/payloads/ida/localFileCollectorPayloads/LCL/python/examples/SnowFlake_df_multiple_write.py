from pyspark.sql import SQLContext 
from pyspark import SparkContext 
 


def jdbc_SFtoSF_multiple_write_example(spark):
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.STUDENT").option("user", "SENTHIL").option("password", "Asg-2019").load()
    jdbcDF.select("STUDENTID","NAME").write.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.STUDENT_TWOCOLUMNS").option("user", "SENTHIL").option("password", "Asg-2019").save()
    jdbcDF.select("ADDRESS").write.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.STUDENT_ONECOLUMN").option("user", "SENTHIL").option("password", "Asg-2019").save()
    jdbcDF = spark.read.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.EMPLOYEE_DATA").option("user", "SENTHIL").option("password", "Asg-2019").load()
    jdbcDF.filter(jdbcDF.GENDER=='M').write.format("jdbc").option("url", "jdbc:snowflake://asg_partner.us-east-1.snowflakecomputing.com/?warehouse=DEMO_WH&db=TEST_DB").option("driver","net.snowflake.client.jdbc.SnowflakeDriver").option("dbtable", "TESTSCHEMA.EMPLOYEE_DATA_GENDER_FILTER").option("user", "SENTHIL").option("password", "Asg-2019").save()
    
if __name__ == "__main__":
       
    spark = SQLContext(sc) 
    jdbc_SFtoSF_multiple_write_example(spark)