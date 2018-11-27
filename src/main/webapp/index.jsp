<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if(session.getAttribute("userFullName")!=null)
{
	response.sendRedirect("home.jsp");
}
/*ArrayList <String>rememeberData=new ArrayList();
Cookie[] rememberCookies=request.getCookies();
if(rememberCookies !=null){
	for (int i = 0; i < rememberCookies.length; i++) {
		Cookie rCookie = rememberCookies[i];
		//System.out.println("rCh->"+ rCookie.getValue());
		rememeberData.add(i, rCookie.getValue());
		
	}
	System.out.println(rememeberData.get(0));
}*/
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="A fully featured admin theme which can be used to build CRM, CMS, etc.">
<meta name="author" content="Coderthemes">
<!-- App favicon -->
<link rel="shortcut icon" href="assets/images/favicon.png">
<!-- Notification css (Toastr) -->
<link href="plugins/toastr/toastr.min.css" rel="stylesheet"
	type="text/css" />
<!-- Custom CSS -->
<link href="assets/css/custom.style.css" rel="stylesheet"
	type="text/css" />
<!-- Animated css -->
<link href="plugins/animate/animate.min.css" rel="stylesheet"
	type="text/css" />
<!-- Titel -->
<title>DAK | Sing in</title>
<!-- css -->
<link rel="stylesheet" type="text/css"
	href="assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="assets/css/core.css">
<link rel="stylesheet" type="text/css" href="assets/css/components.css">
<link rel="stylesheet" type="text/css" href="assets/css/icons.css">
<link rel="stylesheet" type="text/css" href="assets/css/pages.css">
<link href="assets/css/menu.css" rel="stylesheet" type="text/css" />
<link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />
<!-- Upload Master -->
<link href="plugins/jquery.filer/css/jquery.filer.css" rel="stylesheet" />
<link
	href="plugins/jquery.filer/css/themes/jquery.filer-dragdropbox-theme.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="plugins/MProgress.js-master/mprogress.min.css">
<style type="text/css">
.barLayout {
	width: 100%;
	max-width: 690px;
	height: 5px;
}

.demo-button {
	width: 50px;
	line-height: 25px;
	height: 25px;
	display: inline-block;
	background: #FFA500;
	text-align: center;
	color: #FFF;
	font-size: 1.7rem;
	border-radius: 3px;
	margin: 15px 12px 5px 0;
	cursor: pointer;
}

.demo-button:hover {
	background: #00BCD4;
}
</style>
</head>
<body class="bodyBackground">
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
	<section>
		<div class="container-alt">
			<div class="row">
				<div class="col-sm-12">
					<div class="wrapper-page">
						<div class="m-t-40 account-pages">
							<div id="accountHead" class="text-center account-logo-box">
								<h2 class="text-uppercase">
									<a href="index.html" class="text-success"> <span><img
											src="assets/images/logo.png" alt="" height="50"></span>
									</a>
								</h2>
								<!-- <h4 class="text-uppercase font-bold m-b-0">Sign In</h4> -->
							</div>
							<div id="processBar" class="barLayout" style="display: none"></div>
							<div class="account-content ">
								<div id="accountContent"></div>
								<div class="clearfix"></div>
							</div>
						</div>
						<!-- end card-box-->
						<div class="row m-t-50">
							<div class="col-sm-12 text-center">
								<p class="text-muted">
									Don't have an account? <a href="signup.jsp"
										class="text-primary m-l-5"><b>Sign Up</b></a>
								</p>
							</div>
						</div>
					</div>
					<!-- end wrapper -->
				</div>
			</div>
		</div>
	</section>
	<div
		class="alert alert-icon alert-info alert-dismissible fade in divAlignCenter animated zoomIn"
		role="alert" style="max-width: 450px">
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
		<i class="mdi mdi-information"></i> <strong>Note!</strong> For best
		browsing experience use Google Chrome.
	</div>


	<!-- jQuery  -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/detect.js"></script>
	<script src="assets/js/fastclick.js"></script>
	<script src="assets/js/jquery.blockUI.js"></script>
	<script src="assets/js/waves.js"></script>
	<script src="assets/js/jquery.slimscroll.js"></script>
	<script src="assets/js/jquery.scrollTo.min.js"></script>
	<script>
            var resizefunc = [];
            $("#accountContent").load("loginDiv.jsp",function(){
        		$.getScript("assets/js/accountContent.js");
        	});
       </script>


	<!-- Toastr js -->
	<script src="plugins/toastr/toastr.min.js"></script>
	<!-- Toastr init js (Demo)-->
	<script src="assets/pages/jquery.toastr.js"></script>


	<!-- App js -->
	<script src="assets/js/jquery.core.js"></script>
	<script src="assets/js/jquery.app.js"></script>
	<!-- validation -->
	<script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>
	<!-- Upload Master -->
	<script src="plugins/jquery.filer/js/jquery.filer.min.js"></script>
	<script src="assets/pages/jquery.fileuploads.init.js"></script>

	<script type="text/javascript"
		src='plugins/MProgress.js-master/mprogress.min.js'></script>
	<script type="text/javascript">
    	jQuery(document).ready(function($) {
    		getLocation();
    		function getLocation() {
    		    if (navigator.geolocation) {
    		        navigator.geolocation.getCurrentPosition(showPosition);
    		    } else { 
    		        alert=("Geolocation is not supported by this browser.");
    		    }
    		}
    		function showPosition(position) {
    		    var location=position.coords.latitude+"~"+position.coords.longitude;
    		    $.ajax({
					url:'account',
					type:'GET',
					data:{locationInfo:location},
					success : function(responseText) {
					}
				});
			
    		}
    	});
    	</script>

</body>
</html>