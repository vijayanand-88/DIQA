package com.asg.automation.utils;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Created by muthuraja.ramakrishn on 6/15/2017.
 */
public class JsonFormater {
    JsonFormater jsonformat;
    ObjectMapper mapper;

    public String jsonformat(String text) {
       String returnText=null;
        try {
            jsonformat = new JsonFormater();
            mapper = new ObjectMapper();
            Object json = mapper.readValue(text, Object.class);
            returnText = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);

        }catch(Exception e)
        {
            //it's find if throws exception to reach end of file - need to investigate
        }
        return returnText;
    }


}