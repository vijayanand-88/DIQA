package com.asg.automation.utils;

import cucumber.api.DataTable;

import java.util.List;

/**
 * Created by muthuraja.ramakrishn on 8/8/2017.
 */
public class DataSetHandler {

    public String getValue(DataTable dataTableCollection, String fieldName) {
        String fieldValue = null;
        List<CucumberDataSet> dataTable = dataTableCollection.asList(CucumberDataSet.class);
        for (CucumberDataSet cols : dataTable) {
            switch (fieldName) {
                case "firstColName":
                    fieldValue = cols.getFirstColName();
                    break;
                case "secColName":
                    fieldValue = cols.getSecColName();
                    break;
                case "criteriaName":
                    fieldValue = cols.getCriteriaName();
                    break;
                case "tableName":
                    fieldValue = cols.getTableName();
                    break;
                case "clusterName":
                    fieldValue = cols.getClusterName();
                    break;
                case "hostName":
                    fieldValue = cols.getHostName();
                    break;
                case "name":
                    fieldValue = cols.getfileName();
                    break;
                case "searchName":
                    fieldValue = cols.getSearchName();
                    break;
                case "searchDesc":
                    fieldValue = cols.getSearchDesc();
                    break;
                case "widgetOne":
                    fieldValue = cols.getWidgetOne();
                    break;
                case "widgetTwo":
                    fieldValue = cols.getWidgetTwo();
                    break;
                default:
                    break;
            }

        }

        return fieldValue;
    }

}
