#Validation of Glue Linker End to End for S3 (Avro, Json and Parquet)
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

dsparquet = glueContext.create_dynamic_frame.from_catalog(database = "linkersourcedb", table_name = "cricketparquet2", transformation_ctx = "dsparquet")
amparquet = ApplyMapping.apply(frame = dsparquet, mappings = [("username1", "string", "username1", "string"), ("age", "int", "age", "int"), ("phone", "string", "phone", "string"), ("housenum", "string", "housenum", "string")], transformation_ctx = "amparquet")
dtparquet = glueContext.write_dynamic_frame.from_catalog(frame = amparquet, database = "linkertargetdb", table_name = "cricketparquet2target", transformation_ctx = "dtparquet")

dsavro = glueContext.create_dynamic_frame.from_catalog(database = "linkersourcedb", table_name = "avrofile2", transformation_ctx = "dsavro")
dtavro = glueContext.write_dynamic_frame.from_catalog(frame = dsavro, database = "linkertargetdb", table_name = "avrofile2target", transformation_ctx = "dtavro")

dsjson = glueContext.create_dynamic_frame.from_catalog(database = "linkersourcedb", table_name = "aidscolumnarrayjson", transformation_ctx = "dsjson")
dtjson = glueContext.write_dynamic_frame.from_catalog(frame = dsjson, database = "linkertargetdb", table_name = "aidscolumnarrayjsontarget", transformation_ctx = "dtjson")

job.commit()