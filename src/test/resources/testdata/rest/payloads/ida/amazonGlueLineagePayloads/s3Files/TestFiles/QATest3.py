import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job


def processMain():
    ## @params: [JOB_NAME]
    args = getResolvedOptions(sys.argv, ['JOB_NAME'])
    sc = SparkContext()
    glueContext = GlueContext(sc)
    spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args['JOB_NAME'], args)
    datasource0 = glueContext.create_dynamic_frame.from_catalog(database="autoglues3lineage",
                                                                table_name="train_sm_s2adb_csv",
                                                                transformation_ctx="datasource0")
    resolvechoice2 = ResolveChoice.apply(frame=datasource0, choice="make_struct", transformation_ctx="resolvechoice2")
    dropnullfields3 = DropNullFields.apply(frame=resolvechoice2, transformation_ctx="dropnullfields3")
    datasink4 = glueContext.write_dynamic_frame.from_options(frame=dropnullfields3, connection_type="s3",
                                                             connection_options={
                                                                 "path": "s3://asgqatestautomation4/NoTargetdata"},
                                                             format="csv", transformation_ctx="datasink4")
    job.commit()


processMain()
