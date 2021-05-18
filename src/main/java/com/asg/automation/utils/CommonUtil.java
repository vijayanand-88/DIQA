package com.asg.automation.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonParser;
import com.jayway.jsonpath.PathNotFoundException;
import com.mongodb.util.Hash;
import net.sf.json.test.JSONAssert;
import org.apache.commons.codec.binary.Base64;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.skyscreamer.jsonassert.JSONCompareMode;
import org.testng.Assert;

import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.*;
import java.util.logging.Logger;

/**
 * Created by muthuraja.ramakrishn on 7/7/2017.
 */
public class CommonUtil {
    public Random random;
    public static int randomNum;
    public static int randomNo;
    public static int randomRate;
    public static PropertyLoader proploader;
    public static FileOutputStream fileOutputStream = null;
    public static List<String> tempList;
    public static HashMap<String, String> tempHashMap = new HashMap<>();
    public static HashMap<String, List<String>> tempSingleKeyMultipleValueList = new HashMap<>();
    public static String temp;
    public static String tempvar;
    public Float floatNum;
    public static List<String> tempElementList = new ArrayList<>();
    public List<Integer> randomList = new ArrayList<>();
    private static final Logger LOG = Logger.getLogger(Actions.class.getName());
    public static List<String> booleanArray = new ArrayList<String>();



    public CommonUtil() {
        propertyLoader();
    }

    //To return random no from 1 to 10 when each time call this method
    public int randomint(int min, int max) {
        random = new Random();
        randomNum = random.nextInt(max - min) + min;
        return randomNum;
    }

    //To return random no without repetition
    public int random(int min, int max) {
        random = new Random();
        do {
            randomNo = random.nextInt(max - min) + 1;

        } while (randomList.contains(randomNo));
        randomList.add(randomNo);
        return randomNo;
    }

    //Return random number based on user needs
    public int randomRating() {
        random = new Random();
        randomRate = random.nextInt(5 - 1) + 1;
        return randomRate;
    }

    public void propertyLoader() {
        proploader = new PropertyLoader();
        proploader.loadProperty();
    }

    public String returnSchema() {
        String schemaName = null;
        schemaName = proploader.prop.getProperty("schemaname");
        return schemaName;
    }

    public String returnTableName() {
        String tableName = null;
        tableName = proploader.prop.getProperty("tablename");
        return tableName;
    }


    public String getNUMfromString(String text) {
        String CharSpecialChar;
        CharSpecialChar = text.replaceAll("[^0-9.]", "");
        return CharSpecialChar;
    }

    //To get only numbers from a dynamic Item ID without a period .
    public String getOnlyNUMfromString(String text) {
        String CharSpecialChar;
        CharSpecialChar = text.replaceAll("[^0-9]", "");
        return CharSpecialChar;
    }

    public String getExactNumfromUISearchResults(String text) {
        String exactSearchValue = null;
        try {
            int startIndex = text.indexOf("Select all");
            exactSearchValue = text.substring(0, startIndex).trim();
        }
        catch (Exception ex) {
            Assert.fail("Search Results are not retrieved from UI");
        }
        return exactSearchValue;
    }

    public String getExactNumfromResultsFound(String text,String nameinText) {
        String exactSearchValue = null;
        try {
            int startIndex = text.indexOf(nameinText);
            exactSearchValue = text.substring(0, startIndex).trim();
        } catch (Exception ex) {
            Assert.fail("Search Results are not retrieved from UI");
        }
        return exactSearchValue;
    }

    public static void storeTemporaryList(List<String> list) {
        tempList = list;
    }

    public static List<String> getTemporaryList() {
        return tempList;
    }


    public static void addElementsInList(String element) {

        tempElementList.add(element);
    }

    public static List<String> getElementsInList() {

        return tempElementList;
    }

    public static void addToTemporaryHashMap(String key, String value) {
        tempHashMap.put(key, value);
    }

    public static void addToTemporaryHashMap(String key, List<String> value) {
        tempSingleKeyMultipleValueList.put(key, value);
    }

    public static String getValueFromTempHashMap(String key) {
        return tempHashMap.get(key);
    }

    public static HashMap<String, String> getTempHashMap() {
        return tempHashMap;
    }

    public static HashMap<String, List<String>> gettempSingleKeyMultipleValueList() {
        return tempSingleKeyMultipleValueList;
    }

    public static List<String> getValueListFromTempHashMap(String key) {
        return tempSingleKeyMultipleValueList.get(key);
    }

    /**
     * Method Name : storeTemporaryText
     * Description : Storing run time information into temp variable
     */
    public void storeTemporaryText(String text) {
        temp = text;
    }

    /**
     * Method Name : getTemporaryText
     * Description : Getting run time information from temp variable
     */
    public static String getTemporaryText() {
        return temp;
    }

    /**
     * @param text store text dynamic values during run time
     */
    public static void storeText(String text) {
        tempvar = text;
    }

    /**
     * getText get the dynamic value stored in storeText function
     *
     * @return
     */
    public static String getText() {
        return tempvar;
    }

    public static String getElementTextwithouttrim(WebElement webElement) {
        String text;
        text = webElement.getText().replaceAll("[\\s]", "");
        return text;
    }


    public void storeTemporaryFloatNumber(Float number) {
        floatNum = number;
    }

    public Float getTemporaryFloatNumber() {
        return floatNum;
    }

    public String returnColumnName() {
        String columnName = null;
        columnName = proploader.prop.getProperty("columnname");
        return columnName;
    }

    public String returnFileName() {
        String columnName = null;
        columnName = proploader.prop.getProperty("filename");
        return columnName;
    }

    public String returnFieldName() {
        String columnName = null;
        columnName = proploader.prop.getProperty("fieldname");
        return columnName;
    }

    public String returnDirectoryName() {
        String columnName = null;
        columnName = proploader.prop.getProperty("directoryname");
        return columnName;
    }

    public String returnDatabaseName() {
        String columnName = null;
        columnName = proploader.prop.getProperty("databasename");
        return columnName;
    }

    public static TreeMap<String, String> loadTwoListsIntoTreeMap(List<String> list1, List<String> list2) {

        TreeMap<String, String> tmap = new TreeMap<String, String>();
        Iterator<String> i1 = list1.iterator();
        Iterator<String> i2 = list2.iterator();
        while (i1.hasNext() || i2.hasNext()) tmap.put(i1.next(), i2.next());
        return tmap;
    }

    public boolean compareTwoJsonStrings(String expectedString, String actualString) throws IOException {

        boolean status = false;
        ObjectMapper om = new ObjectMapper();

        Map<String, Object> m1 = (Map<String, Object>) (om.readValue(actualString, Map.class));
        Map<String, Object> m2 = (Map<String, Object>) (om.readValue(expectedString, Map.class));
        if (!m1.equals(m2)) {
            return status;
        } else {
            return true;
        }

    }

    //verify if the provided List is null
    public static boolean IsListNull(List<String> stringList) {
        for (String s : stringList)
            if (s != null) return false;
        return true;
    }

    public static boolean compareTwoJsonFiles(String srcFile, String tarFile) throws FileNotFoundException {
        boolean status = false;
        JsonParser jsonParser = new JsonParser();
        if (jsonParser.parse(new FileReader(srcFile)).equals(jsonParser.parse(new FileReader(tarFile)))) {
            status = true;
        } else {
            return status;
        }
        return status;
    }

    public static boolean isAllUppercase(String s) {
        for (char c : s.toCharArray()) {
            if (Character.isLetter(c) && Character.isLowerCase(c)) {
                return false;
            }
        }
        return true;
    }

    public static List<String> convertStringListToLowerCase(List<String> list) {
        List<String> list1 = new ArrayList<>();
        for (String text : list) {
            list1.add(text.toLowerCase());
        }
        return list1;
    }

    public static HashMap<WebElement, WebElement> loadTwoElementsListsIntoMap(List<WebElement> list1, List<WebElement> list2) {

        HashMap<WebElement, WebElement> hmap = new HashMap<WebElement, WebElement>();
        Iterator<WebElement> i1 = list1.iterator();
        Iterator<WebElement> i2 = list2.iterator();
        while (i1.hasNext() || i2.hasNext()) hmap.put(i1.next(), i2.next());
        return hmap;
    }

    public static String[] splittedText(String text, String splitValue) {
        String fullText = text;
        String[] splitText = fullText.split(splitValue);
        return splitText;
    }

    public static boolean compareLists(List<String> actual, List<String> expected) {
        Collections.sort(actual);
        Collections.sort(expected);
        return actual.equals(expected);
    }


    public static String stringDecoder(String encodedString) throws UnsupportedEncodingException {
        byte[] asBytes = Base64.decodeBase64(encodedString);
        String base64Decoded = new String(asBytes, "utf-8");
        return base64Decoded;
    }

    public static String getTextWithoutNextLineInResponse(String text) {
        text = text.replaceAll("\\r|\\n", "");
        return text;
    }

    public static String getFirstLetterAsUpperCase(String text) {

        text = text.substring(0, 1).toUpperCase() + text.substring(1);
        return text;
    }

    public static String getCurrentDateInStringFormat() {

        LocalDate currentDate = LocalDate.now();
        String text = currentDate.getMonth().toString() + " " + currentDate.getDayOfMonth() + ", " + currentDate.getYear();

        return text;
    }

    public static String getTextWithoutWhiteSpace(String text) {
        text = text.replaceAll("\\s", "");
        return text;
    }


    //Gets the data format from UI to our user Specified Format
    public static String dataFormater(String dateValue, String datePattern, String requiredDatePattern) throws Exception {
        //datePattern = "yyyy-MM-dd HH:mm:ss.SSSXXX"   //date format and datepattern format has to match  //requiredDatePattern = "MMM d, yyyy, h:mm:ss a" (it can be of any required format)
        SimpleDateFormat dateFormat = new SimpleDateFormat(datePattern);
        Date date = dateFormat.parse(dateValue);
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MINUTE, -30);
        cal.add(Calendar.HOUR_OF_DAY, -5);
        cal.add(Calendar.SECOND, -5);
        Date newDate = cal.getTime();
        SimpleDateFormat newDateFormat = new SimpleDateFormat(requiredDatePattern);
        String formatedDate = newDateFormat.format(newDate);
        return formatedDate;
    }

    public static String fileSizeConversion(String fileSize, String format) {
        String convertedFileSize = null;
        switch (format) {
            case "MB":
                String size = fileSize.substring(0, fileSize.length() - 2);
                double fileSizeInKB = Double.parseDouble(size);
                int fileSizeInMB = (int) (fileSizeInKB * 1024);
                convertedFileSize = String.valueOf(fileSizeInMB);
                break;
        }
        return convertedFileSize;
    }

    //Roundoff for Decimal Values using Half_UP RoundingMethod
    public static String roundOffDecimalValueUsingHalfUP(String value, int scale) {
        BigDecimal Value = new BigDecimal(value);
        BigDecimal roundOffValue = Value.setScale(scale, RoundingMode.HALF_UP);
        String updatedValue = roundOffValue.toString();
        return updatedValue;
    }

    //Method to get the Current day
    public static String getCurrentDay() {
        String pattern = "dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        String date = simpleDateFormat.format(new Date());
        return date;
    }

    //Method to verify whether the given json is valid or not
    public static boolean isJSONValid(String content) {
        try {
            final ObjectMapper mapper = new ObjectMapper();
            mapper.readTree(content);
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    /**
     * to encode the string
     *
     * @param string
     * @return
     */
    public static String stringEncoder(String string) {
        String encodedString = null;
        try {
            encodedString = java.util.Base64.getEncoder()
                    .encodeToString(string.getBytes());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encodedString;
    }

    public static void jsonAssertTwoJSONFiles(String expectedJsonFile, String actualJsonFile) throws IOException {
        JSONParser jsonParser = new JSONParser();
        Object obj1 = null;
        Object obj2 = null;
        try {
            obj1 = jsonParser.parse(new FileReader(expectedJsonFile));
            obj2 = jsonParser.parse(new FileReader(actualJsonFile));
            String expected = obj1.toString();
            String actual = obj2.toString();
//            JSONAssert.assertJsonEquals(expected, actual);
            org.skyscreamer.jsonassert.JSONAssert.assertEquals(expected,actual, JSONCompareMode.LENIENT);
            org.skyscreamer.jsonassert.JSONAssert.assertEquals(expected,actual,JSONCompareMode.NON_EXTENSIBLE);
        } catch (ParseException e) {
            Assert.fail("Error while parsing");
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            Assert.fail("File not found");
            e.printStackTrace();
        }

    }

    public static void jsonAssertTwoJSONFilesForItem (String expectedJsonFile, String actualJsonFile, String item) throws IOException {
        JSONParser jsonParser = new JSONParser();
        Object obj1 = null;
        Object obj2 = null;
        try {

            obj1 = JsonRead.readJsonObject(expectedJsonFile, "$."+item+"");
            obj2 = JsonRead.readJsonObject(actualJsonFile, "$."+item+"");
            String expected = obj1.toString();
            String actual = obj2.toString();
            org.skyscreamer.jsonassert.JSONAssert.assertEquals(expected,actual, JSONCompareMode.LENIENT);
            org.skyscreamer.jsonassert.JSONAssert.assertEquals(expected,actual,JSONCompareMode.NON_EXTENSIBLE);
        } catch (ParseException e) {
            e.printStackTrace();
            Assert.fail("Error while parsing");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            Assert.fail("File not found");
        } catch (PathNotFoundException e){
            Assert.fail("Actual Lineage Hop metadata not available for item "+item);
            e.printStackTrace();
        } catch (Exception e){
            e.printStackTrace();
            Assert.fail("Lineage hops verification failed");
        }

    }

    //Method to get the Current Date
    public static String getCurrentDate(String pattern) {
        String date="";
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
            date = simpleDateFormat.format(new Date());

        } catch (DateTimeException e) {
            Assert.fail("Date is not captured");
        }
        return date;
    }

    //Method to get the Current Date in formatted form
    public static String getCurrentDateFormatted() {
        String date="";
        try {
            DateFormat Date = DateFormat.getDateInstance();
            Calendar calender = Calendar.getInstance();
            date = Date.format(calender.getTime());

        } catch (DateTimeException e) {
            Assert.fail("Date is not captured");
        }
        return date;
    }

    //Method to verify whether the given string is Base64 or not
    public static boolean isStringBase64(String input) {
        boolean flag = false;
        try {
            if (!input.contains(" ") && Base64.isBase64(input) == true) {
                flag = true;
            } else {
                flag = false;
            }
        } catch (Exception ex) {
        }
        return flag;
    }
    //Method to traverse each java file across the given folder to verify the escrow details
    public static List<String> traverseFilesAndVerifyContainsText(File[] arr, int level, String copyrightsMessage) {
        try {
            boolean flag = false;
            for (File f : arr) {
                for (int i = 0; i < level; i++)
                    LoggerUtil.logLoader_info("Escrow", "\t");
                if (f.isFile() && f.getName().contains(".java")) {
                    flag = FileUtil.returnFileContentToSTring(f.getPath()).contains(copyrightsMessage);
                    if (flag) {
                        booleanArray.add(Boolean.toString(flag));
                        LOG.info("Copyrights Present in " + f.getPath());
                    } else {
                        booleanArray.add(Boolean.toString(flag));
                        LOG.severe("Copyrights Not Present in " + f.getPath());
                    }

                } else if (f.isDirectory()) {
                    if (f.getPath().contains("src\\test")) {
                        LOG.severe("Wrong Directory Path " + f.getPath());
                    } else {
                        traverseFilesAndVerifyContainsText(f.listFiles(), level + 1, copyrightsMessage);

                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return booleanArray;
    }
    public static Map<String, String> removeValuefromMap(Map<String, String> map, String removeValue) {
        Iterator<String> keySetIterator = map.values().iterator();
        while (keySetIterator.hasNext()) {
            String key = keySetIterator.next();
            if (key.trim().equalsIgnoreCase(removeValue)) {
                keySetIterator.remove();
            }
        }
        return map;
    }
}
