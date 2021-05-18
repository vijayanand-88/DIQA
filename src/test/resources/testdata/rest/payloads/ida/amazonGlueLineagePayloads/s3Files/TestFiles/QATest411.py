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
## @args: [database = "autoglues3lineage", table_name = "train_sm_s2adb_csv", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "autoglues3lineage", table_name = "train_sm_s2adb_csv", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("passengerid", "long", "passengerid", "long"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "long")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("passengerid", "long", "passengerid", "long"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "long")], transformation_ctx = "applymapping1")
## @type: SelectFields
## @args: [paths = ["passengerid", "age", "ticket", "fare"], transformation_ctx = "selectfields2"]
## @return: selectfields2
## @inputs: [frame = applymapping1]
# selectfields2 = SelectFields.apply(frame = applymapping1, paths = ["passengerid", "age", "ticket", "fare"], transformation_ctx = "selectfields2")
## @type: ResolveChoice
## @args: [choice = "MATCH_CATALOG", database = "autoglues3lineagetarget", table_name = "train_sm_csv", transformation_ctx = "resolvechoice3"]
## @return: resolvechoice3
## @inputs: [frame = selectfields2]
resolvechoice3 = ResolveChoice.apply(frame = applymapping1, choice = "MATCH_CATALOG", database = "autoglues3lineagetarget", table_name = "train_sm_csv", transformation_ctx = "resolvechoice3")
## @type: DataSink
## @args: [database = "autoglues3lineagetarget", table_name = "train_sm_csv", transformation_ctx = "datasink4"]
## @return: datasink4
## @inputs: [frame = resolvechoice3]
datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = "autoglues3lineaget1", table_name = "gluetargett1_csv", transformation_ctx = "datasink4")
datasink5 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = "autoglues3lineaget12", table_name = "gluetargett12_csv", transformation_ctx = "datasink5")
job.commit()