package com.dak.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Statement;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet("/account")
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Connection connect;
    PreparedStatement pStatement;
    ResultSet rSet;
    String userFullName=null;
    String userAddress=null;
    String userPP=null;
    int userId=0;
    String latitude="Unknown";
    String longitude="Unknown";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountServlet() {
        super();
        
    }
    
    public void init() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection("jdbc:mysql://testingdak-jws-app-mysql:3306/dakDataBase","dakadmin","7268");
		}catch (Exception e) {
			e.toString();
		}
	}
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String findDakId=request.getParameter("findDakId");
    	if(findDakId!=null) {
    		if(isExists(findDakId)) {
    			response.setContentType("text/plain");
				response.getWriter().write("exists");
    		}else {
    			response.setContentType("text/plain");
				response.getWriter().write("notExists");
    		}
    	}
    	String getLocationInfo=request.getParameter("locationInfo");
    	System.out.println("chek location"+getLocationInfo);
    	if(getLocationInfo!=null) {
    		if(true) {
				latitude=getLocationInfo.split("~")[0];
				longitude=getLocationInfo.split("~")[1];
    		}
    	}
    	
	}
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				Date toDay = new Date(); 
				 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				 String currtentTime=formatter.format(toDay);
				 if("Sign up".equals(request.getParameter("singUpButton"))) {
					 String userFirstName=request.getParameter("firstName"),
								userLastName=request.getParameter("lastName"),
								userDakId=request.getParameter("email")+"@dak.com",
								userPassword=request.getParameter("password"),
								userPhoneNo=request.getParameter("phoneNmber"),
								userGender= request.getParameter("gender"),
								userDateOfBirth=request.getParameter("dateOfBirth");
					 if(!isExists(userDakId)) {
						 try
						    {
						      //create SimpleDateFormat object with source string date format
						      SimpleDateFormat sdfSource = new SimpleDateFormat("MM/dd/yy");
						      //parse the string into Date object
						      Date date = sdfSource.parse(userDateOfBirth);
						      
						      //create SimpleDateFormat object with desired date format
						      SimpleDateFormat sdfDestination = new SimpleDateFormat("yyyy-MM-dd");
						      
						      //parse the date into another format
						      userDateOfBirth = sdfDestination.format(date);
						    }
						    catch(Exception pe)
						    { 
						      System.out.println("Parse Exception : " + pe);
						    }
						 try {
							pStatement=connect.prepareStatement("insert into tbluserdata(firstName,lastName,dakAddress,password,gender,dateOfBirth,mobileNumber,createdOn) values(?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
							pStatement.setString(1, userFirstName);
							pStatement.setString(2, userLastName);
							pStatement.setString(3, userDakId);
							pStatement.setString(4, userPassword);
							pStatement.setString(5, userGender);
							pStatement.setString(6, userDateOfBirth);
							pStatement.setBigDecimal(7, new BigDecimal(userPhoneNo));
							pStatement.setString(8,currtentTime);
							pStatement.executeUpdate();
							rSet=pStatement.getGeneratedKeys();
							while(rSet.next()) {
								System.out.println(rSet.getInt(1)+"<-----");
								request.setAttribute("userTableId",rSet.getInt(1));
								Cookie saveInBrowser =new Cookie("savedUserIdOf"+rSet.getInt(1),"");
								saveInBrowser.setMaxAge(30*120*24*365);
								response.addCookie(saveInBrowser);
							}
							request.getRequestDispatcher("signUpConfirmation.jsp").include(request, response);
						} catch (SQLException e) {
							e.printStackTrace();
						}
				 }else {
					 request.setAttribute("signUpError","alreadyExists");
					 request.setAttribute("firstName",userFirstName);
					 request.setAttribute("lastName", userLastName);
					 request.setAttribute("dakId", userDakId.substring(0,userDakId.lastIndexOf('@')));
					 request.setAttribute("phoneNmber", userPhoneNo);
					 request.setAttribute("dateOfBirth", userDateOfBirth);
					 request.getRequestDispatcher("signup.jsp").include(request, response);
				 }
			 }else if("Sign in".equals(request.getParameter("singInButton"))) {
				 String signInEmail=request.getParameter("email"),
						 signInPassword=request.getParameter("password"),
						 rememberSignIn=request.getParameter("rememberMe");
				// System.out.println(rememberSignIn);
				 if(isMatch(signInEmail, signInPassword)) {
					 
					 addSession(request);
					 if(!checkDevice(request)) {
						 System.out.println("new Device");
					 }
					 if(rememberSignIn!=null) {
//						 Cookie userIdCookie = new Cookie("userId",signInEmail);
//						 Cookie userPasswordCookie = new Cookie("userPassword",signInPassword);
//						 userIdCookie.setMaxAge(30*120*24*365);
//						 userPasswordCookie.setMaxAge(30*120*24*365);
//						 response.addCookie(userIdCookie);
//						 response.addCookie(userPasswordCookie);
					 }
					 String deviceInfo=getBrowserAndOSInfo(request.getHeader("User-Agent"))+"~"+getDeviceDetails();
					 System.out.println("DEviceInfo"+deviceInfo);
					 System.out.println("Location->"+this.latitude+"  "+this.longitude);
					 try {
						pStatement=connect.prepareStatement("INSERT INTO `accountactivity`(`userID`, `browserDetails`, `deviceOS`, `deviceMAC`, `deviceIP`, `locationLat`, `locationLng`) VALUES (?,?,?,?,?,?,?)");
						pStatement.setInt(1, this.userId);
						pStatement.setString(2,deviceInfo.split("~")[0]);
						pStatement.setString(3,deviceInfo.split("~")[1] );
						pStatement.setString(4, deviceInfo.split("~")[2]);
						pStatement.setString(5, deviceInfo.split("~")[3]);
						pStatement.setString(6, this.latitude);
						pStatement.setString(7, this.longitude);
						pStatement.executeUpdate();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					 if(profileSetup(request,response)) {
						 request.getRequestDispatcher("setup.jsp").include(request, response);
					 }else {
						 response.sendRedirect("home.jsp");
					 }
				 }
				 else {
					 request.setAttribute("signInError","notExists");
					 request.getRequestDispatcher("index.jsp").include(request, response);
				 }
			 }else if("Sign out".equals(request.getParameter("singOututton"))) {
				 HttpSession signOutsession = request.getSession(false);
					if(signOutsession!=null) {
						signOutsession.invalidate();
					}
					response.sendRedirect("index.jsp");
			 }
				//System.out.print(userFirstName+"->"+userLastName+"->"+userEmail+"->"+userPassword+"->"+userPhoneNo+"->"+userGender+"->"+userDateOfBirth);
	}
	public boolean isExists(String userEmail) {
        boolean status = false;
        System.out.println(userEmail);
        try {
            pStatement= connect.prepareStatement("select * from tbluserdata where dakAddress=?");
            pStatement.setString(1, userEmail);
            //pStatement.setString(2, userPassword);
            rSet = pStatement.executeQuery();
            while (rSet.next()) {
            	status=true;
            }
        } catch (SQLException e) {
            e.toString();
        }
        //System.out.println(status);
        return status;
    }
	 
	public boolean isMatch(String userEmail, String userPassword) {
	        boolean status = false;
	        System.out.print(userEmail+"<->"+userPassword);
	        try {
	            pStatement = connect.prepareStatement("select * from tbluserdata where dakAddress=? and password=?");
	            pStatement.setString(1, userEmail);
	            pStatement.setString(2, userPassword);
	            this.rSet= pStatement.executeQuery();
	            while (this.rSet.next()) {
	                status = true;
	                this.userFullName=this.rSet.getString("firstName")+" "+this.rSet.getString("lastName");
	                this.userId= rSet.getInt("id");
	                this.userAddress=rSet.getString("dakAddress");
	                this.userPP=rSet.getString("profilePicture");
	            }
	        } catch (SQLException e) {
	            e.toString();
	        }
	        return status;
	    }
	public void addSession(HttpServletRequest request) throws ServletException, IOException{
		HttpSession signInSession = request.getSession();
		signInSession.setAttribute("userFullName",this.userFullName);
		signInSession.setAttribute("userId",this.userId);
		signInSession.setAttribute("userAddress", this.userAddress);
		if(this.userPP!=null) {
			signInSession.setAttribute("userPP", this.userPP);
		}
		signInSession.setAttribute("deviceInfo", getDeviceDetails());
		signInSession.setMaxInactiveInterval(30*60);
		
	}
	public boolean checkDevice(HttpServletRequest request) {
		Cookie getUserCookies[]=request.getCookies();
		Cookie getUserCookie=null;
		boolean status=false;
		if(getUserCookies!=null) {
			for(int i=0;getUserCookies.length>i;i++) {
				getUserCookie=getUserCookies[i];
				getUserCookie.getValue();
				String chk="savedUserIdOf"+this.userId;
				System.out.println("value->>"+getUserCookie.getName()+" length->"+getUserCookies.length+" Name->>"+chk);
				if(chk.equals(getUserCookie.getName())) {
					System.out.println("exist->>"+getUserCookie.getValue()+" ID->"+this.userId);
					status=true;
				}
			}
		}
		return status;
	}
	public String getBrowserAndOSInfo(String browserDetails) {
		//String  browserDetails  =   request.getHeader("User-Agent");
        String  userAgent       =   browserDetails;
        String  user            =   userAgent.toLowerCase();

        String os = "";
        String browser = "";

        System.out.println("User Agent for the request is===>"+browserDetails);
        //=================OS=======================
         if (userAgent.toLowerCase().indexOf("windows") >= 0 )
         {
             os = "Windows";
         } else if(userAgent.toLowerCase().indexOf("mac") >= 0)
         {
             os = "Mac";
         } else if(userAgent.toLowerCase().indexOf("x11") >= 0)
         {
             os = "Unix";
         } else if(userAgent.toLowerCase().indexOf("android") >= 0)
         {
             os = "Android";
         } else if(userAgent.toLowerCase().indexOf("iphone") >= 0)
         {
             os = "IPhone";
         }else{
             os = "UnKnown, More-Info: "+userAgent;
         }
         //===============Browser===========================
        if (user.contains("msie"))
        {
            String substring=userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
            browser=substring.split(" ")[0].replace("MSIE", "IE")+"-"+substring.split(" ")[1];
        } else if (user.contains("safari") && user.contains("version"))
        {
            browser=(userAgent.substring(userAgent.indexOf("Safari")).split(" ")[0]).split("/")[0]+"-"+(userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
        } else if ( user.contains("opr") || user.contains("opera"))
        {
            if(user.contains("opera"))
                browser=(userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0]+"-"+(userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
            else if(user.contains("opr"))
                browser=((userAgent.substring(userAgent.indexOf("OPR")).split(" ")[0]).replace("/", "-")).replace("OPR", "Opera");
        } else if (user.contains("chrome"))
        {
            browser=(userAgent.substring(userAgent.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
        } else if ((user.indexOf("mozilla/7.0") > -1) || (user.indexOf("netscape6") != -1)  || (user.indexOf("mozilla/4.7") != -1) || (user.indexOf("mozilla/4.78") != -1) || (user.indexOf("mozilla/4.08") != -1) || (user.indexOf("mozilla/3") != -1) )
        {
            //browser=(userAgent.substring(userAgent.indexOf("MSIE")).split(" ")[0]).replace("/", "-");
            browser = "Netscape-?";

        } else if (user.contains("firefox"))
        {
            browser=(userAgent.substring(userAgent.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
        } else if(user.contains("rv"))
        {
            browser="IE-" + user.substring(user.indexOf("rv") + 3, user.indexOf(")"));
        } else
        {
            browser = "UnKnown, More-Info: "+userAgent;
        }
        System.out.println("Operating System->"+os);
        System.out.println("Browser Name->"+browser);
        return browser+"~"+os;
	}
	public String getDeviceDetails() {
		InetAddress ip;
		String IPAddress=null;
		String MAC=null;
		try {
				
			ip = InetAddress.getLocalHost();
			System.out.println("Current IP address : " + ip.getHostAddress());
			IPAddress=ip.getHostAddress();
			NetworkInterface network = NetworkInterface.getByInetAddress(ip);
				
			byte[] mac = network.getHardwareAddress();
				
			System.out.print("Current MAC address : ");
			if(mac!=null) {
				StringBuilder sb = new StringBuilder();
				for (int i = 0; i < mac.length; i++) {
					sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));		
				}
				System.out.println(sb.toString());
				MAC=sb.toString();
			}
		} catch (UnknownHostException e) {
			
			e.printStackTrace();
			
		} catch (SocketException e){
				
			e.printStackTrace();
				
		}
		return MAC+"~"+IPAddress;
	}
	public boolean profileSetup(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		boolean status=false;
		HttpSession userInfo = request.getSession(false);
		try {
			pStatement=connect.prepareStatement("SELECT `profilePicture` FROM `tbluserdata` WHERE `id`=?");
			pStatement.setInt(1, (int)userInfo.getAttribute("userId"));
			rSet=pStatement.executeQuery();
			while(rSet.next()) {
				if(rSet.getString(1)==null) {
					status=true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return status;
	}
	public void isSignIn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession signInSession = request.getSession(false);
		if(signInSession.getAttribute("userFullName")==null)
		{
			response.sendRedirect("index.jsp");
		}
		else
		{
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		    response.setDateHeader("Expires", 0); 
		}
	}
}
