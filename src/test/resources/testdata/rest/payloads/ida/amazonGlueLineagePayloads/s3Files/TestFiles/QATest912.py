#Validation of MapToCollection Api
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

def add_ten(frame,transformation_ctx):
    frame1 = RenameField.apply(frame =frame, old_name = "y", new_name = "young_new")
    mapToColf0_op = glueContext.write_dynamic_frame.from_options(frame = frame1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target912/mapToColf0OP"}, format = "csv", transformation_ctx = "mapToColf0_op")
    frame2 = RenameField.apply (frame =frame1, old_name = "young_new", new_name = "young_new1")
    return frame2

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

connection_s3_options3 = {
	"paths": ["s3://asgqatestautomation4/SourceFiles/Source812/AIDS/aids.csv"]
}

datasource0 = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options3, format="csv", format_options={  "withHeader": True, "separator": "," }, transformation_ctx="datasource0")

split1 = SplitRows.apply(datasource0, {"snno": {">": 5}}, "split11", "split12", transformation_ctx ="split1")## @type: SplitRows

test = add_ten

mapToColf1 = MapToCollection.apply(dfc = split1, callable = test, transformation_ctx = "mapToColf1")

mapToColf1_op = glueContext.write_dynamic_frame.from_options(frame = mapToColf1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target912/mapToColf1OP"}, format = "csv", transformation_ctx = "mapToColf1_op")

job.commit()