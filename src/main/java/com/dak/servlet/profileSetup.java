package com.dak.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class profileSetup
 */
@WebServlet("/profileSetup")
public class profileSetup extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection connect;
    PreparedStatement pStatement;
    ResultSet rSet;
	 public void init() {
		 try {
				Class.forName("com.mysql.jdbc.Driver");
				connect = DriverManager.getConnection("jdbc:mysql://testingdak-jws-app-mysql:3306/dakDataBase","dakadmin","7268");
			}catch (Exception e) {
				e.toString();
			}
		}
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profileSetup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession userInfo = request.getSession(false);
		String avatar=request.getParameter("avatarChoosen"),
				sequrityQAns=request.getParameter("answer"),
				sequrityQ=request.getParameter("question");
		try {
			pStatement=connect.prepareStatement("UPDATE `recoveraccount` SET `securityQ`=?,`securityA`=? WHERE `userId`=?");
			pStatement.setString(1, sequrityQ);
			pStatement.setString(2, sequrityQAns);
			pStatement.setInt(3,Integer.parseInt(userInfo.getAttribute("userId").toString()));
			pStatement.executeUpdate();
			pStatement=connect.prepareStatement("UPDATE `tbluserdata` SET `profilePicture`=? WHERE `id`=?");
			pStatement.setString(1, "A~"+avatar);
			pStatement.setInt(2,(int) userInfo.getAttribute("userId"));
			pStatement.executeUpdate();
			pStatement=connect.prepareStatement("SELECT `profilePicture` FROM `tbluserdata` WHERE `id`=?");
			pStatement.setInt(1, (int) userInfo.getAttribute("userId"));
			rSet=pStatement.executeQuery();
			while(rSet.next()) {
				userInfo.setAttribute("userPP", rSet.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("home.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
