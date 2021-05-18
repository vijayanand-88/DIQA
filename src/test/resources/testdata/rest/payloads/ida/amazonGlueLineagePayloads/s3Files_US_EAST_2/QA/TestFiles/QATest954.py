#Validation for Postgres RDS End to End Lineage
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

datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "accounts_rds", table_name = "dvdrental_accounts_rds", transformation_ctx = "datasource0")

datasink2 = glueContext.write_dynamic_frame.from_options(frame = datasource0, connection_type = "s3", connection_options = {"path": "s3://asg-qa-glue-lineage-rds/QA/Output/postgres_rds_out/csv_format"}, format = "csv", transformation_ctx = "datasink2")
# datasink2 = glueContext.write_dynamic_frame.from_options(frame = applymapping1, connection_type = "s3", connection_options = {"path": "s3://asg-qa-glue-linker-rds/Output/postgres_out/csv_format"}, format = "csv", transformation_ctx = "datasink2")
job.commit()