//package com.asg.automation.utils.rest;
//
//import org.apache.hadoop.conf.Configuration;
//import org.apache.hadoop.fs.FileSystem;
//import org.apache.hadoop.fs.Path;
//import org.apache.hadoop.hive.ql.exec.vector.BytesColumnVector;
//import org.apache.hadoop.hive.ql.exec.vector.LongColumnVector;
//import org.apache.hadoop.hive.ql.exec.vector.VectorizedRowBatch;
//import org.apache.orc.CompressionKind;
//import org.apache.orc.OrcFile;
//import org.apache.orc.TypeDescription;
//import org.apache.orc.Writer;
//
//import java.io.IOException;
//
//public class orcCreater {
//
//    public static void main(String[] args) throws IOException {
//        TypeDescription schema = createSchema();
//        Configuration conf = new Configuration();
//        FileSystem fs = FileSystem.getLocal(conf);
//        Path testFilePath = new Path("sample.orc");
//        fs.delete(testFilePath, false);
//        int batchSize = 50000;
//
//        Writer writer = OrcFile.createWriter(testFilePath, OrcFile.writerOptions(conf)
//                .setSchema(schema)
//                .compress(CompressionKind.ZLIB)
//                .stripeSize(128 * 1024 * 1024)
//                .bufferSize(256 * 1024)
//                .rowIndexStride(10000)
//                .version(OrcFile.Version.V_0_12));
//        VectorizedRowBatch batch = schema.createRowBatch(batchSize);
//        int numRows = 200000000;
//        int iters = numRows / batchSize;
//        for (int iter = 0; iter < iters; iter++) {
//            for (int i = 0; i < batchSize; ++i) {
//                int row = batch.size++;
//                appendRow(batch, row);
//            }
//            writer.addRowBatch(batch);
//            batch.reset();
//        }
//        writer.close();
//    }
//
//    private static void appendRow(VectorizedRowBatch batch, int row) {
//        for (int i = 0; i < 122; i++) {
//            ((LongColumnVector) batch.cols[i]).vector[row] = row * 300;
//        }
//        for (int i = 122; i < 133; i++) {
//            ((BytesColumnVector) batch.cols[i]).setVal(row, Integer.toHexString(10 * row % 10000).getBytes());
//        }
//    }
//
//    private static TypeDescription createSchema() {
//        TypeDescription td = TypeDescription.createStruct();
//        for (int i = 0; i < 122; i++) {
//            td.addField("long" + i, TypeDescription.createLong());
//        }
//        for (int i = 0; i < 11; i++) {
//            td.addField("string" + i, TypeDescription.createString());
//        }
//        return td;
//    }
//}
