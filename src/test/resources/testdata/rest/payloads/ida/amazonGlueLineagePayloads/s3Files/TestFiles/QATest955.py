#Validation of Glue Linker End to End for S3 (Orc)
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
## @args: [database = "tempdb", table_name = "orcfile", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "linkersourcedb", table_name = "orcfile", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("city", "string", "city", "string"), ("contactno", "binary", "contactno", "binary"), ("country", "string", "country", "string"), ("email", "string", "email", "string"), ("fax", "string", "fax", "string"), ("gender", "string", "gender", "string"), ("ipaddress", "string", "ipaddress", "string"), ("landlineno", "string", "landlineno", "string"), ("phone", "string", "phone", "string"), ("postalcode", "string", "postalcode", "string"), ("ssn", "string", "ssn", "string"), ("state", "string", "state", "string"), ("street", "string", "street", "string"), ("userid", "byte", "userid", "byte"), ("username", "string", "username", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("city", "string", "city", "string"), ("contactno", "binary", "contactno", "binary"), ("country", "string", "country", "string"), ("email", "string", "email", "string"), ("fax", "string", "fax", "string"), ("gender", "string", "gender", "string"), ("ipaddress", "string", "ipaddress", "string"), ("landlineno", "string", "landlineno", "string"), ("phone", "string", "phone", "string"), ("postalcode", "string", "postalcode", "string"), ("ssn", "string", "ssn", "string"), ("state", "string", "state", "string"), ("street", "string", "street", "string"), ("userid", "byte", "userid", "byte"), ("username", "string", "username", "string")], transformation_ctx = "applymapping1")
## @type: DataSink
## @args: [connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/SourceFiles/s3FileSupportWithGlueTable/GlueTarget/OrcTarget"}, format = "json", transformation_ctx = "datasink2"]
## @return: datasink2
## @inputs: [frame = applymapping1]
datasink2 = glueContext.write_dynamic_frame.from_options(frame = applymapping1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/SourceFiles/s3FileSupportWithGlueTable/GlueTarget/OrcFileOp"}, format = "json", transformation_ctx = "datasink2")
job.commit()