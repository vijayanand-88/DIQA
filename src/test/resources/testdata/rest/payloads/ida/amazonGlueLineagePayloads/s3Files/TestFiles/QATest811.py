import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

def filter_sex(item):
    if item['sex'] == 'Male':
        return True
    else:
        return False

## @params: [JOB_NAME]
## Validation of Filter API
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

connection_s3_options = {
	"paths": ["s3://asgqatestautomation3/SourceFiles/Source811/AMSSurvey"]
}

datasource0 = glueContext.create_dynamic_frame.from_options("s3",connection_s3_options,format="csv",format_options={"withHeader":True,"separator":","})

filter11frame = Filter.apply(frame=datasource0, f=lambda x:x['citizen'] in ["US"])

filter21frame = Filter.apply(frame=datasource0, f=lambda x:x['count'] > 50)

filter31frame = Filter.apply(frame=datasource0, f=filter_sex)


filter11_op = glueContext.write_dynamic_frame.from_options(frame = filter11frame, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target811/filter11_op"}, format = "csv", transformation_ctx = "filter11_op")
filter21_op = glueContext.write_dynamic_frame.from_options(frame = filter21frame, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target811/filter21_op"}, format = "csv", transformation_ctx = "filter21_op")
filter31_op = glueContext.write_dynamic_frame.from_options(frame = filter31frame, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target811/filter31_op"}, format = "csv", transformation_ctx = "filter31_op")
job.commit()