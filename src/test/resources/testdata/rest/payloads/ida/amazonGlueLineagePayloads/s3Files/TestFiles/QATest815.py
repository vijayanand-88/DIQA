#This file is meant for S3 Sources with different formats
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

connection_s3_options1Json = {
	"paths": ["s3://asgqatestautomation4/SourceFiles/s3FileSupport/aids_columnArray.json"]
}


connection_s3_options1Csv = {
	"paths": ["s3://asgqatestautomation4/SourceFiles/s3FileSupport/emp.csv"]
}

connection_s3_options1Avro = {
	"paths": ["s3://asgqatestautomation4/SourceFiles/s3FileSupport/AvroFile1.avro"]
}


connection_s3_options1Parquet = {
	"paths": ["s3://asgqatestautomation4/SourceFiles/s3FileSupport/cricket.parquet"]
}


datasourceCSV = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options1Csv, format="csv", transformation_ctx="datasource0")
datasourceJson = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options1Json, format="json",  transformation_ctx="datasourceJson")
datasourceAvro = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options1Avro, format="avro",  transformation_ctx="datasourceAvro")
datasourceParquet = glueContext.create_dynamic_frame.from_options("s3", connection_s3_options1Parquet, format="parquet",  transformation_ctx="datasourceParquet")


CsvOp = glueContext.write_dynamic_frame.from_options(frame = datasourceCSV, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target815/CSVOUTPUT"}, format = "csv", transformation_ctx = "CsvOp")
JsonOp = glueContext.write_dynamic_frame.from_options(frame = datasourceJson, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target815/JsonOUTPUT"}, format = "json", transformation_ctx = "JsonOp")
AvroOp = glueContext.write_dynamic_frame.from_options(frame = datasourceAvro, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target815/AvroOUTPUT"}, format = "csv", transformation_ctx = "AvroOp")
ParquetOp = glueContext.write_dynamic_frame.from_options(frame = datasourceParquet, connection_type = "s3", connection_options = {"path": "s3://asgqatestautomation4/TargetFiles/Target815/ParquetOUTPUT"}, format = "parquet", transformation_ctx = "ParquetOp")
job.commit()