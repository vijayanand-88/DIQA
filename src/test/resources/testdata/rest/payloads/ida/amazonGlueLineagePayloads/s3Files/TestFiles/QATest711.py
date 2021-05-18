import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
## @type: DataSource
## @args: [database = "sourcedb777", table_name = "titanic611table", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "autoglues3lineage", table_name = "train_sm_s2adb_csv", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("passengerid", "long", "passengerid", "long"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "double"), ("sex", "string", "sex", "string"), ("city", "string", "city", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
split1 = SplitRows.apply(datasource0, {"age": {">": 20}}, "split11", "split12", transformation_ctx ="split1")## @type: SplitRows
## @args: [comparison_dict = <comparison_dict>, transformation_ctx = "<transformation_ctx>"]
## @return: <output>
## @inputs: [frame = <frame>]
# <output> = SplitRows.apply(frame = <frame>, comparison_dict = <comparison_dict>, transformation_ctx = "<transformation_ctx>")


split2 = SplitRows.apply(datasource0,  {"age": {">": 20, "<": 30}}, "split21", "split22", transformation_ctx ="split2")

split3 = SplitRows.apply(datasource0,  {"age": {">": 20, "<": 30}}, transformation_ctx ="split3")

split1_op = glueContext.write_dynamic_frame.from_options(frame = split1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target711/split1_op1"}, format = "csv", transformation_ctx = "split1_op")
split21_op = glueContext.write_dynamic_frame.from_options(frame = split2['split21'], connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target711/split21_op1"}, format = "csv", transformation_ctx = "split21_op")
split22_op = glueContext.write_dynamic_frame.from_options(frame = split2['split22'], connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target711/split22_op1"}, format = "csv", transformation_ctx = "split22_op")
split3_op = glueContext.write_dynamic_frame.from_options(frame = split3, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target711/split3_op1"}, format = "csv", transformation_ctx = "split3_op")


# applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("passengerid", "long", "passengerid", "long"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "double"), ("sex", "string", "sex", "string"), ("city", "string", "city", "string")], transformation_ctx = "applymapping1")
# ## @type: DataSink
# ## @args: [connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles"}, format = "csv", transformation_ctx = "datasink2"]
# ## @return: datasink2
# ## @inputs: [frame = applymapping1]
# datasink2 = glueContext.write_dynamic_frame.from_options(frame = applymapping1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles"}, format = "csv", transformation_ctx = "datasink2")
job.commit()