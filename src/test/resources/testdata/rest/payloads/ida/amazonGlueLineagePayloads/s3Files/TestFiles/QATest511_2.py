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

fruits = glueContext.create_dynamic_frame.from_catalog(
    database="sourcedb511",
    table_name="fruits_table", transformation_ctx="fruits")

brands = glueContext.create_dynamic_frame.from_catalog(
    database="sourcedb511",
    table_name="brands_table", transformation_ctx="brands")

company = glueContext.create_dynamic_frame.from_catalog(
    database="sourcedb511a",
    table_name="company_table", transformation_ctx="company")

fruits_and_brands1 = Join.apply(fruits, brands, 'id', 'id', transformation_ctx="fruits_and_brands1")

true_company = RenameField.apply(frame=company, old_name="id1", new_name="id")

fruits_and_comp1 = Join.apply(fruits, Join.apply(brands, true_company, 'id', 'id'),'id','id',transformation_ctx="fruits_and_comp1")

fruits_and_brands1_op = glueContext.write_dynamic_frame.from_options(frame=fruits_and_brands1, connection_type="s3",
                                                          connection_options={
                                                              "path": "s3://asgqatestautomation4/TargetFiles/Target511/FruitsAndBrands"},
                                                          format="csv", transformation_ctx="fruits_and_brands1_op")

true_company_op = glueContext.write_dynamic_frame.from_options(frame=fruits_and_brands1, connection_type="s3",
                                                               connection_options={
                                                                   "path": "s3://asgqatestautomation4/TargetFiles/Target511/TrueCompany"},
                                                               format="csv", transformation_ctx="true_company_op")

fruits_and_comp1_op = glueContext.write_dynamic_frame.from_options(frame=fruits_and_brands1, connection_type="s3",
                                                               connection_options={
                                                                   "path": "s3://asgqatestautomation4/TargetFiles/Target511/FruitsAndCompany"},
                                                               format="csv", transformation_ctx="fruits_and_comp1_op")

job.commit()




