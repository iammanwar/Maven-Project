$(document).ready(function() {
	$('input[name="files"]').fileuploader({
		limit:6,
		extensions: ['jpg', 'jpeg', 'png', 'gif', 'pdf','bmp','pptx','ppt','docx','doc','xlsx','xls','txt','mp3','mp4','avi','psd'],
		fileMaxSize:25,
        changeInput: '<div class="fileuploader-input">' +
					      '<div class="fileuploader-input-inner">' +
						      '<img src="plugins/fileuploader-master/images/fileuploader-dragdrop-icon.png">' +
							  '<h3 class="fileuploader-input-caption"><span>Drag and drop files here</span></h3>' +
							  '<p>or</p>' +
							  '<div class="fileuploader-input-button"><span>Browse Files</span></div>' +
						  '</div>' +
					  '</div>',
        theme: 'dragdrop',
		upload: {
            url: 'replyToMail',
            data: null,
            type: 'POST',
            enctype: 'multipart/form-data',
            start: true,
            synchron: true,
            beforeSend: null,
            onSuccess: function(result, item) {
                var data = JSON.parse(result);
                var isBol=false;
                //isDraftEdit=data.draftEditOn;
               // draftEditId=data.draftId;
                if(data.uploadFileName!='') {
                    item.name = data.uploadFileName;
                }
                item.html.find('.column-actions').append('<a class="fileuploader-action fileuploader-action-remove fileuploader-action-success" title="Remove"><i></i></a>');
                setTimeout(function() {
                    item.html.find('.progress-bar2').fadeOut(400);
                }, 400);
                draftCount();
            },
            onError: function(item) {
				var progressBar = item.html.find('.progress-bar2');
				
				if(progressBar.length > 0) {
					progressBar.find('span').html(0 + "%");
                    progressBar.find('.fileuploader-progressbar .bar').width(0 + "%");
					item.html.find('.progress-bar2').fadeOut(400);
				}
                
                item.upload.status != 'cancelled' && item.html.find('.fileuploader-action-retry').length == 0 ? item.html.find('.column-actions').prepend(
                    '<a class="fileuploader-action fileuploader-action-retry" title="Retry"><i></i></a>'
                ) : null;
            },
            onProgress: function(data, item) {
                var progressBar = item.html.find('.progress-bar2');
				
                if(progressBar.length > 0) {
                    progressBar.show();
                    progressBar.find('span').html(data.percentage + "%");
                    progressBar.find('.fileuploader-progressbar .bar').width(data.percentage + "%");
                }
            },
            onComplete: null,
        },
        
        files:replyUploadFiles,
//     		   [
//	        	{
//					name: "1.jpg",
//					size: 145,
//					type: "image/jpg",
//					file: "assets/images/small/img-1.jpg"
//				},
//				{
//					name: "2.jpg",
//					size: 145,
//					type: "image/jpg",
//					file: "assets/images/small/img-2.jpg"
//				},
//				],
		onRemove: function(item) {
			$.get('replyToMail', {
				file: item.name,
				//mailId:draftEditId
			});
		},
		captions: {
            feedback: 'Drag and drop files here',
            feedback2: 'Drag and drop files here',
            drop: 'Drag and drop files here'
        },
	});
	
});