import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.dynamicframe import DynamicFrame
from awsglue.job import Job
from pyspark.sql import SparkSession
from pyspark.sql.functions import udf
from pyspark.sql.types import StringType



def processMain():
    ## @params: [JOB_NAME]
    glueContext = GlueContext(SparkContext.getOrCreate())
    spark = glueContext.spark_session

    ds0 = glueContext.create_dynamic_frame.from_catalog(database="autoglues3lineage", table_name="train_sm_s2adb_csv", transformation_ctx="ds0")


    ds3 = ds0.toDF()
    ds3.createOrReplaceTempView("train_sm_s2adb_csv_temp")
    ds4 = spark.sql("SELECT * FROM train_sm_s2adb_csv_temp WHERE age > 30")
    ds5 = DynamicFrame.fromDF(ds4, glueContext, "ds5")


    ds6 = glueContext.write_dynamic_frame.from_options(frame=ds5, connection_type="redshift",
                                                             connection_options={
                                                                 "url": "jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world",
                                                                 "dbtable": "atn.Nogluetable"},
                                                             transformation_ctx="ds6")



processMain()
