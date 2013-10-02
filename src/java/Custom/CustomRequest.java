/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Custom;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Anji
 */
public class CustomRequest {

    private final String LOCATION = "../tempData";
    private HashMap<String, String> formMap = new HashMap<String, String>();
    private HashMap<String, String> fileMap = new HashMap<String, String>();
    private Enumeration<String> names;
    private DiskFileItemFactory factory = new DiskFileItemFactory();
    private Iterator<FileItem> iter = null;
    private FileItem item = null;
    private long MAX_FILE_SIZE = 1 * 1024 * 1024;//max file size 5MB

    /*
     * constructor
     */
    public CustomRequest(HttpServletRequest request) throws FileUploadException, Exception {
        try {
            new File(LOCATION).mkdir();
            factory.setRepository(new File(LOCATION));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(MAX_FILE_SIZE);
            List<FileItem> items = upload.parseRequest(request);
            iter = items.iterator();
            while (iter.hasNext()) {
                item = iter.next();
                if (item.isFormField()) {
                    String key = item.getFieldName();
                    String val = item.getString();
                    formMap.put(key, val);
                } else {
                    String key = item.getFieldName();
                    String val = item.getName();
                    
                    formMap.put(key, val);
                    File f = new File(LOCATION, val);
                    try{
                    item.write(f);
                    }
                    catch(FileNotFoundException ex){}
                    finally  {
                        fileMap.put(key, LOCATION+"/"+val);
                    }
                }
            }
        } catch (FileUploadException ex) {
            throw ex;
        } catch (Exception ex) {
            throw ex;
        }
    }

    /*
     * simulation of getParameter method of request.
     */
    public String getParameter(String key) {
        return formMap.get(key);
    }
    
    /*
     * To get the contents of a file.s
     */
    public String getFileStream(String fileName) {
        return fileMap.get(fileName );
    }

    @Override
    public String toString() {
        return "" + formMap +"\n"+ fileMap;
    }
}
