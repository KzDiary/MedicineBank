/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DA.AccountDAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Kz
 */
public class UpdateAccount extends HttpServlet {

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
           String uuid = request.getParameter("uuid");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int roleid = Integer.parseInt(request.getParameter("roleid"));
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateAccount at " + uuid+username+email+phone+roleid+ "</h1>");
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
        AccountDAO DAO = new AccountDAO();
        String uuid = request.getParameter("uuid");
        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        if(validUpdate(email,phone) && !username.isEmpty()){
            if (DAO.updateAccount(uuid, username, email, phone)) {
                Account a = DAO.getAccountByUsername(username);
                HttpSession session = request.getSession();
                session.setAttribute("user", a);
                request.setAttribute("alarm", "Cập nhật thành công!");
                request.getRequestDispatcher("AccountDetails.jsp").forward(request, response);
        }}
        request.setAttribute("alarm", "Cập nhật thất bại!");
        request.getRequestDispatcher("AccountDetails.jsp").forward(request, response);
    }

    boolean validUpdate(String email, String phone) {
        email = email != null ? email.trim() : null;
        phone = phone != null ? phone.trim() : null;

        return email != null && !email.isEmpty() &&
                Pattern.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email) &&
                phone != null && phone.length() >= 10 && phone.length() <= 11 &&
                phone.matches("\\d+");
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
