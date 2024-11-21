/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DA.MedicineDAO;
import DA.PrescriptionDAO;
import Models.Medicine;
import Models.Prescription;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author Kz
 */
public class DetailsPrescription extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DetailsPrescription</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetailsPrescription at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        PrescriptionDAO DAO = new PrescriptionDAO();
        int ID = Integer.parseInt(request.getParameter("ID"));
        Optional<Prescription> pres = DAO.getPrescriptionByID(ID);
        MedicineDAO medDAO = new MedicineDAO();
        List<Medicine> list = medDAO.getMedicine();
        request.setAttribute("pres", pres);
        request.setAttribute("listMedicine", list);
        request.getRequestDispatcher("PrescriptionDetails.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
