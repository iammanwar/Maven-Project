<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="com.dak.servlet.AccountServlet"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%
	AccountServlet ob=new AccountServlet();
	ob.isSignIn(request, response);
	/*String userAddress=null;int userId=0;
	if(session.getAttribute("userId")!=null){
		userId=(int)session.getAttribute("userId");
	}
	Cookie getUserCookies[]=request.getCookies();
	Cookie getUserCookie=null;
	boolean status=false;
	if(getUserCookies!=null) {
		for(int i=0;i<getUserCookies.length;i++) {
			getUserCookie=getUserCookies[i];
			getUserCookie.getValue();
			out.print(getUserCookie.getValue());
			String chk="savedUserIdOf"+userId;
			System.out.println("value->>"+getUserCookie.getName()+" length->"+getUserCookies.length+" Name->>"+chk);
			if(chk.equals(getUserCookie.getName())) {
				System.out.println("exist->"+getUserCookie.getValue()+" ID->"+userId);
			}
		}
	}*/
%>
<jsp:include page="mainHead.jsp"></jsp:include>
<jsp:include page="topBar.jsp"></jsp:include>
<jsp:include page="sideBar.jsp"></jsp:include>
<!-- controlButton-->
<div id="inboxContent" class="content-page">
	<!-- Start content -->
	<div class="content">
		<div class="container">
			<div class="table-detail mail-right">
				<div class="row">
					<div class="col-lg-12">
						<div class="btn-toolbar m-t-20" role="toolbar">
							<div class="btn-group">
								<button id="moveToArchive" type="button"
									class="btn btn-primary waves-effect waves-light "
									style="border-radius: 50px 0px 0px 50px;" data-from="inbox">
									<i class="fa fa-inbox"></i>
								</button>
								<button id="spanReport" type="button"
									class="btn btn-primary waves-effect waves-light "
									data-from="inbox">
									<i class="fa fa-exclamation-circle"></i>
								</button>
								<button id="moveToTrash" type="button"
									class="btn btn-primary waves-effect waves-light "
									style="border-radius: 0px 50px 50px 0px;" data-from="inbox">
									<i class="fa fa-trash-o"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End row -->

				<div class="table-responsive m-t-20">
					<table id="inboxArea" class="table table-hover mails m-0">
						<% 	Connection connect;
	PreparedStatement pStatement;
	ResultSet rSet;
	int userid=0;
	if(session.getAttribute("userId")!=null){
		userid=(int) session.getAttribute("userId");
	}
	System.out.println("___>"+userid);
	try{
		Class.forName("com.mysql.jdbc.Driver");
		connect = DriverManager.getConnection("jdbc:mysql://testingdak-jws-app-mysql:3306/dakDataBase","dakadmin","7268");
		//-------------------------------------------
		pStatement = connect.prepareStatement("SELECT M.id,firstName,U.lastName,M.subject,M.content,M.isTrash,M.isSeen,M.haveAttachedFile,U.id FROM tbl_maildata M LEFT JOIN tbluserdata U ON M.sentBy=U.id WHERE sentTo=? AND isDraft=? AND trashBy!=? AND isTrash=? AND archiveBy!=? AND archiveByAll=?");
		pStatement.setInt(1,userid);
		pStatement.setInt(2,0);
		pStatement.setInt(3,userid);
		pStatement.setInt(4, 0);
		pStatement.setInt(5,userid);
		pStatement.setInt(6, 0);
		rSet = pStatement.executeQuery();
		//System.out.println("arry->"+fileArray);
		%>
						<tbody>
							<% while(rSet.next()){%>
							<tr class="<%if(rSet.getInt(7)==0){%>unread<%} %> cursorPointer">
								<td class="">
									<div class="checkbox checkbox-info checkbox-circle m-r-15">
										<input id="checkbox1" type="checkbox" name="mailSelect"
											value="<%=rSet.getInt(1)%>~<%=rSet.getInt(9)%>"> <label
											for="checkbox1"></label>
									</div>
								</td>
								<td onclick="readMail(<%= rSet.getInt(1) %>)">
									<%
                         	String sendTo=rSet.getString(2)+" "+rSet.getString(3);
                         %> <a class="email-name"><%=sendTo%></a> <%
                         	int showingTextLength=97-rSet.getString(4).length();
                                System.out.print("showingTextLength----->"+showingTextLength);
                         	String contentInText=Jsoup.parse(rSet.getString(5)).text();
                            if(contentInText.length()>90){
                            	contentInText=contentInText.substring(0,showingTextLength)+". . .";
                            }
                         %>
								
								<td class="hidden-xs col-md-8"
									onclick="readMail(<%= rSet.getInt(1) %>)"><a
									class="email-msg"><span style="font-weight: 700">
											<%if(rSet.getString(4).equals("")){%>(no subject)<%}else{%><%=rSet.getString(4)%></span>-<span
										style="font-weight: 100">
											<%};%><%=contentInText %></span></a></td>
								<td style="width: 20px;"><i
									class="<%if(rSet.getInt(8)!=0){%>fa fa-paperclip<%} %>"></i></td>
								<td class="text-right">07:23 AM</td>
							</tr>

							<%}%>
						</tbody>
					</table>
				</div>


				<%}catch(SQLException e){
		e.printStackTrace();
	}
	%>
				<jsp:include page="composeModal.html"></jsp:include>
				<!-- content -->
				<jsp:include page="footerStart.jsp"></jsp:include>
				<jsp:include page="footerEnd.jsp"></jsp:include>