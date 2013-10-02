/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataConnection;

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
            properties.loadFromXML(new FileInputStream("credentials.properties"));
            String driver=properties.getProperty("Driver");
            String uri=properties.getProperty("url");
            String username=properties.getProperty("root-user");
            String password=properties.getProperty("root-password");
            Class.forName(driver);
            String url=uri+"feedback_"+dept;
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
