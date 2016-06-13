package com.lifeeditor.controller.target_List;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.lifeeditor.model.target_list.Target_ListVO;
import com.lifeeditor.model.target_spec.Target_specVO;
import com.lifeeditor.model.user_spec.user_specVO;
import com.lifeeditor.service.TargetSpecService;
import com.lifeeditor.service.Target_List_Service;
import com.lifeeditor.utility.MyGson;

/**
 * Servlet implementation class getTarget
 */
@WebServlet("/getTarget")
public class getTarget extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public getTarget() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Target_List_Service trgSvc = new Target_List_Service();
		user_specVO user = (user_specVO)request.getSession().getAttribute("LoginOK");
		List<Target_ListVO> list = trgSvc.findByUserID(user.getUserID());
		JsonArray jsonArray = new JsonArray();
		Gson gson = new Gson();
		for(Target_ListVO targetList : list) {
			jsonArray.add(gson.toJsonTree(targetList.getTrgVO()));
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(jsonArray.toString());
	}

}
