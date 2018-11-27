var  mp4 = new Mprogress({
        template: 4,
        parent: '#processBar',
    });
$(document).ready(function(){
	var isAlertShow=false;
	var isAlertFadeOut=false;
	$("#forgrtPassword").click(function(){
		$("#accountContent").load("accountRecoverDiv.jsp",function(){
		});
	});
	$("#gotoVerification").click(function(){
		var acRecoverFor=$('#recoverDakAddressInput').val();
		var chkId=acRecoverFor.substr(acRecoverFor.indexOf("@")+1);
		if(acRecoverFor==''){
			errorAlert('Enter a valid Dak address.');
		}else if(chkId != 'dak.com'){
			errorAlert('Enter a valid Dak address.');
		}else{
			$('#processBar').fadeIn();
			mp4.start();
			$.ajax({
				url: 'AccountRecover',
				type:'get',
				data:{
					revcoverArrdess: $("#recoverDakAddressInput").val()
				},
			success : function(result) {
				 	mp4.end(true);
		            $('#processBar').delay(500).fadeOut();
				if(result=="notExists"){
					errorAlert('Couldn\'t find your Dak Account')
				}else{
					$("#accountContent").load("accountVerificationDiv.jsp");
					if(isAlertShow){
						$('#errorAlertArea').remove();
					}
					
				}
			}
			})
		}
		
	});
	$('#qrUpload').change(function(){
		$('#processBar').fadeIn();
		mp4.start();
		$('.jFiler-input-dragDrop').hide();
	});
	$('#gotoNewPassword').click(function(){
		$("#accountContent").load("newPasswordDiv.jsp");
	});
	$('#newPassword').blur(function(){
		var newPassword=$('#newPassword').val();
		if(newPassword==''){
			errorAlert('Enter a password.');
		}else if(newPassword.length<8){
			errorAlert('Use 8 characters or more for your password.');
		}else{
			if(isAlertShow){
				$('#errorAlertArea').fadeOut();
				isAlertFadeOut=true;
			}
			$('#cfrmPassword').keyup(function(){
				var cPassword=$('#cfrmPassword').val();
				if(newPassword!=cPassword){
					errorAlert('Those passwords didn\'t match.');
					$('#newPasswordBtn').prop('disabled',true);
				}else{
					if(isAlertShow){
						$('#errorAlertArea').fadeOut();
						isAlertFadeOut=true;
					}
					$('#newPasswordBtn').prop('disabled',false);
					$('#newPasswordBtn').click(function(){
						$.ajax({
							url: 'AccountRecover',
							type:'get',
							data:{
								newPassword:cPassword
							},
						success : function(result) {
							$("#accountContent").load("loginDiv.jsp");
						} 
						});
					});
				}
			});
		}
	});
	
	
	function errorAlert(message){
		if(isAlertFadeOut){
			$('#errorAlertArea').fadeIn();
			isAlertFadeOut=false;
		}
		if(!isAlertShow){ 
			$("#accountHead").after('<div id="errorAlertArea"class="animated fadeIn"style="background-color: #ffcc56;"><h5 id="dakValidationAlert"class="font-10" style="text-align: center;margin: 0px;padding: 4px;color: #fff;font-size: small;">'+message+'</h5></div>');
			isAlertShow=true;
			}else{
				$("#dakValidationAlert").html(message);
			}
	}
});