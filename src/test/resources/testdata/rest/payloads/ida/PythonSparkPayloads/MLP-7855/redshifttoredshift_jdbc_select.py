from pyspark.sql import SparkSession

def jdbc_redshift_example(spark):

       oracleDF = spark.read.jdbc("jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world", "demo.city",properties={"user": "master", "password": "Asg-2019","driver": "com.amazon.redshift.jdbc.Driver"})
       oracleDF.select("name","countrycode").write.jdbc("jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world", "demo.citywithtwocolumns",properties={"user": "master", "password": "Asg-2019","driver": "com.amazon.redshift.jdbc.Driver"})

if __name__ == "__main__":
       spark = SparkSession.builder.appName("jdbc_api").getOrCreate()
       jdbc_redshift_example(spark)
       spark.stop()