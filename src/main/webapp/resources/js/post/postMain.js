
$(document).ready(function() {
	
	
	let postNo = "";
	let email = $('#user').attr('value');
	
	
	
	$(".titleimg").click(function(){
        postNo = $(this).attr("data-value");
		email = $('#user').attr('value');
		
		
		if(email!=="" && email!==null && email!=="null"){
			addview();
		}
		
		$.ajax({
            url:"getlist.do",
            data:{
				postNo:postNo,
				email : email},
            type:"post",
 		    beforeSend: function(xhr){
	 		   	var token = $("meta[name='_csrf']").attr('content');
	 			var header = $("meta[name='_csrf_header']").attr('content');
 		        xhr.setRequestHeader(header, token);
 		    },
            success:function(data){
				console.log(data);
                var Citem = "";
                var userNickname="";
                var postContent="";

            	let email = data[0].email;
            	let likes = data[0].likes;
            	let content = data[0].content;
            	let comment_total = data[0].comments;
            	let location = data[0].location;
            	let views = data[0].views;
            	let images = data[0].images.split('/');
            	let postNo = data[0].postNo;
            	let heartCheck =data[0].heartCheck;
            	for(var i=0; i<images.length-1; i++){
                    if(i==0){
                       Citem+='<div class="carousel-item active"><img src="../images/'+images[i]+'"></div>';
                    }else{
                       Citem+='<div class="carousel-item"><img src="../images/'+images[i]+'"></div>';
                    }
                }
              
            	
				if(heartCheck==0){
					likes ='<i class="modal-icon fa-regular fa-heart modal-like" data-postno="'+postNo+'"></i>'+
            			'<span id="likeCount">'+likes+'</span>';
            	}else{
					likes ='<i class="modal-icon fa-regular fa-heart modal-like active" data-postno="'+postNo+'"></i>'+
            			'<span id="likeCount">'+likes+'</span>';
				}

				views ='<i class="modal-icon fa-regular fa-eye"></i>'+views;
            	comment_total ='<i class="modal-icon fa-regular fa-comment-dots"></i>'+comment_total;

				

				//내용 넣는 프로세스
                $(".Citem").html(Citem);
                $(".email").html(email);
                $(".content").html(content);
                $(".likes").html(likes);
                $(".comment_total").html(comment_total);
                $(".views").html(views);
                $(".location").html(location);
                $(".modify").attr('href','post/modify?postNo='+postNo);
                $(".delete").attr('href','post/delete.do?postNo='+postNo);
            },
            error:function(){
                console.log("ajax1 처리 실패");
            }
        });
   		getComments();
    });
		modalLike();

	function addview(){
		$.ajax({
			url :'addView.do',
			data : {
				postNo : postNo,
				email : email},
			type : 'post',
			beforeSend: function(xhr){
		 	   	var token = $("meta[name='_csrf']").attr('content');
		 		var header = $("meta[name='_csrf_header']").attr('content');
	 		    xhr.setRequestHeader(header, token);
	 		},
			success : function () {
			},
			error : function () {
				console.log('failed view up');
			}
		});
	}
	
	$('.addcomment').click(function () {

		let content = $('.comment').val();
		let grpl = $('.grpl').attr('data-value');
		
		$.ajax({
			url : 'addcomments.do',
			type : 'post',
			data : {postNo : postNo,
					content : content,
					grpl : grpl,
					email : email},
			beforeSend: function(xhr){
		 	  	var token = $("meta[name='_csrf']").attr('content');
		 		var header = $("meta[name='_csrf_header']").attr('content');
	 		    xhr.setRequestHeader(header, token);
	 		},
	 		success : function () {
	 			console.log('success');
	 			getComments();
				
	 			$('.comment').val("");
			},
			error : function () {
				console.log('ERROR');
			}
			
		});
	});

	
	function modalLike(){
			$(document).on('click','.modal-like' ,function(){
			var element = $(this);
     	 	postNo = $(this).attr('data-postno');
			
			$.ajax({
	        	url :'addLike.do',
	         	data : {
	            	postNo : postNo,
	                email : email
	            },
	         	type : 'post',
	         	beforeSend: function(xhr){
	            	var token = $("meta[name='_csrf']").attr('content');
	            	var header = $("meta[name='_csrf_header']").attr('content');
	            	xhr.setRequestHeader(header, token);
	         	},
	        	success : function(info) {
	            	if ( info == 'add' ) {
	               		element.addClass('active');
	               		element.siblings('#likeCount').text(Number(element.siblings('#likeCount').text())+1);
	            	} else {
	               		element.removeClass('active');
	               		element.siblings('#likeCount').text(Number(element.siblings('#likeCount').text())-1);
	       		    }
	

	            	console.log('하트날리기 성공');   
	        	},
	         	error : function () {
	            	console.log('하트날리기 실패');
	        	}
    		});
		});
	}
		
	function getComments() {
		let comments ="";
		$.ajax({
	        url:"getcomments.do",
	        data:{postNo:postNo},
	        type:"post",
			beforeSend: function(xhr){
		 	  	var token = $("meta[name='_csrf']").attr('content');
		 		var header = $("meta[name='_csrf_header']").attr('content');
			    xhr.setRequestHeader(header, token);
			    },
	        success:function(data){
		           	for(var i=0; i<data.length; i++){
						comments += '<div class="coment-block row mx-0 my-1 d-flex">';
		           		for(var y=0; y < data[i].grpl; y++){
		           			comments += '<span>&nbsp;</span>';
						}
						comments +=	'<div class="profile-img-xxs col-1 px-0">';
						comments +=	'<div class="img-xxs border"></div>';
						comments +=	'</div>';
						comments +=	'<span class="col-3 pl-1" style="font-size: 14px; font-weight: 600;">' + data[i].email + '</span>';
		           		comments += '<span class="col-6 px-0 comment-text" style="font-size: 13px;">'+data[i].content+'</span>';
						comments += '<span class="replyClick col-1 px-0" data-count="0" style="font-size: 5px; cursor : pointer;">답글</span>';
						comments += '<i class="fa-solid fa-x deleteRe" style="font-size:5px; color:red; cursor : pointer;" data-no="'+data[i].commentNo+'"></i><br/>';
						comments += '<div class="form-group col-12 row mx-0">';
						comments += '<input type="text" class="col-10 recomment" data-grp="'+data[i].grp+'" data-grpl="'+data[i].grpl+'" data-grps="'+data[i].grps+'">';
						comments += '<input type="button" class="btn btn-sm btn-outline-success addreplyComment ml-1" role="button" value="전송">';
						comments += '</div>';
						comments += '</div>';
						comments += '</div>';
		           	}
		           	
					$('.comments').html(comments);
					
					$('.replyClick').click(function () { //re댓글 작성
						
						var count = $(this).attr('data-count');
						
						if ( count == 0 ) {
							$(this).siblings('.form-group').css('display', 'flex');
							$(this).attr('data-count', Number(count)+1);
						} else {
							$(this).siblings('.form-group').css('display', 'none');
							$(this).attr('data-count', 0);
						}
						
						
						$('.addreplyComment').click(function () {
							let content = $(this).siblings('.recomment').val();
							let grp = $(this).siblings('.recomment').attr('data-grp');
							let grpl = $(this).siblings('.recomment').attr('data-grpl');
							let grps = $(this).siblings('.recomment').attr('data-grps');
							console.log(email);

							$.ajax({
								url : 'addReplyComments.do',
								type : 'post',
								data : {postNo : postNo,
										content : content,
										grp : grp,
										grpl : grpl,
										grps : grps,
										email : email},
								beforeSend: function(xhr){
							 	  	var token = $("meta[name='_csrf']").attr('content');
							 		var header = $("meta[name='_csrf_header']").attr('content');
						 		    xhr.setRequestHeader(header, token);
						 		},
						 		success : function () {
						 			console.log('success');
						 			getComments();
								},
								error : function () {
									console.log('ERROR');
								}
								
							});
						});
						
					});
					
					$('.deleteRe').click(function () { //re댓글 삭제
					

						let commentNo = $(this).attr('data-no');
					
						$.ajax({
							url : 'deleteReplyComments.do',
							type : 'post',
							data : {commentNo : commentNo},
							beforeSend: function(xhr){
						 	  	var token = $("meta[name='_csrf']").attr('content');
						 		var header = $("meta[name='_csrf_header']").attr('content');
					 		    xhr.setRequestHeader(header, token);
					 		},
					 		success : function () {
					 			console.log('success');
					 			getComments();
							},
							error : function () {
								console.log('ERROR');
							}
							
						});
						
					});
	         },
	         error:function(){
	             console.log("ajax 처리 실패");
	         }

	     });
	}
	
	
});



function deleteCheck(){
    if(confirm("삭제하시겠습니까?")){
        return true;
    } else {
    	$(".delete").attr('href','post/list');
        return false;
    }
}
