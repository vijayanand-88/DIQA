#Lineage Verification where source is S3 and Target is Actual Table present in SQLServerDB, PostgreSQL, Oracle RDS in USEAST2 Region

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [TempDir, JOB_NAME]
args = getResolvedOptions(sys.argv, ['TempDir','JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)



connection_s3_options3 = {
	"paths": ["s3://asg-qa-glue-lineage-rds/QA/Input/PastHires.csv"]
}

datasource0 = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options3, format="csv", format_options={  "withHeader": True, "separator": "," }, transformation_ctx="datasource0")



dropnullfields1 = DropNullFields.apply(frame = datasource0, transformation_ctx = "dropnullfields1")

datasink4 = glueContext.write_dynamic_frame.from_jdbc_conf(frame = dropnullfields1, catalog_connection = "oracle19connection", connection_options = {"dbtable": "past_hires_orc_target", "database": "orcl"}, transformation_ctx = "datasink4")

datasink5 = glueContext.write_dynamic_frame.from_jdbc_conf(frame = dropnullfields1, catalog_connection = "sqlserver2019", connection_options = {"dbtable": "past_hires_sqlsvr_target", "database": "adventureworks"}, transformation_ctx = "datasink5")

datasink6 = glueContext.write_dynamic_frame.from_jdbc_conf(frame = dropnullfields1, catalog_connection = "RDS-PostgreSQL", connection_options = {"dbtable": "past_hires_pstgr_target", "database": "dvdrental"}, transformation_ctx = "datasink6")

job.commit()