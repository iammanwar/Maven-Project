<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if(session.getAttribute("userFullName")!=null)
{
	response.sendRedirect("home.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="A fully featured admin theme which can be used to build CRM, CMS, etc.">
<meta name="author" content="Coderthemes">

<!-- App favicon -->
<link rel="shortcut icon" href="assets/images/favicon.png">
<link href="assets/css/custom.style.css" rel="stylesheet"
	type="text/css" />
<!-- App title -->
<title>Dak | Sign up</title>
<!-- Custom CSS -->
<link href="assets/css/custom.style.css" rel="stylesheet"
	type="text/css" />
<!-- Notification css (Toastr) -->
<link href="plugins/toastr/toastr.min.css" rel="stylesheet"
	type="text/css" />
<!-- Animated css -->
<link href="plugins/animate/animate.min.css" rel="stylesheet"
	type="text/css" />
<!-- App css -->
<link href="assets/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="assets/css/core.css" rel="stylesheet" type="text/css" />
<link href="assets/css/components.css" rel="stylesheet" type="text/css" />
<link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
<link href="assets/css/pages.css" rel="stylesheet" type="text/css" />
<link href="assets/css/menu.css" rel="stylesheet" type="text/css" />
<link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />

<!-- Date picker -->
<link
	href="plugins/bootstrap-datepicker/css/bootstrap-datepicker.min.css"
	rel="stylesheet">
<!-- Selection/Drop down-->
<link href="plugins/bootstrap-select/css/bootstrap-select.min.css"
	rel="stylesheet" />

<!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

<script src="assets/js/modernizr.min.js"></script>

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
	<!-- HOME -->
	<section>
		<div class="container-alt">
			<div class="row">
				<div class="col-sm-12">

					<div class="wrapper-page" style="max-width: 620px">

						<div class="m-t-40 account-pages">
							<div class="text-center account-logo-box">
								<h2 class="text-uppercase">
									<a href="index.html" class="text-success"> <span><img
											src="assets/images/logo.png" alt="" height="36"></span>
									</a>
								</h2>
								<!--<h4 class="text-uppercase font-bold m-b-0">Sign In</h4>-->
							</div>
							<div class="account-content">
								<form class="form-horizontal" action="account"
									id="createAccount" method="post">
									<div class="row">
										<div class="col-md-6">
											<div class="form-group m-r-5">
												<input type="text" class="form-control" name="firstName"
													required placeholder="First name"
													<%if(request.getAttribute("firstName")!=null){%>
													value="<%=request.getAttribute("firstName")%>" <%}%> />
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group ">
												<input type="text" class="form-control" name="lastName"
													required placeholder="Last name"
													<%if(request.getAttribute("lastName")!=null){%>
													value="<%=request.getAttribute("lastName")%>" <%}%> />
											</div>
										</div>
									</div>
									<div class="row m-b-10">
										<div class="col-xs-12">
											<div class="form-group">
												<div class="input-group ">
													<input type="text" class="form-control" id="email"
														name="email" required placeholder="Chose an email"
														style="padding-left: 0px;"
														<%if(request.getAttribute("dakId")!=null){%>
														value="<%=request.getAttribute("dakId")%>" <%}%> /> <span
														class="input-group-addon">@dak.com</span>
												</div>
											</div>
										</div>
									</div>
									<div class="row m-b-10">
										<div class="col-md-6">
											<div class="form-group m-r-5">
												<input type="password" id="password" name="password"
													class="form-control" placeholder="Password" />
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group ">
												<input type="password" name="confiemPassword"
													class="form-control" placeholder="Re-Type Password" />

											</div>
										</div>
									</div>
									<div class="row m-b-10">
										<div class="col-xs-12">
											<div class="form-group">
												<input data-parsley-type="number" type="text"
													name="phoneNmber" class="form-control"
													placeholder="Phone numbers"
													<%if(request.getAttribute("phoneNmber")!=null){%>
													value="<%=request.getAttribute("phoneNmber")%>" <%}%> />
											</div>
										</div>
									</div>
									<div class="row m-b-10">
										<div class="col-md-6">
											<div class="form-group m-r-5">
												<!-- <select class="selectpicker" " >
                                    <option data-icon="mdi mdi-human-male-female text-primary">Choose..</option>
                                    <option data-icon="mdi mdi-human-male">Male</option>
                                    <option data-icon=" mdi mdi-human-female">Female</option> 
                                </select> -->
												<select id="heard" name="gender" class="form-control">
													<option value="">Gender</option>
													<option value="1">Male</option>
													<option value="2">Female</option>
													<option value="3">Others</option>
												</select>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group ">
												<div class="input-group">
													<input type="text" class="form-control" name="dateOfBirth"
														placeholder="dd/mm/yyyy" id="datepicker-autoclose"
														<%if(request.getAttribute("dateOfBirth")!=null){%>
														value="<%=request.getAttribute("dateOfBirth")%>" <%}%> />
													<span id="datePickBtn"
														class="input-group-addon cursorPointer"><i
														class="mdi mdi-calendar" id="datepicker-autoclose"></i></span>
												</div>
											</div>
										</div>
									</div>
									<div class="form-group account-btn text-center m-t-10">
										<div class="col-xs-12">
											<button
												class="btn w-md btn-danger btn-bordered waves-effect waves-light"
												name="singUpButton" value="Sign up" type="submit">Sing
												up</button>
										</div>
									</div>

								</form>

								<div class="clearfix"></div>

							</div>
						</div>
						<!-- end card-box-->
						<div class="row m-t-50">
							<div class="col-sm-12 text-center">
								<p class="text-muted">
									Already have account?<a href="index.jsp"
										class="text-primary m-l-5"><b>Sign In</b></a>
								</p>
							</div>
						</div>

					</div>
					<!-- end wrapper -->
				</div>
			</div>
		</div>
	</section>
	<!-- END HOME -->


	<!-- jQuery  -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/detect.js"></script>
	<script src="assets/js/fastclick.js"></script>
	<script src="assets/js/jquery.blockUI.js"></script>
	<script src="assets/js/waves.js"></script>
	<script src="assets/js/jquery.slimscroll.js"></script>
	<script src="assets/js/jquery.scrollTo.min.js"></script>

	<!-- Date pickup -->
	<script src="plugins/moment/moment.js"></script>
	<script src="plugins/timepicker/bootstrap-timepicker.js"></script>
	<script
		src="plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
	<script
		src="plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
	<script src="plugins/clockpicker/js/bootstrap-clockpicker.min.js"></script>
	<script src="plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
	<script src="assets/pages/jquery.form-pickers.init.js"></script>

	<!-- Input mask -->
	<script src="plugins/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>

	<!-- validation -->
	<script type="text/javascript" src="assets/js/validation.main.js"></script>
	<script src="assets/js/custom.validation.js"></script>

	<!-- Toastr js -->
	<script src="plugins/toastr/toastr.min.js"></script>
	<script src="assets/js/custom.js"></script>
	<!-- Selection/Drop down-->
	<script src="plugins/bootstrap-select/js/bootstrap-select.min.js"></script>
	<!-- App js -->
	<script src="assets/js/jquery.core.js"></script>
	<script src="assets/js/jquery.app.js"></script>
	<jsp:include page="notification.jsp"></jsp:include>
</body>
</html>