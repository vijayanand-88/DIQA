package com.asg.automation.utils;

import io.restassured.path.xml.config.XmlPathConfig;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static io.restassured.path.xml.XmlPath.from;

/**
 * Created by Nirmal.Balasundaram on 8/23/2017.
 */
public class XMLReaderUtil {

    /**
     * @param filePath  localfilepath
     * @param element   element name
     * @param attribute attribute
     * @return List of string values
     * @throws IOException
     */

    public static List<String> readAnAttributeFromFile(String filePath, String element, String attribute) throws IOException {

        Object attributes = from(new String(Files.readAllBytes(Paths.get(filePath)))).using(XmlPathConfig.xmlPathConfig().allowDocTypeDeclaration(true)).get("**.findAll{it.name() == '" + element + "'}.@" + attribute + "");
        if (attributes instanceof List<?>) {
            return (List<String>) attributes;
        } else if (attributes instanceof String) {
            ArrayList<String> listOfAttributes = new ArrayList<>();
            listOfAttributes.add((String) attributes);
            return listOfAttributes;
        }
        return (List<String>) attributes;
    }

    public static List<String> readAttributesFromXmlAttributes(String filePath, String xPath, String attributeName) throws ParserConfigurationException, SAXException, IOException, XPathExpressionException {
        List<String> xmlList = new ArrayList<>();
        File inputFile = new File(filePath);
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(inputFile);
        XPathFactory xPathfactory = XPathFactory.newInstance();
        XPath xpath = xPathfactory.newXPath();
        XPathExpression expr = xpath.compile(xPath);
        NodeList nl = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
        for (int i = 0; i < nl.getLength(); i++) {
            Node currentItem = nl.item(i);
            String key = currentItem.getAttributes().getNamedItem(attributeName).getNodeValue();
            xmlList.add(key);

        }
        return xmlList;
    }

    public static List<String> readAttributesFromXmlTagName(String filePath, String tagName) throws ParserConfigurationException, SAXException, IOException {
        {
            List<String> xmlList = new ArrayList<>();
            File inputFile = new File(filePath);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(inputFile);

            NodeList nList = doc.getElementsByTagName(tagName);
            int queryTextCount = nList.getLength();
            for (int j = 0; j < queryTextCount; j++) {
                String node = nList.item(j).getTextContent();
                xmlList.add(node);
            }
            return xmlList;
        }


    }
}