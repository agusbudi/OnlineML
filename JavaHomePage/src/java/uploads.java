/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import weka.core.Instances;

/**
 *
 * @author raharjo
 */
@WebServlet(urlPatterns = {"/uploads"})
public class uploads extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //response.setContentType("text/html;charset=UTF-8");
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String train = "";
        String test = "";
        String StatusTrain = "";
        String StatusTest = "";
       // processRequest(request, response);
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            //get IP address
            String ip = request.getHeader("X-Forwarded-For");  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("Proxy-Client-IP");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("WL-Proxy-Client-IP");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("HTTP_CLIENT_IP");  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
            } 
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                ip = request.getRemoteAddr();  
            }
            
            ip = ip.replace(':', '1');
        
            //get Date
            //new java.util.Date()).toLocaleString()
            long date = (new java.util.Date()).getTime();
            
            File file ;
            int maxFileSize = 5000 * 1024;
            int maxMemSize = 5000 * 1024;
            String filePath = "/Users/raharjo/Downloads/oke/";
            
            String contentType = request.getContentType();
            
            if ((contentType.indexOf("multipart/form-data") >= 0)) {

               DiskFileItemFactory factory = new DiskFileItemFactory();
               factory.setSizeThreshold(maxMemSize);
               factory.setRepository(new File("/Users/raharjo/Downloads/tempo/"));
               ServletFileUpload upload = new ServletFileUpload(factory);
               upload.setSizeMax( maxFileSize );
               try{ 
                  List fileItems;
                   fileItems = upload.parseRequest(request);
                  Iterator i = fileItems.iterator();
                  while ( i.hasNext () ) 
                  {
                     FileItem fi = (FileItem)i.next();
                     if ( !fi.isFormField () )  {
                         String fieldName = fi.getFieldName();
                         String fileName = fi.getName();
                         boolean isInMemory = fi.isInMemory();
                         long sizeInBytes = fi.getSize();
                         String temp[] = fileName.split("\\.");
                         int status=0;
                         
                        String datatype = temp[temp.length-1];
                        file = new File( filePath + ip +date + fileName) ;
                        fi.write( file ) ;
                         if(fieldName.equals("train")){
                             train = filePath + ip + date + fileName;                             
                             try{
                                StatusTrain= ReadFile(train, fileName);
                             }catch(Exception ex){
                                 StatusTrain = "0--" + fileName + "<br/>Status: <i>Data can not be read</i><br/>";
                             }
                             String cx= StatusTrain.substring(0,1);
                             if(StatusTrain.substring(0,2).equals("1-"))
                                 status=1;
                             else{
                                if(file.delete())
                                    System.out.println("File deleted successfully");
                                else
                                    System.out.println("Failed to delete the file");
                             }
                         }
                         else if(fieldName.equals("test")){
                             test = filePath + ip + date + fileName; 
                             try{
                             StatusTest= ReadFile(test, fileName);
                             }catch(Exception ex){
                                 StatusTest = "0--" + fileName + "<br/>Status: <i>Data can not be read</i><br/>";
                             }
                             if(StatusTest.substring(0,2).equals("1-"))
                                 status=1;
                             else{
                                if(file.delete())
                                    System.out.println("File deleted successfully");
                                else
                                    System.out.println("Failed to delete the file");
                             }
                         }
                     }
                  }
                  request.setAttribute("dataset", StatusTrain + "--" + StatusTest);
                  request.setAttribute("rdeminfo", "1:" + train + ":" + test);
                         
               }catch(Exception ex) {
                  request.setAttribute("rdeminfo", "0:0:" + ex);
               }
                
            }else{
                    request.setAttribute("rdeminfo","2:2:File not found");
            }
            
            RequestDispatcher aDispatcher = request.getRequestDispatcher("/index.jsp");
            aDispatcher.forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(uploads.class.getName()).log(Level.SEVERE, null, ex);
            }
    }

    //read your file, p.s. weka is only for single label learning, that is why you must set the class index
    private static String ReadFile(String fileAddress, String fileName) throws Exception{
        Instances data = null;
        
        String content="";
        
        weka.core.converters.ConverterUtils.DataSource source;
        try {
            source = new weka.core.converters.ConverterUtils.DataSource(fileAddress);
            data = source.getDataSet();
            // setting class attribute in the last of attribute
            if(data.classIndex() == -1)
                data.setClassIndex(data.numAttributes() - 1);
            content=content + "1--" + fileName;
            content= content + "; Instances : "+ data.numInstances() +"; ";
            content= content + "Attributes : "+ data.numAttributes() +"; ";
            content= content + "Class      : "+ data.numClasses() +"; <br/>";            
            content= content + "Status: <i>appropriate data format</i><br/>";
        } catch (Exception ex) {
            System.out.println("Data can't be read because of this error :" + ex);
            content = content + "0--" + fileName + "<br/>Status: <i>Data can not be read</i><br/>";
        }
        
        return content;
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
