<%@ page import="java.sql.*"%>
<body class="fixed-left">

	<!-- Loader -->
	<div id="preloader">
		<div id="status">
			<div class="spinner">
				<div class="spinner-wrapper">
					<div class="rotator">
						<div class="inner-spin"></div>
						<div class="inner-spin"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Begin page -->
	<div id="wrapper">

		<!-- Top Bar Start -->
		<div class="topbar">

			<!-- LOGO -->
			<div class="topbar-left">
				<!--<a href="home.jsp" class="logo"><span>Zir<span>cos</span></span><i class="mdi mdi-cube"></i></a>-->
				<!-- Image logo -->
				<a href="home.jsp" class="logo"> <span> <img
						src="assets/images/logo.png" alt="" height="50">
				</span> <i> <img src="assets/images/logo_sm.png" alt="" height="40">
				</i>
				</a>
			</div>

			<!-- Button mobile view to collapse sidebar menu -->
			<div class="navbar navbar-default" role="navigation">
				<div class="container">

					<!-- Navbar-left -->
					<ul class="nav navbar-nav navbar-left">
						<li>
							<button id="menuButton"
								class="button-menu-mobile open-left waves-effect waves-light">
								<i class="mdi mdi-menu"></i>
							</button>
						</li>
					</ul>

					<!-- Right(Notification) -->
					<ul class="nav navbar-nav navbar-right">
						<li class="hidden-xs">
							<form role="search" class="app-search">
								<input type="text" placeholder="Search..." class="form-control">
								<a href=""><i class="fa fa-search"></i></a>
							</form>
						</li>
						<li class="dropdown user-box"><a href=""
							class="dropdown-toggle waves-effect waves-light user-link"
							data-toggle="dropdown" aria-expanded="true"> <%
                                	String profilePicture= (String) session.getAttribute("userPP");
                                	String src=null;
                                	System.out.print("====>"+profilePicture);
                                	if(session.getAttribute("userPP")!=null){
                                		if(profilePicture.split("~")[0].equals("A")){
                                    		src="assets/images/avatar/"+profilePicture.split("~")[1];
                                    	}
                                	}
                                	
                                %> <img src="<%= src %>" alt="user-img"
								class="img-circle user-img">
						</a>
							<form id="signOutForm" action="signOut" method="post"></form>
							<form id="profileForm" action="UserAccount" method="get"></form>
							<ul
								class="dropdown-menu dropdown-menu-right arrow-dropdown-menu arrow-menu-right user-list notify-list">
								<li>
									<h5><%=session.getAttribute("userFullName")%></h5>
								</li>
								<li><a id="profileButton" href="javascript:{}"><i
										class="ti-user m-r-5"></i> Profile</a></li>
								<li><a id="singOutButton" href="javascript:{}"><i
										class="ti-power-off m-r-5"></i> Sign out</a></li>
							</ul></li>

					</ul>
					<!-- end navbar-right -->

				</div>
				<!-- end container -->
			</div>
			<!-- end navbar -->
		</div>
		<!-- Top Bar End -->