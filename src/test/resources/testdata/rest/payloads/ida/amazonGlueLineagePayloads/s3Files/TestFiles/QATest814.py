import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
## Validation of Spigot API
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "amssurveydb", table_name = "amssurvey", transformation_ctx = "datasource0")

applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("nomber", "long", "nomber", "long"), ("type", "string", "type", "string"), ("sex", "string", "sex", "string"), ("citizen", "string", "citizen", "string"), ("count", "long", "count", "long"), ("countstate", "long", "countstate", "long")], transformation_ctx = "applymapping1")



spigot1 = Spigot.apply(frame = applymapping1, path = "s3://asgqatestautomation4/TargetFiles/Target814/spigot1", options = {})


spigot_op = glueContext.write_dynamic_frame.from_options(frame = spigot1, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/Target814/spigot3"}, format = "csv", transformation_ctx = "spigot_op")
job.commit()