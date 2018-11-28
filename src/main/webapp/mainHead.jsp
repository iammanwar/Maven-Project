<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.dak.servlet.AccountServlet"%>
<%
	AccountServlet ob=new AccountServlet();
	ob.isSignIn(request, response);
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
<!-- Tooltipster css -->
<link rel="stylesheet"
	href="plugins/tooltipster/tooltipster.bundle.min.css">

<!-- Custom CSS -->
<!-- Custom box css -->
<link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
<link href="assets/css/custom.style.css" rel="stylesheet"
	type="text/css" />
<!-- Animated css -->
<link href="plugins/animate/animate.min.css" rel="stylesheet"
	type="text/css" />
<!-- Summernote CSS -->
<link rel="stylesheet" href="plugins/summernote/summernote.css">
<!-- Jquery filer css 
        <link href="plugins/jquery.filer/css/jquery.filer.css" rel="stylesheet" />
        <link href="plugins/jquery.filer/css/themes/jquery.filer-dragdropbox-theme.css" rel="stylesheet" /> -->
<!-- Upload Master -->
<link href="plugins/fileuploader-master/css/jquery.fileuploader.css"
	rel="stylesheet" />
<link
	href="plugins/fileuploader-master/css/jquery.fileuploader-theme-dragdrop.css"
	rel="stylesheet" />
<!-- Notification css (Toastr) -->
<link href="plugins/toastr/toastr.min.css" rel="stylesheet"
	type="text/css" />
<!-- Sweet Alert -->
<link href="plugins/bootstrap-sweetalert/sweet-alert.css"
	rel="stylesheet" type="text/css">
<!-- App title -->
<title>Dak | Inbox</title>
<!-- App css -->
<link href="assets/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="assets/css/core.css" rel="stylesheet" type="text/css" />
<link href="assets/css/components.css" rel="stylesheet" type="text/css" />
<link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
<link href="assets/css/pages.css" rel="stylesheet" type="text/css" />
<link href="assets/css/menu.css" rel="stylesheet" type="text/css" />
<link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />


<!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/modernizr.min.js"></script>
<!-- Upload Master -->
<script src="plugins/fileuploader-master/js/jquery.fileuploader.min.js"></script>
<!--summernote-->
<script src="plugins/summernote/summernote.min.js"></script>
<script>
            jQuery(document).ready(function(){

                $('.summernote').summernote({
                    height: 250,                 // set editor height
                    minHeight: null,             // set minimum height of editor
                    maxHeight: null,             // set maximum height of editor
                    focus: false                 // set focus to editable area after initializing summernote
                });
            });
        </script>

</head>