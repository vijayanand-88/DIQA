package com.asg.automation.utils;
import org.testng.Assert;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class HiveJdbc {

    @SuppressWarnings("DefaultFileTemplate")
    private String driver = Constant.HIVEJDBCDRIVER;
    protected PropertyLoader propLoader;

    public HiveJdbc() {
        try {
            Class.forName(driver);
            propLoader = new PropertyLoader();
            propLoader.loadProperty();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    public void runHiveQuery(String query) throws SQLException {

        Connection connect = DriverManager.getConnection(propLoader.prop.getProperty("HiveJDBC"));
        Statement state = connect.createStatement();
        // The query does not generate a result set, so using execute()
        state.execute(query);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), query+": Query Executed successfully");
        // closing the state
        state.close();
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ": State closed successfully");
        // closing the connection pool
        connect.close();
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), ": connected closed successfully");
    }

    public int checkTableRowsCountPresentInHive(String query) throws SQLException {
        int rowCount = 0;
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(propLoader.prop.getProperty("HiveJDBC"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Connection established");
            Statement stmt = connection.createStatement();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "statement is created");
            ResultSet set = stmt.executeQuery(query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query :" + query + " has been executed");
            while(set.next()){
               rowCount ++;
               }
               LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"No of rows found in a table : " +rowCount);
        } catch (SQLException e) {
            Assert.fail("Query :" + query + " can't be executed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query :" + query + " can't be completed" + e.getMessage());
        } finally {
            connection.close();
        }

        return rowCount;

    }

    public Map returnHiveTableDescToMap(String query, int keyIndex, int valueIndex) throws SQLException {
        Map<String, String> map = new HashMap();
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(propLoader.prop.getProperty("HiveJDBC"));
            Statement stmt = connection.createStatement();
            ResultSet set = stmt.executeQuery(query);
            while (set.next()) {
                String col1 = set.getString(keyIndex);
                String col2 = set.getString(valueIndex);
                map.put(col1, col2);
            }
        }catch (Exception e){
            Assert.fail("Query :" + query + " can't be executed");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query :" + query + " can't be completed" + e.getMessage());
        } finally {
            connection.close();
        }
        return map;
    }

    public List returnHiveQueryValuesToList(String query, int Index) throws SQLException {
        List<String> values = new ArrayList<>();
        Connection connection=null;
        try {
            connection = DriverManager.getConnection(propLoader.prop.getProperty("HiveJDBC"));
            Statement stmt = connection.createStatement();
            ResultSet set = stmt.executeQuery(query);
            while (set.next()) {
              values.add(set.getString(Index));
              }
              System.out.println(values.size());
        }catch (Exception e) {
            Assert.fail("Query :" + query + " can't be executed " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query :" + query + " can't be completed" + e.getMessage());
        } finally {
            if(connection!=null)
            connection.close(); }
        return values;
    }

    }
