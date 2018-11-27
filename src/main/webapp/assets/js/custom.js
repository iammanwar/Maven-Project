var isDraftEdit=false; 
var draftEditId=0;
var uploadFiles="";
var replyUploadFiles="";
var replyInFocus=false;
var displayCompose=true;
$(document).ready(function(){
			$("#content").load("homeDiv.jsp");
			$("#loadDraft").click(function(){
				$("#content").load("draftDiv.jsp");
			});
			inboxCount();
			draftCount();
			trashCount();
			newMailAlert();
			var isAlertShow=false;
			var validationError=false;
			var isExternalAddress=0;
			$( "#menuButton" ).trigger( "click" );
			minimizeManu();
			$( "#menuButton" ).trigger( "click" );
			maximizeManu();
				$("#menuButton").click(function(){
					if(displayCompose){
						minimizeManu();
						displayCompose=false;
					}else{
						maximizeManu();
						displayCompose=true;
					}
				});
				$("#singInButton").click(function(){
					$("#signOutForm").submit();
				});
				$("#profileButton").click(function(){
					$("#profileForm").submit();
				});
				$("#composeModalSendButton").click(function(){
					if(validationError){
						composeAjax(0);	
					}else{
						$("#sendTo").focus();
						$("#sendTo").css("color", "red");
					}
					
				});
				$("#editButton").click(function(){
					$("#personalFormFieldset").prop('disabled', false);
					$("#editButton").hide();
					$("#doneButton").show();
				});
				$("#doneButton").click(function(){
					$("#personalFormFieldset").prop('disabled', true);
					$("#editButton").show();
					$("#doneButton").hide();
				});
				
				$("#sendTo").blur(function(){
					var sendAddress=$("#sendTo").val();
					var sendAddressType=sendAddress.split("@");
					isExternalAddress=0;
					if(sendAddressType[1]!="dak.com"){
						isExternalAddress=1;
					}
				});
				$("#sendTo").blur(function(){
					var sendId=$("#sendTo").val()
					var chkId=sendId.substr(sendId.indexOf("@")+1);
					$("#dakValidationMess").css("display", "block");
					if(chkId != 'dak.com'){
						if(!isAlertShow){
							$("#sendTo").after('<div><label id="dakValidationMess" class="error" for="sendTo">Please enter a <span><img src="assets/images/logo.png" alt="" height="12"></span> address.</label></div>');
							isAlertShow=true;
						}else{
							$("#dakValidationMess").html('Please enter a <span><img src="assets/images/logo.png" alt="" height="12"></span> address.');
						}
					}else{
						$.ajax({
							url: 'account',
							type:'get',
							data:{
								findDakId:sendId
							},
						success : function(result) {
							if(result=="notExists"){
								$("#dakValidationMess").html('Invalid <span><img src="assets/images/logo.png" alt="" height="12"></span> address.');
							}else{
								$("#dakValidationMess").css("display", "none");
								$("#sendTo").css("color", "");
								validationError=true;
							}
						}
						});
					}
					
				});
				$("#composeModalCloseButton").click(function(){
					replyInFocus=true;
					if($("#sendTo").val()!=""||$("#mailSubject").val()!=""||$('.summernote').summernote('code')!="<p><br></p>"){
						composeAjax (1);
					}
				});
				$("#moveToTrash").click(function(){
					var where=$(this).data('from');
					alert(where)
		            var selectedMailsObj = [];
		            $.each($("input[name='mailSelect']:checked"), function(){            
		            	selectedMailsObj.push($(this).val());
		            });
		            console.log("->"+selectedMailsObj.join());
		            var selectedMails=selectedMailsObj.join("*").split("*");
		            $.ajax({
		            	url:'moveToTrash',
		            	data:{
		            		selectMails:selectedMails,from:where
		            	},
		            success : function() {
		            	if(where==="inbox"){
		            		$("#inboxArea").load("home.jsp" + " #inboxArea");
							toastr.options.showMethod = 'slideDown';
							toastr.options.hideMethod = 'slideUp';
							toastr.options.closeMethod = 'slideUp';
							toastr.options.positionClass = "toast-top-center",
							toastr.options.progressBar = true;
							toastr.success('Click to undo.','Conversation Trashed.');
		            		inboxCount();
		            		trashCount();
		            	}else{
		            		$("#draftArea").load("draft.jsp" + " #draftArea");
		            		toastr.options.showMethod = 'slideDown';
							toastr.options.hideMethod = 'slideUp';
							toastr.options.closeMethod = 'slideUp';
							toastr.options.positionClass = "toast-top-center",
							toastr.options.progressBar = true;
							toastr.success('Click to undo.','Conversation Trashed.');
		            		draftCount();
		            		trashCount();
		            	}
					}
		            });
		            
		        });
				$("#moveToArchive").click(function(){
					var where=$(this).data('from');
		            var selectedMailsObj = [];
		            $.each($("input[name='mailSelect']:checked"), function(){            
		            	selectedMailsObj.push($(this).val());
		            });
		            console.log("->"+selectedMailsObj.join());
		            var selectedMailsInfo=selectedMailsObj.join("*").split("*");
		            alert(selectedMailsInfo);
		            $.ajax({
		            	url:'moveToArchive',
		            	data:{
		            		selectMails:selectedMailsInfo,from:where
		            	},
		            success : function() {
		            	if(where==="inbox"){
		            		$("#inboxArea").load("home.jsp" + " #inboxArea");
		            		toastr.options.showMethod = 'slideDown';
							toastr.options.hideMethod = 'slideUp';
							toastr.options.closeMethod = 'slideUp';
							toastr.options.positionClass = "toast-top-center",
							toastr.options.progressBar = true;
							toastr.success('Click to undo.','Conversation Archived.');
		            		inboxCount();
		            	}else{
		            		$("#draftArea").load("draft.jsp" + " #draftArea");
		            		toastr.options.showMethod = 'slideDown';
							toastr.options.hideMethod = 'slideUp';
							toastr.options.closeMethod = 'slideUp';
							toastr.options.positionClass = "toast-top-center",
							toastr.options.progressBar = true;
							toastr.success('Click to undo.','Conversation Archived.');
		            		draftCount();
		            	}
					}
		            });
				});
				$("#spanReport").click(function(){
					var where=$(this).data('from');
		            var selectedMailsObj = [];
		            $.each($("input[name='mailSelect']:checked"), function(){            
		            	selectedMailsObj.push($(this).val());
		            });
		            console.log("->"+selectedMailsObj.join());
		            var selectedMailsInfo=selectedMailsObj.join("*").split("*");
		            $.ajax({
		            	url:'spanReport',
		            	data:{
		            		selectMails:selectedMailsInfo,from:where
		            	},
		            success : function() {
		            		$("#inboxArea").load("home.jsp" + " #inboxArea");
		            		toastr.options.showMethod = 'slideDown';
							toastr.options.hideMethod = 'slideUp';
							toastr.options.closeMethod = 'slideUp';
							toastr.options.positionClass = "toast-top-center",
							toastr.options.progressBar = true;
							toastr.success('Thanks for reporting.');
		            		inboxCount();
						}
		            });
				});
				$('#replyButton').click(function(){
					replyInFocus=true;
					var opendInboxMailId=$(this).data('openmailid');
					$("#replyButton").hide();
					$("#replyArea").show();
					$('.summernote').summernote('focus');
					$.getScript("assets/pages/custom.dragdrop.jquery.replyfileuploader.js");
					$.ajax({
						url: 'replyToMail',
						type:'get',
						data:{
							opendMailId: opendInboxMailId
						},
					success : function() {
						$('.summernote').on('summernote.keyup', function() {
							$.ajax({
								url: 'replyToMail',
								type:'post',
								data:{
									mailContent: $('.summernote').summernote('code')
								},
							success : function() {
							}
							})
						});
					}
					});
				});
				$('#replyDiscard').click(function(){
					$("#replyButton").show();
					$("#replyArea").hide();
					$.ajax({
						url: 'replyToMail',
						type:'get',
						data:{
							replyDiscard: true
						},
					success : function() {
						location.reload(true);
					}
					})
				});
				$("#draftReplyDiscard").click(function(){
					$("#replyButton").show();
					$("#replyArea").hide();
					var draftReplyId=$(this).data('rdraftdiscardid');
					var mailId=$(this).data('mailid');
					$.ajax({
						url: 'replyToMail',
						type:'get',
						data:{
							replyDiscard: draftReplyId,openMailId:mailId
						},
					success : function() {
						location.reload(true);
					}
					})
				});
				$("#replySendButton").click(function(){
					if($('.summernote').summernote('code')!="<p><br></p>"){
						var sentReplyId=$(this).data('rdraftdiscardid');
						$.ajax({
							url: 'replyToMail',
							type:'get',
							data:{
								replySent: sentReplyId
							},
						success : function() {
							location.reload(true);
						}
						})
					}else{
						alert("111111")
					}
				});
				$("#datePickBtn").click(function(){
					$("#datepicker-autoclose").focus();
				});
				function newMailAlert(){
					$.ajax({
						url: 'ChkForNewMail',
						type:'get',
					success : function(result) {
						var mailInfo=JSON.parse(result);
						if(mailInfo!=null){
							toastr.options.showMethod = 'show';
							toastr.options.hideMethod = 'hide';
							toastr.options.closeMethod = 'hide';
							toastr.options.positionClass = "toast-top-right",
							toastr.options.progressBar = true;
							toastr.options.onclick = function() {window.location.href = "home.jsp" } 
							toastr.info(mailInfo.mailSubject,mailInfo.senderName);
							$("#inboxArea").load("home.jsp" + " #inboxArea");
							inboxCount();
						}
						setTimeout(newMailAlert,5000);
					}
					});
				}
				function minimizeManu(){
					$("#composeButton").hide();
					$("#composeMiniButton").show();
				}
				function maximizeManu(){
					$("#composeButton").show();
					$("#composeMiniButton").hide();
				}
				function composeAjax (isDraft){
					$.ajax({
						url: 'composeMail',
						type:'post',
						data:{
							sendTo: $("#sendTo").val(),
							subject:$("#mailSubject").val(),
							mailContent: $('.summernote').summernote('code'),
							setAsDraft:isDraft,
							isEdit:isDraftEdit,
							draftId:draftEditId
						},
					success : function() {
						isDraftEdit=false;
						draftCount();
						location.reload(true);
						
					}
					});
				}
			});
//------------------------------------------------------
			function draftEdit(draftMailId){
				isDraftEdit=true;
				draftEditId=draftMailId;
				$.ajax({
					url:'draftEdit',
					data:{
						mailDreftId: draftMailId
					},
				success : function(responseValue) {
					var setValueToCompose=JSON.parse(responseValue);
					$("#sendTo").val(setValueToCompose.sentTo);
					$("#mailSubject").val(setValueToCompose.subject);
					$('.summernote').summernote('code', setValueToCompose.content);
				}
				});
				$.ajax({
					url:'UploadServlet',
					type:'post',
					data:{iscomposeTrigger:false,editmailId:draftEditId},
					success : function() {
					}
				});
				$.ajax({
					url:'getUploadFileInfo',
					type:'get',
					data:{mailID:draftMailId},
				success:function(filesData){
					var fileInfo= JSON.parse(filesData);
					uploadFiles=fileInfo;
						$.getScript("assets/pages/custom.dragdrop.jquery.fileuploader.js");
				}
				});
				$.ajax({
					url: 'composeMail',
					type:'post',
					data:{
						isEdit:isDraftEdit,
						setAsDraft:0,
						draftId:draftMailId
					}
				});
			}
			function delFrmTrash(){
				var selectedMailsObj = [];
	            $.each($("input[name='mailSelect']:checked"), function(){            
	            	selectedMailsObj.push($(this).val());
	            });
	            console.log("->"+selectedMailsObj.join());
	            var selectedMails=selectedMailsObj.join("*").split("*");
	            $.ajax({
	            	url:'delectFrmTrash',
	            	data:{
	            		selectMails:selectedMails
	            	},
	            success : function() {
	            	trashCount();
	            	$("#trashArea").load("trash.jsp" + " #trashArea");
				}
	            });
			}
			function replyToTrash(trashReplyId,mainMailId){
				$.ajax({
					url: 'moveToTrash',
					type:'get',
					data:{
						replyId: trashReplyId,replyOf:mainMailId
					},
				success : function() {
					$("#mailReadArea").load("readMail?mi@-=" + mainMailId + " #mailReadArea");
				}
				})
			}
			function mailPrint(mailId,from){
				window.open("mailPrintOut?mi@-="+mailId+"~"+from);
			}
			function readMail(inboxMailId){
				document.location.href = "readMail?mi@-="+inboxMailId; 
			}
			function fileDownload(attachedFileName){
				document.location.href = "FileDownload?mi@-="+attachedFileName; 
			}
			function composeOpen(){
				replyInFocus=false;
				$.getScript("assets/pages/custom.dragdrop.jquery.fileuploader.js");
				$.ajax({
	            	url:'UploadServlet',
	            	type:'GET',
	            	data:{
	            		iscomposeTrigger:true
	            	},
	            success : function() {
				}
	            });
			}
			function passKeyGenerate(idOfUser,type){
				$.ajax({
					url:'creatPassKeyQR',
					data:{keyFor:idOfUser,isRegenerate:type},
					success : function(responseText) {
						
					}
				});
			}
			function draftCount(){
				$.ajax({
					url:'draftCount',
					success : function(responseText) {
						$('#totalDraft').text(responseText);
					}
				});
			}
			function inboxCount(){
				$.ajax({
					url:'inboxCount',
					success : function(responseText) {
						$('#totalUnseen').text(responseText);
					}
				});
			}
			function trashCount(){
				$.ajax({
					url:'trashCount',
					success : function(responseText) {
						$('#totalTrash').text(responseText);
					}
				});
			}
	     
