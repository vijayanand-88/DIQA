package com.asg.automation.utils.jmxUtil;

import org.apache.geode.cache.client.ClientCache;
import org.apache.geode.cache.client.ClientCacheFactory;
import org.apache.geode.cache.query.*;
import org.apache.geode.management.DistributedRegionMXBean;
import org.apache.geode.management.DistributedSystemMXBean;
import org.apache.geode.management.RegionAttributesData;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.management.JMX;
import javax.management.MBeanServerConnection;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;
import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;
import java.io.IOException;
import java.lang.reflect.UndeclaredThrowableException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import static com.asg.automation.utils.jmxUtil.GemFireConstants.*;
import static org.apache.geode.management.internal.cli.shell.MXBeanProvider.getDistributedSystemMXBean;


public class JmxBase implements AutoCloseable {

    private static MBeanServerConnection mbeanConnection;

    private static JMXConnector connector;

    static GemfireBase gemFire = new GemfireBase();

    public static MBeanServerConnection connectJMX(final String hostName,
                                                   final String jmxPort) throws Exception {


        connector = JMXConnectorFactory.connect(new JMXServiceURL("service:jmx:rmi://" + hostName + ":"
                + jmxPort + "/jndi/rmi://" + hostName + ":" + jmxPort + "/jmxrmi"));
        mbeanConnection = connector.getMBeanServerConnection();


        if (mbeanConnection == null) {
            System.out.println("Not Connected");
        } else {
            System.out.println("Connected");
        }


        return mbeanConnection;
    }

    /*public static DistributedSystemMXBean getDistributedSystemMXBean( ) {
        try {
         connectJMX(hostName, jmxport);

        } catch (Exception e) {
            System.out.println("Exception  :::: "  +e.toString());
        }


        return JMX.newMXBeanProxy(mbeanConnection, MBeanJMXAdapter.getDistributedSystemName(),
                DistributedSystemMXBean.class);
    }*/

    public static DistributedRegionMXBean getDistributedRegionMXBean(String regionName) {
        ObjectName objName = null;
        try {
            // connectJMX(hostName, jmxPort);
            objName = new ObjectName(String.format(DISTRIBUTED_REGION, regionName));

        } catch (Exception e) {
            System.out.println("Exception  :::: " + e.toString());
        }


        return JMX.newMXBeanProxy(mbeanConnection, objName,
                DistributedRegionMXBean.class);
    }

    public static JsonObject getClusterTechData() throws IOException, MalformedObjectNameException {
        DistributedSystemMXBean dsmBean = getDistributedSystemMXBean();


        JsonObject techData = null;
        techData = Json.createObjectBuilder().add("Used Heap Size", Long.toString(dsmBean.getUsedHeapSize()))
                .add("Total Heap Size", Long.toString(dsmBean.getTotalHeapSize()))
                .add("Member(Locator + Server) Count", Integer.toString(dsmBean.getMemberCount()))
                .add("Locator Count", Integer.toString(dsmBean.getLocatorCount()))
                .add("Total Region Count", Integer.toString(dsmBean.getTotalRegionCount()))
                .add("Total Region Data Size", Long.toString(dsmBean.getTotalRegionEntryCount())).build();

        dsmBean.listMembers();
        System.out.println("tech data :::: used heap size:: " + techData.getString("Used Heap Size"));
        System.out.println("tech data :::: Total heap size::" + techData.getString("Total Heap Size"));
        System.out.println("tech data :::: Member count::" + techData.getString("Member(Locator + Server) Count"));


        List<String> lis = new ArrayList<String>();

        lis = Arrays.asList(dsmBean.listMembers());

        // for (int i )

        return techData;
    }

    public List<String> getRegions() throws IOException, MalformedObjectNameException {
        DistributedSystemMXBean dsmBean = getDistributedSystemMXBean();

        List<String> regions = Arrays.asList(dsmBean.listRegions());

        for (int i = 0; i < regions.size(); i++) {
            System.out.println("regions ::: " + regions.get(i));
        }

        return regions;
    }


    public static JsonObject getRegionTechData(String regionName, String hostName, String jmxPort) {
        boolean isPrimitive = false;
        boolean isPrimitiveValue = false;

        ClientCache clientCache = new ClientCacheFactory().addPoolLocator(hostName, 10334).create();
        //gemFire.createCache(hostName);
        String tableSize = null;
        JsonObject techData = null;
        DistributedRegionMXBean rBean = getDistributedRegionMXBean("/" + regionName);

        System.out.println("::: " + rBean.getRegionType());

        try {
            final JsonObjectBuilder builder = Json.createObjectBuilder();


            if (rBean != null) {

                final QueryService qservice = clientCache.getQueryService();
                final SelectResults result = (SelectResults) qservice
                        .newQuery(String.format("select count(*) from %s", "/" + regionName)).execute();
                Iterator iter = result.iterator();
                while (iter.hasNext()) {
                    tableSize = iter.next().toString();
                }

                System.out.println("table size :::: " + tableSize);

                if (rBean.getAvgBucketSize() > 0) {
                    System.out.println("after inside first iffff");
                    builder.add("AvgBucketSize", rBean.getAvgBucketSize());
                }
                if (rBean.getBucketCount() > 0) {
                    builder.add("BucketCount", rBean.getBucketCount());
                }

                System.out.println("after bucketCountttt");

                if (rBean.getCacheListenerCallsAvgLatency() > 0) {
                    builder.add("CacheListenerCallsAvgLatency", rBean.getCacheListenerCallsAvgLatency());
                }
                if (rBean.getCacheWriterCallsAvgLatency() > 0) {
                    builder.add("CacheWriterCallsAvgLatency", rBean.getCacheWriterCallsAvgLatency());
                }
                if (rBean.getDiskUsage() > 0) {
                    builder.add("DiskUsage", rBean.getDiskUsage());
                }
                if (rBean.getEmptyNodes() > 0) {
                    builder.add("EmptyNodes", rBean.getEmptyNodes());
                }
                if (rBean.getHitCount() > 0) {
                    builder.add("HitCount", rBean.getHitCount());
                }
                if (rBean.getLastAccessedTime() != -1) {
                    builder.add("LastAccessedTime", new Timestamp((long) rBean.getLastAccessedTime()).toString());
                }
                if (rBean.getLastModifiedTime() != -1) {
                    builder.add("LastModifiedTime", new Timestamp((long) rBean.getLastModifiedTime()).toString());
                }


                System.out.println("after timestamppppp");

                if (rBean.getMissCount() > 0) {
                    builder.add("MissCount", rBean.getMissCount());
                }
                builder.add("NumBucketsWithoutRedundancy", rBean.getNumBucketsWithoutRedundancy());
                if (rBean.getParentRegion() != null) {
                    builder.add("Parent Region", rBean.getParentRegion());
                }
                if (rBean.getPrimaryBucketCount() > 0) {
                    builder.add("PrimaryBucketCount", rBean.getPrimaryBucketCount());
                }
                if (rBean.getPutRemoteAvgLatency() > 0) {
                    builder.add("PutRemoteAvgLatency", rBean.getPutRemoteAvgLatency());
                }
                if (rBean.getPutRemoteLatency() > 0) {
                    builder.add("PutRemoteLatency", rBean.getPutRemoteLatency());
                }
                if (rBean.getRegionType() != null) {
                    builder.add("RegionType", rBean.getRegionType());
                }


                System.out.println("after regionTypeeeeeeee");

                if (rBean.getSystemRegionEntryCount() > 0) {
                    builder.add("SystemRegionEntryCount", rBean.getSystemRegionEntryCount());
                }
                if (rBean.getTotalBucketSize() > 0) {
                    builder.add("TotalBucketSize", rBean.getTotalBucketSize());
                }
                if (rBean.getTotalDiskEntriesInVM() > 0) {
                    builder.add("TotalDiskEntriesInVM", rBean.getTotalDiskEntriesInVM());
                }
                if (rBean.getTotalDiskWritesProgress() > 0) {
                    builder.add("TotalDiskWritesProgress", rBean.getTotalDiskWritesProgress());
                }
                if (rBean.getTotalEntriesOnlyOnDisk() > 0) {
                    builder.add("TotalEntriesOnlyOnDisk", rBean.getTotalEntriesOnlyOnDisk());
                }
                if (rBean.getAverageReads() > 0) {
                    builder.add("AverageReads", rBean.getAverageReads());
                }
                if (rBean.getAverageWrites() > 0) {
                    builder.add("AverageWrites", rBean.getAverageWrites());
                }
                if (rBean.getCreatesRate() > 0) {
                    builder.add("CreatesRate", rBean.getCreatesRate());
                }
                if (rBean.getDestroyRate() > 0) {
                    builder.add("DestroyRate", rBean.getDestroyRate());
                }
                if (rBean.getDiskReadsRate() > 0) {
                    builder.add("DiskReadsRate", rBean.getDiskReadsRate());
                }
                if (rBean.getGetsRate() > 0) {
                    builder.add("GetsRate", rBean.getGetsRate());
                }
                if (rBean.getHitRatio() > 0) {
                    builder.add("HitRatio", rBean.getHitRatio());
                }
                if (rBean.getLruDestroyRate() > 0) {
                    builder.add("LruDestroyRate", rBean.getLruDestroyRate());
                }
                if (rBean.getLruEvictionRate() > 0) {
                    builder.add("LruEvictionRate", rBean.getLruEvictionRate());
                }
                if (rBean.getPutAllRate() > 0) {
                    builder.add("PutAllRate", rBean.getPutAllRate());
                }
                if (rBean.getPutLocalRate() > 0) {
                    builder.add("PutLocalRate", rBean.getPutLocalRate());
                }
                if (rBean.getPutRemoteRate() > 0) {
                    builder.add("PutRemoteRate", rBean.getPutRemoteRate());
                }
                if (rBean.getPutsRate() > 0) {
                    builder.add("PutsRate", rBean.getPutsRate());
                }
                if (rBean.getEntrySize() > 0) {
                    builder.add("EntrySize", rBean.getEntrySize());
                }


                System.out.println("after EntrySizeeeeeeeeeeee");
                builder.add("FullPath", rBean.getFullPath());
                final JsonObjectBuilder builder1 = Json.createObjectBuilder();
                final RegionAttributesData regionAttributesData = rBean.listRegionAttributes();
                if (regionAttributesData != null) {
                    if (regionAttributesData.getKeyConstraintClassName() != null) {
                        builder1.add("Key Constraint Class Name", regionAttributesData.getKeyConstraintClassName());
                    }
                    if (regionAttributesData.getValueConstraintClassName() != null) {
                        builder1.add("value Constraint Class Name", regionAttributesData.getValueConstraintClassName());
                    }
                    builder1.add("asyncConflationEnabled", regionAttributesData.isAsyncConflationEnabled());
                    if (regionAttributesData.getAsyncEventQueueIds() != null
                            && !regionAttributesData.getAsyncEventQueueIds().isEmpty()) {
                        builder1.add("asyncEventQueueIds", regionAttributesData.getAsyncEventQueueIds().toString());
                    }
                    if (regionAttributesData.getCacheListeners() != null
                            && regionAttributesData.getCacheListeners().length != 0) {
                        builder1.add("cacheListeners", Arrays.toString(regionAttributesData.getCacheListeners()));
                    }
                    if (regionAttributesData.getCacheLoaderClassName() != null) {
                        builder1.add("cacheLoaderClassName", regionAttributesData.getCacheLoaderClassName());
                    }
                    if (regionAttributesData.getCacheWriterClassName() != null) {
                        builder1.add("cacheWriterClassName", regionAttributesData.getCacheWriterClassName());
                    }
                    builder1.add("cloningEnabled", regionAttributesData.isCloningEnabled());
                    if (regionAttributesData.getCompressorClassName() != null) {
                        builder1.add("compressorClassName", regionAttributesData.getCompressorClassName());
                    }
                    builder1.add("concurrencyLevel", regionAttributesData.getConcurrencyLevel());
                    if (regionAttributesData.getCustomEntryIdleTimeout() != null) {
                        builder1.add("customEntryIdleTimeout", regionAttributesData.getCustomEntryIdleTimeout());
                    }
                    if (regionAttributesData.getCustomEntryTimeToLive() != null) {
                        builder1.add("customEntryTimeToLive", regionAttributesData.getCustomEntryTimeToLive());
                    }
                    if (regionAttributesData.getDataPolicy() != null) {
                        builder1.add("dataPolicy", regionAttributesData.getDataPolicy());
                    }
                    if (regionAttributesData.getDiskStoreName() != null) {
                        builder1.add("diskStoreName", regionAttributesData.getDiskStoreName());
                    }
                    builder1.add("diskSynchronous", regionAttributesData.isDiskSynchronous());
                    builder1.add("entryIdleTimeout", regionAttributesData.getEntryIdleTimeout());
                    builder1.add("entryTimeToLive", regionAttributesData.getEntryTimeToLive());
                    builder1.add("No_of_gatewaySenders", regionAttributesData.getGatewaySenderIds().size());

                    if (!regionAttributesData.getGatewaySenderIds().isEmpty()) {
                        int x = 1;
                        final JsonObjectBuilder builderSenderId = Json.createObjectBuilder();
                        for (final String s : regionAttributesData.getGatewaySenderIds()) {
                            builderSenderId.add("Gateway Sender Id " + x, s);
                            x++;
                        }
                        builder1.add("gateway Senders id", builderSenderId.build());
                    }
                    builder1.add("ignoreJTA", regionAttributesData.isIgnoreJTA());
                    builder1.add("indexMaintenanceSynchronous", regionAttributesData.isIndexMaintenanceSynchronous());
                    builder1.add("initialCapacity", regionAttributesData.getInitialCapacity());
                    if (regionAttributesData.getInterestPolicy() != null) {
                        builder1.add("interestPolicy", regionAttributesData.getInterestPolicy());
                    }
                    builder1.add("loadFactor", regionAttributesData.getLoadFactor());
                    builder1.add("lockGrantor", regionAttributesData.isLockGrantor());
                    builder1.add("multicastEnabled", regionAttributesData.isMulticastEnabled());
                    builder1.add("offHeap", regionAttributesData.getOffHeap());
                    if (regionAttributesData.getPoolName() != null) {
                        builder1.add("poolName", regionAttributesData.getPoolName());
                    }
                    builder1.add("regionIdleTimeout", regionAttributesData.getRegionIdleTimeout());
                    builder1.add("regionTimeToLive", regionAttributesData.getRegionTimeToLive());
                    if (regionAttributesData.getScope() != null) {
                        builder1.add("scope", regionAttributesData.getScope());
                    }
                    builder1.add("statisticsEnabled", regionAttributesData.isStatisticsEnabled());
                    builder1.add("subscriptionConflationEnabled",
                            regionAttributesData.isSubscriptionConflationEnabled());

                    int booleanValue = 0;
                    int stringValue = 0;
                    int doubleValue = 0;
                    int floatValue = 0;
                    int charValue = 0;
                    int intValue = 0;
                    int byteValue = 0;
                    int shortValue = 0;
                    int longValue = 0;

                    int booleanKey = 0;
                    int stringKey = 0;
                    int doubleKey = 0;
                    int floatKey = 0;
                    int charKey = 0;
                    int intKey = 0;
                    int byteKey = 0;
                    int shortKey = 0;
                    int longKey = 0;

                    final JsonObjectBuilder builder2 = Json.createObjectBuilder();
                    final QueryService qs = clientCache.getQueryService();
                    final SelectResults results = (SelectResults) qs
                            .newQuery(String.format(GET_REGION_DATA_FULL, "/" + regionName)).execute();
                    if (regionAttributesData.getKeyConstraintClassName() == null) {

                        final Iterator resultsIterator = results.iterator();
                        while (resultsIterator.hasNext()) {
                            final Struct o = (Struct) resultsIterator.next();
                            final String keyClass = o.get("key").getClass().toString();

                            if (keyClass.equals(CLASS + BOOL_CLASS)) {
                                booleanKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + STRING_CLASS)) {
                                stringKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + DOUBLE_CLASS)) {
                                doubleKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + FLOAT_CLASS)) {
                                floatKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + CHAR_CLASS)) {
                                charKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + INT_CLASS)) {
                                intKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + BYTE_CLASS)) {
                                byteKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + SHORT_CLASS)) {
                                shortKey++;
                                isPrimitive = true;
                            } else if (keyClass.equals(CLASS + LONG_CLASS)) {
                                longKey++;
                                isPrimitive = true;
                            }
                        }
                        if (booleanKey != 0) {
                            builder2.add("Total Boolean Keys", booleanKey);
                        }
                        if (stringKey != 0) {
                            builder2.add("Total String Keys", stringKey);
                        }
                        if (doubleKey != 0) {
                            builder2.add("Total Double Keys", doubleKey);
                        }
                        if (floatKey != 0) {
                            builder2.add("Total Float Keys", floatKey);
                        }
                        if (charKey != 0) {
                            builder2.add("Total Character Keys", charKey);
                        }
                        if (intKey != 0) {
                            builder2.add("Total Integer Keys", intKey);
                        }
                        if (byteKey != 0) {
                            builder2.add("Total Byte Keys", byteKey);
                        }
                        if (shortKey != 0) {
                            builder2.add("Total Short Keys", shortKey);
                        }
                        if (longKey != 0) {
                            builder2.add("Total Long Keys", longKey);
                        }
                        if (rBean.getMembers().length > 0) {
                            builder1.add("Key Distribution", builder2.build());
                        }
                    } else {
                        String keyConsClass = regionAttributesData.getKeyConstraintClassName();
                        if (keyConsClass != null && (keyConsClass.equals(BOOL_CLASS)
                                || keyConsClass.equals(STRING_CLASS)
                                || keyConsClass.equals(DOUBLE_CLASS)
                                || keyConsClass.equals(FLOAT_CLASS)
                                || keyConsClass.equals(CHAR_CLASS) || keyConsClass.equals(INT_CLASS)
                                || keyConsClass.equals(BYTE_CLASS)
                                || keyConsClass.equals(LONG_CLASS)
                                || keyConsClass.equals(SHORT_CLASS)
                                || keyConsClass.equals(OBJ_CLASS))) {
                            isPrimitive = true;
                        }
                    }

                    final JsonObjectBuilder builder3 = Json.createObjectBuilder();
                    if (regionAttributesData.getValueConstraintClassName() == null) {
                        final Iterator resultsIterator = results.iterator();
                        while (resultsIterator.hasNext()) {
                            final Struct o = (Struct) resultsIterator.next();
                            final String valueClass = o.get(VALUE).getClass().toString();
                            if (valueClass.equals(CLASS + BOOL_CLASS)) {
                                booleanValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + STRING_CLASS)) {
                                stringValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + DOUBLE_CLASS)) {
                                doubleValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + FLOAT_CLASS)) {
                                floatValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + CHAR_CLASS)) {
                                charValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + INT_CLASS)) {
                                intValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + BYTE_CLASS)) {
                                byteValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + SHORT_CLASS)) {
                                shortValue++;
                                isPrimitiveValue = true;
                            } else if (valueClass.equals(CLASS + LONG_CLASS)) {
                                longValue++;
                                isPrimitiveValue = true;
                            }
                        }
                        if (booleanValue != 0) {
                            builder3.add("Total Boolean Values", booleanValue);
                        }
                        if (stringValue != 0) {
                            builder3.add("Total String Values", stringValue);
                        }
                        if (doubleValue != 0) {
                            builder3.add("Total Double Values", doubleValue);
                        }
                        if (floatValue != 0) {
                            builder3.add("Total Float Values", floatValue);
                        }
                        if (charValue != 0) {
                            builder3.add("Total Character Values", charValue);
                        }
                        if (intValue != 0) {
                            builder3.add("Total Integer Values", intValue);
                        }
                        if (byteValue != 0) {
                            builder3.add("Total Byte Values", byteValue);
                        }
                        if (shortValue != 0) {
                            builder3.add("Total Short Values", shortValue);
                        }
                        if (longValue != 0) {
                            builder3.add("Total Long Values", longValue);
                        }
                        if (Long.valueOf(tableSize) > 0) {
                            builder1.add("Value Distribution", builder3.build());
                        }

                    } else {
                        String keyConsClass = regionAttributesData.getValueConstraintClassName();
                        if (keyConsClass != null && (keyConsClass.equals(BOOL_CLASS)
                                || keyConsClass.equals(STRING_CLASS)
                                || keyConsClass.equals(DOUBLE_CLASS)
                                || keyConsClass.equals(FLOAT_CLASS)
                                || keyConsClass.equals(CHAR_CLASS) || keyConsClass.equals(INT_CLASS)
                                || keyConsClass.equals(BYTE_CLASS)
                                || keyConsClass.equals(LONG_CLASS)
                                || keyConsClass.equals(SHORT_CLASS)
                                || keyConsClass.equals(OBJ_CLASS))) {
                            isPrimitiveValue = true;
                        }
                    }
                    builder.add("RegionAttributesData", builder1.build());
                }
                builder.add("No of Hosting Members(Servers)", rBean.getMemberCount());
                if (rBean.getMembers().length > 0) {
                    final JsonObjectBuilder builderRMember = Json.createObjectBuilder();
                    int x = 1;
                    for (final String s : rBean.getMembers()) {
                        builderRMember.add("Hosting Server " + x, s);
                        x++;
                    }
                    builder.add("Hosting Members", builderRMember.build());
                }

                techData = builder.build();

            }
        } catch (FunctionDomainException | TypeMismatchException | NameResolutionException
                | QueryInvocationTargetException | IllegalArgumentException | UndeclaredThrowableException e) {
            System.out.println("exception ::: " + e.toString());

        }
        return techData;
    }


    public static List<String> getMembers() throws IOException, MalformedObjectNameException {
        DistributedSystemMXBean dsmBean = getDistributedSystemMXBean();

        List<String> lis = new ArrayList<String>();

        lis = Arrays.asList(dsmBean.listMembers());


        return lis;

    }

    public static void main(String args[]) throws Exception {
        JmxBase jmx;

        try {
            jmx = new JmxBase();

            List<String> tableTechData = jmx.getRegions();

        } catch (Exception e) {
            System.out.println("exception ::::: " + e.toString());
        }


    }

    @Override
    public void close() throws Exception {
        System.out.println("connector closee");
        connector.close();
    }
}