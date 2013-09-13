/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Custom;

import java.io.*;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

/**
 *
 * @author Anji
 */
public class CustomRequest {

    public HashMap<String, String> hm = new HashMap<String, String>();
    public HashMap<String, File> hf = new HashMap<String, File>();
    FileItemStream item = null;
    ServletFileUpload upload = new ServletFileUpload();
    FileItemIterator iter = null;

    /*
     * constructor
     */
    public CustomRequest(HttpServletRequest request,String dept,String year) throws FileUploadException, IOException {
        iter = upload.getItemIterator(request);
        while (iter.hasNext()) {
            item = iter.next();
            if (item.isFormField()) {
                String key = item.getFieldName();
                String val = Streams.asString(item.openStream());
                hm.put(key, val);
            } else {
                String key = item.getFieldName();
                String val = item.getName();
                hm.put(key, val);
                File f=new File("../TempData/"+dept);
                System.out.println(f.mkdir());
                System.out.println(f.getAbsolutePath());
                f=new File("../TempData/"+dept+"/"+"year"+year+key+".csv");
                PrintWriter pw=new PrintWriter(f);
                BufferedReader br=new BufferedReader(new InputStreamReader(item.openStream()));
                String str;
                while((str=br.readLine())!=null){
                    pw.println(str);
                }
                pw.flush();
                br.close();
                hf.put(key, f);
            }
        }
    }
    
    /*
     * simulation of getParameter method of request.
     */
    public String getParameter(String key) {
        return hm.get(key);
    }
    
    /*
     * To get the contents of a file
     */

    public File getFileStream(String fileName) {
        return hf.get(fileName);        
    }

    @Override
    public String toString() {
        return "" + hm;
    }
}
