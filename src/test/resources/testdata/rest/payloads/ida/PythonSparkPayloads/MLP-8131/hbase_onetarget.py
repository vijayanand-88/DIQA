from pyspark.sql import SparkSession

def hbase_example2(spark):
	df = spark.read.format('org.apache.hadoop.hbase.spark').option('hbase.table','pyspark:employee').option('hbase.use.hbase.context', 'False').option('hbase.config.resources', 'file:///etc/hbase/conf/hbase-site.xml').option('hbase-push.down.column.filter', 'False').load() 
	df.write.format('org.apache.hadoop.hbase.spark').option('hbase.table','pyspark:hremployee').option('hbase.use.hbase.context','False').option('hbase.config.resources', 'file:///etc/hbase/conf/hbase-site.xml').option('hbase-push.down.column.filter', 'False').save()
	
if __name__ == "__main__":
	spark = Spar2Session.builder.appName("Python Spark SQL data source example").getOrCreate()
	hbase_example2(spark)
	park.stop()