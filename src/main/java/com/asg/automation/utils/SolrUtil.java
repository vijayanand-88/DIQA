package com.asg.automation.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by muthuraja.ramakrishn on 6/8/2017.
 */
public class SolrUtil {
    PropertyLoader propLoader;
    SolrClient client;
    HashMap<String, Object> solrDocValue;

    public SolrUtil() {
        new PropertyLoader();
    }

    public void propLoader() {
        propLoader = new PropertyLoader();
        propLoader.loadProperty();
    }

    public long Solr_SearchCount(String Query, String FilterQuery, String RequestHandler) {
        long count = 0;
        try {
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            query.addFilterQuery(FilterQuery);
            query.setStart(0);

            QueryResponse response = client.query(query);
            SolrDocumentList results = response.getResults();
            count = results.getNumFound();


        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return count;

    }


    public boolean solrSearch(String Query, String FilterQuery, String RequestHandler, String expectedResults, int indexNo) {
        SolrDocumentList results = null;
        boolean status = false;
        try {
            ObjectMapper mapper = new ObjectMapper();
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            query.addFilterQuery(FilterQuery);
            query.setStart(0);
            QueryResponse response = client.query(query);
            results = response.getResults();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Searched Index Position " + indexNo + " in SOLR");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Solr Search Doc result is: " + results.get(indexNo));

            if (results.get(indexNo).containsValue(expectedResults.trim()))
                status = true;

            /*for (int i = 0; i < results.size(); ++i) {
                if (expectedResults.contains(results.get(i).toString())) {
                    if (results.get(i).containsValue(expectedResults)) {
                        System.out.println("Success");
                        break;
                    } else {
                        System.out.println(results.get(i));
                    }

                }

            }*/
        } catch (Exception e) {
            System.out.println(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return status;
    }

    public boolean solrSearchRows(String Query, String FilterQuery, String RequestHandler, String facetField, String expectedResults, int indexNo, int rows) {
        SolrDocumentList results = null;
        boolean status = false;
        try {
            ObjectMapper mapper = new ObjectMapper();
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            query.addFilterQuery(FilterQuery);
            query.setStart(0);
            query.setRows(rows);
            if (!facetField.equals("")) {
                query.addFacetField(facetField);
            }
            QueryResponse response = client.query(query);
            results = response.getResults();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Searched Index Position " + indexNo + " in SOLR");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Solr Search Doc result is: " + results.get(indexNo));

            if (results.get(indexNo).containsValue(expectedResults.trim()))
                status = true;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return status;
    }

    public List<SolrDocument> solrSearchResults(String Query, String FilterQuery, String FieldQuery, String RequestHandler, String ExpectedResults) {

        SolrDocumentList results = null;

        try {
            ObjectMapper mapper = new ObjectMapper();
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            query.addFilterQuery(FilterQuery);
            query.addField(FieldQuery);
            QueryResponse response = client.query(query);
            results = response.getResults();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search Result from Solr" + results);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return results;
    }

    public long Solr_SearchCountFilters(String Query, List<String> FilterQuery, String RequestHandler, String FacetField) {
        long count = 0;
        try {
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            for (String filter : FilterQuery) {
                query.addFilterQuery(filter);
            }
            query.setStart(0);
            if (!FacetField.equals("")) {
                query.addFacetField(FacetField);
            }
            QueryResponse response = client.query(query);
            SolrDocumentList results = response.getResults();
            count = results.getNumFound();


        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return count;

    }

    public boolean solrSearchFilters(String Query, List<String> FilterQuery, String RequestHandler, String facetField, String sortField, String sortOrder, String expectedResults, int indexNo, int rows) {
        SolrDocumentList results = null;
        boolean status = false;
        try {
            ObjectMapper mapper = new ObjectMapper();
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            for (String filter : FilterQuery) {
                query.addFilterQuery(filter);
            }
            if (!sortField.equals("")) {
                if (sortOrder.equals("Asc"))
                    query.setSort(sortField, SolrQuery.ORDER.asc);
                else if ((sortOrder.equals("Desc")))
                    query.setSort(sortField, SolrQuery.ORDER.desc);
            }
            query.setStart(0);
            query.setRows(rows);
            if (!facetField.equals("")) {
                query.addFacetField(facetField);
            }
            QueryResponse response = client.query(query);
            results = response.getResults();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Searched Index Position " + indexNo + " in SOLR");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Solr Search Doc result is: " + results.get(indexNo));

            for (int i = 0; i < results.size(); i++) {
                if (results.get(i).containsValue(expectedResults))
                    status = true;
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return status;
    }


    public List<FacetField> solrSearchFacets(String Query, List<String> FilterQuery, String RequestHandler, String facetField, String sortField, String sortOrder,int rows) {
        SolrDocumentList results = null;
        List<FacetField> facetList=null;
        try {
            ObjectMapper mapper = new ObjectMapper();
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            for (String filter : FilterQuery) {
                query.addFilterQuery(filter);
            }
            if (!sortField.equals("")) {
                if (sortOrder.equals("Asc"))
                    query.setSort(sortField, SolrQuery.ORDER.asc);
                else if ((sortOrder.equals("Desc")))
                    query.setSort(sortField, SolrQuery.ORDER.desc);
            }
            query.setStart(0);
            query.setRows(rows);
            if (!facetField.equals("")) {
                query.addFacetField(facetField);
            }
            QueryResponse response = client.query(query);
            facetList=response.getFacetFields();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Solr Search Facet Fields result: " + facetList);


        } catch (Exception e) {
            System.out.println(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
 return facetList;
    }

    public List<String> solrGetFieldValue(String Query, List<String> FilterQuery, String FieldQuery, String RequestHandler, String fieldName) {
        SolrDocumentList results = null;
        List<String> fieldValue = new ArrayList<>();
        try {
            ObjectMapper mapper = new ObjectMapper();
            propLoader();
            SolrClient client = new HttpSolrClient.Builder(propLoader.prop.getProperty("solrURI")).build();
            SolrQuery query = new SolrQuery();
            query.setQuery(Query);
            query.setRequestHandler(RequestHandler);
            for (String filter : FilterQuery) {
                query.addFilterQuery(filter);
            }
            query.addField(FieldQuery);
            QueryResponse response = client.query(query);
            results = response.getResults();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Search Result from Solr: " + response.getResults());
            for (SolrDocument result : results) {
                if (result.containsKey(fieldName)) {
                    fieldValue.add(result.get(fieldName).toString());
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Solr result does not contain  " + fieldName);
                    fieldValue.add("false");
                }
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
        return fieldValue;
    }



}

