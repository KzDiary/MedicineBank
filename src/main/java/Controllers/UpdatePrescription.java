/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DA.MedicineDAO;
import DA.PrescriptionDAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author Kz
 */
public class UpdatePrescription extends HttpServlet {

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
            out.println("<title>Servlet UpdatePrescription</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdatePrescription at " + request.getContextPath() + "</h1>");
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
        MedicineDAO DAO = new MedicineDAO();
        PrescriptionDAO preDAO = new PrescriptionDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        String UUID = a.getUUID();
        int ID = Integer.parseInt(request.getParameter("ID"));
        String patientName = request.getParameter("patientName");
        String doctorName = request.getParameter("doctorName");
        int age = Integer.parseInt(request.getParameter("age"));
        int height = Integer.parseInt(request.getParameter("height"));
        int weight = Integer.parseInt(request.getParameter("weight"));
        String diagnose = request.getParameter("diagnose");
        String medicalHistory = request.getParameter("medicalHistory");
        Date createDate = Date.valueOf(request.getParameter("createDate"));
        String Note = request.getParameter("Note");
        String[] listReg = request.getParameterValues("regNumber");
        String[] medNote = request.getParameterValues("medNote");
        preDAO.deleteMedPresRelation(ID);
        for (int i = 0; i < listReg.length; i++) {
            preDAO.insertPresMedRelation(UUID, ID, listReg[i], medNote[i]);
        }
        preDAO.updatePrescription(ID, patientName, doctorName, age, weight, height, createDate, diagnose, medicalHistory, Note);
        response.sendRedirect("showPres");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
