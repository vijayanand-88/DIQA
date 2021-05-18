import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
glueContext = GlueContext(SparkContext.getOrCreate())

titanic = glueContext.create_dynamic_frame.from_catalog(
    database="sourcedb512",
    table_name="titanic_table", transformation_ctx="titanic")

titanic1 = RenameField.apply(frame=titanic, old_name="passengerid", new_name="passid")

titanic2 = RenameField.apply(frame=titanic1, old_name="fare", new_name="faredollars")

titanic3 = RenameField.apply(frame=glueContext.create_dynamic_frame.from_catalog(
     database="sourcedb512",
     table_name="titanic_table", transformation_ctx="titanic"), old_name="age", new_name="ageinyears")


titanic2_op = glueContext.write_dynamic_frame.from_options(frame=titanic2, connection_type="s3",
                                                          connection_options={
                                                              "path": "s3://asgqatestautomation4/TargetFiles/Target512/Titanic2"},
                                                          format="csv", transformation_ctx="titanic2_op")

titanic3_op = glueContext.write_dynamic_frame.from_options(frame=titanic3, connection_type="s3",
                                                            connection_options={
                                                                "path": "s3://asgqatestautomation4/TargetFiles/Target512/Titanic3"},
                                                            format="csv", transformation_ctx="titanic3_op")
