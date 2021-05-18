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
    ds0 = glueContext.create_dynamic_frame.from_catalog(database="autoglues3lineage", table_name="train_sm_s2adb_csv", transformation_ctx="ds0")
    rc1 = ResolveChoice.apply(frame=ds0, choice="make_struct", transformation_ctx="rc1")

    ds3 = glueContext.write_dynamic_frame.from_options(frame=rc1, connection_type="redshift",
                                                       connection_options={
                                                           "url": "jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world",
                                                           "dbtable": "atn.gluetable211"},
                                                       transformation_ctx="ds3")
    ds7 = glueContext.write_dynamic_frame.from_options(frame=rc1, connection_type="s3",
                                                       connection_options={
                                                           "path": "s3://asgqatestautomation4/Targetdata211"},
                                                       format="json", transformation_ctx="ds7")

    # ds3 = glueContext.write_dynamic_frame.from_options(frame=rc1, connection_type="postgresql",
    #                                                    connection_options={
    #                                                        "url": "jdbc:postgresql://decheqaperf01v.asg.com:5432/postgres",
    #                                                        "dbtable": "public.gluetable26"},
    #                                                    transformation_ctx="ds3")
    job.commit()


processMain()
