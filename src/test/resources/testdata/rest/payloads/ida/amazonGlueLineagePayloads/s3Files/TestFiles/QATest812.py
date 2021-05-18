##This file is meant for Automation for Map API
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

def add_ten(rec):
    rec["snno"]=rec["snno"]+10
    rec["year"]=rec["y"]
    del rec["quarter"]
    del rec["delay"]
    del rec["dud"]
    del rec["time"]
    del rec["y"]
    return rec

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

connection_s3_options1 = {
	"paths": ["s3://asgqatestautomation4/SourceFiles/Source812/AIDS/aids.csv","s3://asgqatestautomation4/SourceFiles/Source812/AIDS/aids1.csv"]
}

datasource0 = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options1, format="csv", format_options={  "withHeader": True, "separator": "," }, transformation_ctx="datasource0")
# datasource0 = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options1, format="csv")



mapframe812 = Map.apply(frame = datasource0, f = add_ten, transformation_ctx = "mapframe812")

#datasource0_op = glueContext.write_dynamic_frame.from_options(frame = datasource0, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation3/SourceFiles/datasource0OP"}, format = "csv", transformation_ctx = "datasource0_op")
mapframe812_op = glueContext.write_dynamic_frame.from_options(frame = mapframe812, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target812/mapframe812OP"}, format = "csv", transformation_ctx = "mapframe812_op")
job.commit()