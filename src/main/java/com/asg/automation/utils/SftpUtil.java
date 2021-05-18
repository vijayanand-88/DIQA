package com.asg.automation.utils;

import com.jcraft.jsch.*;

import java.io.*;
import java.nio.charset.Charset;
import java.util.Properties;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

/**
 * Created by venkata.mulugu on 7/13/2017.
 */
public class SftpUtil {


    private String server;
    private int port;
    private String login;
    private String password;

    private JSch jsch = null;
    private Session session = null;
    private Channel channel = null;
    private ChannelSftp c = null;

    public SftpUtil(String server, int port, String login, String password) {
        this.server = server;
        this.port = port;
        this.login = login;
        this.password = password;
    }

    /**
     * Connects to the server and does some commands.
     */
    public void connect() {
        try {
            jsch = new JSch();
            session = jsch.getSession(login, server, port);
            session.setPassword(password.getBytes(Charset.forName("ISO-8859-1")));
            Properties config = new Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            // Initializing a channel
            channel = session.openChannel("sftp");
            channel.connect();
            c = (ChannelSftp) channel;
        } catch (JSchException e) {
            e.printStackTrace();
        }
    }

    public Channel executeShellCommand(String cmd) throws Exception{
        try {
            channel = session.openChannel("shell");

            OutputStream inputstream_for_the_channel = channel.getOutputStream();
            PrintStream commander = new PrintStream(inputstream_for_the_channel, true);

            channel.setOutputStream(System.out, true);

            channel.connect();
            TimeUnit.SECONDS.sleep(10);

            commander.println(cmd);
            TimeUnit.SECONDS.sleep(10);

            commander.close();

            if (channel.isClosed()) {
                System.out.println("Exit Status: "
                        + channel.getExitStatus());
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
        return channel;
    }

    public String retrieveFilesInDirectory(String sourceDirectoryPath, String destinationDirectory, String fileExt) throws SftpException {
        String eventFileDestinationLocation = null;
        c.cd(sourceDirectoryPath);
        long startTime = System.currentTimeMillis();
        long endTime = startTime+ TimeUnit.SECONDS.toMillis(30);
        do {
            Vector<ChannelSftp.LsEntry> list = c.ls(fileExt);
            for (ChannelSftp.LsEntry entry : list) {
                eventFileDestinationLocation = destinationDirectory + entry.getFilename();
                c.get(entry.getFilename(), eventFileDestinationLocation);
            }
        }while (eventFileDestinationLocation==null&& System.currentTimeMillis()>endTime);
    return eventFileDestinationLocation;
    }

    public int countOfFilesInDirectory(String sourceDirectoryPath, String fileExt) throws SftpException {
        c.cd(sourceDirectoryPath);
            Vector<ChannelSftp.LsEntry> list = c.ls(fileExt);
        return list.size();
    }
    /**
     * Retrieves a file from the sftp server
     *
     * @param destinationFile String path to the remote file on the server
     * @param sourceFile      String path on the local fileSystem
     */
    public void retrieveFile(String sourceFile, String destinationFile) {
        if (c == null || session == null || !session.isConnected() || !c.isConnected()) {
            LoggerUtil.logLoader_info("SftpUtil","No Channel");
        }

        try {

            c.get(sourceFile, destinationFile);

        } catch (SftpException e) {
            if (e.getMessage() != null && e.getMessage().indexOf("No such file") == -1) {
                LoggerUtil.logLoader_info("SftpUtil","No file exists in source");
            }
        }
    }

    /**
     * This method is to clear the content in SFTP file
     * @param sourceFile file which content to be cleared
     * @throws IOException
     * @throws SftpException
     */
    public void clearSFTPFileContent(String sourceFile) throws IOException, SftpException {
        if (c == null || session == null || !session.isConnected() || !c.isConnected()) {
            LoggerUtil.logLoader_info("SftpUtil","No Channel");
        }
        try {
            OutputStream out = c.put(sourceFile);
                OutputStreamWriter writer = new OutputStreamWriter(out);
                writer.write("");



        } catch (SftpException e) {
            if (e.getMessage() != null && e.getMessage().indexOf("No such file") == -1) {
              LoggerUtil.logLoader_info("SftpUtil",sourceFile+"content not cleared");
              }
        }
    }


    public void disconnect() {
        if (c != null) {

            c.disconnect();
        }
        if (channel != null) {

            channel.disconnect();
        }
        if (session != null) {

            session.disconnect();
        }
    }


    public String getServer() {
        return server;
    }

    public void setServer(String server) {
        this.server = server;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public SftpUtil() {
    }

    public void setConnectionConfiguration(PropertyLoader propLoader)
    {

        setServer(propLoader.prop.getProperty("sftpServerHostname"));
        setPort(Integer.parseInt(propLoader.prop.getProperty("sftpPortNumber")));
        setLogin(propLoader.prop.getProperty("sftpUsername"));
        setPassword(propLoader.prop.getProperty("sftpPassword"));
    }
    public void setConnectionConfigurationhost(PropertyLoader propLoader)
    {
        setServer(propLoader.prop.getProperty("dockerHost"));
        setPort(Integer.parseInt(propLoader.prop.getProperty("dockerPort")));
        setLogin(propLoader.prop.getProperty("dockerUser"));
        setPassword(propLoader.prop.getProperty("dockerPassword"));
    }

}
