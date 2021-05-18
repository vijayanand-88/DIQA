package com.asg.automation.utils.jmxUtil;

public class GemFireConstants {


    public static final String BOOL_CLASS = "java.lang.Boolean";
    public static final String STRING_CLASS = "java.lang.String";
    public static final String DOUBLE_CLASS = "java.lang.Double";
    public static final String FLOAT_CLASS = "java.lang.Float";
    public static final String CHAR_CLASS = "java.lang.Character";
    public static final String INT_CLASS = "java.lang.Integer";
    public static final String BYTE_CLASS = "java.lang.Byte";
    public static final String SHORT_CLASS = "java.lang.Short";
    public static final String LONG_CLASS = "java.lang.Long";
    public static final String OBJ_CLASS = "java.lang.Object";
    public static final String VALUE = "value";
    public static final String KEY = "key";
    public static final String CLASS = "class ";
    public static final String SERIAL_VERSION_UID = "serialVersionUID";
    /**
     * To catch exception
     */
    public static final String CAUSE = "Cause : ";
    /**
     * To catch exception
     */
    public static final String MESSAGE = "Message : ";
    /**
     * Integer
     */
    public static final String INTEGER = "Integer";
    /**
     * Float
     */
    public static final String FLOAT = "Float";
    /**
     * Double
     */
    public static final String DOUBLE = "Double";
    /**
     * Long
     */
    public static final String LONG = "Long";
    /**
     * Member
     */
    public static final String MEMBER = "member";
    /**
     * Cache Server
     */
    public static final String CACHE_SERVER = "GemFire:service=CacheServer,port=%s,type=Member,member=%s";
    /**
     * Region with limit
     */
    public static final String GET_REGION_DATA = "Select entry.key, entry.value from %s.entries entry LIMIT %s";
    /**
     * Region
     */
    public static final String GET_REGION_DATA_FULL = "Select entry.key, entry.value from %s.entries entry";
    /**
     * Server Region
     */
    public static final String SERVER_REGION = "GemFire:service=Region,name=%s,type=Member,member=%s";
    /**
     * Distributed Region
     */
    public static final String DISTRIBUTED_REGION = "GemFire:service=Region,name=%s,type=Distributed";
    /**
     * Exclude
     */
    public static final String EXCLUDE = "exclude";
    /**
     * include
     */
    public static final String INCLUDE = "include";
    /**
     * currentTime
     */
    public static final String CURRENT_TIME = "CurrentTime";
    /**
     * LOCAL_HOST - Gets name from configuration
     */
    public static final String LOCAL_HOST = "HostName";
    /**
     * LOCATOR_PORT - Gets port from configuration
     */
    public static final String LOCATOR_PORT = "locatorPort";
    /**
     * JMX_PORT - Gets JMX port from configuration
     */
    public static final String JMX_PORT = "JMXPort";
    /**
     * SAMPLE_DATA_LIMIT - Gets Sample Data Limit from configuration
     */
    public static final String SAMPLE_DATA_LIMIT = "Sample Data Limit";
    /**
     * INCREMENTAL - Checks for Incremental
     */
    public static final String INCREMENTAL = "fromLastRun";

    /**
     * Sets default name for DOM Objects
     */
    public static final String GEMFIRE_NAME = "Gemfire";
    /**
     * Gemfire Version
     */
    public static final String GEMFIRE_VERSION = "9.6.0";
    /**
     * Contains list of attributes at Member level
     */
    protected static final String[] MEMBER_ATTRS = { "AverageReads", "MemberUpTime", "AverageWrites", "CpuUsage",
            "FreeHeapSpace", "FreeMemory", "MaximumHeapSize", "OffHeapFreeMemory", "OffHeapUsedMemory",
            "OffHeapMaxMemory", "UsedMemory", "Locator", "Server", "Manager", "GatewayReceiver", "GatewaySender",
            "TotalPrimaryBucketCount", "TotalNumberOfLockService", "TotalNumberOfGrantors", "BytesReceivedRate",
            "BytesSentRate", "CurrentHeapSize", CURRENT_TIME, "Host" };
    /**
     * Contains list of attributes at various level
     */
    protected static final String[] SENDER_ATTR_NAMES = { "AlertThreshold", "AverageDistributionTimePerBatch",
            "BatchesDispatchedRate", "BatchSize", "BatchTimeInterval", "BytesOverFlowedToDisk", "DispatcherThreads",
            "EntriesOverFlowedToDisk", "EventQueueSize", "EventsExceedingAlertsThreshold", "EventsQueuedRate",
            "EventsReceivedRate", "GatewayEventFilters", "GatewayReceiver", "GatewayTransportFilters",
            "LRUEvictionsRate", "MaximumQueueMemory", "OrderPolicy", "OverflowDiskStoreName", "RemoteDSId", "SenderId",
            "SocketBufferSize", "SocketReadTimeout", "TotlBatchesRedistributed", "TotalEventsConflated",
            "BatchConflationEnabled", "Connected", "DiskSynchronous", "ManualStart", "Parellel", "Paused",
            "PersistenceEnabled", "Primary", "Running" };
    /**
     * Contains list of attributes at various level
     */
    protected static final String[] RECEIVER_ATTR_NAMES = { "AverageBatchProcessingTime", "BindAddress",
            "ClientConnectionCount", "ConnectedGatewaySenders", "ConnectionLoad", "ConnectionThreads",
            "CreateRequestsRate", "DestroyRequestsRate", "DuplicateBatchesReceived", "EndPort", "EventsReceivedRate",
            "GatewayTransportFilters", "GetRequestAvgLatency", "GetRequestRate", "LoadPerConnection", "LoadPerQueue",
            "MaximumTimeBetweenPings", "NumGateways", "OutOfOrderBatchesReceived", "Port", "PutRequestAvgLatency",
            "PutRequestRate", "QueueLoad", "SocketBufferSize", "StartPort", "ThreadQueueSize",
            "TotalConnectionsTimedOut", "TotalFailedConnectionAttempts", "TotalReceivedBytes", "TotalSentBytes",
            "UpdateRequestsRate", "Running" };
}




