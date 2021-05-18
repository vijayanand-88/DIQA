package com.asg.automation.stepdefinition.restapi;


import com.asg.automation.utils.*;
import com.asg.automation.utils.rest.RestBuilderUtil;
import com.asg.automation.wrapper.RestAPIWrapper;
import com.asg.automation.wrapper.UIWrapper;
import cucumber.api.DataTable;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.restassured.RestAssured;
import io.restassured.path.xml.config.XmlPathConfig;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.apache.solr.client.solrj.response.FacetField;
import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.JSONParser;
import org.testng.Assert;

import java.io.*;
import java.text.DecimalFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.asg.automation.utils.Constant.*;
import static com.asg.automation.utils.PostgresSqlBuilder.getselectedColumnName;
import static io.restassured.path.xml.XmlPath.from;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItems;

/**
 * Created by muthuraja.ramakrishn on 4/17/2017.
 */
@SuppressWarnings("DefaultFileTemplate")
public class RESTAPIDefinition extends RestAPIWrapper {
    private static int id, rating;
    protected DBPostgresUtil db_postgres_util;
    RepoData repoData;
    private SolrUtil solr;
    private JsonRead jsonRead;
    private CommonUtil commonUtil;
    private UIWrapper uiWrapper;
    private XMLReaderUtil xmlReader;
    private FileUtil fileUtil;
    private DBHelper dbHelper;

    @Before
    public void initialize(Scenario scenario) {
        /*Initializing Rest API Base URI, BasePath*/
        initializeRestAPI("IDC");
        solr = new SolrUtil();
        jsonRead = new JsonRead();
        commonUtil = new CommonUtil();
        xmlReader = new XMLReaderUtil();
        fileUtil = new FileUtil();
        uiWrapper = new UIWrapper();
        dbHelper = new DBHelper();
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "================================");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Scenario Test Execution Started");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "================================");

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "=====================================================================");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Scenario Test Execution Started for: " + scenario.getName());
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "======================================================================");


    }

    @After
    public void tearDown(Scenario scenario) {
        /*Resetting Rest API Base URI, BasePath*/
        resetRestAPI();
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "=========================================================================");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Scenario Test Execution Completed: : " + scenario.getName());
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "==========================================================================");
    }


    @Given("^A query param with \"([^\"]*)\" and \"([^\"]*)\" and supply authorized users, contentType and Accept headers$")
    public void a_query_param_with_and_and_supply_authorized_users_contentType_and_Accept_headers(String Query, String param) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        String credentials = propLoader.prop.getProperty("TestSystemUser");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        multiHeader(credentials, "application/json", "application/json");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType: application/json, acceptformat: application/json");
        setpathQueryParm(Query, param);

    }


    @Given("^build a request with header to accept \"([^\"]*)\" response$")
    public void build_a_request_with_header_to_accept_response(String acceptFormat) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        multiHeader(propLoader.prop.getProperty("TestSystemUser"), "text/xml", acceptFormat);
    }


    @Then("^the exported data should contain the item \"([^\"]*)\"$")
    public void the_exported_data_should_contain_the_item(String item) throws Throwable {

        List<String> attributes = from(response().body().asString()).using(XmlPathConfig.xmlPathConfig().allowDocTypeDeclaration(true)).get("**.findAll{it.name() == 'ITEM'}.@itemName");
        Assert.assertEquals(attributes.stream().filter(exportedContent -> exportedContent.equalsIgnoreCase(item)).findFirst().get(), item);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Attribute tested in the exported response " + attributes.stream().filter(exportedContent -> exportedContent.equalsIgnoreCase(item)).findFirst().get());

    }

    @Given("^A query param with \"([^\"]*)\" and \"([^\"]*)\" on solr search$")
    public void a_query_param_with_and_on_solr_search(String query, String param) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        String baseURI = propLoader.prop.getProperty("solrURI");
        String basePATH = propLoader.prop.getProperty("basesolrPATH");
        setBaseURI(baseURI);
        setBasePath(basePATH);
        initializeGiven();
        String credentials = propLoader.prop.getProperty("TestSystemUser");
        multiHeader(credentials, "application/json", "application/json");
        setpathQueryParm(query, param);
        LoggerUtil.logLoader_info(this.getClass().getName(), RestAssured.baseURI + RestAssured.basePath);
    }

    @When("^user makes a REST Call for Get request with url \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_GET_request_with_url(String path) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        invokeGetRequest(path);
    }

    @Given("^user attaches/upload file \"([^\"]*)\" to request$")
    public void user_attaches_upload_file_to_request(String attachment) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        if (attachment.contains("Constant.REST_DIR")) {
            setMultiPart(attachment.replace("Constant.REST_DIR", REST_DIR));
        } else {
            setMultiPart(FEATURES + attachment);
        }
    }

    @Given("^user attaches/upload file \"([^\"]*)\" to request from the repository \"([^\"]*)\" location$")
    public void user_attaches_upload_file_to_request_from_the_location(String attachment, String location) throws Throwable {
        String home = System.getProperty("user.home");
        setMultiPart(home + REPOSISTORY_LOCATION + location + attachment);
    }

    @When("^user makes a recursive REST Call for GET request \"([^\"]*)\" till the status becomes \"([^\"]*)\" with maximum threshhold of \"([^\"]*)\" times$")
    public void user_makes_a_recursive_rest_call_for_get_request_till_the_valid_status_is_reached_with_threshhold(String path, String status, String threshhold) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        invokeGetRequestRecursive(path, status, threshhold);
    }

    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with dynamic id and Ratings from DB$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_dynamic_id_and_Ratings_from_DB(String path) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        //int returnValue = 0;
        id = commonUtil.randomint(1, 10);
        rating = commonUtil.randomRating();
        String dynamicPath = null;
        db_postgres_util = new DBPostgresUtil();
        try {
            db_postgres_util.get_Value("SELECT * FROM \"" + commonUtil.returnSchema() + "\".\"" + commonUtil.returnTableName() + "\" where \"ID\"=" + id + "");
            //"select \"ID\" from \"" + schemaName + "\".\"" + tableName + "\" where \"ID\"=" + splitIdValue + ""
            dynamicPath = commonUtil.returnSchema() + ".Table%3A%3A%3A" + id + "/" + rating;
            invokePostRequest(path + dynamicPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^Dynamic rating must be matched with the table \"([^\"]*)\" in database$")
    public void dynamic_rating_must_be_matched_with_the_table_in_database(String tableName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        int noOfrows;
        db_postgres_util = new DBPostgresUtil();
        try {
            noOfrows = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(commonUtil.returnSchema(), tableName, "rating", commonUtil.randomRate));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), noOfrows + " Record(s) Match");
            if (noOfrows == 0)
                Assert.fail("No such record Exists in database");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception in database" + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @When("^user makes a REST Call for PUT request with url \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_PUT_request_with_url(String path) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        invokePutRequest(path);

    }

    @When("^user makes a REST Call for POST request with url \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_POST_request_with_url(String path) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        invokePostRequest(path);
    }

    @When("^user makes a REST Call for DELETE request with url \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_DELETE_request_with_url(String path) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        invokeDeleteRequest(path);
    }

    @Given("^supply payload with file name \"([^\"]*)\"$")
    public void supply_payload_with_file_name(String FileName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        setBody(FileName);
    }

    @Then("^set the content type \"([^\"]*)\"$")
    public void set_the_content_type(String content_type) throws Throwable {
        setContentType(content_type);
    }

    @Then("^build a request with query parameters$")
    public void send_request_with_query_parameters(Map<String, String> dataFields) throws Throwable {
        buildQueryParam(dataFields);
    }

    @Then("^Status code (\\d+) must be returned$")
    public void status_code_must_be_returned(int expectedStatusCode) throws IOException {
        // Write code here that turns the phrase above into concrete actions
        try {
            returnRestResponse();
            Assert.assertEquals(returnStatusCode(), expectedStatusCode);
        } catch (Exception e) {
            Assert.fail("Exception is: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Actual code is not matched with  Expected code: RestResponse\n" + returnRestResponse());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Then("^Status line \"([^\"]*)\" must be returned$")
    public void status_line_must_be_returned(String ExpectedStatusLine) throws Throwable {
        try {
            returnRestResponse();
            Assert.assertEquals(responseGettingStatusLineCode(), ExpectedStatusLine);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Actual Status: " + responseGettingStatusLineCode() + " Expected Status: " + ExpectedStatusLine);
        } catch (Exception e) {
            Assert.fail("Exception is: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Actual code is not matched with  Expected code: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^verify created schema \"([^\"]*)\" exists in database$")
    public void verify_created_schema_exists_in_database(String schemaName) {
        // Write code here that turns the phrase above into concrete actions
        int returnValue = 0;
        db_postgres_util = new DBPostgresUtil();
        try {
            returnValue = db_postgres_util.get_rowCount("SELECT * FROM public.\"items\" where catalog=" + "'" + schemaName + "'" + "");
            if (returnValue == 0) {
                Assert.fail("No " + schemaName + " found in database");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No " + schemaName + " found in database");
            }
        } catch (Exception e) {
            Assert.fail("Database issue " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^verify the content \"([^\"]*)\" is successfully imported into the database$")
    public void verify_the_content_is_successfully_imported_into_the_databasee(String content) throws Throwable {
        int returnValue = 0;
        db_postgres_util = new DBPostgresUtil();
        try {
            returnValue = db_postgres_util.get_rowCount(
                    "Select * from \"BrowserData\".\"V_Database\" where name = '" + content + "'" + "");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "select query response " + returnValue);
            if (returnValue == 0) {
                Assert.fail("No " + content + " found in database");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No " + content + " found in database");
            }
        } catch (Exception e) {
            Assert.fail("Database issue " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^verify created schema \"([^\"]*)\" doesn't exists in database$")
    public void verify_created_schema_doesn_t_exists_in_database(String schemaName) {
        // Write code here that turns the phrase above into concrete actions
        int returnValue = 0;
        db_postgres_util = new DBPostgresUtil();
        try {
            returnValue = db_postgres_util.get_rowCount("SELECT * FROM sqlg_schema.\"V_schema\" where name=" + "'" + schemaName + "'" + "");
            if (returnValue != 0)
                Assert.fail("No " + schemaName + " found in database");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No " + schemaName + " found in database");
        } catch (Exception e) {
            Assert.fail("Database issue " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response message contains value \"(.*)\"$")
    public void response_message_contains_value(String ElementValue) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        boolean status = false;
        try {
            //responseMessage = jsonFormater.jsonformat(returnRestResponse());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), returnRestResponse());
            if (!ElementValue.isEmpty()) {
                String response = returnRestResponse().toString();
                status = returnRestResponse().contains(ElementValue);
                if (!status)
                    Assert.fail("Such Element value not found in API Json Response");
                else
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is found in API Response");
            }
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Then("^Json response message should contains the following value$")
    public void response_message_contains_value(List<CucumberDataSet> dataTableCollection) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        boolean status = false;
        try {
            for (CucumberDataSet data : dataTableCollection) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
                status = returnRestResponse().contains(data.getResponseText());
                if (!status)
                    Assert.fail("Such Element value not found in API Response");
                else
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is found in API Response");

            }
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail(e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Then("^Verify XML response message contains value$")
    public void response_message_contains_value_for_xml(List<CucumberDataSet> dataTableCollection) throws Throwable {
        boolean status = false;

        try {
            for (CucumberDataSet data : dataTableCollection) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
                status = returnRestResponseForXML(data.getResponseXMLText());
                if (!status)
                    Assert.fail("Such Element value not found in API Response");
                else
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is found in API Response");

            }

            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Such Element value not found in API Response" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Then("^Verify XML response message not contains value$")
    public void response_message_not_contains_value_for_XML(List<CucumberDataSet> dataTableCollection) throws Throwable {
        boolean status = false;
        try {
            for (CucumberDataSet data : dataTableCollection) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
                status = returnRestResponseForXML(data.getResponseXMLText());
                if (status)
                    Assert.fail("Such Element value found in API Response");
                else
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is not found in API Response");
            }
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Such Element value found in API Response" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Then("^response message not contains value \"(.*)\"$")
    public void response_message_not_contains_value(String ElementValue) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        boolean status = false;
        try {
            //responseMessage = jsonFormater.jsonformat(returnRestResponse());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
            LoggerUtil.logLoader_info(returnRestResponse().toString(), "Return Response");
            status = returnRestResponse().contains(ElementValue);
            if (status)
                Assert.fail("Such Element value found in API Json Response");

            else
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is not found in API Response");

            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Such Element value found in API Json Response" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Then("^Verify response header contains value$")
    public void response_header_contains_value_for(DataTable data) throws Throwable {
        try {
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {
                if (response.headers().exist()) {

                    Assert.assertTrue(response.getHeaders().toString().contains(values.get("HeaderValue")));
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response Header is not present");
                }
            }
        } catch (Exception e) {
            Assert.fail("Response Header is not present" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Given("^Delete record in the table \"([^\"]*)\" when column name \"([^\"]*)\" is \"([^\"]*)\"$")
    public void delete_record_in_the_table_when_column_name_is(String tableName, String columnName, String userName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            db_postgres_util = new DBPostgresUtil();
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery(commonUtil.returnSchema(), tableName, "asg.modifiedBy", "TestService"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^Delete all records in the table \"([^\"]*)\"$")
    public void delete_all_records_in_the_table(String tableName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        try {
            db_postgres_util = new DBPostgresUtil();
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery(commonUtil.returnSchema(), tableName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^compare \"([^\"]*)\" between Json Response and Solr Response with Search Index ID is (\\d+)$")
    public void compare_between_Json_Response_and_Solr_Response_with_Search_Index_ID_is(String searchElement, int indexPosition) {
        // Write code here that turns the phrase above into concrete actions
        boolean searchCompare;
        try {
            List<String> actual = returnElementLists(searchElement);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "IDC Rest API Search Results: " + actual.get(indexPosition));
            searchCompare = solr.solrSearch("test", "schema_s=BigData", "/select", actual.get(indexPosition), indexPosition);
            if (!searchCompare)
                Assert.fail("Search is not matched between Solr and Rest Response");
            else
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "API result is successfully compared with Solr Search Results");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^search query \"([^\"]*)\" in response and verify following results$")
    public void search_query_in_response_and_verify_following_results(String JsonQuery, List<String> ExpectedResults) throws Throwable {
        String actualResult = returnJsonValue(JsonQuery);
        Assert.assertTrue(ExpectedResults.get(0).equalsIgnoreCase(actualResult));

    }

    @Then("^configure a new REST API for the service \"([^\"]*)\"$")
    public void configure_a_new_REST_API_for_the_service(String serviceName) throws Throwable {
        initializeRestAPI(serviceName);
    }

    @Then("^response includes the following$")
    public void response_includes_the_following(Map<String, String> dataFields) throws Throwable {
        for (Map.Entry<String, String> dataitem : dataFields.entrySet()) {
            if (StringUtils.isNumeric(dataitem.getValue())) {
                responseTable.body(dataitem.getKey(), equalTo(Integer.parseInt(dataitem.getValue())));
            } else {
                responseTable.body(dataitem.getKey(), equalTo(dataitem.getValue()));
            }

        }
    }


    @Given("^User can add a repository in QA Project space in BitBucket$")
    public void okuser_can_add_a_repository_in_QA_Project_space_in_BitBucket() throws Throwable {

        String dynamicRepoName = "Analyzer_" + RandomStringUtils.randomAlphanumeric(3);
        Map<String, Object> requestBodyAsMap = new HashMap<>();
        requestBodyAsMap.put("name", dynamicRepoName);
        requestBodyAsMap.put("scmId", "git");
        getRequest().contentType("application/json").body(requestBodyAsMap);
        response = getRequest().when().post("projects/DIQA/repos");
        LoggerUtil.logLoader_info(this.getClass().getName(), response.body().print());
    }

    /*
    Assinging Multi headers value
     */
    @Given("^To configure multiple headers and Authorization dynamically for Rest Endpoint$")
    public void to_configure_multiple_headers_and_Authorization_dynamically_for_Rest_Endpoint(Map<String, String> multiHeaders) throws Throwable {
        request = request.headers(multiHeaders).urlEncodingEnabled(true);
    }

    @When("^user makes a REST Call for Get request with url \"([^\"]*)\" with the following query param$")
    public void user_makes_a_REST_Call_for_Get_request_with_url_with_the_following_query_param(String path, Map<String, String> queryParam) throws Throwable {
        request = request.queryParams(queryParam);
        invokeGetRequest(path);
    }

    @When("^user makes a REST Call for PUT request with url \"([^\"]*)\" with the following query param$")
    public void user_makes_a_REST_Call_for_PUT_request_with_url_with_the_following_query_param(String path, Map<String, String> queryParam) throws Throwable {
        request = request.queryParams(queryParam);
        invokePutRequest(path);
    }


    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with the following query param$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_the_following_query_param(String path, Map<String, String> queryParam) throws Throwable {
        request = request.queryParams(queryParam);
        invokePostRequest(path);
    }

    @Then("^response returns with the following items$")
    public void response_returns_with_the_following_items(DataTable arg1) throws Throwable {
        List<CucumberDataSet> restAPI_dataTable_handlers = arg1.asList(CucumberDataSet.class);
        try {

            for (CucumberDataSet dataTable : restAPI_dataTable_handlers) {
                switch (dataTable.getDescription()) {
                    case "Status Code":
                        returnRestResponse();
                        Assert.assertEquals(Integer.parseInt(dataTable.getExpectedResults()), returnStatusCode());
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Status code is " + returnStatusCode());
                        break;
                    case "Status Line":
                        Assert.assertEquals(dataTable.getExpectedResults(), responseGettingStatusLineCode());
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Status Line is " + responseGettingStatusLineCode());
                        break;
                    case "Content Type":
                        Assert.assertTrue(returnContentType().contains(dataTable.getExpectedResults()));
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Content Type is " + response.getContentType());
                        break;
                    case "ResponseBody_ReturnSingleValue":
                        if (dataTable.getExpectedResults().matches("\\d+")) {
                            Assert.assertEquals(Integer.toString(response.path(dataTable.getSearchItems().trim())), dataTable.getExpectedResults());
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rest API Search item returns: " + dataTable.getSearchItems() + Integer.toString(response.path(dataTable.getSearchItems())));
                        } else {
                            Assert.assertEquals(response.path(dataTable.getSearchItems().trim()), dataTable.getExpectedResults());
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rest API Search item returns: " + dataTable.getSearchItems() + response.path(dataTable.getSearchItems()));
                        }
                        break;
                    case "ResponseBody_ValidateList":
                        List<String> items = Arrays.asList(dataTable.getExpectedResults().split(","));
                        int size = items.size();
                        if (size > 1) {
                            final List<String> item_collections = returnJsonCollections(dataTable.getSearchItems());
                            Assert.assertEquals(item_collections.toString(), items.toString());
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rest API Search item returns: " + item_collections.toString());
                        } else {
                            Assert.assertEquals(response.path(dataTable.getSearchItems()), hasItems(items.get(0).toString()));
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rest API Search item returns: " + dataTable.getSearchItems());
                        }
                        break;
                    case "ResponseValidate_NoJsonObject":
                        List<String> responseItems = Arrays.asList(dataTable.getSearchItems().split(","));
                        List<String> comparisonItem = Arrays.asList(dataTable.getExpectedResults().split(","));
                        if (responseItems.size() != 0 && responseItems.size() == 1) {
                            responseValidationhasItems(responseItems, comparisonItem);
                        }


                }
            }
            //CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            LoggerUtil.logLoader_info("Assertion error " + this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^User calls the bitbucket repository web service to get the repo \"([^\"]*)\"$")
    public void user_calls_the_bitbucket_repository_web_service_to_get_the_repo(String path) throws Throwable {

        invokeGetRequest(path);

    }

    @Then("^the status code code is (\\d+)$")
    public void the_status_code_code_is(int code) throws Throwable {
        responseTable = response().then().statusCode(code);
    }

    @Then("^user stores the file count from bitbucket API$")
    public void user_stores_the_file_count_from_bitbucket_API() throws Throwable {
        try {
            DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(new Integer(response().jsonPath().getInt("size")));

        } catch (Exception e) {

        }
     /* {
          LoggerUtil.logLoader_error(this.getClass().getSimpleName(),"Total source is:"+totalsources+e.getMessage());
      }*/

    }

    @Then("^verify created quicklink is available in \"([^\"]*)\" table of \"([^\"]*)\" schema")
    public void verify_created_quicklink_is_available_in_table_of_schema_for_user_id(String schemaName, String TableName) throws IOException {
        db_postgres_util = new DBPostgresUtil();
        try {

            String response = returnRestResponse();
            List<String> resultList = db_postgres_util.returnQueryList("public", "config", "data", "path",
                    "com/asg/dis/platform/quicklink_user.json/TestService");
            for (String list : resultList) {
                if (list.contains("\"name\": \"list of Tables\"") && list.contains(response)) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");

                } else {
                    Assert.fail("Quicklink not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found");

                }
            }

        } catch (Exception e) {
            Assert.fail("Problem in connecting database");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^verify created quicklink for multiwidget is available in \"([^\"]*)\" table of \"([^\"]*)\" schema$")
    public void verify_created_quicklink_for_multiwidget_is_available_in_table_of_schema(String schemaName, String TableName) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        try {
            String response = returnRestResponse();

            List<String> resultList = db_postgres_util.returnQueryList(schemaName, TableName, "data", "path",
                    "com/asg/dis/platform/quicklink_user.json/TestService");
            for (String list : resultList) {
                if (list.contains("\"name\": \"list of Analysis\"") && list.contains(response) && list.contains("\"widgets\": [" + "\"BigData\"," + "\"Analysis\"" + "]")) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");

                } else {
                    Assert.fail("Quicklink not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found");

                }
            }
        } catch (Exception e) {
            Assert.fail("Problem in connecting database");
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with dynamic id and Ratings from DB with following query param$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_dynamic_id_and_Ratings_from_DB_with_following_query_param(String path, Map<String, String> queryParam) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        //int returnValue = 0;
        if (!queryParam.containsValue("null")) {
            request = request.queryParams(queryParam);
        }
        id = commonUtil.randomint(40, 80);
        rating = commonUtil.randomRating();
        String dynamicPath = null;
        try {
            dynamicPath = commonUtil.returnSchema() + ".Table:::" + id + "/" + rating;
            invokePostRequest(path + dynamicPath);
            commonUtil.storeTemporaryText(String.valueOf(id));
            commonUtil.addElementsInList(String.valueOf(rating));
        } catch (Exception e) {
            e.getCause();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^Dynamic rating must be matched with the table \"([^\"]*)\" in database for \"([^\"]*)\" user$")
    public void dynamic_rating_must_be_matched_with_the_table_in_database_for_user(String tableName, String userName) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        int noOfrows;
        db_postgres_util = new DBPostgresUtil();
        try {
            String modified = "asg.modifiedBy";
            String value = String.valueOf(commonUtil.randomRate);
            noOfrows = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(commonUtil.returnSchema(), tableName, modified, userName, "rating", value));
            Assert.assertEquals(noOfrows, 1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), noOfrows + " Record(s) Match");
            if (noOfrows == 0)
                Assert.fail("No such record Exists in database");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            Assert.fail("Exception in database" + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with dynamic id and Ratings for \"([^\"]*)\" with following query param$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_dynamic_id_and_Ratings_for_with_following_query_param(String path, String type, Map<String, String> queryParam) throws Throwable {
        if (!queryParam.containsValue("null")) {
            request = request.queryParams(queryParam);
        }
        id = commonUtil.randomint(219, 400);
        rating = commonUtil.randomRating();
        String dynamicPath = null;
        db_postgres_util = new DBPostgresUtil();
        try {

            dynamicPath = commonUtil.returnSchema() + "." + type + ":::" + id + "/" + rating;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "path" + dynamicPath);
            invokePostRequest(path + dynamicPath);
            commonUtil.storeTemporaryText(String.valueOf(id));

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }


    @Then("^user makes a REST Call for POST request with url \"([^\"]*)\" with id and dynamic Rating from DB with following query param$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_id_and_dynamic_Rating_from_DB_with_following_query_param(String path, Map<String, String> queryParam) throws Throwable {

        if (!queryParam.containsValue("null")) {
            request = request.queryParams(queryParam);
        }
        String dynamicPath = null;
        rating = commonUtil.randomRating();
        String id = commonUtil.getTemporaryText();
        try {
            dynamicPath = commonUtil.returnSchema() + ".Table:::" + id + "/" + rating;
            invokePostRequest(path + dynamicPath);
            commonUtil.addElementsInList(String.valueOf(rating));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Then("^user makes a REST Call for DELETE request with url \"([^\"]*)\" and id for \"([^\"]*)\" user$")
    public void user_makes_a_REST_Call_for_DELETE_request_with_url_and_id_for_user(String path, String user) throws Throwable {
        String dynamicPath;
        String userName = null;
        String id = commonUtil.getTemporaryText();
        try {
            switch (user) {
                case "TestService":
                    userName = "?user=TestService";
                    break;
                case "TestSystem":
                    userName = "?user=TestSystem";
                    break;
                case "TestInfo":
                    userName = "?user=TestInfo";
                    break;
            }
            dynamicPath = commonUtil.returnSchema() + ".Table:::" + id + userName;
            invokeDeleteRequest(path + dynamicPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^deleted id must not be present in table \"([^\"]*)\" in database$")
    public void deleted_id_must_not_be_present_in_table_in_database(String tableName) throws Throwable {
        try {
            String id = commonUtil.getTemporaryText();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "GetId" + id);
            db_postgres_util = new DBPostgresUtil();
            String columnName = commonUtil.returnSchema() + ".Table__I";
            int count = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(commonUtil.returnSchema(), tableName, columnName, Integer.parseInt(id)));
            Assert.assertEquals(count, 0);

        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Exception is: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted id is present in database: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^user makes a REST Call for Get request with url \"([^\"]*)\" for the specific id$")
    public void user_makes_a_REST_Call_for_Get_request_with_url_for_the_specific_id(String path) throws Throwable {
        String dynamicPath = null;
        String id = commonUtil.getTemporaryText();
        try {
            dynamicPath = commonUtil.returnSchema() + ".Table%3A%3A%3A" + id + "?limit=10&order=date&reverse=true";
            invokeGetRequest(path + dynamicPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Then("^all rating should be displayed for specified item$")
    public void all_rating_should_be_displayed_for_specified_item() throws Throwable {
        try {
            Assert.assertEquals(commonUtil.getElementsInList().size(), 2);
            int rating = Integer.parseInt(commonUtil.getElementsInList().get(0));
            int secondRating = Integer.parseInt(commonUtil.getElementsInList().get(1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating of first user: " + rating + "Rating of Second user: " + secondRating);
            Assert.assertEquals(secondRating, response().jsonPath().getInt("ratings.rating[0]"));
            Assert.assertEquals(rating, response().jsonPath().getInt("ratings.rating[1]"));
        } catch (Exception e) {
            Assert.fail("Ratings not displayed: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        }
    }

    @Then("^compare the average rating displayed for the item$")
    public void compare_the_average_rating_displayed_for_the_item() throws Throwable {
        try {
            int rating = Integer.parseInt(commonUtil.getElementsInList().get(0));
            int secondRating = Integer.parseInt(commonUtil.getElementsInList().get(1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating of first user : " + rating + "Rating of Second user: " + secondRating);
            float avgRating = secondRating + rating;
            float average = avgRating / 2;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Average Rating: " + average);
            int compare = Float.compare(average, response().jsonPath().getFloat("averageRating"));
            Assert.assertEquals(compare, 0);
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Average Rating not matched: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        }
    }

    @Then("^get average Rating of the specified item$")
    public void get_average_Rating_of_the_specified_item() throws Throwable {
        try {
            int rating = Integer.parseInt(commonUtil.getElementsInList().get(0));
            int secondRating = Integer.parseInt(commonUtil.getElementsInList().get(1));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Rating of first user : " + rating + "Rating of Second user: " + secondRating);
            float avgRating = secondRating + rating;
            float average = (avgRating) / 2;
            commonUtil.storeTemporaryFloatNumber(average);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Average Rating : " + average);

        } catch (Exception e) {
            Assert.fail("Average Rating not matched: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        }
    }

    @Then("^deleted id must not be present in table \"([^\"]*)\" in database for \"([^\"]*)\"$")
    public void deleted_id_must_not_be_present_in_table_in_database_for(String tableName, String userName) throws Throwable {
        try {
            String id = commonUtil.getTemporaryText();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "GetId" + id);
            db_postgres_util = new DBPostgresUtil();
            String columnName = commonUtil.returnSchema() + ".Table__I";
            String modified = "asg.modifiedBy";
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "SELECT * FROM \"" + commonUtil.returnSchema() + "\".\"" + tableName + "\" where \"" + columnName + "=" + id + "\" and  \" asg.modifiedBy" + "\" =" + userName + "");
            int count = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(commonUtil.returnSchema(), tableName, modified, userName, columnName, id));
            //("SELECT * FROM \"" + commonUtil.returnSchema() + "\".\"" + tableName + "\" where \""+ columnName + "" +"=" id + and asg.modifiedBy" + "\"+ =" + userName +"");
            Assert.assertEquals(count, 0);

        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Exception is: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted id is present in database " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^average rating should be changed after deletion$")
    public void average_rating_should_be_changed_after_deletion() throws Throwable {
        try {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Elements" + commonUtil.getElementsInList());
            float rating = Integer.parseInt(commonUtil.getElementsInList().get(1));
            int compare = Float.compare(rating, response().jsonPath().getFloat("averageRating"));
            Assert.assertEquals(compare, 0);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Previous Average Rating:" + commonUtil.getTemporaryFloatNumber() + "Average Rating after Deletion: " + response().jsonPath().getFloat("averageRating"));
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Average Rating not changed after Deletion : " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        }
    }

    @Then("^user makes a REST Call for Get request with url \"([^\"]*)\" for the specific user$")
    public void user_makes_a_REST_Call_for_Get_request_with_url_for_the_specific_user(String path) throws Throwable {
        String dynamicPath = null;
        try {
            dynamicPath = commonUtil.returnSchema() + "?limit=10&order=date&reverse=true";
            invokeGetRequest(path + dynamicPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^rating and table id must be matched with table \"([^\"]*)\" in database for \"([^\"]*)\" user$")
    public void rating_and_table_id_must_be_matched_with_table_in_database_for_user(String tableName, String userName) throws Throwable {
        try {
            db_postgres_util = new DBPostgresUtil();
            String columnName = "asg.modifiedBy";
            String id = commonUtil.returnSchema() + ".Table__I";
            List<String> ratingReturnList = db_postgres_util.returnQueryList(commonUtil.returnSchema(), tableName, "rating", columnName, userName);
            List<String> tableId = db_postgres_util.returnQueryList(commonUtil.returnSchema(), tableName, id, columnName, userName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Ratings" + ratingReturnList + "Id" + tableId);
            Assert.assertTrue(returnRestResponse().contains(" \"rating\" : " + ratingReturnList.get(0)));
            Assert.assertTrue(returnRestResponse().contains(" \"rating\" : " + ratingReturnList.get(1)));
            String firstId = commonUtil.returnSchema() + ".Table:::" + tableId.get(0);
            String secondId = commonUtil.returnSchema() + ".Table:::" + tableId.get(1);
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + firstId + ""));
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + secondId + ""));
        } catch (Exception e) {
            Assert.fail("Ratings and table id not matched: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^To generate dynamic query with the following param$")
    public void to_generate_dynamic_query_with_the_following_param(DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        criteriaValue.add("1");
        criteriaValue.add("Hello");
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
        LoggerUtil.logLoader_info(this.getClass().getName(), Query);
    }

    @Then("^Response id return in json format must match with table in database$")
    public void response_id_return_in_json_format_must_match_with_table_in_database(DataTable dataTableCollection) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        List<String> criteriaValue = new ArrayList<>();
        int dbID = 0;
        String splitIdValue = null;
        splitIdValue = returnRestResponse().replaceAll("[^0-9]", "");
        criteriaValue.add(splitIdValue);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated API Response Id is: " + splitIdValue);
        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            db_postgres_util = new DBPostgresUtil();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            dbID = db_postgres_util.get_Value(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query based on API response ID : " + "queryBuilder" + splitIdValue + "Total No of rows: " + dbID);
            Assert.assertEquals(Integer.parseInt(splitIdValue), dbID);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "ID comparison between API ID is: " + splitIdValue + " and DB ID is :" + dbID + " Success");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Exception is: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Actual id " + splitIdValue + "is not matched with Expected id: " + dbID + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }


    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with dynamic id and rating as \"([^\"]*)\" for \"([^\"]*)\" with following query param$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_dynamic_id_and_rating_as_for_with_following_query_param(String path, String rating, String table, Map<String, String> queryParam) throws Throwable {
        if (!queryParam.containsValue("null")) {
            request = request.queryParams(queryParam);
        }
        id = commonUtil.random(1, 20);
        String dynamicPath = null;
        try {
            dynamicPath = commonUtil.returnSchema() + "." + table + ":::" + id + "/" + rating;
            invokePostRequest(path + dynamicPath);
            commonUtil.addElementsInList(String.valueOf(id));
        } catch (Exception e) {
            e.getCause();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Then("^user makes a REST Call for POST request with url \"([^\"]*)\" with id and rating as \"([^\"]*)\" for \"([^\"]*)\" with following query param$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_with_id_and_rating_as_for_with_following_query_param(String path, String rating, String table, Map<String, String> queryParam) throws Throwable {

        if (!queryParam.containsValue("null")) {
            request = request.queryParams(queryParam);
        }
        String dynamicPath = null;
        String id = commonUtil.getElementsInList().get(0);
        try {

            dynamicPath = commonUtil.returnSchema() + "." + table + ":::" + id + "/" + rating;
            invokePostRequest(path + dynamicPath);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Id in List" + commonUtil.getElementsInList());
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }


    }

    @Then("^response message should contain the recommended id of similar rated items for \"([^\"]*)\"$")
    public void response_message_should_contain_the_recommended_id_of_similar_rated_items_for(String table) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        try {
            String firstId = commonUtil.returnSchema() + "." + table + ":::" + commonUtil.getElementsInList().get(1);
            String secondId = commonUtil.returnSchema() + "." + table + ":::" + commonUtil.getElementsInList().get(2);
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + firstId + ""));
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + secondId + ""));
            List<String> recommendedId = db_postgres_util.returnQueryList(commonUtil.returnSchema(), "recommender", "recommended", "username", "TestSystem");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Recommended Item Id in Response: " + firstId + secondId + "Recommended Item ID in DB: " + recommendedId);
            recommendedId.contains(firstId);
            recommendedId.contains(secondId);
        } catch (Exception e) {
            Assert.fail("Recommended items id not matched: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response message should contain the recommended id of highly rated items$")
    public void response_message_should_contain_the_recommended_id_of_highly_rated_items() throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        try {
            String firstId = commonUtil.returnSchema() + ".Table:::" + commonUtil.getElementsInList().get(2);
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + firstId + ""));
            List<String> recommendedId = db_postgres_util.returnQueryList(commonUtil.returnSchema(), "recommender", "recommended", "username", "TestSystem");
            recommendedId.contains(firstId);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Recommended Item Id" + firstId);
        } catch (Exception e) {
            Assert.fail("Recommended items id not matched: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }


    }

    @Given("^User get the java file count from bitbucket$")
    public void user_get_the_java_file_count_from_bitbucket() throws Throwable {
        try {
            DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(new Integer(response().jsonPath().getInt("size")));

        } catch (Exception e) {

        }
    }

    @And("^verify created quicklink is available for TestSystem User$")
    public void verifyCreatedQuicklinkIsAvailableForTestSystemUser(DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        try {
            String response = returnRestResponse();

            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestSystem");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                LoggerUtil.logLoader_info(this.getClass().getName(), list);
                if (list.contains("\"name\":\"list of Tables\"") && list.contains(response)) {


                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");

                } else {
                    Assert.fail("Quicklink not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found");

                }
            }

        } catch (Exception e) {
            Assert.fail("Quicklink not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }

    }

    @And("^verify created quicklink is available for multiwidget in TestSystem User$")
    public void verifyCreatedQuicklinkIsAvailableForMultiwidgetInTestSystemUser(DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        try {
            String response = returnRestResponse();

            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestSystem");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                LoggerUtil.logLoader_info(this.getClass().getName(), list);
                if (list.contains("\"name\":\"list of Analysis\"") && list.contains(response)) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");

                } else {
                    Assert.fail("Quicklink not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found");

                }
            }

        } catch (Exception e) {
            Assert.fail("Quicklink not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^verify created quicklink for Solr search is available for TestSystem user$")
    public void verifyCreatedQuicklinkForSolrSearchIsAvailableForTestSystemUser(DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        try {
            String response = returnRestResponse();
            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestService");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                LoggerUtil.logLoader_info(this.getClass().getName(), list);
                if (list.contains("\"name\":\"list of Tables by Solr\"") && list.contains(response) &&
                        (list.contains("\"data\":\"schema_s:BigData AND type_s:Table\""))) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");

                } else {
                    Assert.fail("Quicklink not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found");

                }
            }

        } catch (Exception e) {
            Assert.fail("Quicklink not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }


    }

    @And("^response body quick link should match the saved quicklink json in V_Setting table$")
    public void responseBodyShouldMatchTheSavedQuicklinkJsonInConfigTable(DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> quicklinkList = new ArrayList<>();
        List<String> criteriaValue = new ArrayList<>();
        String nodeName = "name";
        try {
            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestSystem");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            quicklinkList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getName(), returnNodeValue(nodeName));
            if (quicklinkList.get(0).contains(returnNodeValue(nodeName))) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");
            } else {
                Assert.fail("Quicklink from GET request could not be found in table");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink from GET request could " +
                        "not be found in table");
            }


        } catch (Exception e) {
            Assert.fail("Quicklink which was retruned from GET doesn't match with the table data");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }


    }

    @And("^response body should have \"([^\"]*)\" message$")
    public void responseBodyShouldHaveMessage(String msg) throws Throwable {
        try {
            String response = returnRestResponse();
            if (response.contains(msg)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Exception message meets the expected");
            } else {
                Assert.fail("response body didn't meet the expected");
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "returned Quicklink not matching" +
                        " with table value");
            }

        } catch (Exception e) {
            Assert.fail("Quicklink which was retruned from GET doesn't match with the table data");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^Dynamic rating must be matched with the table in database for \"([^\"]*)\"$")
    public void dynamic_rating_must_be_matched_with_the_table_in_database_for(String userName, DataTable dataTableCollection) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        db_postgres_util = new DBPostgresUtil();
        int noOfrows = 0;
        List<String> criteriaValue = new ArrayList<>();
        String rating = String.valueOf(commonUtil.randomRate);
        criteriaValue.add(userName);
        criteriaValue.add(rating);
        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            noOfrows = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query : " + queryBuilder + "Total No of rows: " + noOfrows);
            Assert.assertEquals(noOfrows, 1);

        } catch (Exception e) {

            Assert.fail("Test Fail" + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Rows not matching for rating : " + noOfrows + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^deleted id must not be present in table in database for \"([^\"]*)\"$")
    public void deleted_id_must_not_be_present_in_table_in_database_for(String userName, DataTable dataTableCollection) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        String id = commonUtil.getTemporaryText();
        criteriaValue.add(id);
        criteriaValue.add(userName);
        int rowCount = 0;
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query based: " + queryBuilder + " No of rows: " + rowCount);
            Assert.assertEquals(rowCount, 0);
        } catch (Exception e) {
            Assert.fail("Deleted id Exception is: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted id " + id + "is present  in database:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }


    @Then("^response message should contain the recommended \"([^\"]*)\" id of similar rated items for \"([^\"]*)\"$")
    public void response_message_should_contain_the_recommended_id_of_similar_rated_items_for(String tableName, String userName, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        criteriaValue.add(userName);
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            String firstId = commonUtil.returnSchema() + "." + tableName + ":::" + commonUtil.getElementsInList().get(1);
            String secondId = commonUtil.returnSchema() + "." + tableName + ":::" + commonUtil.getElementsInList().get(2);
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + firstId + ""));
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + secondId + ""));
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            List<String> recommendedId = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query based: " + queryBuilder + "Recommended ID from DB: " + recommendedId);
            Assert.assertTrue(recommendedId.get(0).contains(firstId));
            Assert.assertTrue(recommendedId.get(0).contains(secondId));
            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Recommended id of similar rated items not found:  " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Recommended id of similar rated items not found:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^response message should contain the recommended \"([^\"]*)\" id of highly rated items for \"([^\"]*)\"$")
    public void response_message_should_contain_the_recommended_id_of_highly_rated_items_for(String tableName, String userName, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        criteriaValue.add(userName);
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {

            String firstId = commonUtil.returnSchema() + "." + tableName + ":::" + commonUtil.getElementsInList().get(2);
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + firstId + ""));
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            List<String> recommendedId = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query based: " + queryBuilder + "Recommended ID from DB: " + recommendedId);
            Assert.assertTrue(recommendedId.get(0).contains(firstId));

        } catch (Exception e) {
            Assert.fail("Recommended id of highly rated items not found:  " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Recommended id of highly rated items not found:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^rating must be matched with table in database for \"([^\"]*)\" user$")
    public void rating_must_be_matched_with_table_in_database_for_user(String userName, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        List<String> ratingReturnList = new ArrayList<>();
        criteriaValue.add(userName);
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            ratingReturnList = db_postgres_util.returnQueryIntList(queryBuilder, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Ratings from DB: " + ratingReturnList);
            Assert.assertTrue(returnRestResponse().contains(" \"rating\" : " + ratingReturnList.get(0)));
            Assert.assertTrue(returnRestResponse().contains(" \"rating\" : " + ratingReturnList.get(1)));


        } catch (Exception e) {
            Assert.fail("Rating not matched with table:  " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Rating not matched with table:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^table id must be matched with table in database for \"([^\"]*)\" user$")
    public void table_id_must_be_matched_with_table_in_database_for_user(String userName, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        List<String> tableIdList = new ArrayList<String>();
        criteriaValue.add(userName);
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            tableIdList = db_postgres_util.returnQueryIntList(queryBuilder, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table ID from DB: " + tableIdList);
            String firstId = commonUtil.returnSchema() + ".Table:::" + tableIdList.get(0);
            String secondId = commonUtil.returnSchema() + ".Table:::" + tableIdList.get(1);
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + firstId + ""));
            Assert.assertTrue(returnRestResponse().contains(" \"id\" : \"" + secondId + ""));

        } catch (Exception e) {
            Assert.fail("Table id not matched:  " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Table id not matched:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^updated quicklink json in should be saved config table$")
    public void updatedQuicklinkJsonInShouldBeSavedConfigTable(DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        try {
            String response = returnRestResponse();
            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestService");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                if (list.contains("\"name\":\"list of Files\"") &&
                        (list.contains("\"data\":\"File\""))) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");

                } else {
                    Assert.fail("Quicklink not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is not found");

                }
            }

        } catch (Exception e) {
            Assert.fail("Quicklink not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^Quick link with id (\\d+) should not be found in postgres$")
    public void quickLinkWithIdShouldNotBeFoundInPostgres(int arg0, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        try {
            String response = returnRestResponse();
            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestService");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                if (list.contains("\"id\": \"1\"")) {
                    Assert.fail("Quicklink is not deleted");
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Quicklink is found in DB");
                } else {
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Quicklink is deleted");
                }
            }

        } catch (Exception e) {
            Assert.fail("Quicklink not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^When query is ran to delete all quicklinks in \"([^\"]*)\" schema of \"([^\"]*)\" table$")
    public void whenQueryIsRanToDeleteAllQuicklinksInSchemaOfTable(String schemaName, String tableName) {
        db_postgres_util = new DBPostgresUtil();
        try {
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/quicklink_user.json/TestSystem"));
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/quicklink_user.json/TestData"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^Quicklink should not be found in \"([^\"]*)\" schema of \"([^\"]*)\" table$")
    public void quicklinkShouldNotBeFound(String schemaName, String tableName) throws Throwable {
        int rowCount;
        db_postgres_util = new DBPostgresUtil();
        try {
            rowCount = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/quicklink_user.json/TestService"));
            if (rowCount == 0) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
            } else {
                Assert.fail("Quicklinks is not deleted");
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @And("^Quicklinks from BigData Widget should be displaying$")
    public void quicklinksFromBigDataWidgetShouldBeDisplaying(DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        String nodeName = "name";
        int count = 0;
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No of Quicklinks found in a " +
                "widget from response: " + returnNodeValuesAsList(nodeName).size());
        try {
            String response = returnRestResponse();
            criteriaValue.add("com/asg/dis/platform/quicklink_user.json/TestSystem");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            String[] list = resultList.get(0).split(",");
            for (int i = 0; i < list.length - 1; i++) {
                if (list[i].contains("\"widgets\":[\"BigData\"")) {
                    count++;
                }
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No of Quicklinks found in a " +
                    "widget from database: " + count);
            Assert.assertEquals(returnNodeValuesAsList(nodeName).size(), count);
        } catch (Exception e) {
            Assert.fail("Quicklink count from Widget is mismatching");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^compare the count between Json Response and Solr Response$")
    public void compare_the_count_between_Json_Response_and_Solr_Response(DataTable table) throws Throwable {
        try {

            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            long solrCount = solr.Solr_SearchCountFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField());
            long count = returnJsonIntValue("count");
            Assert.assertEquals(count, solrCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "API count is successfully compared with Solr Search Results: " + count);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }

    }

    @Then("^compare \"([^\"]*)\" between Json Response and Solr Response with Search Index ID$")
    public void compare_between_Json_Response_and_Solr_Response_with_Search_Index_ID(String searchElement, DataTable table) {
        try {

            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> actual = returnElementLists(searchElement);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "IDC Rest API Search Results: " + actual);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            long solrCount = solr.Solr_SearchCountFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", "");
            if (actual.size() > 0) {
                Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), "", "", actual.get(0), 0, (int) solrCount));
                if (actual.size() > 1) {
                    int indexNumber = actual.size() - 1;
                    Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), "", "", actual.get(indexNumber), indexNumber, (int) solrCount));
                    int indexNo = actual.size() / 2;
                    Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), "", "", actual.get(indexNo), indexNo, (int) solrCount));
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Only one item found");
                }

            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No items found");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^New cluster Cluster Test should be created$")
    public void newClusterClusterTestShouldBeCreated(DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> arrResultList = new ArrayList<>();

        try {
            arrCriteriaValue.add("com/asg/dis/platform/analyzers/Cluster Test.json");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            arrResultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            if (arrResultList.size() == 1) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "New Cluster has been created");
            } else {
                Assert.fail("New Cluster didn't get created");
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "New Cluster didn't get created");
            }
        } catch (Exception e) {
            Assert.fail("Query could not be generated");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query could not be generated");
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @And("^response body should have the config from postgres DB$")
    public void responseBodyShouldTheConfigFromPostgresDB(DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> arrResultList = new ArrayList<>();
        try {
            arrCriteriaValue.add("com/asg/dis/platform/analyzers/Cluster Test.json");
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);

            arrResultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            if (arrResultList.get(0).contains("\"tags\":[\"Hive Test Tag1\",\"Hive Test Tag2\"]")) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "GET response Config matches with updated " +
                        "config of cluster");
            } else {
                Assert.fail("Updated cluster config could not match GET response");
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Updated cluster config " +
                        "could not match GET response");
            }
        } catch (Exception e) {
            Assert.fail("Query could not be generated");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query could not be generated");
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^cluster Test should be deleted from schema \"([^\"]*)\" of \"([^\"]*)\" table$")
    public void clusterTestShouldBeDeletedFromSchemaOfTable(String schemaName, String tableName) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        int nrowCount = 0;
        try {
            nrowCount = db_postgres_util.get_rowCount(db_postgres_util.selectQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/ingestion/Cluster Test.json"));
            if (nrowCount == 0) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Cluster Deleted Successfully");
            } else {
                Assert.fail("Cluster is not deleted");
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^newly added Tag template \"([^\"]*)\" should be found in the response body$")
    public void newlyAddedTagTemplateShouldBeFoundInTheResponseBody(String tagTemplateName) {
        String response = null;
        try {
            response = returnRestResponse();
            if (response.contains(tagTemplateName)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Teamplate " + tagTemplateName + " is found");
            } else {
                Assert.fail("Tag Template is not found");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tag Teamplate " + tagTemplateName + " is not found");
            }
        } catch (IOException e) {
            e.printStackTrace();
            Assert.fail("Tag Template is not found");
        }
    }
//Data Creation through REST API steps

    @Given("^I create \"([^\"]*)\" widget for \"([^\"]*)\" role$")
    public void i_create_widget_for_role(String widget, String role) throws Throwable {
        try {
            ArrayList<String> widgets = RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                    this,
                    JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/getCatalogs.json"),
                    role).getListFromResponse("name");

            if (widgets.contains(widget)) {

                RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                        this,
                        JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/deleteAnalysisWidget.json"),
                        role).validateResponseCode(204);

                RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                        this,
                        JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/createAnalysisWidget.json"),
                        role).validateResponseCode(204);

            } else {

                RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                        this,
                        JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/createAnalysisWidget.json"),
                        role).validateResponseCode(204);

            }

            RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                    this,
                    JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/getCatalogs.json"),
                    role)
                    .validateResponseContainsItems("name", widget);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.resetRestAPI();
            this.initializeRestAPI("IDC");
        }
    }


    @Given("^I create a dashboard with name \"([^\"]*)\" and add \"([^\"]*)\" widget for \"([^\"]*)\" role$")
    public void i_create_a_dashboard_with_name_and_add_widget_for_role(String dashboardName, String widget, String role) throws Throwable {

        try {

            //Check if an existing dashboard of the same name exists before recreating it
            ArrayList<String> dashboards = RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                    this,
                    JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/getDashboards.json"),
                    role).
                    getListFromResponse(".");

            if (dashboards.contains(dashboardName)) {

                //Existing Dashboard present , hence deleting it and recreating it
                RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                        this,
                        JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/deleteDashboard.json"),
                        role).validateResponseCode(204);

                RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                        this,
                        JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/createDashboard.json"),
                        role).validateResponseCode(204);

            } else {

                //No Dashboard present , hence just recreating it
                RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                        this,
                        JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/createDashboard.json"),
                        role).validateResponseCode(204);

            }

            //Verify if the newly created dashboard is present
            RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                    this,
                    JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/getDashboards.json"),
                    role).validateResponseContainsItems("$", dashboardName);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.resetRestAPI();
            this.initializeRestAPI("IDC");
        }
    }

    @Given("^I send series of requests for an operation$")
    public void i_send_series_of_requests_for_an_operation(List<CucumberDataSet> config) throws Throwable {

        String mashedupPayload = new String("nil");
        for (CucumberDataSet dataset : config) {

            if (mashedupPayload.equalsIgnoreCase("nil")) {
                RestBuilderUtil.buildRequestUsingConfigAndExecute(
                        this, dataset.requestConfig);
            } else {
                RestBuilderUtil.buildRequestUsingConfigAndExecute(
                        this, dataset.requestConfig, mashedupPayload);

            }
            RestBuilderUtil.validateResponse(this, dataset.responseConfig);
            if (dataset.responseRequiredOnNextCall.equalsIgnoreCase("Yes")) {

                mashedupPayload = RestBuilderUtil.updateResponse(this.getResponseAsString(), dataset.valueToUpdate);

            }

        }
    }

    @Then("^compare \"([^\"]*)\" and \"([^\"]*)\" between Json Response and Solr Response with Search Index ID$")
    public void compare_and_between_Json_Response_and_Solr_Response_with_Search_Index_ID(String searchElement, String searchValue, DataTable table) {
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> actual = returnElementLists(searchElement);
            List<String> types = returnElementLists(searchValue);
            for (String type : types) {
                Assert.assertTrue(type.equals("Table"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "IDC Rest API Search Results: " + actual + "API Results" + searchValue);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            if (actual.size() > 0) {
                Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), "", "", actual.get(0), 0, 10));
                if (actual.size() > 1) {
                    int indexNumber = actual.size() - 1;
                    Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), "", "", actual.get(indexNumber), indexNumber, actual.size()));
                    int indexNo = actual.size() / 2;
                    Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), "", "", actual.get(indexNo), indexNo, actual.size()));
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Only one item found");
                }

            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No items found");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^Database \"([^\"]*)\" and tableName \"([^\"]*)\" should be matching$")
    public void databaseAndTableNameShouldBeMatching(String databaseName, String tableName) throws Throwable {

        try {

            Assert.assertEquals(databaseName, returnNodeValue("hiveDatabaseName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with the upload data");
            Assert.assertEquals(tableName, returnNodeValue("hiveTableName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with the upload data");

        } catch (Exception e) {

            Assert.fail("Table andm DatabaseName is mismatching with upload Data");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table andm DatabaseName is mismatching with upload Data");

        }

    }

    @And("^user makes a REST Call for DELETE request with url \"([^\"]*)\" with the following query param$")
    public void userMakesARESTCallForDELETERequestWithUrlWithTheFollowingQueryParam(String path, Map<String, String> queryParam) throws Throwable {
        request = request.queryParams(queryParam);
        invokeDeleteRequest(path);
    }


    @And("^excel \"([^\"]*)\" should be uploaded to uploadData table$")
    public void excelShouldBeUploadedToUploadDataTable(String fileName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(fileName);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            Assert.assertEquals(fileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name is matching with uploaded file");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "firstColName")).get(0), returnNodeValue("hiveDatabaseName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "secColName")).get(0), returnNodeValue("hiveTableName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "clusterName")).get(0), returnNodeValue("clusterName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterName is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "hostName")).get(0), returnNodeValue("hostName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "hostName is matching with Given Queryparam");
        } catch (Exception e) {
            Assert.fail("Database and table name doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table/Database Name is not matching with given params");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^file \"([^\"]*)\" should be removed from upload Data$")
    public void fileShouldBeRemovedFromUploadData(String fileName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(fileName);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            if (columnValues.get("databaseName").size() == 0 && columnValues.get("tableName").size() == 0) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File is deleted successfully");
            } else {
                Assert.fail("File is not deleted and Upload data is still found in DB");
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File is not deleted and Upload " +
                        "data is still found in DB");
            }
        } catch (Exception e) {
            Assert.fail("Query could not be generated");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query could not be generated");
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^compare between Json Response and Solr Response matches$")
    public void compare_between_Json_Response_and_Solr_Response_matches(DataTable table) {
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            String[] actual = returnRestResponse().replace("\"", "").replace("[", "").replace("]", "").split(",");
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            List<FacetField> results = solr.solrSearchFacets(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), solr_dataTable.get(0).getSortField(), solr_dataTable.get(0).getSortOrder(), actual.length);
            for (String name : actual) {
                Assert.assertTrue(results.get(0).toString().contains(name.trim()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Solr Results Matched for " + name + "");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^I update the ingestion configuration for \"([^\"]*)\" role$")
    public void i_update_the_ingestion_configuration_for_role(String role, List<CucumberDataSet> config) throws Throwable {

        RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                this,
                JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/getIngestionConfiguration.json"),
                role).validateResponseContainsItems("configurations.GitCollector.findAll { GitCollector -> GitCollector.name == 'Bitbucket AnalysisDemoData'}.name", "Bitbucket AnalysisDemoData");
        this.response.prettyPrint();

        String inputData = this.getResponseAsString();

        for (CucumberDataSet dataset : config) {

            inputData = JsonBuildUpdateUtil.insertJsonNode(inputData, dataset.pathToConfig, dataset.configName, dataset.configValue).toString();
        }


        RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                this,
                JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/putIngestionConfiguration.json"),
                role,
                inputData)
                .validateResponseCode(204);

        RestBuilderUtil.buildRequestUsingConfigAndExecute("IDC",
                this,
                JsonRead.readJSONObject(TEST_DATA_PATH + "rest/request/getIngestionConfiguration.json"),
                role
                , inputData)
                .validateResponseContainsItems("configurations.GitCollector.findAll { GitCollector -> GitCollector.name == 'Bitbucket AnalysisDemoData'}" + "." + config.get(0).configName, config.get(0).configValue);

        this.response.prettyPrint();


    }

    @Given("^User gets the \"([^\"]*)\" included file count from bitbucket repository$")
    public void user_gets_the_included_file_count_from_bitbucket_repository(String fileExtn) throws Throwable {

        List<String> filelist = returnNodeValuesAsList("values");
        int filecount = 0;
        for (String fileExtension : filelist) {

            Pattern p = Pattern.compile(fileExtn);
            Matcher m = p.matcher(fileExtension);

            if (m.find()) {
                filecount++;

            }
            try {
                DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(filecount);

            } catch (Exception e) {

            }
        }


    }

    @Given("^User gets the \"([^\"]*)\" excluded file count from bitbucket repository$")
    public void user_gets_the_excluded_file_count_from_bitbucket_repository(String fileExtn) throws Throwable {
        List<String> filelist = returnNodeValuesAsList("values");
        int filecount = 0;
        for (String fileExtension : filelist) {
            Pattern p = Pattern.compile(fileExtn);
            Matcher m = p.matcher(fileExtension);

            if (!m.find()) {
                filecount++;

            }
            try {
                DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(filecount);

            } catch (Exception e) {

            }
        }

    }

    @Given("^User gets the file count of wildcards added in filter pattern from bitbucket repository$")
    public void user_gets_the_file_count_of_wildcards_added_in_filter_pattern_from_bitbucket_repository(DataTable fileExtn) throws Throwable {
        List<List<String>> data = fileExtn.raw();
        List<String> filelist = returnNodeValuesAsList("values");
        int filecount = 0;
        for (String fileExtension : filelist) {
            Pattern p = Pattern.compile(data.toString());
            Matcher m = p.matcher(fileExtension);

            if (!m.find()) {
                filecount++;

            }
            try {
                DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(filecount);

            } catch (Exception e) {

            }
        }


    }

    @Given("^sync the test execution for \"([^\"]*)\" seconds$")
    public void sync_the_test_execution_for_seconds(int arg1) throws Throwable {
        try {
            TimeUnit.SECONDS.sleep(arg1);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Given("^Add a random version for the \"([^\"]*)\" payload$")
    public void add_a_random_version_for_the_payload(String arg1) throws Throwable {

        try {
            String value = "version" + (int) (Math.random() * 50 + 10);
            JSONParser parser = new JSONParser();
            Object obj = parser.parse(new FileReader(REST_PAYLOAD + arg1));
            JSONObject object = new JSONObject(obj.toString());
            JSONObject json = object.getJSONObject("Clusters").getJSONObject("desired_config");
            JSONObject j = json.put("tag", value);
            FileWriter fW = new FileWriter(REST_PAYLOAD + arg1);
            fW.write(object.toString());
            fW.flush();


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @And("^verify the Ambari status with the status code \"([^\"]*)\"$")
    public void verify_the_Ambari_status_with_the_status_code(int expectedStatusCode) throws Throwable {
        try {
            returnRestResponse();
            Assert.assertEquals(returnStatusCode(), expectedStatusCode);
        } catch (Exception e) {
            Assert.fail("Exception is: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            if (returnStatusCode() == HttpStatus.SC_OK) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Catatloger is already stopped");
            } else {
                Assert.fail("Actual code is not matched with  Expected code: " + e.getMessage());
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
            }
        }


    }


    @Given("^response returns with the following hdfs property items$")
    public void response_returns_with_the_following_hdfs_property_items() throws Throwable {
        returnRestResponse();
        LoggerUtil.logLoader_info(this.getClass().getName(), returnRestResponse());

    }

    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" and store the response$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_and_store_the_response(String path) throws Throwable {

        try {
            invokePostRequest(path);

            commonUtil.storeText(returnRestResponse());

        } catch (Exception e) {
            e.getCause();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @When("^user makes a REST Call for GET request with url \"([^\"]*)\" and store the response$")
    public void user_makes_a_REST_Call_for_GET_request_with_url_and_store_the_response(String path) throws Throwable {

        try {
            invokeGetRequest(path);
            commonUtil.storeTemporaryText(returnRestResponse());

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "" + returnRestResponse().toString());
        } catch (Exception e) {
            e.getCause();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }


    @Then("^user makes a REST Call for DELETE request for the catalogid\\.$")
    public void user_makes_a_REST_Call_for_DELETE_request_for_the_catalogid() throws Throwable {

        String catalogID = commonUtil.getText().replaceAll("\\[|\\]|\"", "");
        String catalogIDwithoutspace = catalogID.replaceAll("\\s", "");
        String[] splitResponse = catalogIDwithoutspace.split(",");
        for (int resp = 0; resp < splitResponse.length; resp++) {
            String path = "/items/BigData/" + splitResponse[resp];
            invokeDeleteRequest(path);

        }


    }

    @Given("^user makes a REST Call for PUT request with update url$")
    public void user_makes_a_REST_Call_for_PUT_request_with_update_url() throws Throwable {
        String catalogID = commonUtil.getText().replaceAll("\\[|\\]|\"", "");
        String catalogIDwithoutspace = catalogID.replaceAll("\\s", "");
        String[] splitResponse = catalogIDwithoutspace.split(",");
        for (String response : splitResponse) {
            String path = "/items/BigData/" + response;
            invokePutRequest(path);

        }

//        String path="/items/BigData/"+catalogIDwithoutspace;
//        invokePutRequest(path);
    }

    @When("^user makes a REST call for DELETE to delete the catalog created\\.$")
    public void user_makes_a_REST_call_for_DELETE_to_delete_the_catalog_created() throws Throwable {
        String catalogID = commonUtil.getText().replaceAll("\\[|\\]|\"", "");
        String catalogIDwithoutspace = catalogID.replaceAll("\\s", "");
        String[] splitResponse = catalogIDwithoutspace.split(",");
        for (String response : splitResponse) {
            String path = "/items/BigData/" + response;
            invokeDeleteRequest(path);

        }

    }

    @Given("^user makes a REST call for POST with url \"([^\"]*)\" and body to delete the catalog created\\.$")
    public void user_makes_a_REST_call_for_POST_with_url_and_body_to_delete_the_catalog_created(String path) throws Throwable {
        request = request.body(commonUtil.getText());
        invokePostRequest(path);

    }

    @Given("^user makes a REST Call for POST request with url \"([^\"]*)\" and add the scope id to path$")
    public void user_makes_a_REST_Call_for_POST_request_with_url_and_add_the_scope_id_to_path(String path) throws Throwable {

        String catalogID = commonUtil.getText().replaceAll("\\[|\\]|\"", "");
        String scopeIdWithOutSpace = catalogID.replaceAll("\\s", "");
        String paramPath = path + scopeIdWithOutSpace;
        invokePostRequest(paramPath);

    }


    @Given("^user passes the jsonquery \"([^\"]*)\" response message contains value \"([^\"]*)\"$")
    public void user_passes_the_jsonquery_response_message_contains_value(String arg1, String arg2) throws Throwable {
        boolean status = false;
        try {
            //responseMessage = jsonFormater.jsonformat(returnRestResponse());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
            LoggerUtil.logLoader_info(returnRestResponse().toString(), "Return Response");
            status = returnJsonValue(arg1).contains(arg2);
            if (!status)
                Assert.fail("Such Element value not found in API Json Response");
            else
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is found in API Response");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Given("^user deletes the created tag \"([^\"]*)\"$")
    public void user_deletes_the_created_tag(String arg1) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        try {
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery("BigData", "V_Tag", "name",
                    arg1));

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @When("^Response return in swagger should match with response returned from \"([^\"]*)\" column from path \"([^\"]*)\"  in database table$")
    public void response_return_in_swagger_should_match_with_response_returned_from_column_from_path_in_database_table(String columnName, String criteria, DataTable dataTableCollection) throws Throwable {
        try {
            db_postgres_util = new DBPostgresUtil();
            List<String> criteriaValue = new ArrayList<>();
            criteriaValue.add(criteria);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            db_postgres_util.returnQueryList(queryBuilder, "data");
            String expectedResponse = db_postgres_util.get_String_Value(queryBuilder, columnName);
            String actualResponse = returnRestResponse().replaceAll("[\r\n]+", " ").replaceAll("\\s+(?=([^\"]*\"[^\"]*\")*[^\"]*$)", "");
            if (actualResponse.contains("\"cloudUri\":false,")) {
                actualResponse = actualResponse.replace("\"cloudUri\":false,", "");
            }
            if (commonUtil.compareTwoJsonStrings(expectedResponse, actualResponse) == true) {
                LoggerUtil.logLoader_info(this.getClass().getName(), "Values in Database and Swagger matches");

            } else {
                Assert.fail("Values in Database and Swagger mismatches");

            }
        } catch (Exception e) {
            Assert.fail("Values in Database and Swagger mismatches");

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^both \"([^\"]*)\" directory file \"([^\"]*)\" and \"([^\"]*)\" directory file \"([^\"]*)\" should match$")
    public void bothDirectoryFileAndDirectoryFileShouldMatch(String srcDir, String srcFile,
                                                             String destDir, String destFile) {
        try {
            Assert.assertTrue(FileUtil.fileCompare(propLoader.prop.getProperty(srcDir) + srcFile,
                    propLoader.prop.getProperty(destDir) + destFile));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Downloaded File content is matching source file");
        } catch (Exception e) {
            Assert.fail("Downloaded File content is not matching with source file");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Downloaded File content is not matching with source file");
        }

    }

    @And("^both \"([^\"]*)\" directory file \"([^\"]*)\" and \"([^\"]*)\" directory file \"([^\"]*)\" should match Exactly$")
    public void bothDirectoryFileAndDirectoryFileShouldMatchexactly(String srcDir, String srcFile,
                                                                    String destDir, String destFile) {
        try {
            Assert.assertTrue(FileUtil.fileImageCompare(Constant.FEATURES + srcDir + srcFile,
                    Constant.FEATURES + destDir + destFile));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Downloaded File content is matching source file");
        } catch (Exception e) {
            Assert.fail("Downloaded File content is not matching with source file");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Downloaded File content is not matching with source file");
        }

    }


    @And("^user should able to download the file in \"([^\"]*)\" and save it as \"([^\"]*)\"$")
    public void userShouldAbleToDownloadTheFileInAndSaveItAs(String destDir, String downloadedFileName) throws Throwable {
        try {
            responseFileDownload(destDir, downloadedFileName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File downloaded Successfully");
        } catch (Exception e) {
            Assert.fail("File could not be downloaded");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File could not be downloaded");
        }
    }


    @Given("^user performs update in DB for a particular row \"([^\"]*)\" with value \"([^\"]*)\"$")
    public void user_performs_update_in_DB_for_a_particular_row_with_value(String rowNum, String value, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        criteriaValue.add(rowNum);
        String columnValue = null;
        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            if (value.equals("")) {
                columnValue = value;
            } else {
                columnValue = value + commonUtil.randomint(1, 30);
            }
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue, columnValue);
            if (!value.equals("")) {
                commonUtil.storeTemporaryText(columnValue);
            }
            db_postgres_util.updateQuery(queryBuilder);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^value for \"([^\"]*)\" should not be updated in solr$")
    public void value_for_should_not_be_updated_in_solr(String fieldName, DataTable table) throws Throwable {
        List<String> solrList = new ArrayList<>();
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            solrList = solr.solrGetFieldValue(solr_dataTable.get(0).getQueryName(), filterQuery, "", "/select", fieldName);
            if (!solrList.get(0).contains("false")) {
                Assert.assertFalse(removeSpecialChar(solrList.get(0)).contains(commonUtil.getTemporaryText()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description" + solrList.get(0) + "is not updated in solr");
            }


        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^value for \"([^\"]*)\" should be updated in solr$")
    public void value_for_should_be_updated_in_solr(String fieldName, DataTable table) throws Throwable {
        List<String> solrList = new ArrayList<>();
        ;
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            solrList = solr.solrGetFieldValue(solr_dataTable.get(0).getQueryName(), filterQuery, "", "/select", fieldName);
            Assert.assertTrue(removeSpecialChar(solrList.get(0)).equalsIgnoreCase(commonUtil.getTemporaryText()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description" + commonUtil.getTemporaryText() + " is updated in solr");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^value for \"([^\"]*)\" should be updated only for one item in solr$")
    public void value_for_should_be_updated_only_for_one_item_in_solr(String fieldName, DataTable table) throws Throwable {
        List<String> solrList = new ArrayList<>();
        List<String> fieldList = new ArrayList<>();
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            solrList = solr.solrGetFieldValue(solr_dataTable.get(0).getQueryName(), filterQuery, "", "/select", fieldName);
            Assert.assertTrue(removeSpecialChar(solrList.get(0)).contains("TestValue"));
            List<String> filter = Arrays.asList(solr_dataTable.get(1).getFilterQuery().split(","));
            fieldList = solr.solrGetFieldValue(solr_dataTable.get(1).getQueryName(), filter, "", "/select", fieldName);
            if (!fieldList.get(0).contains("false")) {
                Assert.assertFalse(removeSpecialChar(fieldList.get(0)).contains(commonUtil.getTemporaryText()));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description" + solrList.get(0) + "is not updated in solr");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^response message should contain username as \"([^\"]*)\"$")
    public void response_message_should_contain_username_as(String ElementValue) throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        boolean status = false;
        try {
            LoggerUtil.logLoader_info(returnRestResponse().toString(), "Return Response");
            status = returnRestResponse().toString().equals('"' + ElementValue + '"');
            if (!status)
                Assert.fail("Such Element value not found in API Json Response");
            else
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is found in API Response");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @Then("^oracle index \"([^\"]*)\" should get deleted from  database$")
    public void oracle_index_should_get_deleted_from_database(String schema, DataTable table) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        db_postgres_util = new DBPostgresUtil();

        try {
            criteriaValue.add(schema);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(table, criteriaValue);
            db_postgres_util = new DBPostgresUtil();
            db_postgres_util.get_String_Value(queryBuilder, schema);

            if (!(db_postgres_util.get_String_Value(queryBuilder, schema) == null)) {
                Assert.fail("Not deleted");
            } else {
                LoggerUtil.logLoader_info(this.getClass().getName(), "deleted");
            }
        } catch (Exception e) {
            Assert.fail("Problem in connecting database");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^user get all the column names from database \"([^\"]*)\"$")
    public void user_get_all_the_column_names_from_database(String criteria, DataTable table) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        db_postgres_util = new DBPostgresUtil();

        try {
            criteriaValue.add(criteria);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQueryWithOperators(table, criteriaValue, "like");


            Set<String> set = new HashSet<String>(db_postgres_util.returnQueryList(queryBuilder, "column_name"));
            for (String temp : set) {
                LoggerUtil.logLoader_info(this.getClass().getName(), temp);
            }
        } catch (Exception e) {
            Assert.fail("Problem in connecting database");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^excel \"([^\"]*)\" should be uploaded to new cluster \"([^\"]*)\"$")
    public void excelShouldBeUploadedToNewCluster(String fileName, String clusterName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(clusterName);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            Assert.assertEquals(fileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name is matching with uploaded file");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "firstColName")).get(0), returnNodeValue("hiveDatabaseName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "secColName")).get(0), returnNodeValue("hiveTableName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "clusterName")).get(0), returnNodeValue("clusterName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterName is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "hostName")).get(0), returnNodeValue("hostName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "hostName is matching with Given Queryparam");
        } catch (Exception e) {
            Assert.fail("Database and table name doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table/Database Name is not matching with given params");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^Database \"([^\"]*)\" and tableName \"([^\"]*)\" and cluster \"([^\"]*)\" and file \"([^\"]*)\"should be matching$")
    public void databaseAndTableNameAndClusterAndFileShouldBeMatching(String dbName, String tableName, String clusterName, String fileName) {

        try {

            Assert.assertEquals(dbName, returnNodeValue("hiveDatabaseName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with the upload data");
            Assert.assertEquals(tableName, returnNodeValue("hiveTableName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with the upload data");
            Assert.assertEquals(clusterName, returnNodeValue("clusterName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterName is matching with the upload data");
            Assert.assertEquals(fileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File name is matching with upload data");

        } catch (Exception e) {

            Assert.fail("Table,DatabaseName, Cluster and File Name is mismatching with upload Data");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table,DatabaseName, Cluster and File Name is mismatching with upload Data");

        }

    }

    @Then("^file \"([^\"]*)\" should be removed from \"([^\"]*)\" database and \"([^\"]*)\" table$")
    public void file_should_be_removed_from_database_and_table(String fileName, String dbName, String tableName, DataTable dataTableCollection) throws Throwable {

        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> columnValues = new ArrayList<>();
        try {
            arrCriteriaValue.add(dbName);
            arrCriteriaValue.add(tableName);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            if (columnValues.get(0).equals("DELETE")) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File is deleted successfully");
            } else {
                Assert.fail("File is not deleted and Upload data is still found in DB");
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File is not deleted and Upload " +
                        "data is still found in DB");
            }
        } catch (Exception e) {
            Assert.fail("Query could not be generated");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query could not be generated");
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^compare \"([^\"]*)\" and \"([^\"]*)\" between Json Response and Solr Response with type \"([^\"]*)\"$")
    public void compare_and_between_Json_Response_and_Solr_Response_with_type(String searchElement, String searchValue, String typeName, DataTable table) {
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> actual = returnElementLists(searchElement);
            List<String> types = returnElementLists(searchValue);
            for (String type : types) {
                Assert.assertTrue(type.equals(typeName));

            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "IDC Rest API Search Results: " + actual + "API Results" + searchValue);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            long solrCount = solr.Solr_SearchCountFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", "");
            if (actual.size() > 0) {
                Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), solr_dataTable.get(0).getSortField(), solr_dataTable.get(0).getSortOrder(), actual.get(0), 0, (int) solrCount));
                if (actual.size() > 1) {
                    int indexNumber = actual.size() - 1;
                    Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), solr_dataTable.get(0).getSortField(), solr_dataTable.get(0).getSortOrder(), actual.get(indexNumber), indexNumber, (int) solrCount));
                    int indexNo = actual.size() / 2;
                    Assert.assertTrue(solr.solrSearchFilters(solr_dataTable.get(0).getQueryName(), filterQuery, "/select", solr_dataTable.get(0).getFacetField(), solr_dataTable.get(0).getSortField(), solr_dataTable.get(0).getSortOrder(), actual.get(indexNo), indexNo, (int) solrCount));
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Only one item found");
                }

            } else {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "No items found");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^excel \"([^\"]*)\" should be uploaded to uploadData table \"([^\"]*)\"$")
    public void excelShouldBeUploadedToUploadDataTable(String fileName, String tableName, DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(tableName);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            Assert.assertEquals(fileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name is matching with uploaded file");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "firstColName")).get(0), returnNodeValue("hiveDatabaseName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "secColName")).get(0), returnNodeValue("hiveTableName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "clusterName")).get(0), returnNodeValue("clusterName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterName is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "hostName")).get(0), returnNodeValue("hostName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "hostName is matching with Given Queryparam");
        } catch (Exception e) {
            Assert.fail("Database and table name doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table/Database Name is not matching with given params");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^root tags \"([^\"]*)\" should be \"([^\"]*)\"$")
    public void rootTagsShouldBe(String originTypePath, String glossaryType) throws Throwable {
        String origin = null;
        try {
            origin = getValueFromResponse(originTypePath);
            if (origin.equals(glossaryType)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Root Tag type is matching as expected");
            } else {
                Assert.fail("Root Tag's type from xml import file is mismatching");
            }
        } catch (Exception e) {
            Assert.fail("Root Tag's type from xml import file is mismatching");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Root Tag's type from xml import file is mismatching");
        }
    }

    @And("^BigData catalog should be having a root tag template \"([^\"]*)\" as \"([^\"]*)\"$")
    public void bigdataCatalogShouldBeHavingARootTagTemplateAs(String rootTagPath, String rootTagName) {
        String rootTag = null;
        try {
            rootTag = getValueFromResponse(rootTagPath);
            if (rootTag.equals(rootTagName)) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Root Tag's name is matcging as expected");
            } else {
                Assert.fail("Root Tag's name from xml import file is mismatching");
            }
        } catch (Exception e) {
            Assert.fail("Root Tag's name from xml import file is mismatching");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Root Tag's name and tag count from xml import file is mismatching");
        }
    }

    @And("^Subtags \"([^\"]*)\" should be available and tag count should be (\\d+)$")
    public void subtagsShouldBeAvailableAndTagCountShouldBe(String subTagsPath, int tagCount) {
        List<String> arrSubTagList = new ArrayList<>();
        try {
            arrSubTagList = returnNodeValuesAsList(subTagsPath);
            if (arrSubTagList.size() == tagCount) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Root Tag's name and child tag count is matching from xml import file");
            } else {
                Assert.fail("Root Tag's name and tag count from xml import file is mismatching");
            }
        } catch (Exception e) {
            Assert.fail("Root Tag's name and tag count from xml import file is mismatching");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Root Tag's name and tag count from xml import file is mismatching");
        }
    }

    @And("^Subtags \"([^\"]*)\" should be \"([^\"]*)\"$")
    public void subtagsShouldBe(String subTagsOriginPath, String originType) {
        List<String> arrSubTagOriginList = new ArrayList<>();
        try {

//            for (String origintype : arrSubTagOriginList) {
            Assert.assertTrue(getJsonValueUsingJsonPath(subTagsOriginPath).equals(originType));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Default allowed type is coming as RBG/BUSINESS-TERM");
//            }
        } catch (Exception e) {
            Assert.fail("Default allowed type is not coming as RBG/BUSINESS-TERM");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Default allowed type is not coming as RBG/BUSINESS-TERM");
        }
    }

    @Then("^\"([^\"]*)\" osgi bundle should be uploaded to bundle table$")
    public void osgi_bundle_should_be_uploaded_to_bundle_table(String bundleName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(bundleName);
            arrCriteriaValue.add(returnNodeValue("version"));
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "firstColName")).get(0), returnNodeValue("version"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Bundle Version is matching with database");
            for (String plugin : returnNodeValuesAsList("plugins")) {
                Assert.assertTrue(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                        "secColName")).get(0).contains(plugin));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Bundle Plugin Name is matching with database");

        } catch (Exception e) {
            Assert.fail("Table values doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table values is not matching with given params");
            db_postgres_util.disConnect();
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response of bundle types should match with the table in database$")
    public void response_of_bundle_types_should_match_with_the_table_in_database(DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        int index = 0;
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> criteriaValue = new ArrayList<>();
        List<String> pluginTypes = new ArrayList<>();
        try {
            String[] types = returnRestResponse().split(",");
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            pluginTypes = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            Collections.sort(pluginTypes);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Values from DB" + pluginTypes);
            if ((types.length) == pluginTypes.size()) {
                for (String type : pluginTypes) {
                    Assert.assertEquals(type.replaceAll("[^a-zA-Z0-9]", ""), types[index].replaceAll("[^a-zA-Z0-9]", ""));
                    index++;
                }
            }


        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } catch (AssertionError e) {
            Assert.fail("Response is not matched with Database: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^response of bundle \"([^\"]*)\" version should match with the table in database$")
    public void response_of_bundle_version_should_match_with_the_table_in_database(String bundleName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> bundleVersion = new ArrayList<>();
        List<String> versionListFromResponse = new ArrayList<>();
        try {
            arrCriteriaValue.add(bundleName);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            bundleVersion = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Collections.sort(bundleVersion);
            versionListFromResponse = returnNodeValuesAsList("version");
            Collections.sort(versionListFromResponse);
            for (String value : bundleVersion) {
                Assert.assertTrue(versionListFromResponse.contains(value));

            }
            // Assert.assertTrue(bundleVersion.equals(versionListFromResponse));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Bundle Version" + bundleVersion + " is matching with database");


        } catch (Exception e) {
            Assert.fail("Table values doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Bundle Version is not matching with database ");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response of version schemes should match with database$")
    public void response_of_version_schemes_should_match_with_database(DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> bundleVersion = new ArrayList<>();
        try {
            arrCriteriaValue.add("TestService");
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            bundleVersion = db_postgres_util.returnQueryList(query, getselectedColumnName);
            String response = returnRestResponse().replaceAll("[\r\n]+", " ").replaceAll("\\s+(?=([^\"]*\"[^\"]*\")*[^\"]*$)", "");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "API Response" + response);
            Assert.assertTrue(response.equals(bundleVersion.get(0)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Response" + bundleVersion.get(0));

        } catch (Exception e) {
            Assert.fail("Version schemes doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Version schemes doesn't match response");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response of schemes should match with \"([^\"]*)\"$")
    public void response_of_schemes_should_match_with(String filePath) throws Throwable {
        try {
            Assert.assertTrue(commonUtil.compareTwoJsonStrings(returnRestResponse(), jsonRead.readFile(REST_PAYLOAD + filePath)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response matches");

        } catch (Exception e) {
            Assert.fail("Response doesn't match");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response doesn't match ");
        }
    }

    @Then("all bundles \"([^\"]*)\" should match with database$")
    public void all_bundles_should_match_with_database(String bundleName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        List<String> versionListFromDB = new ArrayList<>();
        List<String> nameListFromDB = new ArrayList<>();
        List<String> versionListFromResponse = new ArrayList<>();
        List<String> nameListFromResponse = new ArrayList<>();
        try {
            arrCriteriaValue.add("TestService");
            arrCriteriaValue.add(bundleName);
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Results:" + columnValues);
            versionListFromDB = columnValues.get("version");
            nameListFromDB = columnValues.get("name");
            versionListFromResponse = returnNodeValuesAsList("version");
            nameListFromResponse = returnNodeValuesAsList("name");
            Collections.sort(versionListFromDB);
            Collections.sort(nameListFromDB);
            Collections.sort(versionListFromResponse);
            Collections.sort(nameListFromResponse);
            for (String value : versionListFromDB) {
                Assert.assertTrue(versionListFromResponse.contains(value));

            }
            for (String value : nameListFromDB) {
                Assert.assertTrue(nameListFromResponse.contains(returnSplitValueLeft(value, "-")));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Split" + returnSplitValueLeft(value, "-"));

            }
//            Assert.assertTrue(versionListFromDB.equals(versionListFromResponse));
//            Assert.assertTrue(nameListFromDB.equals(nameListFromResponse));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Bundle Version and Name is matching with database" + columnValues);

        } catch (Exception e) {
            Assert.fail("Bundles doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Bundles is not matching");
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^deleted bundle \"([^\"]*)\" of version \"([^\"]*)\" should not be present in database$")
    public void deleted_bundle_of_version_should_not_be_present_in_database(String bundleName, String bundleVersion, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        criteriaValue.add(bundleName);
        criteriaValue.add(bundleVersion);
        int rowCount = 0;
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount, 0);
        } catch (Exception e) {
            Assert.fail("Deleted bundle is present: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted bundle is present  in database:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^deleted bundle \"([^\"]*)\" should not be present in database$")
    public void deleted_bundle_should_not_be_present_in_database(String bundleName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        criteriaValue.add(bundleName);
        int rowCount = 0;
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount, 0);
        } catch (Exception e) {
            Assert.fail("Deleted bundles is present: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted bundles is present  in database:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^excel \"([^\"]*)\" status should be updated to \"([^\"]*)\"$")
    public void excelStatusShouldBeUpdatedTo(String FileName, String status) {
        try {
            String file = returnNodeValue("fileName");
            LoggerUtil.logLoader_info(this.getClass().getName(), returnNodeValue("fileName"));
            Assert.assertEquals(FileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name" + FileName + " is matching with fileName from Upload Data");
            Assert.assertEquals(status, returnNodeValue("status"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "status" + status + "is matching in the response");
        } catch (Exception e) {
            Assert.fail("File name and status is not matching");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File name and status is not matching");
        }
    }

    @And("^excel \"([^\"]*)\" message should be \"([^\"]*)\"$")
    public void excelMessageShouldBe(String FileName, String message) {
        try {
            Assert.assertEquals(FileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name" + FileName + " is matching with fileName from Upload Data");
            Assert.assertEquals(message, returnNodeValue("message"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "status" + message + "is matching in the response");
        } catch (Exception e) {
            Assert.fail("File name and message is not matching");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File name and message is not matching");
        }
    }

    @And("^excel \"([^\"]*)\" should be uploaded to uploadData table with sheetName \"([^\"]*)\"$")
    public void excelShouldBeUploadedToUploadDataTableWithSheetName(String fileName, String sheetName, DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(sheetName);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            Assert.assertEquals(fileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name is matching with uploaded file");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "firstColName")).get(0), returnNodeValue("hiveDatabaseName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "secColName")).get(0), returnNodeValue("hiveTableName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "clusterName")).get(0), returnNodeValue("clusterName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterName is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "hostName")).get(0), returnNodeValue("hostName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "hostName is matching with Given Queryparam");
        } catch (Exception e) {
            Assert.fail("Database and table name doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table/Database Name is not matching with given params");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^status \"([^\"]*)\" should return the UploadData \"([^\"]*)\"$")
    public void statusShouldReturnTheUploadData(String status, String uploadDataId, DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        try {
            arrCriteriaValue.add(status);
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryMap(Query);
            Assert.assertEquals(uploadDataId, returnNodeValuesAsList("id").get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Upload id is matching with response");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "firstColName")).get(0), returnNodeValuesAsList("hiveDatabaseName").get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "name")).get(0), returnNodeValuesAsList("fileName").get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "secColName")).get(0), returnNodeValuesAsList("hiveTableName").get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Table Name is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "clusterName")).get(0), returnNodeValuesAsList("clusterName").get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "clusterName is matching with Given Queryparam");
            Assert.assertEquals(columnValues.get(new DataSetHandler().getValue(dataTableCollection,
                    "hostName")).get(0), returnNodeValuesAsList("hostName").get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "hostName is matching with Given Queryparam");
        } catch (Exception e) {
            Assert.fail("Database and table name doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table/Database Name is not matching with given params");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^deleted file data should be from the excel \"([^\"]*)\"$")
    public void deletedFileDataShouldBeFromTheExcel(String fileName) throws Throwable {
        try {
            Assert.assertEquals(fileName, returnNodeValue("fileName"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "File Data from file" + fileName + "is deleted successfully");
        } catch (Exception e) {
            Assert.fail("File data from" + fileName + "is not deleted");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "File data from" + fileName + "is not deleted");
        }
    }

    @Given("^When query is ran to delete all quicklinks in \"([^\"]*)\" schema of \"([^\"]*)\" table for Test Data$")
    public void whenQueryIsRanToDeleteAllQuicklinksInSchemaOfTableForTestData(String schemaName, String tableName) {
        db_postgres_util = new DBPostgresUtil();
        try {
            db_postgres_util.executeQuery(db_postgres_util.deleteQuery(schemaName, tableName, "path",
                    "com/asg/dis/platform/quicklink_user.json/TestData"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Records Deleted Successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "No records executed " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response query definition for \"([^\"]*)\" should match with the table in database$")
    public void response_query_definition_for_should_match_with_the_table_in_database(String queryName, DataTable dataTableCollection) throws Throwable {

        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        try {
            String queryValue = "com/asg/dis/platform/query/com.asg.idc.Osgi1-" + queryName + ".json";
            arrCriteriaValue.add(queryValue);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "" + returnRestResponse());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Assert.assertTrue(queryDefinition.get(0).equals(returnRestResponse().replaceAll("[\r\n]+", " ").replaceAll("\\s+(?=([^\"]*\"[^\"]*\")*[^\"]*$)", "")));

        } catch (Exception e) {
            Assert.fail("Query Definition doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query Definition doesn't match response ");
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^response query definition for \"([^\"]*)\" updated should match with the table in database$")
    public void response_query_definition_for_updated_should_match_with_the_table_in_database(String queryName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        try {
            String queryValue = "com/asg/dis/platform/query/com.asg.idc.Osgi1-" + queryName + ".json";
            arrCriteriaValue.add(queryValue);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Assert.assertTrue(queryDefinition.get(0).contains("List query updated"));
            Assert.assertTrue(queryDefinition.get(0).equals(returnRestResponse().replaceAll("[\r\n]+", " ").replaceAll("\\s+(?=([^\"]*\"[^\"]*\")*[^\"]*$)", "")));

        } catch (Exception e) {
            Assert.fail("Query Definition doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query Definition doesn't match response ");
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^response should not contain deleted bundle type$")
    public void response_should_not_contain_deleted_bundle_type() throws Throwable {
        try {
            Assert.assertFalse(returnRestResponse().contains("TestPlugin"));
        } catch (Exception e) {
            Assert.fail("Deleted Bundle type displayed:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Deleted Bundle type displayed: " + e.getMessage());

        }
    }

    @Then("^user verifies that a JSON file is created for the diagram$")
    public void user_verifies_that_a_JSON_file_is_created_for_the_diagarm(DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            criteriaValue.add("com/asg/dis/platform/diagram/Custom_h.json");
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                if (list.contains("com/asg/dis/platform/diagram/Custom_h.json")) {


                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Diagram Configuration is found in DB");

                } else {
                    Assert.fail("ItemView not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Configuration is not found");

                }

            }
        } catch (Exception e) {
            Assert.fail("ItemView not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response query definition for \"([^\"]*)\" should match with the table in database for diagram$")
    public void response_query_definition_for_should_match_with_the_table_in_database_for_diagram(String queryName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        try {
            String queryValue = "com/asg/dis/platform/diagram/" + queryName + ".json";
            arrCriteriaValue.add(queryValue);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Assert.assertTrue(queryDefinition.get(0).equals(returnRestResponse().replaceAll("[\r\n]+", " ").replaceAll("\\s+(?=([^\"]*\"[^\"]*\")*[^\"]*$)", "")));

        } catch (Exception e) {
            Assert.fail("Query Definition doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query Definition doesn't match response ");
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^response query definition for \"([^\"]*)\" updated should match with the table in database for diagrams$")
    public void response_query_definition_for_updated_should_match_with_the_table_in_database_for_diagrams(String queryName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        try {
            String queryValue = "com/asg/dis/platform/diagram/" + queryName + ".json";
            arrCriteriaValue.add(queryValue);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Assert.assertFalse(queryDefinition.get(0).contains("color"));

        } catch (Exception e) {
            Assert.fail("Query Definition doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query Definition doesn't match response ");
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with dynamic id and Ratings for \"([^\"]*)\"$")
    public void userMakesARESTCallForPOSTRequestWithUrlWithDynamicIdAndRatingsFor(String path, String type, DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        rating = commonUtil.randomRating();
        String dynamicPath = null;
        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query : " + queryBuilder);
            id = commonUtil.random(db_postgres_util.getMinValueFromResultSet(queryBuilder), db_postgres_util.getMaxValueFromResultSet(queryBuilder));
            dynamicPath = commonUtil.returnSchema() + "." + type + ":::" + id + "/" + rating;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "path" + dynamicPath);
            invokePostRequest(path + dynamicPath);
            commonUtil.storeTemporaryText(String.valueOf(id));
            commonUtil.addElementsInList(String.valueOf(rating));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @When("^user makes a REST Call for POST request with url \"([^\"]*)\" with dynamic id and rating as \"([^\"]*)\" for \"([^\"]*)\"$")
    public void userMakesARESTCallForPOSTRequestWithUrlWithDynamicIdAndRatingAsFor(String path, String rating, String type, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        String dynamicPath = null;
        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated Dynamic Query : " + queryBuilder);
            id = commonUtil.randomint(db_postgres_util.getMinValueFromResultSet(queryBuilder), db_postgres_util.getMaxValueFromResultSet(queryBuilder));
            dynamicPath = commonUtil.returnSchema() + "." + type + ":::" + id + "/" + rating;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "path" + dynamicPath);
            invokePostRequest(path + dynamicPath);
            commonUtil.storeTemporaryText(String.valueOf(id));
            commonUtil.addElementsInList(String.valueOf(rating));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^created diagram theme should be present in database$")
    public void created_diagram_theme_should_be_present_in_database(DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        try {
            criteriaValue.add("com/asg/dis/platform/theme/Sample Theme.json");
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                if (list.contains("com/asg/dis/platform/theme/Sample Theme.json")) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Diagram Theme is found in DB");
                } else {

                    Assert.fail("Theme not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Diagram Theme is not found");
                }
            }
        } catch (Exception e) {
            Assert.fail("Diagram Theme not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response diagram theme for \"([^\"]*)\" should match with database$")
    public void response_diagram_theme_for_should_match_with_database(String themeName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        try {
            String themePath = "com/asg/dis/platform/theme/" + themeName + ".json";
            arrCriteriaValue.add(themePath);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Assert.assertTrue(queryDefinition.get(0).equals(returnRestResponse().replaceAll("[\r\n]+", " ").replaceAll("\\s+(?=([^\"]*\"[^\"]*\")*[^\"]*$)", "")));

        } catch (Exception e) {
            Assert.fail("Themes doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Themes doesn't match response ");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response diagram theme updated for \"([^\"]*)\" should match with database$")
    public void response_diagram_theme_updated_for_should_match_with_database(String themeName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        try {
            String themePath = "com/asg/dis/platform/theme/" + themeName + ".json";
            arrCriteriaValue.add(themePath);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Response " + queryDefinition.get(0));
            Assert.assertFalse(queryDefinition.get(0).contains("tooltip"));
        } catch (Exception e) {
            Assert.fail("Themes doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Themes doesn't match response ");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^verify theme \"([^\"]*)\" not present in database$")
    public void verify_theme_not_present_in_database(String themeName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int rowCount = 0;
        try {
            String queryValue = "com/asg/dis/platform/theme/" + themeName + ".json";
            criteriaValue.add(queryValue);
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount, 0);
        } catch (Exception e) {
            Assert.fail("Deleted theme is present: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted theme is present in database:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^response should match with database for \"([^\"]*)\"$")
    public void response_should_match_with_database_for(String diagramName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> responseValue = new ArrayList<>();
        List<String> dbValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        try {
            responseValue = returnNodeValuesAsList("name");
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            dbValue = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response" + responseValue);
            for (String value : responseValue) {
                Assert.assertTrue(dbValue.contains("com/asg/dis/platform/" + diagramName + "/" + value + ".json"));
            }
        } catch (Exception e) {
            Assert.fail("Diagram is not present: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Diagram is not present in database:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Then("^user verifies record is created in db with \"([^\"]*)\"$")
    public void user_verifies_record_is_created_in_db_with(String pathValue, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        int rowCount = 0;
        try {
            criteriaValue.add(pathValue);
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(Query);
            Assert.assertEquals(rowCount, 1);

        } catch (Exception e) {
            Assert.fail("ItemView not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding$")
    public void to_configure_multiple_headers_and_Authorization_dynamically_for_Rest_Endpoint_with_false_encoding(Map<String, String> multiHeaders) throws Throwable {
        request = request.headers(multiHeaders).urlEncodingEnabled(false);
    }


    @Given("^endpoint having \"([^\"]*)\" and query param with \"([^\"]*)\" \"([^\"]*)\" for request type \"([^\"]*)\" with url \"([^\"]*)\" and body \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\"$")
    public void endpoint_having_and_query_param_with_for_request_type_with_url_and_body_and_verify_and(String Header, String Query, String param, String type, String url, String file, int responseCode, String responseMessage) throws Throwable {

        String credentials = propLoader.prop.getProperty("TestSystemUser");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        if (Header.equalsIgnoreCase("text/plain")) {
            multiHeader(credentials, Header, "text/plain");
        } else if (Header.equals("xml/json")) {
            multiHeader(credentials, "application/xml", "application/json");
        } else if (Header.equals("xml/xml")) {
            multiHeader(credentials, "application/xml", "application/xml");
        } else if (Header.equals("text/json")) {
            multiHeader(credentials, "text/plain", "application/json");
        } else if (Header.equals("policy")) {
            setAcceptFormat(credentials, "application/vnd.asg-services-policy.v1+json");
        } else {
            multiHeader(credentials, Header, "application/json");
        }

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
        setpathQueryParm(Query, param);
        if (url.contains("hostName")) {
            url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
        }
        try {
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    break;
                case "RecursiveGet":
                    invokeGetRequestRecursive(url, responseMessage, "40");
                    break;
                case "Put":
                    if (file != null && !file.isEmpty()) {
                        setBody(file);
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBody(file);
                            invokePostRequest(url);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }

            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                response_message_contains_value(responsemsg);
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }
    }

    @Given("^user comparelineage diagram for each SourceTree information generated$")
    public void user_comparelineage_diagram_for_each_SourceTree_information_generated(DataTable parameters) throws Throwable {

        try {
            for (Map<String, String> data : parameters.asMaps(String.class, String.class)) {
                //get values from feature file
                String header = data.get("Header");
                String query = data.get("Query");
                String param = data.get("Param");
                String type = data.get("type");
                String url = data.get("url");
                String catalogName = data.get("catalogName");
                String jsonPath_sourceTreename = data.get("jsonPath_sourceTreename");
                String lineageFrom = data.get("Lineagefromid");
                String lineageTo = data.get("LineageToid");
                String call = data.get("call");
                String[] functionid_s = null;
                String functionid = data.get("Functionid_xpath");
                String lineageid = data.get("Lineageid_xpath");
                String functionname = data.get("functionname");
                String lineagename = data.get("lineagename");
                String classname = data.get("Classname");
                String classid = data.get("Classid");
                String credentials = propLoader.prop.getProperty("TestSystemUser");
                int expectedResponseCode = Integer.parseInt(data.get("response code"));
                String[] Filename = data.get("File Name").split(",");
                String FileCount = data.get("FileCount");

                // string initialised for storing values
                String[] funName = null;
                String storeJsonValue = null;
                String HopID = null;
                String[] lineages = null;
                String LineageFromid;
                String LineageToid;
                String Functionid;
                String Classname = null;
                String Classid;
                String FunctionName;
                String Fid = null;
                // List and maps to store the values in a key values pair
                List<String> sourceTree = new ArrayList<>();
                List<String> functionName = new ArrayList<>();
                String functionID = null;
                Map<String, String> FileToFunc = new HashMap<String, String>();
                Map<String, String> FileToclassid = new HashMap<String, String>();
                Map<String, String> FunToHop = new HashMap<String, String>();
                Map<String, String> FunToHopname = new HashMap<String, String>();
                Map<String, String> LineageFrom_To = new HashMap<String, String>();
                Map<String, String> classNametoFunctionID = new HashMap<String, String>();
                List<String> ClassNames = new ArrayList<>();
                List<String> ClassID = new ArrayList<>();
                //header
                if (header.isEmpty()) {
                    LoggerUtil.logLoader_info("", "Header is already available");
                } else {
                    multiHeader(credentials, header, "application/json");
                }
                // iterate with file name from feature file

                for (int m = 0; m < Filename.length; m++) {

                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
                    setpathQueryParm(query, param);
                    if (url.contains("hostName")) {
                        url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
                    }
                    // switch as per the request
                    switch (type) {
                        case "Get":
                            //invoke the rest API with URL, with catalog , call name, Filename field from featue file from
                            for (int i = 1; i <= Integer.parseInt(FileCount); i++) {
                                try {

                                    invokeGetRequest(url + catalogName + "." + call + "%3A%3A%3A" + i);
                                    status_code_must_be_returned(expectedResponseCode);
                                } catch (Exception e) {
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                    Assert.fail(e.getMessage() + "SourceTree ID" + catalogName + "." + call + "%3A%3A%3A" + i + "throws an error");
                                }
                                //verify the sourceTree name from JSON with filename from feature file
                                if (getJsonValueUsingJsonPath(jsonPath_sourceTreename).equals(Filename[m])) {
                                    try {
                                        //assert the sourceTree name from JSON with filename from feature file
                                        Assert.assertEquals(getJsonValueUsingJsonPath(jsonPath_sourceTreename), Filename[m]);
                                    } catch (Exception e) {
                                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                        Assert.fail(e.getMessage() + "SourceTreeName didn't matched with FileName provided from feature file: SourceTreeName from JSON=>" + getJsonValueUsingJsonPath(jsonPath_sourceTreename) + "and Filenamefrom Cucumber=>" + Filename[m] + "");
                                    }
                                    //store the value of sourceTree name in String
                                    storeJsonValue = getJsonValueUsingJsonPath(jsonPath_sourceTreename);
                                    //store te value of function name from JSON with the jsonxpath from feature file
                                    FunctionName = getJsonValueUsingJsonPath(functionname);
                                    //split the funtionName as single source file can contains multiple functions
                                    funName = FunctionName.split(",");
                                    //get the value of class names in string
                                    Classname = getJsonValueUsingJsonPath(classname);
                                    //get the values of class id in string
                                    Classid = getJsonValueUsingJsonPath(classid);
                                    // store the classid in list
                                    ClassID.add(Classid);
                                    //store the classid in list from cucumber dataset
                                    new CucumberDataSet().setClassid(ClassID);
                                    // store the value of class id to source names
                                    FileToclassid.put(storeJsonValue, Classid);
                                    //store the class ID's with respect to sourceTreename
                                    new CucumberDataSet().setFilenameToclassid(FileToclassid);

                                    if (getJsonValueUsingJsonPath(classid).contains(catalogName + ".Class")) {
                                        try {
                                            //invoke the url for class
                                            invokeGetRequest(url + Classid);
                                            status_code_must_be_returned(expectedResponseCode);
                                        } catch (Exception e) {
                                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                            Assert.fail(e.getMessage() + "Classid URL is invalid, the invalid classID is=>" + Classid + "");
                                        }

                                        //loop to store the value of function name with respect to sourceTree name and store it ina seperate list
                                        Functionid = getJsonValueUsingJsonPath(functionid);
                                        //store the functioid in a string
                                        functionid_s = Functionid.split(",");

                                        //if the json xpath response contains function enter this conditions
                                        if (getJsonValueUsingJsonPath(functionid).contains(catalogName + ".Function")) {
                                            //loop to store the value of function name with respect to sourceTree name and store it ina seperate list
                                            for (int k = 0; k < functionid_s.length; k++) {
                                                try {
                                                    //invoke the url for functions
                                                    invokeGetRequest(url + functionid_s[k]);
                                                    status_code_must_be_returned(expectedResponseCode);
                                                } catch (Exception e) {
                                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                    Assert.fail(e.getMessage() + "FunctionID URL is invalid, the invalid FunctionID is=>" + functionid_s[k] + "");
                                                }
                                                //store the functioname in a string
                                                String Fname = funName[k];
                                                //add the function name to list and stor it to setter function from cucumber dataset
                                                functionName.add(Fname);
                                                new CucumberDataSet().setFunctionName(functionName);
                                                //add the ClassName to FuncitonID
                                                classNametoFunctionID.put(Classname, Functionid);
                                                //verification point to check if response has Lineage HOP
                                                if (getJsonValueUsingJsonPath(lineageid).contains("LineageHop")) {
                                                    //store the lineage id from response
                                                    String lineageid_s = getJsonValueUsingJsonPath(lineageid);
                                                    //store the lineage names from response
                                                    String LineageName = getJsonValueUsingJsonPath(lineagename);
                                                    //store lineage names with respect to function ID
                                                    FunToHopname.put(functionid_s[k], LineageName);
                                                    new CucumberDataSet().setfunctionidToLineageHopName(FunToHopname);
                                                    //store lineage id with respect to function ID
                                                    FunToHop.put(functionid_s[k], lineageid_s);
                                                    new CucumberDataSet().setFunctionidToLineageHopID(FunToHop);
                                                    //split the lineage ID's to create a loop which helps to trigger the url for each ID and store the lineaeFrom and LineageTo with respective HOP ID's
                                                    lineages = lineageid_s.split(",");
                                                    try {
                                                        for (int a = 0; a < lineages.length; a++) {
                                                            try {
                                                                //invoke the HOP ID url
                                                                invokeGetRequest(url + lineages[a]);
                                                                status_code_must_be_returned(expectedResponseCode);
                                                            } catch (Exception e) {
                                                                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                                Assert.fail(e.getMessage() + "LineageID URL is invalid, the invalid LineageID is=>" + lineages[a] + "");
                                                            }
                                                            //store the lineageFrom ID to a string
                                                            LineageFromid = (getJsonValueUsingJsonPath(lineageFrom));
                                                            //Store the LineageTO ID to a string
                                                            LineageToid = (getJsonValueUsingJsonPath(lineageTo));
                                                            //store seperate LineageHOP ID to string , which is used as a key value to store the FROM and TO value
                                                            HopID = lineages[a];
                                                            //store the LineageFrom to the respective HOP ID
                                                            LineageFrom_To.put(HopID + "_From", LineageFromid);
                                                            //store the LineageTO to the respective HOP ID
                                                            LineageFrom_To.put(HopID + "_To", LineageToid);
                                                            new CucumberDataSet().setLineageHopIDToLineageFrom_To(LineageFrom_To);
                                                        }
                                                    } catch (Exception e) {
                                                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                        Assert.fail(e.getMessage());
                                                    }
                                                }
                                            }
                                            //Add values to the setMethod in cucumber data set
                                            new CucumberDataSet().setClassNameToFunctionID(classNametoFunctionID);
                                        }
                                        break;
                                    } else {

                                        //loop to store the value of function name with respect to sourceTree name and store it ina seperate list
                                        Functionid = getJsonValueUsingJsonPath(functionid);
                                        //store the functioid in a string
                                        functionid_s = Functionid.split(",");
                                        //if the json xpath response contains function enter this conditions
                                        if (getJsonValueUsingJsonPath(functionid).contains(catalogName + ".Function")) {
                                            //loop to store the value of function name with respect to sourceTree name and store it ina seperate list
                                            for (int k = 0; k < functionid_s.length; k++) {
                                                try {
                                                    invokeGetRequest(url + functionid_s[k]);
                                                    status_code_must_be_returned(expectedResponseCode);
                                                } catch (Exception e) {
                                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                    Assert.fail(e.getMessage() + "FunctionID URL is invalid, the invalid FunctionID is=>" + functionid_s[k] + "");
                                                }
                                                //store the functioname in a string
                                                String Fname = funName[k];
                                                //add the function name to list and store it to set the function from cucumber dataset
                                                functionName.add(Fname);
                                                new CucumberDataSet().setFunctionName(functionName);
//                                                //store the functionid in a string
                                                Fid = getJsonValueUsingJsonPath(functionid);

                                                //verification point to check if response has Lineage HOP
                                                if (getJsonValueUsingJsonPath(lineageid).contains("LineageHop")) {
                                                    //store the lineage id from response
                                                    String lineageid_s = getJsonValueUsingJsonPath(lineageid);
                                                    //store the lineage names from response
                                                    String LineageName = getJsonValueUsingJsonPath(lineagename);
                                                    //store lineage names with respect to function ID
                                                    FunToHopname.put(functionid_s[k], LineageName);
                                                    new CucumberDataSet().setfunctionidToLineageHopName(FunToHopname);
                                                    //store lineage id with respect to function ID
                                                    FunToHop.put(functionid_s[k], lineageid_s);
                                                    new CucumberDataSet().setFunctionidToLineageHopID(FunToHop);
                                                    //split the lineage ID's to create a loop which helps to trigger the url for each ID and store the lineaeFrom and LineageTo with respective HOP ID's
                                                    lineages = lineageid_s.split(",");
                                                    try {
                                                        for (int a = 0; a < lineages.length; a++) {
                                                            try {
                                                                //invoke the HOP ID url
                                                                invokeGetRequest(url + lineages[a]);
                                                                status_code_must_be_returned(expectedResponseCode);
                                                            } catch (Exception e) {
                                                                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                                Assert.fail(e.getMessage() + "LineageID URL is invalid, the invalid LineageID is=>" + lineages[a] + "");
                                                            }
                                                            //store the lineageFrom ID to a string
                                                            LineageFromid = (getJsonValueUsingJsonPath(lineageFrom));
                                                            //Store the LineageTO ID to a string
                                                            LineageToid = (getJsonValueUsingJsonPath(lineageTo));
                                                            //store seperate LineageHOP ID to string , which is used as a key value to store the FROM and TO value
                                                            HopID = lineages[a];
                                                            //store the LineageFrom to the respective HOP ID
                                                            LineageFrom_To.put(HopID + "_From", LineageFromid);
                                                            //store the LineageTO to the respective HOP ID
                                                            LineageFrom_To.put(HopID + "_To", LineageToid);
                                                            new CucumberDataSet().setLineageHopIDToLineageFrom_To(LineageFrom_To);
                                                        }
                                                    } catch (Exception e) {
                                                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
                                                        Assert.fail(e.getMessage());
                                                    }
                                                }
                                                //store value of functionID to Filename and send it to seeter function from cucumber dataset
                                                FileToFunc.put(storeJsonValue, Functionid);
                                            }
                                            //store the file to fucntion ID to setter method
                                            new CucumberDataSet().setFnid(FileToFunc);
                                            break;
                                        }
                                    }
                                }
                                status_code_must_be_returned(expectedResponseCode);
                            }

                    }
                    // store the classnames in list
                    ClassNames.add(Classname);
                    //store the classnames in list from cucumber dataset
                    new CucumberDataSet().setClassname(ClassNames);
                    // store the  in list
                    sourceTree.add(storeJsonValue);
                    new CucumberDataSet().setSourcetreeName(sourceTree);
                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^Execute REST API with following parameters$")
    public void execute_REST_API_with_following_parameters(DataTable parameters) throws Throwable {
        try {
            int expectedResponseCode = 0;
            for (Map<String, String> data : parameters.asMaps(String.class, String.class)) {
                String header = data.get("Header");
                String query = data.get("Query");
                String param = data.get("Param");
                String type = data.get("type");
                String url = data.get("url");
                String file = data.get("body");
                String endpointType = data.get("endpointType");
                String itemName = data.get("itemName");
                String jsonPath = data.get("jsonPath");
                if (!data.get("response code").isEmpty()) {
                    expectedResponseCode = Integer.parseInt(data.get("response code"));
                }
                String expectedResponseMessage = data.get("response message");
                resetRestAPI();
                String credentials = propLoader.prop.getProperty("TestSystemUser");
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
                if (header.isEmpty()) {
                    LoggerUtil.logLoader_info("", "Header is already available");
                } else {
                    multiHeader(credentials, header, "application/json");
                }

                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
                setpathQueryParm(query, param);
                if (url.contains("hostName")) {
                    url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
                }
                switch (type) {
                    case "Get":
                        invokeGetRequest(url);
                        break;
                    case "RecursiveGet":
                        if (data.containsKey("jsonPath")) {
                            for (int i = 1; i < 300; i++) {
                                invokeGetRequestRecursive(url, expectedResponseMessage, String.valueOf(i));
                                if (getJsonValueUsingJsonPath(jsonPath).equals(expectedResponseMessage)) {
                                    Assert.assertEquals(getJsonValueUsingJsonPath(jsonPath), expectedResponseMessage);
                                    break;
                                }
                            }
                        } else {
                            invokeGetRequestRecursive(url, expectedResponseMessage, "50");
                        }
                        break;
                    case "Put":
                        if (file != null && !file.isEmpty()) {
                            setBody(file);
                            invokePutRequest(url);

                        } else
                            invokePutRequest(url);
                        break;
                    case "Post":
                        if (file != null && !file.isEmpty()) {
                            if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                                setBody(file);
                                invokePostRequest(url);
                            } else {
                                setMultiPart(FEATURES + file);
                                invokePostRequest(url);
                            }

                        } else
                            invokePostRequest(url);
                        break;
                    case "Delete":
                        invokeDeleteRequest(url);
                        break;

                    case "DeleteAndCreate":
                        switch (endpointType) {
                            case "catalog":
                                invokeGetRequest(url);
                                if (returnRestResponse().contains(itemName)) {
                                    String deleteUrl = url + "/" + itemName.replaceAll("\\s", "%20");
                                    invokeDeleteRequest(deleteUrl);
                                }
                                if (file != null && !file.isEmpty()) {
                                    if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                                        setBody(file);
                                        invokePostRequest("settings/catalogs");
                                    } else {
                                        setMultiPart(FEATURES + file);
                                        invokePostRequest("settings/catalogs");
                                    }
                                }
                                break;
                        }


                }

                if (data.get("response code").isEmpty()) {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Status code is not verified");
                } else {
                    status_code_must_be_returned(expectedResponseCode);
                }
                if (!jsonPath.isEmpty()) {
                    Assert.assertEquals(getJsonValueUsingJsonPath(jsonPath), expectedResponseMessage);
                } else {
                    String[] responses = expectedResponseMessage.split(",");
                    for (String responsemsg : responses) {
                        response_message_contains_value(responsemsg);
                    }
                }
            }
        } catch (Exception e) {
            Assert.fail("Error while executing API endpoints" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }
    }

    @Given("^user reset the REST API Service$")
    public void user_reset_the_REST_API_Service() throws Throwable {
        try {
            resetRestAPI();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Rest APi reset is done");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());
        }
    }

    @Then("^value for \"([^\"]*)\" should be updated for both item in solr$")
    public void value_for_should_be_updated_for_both_item_in_solr(String fieldName, DataTable table) throws Throwable {
        List<String> solrList = new ArrayList<>();
        List<String> fieldList = new ArrayList<>();
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            List<String> filterQuery = Arrays.asList(solr_dataTable.get(0).getFilterQuery().split(","));
            solrList = solr.solrGetFieldValue(solr_dataTable.get(0).getQueryName(), filterQuery, "", "/select", fieldName);
            Assert.assertTrue(removeSpecialChar(solrList.get(0)).contains("TestValue"));
            List<String> filter = Arrays.asList(solr_dataTable.get(1).getFilterQuery().split(","));
            fieldList = solr.solrGetFieldValue(solr_dataTable.get(1).getQueryName(), filter, "", "/select", fieldName);
            Assert.assertTrue(removeSpecialChar(fieldList.get(0)).contains(commonUtil.getTemporaryText()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description for both items is updated in solr");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^register for \"([^\"]*)\" catalog should not be displayed$")
    public void register_for_catalog_should_not_be_displayed(String catalogName, DataTable dataTableCollection) throws Throwable {
        List<String> criteriaValue = new ArrayList<>();
        List<String> schemeValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();

        try {

            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            schemeValue = db_postgres_util.returnQueryList(Query, "schema");
            Assert.assertFalse(schemeValue.contains(catalogName));

        } catch (Exception e) {
            Assert.fail("Register for " + catalogName + "is found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^response message should contain \"([^\"]*)\" for the path \"([^\"]*)\"$")
    public void responseMessageShouldContainForThePath(String value, String path) throws Throwable {
        try {
            Assert.assertEquals(returnJsonValue(path), "true");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Autostart flag validated successfully");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Value does not match");
        }
    }

    @Given("^The name of the cluster in Postgres should be \"([^\"]*)\"$")
    public void theNameOfTheClusterInPostgresShouldBe(String queryName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int count = 0;
        try {
            criteriaValue.add(queryName);
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            CommonUtil.addToTemporaryHashMap(queryName, resultList.get(0));
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user tries to derive the relation of \"([^\"]*)\" from \"([^\"]*)\"$")
    public void userTriesToDeriveTheRelationOfFrom(String arg0, String arg1, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        List<String> tempList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        try {
            if (arg0.equalsIgnoreCase("Files")) {
                criteriaValue.add(CommonUtil.getValueFromTempHashMap(arg1));
                String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                CommonUtil.addToTemporaryHashMap(arg0, resultList);
            } else if (arg0.equalsIgnoreCase("Fields")) {
                criteriaValue.add(CommonUtil.getValueFromTempHashMap(arg1));
                String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                CommonUtil.addToTemporaryHashMap(arg0, resultList);
            } else {
                if (arg1.equalsIgnoreCase("query")) {
                    criteriaValue.add(CommonUtil.getValueFromTempHashMap(CommonUtil.getElementsInList().get(0)));
                } else {
                    criteriaValue.add(CommonUtil.getValueFromTempHashMap(arg1));
                }
                String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                if (resultList.size() <= 1) {
                    if (arg1.equalsIgnoreCase("Query")) {
                        commonUtil.tempElementList.clear();
                        commonUtil.tempElementList = resultList;
                    } else {
                        CommonUtil.addToTemporaryHashMap(arg0, resultList.get(0));
                    }

                } else {
                    commonUtil.tempElementList.clear();
                    commonUtil.tempElementList = resultList;
                }
            }
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user tries to validate whether \"([^\"]*)\" exists in \"([^\"]*)\"$")
    public void userTriesToValidateWhetherExistsIn(String arg0, String arg1, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        List<String> resultList = new ArrayList<>();
        List<String> tempList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        String tableName = null;
        String databaseID = null;
        try {
            if (arg1.equalsIgnoreCase("Files")) {
                tempList = CommonUtil.getValueListFromTempHashMap(arg1);
                for (String s : tempList) {
                    criteriaValue.clear();
                    criteriaValue.add(s);
                    String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                    columnValues = db_postgres_util.returnQueryMap(queryBuilder);
                    CommonUtil.addToTemporaryHashMap(columnValues.get("name").get(0), columnValues.get("ID").get(0));
                }
                Assert.assertTrue(CommonUtil.getTempHashMap().containsKey(arg0));
            } else {
                for (String value : commonUtil.tempElementList) {
                    criteriaValue.add(value);
                    String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                    resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                    if (arg0.equalsIgnoreCase(resultList.get(0))) {
                        tableName = resultList.get(0);
                        databaseID = value;
                        break;
                    }
                    criteriaValue.clear();
                }
                Assert.assertEquals(arg0, tableName);
                CommonUtil.addToTemporaryHashMap(arg0, databaseID);
            }
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^the database \"([^\"]*)\" should be present in \"([^\"]*)\" dbSystem$")
    public void theDatabaseShouldBePresentInDbSystem(String arg0, String arg1, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        String tableName = null;
        String databaseID = null;
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        try {
            for (String value : commonUtil.tempElementList) {
                criteriaValue.add(value);
                String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                if (arg0.equalsIgnoreCase(resultList.get(0))) {
                    tableName = resultList.get(0);
                    databaseID = value;
                    break;
                }
                criteriaValue.clear();
            }
            Assert.assertEquals(arg0, tableName);
            CommonUtil.addToTemporaryHashMap(arg0, databaseID);
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @When("^the user validates the Query\"([^\"]*)\" in the V_Operations table$")
    public void theUserValidatesTheQueryInTheV_OperationsTable(String query, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        Map<String, List<String>> columnValues = new HashMap<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        try {
            criteriaValue.add(new JsonRead().readJSon("QueriesValidation", "QueryLog_Q" + query));
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            String finalQuery = queryBuilder.replace("=", " like ");
            queryBuilder = finalQuery.substring(0, finalQuery.length() - 1) + "%'";
            columnValues = db_postgres_util.returnQueryMap(queryBuilder);
            String value = columnValues.get(new DataSetHandler().getValue(dataTableCollection, "firstColName")).get(0);
            String key = columnValues.get(new DataSetHandler().getValue(dataTableCollection, "secColName")).get(0);
            CommonUtil.addToTemporaryHashMap(key, value);
            CommonUtil.addElementsInList(key);
            Assert.assertEquals(new JsonRead().readJSon("Queries", "QueryLog_Q" + query), key);
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user validates the list of \"([^\"]*)\" available in the database in postgres$")
    public void userValidatesTheListOfAvailableInTheDatabaseInPostgres(String tableName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        List<String> columnsNames = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> fieldNames = new ArrayList<>();
        try {
            if (tableName.startsWith("_c")) {
                System.out.println(commonUtil.tempElementList);
                for (String value : commonUtil.getValueListFromTempHashMap("Fields")) {
                    criteriaValue.add(value);
                    String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                    resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                    columnsNames.add(resultList.get(0));
                    CommonUtil.addToTemporaryHashMap(resultList.get(0), value);
                    criteriaValue.clear();
                }

                if (tableName.length() > 3) {
                    for (String ch : tableName.split(",")) {
                        fieldNames.add(ch);
                    }
                } else {
                    fieldNames.add(tableName);
                }
                Assert.assertTrue(CommonUtil.compareLists(columnsNames, fieldNames));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), columnsNames + "matched with " + fieldNames);
            } else {
                for (String value : commonUtil.tempElementList) {
                    criteriaValue.add(value);
                    String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                    resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                    columnsNames.add(resultList.get(0));
                    CommonUtil.addToTemporaryHashMap(resultList.get(0), value);
                    criteriaValue.clear();
                }
                commonUtil.tempElementList.clear();
                CommonUtil.tempElementList = columnsNames;
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), columnsNames + "matched with " + fieldNames);
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user validates the list of \"([^\"]*)\" are available under Has_Execution in IDC UI$")
    public void userValidatesTheListOfAreAvailableUnderHas_ExecutionInIDCUI(String arg0, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        List<String> columnsNames = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        try {
            for (String value : commonUtil.tempElementList) {
                criteriaValue.add(value);
                String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
                resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
                columnsNames.add(resultList.get(0));
                criteriaValue.clear();
            }
            CommonUtil.tempElementList.clear();
            CommonUtil.tempElementList = columnsNames;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), columnsNames + "Added to list");
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^row count \"([^\"]*)\" should be displayed in database$")
    public void row_count_should_be_displayed_in_database(String rowNum, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int rowCount = 0;
        try {
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount, Integer.parseInt(rowNum));
        } catch (Exception e) {
            Assert.fail("Row count is not matching with Database: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Row count is not matching with Database: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^value for \"([^\"]*)\" should be updated for both items in solr$")
    public void value_for_should_be_updated_for_both_items_in_solr(String fieldName, DataTable table) throws Throwable {
        List<String> solrList = new ArrayList<>();
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            for (int i = 0; i < solr_dataTable.size() - 1; i++) {
                List<String> filter = Arrays.asList(solr_dataTable.get(i).getFilterQuery().split(","));
                solrList = solr.solrGetFieldValue(solr_dataTable.get(i).getQueryName(), filter, "", "/select", fieldName);
                Assert.assertTrue(removeSpecialChar(solrList.get(i)).contains("TestValue"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description for both items is updated in solr");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Then("^value for \"([^\"]*)\" should not be updated for both items in solr$")
    public void value_for_should_not_be_updated_for_both_items_in_solr(String fieldName, DataTable table) throws Throwable {
        List<String> solrList = new ArrayList<>();
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            for (int i = 0; i < solr_dataTable.size() - 1; i++) {
                List<String> filter = Arrays.asList(solr_dataTable.get(i).getFilterQuery().split(","));
                solrList = solr.solrGetFieldValue(solr_dataTable.get(i).getQueryName(), filter, "", "/select", fieldName);
                Assert.assertFalse(removeSpecialChar(solrList.get(i)).contains("TestValue"));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Description for items is not updated in solr");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @When("^user validates whether the \"([^\"]*)\" spark Jobs are completed initiated Bigdata Analyzer$")
    public void userValidatesWhetherTheSparkJobsAreCompletedInitiatedBigdataAnalyzer(String catalogerType) throws Throwable {
        try {
            List<String> applicationId = new ArrayList<>();
            List<String> status = new ArrayList<>();
            List<String> listOfApplicationType = new ArrayList<>();
            List<String> listOfId = new ArrayList<>();
            List<String> listOfState = new ArrayList<>();
            String filepath = null;
            String xml = null;
            JSONObject json;
            Boolean flag = true;
            do {
                Thread.sleep(3000);
                invokeGetRequest(propLoader.prop.getProperty("hadoopCluster"));
                json = new JSONObject(returnRestResponse());
                xml = XML.toString(json);
                fileUtil.createFileAndWriteData(DOWNLOAD_FILE_PATH + "RunningJobs.xml", xml);
                filepath = DOWNLOAD_FILE_PATH + "RunningJobs.xml";
                listOfApplicationType = xmlReader.readAttributesFromXmlTagName(filepath, "applicationType");
                listOfId = xmlReader.readAttributesFromXmlTagName(filepath, "id");
                listOfState = xmlReader.readAttributesFromXmlTagName(filepath, "state");
                for (int i = 0; i < listOfApplicationType.size(); i++) {
                    if ((listOfApplicationType.get(i).contains(catalogerType)) && (!listOfState.get(i).equalsIgnoreCase("FINISHED"))) {
                        applicationId.add(listOfId.get(i));
                        flag = false;
                    }
                }
            } while (applicationId.size() >= 1 && flag);
            for (String appId : applicationId) {
                int maxTimeOut = 1;
                while (applicationId.size() != 0 && maxTimeOut <= 100) {
                    invokeGetRequest(propLoader.prop.getProperty("hadoopCluster") + appId);
                    json = new JSONObject(returnRestResponse());
                    xml = XML.toString(json);
                    fileUtil.createFileAndWriteData(DOWNLOAD_FILE_PATH + "Individual.xml", xml);
                    filepath = DOWNLOAD_FILE_PATH + "Individual.xml";
                    status = xmlReader.readAttributesFromXmlTagName(filepath, "finalStatus");
                    if ((status.get(0).equalsIgnoreCase("SUCCEEDED"))) {
                        break;
                    } else {
                        Thread.sleep(3000);
                        maxTimeOut++;
                    }
                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @Given("^The values for the below query in Postgres should be \"([^\"]*)\"$")
    public void the_values_for_the_below_query_in_Postgres_should_be(String arg1, DataTable arg2) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int count = 0;
        try {
            criteriaValue.add(arg1);
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(arg2, criteriaValue);
            resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            CommonUtil.addToTemporaryHashMap(arg1, resultList.get(0));
            CommonUtil.getValueFromTempHashMap(arg1);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Executed the query" + queryBuilder);
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @Given("^configure dynamic endpoint for \"([^\"]*)\" having multiple header \"([^\"]*)\" \"([^\"]*)\" for request type \"([^\"]*)\" with url \"([^\"]*)\" and body \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\"$")
    public void configure_dynamic_endpoint_for_having_multiple_header_for_request_type_with_url_and_body_and_verify_and(String serviceName, String authorization, String requestedBy, String type, String url, String file, int responseCode, String responseMessage) throws Throwable {
        Map<String, String> multiheaders = new HashMap<String, String>();
        try {
            initializeRestAPI(serviceName);
            multiheaders.put("Authorization", authorization);
            multiheaders.put("X-Requested-By", requestedBy);
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    break;
                case "RecursiveGet":
                    invokeGetRequestRecursive(url, responseMessage, "60");
                    break;
                case "Put":
                    if (file != null && !file.isEmpty()) {
                        setBody(file);
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBody(file);
                            invokePostRequest(url);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }

            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                response_message_contains_value(responsemsg);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Invoked dynamic end point");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }

    }


    @Then("^Plugin Configuration from payload \"([^\"]*)\" and REST API response should match$")
    public void plugin_Configuration_from_payload_and_REST_API_response_should_match(String arg1) throws Throwable {
        try {
            Assert.assertTrue(commonUtil.compareTwoJsonStrings(jsonRead.readFile(REST_PAYLOAD + arg1), commonUtil.getTemporaryText()));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Python parser log is as expected");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^verify DataSet is created with name \"([^\"]*)\", Description \"([^\"]*)\" and status as \"([^\"]*)\"$")
    public void verifyDataSetIsCreatedWithNameDescriptionAndStatusAs(String dataSetName, String dataSetDesc,
                                                                     String dataSetStatus) {
        try {
            Assert.assertEquals(dataSetName, returnNodeValue("name"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet name : " + dataSetName + " is " +
                    "matching as expected");
            Assert.assertEquals(dataSetDesc, returnNodeValue("description"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet description : " + dataSetDesc + " is " +
                    "matching as expected");
            Assert.assertEquals(dataSetStatus, returnNodeValue("status"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet status : " + dataSetStatus + " is " +
                    "matching as expected");
        } catch (Exception e) {
            Assert.fail("DataSet name, Description and Status is not matching:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "DataSet name, Description and " +
                    "Status is not matching " + e.getMessage());
        }
    }

    @And("^verify DataSet is created with name \"([^\"]*)\", Description \"([^\"]*)\" and status as \"([^\"]*)\" and has data items$")
    public void verifyDataSetIsCreatedWithNameDescriptionAndStatusAsAndHasDataItems(String dataSetName, String dataSetDesc,
                                                                                    String dataSetStatus,
                                                                                    List<CucumberDataSet> dataItems) {

        List<String> dataElementsList = new ArrayList<>();
        try {
            for (CucumberDataSet items : dataItems) {
                dataElementsList.add(items.getDataElements());
            }
            Assert.assertEquals(dataElementsList.size(), returnNodeValuesAsList("dataElements").size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data elements size : " + dataElementsList.size() + " is " +
                    "matching as expected");
            Assert.assertTrue(dataElementsList.containsAll(returnNodeValuesAsList("dataElements")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Data elements list is " +
                    "matching as expected");
            Assert.assertEquals(dataSetName, returnNodeValue("name"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet name : " + dataSetName + " is " +
                    "matching as expected");
            Assert.assertEquals(dataSetDesc, returnNodeValue("description"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet description : " + dataSetDesc + " is " +
                    "matching as expected");
            Assert.assertEquals(dataSetStatus, returnNodeValue("status"));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSet status : " + dataSetStatus + " is " +
                    "matching as expected");

        } catch (Exception e) {
            Assert.fail("DataSet name, Description and Status is not matching:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "DataSet name, Description and " +
                    "Status is not matching " + e.getMessage());
        }
    }

    @And("^All DataSets should be listed$")
    public void allDataSetsShouldBeListed(DataTable dataTableCollection) {
        db_postgres_util = new DBPostgresUtil();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> arrResultList = new ArrayList<>();
        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            arrResultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Size of the list: " + arrResultList.size());
            Assert.assertEquals(arrResultList.size(), returnNodeValuesAsList("name").size());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Number of DataSets is matching as expected");
            Assert.assertTrue(arrResultList.containsAll(returnElementLists("name")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DataSets list is matching as expected");
        } catch (Exception e) {
            Assert.fail("DataSet list is not matching" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "\"DataSet list is not matching\" "
                    + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user waits for the final status to be reflected after \"([^\"]*)\" milliseconds$")
    public void userWaitsForTheFinalStatusToBeReflectedAfterMilliseconds(long arg0) throws Throwable {
        Thread.sleep(arg0);
    }


    @Given("^user makes a REST Call with url \"([^\"]*)\" to get item \"([^\"]*)\" and compare with below names$")
    public void user_makes_a_REST_Call_with_url_to_get_item_and_compare_with_below_names(String url, String attributeName, List<CucumberDataSet> itemameList) throws Throwable {
        List<String> itemNameFromResponse = new ArrayList<>();
        List<String> itemName = new ArrayList<>();
        try {
            for (String id : CommonUtil.getTemporaryList()) {
                invokeGetRequest(url + id);
                itemNameFromResponse.add(returnNodeValue(attributeName));
            }
            for (CucumberDataSet data : itemameList) {
                itemName.add(data.getItemName());
            }
            Assert.assertTrue(CommonUtil.compareLists(itemNameFromResponse, itemName));
        } catch (Exception e) {
            Assert.fail("Data Elements assigned to Data Set is mismatched" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data Elements assigned to Data Set is mismatched"
                    + e.getMessage());
        }

    }

    @Given("^user makes a REST Call to DELETE \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_to_DELETE(String url) throws Throwable {
        invokeDeleteRequest(url + CommonUtil.getText());
    }

    @And("^user makes a REST Call for DELETE request with url \"([^\"]*)\" with softdelete as \"([^\"]*)\"$")
    public void userMakesARESTCallForDELETERequestWithUrlWithSoftdeleteAs(String path, String flag) throws Throwable {
        String dynamicPath = null;
        try {
            dynamicPath = path + ":::" + commonUtil.getTemporaryText() + "?softdelete=" + flag;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "URL" + dynamicPath);
            invokeDeleteRequest(dynamicPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @And("^user verifies deletedBy column is updated for \"([^\"]*)\"$")
    public void userVerifiesDeletedByColumnIsUpdatedFor(String columnName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> columnValues = new ArrayList<>();
        try {
            arrCriteriaValue.add(columnName);
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            Assert.assertTrue(columnValues.get(0).equals("TestService"));


        } catch (Exception e) {
            Assert.fail("Table values doesn't match response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table values is not matching with given params");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user makes a REST Call for GET request with url \"([^\"]*)\" for the stored id$")
    public void userMakesARESTCallForGETRequestWithUrlForTheStoredId(String path) throws Throwable {
        String dynamicPath = null;
        try {
            dynamicPath = path + ":::" + commonUtil.getTemporaryText() + "?what=asg.deletedAt";
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "URL" + dynamicPath);
            invokeGetRequest(dynamicPath);

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }

    }

    @And("^user compares the response with the database for \"([^\"]*)\"$")
    public void userComparesTheResponseWithTheDatabaseFor(String columnName, DataTable dataTableCollection) throws Throwable {
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        String splitIdValue = null;
        List<String> columnValues = new ArrayList<>();
        criteriaValue.add(columnName);
        try {
            splitIdValue = returnSplitValueLeft((returnSplitValueRightWithLimit(returnRestResponse(), ":", 2).replace("\"", "")), "T");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated API Value: " + splitIdValue);
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            columnValues = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB Response: " + columnValues.get(0));
            Assert.assertTrue(columnValues.get(0).contains(splitIdValue.trim()));
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Response doesnt match with the database" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^user makes a REST Call for POST request with url \"([^\"]*)\" with timestamp$")
    public void userMakesARESTCallForPOSTRequestWithUrlWithTimestamp(String path) throws Throwable {
        String dynamicPath = null;
        String timeStamp = null;
        try {
            timeStamp = getJsonValueUsingJsonPath("$..['asg.deletedAt']").replace("\"", "").replace("}", "").replaceAll(":", "%3A").trim();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "TimeStamp" + timeStamp);
            dynamicPath = path + timeStamp;
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "URL" + dynamicPath);
            invokePostRequest(dynamicPath);
        } catch (Exception e) {
            e.getCause();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error invoking Post Request");
        }
    }

    @And("^The criteria values for the below query in Postgres should be \"([^\"]*)\" and the expected output is \"([^\"]*)\"$")
    public void theCriteriaValuesForTheBelowQueryInPostgresShouldBeAndTheExpectedOutputIs(String arg0, String arg1, DataTable arg2) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int count = 0;
        try {
            criteriaValue.add(arg0);
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(arg2, criteriaValue);
            resultList = db_postgres_util.returnQueryList(queryBuilder, getselectedColumnName);
            Assert.assertEquals(arg1, resultList.get(0));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Executed the query : " + queryBuilder);
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Actual status is not matched with the Expected status : " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^default hostname is modified to exact environment in the file name \"([^\"]*)\"$")
    public void defaultHostnameIsModifiedToExactEnvironmentInTheFileName(String arg0) throws Throwable {
        propertyLoader();
        FileUtil.replaceSpecficString("hostname", propLoader.prop.getProperty("sftpServerHostname"), REST_PAYLOAD + arg0);
    }

    @Given("^user makes a REST Call for the data set with id \"([^\"]*)\" and get the values of \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_the_data_set_with_id_and_get_the_values_of(String dataSetID, String attributeName) throws Throwable {
        invokeGetRequest(dataSetID + CommonUtil.getText());
        returnRestResponse();
        CommonUtil.storeTemporaryList(returnElementLists(attributeName));
    }


    @Given("^user update dataset id in \"([^\"]*)\" file with json path \"([^\"]*)\"$")
    public void user_update_dataset_id_in_file_with_json_path(String fileName, String jsonPath) throws Throwable {
        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, jsonPath, CommonUtil.getText());
    }

    @Given("^user makes a REST Call for Get request with url \"([^\"]*)\" and file Name \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_Get_request_with_url_and_file_Name(String url, String downloadFormat) throws Throwable {
        if (CommonUtil.getText().length() == 21) {
            String path = url + CommonUtil.getText().substring(20, 21).trim() + downloadFormat;
            invokeGetRequest(path);
        } else if (CommonUtil.getText().length() == 22) {
            String path = url + CommonUtil.getText().substring(20, 22).trim() + downloadFormat;
            invokeGetRequest(path);
        }
    }

    @Given("^user makes a REST Call to DELETE dataset \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_to_DELETE_dataset(String url) throws Throwable {
        invokeDeleteRequest(url + commonUtil.getTemporaryText());
    }

    @And("^user makes a REST Call for POST request with url \"([^\"]*)\" for the stored dataset id$")
    public void userMakesARESTCallForPOSTRequestWithUrlForTheStoredDatasetId(String path) throws Throwable {
        String dynamicPath = null;
        String timeStamp = null;
        try {
            dynamicPath = path + "DataSets.DataSet:::" + commonUtil.getTemporaryText() + "/notebooks";
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "URL" + dynamicPath);
            invokePostRequest(dynamicPath);
            CommonUtil.storeText(returnJsonValue("id"));
        } catch (Exception e) {
            e.getCause();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^user \"([^\"]*)\" the json file \"([^\"]*)\" file for following values$")
    public void user_the_json_file_file_for_following_values(String actionType, String fileName, DataTable values) throws Throwable {
        String jsonPath = null;
        String jsonValues = null;
        String type = null;
        try {
            switch (actionType) {
                case "add": {
                    for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                        JsonBuildUpdateUtil.addJsonObjectValueToArray(REST_PAYLOAD + fileName, data.get("jsonPath"), data.get("jsonKey"), data.get("jsonValues"));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values added to JSON Array");
                    }
                }
                break;
                case "update": {
                    for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                        jsonPath = data.get("jsonPath");
                        jsonValues = data.get("jsonValues");
                        type = data.get("type");
                        boolean value;
                        if (type != null) {
                            if (type.equals("Array")) {
                                if (jsonValues.equals("tempStoredValue")) {
                                    JsonBuildUpdateUtil.updateArrayValue(REST_PAYLOAD + fileName, jsonPath, CommonUtil.getText());
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in json file");

                                } else {
                                    JsonBuildUpdateUtil.updateArrayValue(REST_PAYLOAD + fileName, jsonPath, jsonValues);
                                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in json file");
                                }
                            } else if (type.equalsIgnoreCase("boolean")) {
                                if (jsonValues.equalsIgnoreCase("true")) {
                                    value = true;
                                } else {
                                    value = false;
                                }
                                JsonBuildUpdateUtil.updateJsonNodeWithBoolean(REST_PAYLOAD + fileName, jsonPath, value);
                            } else if (type.equalsIgnoreCase("Integer")) {
                                int Value = Integer.parseInt(jsonValues);
                                JsonBuildUpdateUtil.updateJsonNodeWithInteger(REST_PAYLOAD + fileName, jsonPath, Value);
                            } else {
                                JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, jsonPath, jsonValues);
                                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in json file");
                            }
                        } else {
                            JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, jsonPath, jsonValues);
                            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in json file");
                        }
                    }
                    break;
                }
                case "append": {
                    for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                        String newJSONObject = data.get("jsonObjectFilePath");
                        String jsonPath1 = data.get("jsonPath");
                        JsonBuildUpdateUtil.appendNewObjectFromFileToJSON(REST_PAYLOAD + newJSONObject, REST_PAYLOAD + fileName, jsonPath1);
                    }
                    break;
                }
                case "delete": {
                    for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                        String jsonPath1 = data.get("jsonPath");
                        JsonBuildUpdateUtil.deleteJSONNodeUsingPath(REST_PAYLOAD + fileName, jsonPath1);
                    }
                    break;
                }
                case "remove": {
                    for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                        String jsonPath1 = data.get("jsonPath");
                        JsonBuildUpdateUtil.removeJsonNodeUsingKey(REST_PAYLOAD + fileName, jsonPath1);
                    }
                    break;
                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
            Assert.fail(" values not updated in json file");
        }
    }

    @Given("^user update the json file \"([^\"]*)\" file for following values$")
    public void user_update_the_json_file_file_for_following_values(String fileName, DataTable values) throws
            Throwable {
        try {
            for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, data.get("jsonPath"), data.get("jsonValues"));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
            }
        } catch (Exception e) {
            Assert.fail(" not found in db");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
        }
    }

    @And("^user makes a REST Call for DELETE request with url \"([^\"]*)\" for node with hostname$")
    public void userMakesARESTCallForDELETERequestWithUrlForNodeWithHostname(String path) throws Throwable {
        String dynamicPath = null;
        try {
            dynamicPath = "/" + propLoader.prop.getProperty("hostName");
            invokeDeleteRequest(path + dynamicPath);

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error invoking Delete Request");
            Assert.fail("Error invoking Delete Request");
        }

    }

    @Then("^the below metadata should get displayed in the postgres for \"([^\"]*)\"$")
    public void the_below_metadata_should_get_displayed_in_the_postgres_for(String arg1, DataTable arg2) throws
            Throwable {
        db_postgres_util = new DBPostgresUtil();
        try {
            String query = "SELECT * FROM \"BigData\".\"V_Field\" where \"ID\" =" + CommonUtil.getValueFromTempHashMap(arg1) + ";";
            for (Map<String, String> hm : arg2.asMaps(String.class, String.class)) {
                Assert.assertTrue(db_postgres_util.returnQueryasMap(query).entrySet().containsAll(hm.entrySet()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata got displayed");
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^the below metadata should get displayed in the postgres for column \"([^\"]*)\"$")
    public void the_below_metadata_should_get_displayed_in_the_postgres_for_column(String arg1, DataTable arg2) throws
            Throwable {
        db_postgres_util = new DBPostgresUtil();
        HashMap<String, String> dbResults = new HashMap<String, String>();
        try {
            String query = "SELECT * FROM \"BigData\".\"V_Column\" where \"ID\" =" + CommonUtil.getValueFromTempHashMap(arg1) + ";";
            dbResults = (HashMap<String, String>) db_postgres_util.returnQueryasMap(query);
            for (Map.Entry entry : dbResults.entrySet()) {
                if (entry.getValue() != null)
                    try {
                        dbResults.put((String) entry.getKey(), String.valueOf(Float.parseFloat(entry.getValue().toString())));
                    } catch (NumberFormatException e) {

                    }
            }
            for (Map<String, String> hm : arg2.asMaps(String.class, String.class)) {
                Assert.assertTrue(dbResults.entrySet().containsAll(hm.entrySet()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata got displayed in postgres");
        } catch (Exception e) {
            Assert.fail("Unable to process the Query: " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Unable to process the Query:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^xml nodes in \"([^\"]*)\" file and \"([^\"]*)\" should be same except \"([^\"]*)\" node$")
    public void xml_nodes_in_file_and_should_be_same_except_node(String expectedXML, String actualXML, String
            ignoreattr) throws Throwable {
        try {
            Assert.assertTrue(XMLCompareUtil.compareTwoFiles(Constant.FEATURES + expectedXML, DOWNLOAD_FILE_PATH + actualXML, ignoreattr));
        } catch (Exception e) {
            Assert.fail(expectedXML + actualXML + " both xml are not identical" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^xml nodes in \"([^\"]*)\" file and \"([^\"]*)\" should not be same$")
    public void xml_nodes_in_file_and_should_not_be_same(String expectedXML, String actualXML) throws Throwable {
        try {
            Assert.assertFalse(XMLCompareUtil.compareTwoFiles(Constant.FEATURES + expectedXML, DOWNLOAD_FILE_PATH + actualXML, ""));
        } catch (Exception e) {
            Assert.fail(expectedXML + actualXML + " both xml are identical" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^user makes a REST Call for DELETE request with url \"([^\"]*)\" for specific Analysis$")
    public void user_makes_a_REST_Call_for_DELETE_request_with_url_for_specific_Analysis(String path) throws
            Throwable {
        try {
            invokeDeleteRequest(path + CommonUtil.getText().replaceAll("/", "%2F").replaceAll(" ", "%20").replaceAll(":", "%3A").replaceAll("\\+", "%2B"));
        } catch (Exception e) {
            Assert.fail(path + " is not deleted");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^User calls the below bitbucket API and accumulate count from response using json path \"([^\"]*)\"$")
    public void user_calls_the_below_bitbucket_API_and_accumulate_count_from_response_using_json_path(String
                                                                                                              jsonPath, DataTable bitBucketAPIList) throws Throwable {
        try {
            int fileCount = 0;

            for (Map<String, String> path : bitBucketAPIList.asMaps(String.class, String.class)) {
                invokeGetRequest(path.get("repositoryPath"));
                if (path.get("count").equals("Include")) {
                    fileCount = fileCount + Integer.parseInt(getJsonValueUsingJsonPath(jsonPath));
                } else if (path.get("count").equals("Exclude")) {
                    fileCount = fileCount - Integer.parseInt(getJsonValueUsingJsonPath(jsonPath));
                }
            }
            DataLoader.getDataLoaderInstance().getRepoData().setRepoFileCount(fileCount);
        } catch (Exception e) {
            Assert.fail("File count is not accumulated");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user makes a REST Call for PUT request with url \"([^\"]*)\" with dynamic id for dataset$")
    public void userMakesARESTCallForPUTRequestWithUrlWithDynamicIdForDataset(String path) throws Throwable {
        String dynamicPath = null;
        try {
            dynamicPath = path + commonUtil.getTemporaryText() + "?recursive=false&operation=SET";
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "URL" + dynamicPath);
            invokePutRequest(dynamicPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Given("^user makes a REST Call for Get request with url \"([^\"]*)\" and store value of json path\"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_Get_request_with_url_and_store_value_of_json_path(String path, String
            jsonPath) throws Throwable {
        if (path.contains("hostName")) {
            path = path.replace("hostName", propLoader.prop.getProperty("hostName"));
            invokeGetRequest(path);
            CommonUtil.storeText(getJsonValueUsingJsonPath(jsonPath));
        } else {
            invokeGetRequest(path);

            CommonUtil.storeText(getJsonValueUsingJsonPath(jsonPath));
        }
    }

    @Given("^user makes a REST Call for Get request with url \"([^\"]*)\" with value retrieved from json response$")
    public void user_makes_a_REST_Call_for_Get_request_with_url_with_value_retrieved_from_json_response(String path) throws
            Throwable {
        if (CommonUtil.getText().contains("HISTORY%20CATALOG")) {
            if (CommonUtil.getText().length() == 20) {
                invokeGetRequest(path + CommonUtil.getText().substring(19, 20));
            } else if (CommonUtil.getText().length() == 21) {
                invokeGetRequest(path + CommonUtil.getText().substring(19, 21));
            }
        } else if (CommonUtil.getText().contains("Analysis.Analysis")) {
            if (CommonUtil.getText().length() == 21) {
                invokeGetRequest(path + CommonUtil.getText().substring(CommonUtil.getText().lastIndexOf(":") + 1));
            } else {
                invokeGetRequest(path + CommonUtil.getText().substring(CommonUtil.getText().lastIndexOf(":") + 2));
            }

        }

    }

    @Given("^user get the value from response using json path \"([^\"]*)\" and decode the value$")
    public void user_get_the_value_from_response_using_json_path_and_decode_the_value(String jsonPath) throws
            Throwable {
        try {
            CommonUtil.storeText(CommonUtil.stringDecoder(getJsonValueUsingJsonPath(jsonPath)));
        } catch (Exception e) {
            Assert.fail("Decoding is not done" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @Then("^Old Analysis log should get displayed in response$")
    public void old_Analysis_log_should_get_displayed_in_response() throws Throwable {
        try {
            Assert.assertTrue(returnRestResponse().contains(CommonUtil.getText()));

        } catch (Exception e) {
            Assert.fail("Response doesn't have old Analysis log value " + CommonUtil.getText() + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }

    @And("^user compares the value from response using json path \"([^\"]*)\"$")
    public void userComparesTheValueFromResponseUsingJsonPath(String jsonPath, List<CucumberDataSet> jsonValue) throws
            Throwable {
        try {
            for (CucumberDataSet data : jsonValue) {

                Assert.assertEquals(data.getJsonValues().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", ""), getJsonValueUsingJsonPath(jsonPath));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response" + getJsonValueUsingJsonPath(jsonPath));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected value is mismatching with Response");
            Assert.fail("Expected value is mismatching with Response:  " + e.getMessage());
        }
    }

    @Given("^user makes REST call for Get \"([^\"]*)\" and retrieves value from using jsonpath \"([^\"]*)\"$")
    public void user_makes_REST_call_for_Get_and_retrieves_value_from_using_jsonpath(String path, String jsonPath) throws
            Throwable {
        try {
            invokeGetRequest(path);
            CommonUtil.storeText(getJsonValueUsingJsonPath(jsonPath));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response" + getJsonValueUsingJsonPath(jsonPath));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "JsonValue from Response is stored");
        }
    }


    @When("^user makes a REST Call for \"([^\"]*)\" request with url \"([^\"]*)\" and path \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_request_with_url_and_path(String service, String endPoint, String
            querypath) throws Throwable {
        try {
            switch (service) {
                case "POST":
                    RestAssured.reset();
                    if (endPoint.contains("storedID")) {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(19) + querypath);
                        invokePostRequest(path);
                    } else if (endPoint.contains("storedText")) {
                        String path = endPoint.replaceAll("storedText", CommonUtil.getText() + querypath);
                        invokePostRequest(path);
                    }
                    break;
                case "DELETE":
                    if (endPoint.contains("storedID")) {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(19) + querypath);
                        invokeDeleteRequest(path);
                    } else if (endPoint.contains("storedText")) {
                        String path = endPoint.replaceAll("storedText", CommonUtil.getText() + querypath);
                        invokeDeleteRequest(path);
                    }
                    break;
                case "PUT":
                    if (endPoint.contains("PIIEntity") && endPoint.contains("storedID")) {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(29) + querypath);
                        invokePutRequest(path);
                    } else if (endPoint.contains("PIIAttribute") && endPoint.contains("storedID")) {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(32) + querypath);
                        invokePutRequest(path);
                    } else if (endPoint.contains("BusinessTerm") && endPoint.contains("storedID")) {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(32) + querypath);
                        invokePutRequest(path);
                    } else if (endPoint.contains("storedText")) {
                        String path = endPoint.replaceAll("storedText", CommonUtil.getText() + querypath);
                        invokePutRequest(path);
                    } else {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(19) + querypath);
                        invokePutRequest(path);
                    }
                    break;
                case "GET":
                    if (endPoint.contains("storedID")) {
                        String path = endPoint.replaceAll("storedID", CommonUtil.getText().substring(19) + querypath);
                        invokeGetRequest(path);
                    } else if (endPoint.contains("storedText")) {
                        String path = endPoint.replaceAll("storedText", CommonUtil.getText() + querypath);
                        invokeGetRequest(path);
                    }
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "JsonValue from Response is stored");
        }
    }

    @Given("^user add temp text JsonArray value in payload \"([^\"]*)\" to \"([^\"]*)\" index$")
    public void user_add_temp_text_JsonArray_value_in_payload_to_index(String filePath, String index) throws
            Throwable {
        try {
            JsonBuildUpdateUtil.addJsonArrayValueToFile(REST_PAYLOAD + filePath, Integer.parseInt(index), CommonUtil.getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Json Array value  updated in file");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Json Array value not updated in file");
        }
    }

    @Then("^response of user groups should match with \"([^\"]*)\"$")
    public void response_of_userGroups_should_match_with(String filePath) throws Throwable {
        try {
            Assert.assertEquals(CommonUtil.getTextWithoutNextLineInResponse(returnRestResponse().toString().replaceAll(" ", "")), (jsonRead.readFile(REST_PAYLOAD + filePath).toString().replaceAll(" ", "")));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response matches");

        } catch (Exception e) {
            Assert.fail("Response doesn't match");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response doesn't match ");
        }
    }

    @And("^user verifies whether the value is present in response using json path \"([^\"]*)\"$")
    public void userComparesTheValueWithResponseUsingJsonPath(String jsonPath, List<CucumberDataSet> jsonValue) throws
            Throwable {
        try {
            for (CucumberDataSet data : jsonValue) {
                Assert.assertTrue(getJsonValueUsingJsonPath(jsonPath).contains(data.getJsonValues().toString()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response" + getJsonValueUsingJsonPath(jsonPath));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected value is mismatching with Response");
            Assert.fail("Expected value is mismatching with Response:  " + e.getMessage());
        }
    }

    @Then("^response message should not have value \"([^\"]*)\" for jsonpath \"([^\"]*)\"$")
    public void response_message_should_not_have_value_for_jsonpath(String responseValue, String jsonPath) throws
            Throwable {
        try {
            for (String value : getJsonResponseValuesInList(jsonPath)) {
                if (value.equals(responseValue)) {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response contains" + responseValue);
                } else {
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response doesn't contains" + responseValue);
                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response doesn't contains");
            Assert.fail("Expected value is mismatching with Response:  " + e.getMessage());
        }
    }

    @And("^user performs update in DB for a particular row \"([^\"]*)\" with value \"([^\"]*)\" without suffix$")
    public void userPerformsUpdateInDBForAParticularRowWithValueWithoutSuffix(String rowNum, String
            columnValue, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        criteriaValue.add(rowNum);

        try {
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue, columnValue);
            db_postgres_util.updateQuery(queryBuilder);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^user verifies the solr count for the following query should be \"([^\"]*)\"$")
    public void userVerifiesTheSolrCountForTheFollowingQueryShouldBe(long count, DataTable table) throws Throwable {
        try {
            List<CucumberDataSet> solr_dataTable = table.asList(CucumberDataSet.class);
            long solrCount = solr.Solr_SearchCount(solr_dataTable.get(0).getQueryName(), solr_dataTable.get(0).getFilterQuery(), "/select");
            Assert.assertEquals(count, solrCount);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Solr Search Results is matching: " + count);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Solr Search Results is not matching" + e.toString());
            Assert.fail(e.getMessage());
        }
    }

    @And("^empty response body should be displayed$")
    public void emptyResponseBodyShouldBeDisplayed() throws Throwable {
        try {
            Assert.assertTrue(validateEmptyResponse());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " Response body is empty: ");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response body is not empty" + e.toString());
            Assert.fail(e.getMessage());
        }
    }


    @And("^user add \"([^\"]*)\" JsonArray value in payload \"([^\"]*)\" to \"([^\"]*)\" index$")
    public void userAddJsonArrayValueInPayloadToIndex(String value, String filePath, String index) throws Throwable {
        try {
            JsonBuildUpdateUtil.addJsonArrayValueToFile(REST_PAYLOAD + filePath, Integer.parseInt(index), value);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Json Array value  updated in file");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Json Array value not updated in file");
        }
    }

    @And("^user compares the following value from response using json path$")
    public void userComparesTheFollowingValueFromResponseUsingJsonPath(DataTable table) throws Throwable {
        try {
            for (Map<String, String> data : table.asMaps(String.class, String.class)) {

                Assert.assertEquals(data.get("jsonValues").replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", ""), getJsonValueUsingJsonPath(data.get("jsonPath")));
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response matched");
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected value is mismatching with Response");
            Assert.fail("Expected value is mismatching with Response:  " + e.getMessage());
        }
    }


    @And("^response message contains the following values$")
    public void responseMessageContainsTheFollowingValues(List<CucumberDataSet> dataTableCollection) throws
            Throwable {
        boolean status = false;

        try {
            for (CucumberDataSet data : dataTableCollection) {
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Verifying element exist in API response");
                status = returnRestResponseForXML(data.getResponseText());
                if (!status)
                    Assert.fail("Such Element value not found in API Response");
                else
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Element is found in API Response");

            }

            CommonUtil.tempElementList.clear();
        } catch (Exception e) {
            Assert.fail("Such Element value not found in API Response" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        }
    }


    @Given("^user should able store the response in \"([^\"]*)\" and save it as \"([^\"]*)\"$")
    public void user_should_able_store_the_response_in_and_save_it_as(String fileDirPath, String fileName) throws
            Throwable {
        try {
            FileUtil.createFileAndWriteData(fileDirPath + "/" + fileName, response.getBody().asString());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } catch (IOException e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response are not store in " + fileDirPath + fileName);
        }
    }

    @Given("^user retrieve the absolute analysis log with below parameters$")
    public void user_retrieve_the_absolute_analysis_log_with_below_parameters(DataTable paramValues) throws
            Throwable {
        try {
            for (Map<String, String> data : paramValues.asMaps(String.class, String.class)) {
                String fileSrc = data.get("sourcePath");
                String fileDest = data.get("destinationPath");
                String fileContentstartLine = data.get("fileContentStartLine");
                String fileContentEndLine = data.get("fileContentEndLine");
                FileUtil.writeSpecificContentToNewFile(Constant.FEATURES + fileSrc, Constant.FEATURES + fileDest, fileContentstartLine, fileContentEndLine);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Absolute logs are not retrieved");

        }
    }

    @Then("^Expected log file \"([^\"]*)\" in path \"([^\"]*)\" should match with \"([^\"]*)\"$")
    public void expected_log_file_in_path_should_match_with(String expLog, String dir, String actualLog) throws
            Throwable {
        try {
            switch (dir) {
                case "queryLog":
                    Assert.assertTrue(FileUtil.fileCompare(Constant.FEATURES + expLog,
                            Constant.FEATURES + actualLog));
                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Downloaded File content is matching source file");
                    break;
            }

        } catch (Exception e) {
            Assert.fail("Downloaded File content is not matching with source file");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Downloaded File content is not matching with source file");
        }
    }

    @Then("^response body should be \"([^\"]*)\"$")
    public void response_body_should_be(String arg1) throws Throwable {
        try {
            if (returnRestResponse() == null) {
                Assert.assertTrue(true);
            } else {
                Assert.fail("Response body is not null");
            }

        } catch (Exception e) {
            Assert.fail("Response body is not null");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response body is not null");
        }
    }

    @Given("^user makes recursive GET request for below parameters$")
    public void user_makes_recursive_GET_request_for_below_parameters(DataTable paramValues) throws Throwable {
        try {
            for (Map<String, String> data : paramValues.asMaps(String.class, String.class)) {
                String url = data.get("url");
                String body = data.get("body");
                String response_code = data.get("response code");
                String response_message = data.get("response message");
                String jsonPath = data.get("jsonPath");
                for (int i = 0; i < 75; i++) {
                    invokeGetRequestRecursive(url, response_message, String.valueOf(i));
                    if (getJsonValueUsingJsonPath(jsonPath).equals(response_message)) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
            Assert.fail("Response body is not null");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response body is not null");
        }
    }

    @When("^user makes a REST Call for \"([^\"]*)\" request with ID url \"([^\"]*)\" and path \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_Get_with_ID_URL(String service, String endPoint, String querypath) throws
            Throwable {
        try {
            switch (service) {
                case "GET":

                    String storedID = CommonUtil.getText();
                    String path = endPoint + storedID + querypath;
                    invokeGetRequest(path);
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "JsonValue from Response is stored");
        }
    }

    @And("^user stores the value from response using jsonpath\"([^\"]*)\"$")
    public void userStoresTheValueFromResponseUsingJsonpath(String jsonPath) throws Throwable {
        try {
            CommonUtil.storeText(getJsonValueUsingJsonPath(jsonPath));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response" + getJsonValueUsingJsonPath(jsonPath));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "JsonValue from Response is stored");
        }
    }


    @Given("^user update json file \"([^\"]*)\" file for following values using property loader$")
    public void userUpdateJsonFileFileForFollowingValuesUsingPropertyLoader(String fileName, DataTable values) throws
            Throwable {
        try {
            for (Map<String, String> data : values.asMaps(String.class, String.class)) {
                JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, data.get("jsonPath"), propLoader.prop.getProperty(data.get("jsonValues")));
                LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
            }
        } catch (Exception e) {
            Assert.fail(" not found in db");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
        }
    }

    @Given("^user update the json file \"([^\"]*)\" for following values using \"([^\"]*)\"$")
    public void user_update_the_json_file_for_following_value(String fileName, String
            value, List<CucumberDataSet> dataTableCollection) throws Throwable {
        try {
            switch (value) {
                case "db values":
                    for (CucumberDataSet data : dataTableCollection) {
                        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, data.getJsonPath(), CommonUtil.getText());
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
                    }
                    break;
                case "response":
                    for (CucumberDataSet data : dataTableCollection) {
                        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, data.getJsonPath(), getJsonValueUsingJsonPath(data.getJsonPath()));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
                    }
                    break;
                case "response array":
                    for (CucumberDataSet data : dataTableCollection) {
                        JsonBuildUpdateUtil.updateArrayValue(REST_PAYLOAD + fileName, data.getJsonPath(), getJsonValueUsingJsonPath(data.getJsonPath()));
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
                    }
                    break;
                case "commonUtil":
                    for (CucumberDataSet data : dataTableCollection) {
                        JsonBuildUpdateUtil.updateJsonNode(REST_PAYLOAD + fileName, data.getJsonPath(), CommonUtil.getTemporaryText());
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values updated in file");
                    }
                    break;
            }
        } catch (Exception e) {
            Assert.fail(" not found in db");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "values not updated in file");
        }
    }


    @Given("^endpoint for \"([^\"]*)\" having \"([^\"]*)\" and query param with \"([^\"]*)\" \"([^\"]*)\" for request type \"([^\"]*)\" with url \"([^\"]*)\" and body \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\"$")
    public void endpoint_for_having_and_query_param_with_for_request_type_with_url_and_body_and_verify_and(String
                                                                                                                   serviceName, String Header, String Query, String param, String type, String url, String file,
                                                                                                           int responseCode, String responseMessage) throws Throwable {

        initializeRestAPI(serviceName);
        String credentials = propLoader.prop.getProperty("TestSystemUser");
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        if (Header.equalsIgnoreCase("text/plain")) {
            multiHeader(credentials, Header, "text/plain");
        } else if (Header.equals("xml/json")) {
            multiHeader(credentials, "application/xml", "application/json");
        } else if (Header.equals("xml/xml")) {
            multiHeader(credentials, "application/xml", "application/xml");
        } else if (Header.equals("text/json")) {
            multiHeader(credentials, "text/plain", "application/json");
        } else if (Header.equals("Accept")) {
            setAcceptFormat(credentials, "application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("Content-Type")) {
            setContentType("application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("multiHeader")) {
            multiHeader("application/vnd.asg-services-policy.v1+json", "application/vnd.asg-services-policy.v1+json");
        } else {
            multiHeader(credentials, Header, "application/json");
        }

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
        setpathQueryParm(Query, param);
        if (url.contains("hostName")) {
            url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
        } else if (url.contains("dynamicID")) {
            url = url.replace("dynamicID", CommonUtil.getText());
        }
        try {
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    break;
                case "RecursiveGet":
                    invokeGetRequestRecursive(url, responseMessage, "60");
                    break;
                case "Put":
                    if (file != null && !file.isEmpty()) {
                        setBody(file);
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBody(file);
                            invokePostRequest(url);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }

            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                response_message_contains_value(responsemsg);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }
    }

    @Given("^user makes a REST Call for GET request with url \"([^\"]*)\" and save the response in file \"([^\"]*)\"$")
    public void user_makes_a_REST_Call_for_GET_request_with_url_and_save_the_response_in_file(String path, String
            file) throws Throwable {
        try {
            if (CommonUtil.getText() == null) {
                invokeGetRequest(path);
                FileUtil.createFileAndWriteData(Constant.TEST_DATA_PATH + file, returnRestResponse());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response");
            } else {
                invokeGetRequest(path.replace("dynamicID", CommonUtil.getText()));
                FileUtil.createFileAndWriteData(Constant.TEST_DATA_PATH + file, returnRestResponse());
                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response");
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Response not copied to file");
            Assert.fail("Response not copied to file" + e.getMessage());
        }
    }

    @Given("^user copy the data from \"([^\"]*)\" file to \"([^\"]*)\" file$")
    public void user_copy_the_data_from_file_to_file(String sourceFile, String destinationFile) throws Throwable {
        try {
            FileUtil.createFileAndWriteData(Constant.TEST_DATA_PATH + destinationFile, jsonRead.readFile(Constant.TEST_DATA_PATH + sourceFile));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected value is mismatching with Response");
            Assert.fail("Expected value is mismatching with Response:  " + e.getMessage());
        }
    }

    @Given("^user add new object \"([^\"]*)\" to file \"([^\"]*)\" with following params using json path \"([^\"]*)\"$")
    public void user_add_new_object_to_file_with_following_params_using_json_path(String jsonObject, String
            filePath, String jsonPath, DataTable arg4) throws Throwable {
        Map<String, Map<String, String>> data = new HashMap<>();
        Map<String, String> hm1 = new HashMap<>();
        try {
            for (Map<String, String> dataTable : arg4.asMaps(String.class, String.class)) {
                hm1.put(dataTable.get("jsonNode"), dataTable.get("jsonValue"));
            }
            data.put(jsonObject, hm1);
            JsonBuildUpdateUtil.addJsonObjectValueToArrayUsingMap(Constant.TEST_DATA_PATH + filePath, jsonPath, data);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected value is mismatching with Response");
            Assert.fail("Expected value is mismatching with Response:  " + e.getMessage());
        }
    }

    @Then("^user verify postgres column value generated from the query and the \"([^\"]*)\" value are same$")
    public void postgres_item_count_for_attribute_should_be(String expectedValue) throws Throwable {
        try {
            Assert.assertEquals(expectedValue, CommonUtil.getText());
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database value matches with" + expectedValue);
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Database value doesn't matches with" + expectedValue);
        }
    }


    @Given("^user upload bundles from \"([^\"]*)\" with  \"([^\"]*)\" based on the \"([^\"]*)\" and validates \"([^\"]*)\"$")
    public void user_upload_bundles_from_with_based_on_the_and_validates(String bundlePath, String restUrl, String
            productCode, String responseCode) throws Throwable {
        bundlePath = bundlePath.replace("SystemHomeDirectory", System.getProperty("user.home") + "\\" + "Documents");
        File dir = new File(bundlePath);
        try {
            for (File file : dir.listFiles())
                if (file.getName().contains(productCode)) {
                    LoggerUtil.logLoader_info(this.getClass().getName(), productCode + "--" + file.getName());
                    setMultiPart(bundlePath + file.getName());
                    invokePostRequest(restUrl);
                    Assert.assertEquals(String.valueOf(returnStatusCode()), responseCode);
                }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Bundle not uploaded");
        }
    }

    @Then("^verify created \"([^\"]*)\" is available for \"([^\"]*)\" User$")
    public void verify_created_is_available_for_User(String actionName, String userName, DataTable
            dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        List<String> resultList = new ArrayList<>();
        try {
            String response = returnRestResponse();
            if (actionName.equals("recentsearch")) {

                criteriaValue.add("com/asg/dis/platform/recentsearches_user.json/TestSystem/" + userName);
            }
            PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getName(), Query);
            resultList = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            for (String list : resultList) {
                LoggerUtil.logLoader_info(this.getClass().getName(), list);
                if (list.contains("\"name\":\"list of Tables\"") && list.contains(response)) {


                    LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Recent Search is found in DB");

                } else {
                    Assert.fail("Recent Search not found");
                    LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Recent Search is not found");

                }

            }

        } catch (Exception e) {
            Assert.fail("Recent Search not found");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());

        } finally {
            db_postgres_util.disConnect();
        }

    }

//10.3 New UI Step definitions

    //copied from QAdev for 10.3 changes
    @Given("^endpoint for \"([^\"]*)\" for \"([^\"]*)\" having \"([^\"]*)\" and query param with \"([^\"]*)\" \"([^\"]*)\" for request type \"([^\"]*)\" with url \"([^\"]*)\" and body \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\" using \"([^\"]*)\"$")
    public void endpoint_for_for_having_and_query_param_with_for_request_type_with_url_and_body_and_verify_and_using
    (String serviceName, String serviceUser, String Header, String Query, String param, String type, String
            url, String file, int responseCode, String responseMessage, String jsonPath) throws Throwable {

        initializeRestAPI(serviceName);
        String credentials = propLoader.prop.getProperty(serviceUser);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        if (Header.equalsIgnoreCase("text/plain")) {
            multiHeader(credentials, Header, "text/plain");
        } else if (Header.equals("xml/json")) {
            multiHeader(credentials, "application/xml", "application/json");
        } else if (Header.equals("xml/xml")) {
            multiHeader(credentials, "application/xml", "application/xml");
        } else if (Header.equals("text/json")) {
            multiHeader(credentials, "text/plain", "application/json");
        } else if (Header.equals("Accept")) {
            setAcceptFormat(credentials, "application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("Content-Type")) {
            setContentType("application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("multiHeader")) {
            multiHeader("application/vnd.asg-services-policy.v1+json", "application/vnd.asg-services-policy.v1+json");
        }
        if (Header.equals("text/xml")) {
            multiHeader(credentials, "text/xml", "text/xml");
        } else {
            multiHeader(credentials, Header, "application/json");
        }

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
        setpathQueryParm(Query, param);
        if (url.contains("hostName")) {
            url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
        } else if (url.contains("dynamicID")) {
            url = url.replace("dynamicID", CommonUtil.getText());
        }
        try {
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    break;
                case "RecursiveGet":
                    if (jsonPath != null) {
                        for (int i = 1; i < 300; i++) {
                            invokeGetRequestRecursive(url, responseMessage, String.valueOf(i));
                            if (getJsonValueUsingJsonPath(jsonPath).equals(responseMessage)) {
                                Assert.assertEquals(getJsonValueUsingJsonPath(jsonPath), responseMessage);
                                break;
                            }
                        }
                    } else {
                        invokeGetRequestRecursive(url, responseMessage, "50");
                    }
                    break;
                case "Put":
                    if (file != null && !file.isEmpty()) {
                        setBody(file);
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBody(file);
                            invokePostRequest(url);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }

            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                response_message_contains_value(responsemsg);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }
    }

    @Given("^user hits \"([^\"]*)\" for \"([^\"]*)\" with \"([^\"]*)\" and \"([^\"]*)\" \"([^\"]*)\" for request \"([^\"]*)\" with \"([^\"]*)\" and \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\" and store value in \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_hits_for_with_and_for_request_with_and_and_verify_and_and_store_value_in_using(String
                                                                                                            serviceName, String user, String Header, String Query, String param, String type, String url, String file,
                                                                                                    int responseCode, String responseMessage, String filePath, String jsonPath) throws Throwable {

        initializeRestAPI(serviceName);
        String credentials = null;
        switch (user) {
            case "TestSystem":
                credentials = propLoader.prop.getProperty("TestSystemUser");
                break;
            case "policyUser":
                if (filePath.isEmpty()) {
                    credentials = "Basic " + FileUtil.readAllBytesInFile(Constant.REST_DIR + file.substring(0, file.lastIndexOf("/")) + "/webToken.txt");
                } else {
                    credentials = "Basic " + FileUtil.readAllBytesInFile(Constant.REST_DIR + filePath.substring(0, filePath.lastIndexOf("/")) + "/webToken.txt");
                }
                break;
        }

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        if (Header.equalsIgnoreCase("text/plain")) {
            multiHeader(credentials, Header, "text/plain");
        } else if (Header.equals("xml/json")) {
            multiHeader(credentials, "application/xml", "application/json");
        } else if (Header.equals("xml/xml")) {
            multiHeader(credentials, "application/xml", "application/xml");
        } else if (Header.equals("text/json")) {
            multiHeader(credentials, "text/plain", "application/json");
        } else if (Header.equals("AcceptDecisionTables")) {
            setAcceptFormat(credentials, "application/vnd.asg-services-policies-decisiontables.v1+json");
        } else if (Header.equals("Content-Type")) {
            setContentType("application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("AcceptDecisionRules")) {
            authorizeRestAPI(credentials);
//            setAcceptFormat(credentials, "text/plain");
            setContentType("application/vnd.asg-services-policies-decisiontablerules.v1+json");
        } else if (Header.equals("AcceptFormat")) {
            setAcceptFormat(credentials, "application/json");
        } else {
            multiHeader(credentials, Header, "application/json");
        }

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
        setpathQueryParm(Query, param);
        if (url.contains("hostName")) {
            url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
        } else if (url.contains("dynamicID")) {
            url = url.replace("dynamicID", CommonUtil.getText());
        }
        try {
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    if (!filePath.isEmpty()) {
                        if (!jsonPath.isEmpty()) {
                            String jsonValue = getJsonValueUsingJsonPath(jsonPath);
                            FileUtil.createFileAndWriteData(Constant.REST_DIR + filePath, jsonValue);
                        } else if (jsonPath.isEmpty()) {
                            FileUtil.createFileAndWriteData(Constant.REST_DIR + filePath, returnRestResponse());
                        }
                    }
                    break;
                case "RecursiveGet":
                    if (jsonPath != null) {
                        for (int i = 1; i < 150; i++) {
                            invokeGetRequestRecursive(url, responseMessage, String.valueOf(i));
                            if (getJsonValueUsingJsonPath(jsonPath).equals(responseMessage)) {
                                Assert.assertEquals(getJsonValueUsingJsonPath(jsonPath), responseMessage);
                                break;
                            }
                        }
                    } else {
                        invokeGetRequestRecursive(url, responseMessage, "50");
                    }
                    break;
                case "Put":
                    if (file != null && !file.isEmpty()) {
                        setBodyContent(file);
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBodyContent(file);
                            invokePostRequest(url);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    if (!filePath.isEmpty()) {
                        if (!jsonPath.isEmpty()) {
                            String jsonValue = getJsonValueUsingJsonPath(jsonPath);
                            FileUtil.createFileAndWriteData(Constant.REST_DIR + filePath, jsonValue);
                        } else if (jsonPath.isEmpty()) {
                            FileUtil.createFileAndWriteData(Constant.REST_DIR + filePath, returnRestResponse());
                        }
                    }
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }

            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                response_message_contains_value(responsemsg);
            }
        } catch (
                Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }

    }

    @Given("^user performs the following JSON operation$")
    public void user_performs_the_following_JSON_operation(DataTable arg1) throws Throwable {
        try {
            for (Map<String, String> data : arg1.asMaps(String.class, String.class)) {
                String sourceJson = Constant.REST_DIR + data.get("jsonSourcePath");
                String readJSONPath = data.get("jsonReadPath");
                String destJson = Constant.REST_DIR + data.get("jsonDestPath");
                String writeJson = data.get("jsonWritePath");
                switch (data.get("type")) {
                    case "Cluster": {
                        String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                        JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        break;
                    }
                    case "Service": {
                        String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                        JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        break;
                    }
                    case "Database": {
                        String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                        JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        break;
                    }
                    case "Schema": {
                        String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                        JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        break;
                    }
                    case "Table": {
                        if (readJSONPath.contains("asg_scopeid")) {
                            String schemaID = JsonRead.getJsonValue(destJson, "$..has_Schema.id").replace("[", "").replace("]", "");
                            String dynamicID[] = schemaID.split(":");
                            String dynID = dynamicID[dynamicID.length - 1].replace("\\", "").replace("\"", "");
                            readJSONPath = readJSONPath.replace("parentID", dynID);
                            String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                            JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        } else {
                            String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                            JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        }
                        break;
                    }

                    case "Column": {
                        if (readJSONPath.contains("asg_scopeid")) {
                            String schemaID = JsonRead.getJsonValue(destJson, "$..has_Table.id").replace("[", "").replace("]", "");
                            String dynamicID[] = schemaID.split(":");
                            String dynID = dynamicID[dynamicID.length - 1].replace("\\", "").replace("\"", "");
                            readJSONPath = readJSONPath.replace("parentID", dynID);
                            String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                            JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        } else {
                            String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                            JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        }
                        break;
                    }
                    case "Constraint": {
                        String value = JsonRead.getJsonValue(sourceJson, readJSONPath).replace("[", "").replace("]", "");
                        JsonBuildUpdateUtil.updateJsonNode(destJson, writeJson, value);
                        break;

                    }
                }
            }

        } catch (
                Exception e) {
            e.getMessage();
            e.printStackTrace();
        }
    }

    @Given("^user makes a Get request with \"([^\"]*)\" and verify \"([^\"]*)\" using \"([^\"]*)\" from \"([^\"]*)\" and write to \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_makes_a_Get_request_with_and_verify_using_from_and_write_to_using(String url, String
            responseCode, String inputJson, String inputFile, String outPutFile, String outPutJson) throws Throwable {
        try {
            if (url.contains("dynamic")) {
                String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                url = url.replace("dynamic", dynID);
                invokeGetRequest(url);
                status_code_must_be_returned(Integer.parseInt(responseCode));

                if (!outPutFile.isEmpty()) {
                    if (!outPutJson.isEmpty()) {
                        String jsonValue = getJsonValueUsingJsonPath(outPutJson);
                        FileUtil.createFileAndWriteData(Constant.REST_DIR + outPutFile, jsonValue);
                    } else if (outPutJson.isEmpty()) {
                        FileUtil.createFileAndWriteData(Constant.REST_DIR + outPutFile, returnRestResponse());
                    }

                } else {
                    invokeGetRequest(url);
                    status_code_must_be_returned(Integer.parseInt(responseCode));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user makes a Get request with \"([^\"]*)\" and verify \"([^\"]*)\" using \"([^\"]*)\" from \"([^\"]*)\" and write to \"([^\"]*)\" using \"([^\"]*)\" of \"([^\"]*)\"$")
    public void user_makes_a_Get_request_with_and_verify_using_from_and_write_to_using_response(String url, String responseCode, String inputJson, String inputFile, String outPutFile, String outPutJson, String responsePath) throws Throwable {
        try {
            if (url.contains("dynamic")) {
                String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                url = url.replace("dynamic", dynID);
                invokeGetRequest(url);
                if (!outPutFile.isEmpty()) {
                    if (!outPutJson.isEmpty() && !responsePath.isEmpty()) {
                        String jsonValue = getJsonValueUsingJsonPath(responsePath);
                        JsonBuildUpdateUtil.updateJsonNode(Constant.REST_DIR + outPutFile, outPutJson, jsonValue);
                    } else if (outPutJson.isEmpty()) {
                        FileUtil.createFileAndWriteData(Constant.REST_DIR + outPutFile, returnRestResponse());
                    }

                } else {
                    invokeGetRequest(url);

                }
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in updating JsonNode" + e.getMessage());
        }
    }

    @And("^user stores the values in list from response using jsonpath \"([^\"]*)\"$")
    public void userStoresTheValuesInListFromResponseUsingJsonpath(String jsonPath) throws Throwable {
        try {
            CommonUtil.storeTemporaryList(getJsonResponseValuesInList(jsonPath));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response" + getJsonResponseValuesInList(jsonPath));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "JsonValue from Response is stored");
        }
    }

    @Given("^user makes \"([^\"]*)\" with \"([^\"]*)\"  for id from \"([^\"]*)\" \"([^\"]*)\" using \"([^\"]*)\" and verify \"([^\"]*)\",\"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_makes_with_for_id_from_using_and_verify_using(String requestType, String url, String
            file, String type, String path, String status, String resonseValue, String jsonPath) throws Throwable {
        try {
            switch (requestType) {
                case "Get":
                    switch (type) {
                        case "List":
                            if (url.contains("DYN")) {
                                if (url.contains("DYN")) {
                                    List<String> idList = new ArrayList<>();
                                    for (Long s : JsonRead.returnJsonObjectAsLongList(Constant.REST_DIR + file, path)) {
                                        idList.add(s.toString());
                                        url = url.replace("DYN", idList.get(0));
                                        invokeGetRequest(url);
                                        status_code_must_be_returned(Integer.parseInt(status));
                                    }
                                }
                            } else {
                                invokeGetRequest(url);
                            }
                            break;
                    }
                case "Delete":
                    switch (type) {
                        case "List":
                            List<String> idList = new ArrayList<>();
                            if (url.contains("DYN")) {
                                if (url.contains("DYN")) {
                                    for (Long s : JsonRead.returnJsonObjectAsLongList(Constant.REST_DIR + file, path)) {
                                        idList.add(s.toString());
                                    }
                                    for (int i = 0; i < idList.size(); i++) {
                                        invokeDeleteRequest(url.replace("DYN", idList.get(i)));
                                        status_code_must_be_returned(Integer.parseInt(status));

                                    }
                                }
                            } else {
                                invokeDeleteRequest(url);
                            }
                            break;
                    }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user fetches \"([^\"]*)\" and \"([^\"]*)\" request type \"([^\"]*)\" with url \"([^\"]*)\" and body \"([^\"]*)\" for \"([^\"]*)\" user$")
    public void userFetchesAndRequestTypeWithUrlAndBodyForUser(String contentType, String acceptType, String
            type, String url, String file, String user) throws Throwable {
        String credentials = propLoader.prop.getProperty(user);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        multiHeader(credentials, contentType, acceptType);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:" + contentType + ",acceptformat: application/json");
        try {
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    break;
                case "Put":
                    if (file != null && !file.isEmpty()) {
                        setBody(file);
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBody(file);
                            invokePostRequest(url);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }
    }

    @Given("^user makes request with \"([^\"]*)\" and type \"([^\"]*)\" to verify \"([^\"]*)\" and \"([^\"]*)\" using \"([^\"]*)\" from \"([^\"]*)\" with body \"([^\"]*)\" for \"([^\"]*)\" user and with \"([^\"]*)\" and \"([^\"]*)\"$")
    public void userFetchesAndRequestTypeWithUrlAndBodyForUser(String url, String type, int responseCode, String
            responseMessage, String inputJson, String inputFile, String body, String user, String contentType, String
                                                                       acceptType) throws Throwable {
        String credentials = propLoader.prop.getProperty(user);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        multiHeader(credentials, contentType, acceptType);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:" + contentType + ",acceptformat: application/json");
        String dynamicID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
        try {
            switch (type) {
                case "Get":
                    if (url.contains("dynamic")) {
                        String getDynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        url = url.replace("dynamic", getDynID);
                        invokeGetRequest(url);
                    } else {
                        invokeGetRequest(url);
                    }
                    break;
                case "Put":
                    if (url.contains("dynamic")) {
                        String putDynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        url = url.replace("dynamic", putDynID);
                        setBody(body);
                        invokePutRequest(url);
                    } else {
                        setBody(body);
                        invokePutRequest(url);
                    }
                    break;
                case "Post":
                    if (url.contains("dynamic")) {
                        String postDynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        url = url.replace("dynamic", postDynID);
                        setBody(body);
                        invokePostRequest(url);
                    } else {
                        setBody(body);
                        invokePostRequest(url);
                    }
                    break;
                case "Delete":
                    if (url.contains("dynamic")) {
                        String deleDynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        url = url.replace("dynamic", deleDynID);
                        invokeDeleteRequest(url);
                    } else {
                        invokeDeleteRequest(url);
                    }
                    break;
            }
            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                if (responsemsg.contains("dynamic")) {
                    responsemsg = responsemsg.replace("dynamic", dynamicID);
                }
                response_message_contains_value(responsemsg);
            }

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());

        }
    }

    @When("^user makes a REST Call for \"([^\"]*)\" request with url \"([^\"]*)\" and path \"([^\"]*)\" and get paramater from \"([^\"]*)\" file and \"([^\"]*)\" json$")
    public void user_makes_a_REST_Call_for_request_with_url_and_path(String service, String endPoint, String
            querypath, String inputFile, String inputJson, Map<String, String> queryParam) throws Throwable {
        try {
            switch (service) {
                case "POST":
                    RestAssured.reset();
                    if (endPoint.contains("dynamic")) {
                        String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        endPoint = endPoint.replace("dynamic", dynID);
                        invokePostRequest(endPoint);
                    } else {
                        request = request.queryParams(queryParam);
                        invokePostRequest(endPoint);
                    }
                    break;
                case "DELETE":
                    if (endPoint.contains("dynamic")) {
                        String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        endPoint = endPoint.replace("dynamic", dynID);
                        invokeDeleteRequest(endPoint);
                    } else {
                        invokeDeleteRequest(endPoint);
                    }
                    break;
                case "PUT":
                    if (endPoint.contains("dynamic")) {
                        String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        endPoint = endPoint.replace("dynamic", dynID);
                        request = request.queryParams(queryParam);
                        invokePutRequest(endPoint);
                    } else {
                        invokePutRequest(endPoint);
                    }
                    break;
                case "GET":
                    if (endPoint.contains("dynamic")) {
                        String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                        endPoint = endPoint.replace("dynamic", dynID);
                        request = request.queryParams(queryParam);
                        invokeGetRequest(endPoint);
                    } else {
                        invokeGetRequest(endPoint);
                    }
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "JsonValue from Response is stored");
        }
    }


    @Given("^user makes a delete request with \"([^\"]*)\" and verify \"([^\"]*)\" using \"([^\"]*)\" from \"([^\"]*)\"$")
    public void user_makes_a_delete_request_with_and_verify_using_from(String url, String responseCode, String
            inputJson, String inputFile) throws Throwable {
        try {
            if (url.contains("dynamic")) {
                String dynID = commonUtil.getNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                url = url.replace("dynamic", dynID);
                invokeDeleteRequest(url);
                status_code_must_be_returned(Integer.parseInt(responseCode));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("^user compares the value of the attribute \"([^\"]*)\" from the file \"([^\"]*)\" and with the response$")
    public void user_makes_a_REST_Call_with_url_to_get_item_and_compare_with_the_item_in_file(String
                                                                                                      attributeName, String fileName) throws Throwable {
        List<String> itemNameFromResponse = new ArrayList<>();
        List<String> itemName = new ArrayList<>();
        try {
            for (String id : CommonUtil.getTemporaryList()) {
                itemNameFromResponse.add(id);
            }

            String localXmlPath = "src\\test\\resources\\testdata\\rest\\payloads\\idc\\" + fileName;
            List<String> listofXmlNames = XMLReaderUtil.readAnAttributeFromFile(localXmlPath, "ITEM", "itemName");
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " XML Results: " + listofXmlNames);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " UI Results: " + itemNameFromResponse);

            Assert.assertEquals(itemNameFromResponse.size(), listofXmlNames.size());
            Collections.sort(listofXmlNames);
            Collections.sort(itemNameFromResponse);

            Assert.assertTrue(CommonUtil.compareLists(itemNameFromResponse, listofXmlNames));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Item names are matching");

        } catch (Exception e) {
            Assert.fail("Data Elements assigned to Data Set is mismatched" + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Data Elements assigned to Data Set is mismatched"
                    + e.getMessage());
        }

    }

    @And("^response query definition for \"([^\"]*)\" in database should match with the file \"([^\"]*)\"$")
    public void responseQueryDefinitionForInDatabaseShouldMatchWithTheFile(String queryName, String
            fileName, DataTable dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        String queryDefinition = null;
        try {
            arrCriteriaValue.add(queryName);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.get_String_Value(query, getselectedColumnName);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "jsonValue: " + jsonRead.readFile(REST_PAYLOAD + fileName));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "dbValue: " + queryDefinition.toString());
            Assert.assertTrue(commonUtil.compareTwoJsonStrings(jsonRead.readFile(REST_PAYLOAD + fileName), queryDefinition.toString()));
        } catch (Exception e) {
            Assert.fail("Query Definition doesn't match DB response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query Definition doesn't match DB response ");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Then("^deleted query definition \"([^\"]*)\" should not be present in database$")
    public void deleted_query_definition_should_not_be_present_in_database(String queryName, DataTable
            dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        List<String> criteriaValue = new ArrayList<>();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        int rowCount = 0;
        try {
            criteriaValue.add(queryName);
            String queryBuilder = postgresSqlBuilder.buildSqlQuery(dataTableCollection, criteriaValue);
            rowCount = db_postgres_util.get_rowCount(queryBuilder);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), " No of rows: " + rowCount);
            Assert.assertEquals(rowCount, 0);
        } catch (Exception e) {
            Assert.fail("Deleted query definition is present: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Deleted uery definition is present in database:  " + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    //This method helps to compare API response with database, the format of respoinse must be BigData.rating:::10
    @Then("^Response id return in json format must match with the value \"([^\"]*)\" in database$")
    public void response_id_return_in_json_format_must_match_with_table_in_database(String queryName, DataTable
            dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        int splitIdValue;
        splitIdValue = Integer.parseInt(returnRestResponse().replaceAll("[^0-9]", ""));
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Generated API Response Id is: " + splitIdValue);
        try {
            arrCriteriaValue.add(queryName);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            Assert.assertEquals(splitIdValue, Integer.parseInt(queryDefinition.get(0)));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "ID comparison between API ID is: " + splitIdValue + " and DB ID is :" + queryDefinition.get(0) + " Success");
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getName(), "Exception is: " + e.getMessage());
        } catch (AssertionError e) {
            Assert.fail("Actual id " + splitIdValue + "is not matched with Expected id: " + queryDefinition.get(0) + e.getMessage());
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }

    }

    @Then("^compare the response ID between REST API response and Postgres database with Schema name \"([^\"]*)\" are same$")
    public void compare_the_response_ID_between_REST_API_response_and_Postgres_database_Schema_name_and_Table_are_same
            (String queryName, DataTable dataTableCollection) throws Throwable {    // Write code here that turns the phrase above into concrete actions
        int currentValue = 0, expectedIdValue = 0;
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> expectedValue = new ArrayList<>();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> queryDefinition = new ArrayList<>();
        db_postgres_util = new DBPostgresUtil();
        try {
            List<String> text = CommaSeparateStringToList(returnRestResponse());
            for (String dbtest : text) {
                expectedIdValue = Integer.parseInt(returnSplitValueRight(dbtest, "\\.").replaceAll("[^0-9]", ""));
                expectedValue.add(String.valueOf(expectedIdValue));
            }
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Value: " + expectedValue + " extracted from API Response to compare with Database");


            arrCriteriaValue.add(queryName);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.returnQueryList(query, getselectedColumnName);
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Value: " + queryDefinition);

            Assert.assertTrue(CommonUtil.compareLists(expectedValue, queryDefinition));
        } catch (
                Exception e) {
            Assert.fail("Failed to Execute Query in Database");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Database Exception: " + e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^deleted item \"([^\"]*)\" should not be present in database$")
    public void deletedItemShouldNotBePresentInDatabase(String columnName, DataTable dataTableCollection) throws
            Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        try {
            arrCriteriaValue.add(columnName);
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            Assert.assertTrue(db_postgres_util.get_rowCount(Query) == 0);


        } catch (Exception e) {
            Assert.fail("Deleted item is present in database");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Deleted item is present in database");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^delete the record in database with table name \"([^\"]*)\" and type name \"([^\"]*)\"$")
    public void a_database_with_Schema_name_and_Table_name_to_delete_all_records(String tableName, String typeName) {
        // Write code here that turns the phrase above into concrete actions
        try {
            db_postgres_util = new DBPostgresUtil();
            String query = "delete from \"public" + "\".\"" + tableName + '"' + " where " + '"' + "type" + '"' + "='" + typeName + "'";
            db_postgres_util.execute(query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Executing Delete Query to Postgres database" + query);
        } catch (Exception e) {
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), e.getMessage());
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @And("^response query definition for \"(.*)\" in database should match with the response$")
    public void responseQueryDefinitionForInDatabaseShouldMatchWithTheResponse(String queryName, DataTable
            dataTableCollection) throws Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        String queryDefinition = null;
        List<String> itemNameFromResponse = new ArrayList<>();
        try {
            arrCriteriaValue.add(queryName);
            String query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + query);
            queryDefinition = db_postgres_util.get_String_Value(query);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "dbValue: " + queryDefinition.toString());

            for (String id : CommonUtil.getTemporaryList()) {
                itemNameFromResponse.add(id);
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Response List: " + itemNameFromResponse);
            Assert.assertTrue(uiWrapper.traverseListContainsString(itemNameFromResponse, queryDefinition));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Both the response and Db Values are matched");
        } catch (Exception e) {
            Assert.fail("Query Definition doesn't match DB response");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Query Definition doesn't match DB response ");
        } finally {
            db_postgres_util.disConnect();
        }
    }

    @Given("^user get source and target name from REST \"([^\"]*)\" for each \"([^\"]*)\" lineage hop ids from \"([^\"]*)\" and store source and target  name in \"([^\"]*)\"$")
    public void user_get_source_and_target_name_from_REST_for_each_lineage_hop_ids_from_and_store_source_and_target_name_in
            (String path, String item, String inputFile, String outputFile) throws Throwable {
        try {
            if (path.contains("DYN")) {
                org.json.simple.JSONObject jsonObject = new org.json.simple.JSONObject();
                org.json.simple.JSONObject jsonObject1 = new org.json.simple.JSONObject();
                for (String values : JsonRead.returnJsonObjectAsList(Constant.REST_DIR + inputFile, "$.hopsList")) {
                    String scopeId = null;
                    String sourceLocation = null;
                    String targetLocation = null;
                    if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "OperationID")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.OperationID");
                    } else if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "functionID")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.functionID");
                    } else if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "RoutineID")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.RoutineID");
                    }
                    String query = "SELECT * from public.items where  catalog='Default' and type='LineageHop' and name='" + values + "' and asg_scopeid='" + scopeId + "'";
                    invokeGetRequest(path.replace("DYN", dbHelper.returnValue("APPDBPOSTGRES", query)));
                    String mode = getJsonValueUsingJsonPath("$..mode");
                    String source = getJsonValueUsingJsonPath("$..edges.[?(@.type=='lineageFrom')].target");
                    String target = getJsonValueUsingJsonPath("$..edges.[?(@.type=='lineageTo')].target");
                    int sourceID = Integer.parseInt(source.substring(source.lastIndexOf(":") + 1));
                    int targetID = Integer.parseInt(target.substring(target.lastIndexOf(":") + 1));
                    String sourceQuery = "Select name from public.items where id=" + sourceID + "";
                    String targetQuery = "Select name from public.items where id=" + targetID + "";
                    String sourceName = dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery, "name");
                    String targetName = dbHelper.returnStringValue("APPDBPOSTGRES", targetQuery, "name");
                    Map<String, String> ls = new HashMap<>();
                    ls.put("lineageFrom", sourceName);
                    ls.put("lineageTo", targetName);
                    ls.put("mode", mode);
                    if (source.contains("File") || target.contains("File")) {
                        if (source.contains("File")) {
                            invokeGetRequest("searches/Default/query/queryDiagramOutRecursive/Default.File:::DYN".replace("DYN", String.valueOf(sourceID)));
                            sourceLocation = getJsonValueUsingJsonPath("$..nodes.[0].location");
                            ls.put("sourceLocation", sourceLocation);
                        }
                        if (target.contains("File")) {
                            invokeGetRequest("searches/Default/query/queryDiagramOutRecursive/Default.File:::DYN".replace("DYN", String.valueOf(targetID)));
                            targetLocation = getJsonValueUsingJsonPath("$..nodes.[0].location");
                            ls.put("targetLocation", targetLocation);
                        }
                    }
                    jsonObject.put(values, ls);
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + outputFile, item, jsonObject);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user get multiple source and target name from REST \"([^\"]*)\" for each \"([^\"]*)\" lineage hop ids from \"([^\"]*)\" and store source and target  name in \"([^\"]*)\"$")
    public void userGetMultipleSourceAndTargetNameFromRESTForEachLineageHopIdsFromAndStoreSourceAndTargetNameIn
            (String path, String item, String inputFile, String outputFile) throws Throwable {
        try {
            if (path.contains("DYN")) {
                org.json.simple.JSONObject jsonObject = new org.json.simple.JSONObject();
                for (String values : JsonRead.returnJsonObjectAsList(Constant.REST_DIR + inputFile, "$.hopsList")) {
                    String scopeId = null;
                    String sourceLocation = null;
                    String targetLocation = null;
                    if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "OperationID")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.OperationID");
                    } else if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "functionID") && JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "tableIDinsideFunction")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.tableIDinsideFunction");
                    } else if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "functionID")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.functionID");
                    } else if (JsonRead.isKeyPresentinJSONObject(Constant.REST_DIR + inputFile, "fileID")) {
                        scopeId = JsonRead.getJsonValue(Constant.REST_DIR + inputFile, "$.fileID");
                    }
                    String query = "SELECT * from public.items where  catalog='Default' and type='LineageHop' and name='" + values + "' and asg_scopeid='" + scopeId + "'";
                    Map<String, Object> ls = new HashMap<>();
                    invokeGetRequest(path.replace("DYN", dbHelper.returnValue("APPDBPOSTGRES", query)));
                    String mode = getJsonValueUsingJsonPath("$..[?(@.name=='" + values + "')].mode");
                    ls.put("mode", mode);

                    List<String> sourceList = getJsonResponseValuesInList("$..edges.[?(@.type=='lineageFrom' && @.level==1)].target");
                    List<String> lineageFromList = new ArrayList<String>();
                    for (String source : sourceList) {
                        int sourceID = Integer.parseInt(source.substring(source.lastIndexOf(":") + 1));
                        String sourceQuery = "Select name from public.items where id=" + sourceID + "";
                        String sourceName = dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery, "name");
                        lineageFromList.add(sourceName);
                        Collections.sort(lineageFromList);
                        ls.put("lineageFrom", lineageFromList);
                        if (source.contains("File")) {
                            invokeGetRequest("searches/Default/query/queryDiagramOutRecursive/Default.File:::DYN".replace("DYN", String.valueOf(sourceID)));
                            sourceLocation = getJsonValueUsingJsonPath("$..nodes.[0].location");
                            ls.put("sourceLocation", sourceLocation);
                        }
                    }

                    List<String> targetList = getJsonResponseValuesInList("$..edges.[?(@.type=='lineageTo' && @.level==1)].target");
                    List<String> lineageToList = new ArrayList<String>();
                    for (String target : targetList) {
                        int targetID = Integer.parseInt(target.substring(target.lastIndexOf(":") + 1));
                        String targetQuery = "Select name from public.items where id=" + targetID + "";
                        String targetName = dbHelper.returnStringValue("APPDBPOSTGRES", targetQuery, "name");
                        lineageToList.add(targetName);
                        Collections.sort(lineageToList);
                        ls.put("lineageTo", lineageToList);
                        if (target.contains("File")) {
                            invokeGetRequest("searches/Default/query/queryDiagramOutRecursive/Default.File:::DYN".replace("DYN", String.valueOf(targetID)));
                            targetLocation = getJsonValueUsingJsonPath("$..nodes.[0].location");
                            ls.put("targetLocation", targetLocation);
                        }
                    }

                    jsonObject.put(values, ls);
                    JsonBuildUpdateUtil.addJsonObjectToJSONFile(Constant.REST_DIR + outputFile, item, jsonObject);
                }

            }
        } catch (Exception e) {
            Assert.fail("Failed to get multiple Source and Target names from each LineageHops");
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Failed to get multiple Source and Target names from each LineageHops: " + e.getMessage());
        }
    }

    @Then("^expected JSON \"([^\"]*)\" data should be equal to actual \"([^\"]*)\" data$")
    public void expected_JSON_data_should_be_equal_to_actual_data(String expectedJSON, String actualJSON) throws
            Throwable {
        try {
            if (expectedJSON.contains("Constant.REST_DIR") || actualJSON.contains("Constant.REST_DIR")) {
                expectedJSON = expectedJSON.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                actualJSON = actualJSON.replace("Constant.REST_DIR/", Constant.REST_DIR);
            }
            CommonUtil.jsonAssertTwoJSONFiles(expectedJSON, actualJSON);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Then("^expected JSON \"([^\"]*)\" data should be equal to actual \"([^\"]*)\" data for item \"([^\"]*)\"$")
    public void expected_JSON_data_should_be_equal_to_actual_data_for_item(String expectedJSON, String
            actualJSON, String item) throws Throwable {
        try {
            actualJSON = actualJSON.replace("Constant.REST_DIR/", Constant.REST_DIR);
            if (expectedJSON.contains("Constant.REST_DIR/")) {
                expectedJSON = expectedJSON.replace("Constant.REST_DIR/", Constant.REST_DIR);
                CommonUtil.jsonAssertTwoJSONFilesForItem(expectedJSON, actualJSON, item);
            } else {
                CommonUtil.jsonAssertTwoJSONFilesForItem(Constant.REST_PAYLOAD + expectedJSON, actualJSON, item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @And("^user hits the \"([^\"]*)\" for the \"([^\"]*)\" and validate \"([^\"]*)\" with \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_hits_the_for_the_and_validate_with_using(String endPoint, String bundleName, String
            licenseCode, String statusCode, String jsonPath) throws Throwable {
        try {
            invokeGetRequest(endPoint + bundleName);
            Assert.assertEquals(Integer.parseInt(statusCode), returnStatusCode());
            Assert.assertEquals(licenseCode, getJsonValueUsingJsonPath(jsonPath));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @And("^user get the column \"([^\"]*)\" id from the following query$")
    public void userGetTheColumnIdFromTheFollowingQuery(String queryName, DataTable dataTableCollection) throws
            Throwable {
        db_postgres_util = new DBPostgresUtil();
        PostgresSqlBuilder postgresSqlBuilder = new PostgresSqlBuilder();
        List<String> arrCriteriaValue = new ArrayList<>();
        List<String> columnValues = new ArrayList<>();

        try {
            arrCriteriaValue.add(queryName);
            String Query = postgresSqlBuilder.buildSqlQuery(dataTableCollection, arrCriteriaValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Query: " + Query);
            columnValues = db_postgres_util.returnQueryList(Query, getselectedColumnName);
            CommonUtil.storeText(columnValues.get(0));

        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Table values is not matching with given params");
            Assert.fail("Table values doesn't match response");
        } finally {
            db_postgres_util.disConnect();
        }
    }


    @And("^user fetches \"([^\"]*)\" and \"([^\"]*)\" request type \"([^\"]*)\" with url \"([^\"]*)\", dynamic id \"([^\"]*)\" and body \"([^\"]*)\" for \"([^\"]*)\" user$")
    public void userFetchesAndRequestTypeWithUrlDynamicIdAndBodyForUser(String contentType, String
            acceptType, String type, String url, String endpoint, String file, String user) throws Throwable {
        String credentials = propLoader.prop.getProperty(user);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        multiHeader(credentials, contentType, acceptType);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:" + contentType + ",acceptformat: application/json");
        String dynamicUrl = null;
        try {
            switch (type) {
                case "Get":
                    dynamicUrl = url + CommonUtil.getText() + endpoint;
                    invokeGetRequest(dynamicUrl);
                    break;
                case "Put":
                    dynamicUrl = url + CommonUtil.getText() + endpoint;
                    if (file != null && !file.isEmpty()) {
                        setBody(file);
                        invokePutRequest(dynamicUrl);

                    } else
                        invokePutRequest(dynamicUrl);
                    break;
                case "Post":
                    dynamicUrl = url + CommonUtil.getText() + endpoint;
                    if (file != null && !file.isEmpty()) {
                        if (file.contains("json") || file.contains("txt") || file.contains("xml")) {
                            setBody(file);
                            invokePostRequest(dynamicUrl);
                        } else {
                            setMultiPart(FEATURES + file);
                            invokePostRequest(dynamicUrl);
                        }

                    } else
                        invokePostRequest(dynamicUrl);
                    break;
                case "Delete":
                    dynamicUrl = url + CommonUtil.getText() + endpoint;
                    invokeDeleteRequest(dynamicUrl);
                    break;
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());
        }
    }

    @And("^user add JsonArray value in payload \"([^\"]*)\" to \"([^\"]*)\" index from response$")
    public void userAddJsonArrayValueInPayloadToIndexfromResponse(String filePath, String index) throws Throwable {
        try {
            String jsonValue = getResponseAsString().toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", "");
            JsonBuildUpdateUtil.addJsonArrayValueToFile(REST_PAYLOAD + filePath, Integer.parseInt(index), jsonValue);
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Json Array value  updated in file");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Json Array value not updated in file");
        }
    }

    @And("^user append JsonArray value in payload \"([^\"]*)\" to \"([^\"]*)\" index with \"(.*)\" from response$")
    public void userAppendJsonArrayValueInPayloadToIndexfromResponse(String filePath, String index, String
            splCharater) throws Throwable {
        try {
            String jsonValue = getResponseAsString().toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", "");
            JsonBuildUpdateUtil.appendJsonObjectValueToFile(REST_PAYLOAD + filePath, Integer.parseInt(index), jsonValue, splCharater);

            String fileContext = FileUtil.returnFileContentToSTring(REST_PAYLOAD + filePath);
            String[] fileParts = fileContext.split(",");
            String filePart1 = fileParts[0].toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", "").replaceAll("\r\n", "");
            String filePart2 = fileParts[1].toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", "").replaceAll("\r\n", "");

            String fileValue = "[" + '"' + filePart1 + '"' + ',' + '"' + filePart2 + '"' + "]";

            JsonBuildUpdateUtil.addStringValueToFile(REST_PAYLOAD + filePath, fileValue);

            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Json Array value  updated in file");
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Json Array value not updated in file");
        }
    }


    @Given("^user json assert between \"([^\"]*)\" data and \"([^\"]*)\" data$")
    public void user_json_assert_between_data_and_data(String expectedJson, String actualJson) throws Throwable {
        try {
            if (expectedJson.contains("Constant.REST_DIR") || actualJson.contains("Constant.REST_DIR")) {
                expectedJson = expectedJson.replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                actualJson = actualJson.replace("Constant.REST_DIR/", Constant.REST_DIR);
            }
            CommonUtil.jsonAssertTwoJSONFiles(expectedJson, actualJson);
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(expectedJson + " values not equals to " + actualJson);
        }
    }

    @Given("^endpoint for \"([^\"]*)\" for \"([^\"]*)\" having \"([^\"]*)\" and query param with \"([^\"]*)\" \"([^\"]*)\" for request type \"([^\"]*)\" with url \"([^\"]*)\" and body as string from \"([^\"]*)\" with \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\" using \"([^\"]*)\"$")
    public void endpoint_for_for_having_and_query_param_with_for_request_type_with_url_and_body_as_string_from_with_and_verify_and_using(String serviceName, String serviceUser, String Header, String Query, String param, String type, String url, String bodyFile, String bodyPath, int responseCode, String responseMessage, String jsonPath) throws Throwable {

        initializeRestAPI(serviceName);
        String credentials = propLoader.prop.getProperty(serviceUser);
        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Initalizing Authentication: " + credentials);
        if (Header.equalsIgnoreCase("text/plain")) {
            multiHeader(credentials, Header, "text/plain");
        } else if (Header.equals("xml/json")) {
            multiHeader(credentials, "application/xml", "application/json");
        } else if (Header.equals("xml/xml")) {
            multiHeader(credentials, "application/xml", "application/xml");
        } else if (Header.equals("text/json")) {
            multiHeader(credentials, "text/plain", "application/json");
        } else if (Header.equals("Accept")) {
            setAcceptFormat(credentials, "application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("Content-Type")) {
            setContentType("application/vnd.asg-services-policy.v1+json");
        } else if (Header.equals("multiHeader")) {
            multiHeader("application/vnd.asg-services-policy.v1+json", "application/vnd.asg-services-policy.v1+json");
        } else {
            multiHeader(credentials, Header, "application/json");
        }

        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
        setpathQueryParm(Query, param);
        if (url.contains("hostName")) {
            url = url.replace("hostName", propLoader.prop.getProperty("hostName"));
        } else if (url.contains("dynamicID")) {
            url = url.replace("dynamicID", CommonUtil.getText());
        } else if (url.contains("HeadlessEDI")) {
            url = url.replace("HeadlessEDI", propLoader.prop.getProperty("clusterHostName"));
        }
        try {
            switch (type) {
                case "Get":
                    invokeGetRequest(url);
                    break;
                case "RecursiveGet":
                    if (jsonPath != null) {
                        for (int i = 1; i < 300; i++) {
                            invokeGetRequestRecursive(url, responseMessage, String.valueOf(i));
                            if (getJsonValueUsingJsonPath(jsonPath).equals(responseMessage)) {
                                Assert.assertEquals(getJsonValueUsingJsonPath(jsonPath), responseMessage);
                                break;
                            }
                        }
                    } else {
                        invokeGetRequestRecursive(url, responseMessage, "50");
                    }
                    break;
                case "Put":
                    if (bodyFile != null && !bodyFile.isEmpty()) {
                        setBodyAsString(JsonRead.getJsonValue(Constant.REST_DIR + bodyFile, bodyPath));
                        invokePutRequest(url);

                    } else
                        invokePutRequest(url);
                    break;
                case "Post":
                    if (bodyFile != null && !bodyFile.isEmpty()) {
                        if (bodyFile.contains("json") || bodyFile.contains("txt") || bodyFile.contains("xml")) {
                            setBodyAsString(JsonRead.getJsonValue(Constant.REST_DIR + bodyFile, bodyPath));
                            invokePostRequest(url);
                        } else {
                            setMultiPart(Constant.REST_DIR + bodyFile);
                            invokePostRequest(url);
                        }

                    } else
                        invokePostRequest(url);
                    break;
                case "Delete":
                    invokeDeleteRequest(url);
                    break;

            }

            status_code_must_be_returned(responseCode);
            String[] responses = responseMessage.split(",");
            for (String responsemsg : responses) {
                response_message_contains_value(responsemsg);
            }
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in fetching URL" + e.getMessage());
            Assert.fail("Rest end point service action failed");

        }
    }


    @Given("^user hits the following API with given parameters and store the api response in file$")
    public void user_hits_the_following_API_with_given_parameters_and_store_the_api_response_in_file(DataTable arg1) throws Throwable {
        List<Map<String, String>> ls = arg1.asMaps(String.class, String.class);
        String ServiceName = null;
        String credentials = null;
        String header = null;
        String user = null;
        String targetFile = null;
        org.json.simple.JSONObject jsonObject = new org.json.simple.JSONObject();
        try {
            for (int i = 0; i < ls.size(); i++) {
                ServiceName = ls.get(i).get("ServiceName");
                credentials = propLoader.prop.getProperty("TestSystemUser");
                header = ls.get(i).get("Header");
                targetFile = ls.get(i).get("targetFile");
            }
            initializeRestAPI(ServiceName);
            multiHeader(credentials, header, "application/json");
            for (int i = 0; i < ls.size(); i++) {
                user = ls.get(i).get("ServiceUser");
                String query = ls.get(i).get("Query");
                String param = ls.get(i).get("Param");
                String type = ls.get(i).get("type");
                String url = ls.get(i).get("url");
                String bodyFile = ls.get(i).get("bodyFile");
                String bodyJsonPath = ls.get(i).get("path");
                String responseCode = ls.get(i).get("response code");
                String responseMessage = ls.get(i).get("response message");
                String jsonPath = ls.get(i).get("jsonPath");

                LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Setting multiple-headers - Authentication:" + credentials + "ContentType:application/json , acceptformat: application/json");
                switch (type) {
                    case "Post":
                        if (bodyFile != null && !bodyFile.isEmpty()) {
                            if (bodyFile.contains("json") || bodyFile.contains("txt") || bodyFile.contains("xml")) {
                                setBodyAsString(JsonRead.getJsonValue(Constant.REST_DIR + bodyFile, bodyJsonPath));
                                invokePostRequest(url);
                            } else {
                                setMultiPart(Constant.REST_DIR + bodyFile);
                                invokePostRequest(url);
                            }
                            Assert.assertEquals(String.valueOf(returnStatusCode()), responseCode);
                            if (jsonPath != null) {
                                List<Map<String, String>> response = new ArrayList<>();
                                response.addAll(response().getBody().jsonPath().getJsonObject(jsonPath));
                                jsonObject.put(bodyJsonPath.substring(bodyJsonPath.lastIndexOf(".") + 1), response);
                            }
                        }
                        break;
                }
            }
            FileWriter fileWriter = new FileWriter(Constant.REST_DIR + targetFile);
            fileWriter.write(jsonObject.toJSONString());
            fileWriter.flush();
            fileWriter.close();

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user retrieves the name of each id stored in files with below parameters$")
    public void user_retrieves_the_name_of_each_id_stored_in_files_with_below_parameters(DataTable arg1) throws Throwable {
        try {
            List<Map<String, String>> dataTable = arg1.asMaps(String.class, String.class);
            String filePath = null;
            String tableName = null;
            for (int j = 0; j < dataTable.size(); j++) {
                tableName = dataTable.get(j).get("JsonPath");
                filePath = dataTable.get(j).get("fileName");
                if (filePath.contains("Constant.REST_DIR")) {
                    filePath = dataTable.get(j).get("fileName").replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                }
                JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".*");
                List<String> ls = new ArrayList<>();
                ls = JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".*");
                for (int i = 0; i < ls.size(); i++) {
                    String sourceJsonPath = JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".[" + i + "].source").get(0);
                    String targetJsonPath = JsonRead.returnJsonObjectAsList(filePath, "$.." + tableName + ".[" + i + "].target").get(0);
                    String sourceQuery = "select name from public.items where id=" + sourceJsonPath.substring(sourceJsonPath.lastIndexOf(":") + 1) + "";
                    String targetQuery = "select name from public.items where id=" + targetJsonPath.substring(targetJsonPath.lastIndexOf(":") + 1) + "";
                    String sourceName = dbHelper.returnStringValue("APPDBPOSTGRES", sourceQuery, "name");
                    String targetName = dbHelper.returnStringValue("APPDBPOSTGRES", targetQuery, "name");
                    if (sourceJsonPath.contains(":::")) {
                        JsonBuildUpdateUtil.updateJsonNode(filePath, "$.." + tableName + ".[" + i + "].source", sourceName);
                    }
                    if (targetJsonPath.contains(":::")) {
                        JsonBuildUpdateUtil.updateJsonNode(filePath, "$.." + tableName + ".[" + i + "].target", targetName);
                    }

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user sort the json file using the following value$")
    public void user_sort_the_json_file_using_the_following_value(DataTable arg1) throws Throwable {
        try {
            List<Map<String, String>> dataTable = arg1.asMaps(String.class, String.class);
            String filePath = null;
            String tableName = null;
            FileWriter fileWriter = null;
            for (int j = 0; j < dataTable.size(); j++) {
                tableName = dataTable.get(j).get("JsonPath");
                if (dataTable.get(j).get("fileName").contains("Constant.REST_DIR")) {
                    filePath = dataTable.get(j).get("fileName").replaceAll("Constant.REST_DIR/", Constant.REST_DIR);
                }
                List<String> list = new ArrayList<>();
                list = JsonRead.sortJsonObject(filePath, "$." + tableName, dataTable.get(j).get("value"));
                JsonBuildUpdateUtil.addJsonObjectToJSONFile(filePath, tableName, list);


            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @And("^user verifies \"([^\"]*)\" column is updated with \"([^\"]*)\"$")
    public void userVerifiesColumnIsUpdatedWith(String columnName, String expectedValue, DataTable dataTable) throws Throwable {
        try {
            for (Map<String, String> values : dataTable.asMaps(String.class, String.class)) {
                if (expectedValue.equalsIgnoreCase("current date")) {
                    String deletedAtquery = "SELECT * from public.items where  catalog='" + values.get("catalogName") + "' and type='" + values.get("type") + "' and name='" + columnName + "'";
                    Assert.assertEquals(java.time.LocalDate.now().toString(), commonUtil.dataFormater(dbHelper.returnStringValue(values.get("database"), deletedAtquery, values.get("columnName")), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd"));
                } else if (expectedValue.equalsIgnoreCase("targetID")) {
                    String idQuery = "SELECT " + columnName + " from public.links where asg_isnsa=true and target IN (SELECT id from public.items where  catalog='" + values.get("catalogName") + "' and type='" + values.get("type") + "' and name='" + values.get("columnName") + "')";
                    Assert.assertEquals(java.time.LocalDate.now().toString(), commonUtil.dataFormater(dbHelper.returnStringValue(values.get("database"), idQuery, columnName), "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd"));
                } else if (expectedValue.equalsIgnoreCase("ServiceID")) {
                    String idQuery = "SELECT " + columnName + " from public.links where asg_isnsa=true and target IN (SELECT id from public.items where  catalog='" + values.get("catalogName") + "' and type='" + values.get("type") + "' and name='" + values.get("columnName") + "')";
                    Assert.assertEquals("Service", dbHelper.returnStringValue(values.get("database"), idQuery, columnName));
                } else {
                    String deletedByquery = "SELECT * from public.items where  catalog='" + values.get("catalogName") + "' and type='" + values.get("type") + "' and name='" + columnName + "'";
                    Assert.assertEquals(expectedValue, dbHelper.returnStringValue(values.get("database"), deletedByquery, values.get("columnName")));
                }
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "DB verification is done");
        } catch (Exception e) {
            e.printStackTrace();
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Error in DB verification");
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user get json response and write to file \"([^\"]*)\" for json path \"([^\"]*)\"$")
    public void user_get_json_response_and_write_to_file_for_json_path(String filePath, String jsonPath) throws Throwable {
        try {
            if (jsonPath.equals("null")) {
                FileUtil.createFileAndWriteData(REST_DIR + filePath, returnRestResponse());
                LoggerUtil.logInfo(returnRestResponse() + " written to" + filePath);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user hits request \"([^\"]*)\" with \"([^\"]*)\" using dynamic id from \"([^\"]*)\" using \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\" with \"([^\"]*)\"$")
    public void user_hits_request_with_using_dynamic_id_from_using_and_verify_and_with(String requestType, String endpoint, String file, String dynIDPath, String code, String responseValue, String expectedValue) throws Throwable {
        try {
            switch (requestType) {
                case "Get":
                    if (endpoint.contains("DYNID")) {
                        endpoint = endpoint.replace("DYNID", JsonRead.getJsonValue(Constant.REST_DIR + file, dynIDPath));
                        invokeGetRequest(endpoint);
                        status_code_must_be_returned(Integer.parseInt(code));
                        Assert.assertEquals(getJsonValueUsingJsonPath(responseValue), expectedValue);
                    }
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }

    }

    @Given("^create formed query for Tag verification of UI items in API$")
    public String formedQueryForTagVerificationOfUIItemsInAPI(String clusterName, String serviceName, String databaseName, String schemaName, String tableNameorFileNmae, String columnName, String projectName, String directoryName, String businessApplicationName, String query) {
        String formedQuery = null;
        try {
            switch (query) {
                case "ColumnQuerywithoutSchema":
                    formedQuery = "select * from public.items where  catalog='Default' and name = '" + columnName + "' and type ='Column' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'))));";
                    break;
                case "ColumnQuerywithSchema":
                    formedQuery = "select * from public.items where  catalog='Default' and name = '" + columnName + "' and type ='Column' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')))));";
                    break;
                case "TableQuerywithSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'))));";
                    break;
                case "TableQuerywithoutSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')));";
                    break;
                case "ConstraintQuerywithSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Constraint' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'))));";
                    break;
                case "IndexQuerywithSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Index' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'))));";
                    break;
                case "SynonymQuerywithSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Synonym' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'))));";
                    break;
                case "DatabaseLinkQuerywithSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='DatabaseLink' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'))));";
                    break;
                case "UserRoleQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='UserRole' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')));";
                    break;
                case "UserQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='User' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')));";
                    break;
                case "TablespaceQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='Tablespace' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')));";
                    break;
                case "OracleFileQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='File' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')));";
                    break;
                case "SchemaQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster')));";
                    break;
                case "DatabaseQuery":
                    formedQuery = "select * from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster'));";
                    break;
                case "ServiceQuery":
                    formedQuery = "select * from public.items where name ='" + serviceName + "' and type='Service'  and asg_scopeid IN(select id from public.items where name like '%" + clusterName + "%' and type='Cluster');";
                    break;
                case "ClusterQuery":
                    formedQuery = "select * from public.items where name like '%" + clusterName + "%' and type='Cluster';";
                    break;
                case "FileQuery":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type='File'  and asg_scopeid IN(select id from public.items where name like '%" + directoryName + "%' and type='Directory');";
                    break;
                case "FileFieldQuery":
                    formedQuery = "select * from public.items where name ='" + columnName + "' and type='Field'  and asg_scopeid IN(select id from public.items where name like '%" + tableNameorFileNmae + "%' and type='File');";
                    break;
                case "DirectoryQuery":
                    formedQuery = "select * from public.items where name like '%" + directoryName + "%' and type='Directory';";
                    break;
                case "ServiceQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + serviceName + "' and type='Service' ";
                    break;
                case "DatabaseQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service');";
                    break;
                case "SchemaQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service' ));";
                    break;
                case "TableQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service' )));";
                    break;
                case "ColumnQueryWithoutCluster":
                    formedQuery = "select * from public.items where  catalog='Default' and name = '" + columnName + "' and type ='Column' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service'))));";
                    break;
                case "RoutineQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Routine' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service' )));";
                    break;
                case "ConstraintQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Constraint' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service' )));";
                    break;
                case "TriggerQueryWithoutCluster":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Trigger' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='Service' )));";
                    break;
                case "ContentQuery":
                    formedQuery = "select * from public.items where type ='Content' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "')";
                    break;
                case "AnalysisQuery":
                    formedQuery = "SELECT  * from public.items where type='Analysis' and name like '" + tableNameorFileNmae + "%'  ORDER By  asg_modifiedat DESC LIMIT 1;";
                    break;
                case "EDIColumnQuerywithoutSchema":
                    formedQuery = "select * from public.items where  catalog='Default' and name = '" + columnName + "' and type ='Column' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database'));";
                    break;
                case "OperationQuery":
                    formedQuery = "select * from public.items where name like '" + tableNameorFileNmae + "' and type='Operation' order by id DESC LIMIT 1";
                    break;
                case "BAQuery":
                    formedQuery = "select * from public.items where name ='" + businessApplicationName + "' and type='BusinessApplication';";
                    break;
                case "EDIColumnQuerywithSchema":
                    formedQuery = "select * from public.items where  catalog='Default' and name = '" + columnName + "' and type ='Column' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database')));";
                    break;
                case "EDITableQuerywithSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database'));";
                    break;
                case "EDITableQuerywithoutSchema":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Table' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database');";
                    break;
                case "EDISchemaQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='Schema' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='Database');";
                    break;
                case "EDIDatabaseQuery":
                    formedQuery = "select * from public.items where name ='" + databaseName + "' and type ='Database';";
                    break;
                case "EDIServiceQuery":
                    formedQuery = "select * from public.items where name ='" + serviceName + "' and type='Service';";
                    break;
                case "EDIClusterQuery":
                    formedQuery = "select * from public.items where name like '%" + clusterName + "%' and type='Cluster';";
                    break;
                case "ReportPackageQuery":
                    formedQuery = "select * from public.items where name like '%" + clusterName + "%' and type='ReportPackage';";
                    break;
                case "ReportSchemaQuery":
                    formedQuery = "select * from public.items where name ='" + serviceName + "' and type='ReportSchema'  and asg_scopeid IN (select id from public.items where name like '%" + clusterName + "%' and type='ReportPackage');";
                    break;
                case "DataTypeQuery":
                    formedQuery = "select * from public.items where name ='" + databaseName + "' and type ='DataType' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='ReportSchema'  and asg_scopeid IN (select id from public.items where name like '%" + clusterName + "%' and type='ReportPackage'));";
                    break;
                case "DataFieldQuery":
                    formedQuery = "select * from public.items where name ='" + schemaName + "' and type ='DataField' and asg_scopeid IN (select id from public.items where name ='" + databaseName + "' and type ='DataType' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='ReportSchema'  and asg_scopeid IN (select id from public.items where name like '%" + clusterName + "%' and type='ReportPackage')));";
                    break;
                case "ReportQuery":
                    formedQuery = "select * from public.items where name ='" + databaseName + "' and type ='Report' and asg_scopeid IN (select id from public.items where name ='" + serviceName + "' and type='ReportSchema'  and asg_scopeid IN (select id from public.items where name like '%" + clusterName + "%' and type='ReportPackage'));";
                    break;
                case "OperationWithinOperationQuery":
                    formedQuery = "select * from public.items where name ='" + columnName + "' and type='Operation'  and asg_scopeid IN (select id from public.items where name like '%" + tableNameorFileNmae + "%' and type='Operation');";
                    break;
                case "OlapPackageQuery":
                    formedQuery = "select * from public.items where name ='" + databaseName + "' and type ='OlapPackage'";
                    break;
                case "DimensionQuery":
                    formedQuery = "select * from public.items where name ='" + tableNameorFileNmae + "' and type ='Dimension' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type='OlapSchema' and asg_scopeid IN (select id from public.items where name='" + databaseName + "' and type='OlapPackage'))";
                    break;
                case "MeasureQuery":
                    formedQuery = "select * from public.items where name ='" + columnName + "' and type='Measure' and asg_scopeid IN (select id from public.items where name ='" + tableNameorFileNmae + "' and type ='Dimension' and asg_scopeid IN (select id from public.items where name ='" + schemaName + "' and type='OlapSchema' and asg_scopeid IN (select id from public.items where name='" + databaseName + "' and type='OlapPackage')))";
                    break;
                case "GenericQuery":
                    formedQuery = "select * from public.items where name like '%" + serviceName + "%' and type='" + clusterName + "';";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
        return formedQuery;
    }


    @Then("^Tag verification of UI items in API for all the DataTypes$")
    public void Tag_verification_of_UI_items_in_API_for_all_the_DataTypes(DataTable data) throws Throwable {
        try {
            a_query_param_with_and_and_supply_authorized_users_contentType_and_Accept_headers("", "");
            String formedQuery = null;
            List<String> actual = new ArrayList<>();
            List<String> expected = new ArrayList<>();
            boolean flag = false;
            for (Map<String, String> values : data.asMaps(String.class, String.class)) {

                String clusterName = values.get("ClusterName");
                String serviceName = values.get("ServiceName");
                String databaseName = values.get("DatabaseName");
                String schemaName = values.get("SchemaName");
                String projectName = values.get("projectName");
                String directoryName = values.get("directoryName");
                String tableNameorFileNmae = values.get("TableName/Filename");
                String columnName = values.get("Column");
                String TagName = values.get("Tags");
                String Action = values.get("Action");
                String query = values.get("Query");
                String businessApplicationName = values.get("BusinessApplicationName");
                String sourceId = null;
                String sourceType = null;
                String url = null;
                String[] userTags = null;

                formedQuery = formedQueryForTagVerificationOfUIItemsInAPI(clusterName, serviceName, databaseName, schemaName, tableNameorFileNmae, columnName, projectName, directoryName, businessApplicationName, query);

                switch (Action) {
                    case "TagAssigned":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actual = getJsonResponseValuesInList("$.sideBar.widgets[1].data..name");
                        userTags = TagName.split(",");
                        for (String value : userTags) {
                            expected.add(value);
                        }
                        if (expected.size() <= actual.size()) {
                            for (int i = 0; i < expected.size(); i++) {
                                Iterator<String> e = expected.iterator();
                                if (uiWrapper.traverseListContainsString(actual, expected.get(i)) == false) {
                                    flag = false;
                                    break;
                                }
                                flag = true;
                                e.next();
                            }
                        }
                        if (flag == true) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected and Actual tags are same in size and content");
                        } else {
                            Assert.fail("Failure on the TABLE = " + tableNameorFileNmae + " either one should be wrong \r\n 1.size comparison-Actualsize=" + actual.size() + " and Expectedsize=" + expected.size() + "\r\n 2.ExpectedTag =" + expected + " Not available in \nActualtListTags(UI) \n" + actual);
                        }
                        break;
                    case "TagNotAssigned":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actual = getJsonResponseValuesInList("$.sideBar.widgets[1].data..name");
                        userTags = TagName.split(",");
                        for (String value : userTags) {
                            expected.add(value);
                        }
                        if (expected.size() <= actual.size()) {
                            for (int i = 0; i < expected.size(); i++) {
                                Iterator<String> e = expected.iterator();
                                if (uiWrapper.traverseListContainsString(actual, expected.get(i)) == true) {
                                    commonUtil.storeText(expected.get(i));
                                    flag = false;
                                    break;
                                }
                                flag = true;
                                e.next();
                            }
                        }
                        if (flag == true) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Tags are not assigned");
                        } else {
                            Assert.fail("Failure on the TABLE = " + tableNameorFileNmae + " and the \r\n tag=" + commonUtil.getText() + " is available on the UI List = " + actual);
                        }
                        break;
                }
                expected.clear();
                actual.clear();
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }
    }

    @Given("^user delete all \"([^\"]*)\" log with name \"([^\"]*)\" using database$")
    public void user_delete_all_log_with_name_using_database(String dataType, String text) throws Throwable {
        try {
            switch (dataType) {
                case "Analysis":
                    String query = "SELECT  id from public.items where type='Analysis' and name like '" + text + "'";
                    dbHelper.returnRecordInlist("STRUCTURED", "APPDBPOSTGRES", query, "id");
                    RestAPIWrapper restAPIWrapper = new RestAPIWrapper();
                    String credentials = propLoader.prop.getProperty("TestSystemUser");
                    restAPIWrapper.initializeRestAPI("IDC");
                    restAPIWrapper.multiHeader(credentials, "application/json", "application/json");
                    if (dbHelper.returnRecordInlist("STRUCTURED", "APPDBPOSTGRES", query, "id") != null) {
                        for (String s : dbHelper.returnRecordInlist("STRUCTURED", "APPDBPOSTGRES", query, "id")) {
                            restAPIWrapper.invokeDeleteRequest("items/Default/Default.Analysis:::" + s);
                        }
                        LoggerUtil.logInfo("Analysis values are deleted");
                    }
                    LoggerUtil.logInfo("No values found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail("Values not deleted");
        }
    }

    @And("^user verifies whether the value is not present in response using json path \"([^\"]*)\"$")
    public void userVerifiesWhetherTheValueIsNotPresentInResponseUsingJsonPath(String jsonPath, List<CucumberDataSet> jsonValue) throws Throwable {
        try {
            for (CucumberDataSet data : jsonValue) {
                Assert.assertFalse(getJsonValueUsingJsonPath(jsonPath).contains(data.getJsonValues().toString()));
            }
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "JsonValue from Response not found" + getJsonValueUsingJsonPath(jsonPath));
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected value is matching with Response");
            Assert.fail("Expected value is matching with Response:  " + e.getMessage());
        }
    }

    @Given("^user makes a Get request with dynamic ID generated within \"([^\"]*)\" and verify \"([^\"]*)\" using \"([^\"]*)\" from \"([^\"]*)\" and write to \"([^\"]*)\" using \"([^\"]*)\"$")
    public void user_makes_a_Get_request_with_dynamic_id_in_url_and_verify_using_from_and_write_to_using(String url, String
            responseCode, String inputJson, String inputFile, String outPutFile, String outPutJson) throws Throwable {
        try {
            if (url.contains("dynamic")) {
                String dynID = commonUtil.getOnlyNUMfromString(JsonRead.getJsonValue(Constant.REST_DIR + inputFile, inputJson));
                url = url.replace("dynamic", dynID);
                invokeGetRequest(url);
                status_code_must_be_returned(Integer.parseInt(responseCode));

                if (!outPutFile.isEmpty()) {
                    if (!outPutJson.isEmpty()) {
                        String jsonValue = getJsonValueUsingJsonPath(outPutJson);
                        FileUtil.createFileAndWriteData(Constant.REST_DIR + outPutFile, jsonValue);
                    } else if (outPutJson.isEmpty()) {
                        FileUtil.createFileAndWriteData(Constant.REST_DIR + outPutFile, returnRestResponse());
                    }

                } else {
                    invokeGetRequest(url);
                    status_code_must_be_returned(Integer.parseInt(responseCode));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Given("Verify the metadata properties of the item types via api call$")
    public void Verify_the_metadata_properties_of_the_item_types_via_api_call(DataTable data) throws Throwable {

        String formedQuery = null;
        List<String> widgetList = new ArrayList<>();
        List<String> metadataValueList = new ArrayList<>();
        List<String> actualMetadataValueList = new ArrayList<>();
        List<String> expectedMetadataValueList = new ArrayList<>();
        List<String> userValues = new ArrayList<>();

        boolean flag = false;
        a_query_param_with_and_and_supply_authorized_users_contentType_and_Accept_headers("", "");
        for (Map<String, String> values : data.asMaps(String.class, String.class)) {

            String widgetName = values.get("widgetName");
            String clusterName = values.get("ClusterName");
            String serviceName = values.get("ServiceName");
            String databaseName = values.get("DatabaseName");
            String schemaName = values.get("SchemaName");
            String projectName = values.get("projectName");
            String directoryName = values.get("directoryName");
            String tableNameorFileNmae = values.get("TableName/Filename");
            String columnName = values.get("columnName/FieldName");
            String filePath = values.get("filePath");
            String Action = values.get("Action");
            String jsonPath = values.get("jsonPath");
            String query = values.get("query");
            String businessApplicationName = values.get("BusinessApplicationName");
            String tabName = values.get("TabName");
            String specialCharacters = values.get("specialCharacters");
            String sourceId = null;
            String sourceType = null;
            String url = null;
            String valueFormat = null;
            String[] userMetadataAttributes = null;
            String metadataAttribute = null;
            String metadataValue = null;
            formedQuery = formedQueryForTagVerificationOfUIItemsInAPI(clusterName, serviceName, databaseName, schemaName, tableNameorFileNmae, columnName, projectName, directoryName, businessApplicationName, query);

            try {
                switch (Action) {
                    case "metadataValuePresence":
                        Map<String, String> ActualMap = new HashMap<>();
                        Map<String, String> ExpectedMap = jsonRead.returnMapFromJsonObject(Constant.REST_PAYLOAD + filePath, jsonPath);
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        widgetList = getJsonResponseValuesInList("$..[?(@.caption=='" + widgetName + "')].caption");
                        for (int j = 1; j <= widgetList.size(); j++) {
                            metadataValueList = getJsonResponseValuesInList("$..[?(@.caption=='" + widgetName + "')].data.attributes..caption");
                            for (int i = 0; i < metadataValueList.size(); i++) {
                                metadataAttribute = getJsonValueUsingJsonPath("$..[?(@.caption=='" + widgetName + "')].data.attributes.[?(@.caption=='" + metadataValueList.get(i) + "')]..caption");
                                if (specialCharacters != null && specialCharacters.equalsIgnoreCase("yes")) {
                                    metadataValue = getJsonValueUsingJsonPathWithSpecialCharacters("$..[?(@.caption=='" + widgetName + "')].data.attributes.[?(@.caption=='" + metadataValueList.get(i) + "')]..value");
                                } else {
                                    metadataValue = getJsonValueUsingJsonPath("$..[?(@.caption=='" + widgetName + "')].data.attributes.[?(@.caption=='" + metadataValueList.get(i) + "')]..value");
                                }
                                if (metadataAttribute.equalsIgnoreCase("Data") && CommonUtil.isStringBase64(metadataValue) == true) {
                                    metadataValue = CommonUtil.stringDecoder(metadataValue);
                                }
                                try {
                                    DecimalFormat decimalFormat = new DecimalFormat("#.##");
                                    valueFormat = decimalFormat.format(Double.parseDouble(metadataValue));
                                    ActualMap.put(metadataAttribute, valueFormat);
                                } catch (Exception a) {
                                    if (ExpectedMap.get(metadataAttribute) != null && ExpectedMap.get(metadataAttribute).equalsIgnoreCase("null")) {
                                        valueFormat = metadataValue;
                                        ActualMap.put(metadataAttribute, valueFormat);
                                    } else {
                                        valueFormat = metadataValue.trim().replaceAll("null", "0").replaceAll("\\\\n", " ").replaceAll("\\\\", "");
                                        ActualMap.put(metadataAttribute, valueFormat);
                                    }
                                }
                            }
                        }
                        for (Map.Entry<String, String> entry : ExpectedMap.entrySet()) {
                            if (UIWrapper.containsKeyinMap(ExpectedMap, "Data") && CommonUtil.isStringBase64(entry.getValue()) == true) {
                                String encodedValue = CommonUtil.stringDecoder(ExpectedMap.get(metadataAttribute));
                                ExpectedMap.put(metadataAttribute, encodedValue);
                            }
                        }
                        if (ActualMap.entrySet().containsAll(ExpectedMap.entrySet()) && ExpectedMap.size() != 0 && ActualMap.size() != 0) {
                            Assert.assertTrue(true, "Both the Expected List and Actual list are same");
                        } else {
                            String sourceName = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "name");
                            Assert.fail("ACTUAL MAP from API ->\r\n" + ActualMap + " \r\n didn't matched with EXPECTED MAP from FILE -> \r\n\r" + ExpectedMap + "\r\n for the Columns/Field/File/Table/Cluster/Directory Name\r\n =" + sourceName);
                        }
                        break;
                    case "metadataAttributePresence":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actualMetadataValueList = getJsonResponseValuesInList("$..[?(@.caption=='" + widgetName + "')].data.attributes..caption");
                        userMetadataAttributes = jsonRead.getJsonValue(Constant.REST_PAYLOAD + filePath, jsonPath).replaceAll("[^a-zA-Z0-9,\\s]", "").split(",");
                        for (String value : userMetadataAttributes) {
                            expectedMetadataValueList.add(value);
                        }
                        if (expectedMetadataValueList.size() <= actualMetadataValueList.size()) {
                            for (int i = 0; i < expectedMetadataValueList.size(); i++) {
                                Iterator<String> e = expectedMetadataValueList.iterator();
                                if (uiWrapper.traverseListContainsString(actualMetadataValueList, expectedMetadataValueList.get(i)) == false) {
                                    flag = false;
                                    break;
                                }
                                flag = true;
                                e.next();
                            }
                        }
                        if (flag == true) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected and Actual tags are same in size and content");
                        } else {
                            Assert.fail("Failure on the TABLE = " + tableNameorFileNmae + " either one should be wrong \r\n 1.size comparison-Actualsize=" + actualMetadataValueList.size() + " and Expectedsize=" + expectedMetadataValueList.size() + "\r\n 2.ExpectedMetadataAttribute =" + expectedMetadataValueList + " Not available in \nActualtAttributeList(UI) \n" + actualMetadataValueList);
                        }
                        break;
                    case "metadataAttributeNonPresence":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actualMetadataValueList = getJsonResponseValuesInList("$..[?(@.caption=='" + widgetName + "')].data.attributes..caption");
                        userMetadataAttributes = jsonRead.getJsonValue(Constant.REST_PAYLOAD + filePath, jsonPath).replaceAll("[^a-zA-Z0-9,\\s]", "").split(",");
                        for (String value : userMetadataAttributes) {
                            expectedMetadataValueList.add(value);
                        }
//                        if (expectedMetadataValueList.size() <= actualMetadataValueList.size()) {
                        for (int i = 0; i < expectedMetadataValueList.size(); i++) {
                            Iterator<String> e = expectedMetadataValueList.iterator();
                            if (uiWrapper.traverseListContainsString(actualMetadataValueList, expectedMetadataValueList.get(i)) == true) {
                                commonUtil.storeText(expectedMetadataValueList.get(i));
                                flag = false;
                                break;
                            }
                            flag = true;
                            e.next();
                        }
//                        }
                        if (flag == true) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Metadata Attributes are not avilable in UI");
                        } else {
                            Assert.fail("Failure on the TABLE = " + tableNameorFileNmae + " and the \r\n MetadataAttribute=" + commonUtil.getText() + " is available on the UI Attribute List = " + actualMetadataValueList);
                        }
                        break;
                    case "verify widget contains":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actualMetadataValueList = getJsonResponseValuesInList("$..[?(@.category=='" + tabName + "')].data.[?(@.caption=='" + widgetName + "')].data.data..name");
                        userValues = jsonRead.getJsonValueAsList(Constant.REST_PAYLOAD + filePath, jsonPath);

                        if (actualMetadataValueList.containsAll(userValues) == true) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected values matches with Response Expected List " + actualMetadataValueList + "Actual" + userValues);

                        } else {
                            Assert.fail("Expected differs from " + actualMetadataValueList + "Actual" + userValues);
                        }

                        break;
                    case "verify widget presence":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actualMetadataValueList = getJsonResponseValuesInList("$..[?(@.category=='" + tabName + "')].data.[?(@.caption=='" + widgetName + "')].caption");
                        userValues = jsonRead.getJsonValueAsList(Constant.REST_PAYLOAD + filePath, jsonPath);

                        if (actualMetadataValueList.containsAll(userValues) == true) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget name from expected file  " + actualMetadataValueList + "is present in the UI" + userValues);

                        } else {
                            Assert.fail("Widget items from expected file = " + userValues + "is not present in the Analysis item=" + actualMetadataValueList);
                        }
                        break;
                    case "verify widget non presence":
                        sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                        sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                        url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                        invokeGetRequest(url);
                        actualMetadataValueList = getJsonResponseValuesInList("$..[?(@.category=='" + tabName + "')].data.[?(@.caption=='" + widgetName + "')].caption");
                        userValues = jsonRead.getJsonValueAsList(Constant.REST_PAYLOAD + filePath, jsonPath);

                        if (actualMetadataValueList.containsAll(userValues) == false) {
                            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Widget name from expected file  " + actualMetadataValueList + "is not present in the UI" + userValues);

                        } else {
                            Assert.fail("Widget items from expected file = " + userValues + "is present in the Analysis item=" + actualMetadataValueList);
                        }
                        break;
                }

                expectedMetadataValueList.clear();
                actualMetadataValueList.clear();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }

    @Given("^user hits request \"([^\"]*)\" with \"([^\"]*)\" and \"([^\"]*)\" using dynamic id from \"([^\"]*)\" using \"([^\"]*)\" and verify \"([^\"]*)\" and \"([^\"]*)\" with \"([^\"]*)\" and store the value \"([^\"]*)\"$")
    public void user_hits_request_with_and_using_dynamic_id_from_using_and_verify_and_with_and_store_the_value(String requestType, String endpoint, String Body, String file, String dynIDPath, String code, String responseValue, String expectedValue, String targetFile) throws Throwable {
        try {
            switch (requestType) {
                case "Put":
                    if (endpoint.contains("DYNID")) {
                        setBodyContent(Body);
                        endpoint = endpoint.replace("DYNID", JsonRead.getJsonValue(Constant.REST_DIR + file, dynIDPath));
                        invokePutRequest(endpoint);
                        status_code_must_be_returned(Integer.parseInt(code));
                    }
                    break;

                case "Get":
                    if (endpoint.contains("DYNID")) {
                        endpoint = endpoint.replace("DYNID", JsonRead.getJsonValue(Constant.REST_DIR + file, dynIDPath));
                        invokeGetRequest(endpoint);
                        status_code_must_be_returned(Integer.parseInt(code));
                        FileUtil.createFileAndWriteData(Constant.REST_PAYLOAD + targetFile, returnRestResponse().toString());
                    }
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            Assert.fail(e.getMessage());
        }

    }


    @And("^user verifies whether below expected values matches with response using json path \"([^\"]*)\"$")
    public void userVerifiesWhetherBelowExpectedValuesMatchesWithResponseUsingJsonPath(String jsonPath, List<CucumberDataSet> jsonValue) throws Throwable {
        List<String> expectedList = new ArrayList<>();
        try {
            for (CucumberDataSet data : jsonValue) {
                expectedList.add(data.getJsonValues());
            }
            Assert.assertTrue((getJsonResponseValuesInList(jsonPath)).equals(expectedList));
            LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Expected values matches with Response" + jsonPath);
        } catch (Exception e) {
            LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Expected values are mismatching with Response");
            Assert.fail("Expected values are mismatching with Response:  " + e.getMessage());
        }
    }


    @Given("^Verify the Processed Count with the API call$")
    public void verify_the_Processed_Count_with_the_API_call(DataTable arg1) throws Throwable {
        initializeRestAPI("IDC");
        int expectedCount = 0;
        Map<String, String> expectedMap = new CucumberDataSet().getProcessedItemMapValues();
        Set expSet = expectedMap.entrySet();
        Iterator i = expSet.iterator();
        while (i.hasNext()) {
            Map.Entry val = (Map.Entry) i.next();
            expectedCount = expectedCount + Integer.valueOf(val.getValue().toString());
        }
        String expectedProcessedCount = String.valueOf(expectedCount);
        Map<String, String> itemViewMap = new TreeMap<>();
        Map<String, String> pluginMap = new TreeMap<>();
        multiHeader(propLoader.prop.getProperty("TestSystemUser"), "application/json", "application/json");
        for (Map<String, String> values : arg1.asMaps(String.class, String.class)) {
            if (!values.get("analysisItemName").isEmpty()) {
                String formedQuery = "SELECT  * from public.items where type='Analysis' and name like '" + values.get("analysisItemName") + "%'  ORDER By  asg_modifiedat DESC LIMIT 1;";
                String sourceId = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "id");
                String sourceType = dbHelper.returnStringValue("APPDBPOSTGRES", formedQuery, "type");
                String url = "components/Default/item/Default." + sourceType + ":::" + sourceId;
                invokeGetRequest(url);
            }

            switch (values.get("Action")) {
                case "ItemViewMap":
                    List<String> itemCount = getJsonResponseValuesInList("$..[?(@.caption=='Processed Items')].data.data.[?(@.type=='" + values.get("type") + "')].id");
                    itemViewMap.put(values.get("type"), String.valueOf(itemCount.size()));
                    break;

                case "VerifyCountInItemView":
                    String actualProcessedCount = getJsonValueUsingJsonPath("$..[?(@.category=='Overview')].data..data..[?(@.caption=='Number of processed items')].data.value");
                    if (expectedProcessedCount.equals(actualProcessedCount)) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Processed Count are matching");
                    } else {
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Processed Count are not matching");
                        Assert.fail("No of Processed count metadata attribute value is not matching in Item View page");
                    }

                    if (expectedMap.entrySet().equals(itemViewMap.entrySet())) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Items count in the Processed Items widget are matching");
                    } else {
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Processed Count for individual items are not matching");
                        Assert.fail("No of Processed count items is not matching in Processed Items widget in Item View page");
                    }
                    break;

                case "VerifyCountInPluginConfig":
                    String nodeName = values.get("node");
                    String configName = values.get("configName");
                    if (nodeName.contains("HeadlessEDI")) {
                        nodeName = nodeName.replaceAll("HeadlessEDI", propLoader.prop.getProperty("clusterHostName"));
                    }
                    String config_url = "extensions/analyzers/all/pluginconfigs";
                    invokeGetRequest(config_url);

                    List<String> keyList = getJsonResponseValuesInList("$..[?(@.nodeName=='" + nodeName + "')]..[?(@.name=='" + configName + "')].typeCounts..itemType");
                    List<String> valuesList = getJsonResponseValuesInList("$..[?(@.nodeName=='" + nodeName + "')]..[?(@.name=='" + configName + "')].typeCounts..count");
                    String actualCount = getJsonValueUsingJsonPath("$..[?(@.nodeName=='" + nodeName + "')]..[?(@.name=='" + configName + "')].totalCount");

                    for (int m = 0; m < keyList.size(); m++) {
                        pluginMap.put(keyList.get(m).trim(), String.valueOf(valuesList.get(m)).trim());
                    }

                    if (expectedProcessedCount.equals(actualCount)) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Processed Count is matching in Plugin Config");
                    } else {
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Processed Count are not matching");
                        Assert.fail("Total data count in the Plugin config are not matching");
                    }

                    if (expectedMap.entrySet().equals(pluginMap.entrySet())) {
                        LoggerUtil.logLoader_info(this.getClass().getSimpleName(), "Individual item Processed Count is matching in Plugin Config");
                    } else {
                        LoggerUtil.logLoader_error(this.getClass().getSimpleName(), "Processed Count for individual items are not matching");
                        Assert.fail("Data count in the Plugin Config are not matching");
                    }
                    break;
            }
        }

    }

}

