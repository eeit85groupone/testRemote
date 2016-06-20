package com.lifeeditor.backstageLogin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutServiceDB
 */
@WebServlet("/logoutServiceDB")
public class logoutServiceDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public logoutServiceDB() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		session.removeAttribute("backPhoto");
		session.removeAttribute("backVO");
	
		response.sendRedirect(request.getServletContext().getContextPath() + "/manager/Backstage.jsp");
		return;
		
	}

}