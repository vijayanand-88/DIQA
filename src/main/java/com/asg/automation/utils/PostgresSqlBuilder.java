package com.asg.automation.utils;


import ca.krasnay.sqlbuilder.SelectBuilder;
import ca.krasnay.sqlbuilder.UpdateBuilder;
import cucumber.api.DataTable;

import java.util.Arrays;
import java.util.List;

/**
 * Created by muthuraja.ramakrishn on 8/24/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class PostgresSqlBuilder {

    public static String getselectedColumnName=null;
    /*
    To build and return Query Builder
     */
    public String buildSqlQuery(DataTable returnQueryBuilder, List<String> criteriaValue, String... columnValue) {
        String query = null;
        List<CucumberDataSet> restAPI_dataTable_handlers = returnQueryBuilder.asList(CucumberDataSet.class);
        for (CucumberDataSet dataTable : restAPI_dataTable_handlers) {
            switch (dataTable.getDescription()) {
                case "SELECT":
                    SelectBuilder selectBuilder = new SelectBuilder();
                    List<String> columns = Arrays.asList(dataTable.getColumnName().split(","));
                    if (columns.size() > 1) {
                        for (String cols : columns) {
                            selectBuilder.column('"' + cols + '"');
                        }
                    } else {
                        getselectedColumnName = dataTable.getColumnName();
                        if(dataTable.getColumnName().isEmpty()){
                        } else if (dataTable.getColumnName().equals("*")) {
                            selectBuilder.column(dataTable.getColumnName());
                        } else
                            selectBuilder.column('"' + dataTable.getColumnName() + '"');
                    }
                    if(returnQueryBuilder.toString().contains("attributeName")){
                        selectBuilder.column("attributes" + dataTable.getAttributeName());
                    }
                    selectBuilder.from('"' + dataTable.getSchemaName() + '"' + "." + '"' + dataTable.getTableName() + '"');
                    if(returnQueryBuilder.toString().contains("typeName")){
                        selectBuilder.where('"' + "type" + '"' + "=" +"'" + dataTable.getTypeName() + "'");
                    }
                    if(returnQueryBuilder.toString().contains("criteriaAttribute")){
                        selectBuilder.where( dataTable.getCriteriaAttributeName() + "=" +"'" + criteriaValue.get(0) + "'");
                    }
                    if(dataTable.getCriteriaName().isEmpty()){
                    }else {
                    List<String> criteriaName = Arrays.asList(dataTable.getCriteriaName().split(","));
                    int count = 0;
                    if (criteriaValue.size() != 0) {
                        if (criteriaName.size() > 1) {
                            for (String criteria : criteriaName) {

                                if (isInteger(criteriaValue.get(count))) {
                                    selectBuilder.where('"' + criteria + '"' + "=" + criteriaValue.get(count));
                                } else {
                                    selectBuilder.where('"' + criteria + '"' + "=" + "'" + criteriaValue.get(count) + "'");
                                }
                                count++;
                            }
                        } else {
                            if (isInteger(criteriaValue.get(0))) {
                                selectBuilder.where('"' + dataTable.getCriteriaName() + '"' + "=" + criteriaValue.get(0));
                            } else {
                                selectBuilder.where('"' + dataTable.getCriteriaName() + '"' + "=" + "'" + criteriaValue.get(0) + "'");
                            }
                        }
                    }
                }
                        query = selectBuilder.toString();
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamic Query Generated " + selectBuilder.toString());

                        break;

                case "UPDATE":
                    UpdateBuilder updateBuilder = new UpdateBuilder('"' + dataTable.getSchemaName() + '"' + "." + '"' + dataTable.getTableName() + '"');
                    List<String> column = Arrays.asList(dataTable.getColumnName().split(","));
                    int length=0;
                    if (column.size() > 1) {
                        for (String cols : column) {
                            updateBuilder.set('"' + cols +'"'+ "=" + "'" + columnValue[length]+"'");
                            length++;
                        }
                    } else
                        updateBuilder.set('"' + dataTable.getColumnName() +'"'+ "=" + "'" + columnValue[0]+"'");
                    List<String> criteriaNames = Arrays.asList(dataTable.getCriteriaName().split(","));
                    int index = 0;
                    if (criteriaValue.size() != 0) {
                        if (criteriaNames.size() > 1) {
                            for (String criteria : criteriaNames) {

                                if (isInteger(criteriaValue.get(index))) {
                                    updateBuilder.where('"' + criteria + '"' + "=" + criteriaValue.get(index));
                                } else {
                                    updateBuilder.where('"' + criteria + '"' + "=" + "'" + criteriaValue.get(index) + "'");
                                }
                                index++;
                            }
                        } else {
                            if (isInteger(criteriaValue.get(0))) {
                                updateBuilder.where('"' + dataTable.getCriteriaName() + '"' + "=" + criteriaValue.get(0));
                            } else {
                                updateBuilder.where('"' + dataTable.getCriteriaName() + '"' + "=" + "'" + criteriaValue.get(0) + "'");
                            }

                        }
                        query = updateBuilder.toString();
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamic Query Generated " + updateBuilder.toString());
                        break;
                    }


            }
        }return query;
    }


    public String buildSqlQueryWithOperators(DataTable returnQueryBuilder, List<String> criteriaValue, String operator, String... columnValue) {
        String query = null;
        List<CucumberDataSet> restAPI_dataTable_handlers = returnQueryBuilder.asList(CucumberDataSet.class);
        for (CucumberDataSet dataTable : restAPI_dataTable_handlers) {
            switch (dataTable.getDescription()) {
                case "SELECT":
                    SelectBuilder selectBuilder = new SelectBuilder();
                    List<String> columns = Arrays.asList(dataTable.getColumnName().split(","));
                    if (columns.size() > 1) {
                        for (String cols : columns) {
                            selectBuilder.column('"' + cols + '"');
                        }
                    } else {
                        getselectedColumnName = dataTable.getColumnName();
                        if (dataTable.getColumnName().equals("*")) {
                            selectBuilder.column(dataTable.getColumnName());
                        } else
                            selectBuilder.column('"' + dataTable.getColumnName() + '"');
                    }
                    selectBuilder.from('"' + dataTable.getSchemaName() + '"' + "." + '"' + dataTable.getTableName() + '"');
                    List<String> criteriaName = Arrays.asList(dataTable.getCriteriaName().split(","));
                    int count = 0;
                    if (criteriaValue.size() != 0) {
                        if (criteriaName.size() > 1) {
                            for (String criteria : criteriaName) {

                                if (isInteger(criteriaValue.get(count))) {
                                    selectBuilder.where('"' + criteria + '"' + operator + criteriaValue.get(count));
                                } else {
                                    selectBuilder.where('"' + criteria + '"' + operator + "'" + criteriaValue.get(count) + "'");
                                }
                                count++;
                            }
                        } else {
                            if (isInteger(criteriaValue.get(0))) {
                                selectBuilder.where('"' + dataTable.getCriteriaName() + '"' + operator + criteriaValue.get(0));
                            } else {
                                selectBuilder.where('"' + dataTable.getCriteriaName() + '"' + operator + "'" + criteriaValue.get(0) + "'");
                            }
                        }
                        query = selectBuilder.toString();
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamic Query Generated " + selectBuilder.toString());

                        break;
                    }

                case "UPDATE":
                    UpdateBuilder updateBuilder = new UpdateBuilder('"' + dataTable.getSchemaName() + '"' + "." + '"' + dataTable.getTableName() + '"');
                    List<String> column = Arrays.asList(dataTable.getColumnName().split(","));
                    int length=0;
                    if (column.size() > 1) {
                        for (String cols : column) {
                            updateBuilder.set('"' + cols +'"'+ operator + "'" + columnValue[length]+"'");
                            length++;
                        }
                    } else
                        updateBuilder.set('"' + dataTable.getColumnName() +'"'+ operator + "'" + columnValue[0]+"'");
                    List<String> criteriaNames = Arrays.asList(dataTable.getCriteriaName().split(","));
                    int index = 0;
                    if (criteriaValue.size() != 0) {
                        if (criteriaNames.size() > 1) {
                            for (String criteria : criteriaNames) {

                                if (isInteger(criteriaValue.get(index))) {
                                    updateBuilder.where('"' + criteria + '"' + operator + criteriaValue.get(index));
                                } else {
                                    updateBuilder.where('"' + criteria + '"' + operator + "'" + criteriaValue.get(index) + "'");
                                }
                                index++;
                            }
                        } else {
                            if (isInteger(criteriaValue.get(0))) {
                                updateBuilder.where('"' + dataTable.getCriteriaName() + '"' + operator + criteriaValue.get(0));
                            } else {
                                updateBuilder.where('"' + dataTable.getCriteriaName() + '"' + operator + "'" + criteriaValue.get(0) + "'");
                            }

                        }
                        query = updateBuilder.toString();
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Dynamic Query Generated " + updateBuilder.toString());
                        break;
                    }


            }
        }return query;
    }

    private static boolean isInteger(String input) {
        try {
            Integer.parseInt(input);
            return true;
        } catch (Exception e) {
            return false;
        }

    }

}
