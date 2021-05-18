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
## @args: [database = "sourcedb611", table_name = "titanic611table", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "sourcedb611", table_name = "titanic611table", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("passengerid", "long", "passengerid", "long"), ("city", "string", "city", "string"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "double"), ("sex", "string", "sex", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("passengerid", "long", "passengerid", "long"), ("city", "string", "city", "string"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "double"), ("sex", "string", "sex", "string")], transformation_ctx = "applymapping1")


applymapping2 = ApplyMapping.apply(frame = datasource0, mappings = [("passengerid", "long", "passengerid1", "long"), ("city", "string", "city", "string"), ("age", "long", "age1", "long"), ("ticket", "string", "ticket1", "string"), ("fare", "double", "fare1", "double"), ("sex", "string", "sex1", "string")], transformation_ctx = "applymapping2")


## @type: DropFields
## @args: [paths = [<paths>], transformation_ctx = "<transformation_ctx>"]
## @return: <output>
## @inputs: [frame = <frame>]
dropfields1 = DropFields.apply(frame = datasource0, paths = ["passengerid","age"], transformation_ctx = "dropfields1")

dropfields2 = DropFields.apply(frame = dropfields1, paths = ["city"], transformation_ctx = "dropfields2")

## @type: SelectFields
## @args: [paths = ["paths"], transformation_ctx = "<transformation_ctx>"]
## @return: <output>
## @inputs: [frame = <frame>]
selectfields1 = SelectFields.apply(frame = datasource0, paths = ["ticket","fare","sex"], transformation_ctx = "selectfields1")

selectfields2 = SelectFields.apply(frame = selectfields1, paths = ["ticket"], transformation_ctx = "selectfields2")


## @type: DataSink
## @args: [connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611"}, format = "json", transformation_ctx = "datasink2"]
## @return: datasink2
## @inputs: [frame = applymapping1]
appm1_op = glueContext.write_dynamic_frame.from_options(frame = applymapping1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611/AppMap1Op"}, format = "csv", transformation_ctx = "appm1_op")

appm2_op = glueContext.write_dynamic_frame.from_options(frame = applymapping2, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611/AppMap2Op"}, format = "csv", transformation_ctx = "appm2_op")


dropfields1_op = glueContext.write_dynamic_frame.from_options(frame = dropfields1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611/Drop1Op"}, format = "csv", transformation_ctx = "dropfields1_op")

dropfields2_op = glueContext.write_dynamic_frame.from_options(frame = dropfields2, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611/Drop2Op"}, format = "csv", transformation_ctx = "dropfields2_op")

selectfields1_op = glueContext.write_dynamic_frame.from_options(frame = selectfields1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611/Select1Op"}, format = "csv", transformation_ctx = "selectfields1_op")

selectfields2_op = glueContext.write_dynamic_frame.from_options(frame = selectfields2, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target611/Select2Op"}, format = "csv", transformation_ctx = "selectfields2_op")



job.commit()