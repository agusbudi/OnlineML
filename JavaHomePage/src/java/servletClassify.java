/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import weka.classifiers.evaluation.ConfusionMatrix;

/**
 *
 * @author raharjo
 */
@WebServlet(urlPatterns = {"/Classify"})
public class servletClassify extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet servletClassify</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet servletClassify at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String train = request.getParameter("train").toString();
            String test = request.getParameter("test").toString();
            String msg2 = request.getParameter("msg2").toString();
            
            int ClassifierNum = 30; 
            String select[] = request.getParameterValues("algo"); 
            boolean algos[] = new boolean[ClassifierNum];
            String algo = "";
            for (int i = 0; i < ClassifierNum; i++)
                    algos[i]= false;
            if (select != null && select.length != 0) {
                for (int i = 0; i < select.length; i++)
                    algos[Integer.parseInt(select[i])]= true;
            }
            
            for (int i = 0; i < ClassifierNum; i++){
                if(algos[i]==false)
                    algo=algo+"f;";
                else
                    algo=algo+"t;";
            }
            
            algo=algo+"t;t;t;t;t;";
            String options[] = new String[ClassifierNum+4];
            for(int i=0;i<ClassifierNum;i++)
                options[i] = request.getParameter("option"+i);
            
            String report = "";
            
            if(select.length==0){
                request.setAttribute("rdeminfo","3:3:No algorithm is selected");
            }
            else{
                Learning learn = new Learning(train, test);
                learn.TrainTest(algos,options);
                report = learn.getReport();
                String getOption = learn.getOptions();
                String ConfusionMatrix = learn.getConfusionMatrix();

                request.setAttribute("rdeminfo","5:5:5");
                
                request.setAttribute("confmatrix",ConfusionMatrix);
                request.setAttribute("getOptions",getOption);
            }
            
            request.setAttribute("dataset",msg2);
            request.setAttribute("algo",algo);
            request.setAttribute("report",report);
            
            RequestDispatcher aDispatcher = request.getRequestDispatcher("/index.jsp");
            aDispatcher.forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(servletClassify.class.getName()).log(Level.SEVERE, null, ex);
        }
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
