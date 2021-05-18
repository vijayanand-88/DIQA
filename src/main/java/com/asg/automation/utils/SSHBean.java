package com.asg.automation.utils;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class SSHBean {
    // Creating jsch variable
    private JSch mJschSSH =null;

    // Creating ssh session
    private Session mSSHSession = null;

    // Creating a new channel ssh
    private Channel mSSHChannel = null;

    private InputStream mSSHInput = null;

    private OutputStream mSSHOutput = null;

    // Creating a new SSH connection
    public boolean openConnection(String strHost, int iPort, String strUserName, String strPassword, int iTimeout) throws JSchException, IOException{

        //creating a boolean variable
        boolean blResult = false;

        // creating new value for jsch
        this.mJschSSH = new JSch();

        // set sftp server no check key when login
        java.util.Properties config = new java.util.Properties();
        config.put("StrictHostKeyChecking", "no");
        JSch.setConfig(config);

        // get session
        this.mSSHSession = this.mJschSSH.getSession(strUserName, strHost,iPort);
        // set password
        this.mSSHSession.setPassword(strPassword);

        this.mSSHSession.connect(iTimeout);

        this.mSSHChannel = this.mSSHSession.openChannel("shell");

        // connect to channel
        this.mSSHChannel.connect();

        //after connected successfully; retrive the input/output Streams
        this.mSSHInput = this.mSSHChannel.getInputStream();
        this.mSSHOutput = this.mSSHChannel.getOutputStream();
        blResult = true;

        return blResult;
    }

    // The below function would enable sending the command to ssh server
    public boolean sendCommand(String strCommand) throws IOException{
        boolean blResult = false;

        if(this.mSSHOutput!=null){
            this.mSSHOutput.write(strCommand.getBytes());

            //clear output stream
            this.mSSHOutput.flush();
        }

        return blResult;
    }

    // Below function will receive the data from the ssh server
    public String recvData() throws IOException{
        String strData="";
        // this is to validate whether the input stream has data or not
        if(this.mSSHInput!=null){

            int iAvailable = this.mSSHInput.available();
            while(iAvailable>0){
                // Creating buffer to recieve data
                byte[] btbuffer = new byte[iAvailable];

                // check byte read from input Stream
                int iByteRead = this.mSSHInput.read(btbuffer);

                //check byteread has finished or not
                iAvailable = iAvailable - iByteRead;
                strData+= new String(btbuffer);
            }
        }

        return strData;
    }

    // creating close function let close all in/out stream of SSH
    public void close() throws IOException{
        if(this.mSSHSession!=null){
            this.mSSHSession.disconnect();
        }
        if(this.mSSHChannel!=null){
            this.mSSHChannel.isClosed();
        }
        if(this.mSSHInput!=null){
            this.mSSHInput.close();
        }
        if(this.mSSHOutput!=null){
            this.mSSHOutput.close();
        }
    }

}
