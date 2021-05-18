from pyspark.sql import SparkSession

def hbase_example3(spark):
	df3 = spark.read.format('org.apache.hadoop.hbase.spark').option('hbase.table','pyspark:employee').option('hbase.use.hbase.context', 'False').option('hbase.config.resources', 'file:///etc/hbase/conf/hbase-site.xml').option('hbase-push.down.column.filter', 'False').load() 
	df3.write.format('org.apache.hadoop.hbase.spark').option('hbase.table','pyspark:hremployee').option('hbase.use.hbase.context','False').option('hbase.config.resources', 'file:///etc/hbase/conf/hbase-site.xml').option('hbase-push.down.column.filter', 'False').save()
	df3.write.format('org.apache.hadoop.hbase.spark').option('hbase.table','pyspark:emp').option('hbase.use.hbase.context','False').option('hbase.config.resources', 'file:///etc/hbase/conf/hbase-site.xml').option('hbase-push.down.column.filter', 'False').save()
	
if __name__ == "__main__":
	spark = SparkSession.builder.appName("Python Spark SQL data source example").getOrCreate()
	hbase_example3(spark)
	park.stop()