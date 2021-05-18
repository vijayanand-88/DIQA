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
    ds1 = glueContext.write_dynamic_frame.from_options(frame=rc1, connection_type="sqlserver",
                                                       connection_options={
                                                           "url": "jdbc:sqlserver://dechewindock01v.asg.com:1433;databaseName=pubs",
                                                           "dbtable": "dbo.gluetable21"},
                                                       transformation_ctx="ds1")
    ds2 = glueContext.write_dynamic_frame.from_options(frame=rc1, connection_type="oracle",
                                                       connection_options={
                                                           "url": "jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORACLE12C",
                                                           "dbtable": "COLLECTOR.GLUETABLE212B"},
                                                       transformation_ctx="ds2")
    ds3 = glueContext.write_dynamic_frame.from_options(frame=rc1, connection_type="postgresql",
                                                       connection_options={
                                                            "url": "jdbc:postgresql://decheqaperf01v.asg.com:5432/postgres",
                                                            "dbtable": "atn.gluetable212a"},
                                                       transformation_ctx="ds3")


    job.commit()


processMain()
