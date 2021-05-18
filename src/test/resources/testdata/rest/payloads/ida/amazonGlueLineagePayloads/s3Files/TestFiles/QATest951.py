#Validation of Glue Linker End to End for S3 (CSV) and Redshift DataSources
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
## @args: [database = "aidsdb", table_name = "aids", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "linkersourcedb", table_name = "aids2", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("snno", "long", "snno", "long"), ("year", "long", "year", "long"), ("quarter", "long", "quarter", "long"), ("delay", "long", "delay", "long"), ("dud", "long", "dud", "long"), ("time", "long", "time", "long"), ("y", "long", "y", "long")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("snno", "long", "snno", "long"), ("year", "long", "year", "long"), ("quarter", "long", "quarter", "long"), ("delay", "long", "delay", "long"), ("dud", "long", "dud", "long"), ("time", "long", "time", "long"), ("y", "long", "y", "long")], transformation_ctx = "applymapping1")
## @type: SelectFields
## @args: [paths = ["snno", "year", "quarter", "delay", "dud", "time", "y"], transformation_ctx = "selectfields2"]
## @return: selectfields2
## @inputs: [frame = applymapping1]
selectfields2 = SelectFields.apply(frame = applymapping1, paths = ["snno", "year", "quarter", "delay", "dud", "time", "y"], transformation_ctx = "selectfields2")
## @type: ResolveChoice
## @args: [choice = "MATCH_CATALOG", database = "aidsdb", table_name = "aids", transformation_ctx = "resolvechoice3"]
## @return: resolvechoice3
## @inputs: [frame = selectfields2]
resolvechoice3 = ResolveChoice.apply(frame = selectfields2, choice = "MATCH_CATALOG", database = "aidsdb", table_name = "aids", transformation_ctx = "resolvechoice3")
## @type: DataSink
## @args: [database = "aidsdb", table_name = "aids", transformation_ctx = "datasink4"]
## @return: datasink4
## @inputs: [frame = resolvechoice3]
datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = "linkertargetdb", table_name = "aids3", transformation_ctx = "datasink4")

datasink5 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = "linkertargetdb", table_name = "world_atn_gluetable951", redshift_tmp_dir = args["TempDir"], transformation_ctx = "datasink5")

# datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = dropnullfields3, database = "asgdevdb", table_name = "world_dd_demo_population", redshift_tmp_dir = args["TempDir"], transformation_ctx = "datasink4")


job.commit()