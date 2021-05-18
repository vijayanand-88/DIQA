package com.asg.automation.utils;

import java.sql.*;
import java.util.*;

/**
 * Created by muthuraja.ramakrishn on 5/9/2017.
 */

@SuppressWarnings("DefaultFileTemplate")
public class DBPostgresUtil {

    private Connection conn = null;
    private Statement stmt=null;
    private ResultSet rs=null;

    public DBPostgresUtil() {
        PropertyLoader propLoader = new PropertyLoader();
        propLoader.loadProperty();
        String url = propLoader.prop.getProperty("qadatabaseurl");
        String user = propLoader.prop.getProperty("qauser");
        String password = propLoader.prop.getProperty("qapassword");
        try {
            conn = DriverManager.getConnection(url, user, password);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    public DBPostgresUtil(String connectionURL, String username, String password)
    {
        try {
            conn = DriverManager.getConnection(connectionURL, username, password);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connected to Database successfully.");
        } catch (SQLException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    //Verify such record exists in database.
    public int get_Value(String Query) throws SQLException {
        int returnValue;
        executeQuery(Query);
        rs.next();
        returnValue = rs.getInt(1);
        rs.close();
        return returnValue;

    }
    public String get_String_Value(String Query,String columnName) throws SQLException {
        String returnValue = null;
        executeQuery(Query);
        while(rs.next()) {
            returnValue =rs.getString(columnName);
        }

        rs.close();
        return returnValue;

    }

    public String get_String_Value(String Query) throws SQLException {
        String returnValue = null;
        executeQuery(Query);
        while(rs.next()) {
            returnValue =rs.getString(1);
        }
        rs.close();
        return returnValue;

    }

    public String deleteQuery(String schemaName, String TableName,String columnName, String value)
    {
        String results=null;
        results="delete from \"" + schemaName + "\".\"" + TableName + "\" where \""+ columnName + "\"="+"'"+value+"'"+"";
        return results;
    }

    public String deleteQuery(String schemaName, String TableName)
    {
        String results=null;
        results="delete from \"" + schemaName + "\".\"" + TableName +""+'"';
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),results);
        return results;
    }

    public String selectQuery(String schemaName, String TableName,String columnName, String value)
    {
        String results=null;
        results="select * from \"" + schemaName + "\".\"" + TableName + "\" where \""+ columnName + "\"="+value+"";
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),results);
        return results;
    }

    public String selectQuery(String schemaName, String TableName,String columnName, String conditionName, String value)
    {
        String results=null;
        results="select \"" + columnName + "\"  from \"" + schemaName + "\".\"" + TableName + "\" where \""+ conditionName + "\"=" +"'"+value+"'"+" ";
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),results);
        return results;
    }

    public String selectQuery(String schemaName, String TableName,String columnName, int value)
    {
        String results=null;
        results="select * from \"" + schemaName + "\".\"" + TableName + "\" where \""+ columnName + "\"="+value+"";
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),results);
        return results;
    }



    //Get rowcount from database
    public int get_rowCount(String Query) throws SQLException {
        int rowCount=0;
        executeQuery(Query);
        while(rs.next())
        {
            rowCount++;
        }
        rs.close();
        return rowCount;

    }

    public List<String> returnQueryIntList(String Query,String columnName) {
        ArrayList<String> returnqueryList = new ArrayList<String>();
        try {
            executeQuery(Query);
            while (rs.next()) {
                returnqueryList.add(Integer.toString(rs.getInt(columnName)));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Adding DB list to ArrayList");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        }
        return returnqueryList;

    }

    public List<String> returnQueryList(String schemaName, String TableName, String columnName, String conditionName, String value) {
        ArrayList<String> returnqueryList = new ArrayList<String>();
        try {
            executeQuery(selectQuery(schemaName, TableName, columnName,conditionName,value));
            while (rs.next()) {
                returnqueryList.add(rs.getString(columnName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Adding DB list to ArrayList");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        }
        return returnqueryList;

    }

    public List<String> returnQueryList(String Query,String columnName) {
        ArrayList<String> returnqueryList = new ArrayList<String>();
        try {
            executeQuery(Query);
            while (rs.next()) {
                returnqueryList.add(rs.getString(columnName));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Adding DB list to ArrayList");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        }
        return returnqueryList;

    }

    public Map<String,List<String>> returnQueryMap(String Query) {
        List<String> columnNames = new ArrayList<>();
        Map<String,List<String>> columnNameToValuesMap=new HashMap<String, List<String>>();
        try {
            executeQuery(Query);
            ResultSetMetaData metaData = rs.getMetaData();
            int colCount = metaData.getColumnCount();
            for(int i=1;i<=colCount;i++){
                String columnName = metaData.getColumnName(i);
                columnNames.add(columnName);
                columnNameToValuesMap.put(columnName, new ArrayList());
            }
            while (rs.next()) {
                for (String columnName : columnNames) {
                    //Get the list mapped to column name
                    List<String> columnDataList = columnNameToValuesMap.get(columnName);
                    //Add the current row's column data to list
                    columnDataList.add(rs.getString(columnName));
                    //add the updated list of column data to the map now
                    columnNameToValuesMap.put(columnName, columnDataList);
                }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Added Columns list to Map");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return columnNameToValuesMap;
    }





    private void displayRows(ResultSet rs) throws SQLException {
        while (rs.next()) {
            System.out.println(rs.getString("name") + "\t"
                    + rs.getString("sample"));

        }
    }

    public void executeQuery(String Query) throws SQLException {
        try {
            stmt = conn.createStatement();
            rs=stmt.executeQuery(Query);
        }catch(Exception e)
        {
            rs.close();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    //Using this method for JDBC Cataloger
    public void execute(String Query) throws SQLException{
        try {
            stmt = conn.createStatement();
            stmt.execute(Query);

        }catch(Exception e)
        {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            throw new SQLException(Query +" cannot be executed due to error"+e.getMessage());
        }

    }


    public void execute(List<String> Queries) throws SQLException{
        String Query = null;
        try {
            stmt = conn.createStatement();
            for(String value : Queries) {
                Query = value;
                stmt.execute(value);
            }
        }catch(Exception e)
        {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            throw new SQLException(Query +" cannot be executed due to error"+e.getMessage());
        }

    }

    public void disConnect() {

        try {
            conn.close();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database disconnected successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Connection Issues");
        }


    }

    public void updateQuery(String Query) {
        try {
            stmt = conn.createStatement();
            int rows = stmt.executeUpdate(Query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), +rows + "" + "Row Updated");

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }
    public String selectQuery(String schemaName, String TableName, String condition1, String value1, String condition2, String value2) {
        String results = null;
        results = "select * from \"" + schemaName + "\".\"" + TableName + "\" where \"" + condition1 + "\"=" + "'" + value1 + "'" + " and \"" + condition2 + "\"=" + value2 + "";
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), results);
        return results;
    }

    public int getMinValueFromResultSet(String Query){
        int minValue=0;
        Set<Integer> values = new TreeSet<>();
        try{
            stmt = conn.createStatement();
            rs=stmt.executeQuery(Query);
            while(rs.next()){
                values.add(rs.getInt(1));
            }
            minValue = Collections.min(values);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Minumum Value from Query Result is : "+minValue);
        }catch (SQLException e){
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return minValue;
    }

    public int getMaxValueFromResultSet(String Query){
        int maxValue=0;
        Set<Integer> values = new TreeSet<>();
        try{
            stmt = conn.createStatement();
            rs=stmt.executeQuery(Query);
            while(rs.next()){
                values.add(rs.getInt(1));
            }
            maxValue = Collections.max(values);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Maxmium Value from Query Result is : "+maxValue);
        }catch (SQLException e){
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return maxValue;
    }

    public Map<String,String> returnQueryasMap(String Query) {
        List<String> columnNames = new ArrayList<>();
        Map<String,String> columnNameToValuesMap=new HashMap<String,String>();
        try {
            executeQuery(Query);
            ResultSetMetaData metaData = rs.getMetaData();
            int colCount = metaData.getColumnCount();
            for(int i=1;i<=colCount;i++){
                String columnName = metaData.getColumnName(i);
                columnNames.add(columnName);
            }
            while (rs.next()) {
                for (String columnName : columnNames) {
                    columnNameToValuesMap.put(columnName, rs.getString(columnName));
                }
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Added Columns list to Map");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return columnNameToValuesMap;
    }

    //Created to return Map Value as List
    public List<String> returnMapasList(String Query){
        List<String> resultList = new ArrayList<>();
        Map<String,String> map = new HashMap<>();
        List<String> columnNames = new ArrayList<>();
        try{
            executeQuery(Query);
            ResultSetMetaData metaData = rs.getMetaData();
            int colCount = metaData.getColumnCount();
            int[] colNumber = new int[colCount];
            for(int i=0;i<=colCount-1;i++){
                colNumber[i] = i+1;
            }
            for(int j : colNumber){
                String columnName = metaData.getColumnName(j);
                columnNames.add(columnName);
            }
            while(rs.next())
            {
                for(String columnName: columnNames)
                {
                    map.put(columnName,rs.getString(columnName));

                }
            }
            Iterator<?> iterator = map.entrySet().iterator();
            while(iterator.hasNext()){
                Map.Entry<String, String> entry = (Map.Entry)iterator.next();
                String mapValue = (entry.getKey()+":"+entry.getValue());
                resultList.add(mapValue);
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Added Map to the List");
            }
        }catch (SQLException e){
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return resultList;
    }
}
