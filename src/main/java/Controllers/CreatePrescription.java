/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DA.MedicineDAO;
import DA.PrescriptionDAO;
import Models.Account;
import Models.Medicine;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.List;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author Kz
 */
public class CreatePrescription extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreatePrescription</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreatePrescription at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MedicineDAO medDAO = new MedicineDAO();
        List<Medicine> listMedicine = medDAO.getMedicine();
        request.setAttribute("listMedicine", listMedicine);
        request.getRequestDispatcher("NewPrescription.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrescriptionDAO preDAO = new PrescriptionDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("user");
        String UUID = a.getUUID();
        String patientName = request.getParameter("patientName");
        String doctorName = request.getParameter("doctorName");
        int age = Integer.parseInt(request.getParameter("age"));
        int height = Integer.parseInt(request.getParameter("height"));
        int weight = Integer.parseInt(request.getParameter("weight"));
        Date createDate = Date.valueOf(request.getParameter("createDate"));
        String[] listReg = request.getParameterValues("regNumber");
        String[] medNote = request.getParameterValues("medNote");
        String diagnose = request.getParameter("diagnose");
        String medicalHistory = request.getParameter("medicalHistory");
        String Note = request.getParameter("Note");
        preDAO.insertPrescription(UUID, patientName, doctorName, age, weight, height, createDate, diagnose, medicalHistory, Note);
        int ID = preDAO.getHighestPreID();
        for (int i = 0; i < listReg.length; i++) {
            preDAO.insertPresMedRelation(UUID, ID, listReg[i], medNote[i]);
        }
        response.sendRedirect("showPres");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
