#Validation of Relationalize and Unbox API
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# # @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

connection_options = {
    "url": "jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world",
    "dbtable": "atn.gluetable911",
    "user": "master",
    "password": "Asg-2019",
    "redshiftTmpDir": args["TempDir"]
}
world_frame = glueContext.create_dynamic_frame.from_options("redshift", connection_options)

unbox_transform = Unbox.apply(frame = world_frame, path = "address", format="json", transformation_ctx = "unbox_transform")

relationalize_transform = Relationalize.apply(frame = unbox_transform, staging_path = "s3://asgredshiftworlddata/City_Details/", name = "city_root_table", transformation_ctx = "relationalize_transform")

complete_data = glueContext.write_dynamic_frame.from_options(frame=relationalize_transform, connection_type="s3",
                                                             connection_options={
                                                                 "path": "s3://asgqatestautomation4/TargetFiles/Target911/"},
                                                             format="json", transformation_ctx="complete_data")

job.commit()


