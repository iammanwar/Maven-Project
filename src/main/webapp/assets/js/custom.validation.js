var resizefunc = [];
    $(document).ready(function(){
    	jQuery.validator.addMethod("noSpace", function(value, element) { 
    		  return value.indexOf(" ") < 0 && value != ""; 
    		}, "No space please and don't leave it empty");
    	
    	jQuery.validator.addMethod("noAtTheRate", function(value, element) { 
  		  return value.indexOf("@") < 0 && value != ""; 
  		}, "Don't use @ sign");

    	jQuery.validator.addMethod("dakAddressChk", function(value, element) { 
    		alert("vlid dak");
  		  return value.indexOf("@dak.com") >= 0 && value != ""; 
  		}, "Don't use extera sign");
    	
		$.validator.addMethod("chkAge", function (value, element) {
		
		var dateOfBirth = value;
		var arr_dateText = dateOfBirth.split("/");
		day = arr_dateText[0];
		month = arr_dateText[1];
		year = arr_dateText[2];
		
		var mydate = new Date();
		var myyear=mydate.setFullYear(year, month - 1, day);
		var maxDate = new Date();
		var year=maxDate.setYear(maxDate.getFullYear() - 16);
		if ((maxDate - mydate) <0 ) {
			$.validator.messages.chkAge = "Minimum age should be 16 years.";
			return false;
		}
		return true;
	});
		$('#email').keyup(function()
				{
					var yourInput = $(this).val();
					re = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi;
					var isSplChar = re.test(yourInput);
					if(isSplChar)
					{
						var no_spl_char = yourInput.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, '');
						$(this).val(no_spl_char);
					}
				});
    	
    	$("#createAccount").validate({
    	    rules :{
    	    	firstName : {
    	            required : true, 
    	        },
				lastName :{
					required : true,
				},
				email :{
					required:true,
					noSpace: true,
					noAtTheRate:true
				},
				password :{
					required:true,
					minlength: 8
				},
				confiemPassword:{
					required:true,
					 equalTo: "#password"
				},
				phoneNmber:{
					required: true,
					minlength:10,
					maxlength:10
				},
				gender:{
					required:true
				},
				dateOfBirth:{
					required: true,
					chkAge: true
				}
    	    },
    	    messages :{
    	    	firstName :{
    	            required : 'Enter first name'
    	        },
				lastName :{
					required : 'Enter last name'
				},
				email :{
					required:'Choose an address'
				},
				password :{
					required:'Enter a password',
					minlength:'Use 8 characters or more for your password'
				},
				confiemPassword :{
					required:'Confirm your password',
					equalTo:"Those passwords didn't match. Try again."
				},
				phoneNmber:{
					required:'Enter a phone number',
					minlength:'This phone number format is not recognized. Please check the number.',
					maxlength:'This phone number format is not recognized. Please check the number.'
				},
				gender:{
					required:'Select one'
				},
				dateOfBirth:{
					required: 'Enter date of birth'
				}
    	    }
    	    });
    	$("#signInAccount").validate({
    	    rules :{
				email :{
					required:true,
				},
				password :{
					required:true,
				}
    	    },
    	    messages :{
				email :{
					required:'Enter your Dak ID'
				},
				password :{
					required:'Enter your password',
				}
    	    }
    	    });
    	$("#composeMailFrm").validate({
    		rule:{
    			required:true
    		},
    		messages:{
    			required:'Please specify at least one recipient.'
    		}
    	})
    });