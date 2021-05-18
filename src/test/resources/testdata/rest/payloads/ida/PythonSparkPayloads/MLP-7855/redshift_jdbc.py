from pyspark.sql import SparkSession

def redshift_example(spark):

       df = spark.read.jdbc("jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world", "demo.city",properties={"user": "master", "password": "Asg-2019","driver": "com.amazon.redshift.jdbc.Driver"})
       df.write.jdbc("jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world", "demo.city_created",properties={"user": "master", "password": "Asg-2019","driver": "com.amazon.redshift.jdbc.Driver"})

if __name__ == "__main__":
       spark = SparkSession.builder.appName("jdbc_api").getOrCreate()
       redshift_example(spark)
       spark.stop()
