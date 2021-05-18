package com.asg.automation.utils.jmxUtil;

import com.asg.automation.utils.Constant;
import com.asg.automation.utils.FileUtil;

import com.asg.automation.utils.LoggerUtil;
import org.neo4j.driver.v1.*;

import java.util.*;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;


public class Neo4jBase implements AutoCloseable {

    private Driver driver;

    public void createDbConnection(String uri, String user, String password) {
        driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));


    }

    @Override
    public void close() throws Exception {
        driver.close();
    }

    public String createData(String filePath) {
        Session session = driver.session();
        try {
            String result = session.writeTransaction(new TransactionWork<String>() {
                @Override
                public String execute(Transaction tx) {
                    String query = new FileUtil().returnFileContentToSTring(filePath);

                    query = query.replaceAll("\"", "\\\"");


                    StatementResult result = tx.run(query);


                    tx.success();
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data from file executed successfully");
                    return result.toString();
                }
            });
            return result;
        } finally {
            session.close();
        }
    }

    public List<String> getLabels() {
        Session session = driver.session();
        try {
            List<String> listOfNodeLabelName = new ArrayList<String>();
            StatementResult result = session.run("call db.labels");

            while (result.hasNext()) {
                String record = result.next().get(0).toString();
                String[] relNames = record.replace("[", "").replace("]", "").split(",");

                for (String nodeLabelName : relNames) {
                    nodeLabelName.replaceAll("^\"|\"$", "");
                    listOfNodeLabelName.add(nodeLabelName);
                }

            }
            return listOfNodeLabelName;
        } finally {
            session.close();
        }

    }

    public List<String> readNeo4jComponents() {
        try {
            Session session = driver.session();
            List<String> neo4jComponents = session
                    .writeTransaction(new TransactionWork<List<String>>() {

                        @Override
                        public List<String> execute(Transaction tx) {
                            List<String> listOfComponents = new ArrayList<String>();

                            StatementResult result = tx.run(Constant.readNeo4jComponents);
                            while (result.hasNext()) {
                                Record values = result.next();
                                List<Value> listOfValus = values.values();
                                for (Value singleValue : listOfValus) {
                                    String components = singleValue.toString().replace("[", "").replace("]", "")
                                            .replaceAll("^\"|\"$", "");
                                    listOfComponents.add(components);
                                }
                                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Values :::" + listOfComponents.get(1));
                                tx.close();
                                session.close();
                            }
                            return listOfComponents;
                        }
                    });
            return neo4jComponents;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve Neo4j Components :" + e.toString());
        }
        return null;
    }


    public Value writeTxn(String query) {
        Session session = driver.session();
        try {
            Value value = session.writeTransaction(new TransactionWork<Value>() {
                @Override
                public Value execute(Transaction tx) {
                    StatementResult result = tx.run(query);
                    tx.close();
                    return result.single().get(0);
                }
            });
            return value;
        } finally {
            session.close();
        }
    }


    public void delete(String query) {
        Session session = driver.session();
        try {
            String str = session.writeTransaction(new TransactionWork<String>() {
                @Override
                public String execute(Transaction tx) {
                    tx.run(query);
                    tx.success();
                    return null;
                }
            });
        } finally {
            session.close();
        } }


    public int readAllNodesCount() {
        try {
            int labelCount = writeTxn(Constant.readAllNodeCount).asInt();
            return labelCount;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "exception :" + e.toString());
        }
        return 0;
    }


    public Long readTotalRelationshipsCount() {
        try {
            Long relationshipCount = writeTxn(Constant.readTotalRelationshipCount).asLong();
            return relationshipCount;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to fetch toatal count of relationships :" + e.toString());
        }
        return 0l;

    }

    public Long readCountOfRelationships(String countType) {

        Long relationshipCount = null;
        try {
            switch (countType.toLowerCase()) {
                case "max":
                    relationshipCount = writeTxn(Constant.maxCountofRelationship).asLong();
                    break;

                case "min":
                    relationshipCount = writeTxn(Constant.minCountofRelationship).asLong();
                    break;

            }
            return relationshipCount;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to fetch Relationships count :" + e.toString());
        }
        return 0l;
    }

    public Double readAverageCount(String... arg) {
        //arg[0]= nodeNam , arg[1] = nodeproperties
        Double count = null;
        try {
            switch (arg[1].toLowerCase()) {
                case "relationship":
                    count = writeTxn(Constant.readAverageCountOfRelationships).asDouble();
                    break;

                case "nodeproperties":
                    count = writeTxn(Constant.readAvgCountOfNodeProperties(arg[0])).asDouble();
                    break;
            }
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to fetch Average count :" + e.toString());
        }
        return 0d;
    }

    public Long readCountOfRelationshipTypeForSingleLabel(String labelName, String RelationshipType) {
        Long countOfRelationships = null;
        try {
            switch (RelationshipType.toLowerCase()) {
                case "outgoing":
                    countOfRelationships = writeTxn(Constant.readCountOfOutgoingRelationshipsForSingleLabel(labelName)).asLong();
                    break;

                case "incoming":
                    countOfRelationships = writeTxn(Constant.readCountOfIncomingRelationshipsForSingleLabel(labelName)).asLong();
                    break;
            }
            return countOfRelationships;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve incoming or outgoing relationships count :" + e.toString());
        }
        return null;
    }

    public Long readCountOfNodeProperties(String nodeName, String countType) {
        Long countOfRelationships = null;
        try {
            switch (countType.toLowerCase()) {
                case "max":
                    countOfRelationships = writeTxn(Constant.readMaxCountOfNodeProperties(nodeName)).asLong();
                    break;

                case "min":
                    countOfRelationships = writeTxn(Constant.readMinCountOfNodeProperties(nodeName)).asLong();
                    break;
            }
            return countOfRelationships;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve count of node properties :" + e.toString());
        }
        return null;
    }

    public Long readCountOfNodesForSingleLabel(String nodeName) {
        try {
            Long countOfIncomingRelationships = writeTxn(Constant.readCountOfNodesForSingleLabel(nodeName)).asLong();
            return countOfIncomingRelationships;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve node count for single Label :" + e.toString());
        }
        return null;
    }

    public Long readCountOfLabelProperties(String labelName) {
        try {
            Long CountOfLabelProperties = writeTxn(Constant.readCountOfLabelProperties(labelName)).asLong();
            return CountOfLabelProperties;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve node count for single Label :" + e.toString());
        }
        return null;
    }


    public StatementResult readPropertyDataType() {
        try {
            Session session = driver.session();
            StatementResult nodeTypeProperties = session
                    .writeTransaction(new TransactionWork<StatementResult>() {

                        @Override
                        public StatementResult execute(Transaction tx) {
                            StatementResult result = tx.run(Constant.readPropertyDataType);
                            while (result.hasNext()) {
                                Record record = result.next();
                            }
                            tx.close();
                            session.close();
                            return result;
                        }
                    });
            return nodeTypeProperties;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve Neo4j Label properties :" + e.toString());
        }
        return null;
    }

    public List<String> getAllIndexes() {
        List<String> listOfIndexes = new ArrayList<String>();
        try {
            Session session = driver.session();
            StatementResult result = session.run(Constant.getAllIndexes);
            while (result.hasNext()) {
                Record record = result.next();
                Value value = record.get("description");
                String index = value.toString();
                listOfIndexes.add(index);
                return listOfIndexes;
            }
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to fetch indexes :" + e.toString());
        }
        return null;
    }


    public JsonObject getLabelpts() {
        JsonObject js = null;
        try {
            Session session = driver.session();
            StatementResult nodeTypeProperties = session
                    .writeTransaction(new TransactionWork<StatementResult>() {

                        @Override
                        public StatementResult execute(Transaction tx) {
                            StatementResult result = tx.run(Constant.getLabelpts);
                            while (result.hasNext()) {
                                Record record = result.next();
                                Value value = record.get("description");
                                String index = value.toString();
                                return result;
                            }
                            tx.close();
                            session.close();
                            return result;
                        }
                    });
            return js;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve Neo4j Label properties  :" + e.toString());
        }
        return null;
    }


    public Map<String, Integer> readStoreFileSizes() {
        try {
            Session session = driver.session();
            Map<String, Integer> neo4jStoreFileSizeList = session
                    .writeTransaction(new TransactionWork<Map<String, Integer>>() {

                        @Override
                        public Map<String, Integer> execute(Transaction tx) {
                            Map<String, Integer> storeFileSizeList = new HashMap<String, Integer>();
                            StatementResult result = tx.run(Constant.readStoreFileSizes);
                            while (result.hasNext()) {
                                Record record = result.next();
                                Value st = record.get("row");
                                st.asString();
                                Value st1 = record.get("attributes[row][\"value\"]");
                                st1.asInt();
                                storeFileSizeList.put(st.asString(), st1.asInt());
                            }
                            tx.close();
                            session.close();
                            return storeFileSizeList;
                        }
                    });
            return neo4jStoreFileSizeList;
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Unable to retrieve Neo4j DataBase Store file sizes  :" + e.toString());
        }
        return null;
    }


    public JsonObject buildDatabaseTechData() {
        int nodeCount = readAllNodesCount();
        Long relationshipsCount = readTotalRelationshipsCount();
        Double averageCountOfRelationships =  readAverageCount("relationship");
        Long maximumCountOfRelationships = readCountOfRelationships("Max");
        Long minimumCountOfRelationships = readCountOfRelationships("Min");
        Map<String, Integer> storeFileSize = readStoreFileSizes();

        JsonObjectBuilder indexBuilder = Json.createObjectBuilder();
        JsonObjectBuilder dataBaseMetaDataBuilder = Json.createObjectBuilder();
        JsonObjectBuilder fileStoreSizeBuilder = Json.createObjectBuilder();
        JsonObjectBuilder tranactionBuilder = Json.createObjectBuilder();
        dataBaseMetaDataBuilder.add("TotalCountOfNodes", nodeCount)
                .add("ToatalCountOfRelationship", relationshipsCount)
                .add("AverageCountOfRelationships", averageCountOfRelationships)
                .add("MaximumCountOfRelationships", maximumCountOfRelationships)
                .add("MinimumCountOfRelationships", minimumCountOfRelationships);

        List<String> indexes = getAllIndexes();
        if (indexes != null) {
            for (String indexName : indexes) {
                indexBuilder.add("Indexes", indexName);
            }

        }

        /**
         * Reading all file's store size from data base.
         */
        if (storeFileSize != null) {
            for (Map.Entry<String, Integer> fileSize : storeFileSize.entrySet()) {

                fileStoreSizeBuilder.add(fileSize.getKey(), fileSize.getValue());

            }

        }

        List<String> components = readNeo4jComponents();

        String database;

        if (components.get(2).equalsIgnoreCase("community")) {
            database = "ce";
        } else {
            database = "ee";
        }
        JsonObject dataBaseTechData = (JsonObject) Json.createObjectBuilder()
                .add(database + "DataBaseMetaData", dataBaseMetaDataBuilder)
                .add(database + "fileStoreSize", fileStoreSizeBuilder)
                .add("Indexes", indexBuilder)
                .build();

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"database tech data ::: " + dataBaseTechData);
        return dataBaseTechData;

    }

    public JsonObject buildTableTechData(String label) {
        Long totalOutGoingRelCount = readCountOfRelationshipTypeForSingleLabel(
                label.replaceAll("^\"|\"$", ""), "outgoing");
        Long totalIncomingRelCount = readCountOfRelationshipTypeForSingleLabel(
                label.replaceAll("^\"|\"$", ""), "incoming");
        Long totalNodeCountForSingleLabel = readCountOfNodesForSingleLabel(
                label.replaceAll("^\"|\"$", ""));
        Long minCountOfNodeProperties = readCountOfNodeProperties(
                label.replaceAll("^\"|\"$", ""), "Min");
        Long maxCountOfNodeProperties = readCountOfNodeProperties(
                label.replaceAll("^\"|\"$", ""), "Max");

        Double avgCountOfNodeProperties = readAverageCount(
                label.replaceAll("^\"|\"$", ""),"nodeproperties");



        JsonObject tableTechData = (JsonObject) Json.createObjectBuilder()
                .add("TotalCountOfOutGoingRelationShips", totalOutGoingRelCount)
                .add("TotalCountOfInCmoingRelationShips", totalIncomingRelCount)
                .add("TotalNodeCountInSingleLabel", totalNodeCountForSingleLabel)
                .add("MinimumCountOfNodeProperties", minCountOfNodeProperties)
                .add("MaximumCountOfNodeProperties", maxCountOfNodeProperties)
                .add("AverageCountOfNodeProperties", avgCountOfNodeProperties).build();

        return tableTechData;
    }

    public List<JsonObject> getTableColumns() {
        StatementResult result = readPropertyDataType();

        List<String> labels = getLabels();
        List<JsonObject> list = new ArrayList<>();
        JsonObject tableColumnData = null;


        while (result.hasNext()) {
            for (String labelName : labels) {
                Record record = result.next();
                Value value = record.get("nodeLabels");
                String nodeLabelName = value.toString().replace("[", "").replace("]", "")
                        .replaceAll("^\"|\"$", "");
                if (nodeLabelName != null && nodeLabelName != "") {
                    if (nodeLabelName.equals(labelName.replaceAll("^\"|\"$", ""))) {
                        Value propertyType = record.get("propertyTypes");
                        Value propertyName = record.get("propertyName");
                        tableColumnData = (JsonObject) Json.createObjectBuilder().add("label", labelName.replaceAll("^\"|\"$", "")).add(propertyName.toString().trim().replace("\"", ""), propertyType.toString().trim().replace("\"", "")).build();
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"json obj ::: " + tableColumnData.toString());
                        list.add(tableColumnData);
                    }
                }
            }
        }
        for (int i = 0; i < list.size(); i++) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(),"columns ::: " + list.get(i));
        }
        return list;
    }
}

