/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DA.MedicineDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 *
 * @author Kz
 */
public class UpdateMedicine extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet UpdateMedicine</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>ERROR 404</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        MedicineDAO DAO = new MedicineDAO();
        
        String regNumber =  request.getParameter("regNumber");
        String[] ingredents = request.getParameterValues("ingreName");
        String[] dosageAmount = request.getParameterValues("dosageAmount");
        
        DAO.deleteMedIngredentRelation(regNumber);
        if (ingredents != null) {
            for (int i = 0; i < ingredents.length; i++) {
                DAO.insertMedIngredientRelation(regNumber, ingredents[i], dosageAmount[i]);
            }
        }
        Boolean Rx = Boolean.valueOf(request.getParameter("Rx"));
        String dosageForm = request.getParameter("dosageForm");
        String EXPDate = request.getParameter("EXPDate");
        String GCN = request.getParameter("GCN");
        String imgURL = request.getParameter("imgURL");
        DAO.updateMedicine(regNumber, Rx, dosageForm, EXPDate, GCN, imgURL);
        response.sendRedirect("medDetails?regNumber="+regNumber);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
