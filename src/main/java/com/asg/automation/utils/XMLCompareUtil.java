package com.asg.automation.utils;

import org.w3c.dom.Attr;
import org.w3c.dom.Node;
import org.xmlunit.builder.DiffBuilder;
import org.xmlunit.diff.Comparison;
import org.xmlunit.diff.ComparisonResult;
import org.xmlunit.diff.Diff;
import org.xmlunit.diff.DifferenceEvaluator;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.List;

public class XMLCompareUtil  implements DifferenceEvaluator {

    private String attributeName;

    public XMLCompareUtil(String attributeName) throws FileNotFoundException {
        this.attributeName = attributeName;
    }


    public ComparisonResult evaluate(Comparison comparison, ComparisonResult outcome) {
        if (outcome == ComparisonResult.EQUAL) return outcome; // only evaluate differences.
        final Node controlNode = comparison.getControlDetails().getTarget();
        if (controlNode instanceof Attr) {
            Attr attr = (Attr) controlNode;
            if (attr.getName().equals(attributeName)) {
                return ComparisonResult.SIMILAR; // will evaluate this difference as similar
            }
        }
        return outcome;
    }

    /**
     *
     * @param source - Source XML File
     * @param target - Target XML File
     * @param skipAttribute - Single Attribute which needs to be skipped
     * @return
     * @throws FileNotFoundException
     */
    public static boolean compareTwoFiles(String source, String target, String skipAttribute) throws FileNotFoundException {
        boolean status= true;
        FileInputStream fis1 = new FileInputStream(source);
        FileInputStream fis2 = new FileInputStream(target);
        FileInputStream sourceFile = fis1;
        FileInputStream targetFile = fis2;

        Diff myDiff = DiffBuilder.compare(sourceFile).withTest(targetFile)
                .withDifferenceEvaluator(new XMLCompareUtil(skipAttribute))
                .checkForSimilar()
                .build();

        if(myDiff.hasDifferences()==true){
            return false;

        }else {
            return status;
        }

    }

}

