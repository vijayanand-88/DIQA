package com.asg.automation.utils.rest;


import com.asg.automation.utils.JsonBuildUpdateUtil;
import com.asg.automation.utils.JsonRead;
import com.asg.automation.wrapper.RestAPIWrapper;
import io.restassured.path.json.JsonPath;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.asg.automation.utils.Constant.TEST_DATA_PATH;


/**
 * Created by Nirmal.Balasundaram on 9/1/2017.
 */
public  class RestBuilderUtil {


    /**
     *  This method is used to contrust the request object for a REST api call and execute it
     * @param restHandler RestAPIWrapper
     * @param jPath jPath locator
     * @param user credentials for authentication
     */
    public static RestAPIWrapper buildRequestUsingConfigAndExecute(String serviceName, RestAPIWrapper restHandler, JsonPath jPath, String user) {

        //Resetting the API and re initializing for the current execution
        restHandler.resetRestAPI();
        restHandler.initializeRestAPI(serviceName);

        Map<String, String> queryParam = jPath.get("queryparam");
        String method = jPath.get("method");
        String path = jPath.get("path");
        String credentials = restHandler.propLoader.prop.getProperty(user);
        String contentType = jPath.get("header.contentType");
        String acceptFormat = jPath.get("header.acceptFormat");
        String body = jPath.get("payload");

        if(credentials != null){
            restHandler.multiHeader(credentials, contentType, acceptFormat);
        }else{
            restHandler.multiHeader( contentType, acceptFormat);
        }


        if (!queryParam.isEmpty()) {
            restHandler.buildQueryParam(queryParam);
        }


        switch (method) {
            case "DELETE":
                restHandler.invokeDeleteRequest(path);
                break;
            case "GET":
                restHandler.invokeGetRequest(path);
                break;
            case "PUT":
                restHandler.setBody(body);
                restHandler.invokePutRequest(path);
                break;
            case "POST":
                restHandler.setBody(body);
                restHandler.invokePostRequest(path);
                break;
            default:
                //Do nothing for now
                break;
        }
        return restHandler;
    }

    /**
     *  This method is used to contrust the request object for a REST api call and execute it
     * @param restHandler RestAPIWrapper
     * @param jPath jPath locator
     * @param user credentials for authentication
     */
    public static RestAPIWrapper buildRequestUsingConfigAndExecute(String serviceName, RestAPIWrapper restHandler, JsonPath jPath, String user, String payload) {

        //Resetting the API and re initializing for the current execution
        restHandler.resetRestAPI();
        restHandler.initializeRestAPI(serviceName);

        Map<String, String> queryParam = jPath.get("queryparam");
        String method = jPath.get("method");
        String path = jPath.get("path");
        String credentials = restHandler.propLoader.prop.getProperty(user);
        String contentType = jPath.get("header.contentType");
        String acceptFormat = jPath.get("header.acceptFormat");
        String body = payload;

        if(credentials != null){
            restHandler.multiHeader(credentials, contentType, acceptFormat);
        }else{
            restHandler.multiHeader( contentType, acceptFormat);
        }


        if (!queryParam.isEmpty()) {
            restHandler.buildQueryParam(queryParam);
        }


        switch (method) {
            case "DELETE":
                restHandler.invokeDeleteRequest(path);
                break;
            case "GET":
                restHandler.invokeGetRequest(path);
                break;
            case "PUT":
                restHandler.setBodyAsString(body);
                restHandler.invokePutRequest(path);
                break;
            case "POST":
                restHandler.setBodyAsString(body);
                restHandler.invokePostRequest(path);
                break;
            default:
                //Do nothing for now
                break;
        }
        return restHandler;
    }

    /**
     * Construct the request and execute based on the request config
     * @param restHandler RestAPIWrapper
     * @param config request configuration
     * @return
     */
    public static RestAPIWrapper  buildRequestUsingConfigAndExecute( RestAPIWrapper restHandler, String... config) {

        JsonPath jPath = JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/"+config[0]);
        //Resetting the API and re initializing for the current execution
        restHandler.resetRestAPI();
        restHandler.initializeRestAPI(jPath.get("api"));

        Map<String, String> queryParam = jPath.get("queryparam");
        String method = jPath.get("method");
        String path = jPath.get("path");
        String credentials = restHandler.propLoader.prop.getProperty(jPath.get("user"));
        String contentType = jPath.get("header.contentType");
        String acceptFormat = jPath.get("header.acceptFormat");
        String payload = jPath.get("payload");
        if(config.length == 2)
            payload = config[1];

        if(credentials != null){
            restHandler.multiHeader(credentials, contentType, acceptFormat);
        }else{
            restHandler.multiHeader( contentType, acceptFormat);
        }


        if (!queryParam.isEmpty()) {
            restHandler.buildQueryParam(queryParam);
        }


        switch (method) {
            case "DELETE":
                restHandler.invokeDeleteRequest(path);
                break;
            case "GET":
                restHandler.invokeGetRequest(path);
                break;
            case "PUT":
                restHandler.setBodyAsString(payload);
                restHandler.invokePutRequest(path);
                break;
            case "POST":
                restHandler.setBodyAsString(payload);
                restHandler.invokePostRequest(path);
                break;
            default:
                //Do nothing for now
                break;
        }
        return restHandler;
    }

    /**
     * Validate the response based on the validation configuration
     * @param restHandler RestAPIWrapper
     * @param config response configuration
     * @return
     */
    public static RestAPIWrapper  validateResponse(RestAPIWrapper restHandler, String config){
        JsonPath jPathResult = JsonRead.readJSONObject(TEST_DATA_PATH + "rest/response/validation/"+config);
        int responseCode = jPathResult.get("responseCode");
        restHandler.validateResponseCode(responseCode);

        return restHandler;
    }

    /**
     * Update the response payload for subsequent execution
     * @param response
     * @param config
     * @return
     */
    public static String  updateResponse(String response, String config){
        JsonPath jPathResult = JsonRead.readJSONObject(TEST_DATA_PATH + "rest/response/mashup/"+config);

        String action =  jPathResult.getString("action");
        List<HashMap<String,String>> nodes =  jPathResult.getList("nodes");
        switch (action) {
            case "addNode":
                for (HashMap<String, String> node : nodes) {

                    response = JsonBuildUpdateUtil.insertJsonNode(response, node.get("pathToConfig"), node.get("configName"), node.get("configValue")).toString();
                }

                break;
            case "deleteNode":
                for (HashMap<String, String> node : nodes) {

                    response = JsonBuildUpdateUtil.removeJsonNode(response, node.get("pathToConfig")).toString();
                }
                break;

            default:
                //Do nothing for now
                break;
        }


        return response;
    }
}
