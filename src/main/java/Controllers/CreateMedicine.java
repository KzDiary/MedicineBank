/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DA.CompanyDAO;
import DA.IngredentDAO;
import DA.MedicineDAO;
import Models.Company;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Kz
 */
public class CreateMedicine extends HttpServlet {
   
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
        IngredentDAO DAO = new IngredentDAO();
        CompanyDAO comDAO = new CompanyDAO();
        List<Company> listCSKD = comDAO.getCompany();
        request.setAttribute("listCSKD", listCSKD);
        request.setAttribute("listIngre", DAO.getIngredents());
        request.getRequestDispatcher("NewMedicine.jsp").forward(request, response);
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
        
        String regNumber = request.getParameter("regNumber");
        String medName = request.getParameter("medName");        
        String[] ingredents = request.getParameterValues("ingreName");
        String[] dosageAmount = request.getParameterValues("dosageAmount");
        Boolean Rx = Boolean.valueOf(request.getParameter("Rx"));
        String dosageForm = request.getParameter("dosageForm");
        String EXPDate = request.getParameter("EXPDate");
        String GCN = request.getParameter("GCN");
        String imgURL = request.getParameter("imgURL");
        DAO.insertMedicine(regNumber,medName,Rx,dosageForm,EXPDate,GCN,imgURL);
        
        
        if (ingredents != null) {
            for (int i = 0; i < ingredents.length; i++) {
                DAO.insertMedIngredientRelation(regNumber, ingredents[i], dosageAmount[i]);
            }
        }

        response.sendRedirect("getMedicine");
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
