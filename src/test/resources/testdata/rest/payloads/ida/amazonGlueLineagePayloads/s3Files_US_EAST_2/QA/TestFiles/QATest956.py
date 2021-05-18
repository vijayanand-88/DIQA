#Validation for SQLServer RDS End to End Lineage (Glue table to Glue Table)
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
## @args: [database = "sqlserver_rds", table_name = "adventureworks_acc_useraccount", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "accounts_rds", table_name = "adventureworks_acc_useraccount", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("password", "string", "password", "string"), ("user_id", "int", "user_id", "int"), ("created_on", "string", "created_on", "string"), ("last_login", "string", "last_login", "string"), ("email", "string", "email", "string"), ("username", "string", "username", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("password", "string", "password", "string"), ("user_id", "int", "user_id", "int"), ("created_on", "string", "created_on", "string"), ("last_login", "string", "last_login", "string"), ("email", "string", "email", "string"), ("username", "string", "username", "string")], transformation_ctx = "applymapping1")
## @type: SelectFields
## @args: [paths = ["password", "user_id", "created_on", "last_login", "email", "username"], transformation_ctx = "selectfields2"]
## @return: selectfields2
## @inputs: [frame = applymapping1]
selectfields2 = SelectFields.apply(frame = applymapping1, paths = ["password", "user_id", "created_on", "last_login", "email", "username"], transformation_ctx = "selectfields2")
## @type: ResolveChoice
## @args: [choice = "MATCH_CATALOG", database = "sqlserver_rds", table_name = "adventureworks_acc_useraccount_bkp", transformation_ctx = "resolvechoice3"]
## @return: resolvechoice3
## @inputs: [frame = selectfields2]
datasink5 = glueContext.write_dynamic_frame.from_catalog(frame = selectfields2, database = "accounts_rds", table_name = "adventureworks_acc_useraccount_bkp", transformation_ctx = "datasink5")
job.commit()