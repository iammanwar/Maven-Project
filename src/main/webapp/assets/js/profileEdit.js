$(document).ready(function(){
//	$('#editBtn').click(function(e){
//		var target = $(e.target), article;
//		if($(target).attr('class')=='fa fa-pencil fa-lg'){
//			$('#firstNameEdit').prop('disabled',false);
//			$('#firstNameEdit').focus();
//			//$('#btnIcon').removeClass('fa fa-pencil fa-lg').addClass('fa fa-check fa-lg');
//			$('#btnIcon').removeClass('fa fa-pencil fa-lg').addClass('fa fa-times fa-lg');
//			$('#firstNameEdit').keyup(function(){
//				$('#submitBtn').show();
//				$('#editBtn').hide();
//			});
//		}else{
//			$('#btnIcon').removeClass('fa fa-times fa-lg').addClass('fa fa-pencil fa-lg');
//			$('#firstNameEdit').prop('disabled',true);
//		}
//		
//	});
	var isAlertShow=false;
	$('#testDive').click(function(){
		$('#test').fadeIn();
	});
	var inputDisabled=true;
	$('button').click(function(){
		var element=this.name;
		var elementId='#'+element;
		if(inputDisabled){
			$(elementId).prop('disabled',false);
			inputDisabled=false;
			$(elementId+'BtnIcon').removeClass('fa fa-pencil fa-lg').addClass('fa fa-times fa-lg');
			//alert(elementId);
			var elementType=$(elementId).prop('tagName');
			//alert(elementType);
			if(elementType=='SELECT'){
				$(elementId).change(function(){
					//alert(this.name);
					$(elementId+'Btn').hide();
					$(elementId+'SubmitBtn').show();
				});
			}else{
				$(elementId).focus();
				$(elementId).keyup(function(){
					
						$(elementId+'Btn').hide();
						$(elementId+'SubmitBtn').show();
					
					
				});
			
			}
		}else{
			$(elementId).prop('disabled',true);
			inputDisabled=true;
			$(elementId+'BtnIcon').removeClass('fa fa-times fa-lg').addClass('fa fa-pencil fa-lg');
		}
		$(elementId+'SubmitBtn').click(function(){
			var changeValue=$(elementId).val();
			$.ajax({
				url: 'AccountUpdate',
				type:'get',
				data:{
					updateValue:changeValue,updateThe:$(elementId).attr("name")
				},
			success : function(result) {
				toastr.options.showMethod = 'show';
				toastr.options.showMethod = 'slideDown';
				toastr.options.hideMethod = 'slideUp';
				toastr.options.closeMethod = 'slideUp';
				toastr.options.positionClass = "toast-top-center",
				toastr.options.progressBar = true;
				toastr.success('','Yours account details updated');
				toastr.clear();
				$(elementId+'Btn').show();
				$(elementId+'SubmitBtn').hide();
				$(elementId).prop('disabled',true);
				inputDisabled=true;
				$(elementId+'BtnIcon').removeClass('fa fa-times fa-lg').addClass('fa fa-pencil fa-lg');
			}
			});
		});
	});
	$('#cPasswordBtn').click(function(){
		$('#lastChange').fadeOut();
		$('#newPassword').fadeIn();
		$('#cPasswordBtn').hide()
		$('#uPasswordBtn').show();
		$('#newPassword').focus();
		$('#uPasswordBtn').click(function(){
			var newPassword=$('#newPassword').val();
			if(newPassword==''){
				errorAlert('Enter a password.');
			}else if(newPassword.length<8){
				errorAlert('Use 8 characters or more for your password.');
			}else{
				$.ajax({
					url: 'AccountUpdate',
					type:'get',
					data:{
						updateValue:newPassword,updateThe:'password'
					},
				success : function(result) {
					$('#newPassword').val('');
					$('#lastChange').html('Last Change:Now');
					$('#lastChange').show();
					$('#newPassword').hide();
					$('#cPasswordBtn').show()
					$('#uPasswordBtn').hide();
				} 
				});
			}
			
		});
	});
	$('#securityQShow').click(function(){
		$('#securityQArea').show();
		$('#securityQShow').hide();
		$('#securityQSelection').change(function(){
			var selectedSQ=$('#securityQSelection').val();
			if(selectedSQ==='X'){
				$('#securityAArea').fadeOut();
				$('#securityQArea').fadeOut();
				$('#securityQShow').delay(400).fadeIn();
				$('#questionAns').val('');
			}else if(selectedSQ==='qChoose') {
				$('#securityAArea').fadeOut();
				$('#questionAns').val('');
			}else{
				$('#securityAArea').fadeIn();
				$('#securityAUpdate').click(function(){
					var sqAns=$('#questionAns').val();
					if(sqAns===''){
						errorAlert('Looks like it\'s not an answar');
					}else{
						if(isAlertShow){
							$('#errorAlertArea').fadeOut();
						}
						$.ajax({
							url: 'AccountUpdate',
							type:'post',
							data:{
								selectQ: selectedSQ , yourAns: sqAns
							},
						success : function(result) {
							$('#securityAArea').fadeOut();
							$('#securityQArea').fadeOut();
							$('#securityQShow').delay(400).fadeIn();
							$('#questionAns').val('');
						}
						})
					}
				});
			}
		});
	});
	$('#recoverPhoneShow').click(function(){
		$('#recoveryPhoneArea').fadeIn();
		$('#recoverPhoneShow').hide();
		$('#recoveryPhoneHide').click(function(){
			$('#recoveryPhoneArea').fadeOut();
			$('#recoverPhoneShow').delay(400).fadeIn();
			if(isAlertShow){
				$('#errorAlertArea').fadeOut();
			}
		});
		$('#recoveryPhoneUpdateBtn').click(function(){
			var inputRecoverPhone=$('#recoveryPhone').val();
			if(inputRecoverPhone===''){
				errorAlert('Are you sure it\'s your phone number.');
			}else{
				$.ajax({
					url: 'AccountUpdate',
					type:'get',
					data:{
						updateValue: inputRecoverPhone , updateThe: 'mobileNumber'
					},
				success : function(result) {
					$('#recoverPhoneShow').html(inputRecoverPhone);
					$('#recoveryPhoneArea').fadeOut();
					$('#recoverPhoneShow').delay(400).fadeIn();
					if(isAlertShow){
						$('#errorAlertArea').fadeOut();
					}
					$('#recoveryPhone').val('');
				}
				})
			}
		});
	});
	function errorAlert(message){
		if(!isAlertShow){ 
			$("#accountHead").after('<div id="errorAlertArea"class="animated fadeIn"style="background-color: #ffcc56;"><h5 id="dakValidationAlert"class="font-10" style="text-align: center;margin: 0px;padding: 4px;color: #fff;font-size: small;">'+message+'</h5></div>');
			isAlertShow=true;
			}else{
				$("#dakValidationAlert").html(message);
			}
	}
});