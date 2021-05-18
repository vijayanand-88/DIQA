package com.asg.automation.utils;

import com.asg.utils.databaseutils.CassandraDBUtil;
import com.asg.utils.databaseutils.MongoDBUtil;
import org.bson.Document;
import org.testng.Assert;

import java.sql.ResultSet;
import java.util.*;

/**
 * Created by Chella Mohan Mari on 8/3/2019. This helper class is created to connect with Database utils like DBPostgres, Mongo Util and etc
 */

public class DBHelper {

    DBPostgresUtil dbPostgresUtil;
    MongoDBUtil mongoDBUtil;
    CassandraDBUtil cassandraDBUtil;
    ResultSet rs = null;


    //Connects to the Database depending on the text "Oracle" or "DB2" and etc
    private void connection(String database) {
        PropertyLoader propLoader = new PropertyLoader();
        propLoader.loadProperty();
        try {
            switch (database.toUpperCase()) {
                case "ORACLE":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl"), propLoader.prop.getProperty("oracleuser"), propLoader.prop.getProperty("oraclepassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle DB");
                    break;

                case "DB2":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("db2url"), propLoader.prop.getProperty("db2user"), propLoader.prop.getProperty("db2password"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to DB2 DB");
                    break;

                case "DB2_11_5":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("db2url_11_5"), propLoader.prop.getProperty("db2user_11_5"), propLoader.prop.getProperty("db2password_11_5"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to DB2 DB");
                    break;

                case "MONGO":
                    mongoDBUtil = new MongoDBUtil(propLoader.prop.getProperty("mongoDBHostName"), propLoader.prop.getProperty("mongoDBPort"), propLoader.prop.getProperty("mongoDBUserName"), propLoader.prop.getProperty("mongoDBPassword"), propLoader.prop.getProperty("mongoDBDataBase"));
                    mongoDBUtil.createConnection(true);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Mongo");
                    break;

                case "POSTGRES":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("postgresurl"), propLoader.prop.getProperty("postgresuser"), propLoader.prop.getProperty("postgrespassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to postgres DB");
                    break;

                case "POSTGRES_RDS":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("postgresurl_rds"), propLoader.prop.getProperty("postgresuser"), propLoader.prop.getProperty("postgrespassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to postgres DB RDS");
                    break;

                case "MSSQL_OLD":
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("mssql_old_url"), propLoader.prop.getProperty("mssql_old_user"), propLoader.prop.getProperty("mssql_old_password"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to MS-SQL old DB of URL : "+propLoader.prop.getProperty("mssql_old_url"));
                    break;

                case "MSSQL_RDS":
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("mssql_rds_Url"), propLoader.prop.getProperty("mssql_rds_Userid"), propLoader.prop.getProperty("mssql_rds_Password"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to MS-SQL RDS DB");
                    break;

                case "CASSANDRA":
                    cassandraDBUtil = new CassandraDBUtil(propLoader.prop.getProperty("cassandraIP")).connectDatabase();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Cassandra DB");
                    break;

                case "TERADATA":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("teradataurl"), propLoader.prop.getProperty("teradatauser"), propLoader.prop.getProperty("teradatapassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to teradata DB");
                    break;

                case "APPDBPOSTGRES":
                    dbPostgresUtil = new DBPostgresUtil();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to teradata DB");
                    break;

                case "DB2MAINFRAME":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("db2url_mainframe"), propLoader.prop.getProperty("db2user_mainframe"), propLoader.prop.getProperty("db2password_mainframe"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to DB2 mainframe DB");
                    break;

                case "ORACLE12C":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_12c"), propLoader.prop.getProperty("oracleuser_12c"), propLoader.prop.getProperty("oraclepassword_12c"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 12c DB");
                    break;

                case "SNOWFLAKE":
                    Class.forName("net.snowflake.client.jdbc.SnowflakeDriver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("snowflakeurl"), propLoader.prop.getProperty("snowflakeuser"), propLoader.prop.getProperty("snowflakepassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to snowflake DB");
                    break;

                case "REDSHIFT":
                    Class.forName("com.amazon.redshift.jdbc42.Driver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("redshiftURL"), propLoader.prop.getProperty("redshiftDBuser"), propLoader.prop.getProperty("redshiftDBpassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Redshift DB");
                    break;

                case "ORACLE12C_CDB":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_12c_CDB"), propLoader.prop.getProperty("oracleuser_12c_CDB"), propLoader.prop.getProperty("oraclepassword_12c_CDB"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 12c CDB database");
                    break;

                case "TERADATA_DB16":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("teradataurl_db16"), propLoader.prop.getProperty("teradatauser"), propLoader.prop.getProperty("teradatapassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to teradata DB version 16");
                    break;

                case "ORACLE19C_PDB":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_19c_PDB"), propLoader.prop.getProperty("oracleuser_19c_PDB"), propLoader.prop.getProperty("oraclepassword_19c_PDB"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 19c CDB database");
                    break;

                case "ORACLE19C_CDB":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_19c_CDB"), propLoader.prop.getProperty("oracleuser_19c_CDB"), propLoader.prop.getProperty("oraclepassword_19c_CDB"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 12c CDB database");
                    break;

                case "ORACLE19C_RDS":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_19c_RDS"), propLoader.prop.getProperty("oracleuser_19c_RDS"), propLoader.prop.getProperty("oraclepassword_19c_RDS"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 19c RDS");
                    break;

                case "ORACLE19C_USEAST2_RDS":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_19c_USEAST2_RDS"), propLoader.prop.getProperty("oracleuser_19c_USEAST2_RDS"), propLoader.prop.getProperty("oraclepassword_19c_USEAST2_RDS"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 19c RDS");
                    break;


                case "ORACLE12C_RDS":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_12c_RDS"), propLoader.prop.getProperty("oracleuser_12c_RDS"), propLoader.prop.getProperty("oraclepassword_12c_RDS"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 12c RDS");
                    break;

                case "ORACLE18C_PDB":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_18c_PDB"), propLoader.prop.getProperty("oracleuser_18c_PDB"), propLoader.prop.getProperty("oraclepassword_18c_PDB"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 18c PDB database");
                    break;

                case "ORACLE18C_RDS":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("oracleurl_18c_RDS"), propLoader.prop.getProperty("oracleuser_18c_RDS"), propLoader.prop.getProperty("oraclepassword_18c_RDS"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 18c RDS");
                    break;

                case "MYSQL":
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    dbPostgresUtil=new DBPostgresUtil(propLoader.prop.getProperty("mysqlurl"),propLoader.prop.getProperty("mysqlusername"),propLoader.prop.getProperty("mysqlpassword"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 18c RDS");
                    break;

                case "SYBASE_JDBC":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("sybase_jdbc_url"), propLoader.prop.getProperty("sybase_user"), propLoader.prop.getProperty("sybase_password"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 18c RDS");
                    break;

                case "SYBASE_TESTING":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("sybase_testing_url"), propLoader.prop.getProperty("sybase_user"), propLoader.prop.getProperty("sybase_password"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Oracle 18c RDS");
                    break;

                case "SQLSERVER_RDS":
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("sqlServerDBUrl_RDS"), propLoader.prop.getProperty("sqlServerDBuser_RDS"), propLoader.prop.getProperty("sqlServerDBpassword_RDS"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to SqlServer DB");
                    break;

                case "SQLSERVER_ONPREM":
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("sqlServerDBUrl_OnPrem"), propLoader.prop.getProperty("sqlServerDBuser_OnPrem"), propLoader.prop.getProperty("sqlServerDBpassword_OnPrem"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to SqlServer DB");
                    break;

                case "ZOS_DB2":
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("zOS_DB2_URL"), propLoader.prop.getProperty("zOS_DB2_username"), propLoader.prop.getProperty("zOS_DB2_password"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to zOS Db2");
                    break;



                case "SQLSERVER":
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    dbPostgresUtil = new DBPostgresUtil(propLoader.prop.getProperty("sqlServerURL"), propLoader.prop.getProperty("sqlServerUserName"), propLoader.prop.getProperty("sqlServerPwd"));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to SQL Server DB");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Connection failed due to " + e.getMessage());
        }
    }


    //Executes a sql query for Create, Insert, Delete and Drop
    public void executeSQL(String... data) {
        // data[0]= databaseConnection.
        // data[1] = Operation.
        // data[2] = query.
        // data[3]= SchemaName.
        // data[4]= tableName.
        // data[5]= columnName.
        // data[6]=  columnValue.
        // data[7]= databaseName
        try {
            switch (data[1].toUpperCase()) {
                case "EXECUTEQUERY":
                    connection(data[0]);
                    dbPostgresUtil.execute(data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB query executed");
                    break;

                case "CREATE":
                    connection(data[0]);
                    if (data[0].equalsIgnoreCase("oracle")) {
                        dbPostgresUtil.execute("CREATE TABLE " + data[4] + " (" + data[5] + " varchar2(21))");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Created Table");
                    } else if (data[0].equalsIgnoreCase("db2")) {
                        dbPostgresUtil.execute("CREATE TABLE " + data[3] + "." + data[4] + " (" + data[5] + " varchar(20));");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Created Table");
                    } else if (data[0].equalsIgnoreCase("postgres")) {
                        dbPostgresUtil.execute("CREATE TABLE " + data[4] + " (" + data[5] + " varchar(20));");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Created Table");
                    } else if (data[0].equalsIgnoreCase("teradata")) {
                        dbPostgresUtil.execute("CREATE TABLE " + data[7] + "." + data[4] + " (" + data[5] + " varchar(20));");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Created Table");
                    }
                    break;

                case "INSERT":
                    connection(data[0]);
                    if (data[0].equalsIgnoreCase("oracle")) {
                        dbPostgresUtil.execute("INSERT INTO " + data[4] + "(" + data[5] + ")VALUES('" + data[6] + "')");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data Inserted into Table");
                    } else if (data[0].equalsIgnoreCase("db2")) {
                        dbPostgresUtil.execute("INSERT INTO " + data[4] + "(" + data[5] + ") VALUES('" + data[6] + "'); Commit;");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data Inserted into Table");
                    } else if (data[0].equalsIgnoreCase("postgres")) {
                        dbPostgresUtil.execute("INSERT INTO " + data[4] + "(" + data[5] + ") VALUES('" + data[6] + "');");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data Inserted into Table");
                    } else if (data[0].equalsIgnoreCase("teradata")) {
                        dbPostgresUtil.execute("INSERT INTO " + data[7] + "." + data[4] + "(" + data[5] + ") VALUES('" + data[6] + "'); ");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data Inserted into Table");
                    }
                    break;

                case "DROP":
                    connection(data[0]);
                    if (data[0].equalsIgnoreCase("oracle")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[4]);
                    } else if (data[0].equalsIgnoreCase("db2")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[3] + "." + data[4]);
                    } else if (data[0].equalsIgnoreCase("DB2_11_5")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[3] + "." + data[4]);
                    } else if (data[0].equalsIgnoreCase("postgres")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[4] + "; Commit;");
                    } else if (data[0].equalsIgnoreCase("teradata") | data[0].equalsIgnoreCase("teradata_db16")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[7] + "." + data[4] + "; Commit;");
                    } else if (data[0].equalsIgnoreCase("oracle12c")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[3] + "." + data[4]);
                    } else if (data[0].equalsIgnoreCase("redshift")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[3] + "." + data[4]);
                    } else if (data[0].equalsIgnoreCase("mssql_old")) {
                        dbPostgresUtil.execute("DROP TABLE " + data[3] + "." + data[4]);
                    }
                    break;

                case "DELETE":
                    connection(data[0]);
                    if (data[0].equalsIgnoreCase("oracle")) {
                        dbPostgresUtil.execute("delete from " + data[3] + "." + data[4] + " where " + data[5] + "=" + "'" + data[6] + "'");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value from the DB is deleted");
                    } else if (data[0].equalsIgnoreCase("db2")) {
                        dbPostgresUtil.execute("delete from " + data[3] + "." + data[4] + " where " + data[5] + "=" + "'" + data[6] + "'");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value from the DB is deleted");
                    } else if (data[0].equalsIgnoreCase("postgres")) {
                        dbPostgresUtil.execute("delete from " + data[3] + "." + data[4] + " where " + data[5] + "=" + "'" + data[6] + "'");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value from the DB is deleted");
                    } else if (data[0].equalsIgnoreCase("teradata")) {
                        dbPostgresUtil.execute("delete from " + data[7] + "." + data[4] + " where " + data[5] + "=" + "'" + data[6] + "'");
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value from the DB is deleted");
                    }
                    break;

                case "EXECUTELISTOFQUERIES":
                    connection(data[0]);
                    String[] queries = data[2].split(",");
                    List<String> queryList = new LinkedList<>();
                    for (String value : queries) {
                        queryList.add(value);
                    }
                    dbPostgresUtil.execute(queryList);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB query executed");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("SQL statement cannot be executed : " + e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connection is Closed");
            }
        }

    }

    //Executes a NoSQL statement for Insert and Delete
    public void executeNoSQL(Document document, String... data) {
        //data[0]= databaseConnection.
        // data[1]= operation.
        // data[2]= collectionName.
        // data[3] = mongoDBName
        // data[4] = objectID
        try {
            switch (data[1].toUpperCase()) {
                case "INSERT":
                    connection(data[0]);
                    mongoDBUtil.getDBName(data[3]);
                    mongoDBUtil.insertDocument(data[2], document);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Document is inserted into MongoDB");
                    break;

                case "DELETE":
                    connection(data[0]);
                    mongoDBUtil.getDBName(data[3]);
                    mongoDBUtil.deleteDocument(data[2], data[4]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Document is deleted from MongoDB");
                    break;

            }

        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            if (mongoDBUtil != null) {
                mongoDBUtil.closeConnection();
            }
        }

    }


    //Executes a NoSQL statement for Insert and Delete
    public void executeCassandra(String... data) {
        //data[0]= databaseConnection.
        //data[1]=dataTypeAction
        // data[2]= operation.
        // data[3]= keySpaceName.
        // data[4] = tableName
        //data[5] = query

        try {
            switch (data[1]) {
                case "createKeySpace":
                    connection(data[0]);
                    cassandraDBUtil.keySpaceOperation(data[4], data[3], data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Key Space created in Cassandra DB");
                    break;
                case "dropKeySpace":
                    connection(data[0]);
                    cassandraDBUtil.keySpaceOperation(data[4], data[3], data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Key Space dropped in Cassandra DB");
                    break;

                case "createTable":
                    connection(data[0]);
                    cassandraDBUtil.tableOperation(data[4], data[3], data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table created in Cassandra DB");
                    break;

                case "dropTable":
                    connection(data[0]);
                    cassandraDBUtil.tableOperation(data[4], data[3], data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table dropped in Cassandra DB");
                    break;

                case "insertData":
                    connection(data[0]);
                    cassandraDBUtil.dataOperation(data[4], data[3], data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table deleted from Cassandra DB");
                    break;

                case "alterTable":
                    connection(data[0]);
                    cassandraDBUtil.tableOperation(data[4], data[3], data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table deleted from Cassandra DB");
                    break;

            }

        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            if (cassandraDBUtil != null) {
                cassandraDBUtil.closeConnection();
            }
        }

    }


    //Returns the result from DB in list for SQL & NoSQL DB
    public List<String> returnRecordInlist(String... data) {
        //data[0]= databaseType(Structured/unStructured).
        // data[1]= databaseConnection.
        // data[2] = query.
        // data[3] = columnName
        List<String> resultList = new ArrayList<>();
        try {
            switch (data[0].toUpperCase()) {
                case "UNSTRUCTURED":
                    connection(data[1]);
                    resultList = mongoDBUtil.getDBNames();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Mongo DB records are returned in List");
                    break;

                case "STRUCTURED":
                    connection(data[1]);
                    resultList = dbPostgresUtil.returnQueryList(data[2], data[3]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB records are returned in List");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB connection closed");
            } else if (mongoDBUtil != null) {
                mongoDBUtil.closeConnection();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Mongo db connection closed");
            }
        }
        return resultList;
    }

    //Gets the rows count for SQL and NoSQL DB
    public int getRecordCount(String... data) {
        //data[0]= databaseType(Structured/unStructured).
        // data[1]= databaseConnection.
        // data[2] = query.
        // data[3] = collectionName
        int result = 0;
        try {
            switch (data[0].toUpperCase()) {
                case "UNSTRUCTURED":
                    connection(data[1]);
                    result = (int) mongoDBUtil.getCollectionCount(data[3]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Returns the collection count in MongoDB");
                    break;

                case "STRUCTURED":
                    connection(data[1]);
                    result = dbPostgresUtil.get_rowCount(data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Returns the row count of DB");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB connection closed");
            } else if (mongoDBUtil != null) {
                mongoDBUtil.closeConnection();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Mongo db connection closed");
            }
        }
        return result;
    }

    //Deletes a record from SQL and NoSQL DB
    public void deleteRecord(String... data) {
        //data[0]= databaseType(Structured/Unstructured)
        // data[1]=  databaseConnection. //data[2]= collectionName
        // data[3]= objectID.
        // data[4]= SchemaName.
        // data[5]= tableName.
        // data[6]= columnName.
        // data[7]=  value
        try {
            switch (data[0].toUpperCase()) {
                case "UNSTRUCTURED":
                    connection(data[1]);
                    mongoDBUtil.deleteDocument(data[2], data[3]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Record is deleted from MongoDB");
                    break;

                case "STRUCTURED":
                    connection(data[1]);
                    if ((data[7] != null) && (data[6] != null)) {
                        dbPostgresUtil.deleteQuery(data[4], data[5], data[6], data[7]);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value from the MongoDB is deleted");
                    } else {
                        dbPostgresUtil.deleteQuery(data[4], data[5]);
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table from the MongoDB is deleted");
                    }
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB connection closed");
            } else if (mongoDBUtil != null) {
                mongoDBUtil.closeConnection();
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Mongo db connection closed");
            }
        }
    }

    //Returns the results in list for SQL queries
    public List<String> returnQueryInList(String... data) {
        //data[0] = databaseConnection .
        // data[1] = queryOperation.
        // data[2] = query.
        // data[3]=schemaName. //data[4]=tableName. //data[5]= columnName. //data[6]= conditionName. //data[7]= value
        List<String> resultList = new ArrayList<>();
        try {
            switch (data[1].toLowerCase()) {
                case "returnstringlist":
                    connection(data[0]);
                    resultList = dbPostgresUtil.returnQueryList(data[2], data[5]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "String values are got in the List");
                    break;

                case "returnintlist":
                    connection(data[0]);
                    resultList = dbPostgresUtil.returnQueryIntList(data[2], data[3]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Int values are got in the List");
                    break;

                case "returnvalue":
                    connection(data[0]);
                    resultList = dbPostgresUtil.returnQueryList(data[3], data[4], data[5], data[6], data[7]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value is returned from the DB");
                    break;

                case "returnmaplist":
                    connection(data[0]);
                    resultList = dbPostgresUtil.returnMapasList(data[2]);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Map value is returned as List");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            {
                if (dbPostgresUtil != null) {
                    dbPostgresUtil.disConnect();
                }
            }
            return resultList;
        }
    }

    //Returns the result value as Map
    public Map<String, String> returnQueryasMap(String databaseConnection, String Query) {
        Map<String, String> resultMap = new HashMap<>();
        try {
            connection(databaseConnection);
            resultMap = dbPostgresUtil.returnQueryasMap(Query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value is returned as Map");
        } catch (Exception e) {
            Assert.fail("Values not retrieved");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
            }
        }
        return resultMap;

    }


    //Returns the single row query result as string
    public String returnValue(String databaseConnection, String Query) {
        String value = null;
        try {
            connection(databaseConnection);
            value = String.valueOf(dbPostgresUtil.get_Value(Query));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value is returned as Map");
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
            }
        }
        return value;

    }

    //Returns the single row query result as string
    public String returnStringValue(String databaseConnection, String Query, String columnName) {
        String value = null;
        try {
            connection(databaseConnection);
            value = dbPostgresUtil.get_String_Value(Query, columnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value is returned as Map");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
            }
        }
        return value;

    }

    //Returns the result value as Map and the Map.Value as List
    public Map<String, List<String>> returnQueryMap(String databaseConnection, String Query) {
        Map<String, List<String>> resultMap = new HashMap<>();
        try {
            connection(databaseConnection);
            resultMap = dbPostgresUtil.returnQueryMap(Query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Value is returned as Map");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
            }
        }
        return resultMap;
    }

    //Returns the MaxValue and MinValue from the result
    public int getValue(String databaseConnection, String getValue, String Query) {
        int value = 0;
        try {
            switch (getValue.toUpperCase()) {
                case "MAXVALUE":
                    connection(databaseConnection);
                    value = dbPostgresUtil.getMaxValueFromResultSet(Query);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Max value is returned from ResultSet");
                    break;

                case "MINVALUE":
                    connection(databaseConnection);
                    value = dbPostgresUtil.getMinValueFromResultSet(Query);
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Max value is returned from ResultSet");
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            if (dbPostgresUtil != null) {
                dbPostgresUtil.disConnect();
            }
        }
        return value;
    }

    /**
     * return values from database rows in map
     *
     * @param dbValues
     * @param keyColumnName
     * @param valueColumnName
     * @return
     */
    public Map<String, Integer> returnDBRowValuesInMap(Map<String, List<String>> dbValues, String keyColumnName, String valueColumnName) {
        Map<String, Integer> newMap = null;
        try {
            List<String> key = new ArrayList<String>();
            List<String> value = new ArrayList<>();
            for (Map.Entry<String, List<String>> s : dbValues.entrySet()) {
                if (s.getKey().equals(keyColumnName)) {
                    key.addAll(s.getValue());

                } else if (s.getKey().equals(valueColumnName)) {
                    value.addAll(s.getValue());
                }
            }
            newMap = new HashMap<>();
            for (int i = 0; i < key.size(); i++) {
                for (int j = 0; j < value.size(); j++) {
                    newMap.put(key.get(i), Integer.valueOf(value.get(j)));
                    i++;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return newMap;
    }


    public List<String> returnRowValuesInList(Map<String, List<String>> dbValues, String keyColumnName) {
        List<String> key = new ArrayList<String>();
        try {
            for (Map.Entry<String, List<String>> s : dbValues.entrySet()) {
                if (s.getKey().equals(keyColumnName)) {
                    key.addAll(s.getValue());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return key;
    }

    /**
     * return values from database rows in map.key will be id and value will be name
     *
     * @param dbValues
     * @param keyColumnName
     * @param valueColumnName
     * @return
     */
    public Map<Integer, String> returnDBRowValuesInMap1(Map<String, List<String>> dbValues, String keyColumnName, String valueColumnName) {
        Map<Integer, String> newMap = null;
        try {
            List<String> key = new ArrayList<String>();
            List<String> value = new ArrayList<>();
            for (Map.Entry<String, List<String>> s : dbValues.entrySet()) {
                if (s.getKey().equals(keyColumnName)) {
                    key.addAll(s.getValue());

                } else if (s.getKey().equals(valueColumnName)) {
                    value.addAll(s.getValue());
                }
            }
            newMap = new HashMap<>();
            for (int i = 0; i < key.size(); i++) {
                for (int j = 0; j < value.size(); j++) {
                    newMap.put(Integer.valueOf(key.get(i)), value.get(j));
                    i++;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return newMap;
    }


}


