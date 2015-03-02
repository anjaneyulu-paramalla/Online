/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.data.connection;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 *
 * @author Anji
 */
public class Connector {
    Connection con;     
    public Connector(String dept) throws IOException{
        try{
            Properties properties=new Properties();
            try{
                properties.loadFromXML(new FileInputStream("../config.xml"));
            }
            catch(IOException ie){
                 System.out.println("config file not found in directory: "+new File("../").getAbsolutePath());
                 throw ie;
            }
            String driver=properties.getProperty("driver");
            String uri=properties.getProperty("url");
            String username=properties.getProperty("root-user");
            String password=properties.getProperty("root-password");
            Class.forName(driver);
            String url=uri+"/feedback_"+dept;
            con=DriverManager.getConnection(url,username,password);
        }
        catch(Exception e){
           System.out.println(e);
        }
    }   
    public Connection getConnection(){
        return con;
    } 
}
