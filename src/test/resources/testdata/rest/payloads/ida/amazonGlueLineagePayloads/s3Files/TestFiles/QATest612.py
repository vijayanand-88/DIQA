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

connection_options_tgt = {
    "url": "jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world",
    "dbtable": "atn.gluetable6121",
    "user": "master",
    "password": "Asg-2019",
    "redshiftTmpDir": args["TempDir"]
}


## @type: DataSource
## @args: [database = "sourcedb611", table_name = "titanic611table", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "sourcedb611", table_name = "titanic611table", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("passengerid", "long", "passengerid", "long"), ("city", "string", "city", "string"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "double"), ("sex", "string", "sex", "string")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("passengerid", "long", "passengerid", "long"), ("city", "string", "city", "string"), ("age", "long", "age", "long"), ("ticket", "string", "ticket", "string"), ("fare", "double", "fare", "double"), ("sex", "string", "sex", "string")], transformation_ctx = "applymapping1")

dropfields1 = DropFields.apply(frame = applymapping1, paths = ["city","sex"], transformation_ctx = "dropfields1")

selectfields1 = SelectFields.apply(frame = dropfields1, paths = ["passengerid","age","ticket"], transformation_ctx = "selectfields1")

#writing to atn schema
datasink5 = glueContext.write_dynamic_frame.from_jdbc_conf(frame = selectfields1, catalog_connection = "AmazonRedshiftConnection", connection_options = {"dbtable": "atn.gluetable612", "database": "world"}, redshift_tmp_dir = args["TempDir"], transformation_ctx = "datasink5")


#writing to atn schema using from options
datasink4 = glueContext.write_dynamic_frame.from_options(frame = selectfields1, connection_type = "redshift", connection_options = connection_options_tgt, format=None, transformation_ctx = "datasink4")



job.commit()