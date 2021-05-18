package com.asg.automation.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by muthuraja.ramakrishn on 8/30/2017.
 * This class will holds all constant variables
 * Constant variable use final keyword and capital letter for variable
 * Variable Name must be delimited with underscore between words
 */
public class Constant {

    public static final String UI_CONFIG = "config/UIconfig.properties";
    public static final String IDA_PROP = "config/ida/IDA.properties";
    public static final String IDC_JSONCONFIG = "src/test/resources/testdata/json/IDC.json";
    public static final String EXCEL_PATH = "src/test/resources/testdata/features/querylog/QueryLogTestData.xlsx";
    public static final String FEATURES = "src/test/resources/testdata/features/";
    public static final String TEST_DATA_PATH = "src/test/resources/testdata/";
    public static final String REST_PAYLOAD = "src/test/resources/testdata/rest/payloads/";
    public static final String REST_DIR = "src/test/resources/testdata/rest/";
    public static final String SCREENSHOTS = "src/test/screenshots/";
    public static final String CERTIFICATES = "src/test/resources/testdata/rest/authentication/certificate.jks";
    public static final String CERTIFICATE_PASS = "test1234";
    public static final String NodeFieldNameInAddDataSource = "Node";
    public static final String DOWNLOAD_FILE_PATH = "src/test/resources/testdata/features/datasetdownload/";
    public static final String UPLOAD_FILE_PATH = "src/test/resources/testdata/features/datasetupload/";
    public static final String OSGI_BUNDLES = "src/test/resources/testdata/features/osgibundle/";
    public static final String ANALYSIS_LOG = "src/test/resources/testdata/features/querylog/analyzerLog/";
    public static final String LocalSparkDirectory = System.getProperty("user.home") + "\\Documents\\SparkFolder";
    public static final String LocalSparkDirectory1 = System.getProperty("user.home") + "\\Documents\\SparkFolder\\";
    public static final String LocalDirectory = System.getProperty("user.home") + "\\Documents\\"+CommonUtil.getText();
    // public static final String OSGI_BUNDLES="C:\\Automation\\Rochade GIT Repo\\Repository\\DI_Cucumber_BDD\\src\\test\\resources\\testdata\\features\\osgibundle\\";
    public static final long WAIT_MILLSECS = 3000;
    public static final long WAIT_MILLSECS_EDGE = 5000;
    public static final int WAIT_SECS = 3;
    public static final String HIVEJDBCDRIVER = "org.apache.hive.jdbc.HiveDriver";
    public static final String EXCEL_UPLOAD_PATH = "\\src\\test\\resources\\testdata\\features\\excelupload\\";
    public static final String OSGI_BUNDLES_UPLOAD_PATH = "\\src\\test\\resources\\testdata\\features\\osgibundle\\";
    public static final String PLUGIN_BUNDLES_UPLOAD_PATH = "\\src\\test\\resources\\testdata\\features\\pluginbundle\\";
    public static final  String DIAGRAMMING_IMAGES_PATH="\\src\\test\\resources\\Diagramming_Images\\";
    public static final String SVG_FILES_DOWNLOAD_PATH="src\\test\\resources\\testdata\\features\\svgdownload\\";
    public static final String REPOSISTORY_LOCATION = "\\.m2\\repository\\";
    public static final String LocalDownload = System.getProperty("user.home") + "\\Downloads\\";
    public static final String Excel_DownloadFILE_PATH = "src/test/resources/testdata/features/exceldownload/";
    public static final String EXCEL_DOWNLOAD_PATH = "\\src\\test\\resources\\testdata\\features\\excelDownload\\";
    //JavaParser Constants
    public static final String JAVAPARSER_ERRODETAILS_EXPRESULT ="[{\"lineNumber\":9,\"position\":0,\"errorMsg\":\"no viable alternative at input '@Override\\\\n'\",\"userInfo\":\"no viable alternative at input \",\"name\":\"InvalidJavaFile\"}]";
    public static final String JAVAPARSER_SOURCECODE_EXPRESULT="class SuperClass {\n" +
            "   int z;\n" +
            "   public static final int ERROR_CODE = 127;\n" +
            " \n" +
            "   public void addition(int x, int y) {\n" +
            "      z = x + y;\n" +
            "      System.out.println(\"The sum of the given numbers:\"+z);\n" +
            "   }\n" +
            " \n" +
            "   public void Subtraction(int x, int y) {\n" +
            "      z = x - y;\n" +
            "      System.out.println(\"The difference between the given numbers:\"+z);\n" +
            "   }\n" +
            "}\n" +
            "\n" +
            "public class SubClassWithSuperClass extends SuperClass {\n" +
            "   public void multiplication(int x, int y) {\n" +
            "      z = x * y;\n" +
            "      System.out.println(\"The product of the given numbers:\"+z);\n" +
            "   }\n" +
            " \n" +
            "   public static void main(String args[]) {\n" +
            "      int a = 20, b = 10;\n" +
            "      SubClassWithSuperClass demo = new SubClassWithSuperClass();\n" +
            "      demo.addition(a, b);\n" +
            "      demo.Subtraction(a, b);\n" +
            "      demo.multiplication(a, b);\n" +
            "   }\n" +
            "}";

    //GlueCollector Constants
    public static final String GlueCollector_PythonEXPRESULT="import sys\n" +
            "from awsglue.transforms import *\n" +
            "from awsglue.utils import getResolvedOptions\n" +
            "from pyspark.context import SparkContext\n" +
            "from awsglue.context import GlueContext\n" +
            "from awsglue.job import Job\n" +
            "\n" +
            "## @params: [JOB_NAME]\n" +
            "args = getResolvedOptions(sys.argv, ['JOB_NAME'])\n" +
            "\n" +
            "sc = SparkContext()\n" +
            "glueContext = GlueContext(sc)\n" +
            "spark = glueContext.spark_session\n" +
            "job = Job(glueContext)\n" +
            "job.init(args['JOB_NAME'], args)\n" +
            "## @type: DataSource\n" +
            "## @args: [database = \"spectrumdb\", table_name = \"city1\", transformation_ctx = \"datasource0\"]\n" +
            "## @return: datasource0\n" +
            "## @inputs: []\n" +
            "datasource0 = glueContext.create_dynamic_frame.from_catalog(database = \"spectrumdb\", table_name = \"city1\", transformation_ctx = \"datasource0\")\n" +
            "## @type: ApplyMapping\n" +
            "## @args: [mapping = [(\"id\", \"int\", \"id\", \"int\"), (\"name\", \"string\", \"name\", \"string\"), (\"countrycode\", \"string\", \"countrycode\", \"string\"), (\"district\", \"string\", \"district\", \"string\"), (\"population\", \"int\", \"population\", \"int\")], transformation_ctx = \"applymapping1\"]\n" +
            "## @return: applymapping1\n" +
            "## @inputs: [frame = datasource0]\n" +
            "applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [(\"id\", \"int\", \"id\", \"int\"), (\"name\", \"string\", \"name\", \"string\"), (\"countrycode\", \"string\", \"countrycode\", \"string\"), (\"district\", \"string\", \"district\", \"string\"), (\"population\", \"int\", \"population\", \"int\")], transformation_ctx = \"applymapping1\")\n" +
            "## @type: SelectFields\n" +
            "## @args: [paths = [\"id\", \"name\", \"countrycode\", \"district\", \"population\"], transformation_ctx = \"selectfields2\"]\n" +
            "## @return: selectfields2\n" +
            "## @inputs: [frame = applymapping1]\n" +
            "selectfields2 = SelectFields.apply(frame = applymapping1, paths = [\"id\", \"name\", \"countrycode\", \"district\", \"population\"], transformation_ctx = \"selectfields2\")\n" +
            "## @type: ResolveChoice\n" +
            "## @args: [choice = \"MATCH_CATALOG\", database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"resolvechoice3\"]\n" +
            "## @return: resolvechoice3\n" +
            "## @inputs: [frame = selectfields2]\n" +
            "resolvechoice3 = ResolveChoice.apply(frame = selectfields2, choice = \"MATCH_CATALOG\", database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"resolvechoice3\")\n" +
            "## @type: DataSink\n" +
            "## @args: [database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"datasink4\"]\n" +
            "## @return: datasink4\n" +
            "## @inputs: [frame = resolvechoice3]\n" +
            "datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"datasink4\")\n" +
            "job.commit()";
    public static final String GlueCollector_ScalaEXPRESULT="import sys\n" +
            "from awsglue.transforms import *\n" +
            "from awsglue.utils import getResolvedOptions\n" +
            "from pyspark.context import SparkContext\n" +
            "from awsglue.context import GlueContext\n" +
            "from awsglue.job import Job\n" +
            "\n" +
            "## @params: [JOB_NAME]\n" +
            "args = getResolvedOptions(sys.argv, ['JOB_NAME'])\n" +
            "\n" +
            "sc = SparkContext()\n" +
            "glueContext = GlueContext(sc)\n" +
            "spark = glueContext.spark_session\n" +
            "job = Job(glueContext)\n" +
            "job.init(args['JOB_NAME'], args)\n" +
            "## @type: DataSource\n" +
            "## @args: [database = \"spectrumdb\", table_name = \"city1\", transformation_ctx = \"datasource0\"]\n" +
            "## @return: datasource0\n" +
            "## @inputs: []\n" +
            "datasource0 = glueContext.create_dynamic_frame.from_catalog(database = \"spectrumdb\", table_name = \"city1\", transformation_ctx = \"datasource0\")\n" +
            "## @type: ApplyMapping\n" +
            "## @args: [mapping = [(\"id\", \"int\", \"id\", \"int\"), (\"name\", \"string\", \"name\", \"string\"), (\"countrycode\", \"string\", \"countrycode\", \"string\"), (\"district\", \"string\", \"district\", \"string\"), (\"population\", \"int\", \"population\", \"int\")], transformation_ctx = \"applymapping1\"]\n" +
            "## @return: applymapping1\n" +
            "## @inputs: [frame = datasource0]\n" +
            "applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [(\"id\", \"int\", \"id\", \"int\"), (\"name\", \"string\", \"name\", \"string\"), (\"countrycode\", \"string\", \"countrycode\", \"string\"), (\"district\", \"string\", \"district\", \"string\"), (\"population\", \"int\", \"population\", \"int\")], transformation_ctx = \"applymapping1\")\n" +
            "## @type: SelectFields\n" +
            "## @args: [paths = [\"id\", \"name\", \"countrycode\", \"district\", \"population\"], transformation_ctx = \"selectfields2\"]\n" +
            "## @return: selectfields2\n" +
            "## @inputs: [frame = applymapping1]\n" +
            "selectfields2 = SelectFields.apply(frame = applymapping1, paths = [\"id\", \"name\", \"countrycode\", \"district\", \"population\"], transformation_ctx = \"selectfields2\")\n" +
            "## @type: ResolveChoice\n" +
            "## @args: [choice = \"MATCH_CATALOG\", database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"resolvechoice3\"]\n" +
            "## @return: resolvechoice3\n" +
            "## @inputs: [frame = selectfields2]\n" +
            "resolvechoice3 = ResolveChoice.apply(frame = selectfields2, choice = \"MATCH_CATALOG\", database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"resolvechoice3\")\n" +
            "## @type: DataSink\n" +
            "## @args: [database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"datasink4\"]\n" +
            "## @return: datasink4\n" +
            "## @inputs: [frame = resolvechoice3]\n" +
            "datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = \"spectrumdb\", table_name = \"city\", transformation_ctx = \"datasink4\")\n" +
            "job.commit()";
    public static final String CREATEREPLACEVIEW = "create or replace view \"TEST_SNOWSchemaAuto\".\"CreateReplaceView\" as select * from \"TEST_SNOWSchemaAuto\".\"SCHOOL\";";
    public static final String CREATEVIEWCLASS = "create view \"TEST_SNOWSchemaAuto\".\"CreateViewClass\" as select * from \"TEST_SNOWSchemaAuto\".\"CLASS\";";
    public static final String CREATEVIEWSPECIFIC = "create view \"TEST_SNOWSchemaAuto\".\"CreateViewScholarSpecific\" as select studentid,name from \"TEST_SNOWSchemaAuto\".\"Scholar\";";
    public static final String FORCEVIEW = "create or replace force view \"TEST_SNOWSchemaAuto\".\"ForceView\" as select NAME,AGE from \"TEST_SNOWSchemaAuto\".\"NewCustomers1\" union all select NAME,AGE from \"TEST_SNOWSchemaAuto\".\"NewCustomers2\";";
    public static final String SECUREVIEW = "create or replace secure view \"TEST_SNOWSchemaAuto\".\"SecureView\" comment='Test secure view' as select STUDENTID,NAME from \"TESTSCHEMA\".\"STUDENT\";";
    public static final String JOINVIEW = "create or replace view \"TEST_SNOWSchemaAuto\".\"JoinViews\" as select schoolid,schoolname,name from \"TEST_SNOWSchemaAuto\".\"SCHOOL\" inner join \"TEST_SNOWSchemaAuto\".\"STUDENT\" where SCHOOL.studentid = STUDENT.studentid;";
    public static final String RECURSIVEVIEW = "create recursive view TESTSCHEMA.employee_hierarchy_02 (title, employee_id, manager_id, \"MGR_EMP_ID (SHOULD BE SAME)\", \"MGR TITLE\") as (\n" +
            " -- Start at the top of the hierarchy ...\n" +
            " select title, employee_id, manager_id, null as \"MGR_EMP_ID (SHOULD BE SAME)\", 'President' as \"MGR TITLE\"\n" +
            " from TESTSCHEMA.employees\n" +
            " where title = 'President'\n" +
            " union all\n" +
            " -- ... and work our way down one level at a time.\n" +
            " select employees.title, \n" +
            " employees.employee_id, \n" +
            " employees.manager_id, \n" +
            " employee_hierarchy_02.employee_id as \"MGR_EMP_ID (SHOULD BE SAME)\", \n" +
            " employee_hierarchy_02.title as \"MGR TITLE\"\n" +
            " from TESTSCHEMA.employees inner join employee_hierarchy_02\n" +
            " where employee_hierarchy_02.employee_id = employees.manager_id\n" +
            ");";
    public static final String SNOWFLAKEEXTVIEW ="create or replace view \"TEST_SNOWSchemaAuto\".\"snowflakecsvexttable1view\" as select * from \"TEST_SNOWSchemaAuto\".\"snowflakecsvexttable1\";";
    public static final String CREATEHIVEDATABASE ="create database hivequeryparserdb";
    public static final String DROPHIVEDATABASE ="drop database hivequeryparserdb";
    public static final String SELECTHIVEDATABASE ="select * from hivequeryparserdb.customers";
    public static final String CREATESELECTFROMTABLE1 ="CREATE TABLE hivequeryparserdb.customers1 as select * from hivequeryparserdb.customers";
    public static final String CREATESELECTFROMTABLE2 ="CREATE TABLE hivequeryparserdb.customers(customer_id int,product_id int,product_name varchar(60),brand_name varchar(60))";
    public static final String INSERTSELECTTABLE ="insert into hivequeryparserdb.productstore(store_id,product_id,product_name,store_name) select b.store_id,a.product_id,a.product_name,b.store_name from hivequeryparserdb.product a inner join hivequeryparserdb.store b on a.product_id=b.store_id";
    public static final String INSERTOVERWRITETABLE ="INSERT OVERWRITE TABLE hivequeryparserdb.cust_shop_list select * from hivequeryparserdb.customer_shopping_list";
    public static final String INSERTOVERWRITEDIRECTORY ="INSERT OVERWRITE DIRECTORY 'hivelinker/csv/testcsvfolder' select * from hivequeryparserdb.customer_shopping_list";
    public static final String CREATEEXTERNALTABLE ="CREATE EXTERNAL TABLE IF NOT EXISTS hivequeryparserdb.city (id STRING, name STRING, countrycode STRING, city STRING, population INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE LOCATION 'hdfs://sandbox.hortonworks.com:8020/hivelinkertest/csv/'";


    public static final String PostgressCataloger_DiffDataTypesMinimizedView="CREATE VIEW postgresstestschema.DiffDataTypesMinimizedView AS SELECT \"DiffDataTypesMinimized\".biginttype,\n" +
            " \"DiffDataTypesMinimized\".booleantype,\n" +
            " \"DiffDataTypesMinimized\".charactertype,\n" +
            " \"DiffDataTypesMinimized\".varchartype,\n" +
            " \"DiffDataTypesMinimized\".datetype,\n" +
            " \"DiffDataTypesMinimized\".floattype,\n" +
            " \"DiffDataTypesMinimized\".integertype,\n" +
            " \"DiffDataTypesMinimized\".numerictype,\n" +
            " \"DiffDataTypesMinimized\".realtype,\n" +
            " \"DiffDataTypesMinimized\".smallinttype,\n" +
            " \"DiffDataTypesMinimized\".texttype,\n" +
            " \"DiffDataTypesMinimized\".timetype,\n" +
            " \"DiffDataTypesMinimized\".timetztype,\n" +
            " \"DiffDataTypesMinimized\".timestamptype,\n" +
            " \"DiffDataTypesMinimized\".timestamptztype\n" +
            " FROM postgresstestschema.\"DiffDataTypesMinimized\";";
    public static final String PostgressCataloger_customerviewwithjoin="CREATE VIEW postgresstestschema.customerviewwithjoin AS SELECT cu.customerid AS id,\n" +
            " (((cu.firstname)::text || ' '::text) || (cu.lastname)::text) AS name,\n" +
            " a.address,\n" +
            " a.postalcode AS \"zip code\",\n" +
            " a.phone,\n" +
            " city.city,\n" +
            " country.country,\n" +
            " cu.addressid AS sid\n" +
            " FROM (((postgresstestschema.customer cu\n" +
            " JOIN postgresstestschema.address a USING (addressid))\n" +
            " JOIN postgresstestschema.city USING (cityid))\n" +
            " JOIN postgresstestschema.country USING (countryid));";
    public static final String PostgressCataloger_updatablecityview="CREATE VIEW postgresstestschema.updatablecityview AS SELECT city.city,\n" +
            " city.countryid\n" +
            " FROM postgresstestschema.city\n" +
            " WHERE ((city.cityid)::text = '100'::text);";
    public static final String PostgressCataloger_cityviewwithcheckoption="CREATE VIEW postgresstestschema.cityviewwithcheckoption AS SELECT city.cityid,\n" +
            " city.city,\n" +
            " city.countryid\n" +
            " FROM postgresstestschema.city\n" +
            " WHERE ((city.cityid)::text = '200'::text)\n" +
            " ORDER BY city.city;";
    public static final String PostgressCataloger_childcityview="CREATE VIEW postgresstestschema.childcityview AS SELECT basecityview.cityid,\n" +
            " basecityview.city,\n" +
            " basecityview.countryid\n" +
            " FROM postgresstestschema.basecityview\n" +
            " WHERE ((basecityview.countryid)::text = 'country5'::text);";
    public static final String PostgressCataloger_childcityviewwithlocal="CREATE VIEW postgresstestschema.childcityviewwithlocal AS SELECT basecityview.cityid,\n" +
            " basecityview.city,\n" +
            " basecityview.countryid\n" +
            " FROM postgresstestschema.basecityview\n" +
            " WHERE ((basecityview.countryid)::text = 'country4'::text);";
    public static final String PostgressCataloger_materializedviewwithdata="CREATE MATERIALIZED VIEW postgresstestschema.materializedviewwithdata AS SELECT p1.productname,\n" +
            " sum(p2.percentage) AS percentage,\n" +
            " sum(p1.productid) AS productid\n" +
            " FROM ((postgresstestschema.product p1\n" +
            " JOIN postgresstestschema.sales s1 ON ((p1.productid = s1.productid)))\n" +
            " JOIN postgresstestschema.profit p2 ON ((p1.productid = p2.productid)))\n" +
            " GROUP BY p1.productname\n" +
            " ORDER BY (sum(p2.percentage)) DESC;";
    public static final String PostgressCataloger_managertreerecursive="CREATE VIEW postgresstestschema.managertreerecursive AS WITH RECURSIVE managertreerecursive(id, name) AS (\n" +
            " SELECT employees.id,\n" +
            " employees.name,\n" +
            " employees.manager_id\n" +
            " FROM employees\n" +
            " WHERE (employees.id = 2)\n" +
            " UNION ALL\n" +
            " SELECT e.id,\n" +
            " e.name,\n" +
            " e.manager_id\n" +
            " FROM (employees e\n" +
            " JOIN managertreerecursive mtree ON ((mtree.id = e.manager_id)))\n" +
            " )\n" +
            " SELECT managertreerecursive.id,\n" +
            " managertreerecursive.name,\n" +
            " managertreerecursive.manager_id\n" +
            " FROM managertreerecursive;";
    // PythonParser Constants
    public static final String METHODCOMMENT = "# init method or constructor";
    public static final String CLASSCOMMENT = "# both objects have different self which # contain their attributes # same output as car.show(audi) # same output as car.show(ferrari) # Behind the scene, in every instance method # call, python sends the instances also with # that method call like car.show(audi)";
    public static final String SUPERCLASSESEXPRESULT = "[{\"superClass\":\"Child1\",\"start\":{\"lineNumber\":1,\"position\":13}}]";
    public static final String STATICVARIABLEEXPRESULT = "[{\"start\":{\"lineNumber\":2,\"position\":3},\"staticVar\":\"parentAttr=100\"}]";
    public static final String CONSTANTSTRINGSEXPRESULT = "[{\"startLine\":4,\"endLine\":4,\"startColumn\":6,\"endColumn\":12,\"conString\":\"abc=hai\"}]";
    public static final String RAWINVOKESEXPRESULT = "[{\"startLine\":5,\"endLine\":5,\"startColumn\":6,\"endColumn\":55,\"methodName\":\"print\",\"argumentNb\":3},{\"startLine\":6,\"endLine\":6,\"startColumn\":13,\"endColumn\":19,\"methodName\":\"m1\",\"argumentNb\":2},{\"startLine\":0,\"endLine\":0,\"startColumn\":0,\"endColumn\":0,\"methodName\":null,\"argumentNb\":2},{\"startLine\":8,\"endLine\":8,\"startColumn\":14,\"endColumn\":30,\"methodName\":\"m3\",\"argumentNb\":2},{\"startLine\":8,\"endLine\":8,\"startColumn\":21,\"endColumn\":29,\"methodName\":\"fun2\",\"argumentNb\":2},{\"startLine\":9,\"endLine\":9,\"startColumn\":14,\"endColumn\":38,\"methodName\":\"m4\",\"argumentNb\":2},{\"startLine\":9,\"endLine\":9,\"startColumn\":17,\"endColumn\":25,\"methodName\":\"fun3\",\"argumentNb\":2},{\"startLine\":9,\"endLine\":9,\"startColumn\":29,\"endColumn\":37,\"methodName\":\"fun2\",\"argumentNb\":2}]";
    public static final String ERRORDETAILSEXPRESULT = "[{\"lineNumber\":1,\"position\":4,\"errorMsg\":\"missing ':' at ' '\",\"userInfo\":\"missing \",\"name\":\"error\"},{\"lineNumber\":5,\"position\":6,\"errorMsg\":\"extraneous input '\\\\t\\\\t ' expecting {'def', 'return', 'raise', 'from', 'import', 'global', 'nonlocal', 'assert', 'if', 'while', 'for', 'try', 'with', 'lambda', 'not', 'None', 'True', 'False', 'class', 'yield', 'del', 'pass', 'continue', 'break', 'async', 'await', NAME, STRING_LITERAL, BYTES_LITERAL, UNSIGNED_INTEGER, DECIMAL_INTEGER, OCT_INTEGER, HEX_INTEGER, BIN_INTEGER, FLOAT_NUMBER, IMAG_NUMBER, '...', '*', '(', '[', '+', '-', '~', '{', '@', DEDENT}\",\"userInfo\":\"extraneous input \",\"name\":\"error\"},{\"lineNumber\":5,\"position\":24,\"errorMsg\":\"extraneous input ')' expecting {<EOF>, 'def', 'return', 'raise', 'from', 'import', 'global', 'nonlocal', 'assert', 'if', 'while', 'for', 'try', 'with', 'lambda', 'not', 'None', 'True', 'False', 'class', 'yield', 'del', 'pass', 'continue', 'break', 'async', 'await', NEWLINE, NAME, STRING_LITERAL, BYTES_LITERAL, UNSIGNED_INTEGER, DECIMAL_INTEGER, OCT_INTEGER, HEX_INTEGER, BIN_INTEGER, FLOAT_NUMBER, IMAG_NUMBER, '...', '*', '(', '[', '+', '-', '~', '{', '@'}\",\"userInfo\":\"extraneous input \",\"name\":\"error\"}]";
    public static final String ERRORDETAILSFORPYTHONEXPRESULT = "[]";
    public static final String JUNKCHARACTERSEXPRESULT = "import tensorflow as tf\n" +
            "class sample2():\n" +
            " def test1(self):\n" +
            " print(\"print for import from sample2 class\") \n" +
            " def testtf(self):\n" +
            " static_value_shape = self.get_value_shape()\n" +
            " return tf.convert_to_tensor(static_value_shape, dtype=tf.int32)\n" +
            " def get_value_shape(self):\n" +
            " return 10";
    public static final String RAWIMPORTSEXPRESULT = "[{\"name\":\"dag\",\"start\":{\"lineNumber\":7,\"position\":7},\"stop\":{\"lineNumber\":7,\"position\":10}},{\"name\":\"datetime\",\"start\":{\"lineNumber\":8,\"position\":7},\"stop\":{\"lineNumber\":8,\"position\":15}},{\"name\":\"ops.sample.config.env.sampleEnv\",\"start\":{\"lineNumber\":9,\"position\":7},\"stop\":{\"lineNumber\":9,\"position\":45}},{\"name\":\"ops.sample.utils.tools.nextUid\",\"start\":{\"lineNumber\":10,\"position\":7},\"stop\":{\"lineNumber\":10,\"position\":44}},{\"name\":\"pytz\",\"start\":{\"lineNumber\":11,\"position\":7},\"stop\":{\"lineNumber\":11,\"position\":11}},{\"name\":\"qz.core.enum.Enum\",\"start\":{\"lineNumber\":12,\"position\":7},\"stop\":{\"lineNumber\":12,\"position\":31}},{\"name\":\"qz.lib.xdate.datetimeToTimestamp\",\"start\":{\"lineNumber\":13,\"position\":7},\"stop\":{\"lineNumber\":13,\"position\":46}},{\"name\":\"sandra\",\"start\":{\"lineNumber\":14,\"position\":7},\"stop\":{\"lineNumber\":14,\"position\":13}},{\"name\":\"traceback\",\"start\":{\"lineNumber\":15,\"position\":7},\"stop\":{\"lineNumber\":15,\"position\":16}}]";
    public static final String EXTERNALIMPORT = "[{\"name\":\"tensorflow\",\"alias\":\"tf\",\"start\":{\"lineNumber\":1,\"position\":0},\"stop\":{\"lineNumber\":1,\"position\":21},\"resolved\":[]}]";
    public static final String IMPORTCOUNTEXPRESULT = "4";
    public static final String RAWIMPORTSEXPRESULTPARSER="[{\"name\":\"draw\",\"start\":{\"lineNumber\":1,\"position\":0},\"stop\":{\"lineNumber\":1,\"position\":13},\"resolved\":[]},{\"name\":\"circle\",\"start\":{\"lineNumber\":1,\"position\":0},\"stop\":{\"lineNumber\":1,\"position\":13},\"resolved\":[]},{\"name\":\"moduletest.ageofqueen\",\"start\":{\"lineNumber\":2,\"position\":0},\"stop\":{\"lineNumber\":2,\"position\":23},\"resolved\":[]},{\"name\":\"moduletest.printhello\",\"start\":{\"lineNumber\":3,\"position\":0},\"stop\":{\"lineNumber\":3,\"position\":23},\"resolved\":[]}]";
    public static final String PYHTONTEMPLOG = "src\\test\\resources\\testdata\\features\\pythonParser\\pythonLog.txt";
    public static final String PYTHONLOGEXPECTEDRESULT = "src\\test\\resources\\testdata\\features\\pythonParser\\pythonLogExpectedResult.txt";
    public static final String PYTHONLOGACTUALRESULT = "src\\test\\resources\\testdata\\features\\pythonParser\\pythonLogActualResult.txt";
    public static final String PYTHONFILENOTEBOOK = "src\\test\\resources\\testdata\\features\\notebook\\pythonFile.txt";
    public static final String DYNAMIC_FIELD_INPUT_TEXT = "Dynamic field should be displayed based on the content vertical/horizontal scroll will be seen";
    public static final String START_HBASE = "hbase-daemon.sh start rest -p 2100";
    public static final String STOP_HBASE = "hbase-daemon.sh stop rest -p 2100";

    public static final String SOLRSEARCH_FOR_CLUSTER_DEMO = "name_s:\"Cluster Demo\" and type_s:\"Cluster\" and !type_s:(\"Column\",\"SourceTree\", \"Function\",\"Class\",\"DataPackage\")";
    // Query Parser Log Entries
    public static final String HiveMonitorStopPluginMessage = "INFO  com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: ANALYSIS-0020: Plugin ending work";
    public static final String HdfsMonitorStopPluginMessage = "INFO  com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HdfsMonitor indicated: ANALYSIS-0020: Plugin ending work";
    public static final String HiveMonitorRunningMessage = "INFO  com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: ANALYSIS-0019: Plugin starting work";
    public static final String HdfsMonitorRunningMessage = "INFO  com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HdfsCataloger indicated: ANALYSIS-0019: Plugin started";
    // Hive Cataloger Log Entries
    public static final String HiveCatalogerScanInitiated = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0018: Get scan request message, starting scan process with filtering settings: [hivesample],[default]";
    public static final String HiveCatalogerTagsScannedEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-COMMON-0002: Filtered databases that will be scanned: {default=[HiveTag2], hivesample=[HiveTag1]}";
    public static final String HiveCatalogerDatabaseScanEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0003: Scanning default database.";
    public static final String HiveCatalogerDatabaseRetrivalEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0021: Start retrieving all tables of database default.";
    public static final String HiveCatalogerTableScanEntry1 = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0016: Scanning table sample_07 of the default database.";
    public static final String HiveCatalogerFieldSchemaEntry1 = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0014: Columns of current table are: [FieldSchema(name:code, type:string, comment:null), FieldSchema(name:description, type:string, comment:null), FieldSchema(name:total_emp, type:int, comment:null), FieldSchema(name:salary, type:int, comment:null)].";
    public static final String HiveCatalogerTableScanEntry2 = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0016: Scanning table sample_08 of the default database.";
    public static final String HiveCatalogerFieldSchemaEntry2 = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0014: Columns of current table are: [FieldSchema(name:code, type:string, comment:null), FieldSchema(name:description, type:string, comment:null), FieldSchema(name:total_emp, type:int, comment:null), FieldSchema(name:salary, type:int, comment:null)].";
    public static final String HiveCatalogertoDataAnalyzerEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0017: Publishing scan results to DataAnalyzer.";
    public static final String HiveCatalogerDataAnalyzerStartedEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin dataanalyzer/BigDataAnalyzer indicated: ANALYSIS-0019: Plugin starting work";
    public static final String HiveCatalogerDataAnalyzerStartedConfirmation = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin dataanalyzer/BigDataAnalyzer indicated: BIGDATA-ANALYZER-0003: -----------DATA ANALYZER START-------------";
    public static final String HiveCatalogerNoDatabaseEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0022: CatalogHive didn't scan any databases based on current filter settings.";
    public static final String HiveCatalogerDataBaseWithNoTables = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0018: Get scan request message, starting scan process with filtering settings: [databasewithnotables]";
    public static final String HiveCatalogerBDAnalyzer = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HiveCataloger indicated: CATALOG-HIVE-0016: Scanning table BDATest of the default database";
    //HiveMonitor Log Entries
    public static final String HiveMonitorState = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0015: Started monitor in idle mode";
    public static final String HiveMonitorDeltaTimeEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0014: Starting Hive changes monitor with monitoring interval 5 second(s)";
    public static final String HiveMonitorDatabaseFilterEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0006: Monitor event database hivemonitordb matched the filter.";
    public static final String HiveMonitorChangeEntry = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0006: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0016: Monitor event table zone_east is added to list of items that should be scanned.";
    public static final String HiveMonitorScanKickOff = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0003: Monitor event database hivemonitordb is added to list of items that should be scanned.";
    public static final String HiveMonitortoScannerMessage = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0012: Sending collection with Hive event changes to Scanner.";
    public static final String HiveMonitorClearEvent = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HiveMonitor indicated: MONITOR-HIVE-0002: Clear event folder...";
    public static final String[] SAMPLE08COLUMNS = {"total_emp", "desciption", "code", "salary"};

    // Query Parser Table and their columns
    public static final ArrayList<String> getSample08Columns = new ArrayList<>(Arrays.asList(SAMPLE08COLUMNS));
    // Hdfs Cataloger Log Entries
    public static final String HdfsCatalogerScanInitiated = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HdfsCataloger indicated: CATALOG-HDFS-0054: Got scan request message, starting scanner for [/HDFSMonitor_Test/NewFolder]";
    public static final String HdfsCatalogerScanMessage = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HdfsCataloger indicated: CATALOG-HDFS-0054: Got scan request message, starting scanner for [/idcautomation]";
    public static final String HdfsMonitorScanInitiated = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HdfsMonitor indicated: MONITOR-HDFS-0008: Change detected in HDFS directory /idaautomation/subfolder/scanHdfsTestdata.csv, rescan scheduled";
    public static final String HdfsMonitorScanInitiatedForDireRename = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HdfsMonitor indicated: MONITOR-HDFS-0008: Change detected in HDFS directory /idaautomation/subfolder, rescan scheduled";
    public static final String HdfsMonitorScanInitiatedForExclsnFilter = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin monitor/HdfsMonitor indicated: CATALOG-HDFS-0054: Got scan request message, starting scanner for [/exclusionFilter]";
    public static final String HdfsCatalogerErrorMessageForInvalidDir = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0004: Plugin cataloger/HdfsCataloger reported a warning: CATALOG-HDFS-0067: Failed accessing file/directory /invalidFolder. Probably it was deleted from the cluster";
    public static final String HdfsCatalogerErrorMessageForMultiDirs = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HdfsCataloger indicated: CATALOG-HDFS-0054: Got scan request message, starting scanner for [/multipleDir]";
    public static final String HdfsCatalogerFinishedMessage = "com.asg.dis.analysis.common.BaseAnalysisAPI - ANALYSIS-0005: Plugin cataloger/HdfsCataloger indicated: CATALOG-HDFS-0056: Scanning Cluster Demo finished, returning to idle mode";
    public static String[] xademoTable = {"recharge_details", "customer_details"};
    public static ArrayList<String> getXademoTables = new ArrayList<>(Arrays.asList(xademoTable));
    public static String[] recharge_details_Columns = {"amount", "phone_number", "rec_date", "plan", "channel"};
    public static ArrayList<String> getRecharge_details_Columns = new ArrayList<>(Arrays.asList(recharge_details_Columns));
    public static String[] foodmartTable = {"inventory_fact_1998", "product", "store", "sales_fact_dec_1998", "customer", "customer_shopping_list"};
    public static ArrayList<String> getFoodmartTables = new ArrayList<>(Arrays.asList(foodmartTable));
    public static String[] customer_shopping_list_Columns = {"product_name", "brand_name", "customer_id", "product_id"};
    public static ArrayList<String> getCustomer_shopping_list_Columns = new ArrayList<>(Arrays.asList(customer_shopping_list_Columns));
    public static String[] defaultTable = {"ice_supply", "sample_08", "sample_07", "cus_shop_list"};
    public static ArrayList<String> getDefaultTables = new ArrayList<>(Arrays.asList(defaultTable));
    public static String[] cus_shop_list_Columns = {"product_name", "brand_name", "customer_id", "product_id"};
    public static ArrayList<String> getCus_shop_list_Columns = new ArrayList<>(Arrays.asList(cus_shop_list_Columns));
    public static String[] insertOverWriteDirectory = {"employees", "user/totalCommerce/testcsvfolder"};
    public static ArrayList<String> getInsertOverWriteDirectory = new ArrayList<>(Arrays.asList(insertOverWriteDirectory));
    public static String[] insertOverWriteDirectoryLineageTo = {"user/totalCommerce/testcsvfolder"};
    public static ArrayList<String> getInsertOverWriteDirectoryTo = new ArrayList<>(Arrays.asList(insertOverWriteDirectoryLineageTo));
    public static String[] insertOverWriteDirectoryLineageFrom = {"employees"};
    public static ArrayList<String> getInsertOverWriteDirectoryFrom = new ArrayList<>(Arrays.asList(insertOverWriteDirectoryLineageFrom));
    public static String[] insertOverWriteTable = {"product_name", "product_name", "product_id", "product_id", "brand_name", "brand_name", "customer_id", "customer_id"};
    public static ArrayList<String> getInsertOverWriteTable = new ArrayList<>(Arrays.asList(insertOverWriteTable));
    public static String[] insertOverWriteTableLineageTo = {"product_name"};
    public static ArrayList<String> getInsertOverWriteTableTo = new ArrayList<>(Arrays.asList(insertOverWriteTableLineageTo));
    public static String[] insertOverWriteTableLineageFrom = {"product_name"};
    public static ArrayList<String> getInsertOverWriteTableFrom = new ArrayList<>(Arrays.asList(insertOverWriteTableLineageFrom));
    public static String[] insertInto = {"product", "sales_fact_dec_1998", "customer_shopping_list"};
    public static ArrayList<String> getInsertInto = new ArrayList<>(Arrays.asList(insertInto));
    public static String[] insertIntoLineageTo = {"customer_shopping_list"};
    public static ArrayList<String> getInsertIntoLineageTo = new ArrayList<>(Arrays.asList(insertIntoLineageTo));
    public static String[] insertIntoLineageFrom = {"product"};
    public static ArrayList<String> getInsertIntoLineageFrom = new ArrayList<>(Arrays.asList(insertIntoLineageFrom));
    public static String[] hivesampleTable = {"sales_fact", "zone_west"};
    public static ArrayList<String> getHiveSampleTable = new ArrayList<>(Arrays.asList(hivesampleTable));
    public static String[] sales_fact_Columns = {"unit_sales", "promotion_id", "store_cost", "customer_id", "time_id", "store_id", "store_sales", "product_id"};
    public static ArrayList<String> getSales_Fact_Columns = new ArrayList<>(Arrays.asList(sales_fact_Columns));
    public static String[] healthCareTable_TriggeredByHiveMonitor = {"measuresofbirthanddeath", "preventiveservicesuse", "summarymeasuresofhealth", "defineddatavalue", "relativehealthimportance", "riskfactorsandaccesstocare", "vunerablepopsandenvhealth", "leadingcausesofdeath", "demographics", "zone_east"};
    public static ArrayList<String> getHealthCareTable_TriggeredByHiveMonitor = new ArrayList<>(Arrays.asList(healthCareTable_TriggeredByHiveMonitor));
    public static String[] zone_east_Columns_TriggeredByHiveMonitor = {"store_name", "dept_name", "emp_id", "dep_id"};
    public static ArrayList<String> getZone_East_Columns_TriggeredByHiveMonitor = new ArrayList<>(Arrays.asList(zone_east_Columns_TriggeredByHiveMonitor));
    public static String[] sample_08_Columns={"total_emp","desciption","code","salary"};
    public static ArrayList<String> getSample_08_Columns = new ArrayList<>(Arrays.asList(sample_08_Columns));
    public static final String DATE_TIME_REGEX = "([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9].[0-9]{3})";
    public static final String TIME_REGEX = "(: [0-5][0-9]:[0-5][0-9]:[0-5][0-9].[0-9]{3})";
    public static final String DATE_TIME_REGEX_TZ_PATTERN = "([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9].[0-9]{6})";
    public static final String DATE_TIME_REGEX_TZ_PATTERN4 = "([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9].[0-9]{4})";
    public static final String DATE_TIME_REGEX_TZ_PATTERN3 = "([0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])T(2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9].[0-9]{3})";

    public static List<String> hiveMetaStoreData(String input) {
        List<String> output = null;
        switch (input) {
            case "xademoTables":
                output = getXademoTables;
                break;
            case "defaultTables":
                output = getDefaultTables;
                break;
            case "foodmartTables":
                output = getFoodmartTables;
                break;
            case "recharge_details_Columns":
                output = getRecharge_details_Columns;
                break;
            case "customer_shopping_list_Columns":
                output = getCustomer_shopping_list_Columns;
                break;
            case "cus_shop_list_Columns":
                output = getCus_shop_list_Columns;
                break;
            case "InsertOverwriteDirectory":
                output = getInsertOverWriteDirectory;
                break;
            case "InsertOverwriteDirectoryLineageTo":
                output = getInsertOverWriteDirectoryTo;
                break;
            case "InsertOverwriteDirectoryLineageFrom":
                output = getInsertOverWriteDirectoryFrom;
                break;
            case "InsertOverwriteTable":
                output = getInsertOverWriteTable;
                break;
            case "InsertOverwriteTableLineageTo":
                output = getInsertOverWriteTableTo;
                break;
            case "InsertOverwriteTableLineageFrom":
                output = getInsertOverWriteTableFrom;
                break;
            case "InsertInto":
                output = getInsertInto;
                break;
            case "InsertIntoLineageTo":
                output = getInsertIntoLineageTo;
                break;
            case "InsertIntoLineageFrom":
                output = getInsertIntoLineageFrom;
                break;
            case "hivesampleTables":
                output = getHiveSampleTable;
                break;
            case "sales_fact_Columns":
                output = getSales_Fact_Columns;
                break;
            case "healthCareTables_AfterHiveMonitor":
                output = getHealthCareTable_TriggeredByHiveMonitor;
                break;
            case "zone_east_Columns":
                output = getZone_East_Columns_TriggeredByHiveMonitor;
                break;
            default:
                break;

        }
        return output;
    }

    public static String shellCommand(String command) {

        switch (command) {
            case "START_HBASE":
                command = START_HBASE;
                break;
            case "STOP_HBASE":
                command = STOP_HBASE;
                break;
        }
        return command;
    }

    public static String shellCommandtorunspark(String command, String remoteName, String remotepath,String pythonFile) {

        switch (command) {

            case "SPARK2":
                command = "export SPARK_MAJOR_VERSION=2 && spark-submit --version && spark-submit "+ pythonFile +"";
                break;
            case "Spark2_Local":
                command = "cmd.exe /c cd " + System.getProperty("user.home") + "\\Documents\\SparkFolder && spark-submit " + pythonFile + "";
                break;
            case "Spark2_Remote":
                command = "psexec "+remoteName+" cmd.exe /k cd "+remotepath+" && spark-submit " + pythonFile + "";
                break;
            case "JavaSpark2_Remote":
                command = "cmd /c cd C:\\spark-2.4.3-bin-hadoop2.7 && .\\bin\\spark-submit --class " + pythonFile + "";
                break;
            case "LFC":
                command = "sudo docker cp /home/becubic_build@asg.com/LCL " + pythonFile + ":/lfc_testfiles";
                break;
            case "ClearFileinUnix":
                command = "cd " + remotepath + " && > " + pythonFile;
                break;

        }
        return command;
    }


    //Joins Query for retrieving Hive Columns Or HDFS fields from Postgres

    public static final String getHiveOrHdfsQuery(String service, String databaseOrDirectory, String tableOrFile, String columnOrField) {
        String query = null;
        if (service.equalsIgnoreCase("Hive")) {
            query = "select \"bdvc9\".* from \"BigData\".\"V_Cluster\" bdvc1 join \"BigData\".\"E_has_Service\" bdvc2 on \"bdvc1\".\"ID\"=\"bdvc2\".\"BigData.Cluster__O\"\n" +
                    "                                                                    join \"BigData\".\"V_Service\" bdvc3 on \"bdvc2\".\"BigData.Service__I\"=\"bdvc3\".\"ID\"\n" +
                    "                                                                    join \"BigData\".\"E_has_Database\" bdvc4 on \"bdvc3\".\"ID\"=bdvc4.\"BigData.Service__O\"\n" +
                    "                                                                    join \"BigData\".\"V_Database\" bdvc5 on \"bdvc5\".\"ID\"=bdvc4.\"BigData.Database__I\"\n" +
                    "                                                                    join \"BigData\".\"E_has_Table\" bdvc6 on \"bdvc5\".\"ID\"=\"bdvc6\".\"BigData.Database__O\"\n" +
                    "                                                                    join \"BigData\".\"V_Table\" bdvc7 on \"bdvc6\".\"BigData.Table__I\"=\"bdvc7\".\"ID\"\n" +
                    "                                                                    join \"BigData\".\"E_has_Column\" bdvc8 on \"bdvc8\".\"BigData.Table__O\"=\"bdvc7\".\"ID\"\n" +
                    "                                                                    join \"BigData\".\"V_Column\" bdvc9 on \"bdvc8\".\"BigData.Column__I\"=\"bdvc9\".\"ID\"\n" +
                    "where \"bdvc1\".\"name\" like 'Cluster Demo' and \"bdvc3\".\"name\" like 'HIVE' and \"bdvc5\".\"name\" like '" + databaseOrDirectory + "' and  \"bdvc7\".\"name\" like '" + tableOrFile + "' and \"bdvc9\".\"name\" like '" + columnOrField + "';";

        } else if (service.equalsIgnoreCase("Hdfs")) {
            query = "select \"bdvc10\".* from \"BigData\".\"V_Directory\" bdvc6 \n" +
                    "                                                                 join \"BigData\".\"E_has_File\" bdvc7 on \"bdvc6\".\"ID\"=\"bdvc7\".\"BigData.Directory__O\"\n" +
                    "                                                                 join \"BigData\".\"V_File\" bdvc8 on \"bdvc7\".\"BigData.File__I\"=\"bdvc8\".\"ID\"\n" +
                    "                                                                 join \"BigData\".\"E_has_Field\" bdvc9 on \"bdvc9\".\"BigData.File__O\"=\"bdvc8\".\"ID\"\n" +
                    "                                                                 join \"BigData\".\"V_Field\" bdvc10 on \"bdvc9\".\"BigData.Field__I\"=\"bdvc10\".\"ID\"\n" +
                    "where \"bdvc6\".\"asg.scopeId\" like '%%' and \"bdvc6\".\"name\" like '" + databaseOrDirectory + "' and \"bdvc8\".\"name\" like '" + tableOrFile + "' and \"bdvc10\".\"name\" like '" + columnOrField + "';";
        }
        return query;
    }

    public static final String firstHdfsQuery = "select \"bdvc5\".\"ID\" from \"BigData\".\"V_Cluster\" bdvc1 join \"BigData\".\"E_has_Service\" bdvc2 on \"bdvc1\".\"ID\"=\"bdvc2\".\"BigData.Cluster__O\"\n" +
            "                                                                 join \"BigData\".\"V_Service\" bdvc3 on \"bdvc2\".\"BigData.Service__I\"=\"bdvc3\".\"ID\"\n" +
            "                                                                 join \"BigData\".\"E_has_Directory\" bdvc4 on \"bdvc3\".\"ID\"=bdvc4.\"BigData.Service__O\"\n" +
            "                                                                 join \"BigData\".\"V_Directory\" bdvc5 on \"bdvc5\".\"ID\"=bdvc4.\"BigData.Directory__I\"\n" +
            "where \"bdvc1\".\"name\" like 'Cluster Demo' and \"bdvc3\".\"name\" like 'HDFS' and \"bdvc5\".\"name\" like 'ROOT'";


    //Neo4j Constants
    public static final String readNeo4jComponents = "CALL dbms.components";
    public static final String readAllNodeCount = "MATCH (n) RETURN  count(labels(n))";
    public static final String readTotalRelationshipCount = "MATCH ()-[r]->() RETURN count(*)";
    public static final String minCountofRelationship = "MATCH (n) RETURN min(size((n)-[]-() ))";
    public static final String maxCountofRelationship = "MATCH (n) RETURN max(size((n)-[]-() ))";
    public static final String readAverageCountOfRelationships = "MATCH (n) RETURN avg(size((n)-[]-() ))";
    public static final String readPropertyDataType ="CALL db.schema.nodeTypeProperties";
    public static final String getAllIndexes = "CALL db.indexes()";
    public static final String getLabelpts =  "match (n:player) return properties(n)";
    public static final String readStoreFileSizes = "call dbms.queryJmx(\"org.neo4j:instance=kernel#0,name=Store file sizes\") yield attributes\r\n"
            + "       with  keys(attributes) as k , attributes\r\n" + "       unwind k as row\r\n"
            + "       return row,attributes[row][\"value\"]";
    public static final String readCountOfNodesForSingleLabel (String nodeName){
        String query = "MATCH (n) WHERE n:" + nodeName + " RETURN count(*)";
        return query;
    }
    public static final String readCountOfOutgoingRelationshipsForSingleLabel (String labelName){
        String query = "MATCH (n:" + labelName + ")-[r]->() RETURN COUNT(r)";
        return query;
    }
    public static final String readCountOfIncomingRelationshipsForSingleLabel (String labelName){
        String query = "MATCH (n:" + labelName + ")<-[r]-() RETURN COUNT(r)";
        return query;
    }
    public static final String readMinCountOfNodeProperties(String nodeName){
        String query = "MATCH (n:" + nodeName + ") RETURN min(size(keys(n)))";
        return query;
    }
    public static final String readMaxCountOfNodeProperties(String nodeName){
        String query = "MATCH (n:" + nodeName + ") RETURN max(size(keys(n)))";
        return query;
    }
    public static final String readAvgCountOfNodeProperties(String nodeName){
        String query ="MATCH (n:" + nodeName + ") RETURN avg(size(keys(n)))";
        return query;
    }
    public static final String readCountOfLabelProperties(String labelName){
        String query="match (n:" + labelName + ") return max(size(keys(n)))";
        return query;
    }
}
