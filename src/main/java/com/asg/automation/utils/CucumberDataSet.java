package com.asg.automation.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 * Created by muthuraja.ramakrishn on 8/8/2017.
 */
public class CucumberDataSet {

    private String description;
    private String searchItems;
    private String expectedResults;
    private String tableName;
    private String columnName;
    private String criteriaName;
    private String schemaName;
    private String firstColName;
    private String secColName;
    private String typeName;
    private String attributeName;
    private String criteriaAttribute;

    private String cluster;
    private String dbSystem;
    private String dataType;
    private String xmiid;
    private String dataLength;
    private String dataScale;
    private String stage;
    private String def;
    private String database;
    private String dblocation;
    private String dbstorageType;
    private String dbtags;
    private String dbdef;
    private String table;
    private String tbucketsNumber;
    private String tcreatedBy;
    private String tdelimitedFields;
    private String tfilesCount;
    private String tinputType;
    private String tlocation;
    private String tmodifiedAt;
    private String tmodifiedBy;
    private String tpartitionedBy;
    private String tserdeLibrary;
    private String ttags;
    private String tstorageType;
    private String column;
    private String cdataOfType;
    private String cdataType;
    private String cxmiid;
    private String ctags;
    private String icluster;
    private String idirectory;
    private String ifile;
    private String igroup;
    private String icreatedBy;
    private String itags;
    private String queryName;
    private String filterQuery;
    private String facetField;
    private String sortField;
    private String sortOrder;
    private String lineageItemNames;
    private String lineageItemTypes;
    private String hamburgerMenuList;
    private String iconName;

    public String pathToConfig;
    public String configName;
    public String configValue;

    public String requestConfig;
    public String responseConfig;
    public String responseRequiredOnNextCall;
    public String valueToUpdate;
    public static List<String> sourceTree;
    public static List<String> functionName;
    public static List<String> searchList;
    public static List<String> classID;
    public static List<String> className;
    public String clusterName;
    public String hostName;
    private String jsonPath;
    private String jsonValues;


    public String getClusterName() {
        return clusterName;
    }

    public String getHostName() {
        return hostName;
    }

    public String hivePropertyName;
    public String hivePropertyValue;
    public String hdfsPropertyName;
    public String hdfsPropertyValue;
    public String logEntry;

    public String getLogEntry() {
        return logEntry;
    }

    public String name;

    public String widgetList;
    public String configurationLabelList;
    public String orderListItems;
    public String datasetItems;
    public String orderListRemovedItems;
    public String orderRequestItems;

    public String pluginList;

    public String attributeTableValues;

    public String previewPageAttributeList;
    public String jsonAttributeList;
    public String queryPageNameList;
    public String queryFieldNameList;
    public int queryNumber;
    public String jsonPageNameList;
    public String jsonFieldNameList;


    public String configurationFields;
    public String configurationValues;
    public String configurationLabelFields;
    public String configurationLabelValues;


    public String tableEntry;
    public String searchName;
    public String searchDes;
    public String widgetOne;
    public String widgetTwo;
    public String queryList;
    public String columns;
    public String datatype;
    public String itemViewNames;
    public String notebookHeaders;
    public String notebookNames;
    public String themeList;

    public String responseXmlText;
    public String responseMessage;
    public String year;
    public String userNames;
    public String responseText;

    private String itemName;
    private String criteriaValue;
    private String dataSetName;
    private String dataSetOverViewSections;
    private String dataSetFilters;
    private String tagName;
    private String subMenuList;
    private String lineageNodeName;
    private String lineageNodeType;
    private String action;
    private String width;
    private String height;
    private String lineageSubMenuOptions;
    private String diagramEdgeText;
    private List<String> diagramEdgeTextList;
    public static Map<String, String> FilenameTofunctionid=new HashMap<>();
    public static Map<String, String> FilenameToclassid =new HashMap<>();
    public static Map<String, String> FunctionidToHopid=new HashMap<>();
    public static Map<String, String> FunctionidToHopname=new HashMap<>();
    public static Map<String, String> ClasNameToFunctionID=new HashMap<>();
    private static Map<String, String> HopIDToLineFrom_To=new HashMap<>();;
    public static Map<String, String> FacetselectionNameToHopName=new HashMap<>();
    public static Map<String, String> processedItemsMap = new HashMap<>();
    private String commentText;
    private String popUpParameters;

    private String fileName;
    private String extension;
    private String saveas;
    private String path;
    private String destFileName;

    public void setTcreatedBy(String tcreatedBy) {
        this.tcreatedBy = tcreatedBy;
    }

    public String getTableEntry() {
        return tableEntry;
    }

    public String getQueryEntry() {
        return queryEntry;
    }

    public String queryEntry;

    public String dataElements;

    public String getDescription() {
        return description;
    }

    public String getSchemaName() {
        return schemaName;
    }

    public String getTypeName() {
        return typeName;
    }

    public String getCriteriaAttributeName() {
        return criteriaAttribute;
    }

    public String getSearchItems() {
        return searchItems;
    }

    public String getExpectedResults() {
        return expectedResults;
    }

    public String getTableName() {
        return tableName;
    }

    public String getColumnName() {
        return columnName;
    }

    public String getAttributeName() {
        return attributeName;
    }

    public String getCriteriaName() {
        return criteriaName;
    }

    public String getFirstColName() {
        return firstColName;
    }

    public String getSecColName() {
        return secColName;
    }


    public String getCluster() {
        return cluster;
    }

    public String getDbSystem() {
        return dbSystem;
    }

    public String getDataType() {
        return dataType;
    }

    public String getXmiid() {
        return xmiid;
    }

    public String getDataLength() {
        return dataLength;
    }

    public String getDataScale() {
        return dataScale;
    }

    public String getDef() {
        return def;
    }

    public String getStage() {
        return stage;
    }

    public String getDatabase() {
        return database;
    }

    public String getDbLocation() {
        return dblocation;
    }

    public String getDbStorageType() {
        return dbstorageType;
    }

    public String getDbTags() {
        return dbtags;
    }

    public String getDbDef() {
        return dbdef;
    }

    public String getTable() {
        return table;
    }

    public String getTbucketsNumber() {
        return tbucketsNumber;
    }

    public String getTcreatedBy() {
        return tcreatedBy;
    }

    public String getTdelimitedFields() {
        return tdelimitedFields;
    }

    public String getTfilesCount() {
        return tfilesCount;
    }

    public String getTinputType() {
        return tinputType;
    }

    public String getTlocation() {
        return tlocation;
    }

    public String getTmodifiedAt() {
        return tmodifiedAt;
    }

    public String getTmodifiedBy() {
        return tmodifiedBy;
    }

    public String getTpartitionedBy() {
        return tpartitionedBy;
    }

    public String getTserdeLibrary() {
        return tserdeLibrary;
    }

    public String getTtags() {
        return ttags;
    }

    public String getTstorageType() {
        return tstorageType;
    }

    public String getColumn() {
        return column;
    }

    public String getCxmiid() {
        return cxmiid;
    }

    public String getCdataType() {
        return cdataType;
    }

    public String getCdataOfType() {
        return cdataOfType;
    }

    public String getCtags() {
        return ctags;
    }

    public String getIcluster() {
        return icluster;
    }

    public String getIdirectory() {
        return idirectory;
    }

    public String getIfile() {
        return ifile;
    }

    public String getIgroup() {
        return igroup;
    }

    public String getIcreatedBy() {
        return icreatedBy;
    }

    public String getItags() {
        return itags;
    }

    public String getQueryName() {
        return queryName;
    }

    public String getFilterQuery() {
        return filterQuery;
    }

    public String getFacetField() {
        return facetField;
    }

    public String getSortField() {
        return sortField;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public String gethivePropertyName() {
        return hivePropertyName;
    }

    public String gethivePropertyValue() {
        return hivePropertyValue;
    }

    public String gethdfsPropertyName() {
        return hdfsPropertyName;
    }

    public String gethdfsPropertyValue() {
        return hdfsPropertyValue;
    }

    public String getfileName() {
        return name;
    }

    public String getWidgetListFromVisualComposer() {
        return widgetList;
    }

    public String getConfigurationPanelLabelList() {
        return configurationLabelList;
    }

    public String getUserNames() {
        return userNames;
    }

    public String getItemsFromOrderList() {
        return orderListItems;
    }

    public String getDatasetItemsFromList() {
        return datasetItems;
    }

    public String getRemovedItemsFromOrderList() {
        return orderListRemovedItems;
    }

    public String getorderRequestItems() {
        return orderRequestItems;
    }

    public String getAttributeTableValues() {
        return attributeTableValues;
    }

    public String getPreviewPageAttributeList() {
        return previewPageAttributeList;
    }

    public String getJsonAttributeList() {
        return jsonAttributeList;
    }

    public String getPageNameList() {
        return queryPageNameList;
    }

    public String getFieldNameList() {
        return queryFieldNameList;
    }

    public int getQueryNumber() {
        return queryNumber;
    }

    public String getJsonPageNameList() {
        return jsonPageNameList;
    }

    public String getJsonFieldNameList() {
        return jsonFieldNameList;
    }


    public String getConfigurationFieldNames() {
        return configurationFields;
    }

    public String getConfigurationValues() {
        return configurationValues;
    }

    public String getConfigFieldLabelNames() {
        return configurationLabelFields;
    }

    public String getConfigFieldLabelValues() {
        return configurationLabelValues;
    }

    public String getPluginListFromAvailablePlugins() {
        return pluginList;
    }

    public String getDataElements() {
        return dataElements;
    }

    public String getSearchName() {
        return searchName;
    }

    public String getSearchDesc() {
        return searchDes;
    }

    public String getWidgetOne() {
        return widgetOne;
    }

    public String getWidgetTwo() {
        return widgetTwo;
    }

    public String getItemName() {
        return itemName;
    }

    public String getItemViewNames() {
        return itemViewNames;
    }

    public String getNotebookHeaders() {
        return notebookHeaders;
    }

    public String getNotebookNames() {
        return notebookNames;
    }


    public String getDataSetOverViewSections() {
        return dataSetOverViewSections;
    }


    public String getDataSetName() {
        return dataSetName;
    }

    public String getDataSetFilters() {
        return dataSetFilters;
    }

    public String getTagName() {
        return tagName;
    }

    public String getThemeListInDiagram() {
        return themeList;
    }


    public String getJsonPath() {
        return jsonPath;
    }

    public String getJsonValues() {
        return jsonValues;
    }

    public String getYear() {
        return year;
    }


    public String getQueryList() {
        return queryList;
    }

    public String getTableCoulmns() {
        return columns;
    }

    public String getTableDataType() {
        return dataType;
    }

    public String getResponseXMLText() {
        return responseXmlText;
    }

    public String getResponseText() {
        return responseMessage;
    }

    public void printDataTableValue() {
        System.out.println("Description :" + description + "Search Items: " + searchItems + "Expected Results: " + expectedResults);
    }

    public String getSubMenuList() {
        return subMenuList;
    }

    public String getLineageItemNames() {
        return lineageItemNames;
    }

    public String getLineageItemTypes() {
        return lineageItemTypes;
    }

    public String getHamburgerMenuList() {
        return hamburgerMenuList;
    }

    public String getFileName() {
        return fileName;
    }

    public String getExtension() {
        return extension;
    }

    public String getsaveas() {
        return saveas;
    }

    public String getPath() {
        return path;
    }

    public String geDestFileName() {
        return destFileName;
    }

    public String getIconName() {
        return iconName;
    }

    public String getLineageNodeName() {
        return lineageNodeName;
    }

    public String getlineageNodeType() {
        return lineageNodeType;
    }

    public String getAction() {
        return action;
    }

    public String getWidth() {
        return width;
    }

    public String getHeight() {
        return height;
    }

    public String getLineageSubMenuOptions() {
        return lineageSubMenuOptions;
    }

    public String getDiagramEdgeText() {
        return diagramEdgeText;
    }

    public List<String> getDiagramEdgeText1() {
        return diagramEdgeTextList;
    }

    public String getCommentText() {
        return commentText;
    }
    public static Map<String, String> FilenameTofunctionid() {

        return FilenameTofunctionid;
    }

    public void setFnid(Map<String,String> value){
        this.FilenameTofunctionid=value;

    }

    public static Map<String, String> FilenameToclassid() {

        return FilenameToclassid;
    }

    public void setFilenameToclassid(Map<String,String> value){
        this.FilenameToclassid=value;

    }
    public static void setSourcetreeName(List<String> list) {
        sourceTree = list;
    }

    public static List<String> SourcetreeName() {
        return sourceTree;
    }

    public static List<String> FunctionName() {
        return functionName;
    }
    public static void setFunctionName(List<String> list) {
        functionName = list;
    }

    public static List<String> searchList() {
        return searchList;
    }
    public static void setsearchList(List<String> list) {
        searchList = list;
    }


    public static List<String> Classname() {
        return className;
    }
    public static void setClassname(List<String> list) {
        className = list;
    }

    public static List<String> Classid() {
        return classID;
    }
    public static void setClassid(List<String> list) {
        classID = list;
    }




    public static Map<String, String> functionidToLineageHopID()
    {
        return FunctionidToHopid;
    }
    public void setFunctionidToLineageHopID(Map<String,String> value){
        this.FunctionidToHopid=value;

    }

    public static Map<String, String> functionidToLineageHopName()
    {
        return FunctionidToHopname;
    }
    public void setfunctionidToLineageHopName(Map<String,String> value){
        this.FunctionidToHopname=value;

    }

    public static Map<String, String> ClassNameToFunctionID()
    {
        return ClasNameToFunctionID;
    }
    public void setClassNameToFunctionID(Map<String,String> value){
        this.ClasNameToFunctionID=value;

    }
    public static Map< String, String > HopID_LienFromandLTo() {
        return HopIDToLineFrom_To;
    }
    public void setLineageHopIDToLineageFrom_To(Map<String,String> value){
        this.HopIDToLineFrom_To=value;

    }

    public String getPopUpParameters() {
        return popUpParameters;
    }

    public static Map<String, String> facetSelectionNameToLineageHopName() {
        return FacetselectionNameToHopName;
    }
    public void setfacetSelectionNameToLineageHopName(Map<String, String> value) {
        this.FacetselectionNameToHopName = value;
    }

    public static Map<String,String> getProcessedItemMapValues(){return processedItemsMap;}

    public void setProcessedItemMapValues(Map<String,String> value){
        this.processedItemsMap = value;
    }

    public void clearProcessedItemMapValues(){
        this.processedItemsMap.clear();
    }
}