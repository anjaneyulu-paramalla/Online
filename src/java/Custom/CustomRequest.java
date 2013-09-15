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
    public HashMap<String, String> hf = new HashMap<String, String>();
    FileItemStream item = null;
    ServletFileUpload upload = new ServletFileUpload();
    FileItemIterator iter = null;

    /*
     * constructor
     */
    public CustomRequest(HttpServletRequest request, String dept, String year) throws FileUploadException, IOException {
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
                BufferedReader br = new BufferedReader(new InputStreamReader(item.openStream()));
                String store = "";
                String str;
                while ((str = br.readLine()) != null) {
                    store += str + "\n";
                }
                br.close();
                hf.put(key + "data", store);
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
     * To get the contents of a file.s
     */
    public String getFileStream(String fileName) {
        return hf.get(fileName + "data");
    }

    @Override
    public String toString() {
        return "" + hm + hf;
    }
}
