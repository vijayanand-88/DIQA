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
resolvechoice3 = ResolveChoice.apply(frame = applymapping1, choice = "MATCH_CATALOG", database = "autoglues3lineagetarget", table_name = "train_sm_csv", transformation_ctx = "resolvechoice3")
## @type: DataSink
## @args: [database = "autoglues3lineagetarget", table_name = "train_sm_csv", transformation_ctx = "datasink4"]
## @return: datasink4
## @inputs: [frame = resolvechoice3]
datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = "autoglues3lineaget2", table_name = "gluetargett2_csv", transformation_ctx = "datasink4")
ds6 = glueContext.write_dynamic_frame.from_options(frame=resolvechoice3, connection_type="redshift", connection_options={ "url": "jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world", "dbtable": "atn.gluetable412"}, transformation_ctx="ds6")
ds7 = glueContext.write_dynamic_frame.from_options(frame=resolvechoice3, connection_type="s3", connection_options={  "path": "s3://asgqatestautomation4/Targetdata412"}, format="json", transformation_ctx="ds7")
job.commit()