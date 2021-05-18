import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
##Validation of SplitFields and SelectFromCollection
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
## @type: DataSource
## @args: [database = "amssurveydb", table_name = "amssurvey", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "amssurveydb", table_name = "amssurvey", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("nomber", "long", "nomber", "long"), ("type", "string", "type", "string"), ("sex", "string", "sex", "string"), ("citizen", "string", "citizen", "string"), ("count", "long", "count", "long"), ("countstate", "long", "countstate", "long")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("nomber", "long", "nomber", "long"), ("type", "string", "type", "string"), ("sex", "string", "sex", "string"), ("citizen", "string", "citizen", "string"), ("count", "long", "count", "long"), ("countstate", "long", "countstate", "long")], transformation_ctx = "applymapping1")


## @type: SplitFields
## @args: [paths = ["<paths>"], transformation_ctx = "<transformation_ctx>"]
## @return: <output>
## @inputs: [frame = <frame>]
splitf1 = SplitFields.apply(frame = applymapping1, paths = ["type","sex","countstate"], name1 = "splitf11", name2 = "splitf12",transformation_ctx = "splitf1")

# split1 = SplitRows.apply(applymapping1, {"count": {">": 50}}, "split11", "split12", transformation_ctx ="split1")## @type: SplitRows

selFromCol1f = SelectFromCollection.apply(dfc = splitf1, key = "splitf11", transformation_ctx = "selFromCol1")

selFromCol2f = SelectFromCollection.apply(dfc = splitf1, key = "splitf12", transformation_ctx = "selFromCol2")

selFromCol1_opf = glueContext.write_dynamic_frame.from_options(frame = selFromCol1f, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target813/selFromCol1Opf"}, format = "csv", transformation_ctx = "selFromCol1_opf")

selFromCol2_opf = glueContext.write_dynamic_frame.from_options(frame = selFromCol2f, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target813/selFromCol2Opf"}, format = "csv", transformation_ctx = "selFromCol2_opf")
job.commit()