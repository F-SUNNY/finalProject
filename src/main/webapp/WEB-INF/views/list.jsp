<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>   
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://kit.fontawesome.com/b4e02812b5.js" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/header.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" type="text/css" href="css/footer.css" />
<link rel="stylesheet" type="text/css" href="css/search/main.css" />
<link rel="stylesheet" type="text/css" href="css/search/modalPost.css" />
<title>List</title>
<style>
ul{
   list-style:none;
   }
</style>


</head>
<body>
<%@ include file="header.jsp" %>

<section class="container mb-4">
	<div class="result_posts">
		<div class="posts d-flex flex-wrap justify-content-start mt-2">
			<c:forEach items="${list}" var="post" >
				<div class="post mr-2">
					<div class="post-top border rounded">
						<img class="titleimg" style="cursor : pointer;" width="280px" src="images/${post.titleImage}" data-value="${post.postNo}" data-toggle="modal" data-target="#modal-reg">
					</div>
					<div class="post-bottom border text-center" style="overflow: hidden;">
						<i class="fa-solid fa-heart" style="color:red; cursor : pointer;"></i>
						<i class="fa-solid fa-comment-dots"></i>
						<i class="fa-solid fa-eye"></i>&nbsp;${post.views}
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>

<!--  modal And Caouosel -->
<div class="modal fade" id="modal-reg">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-body bg-light d-flex justify-content-between">
                    <div class="post-img border rounded mr-2"><i class="modal-icon fa-regular fa-images" /></i>
                        <div id="demo" class="carousel slide" data-ride="carousel">
                            <!-- The slideshow -->
                            <div class="carousel-inner Citem">
                            </div>
                            <!-- Left and right controls -->
                            <a class="carousel-control-prev" href="#demo" data-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </a>
                            <a class="carousel-control-next" href="#demo" data-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </a>
                        </div>
                    </div>
                    <ul class="list-group d-block">
                        <li class="list-group-item mb-1"><i class="modal-icon fa-regular fa-circle-user"></i>
                        <ul class="userNickname">
                        	
                        </ul>
                        </li>
                        <li class="list-group-item mb-1"><i class="modal-icon fa-regular fa-rectangle-list"></i>
						<ul class="postContent">
                        	
                        </ul>
						</li>
                        <li class="list-group-item mb-1 d-flex row mx-0">
                            <div class="col-6"><i class="modal-icon fa-regular fa-heart"></i></div>
                            <div class="col-3"><i class="modal-icon fa-regular fa-bookmark"></i></div>
                            <div class="col-3"><i class="modal-icon fa-regular fa-comment-dots"></i></div>
                        </li>
                        <li class="list-group-item "><i class="modal-icon fa-regular fa-comment-dots comments"></i>
								
                        </li>
                        <li>
                        <div class="row">
                        <input type="text" class="col-sm-10 comment grpl" data-value="0">
                        <button type="button" class="btn btn-outline-success addcomment" role="button">전송</button>
                        </div>
                        </li>
                        
                    </ul>
                </div>
            <!-- Modal footer -->
        	<div class="modal-footer">
        		<a class="btn btn-outline-success modify" href="#" role="button">Modify</a>
                <a class="btn btn-outline-danger delete" href="#" role="button" onclick="deleteCheck()">Delete</a>
        	</div>
        </div>
    </div>
</div>


<%@ include file="footer.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	let postNo = "";
	$(".titleimg").click(function(){
        postNo = $(this).attr("data-value");
        
    
        $.ajax({
            url:"getlist.do",
            data:{postNo:postNo},
            type:"post",
 		    beforeSend: function(xhr){
	 		   	var token = $("meta[name='_csrf']").attr('content');
	 			var header = $("meta[name='_csrf_header']").attr('content');
 		        xhr.setRequestHeader(header, token);
 		    },
            success:function(data){
	           	var Cslide = "";
                var Citem = "";
                var userNickname="";
                var postContent="";

            	let email = data[0].email;
            	let title = data[0].title;
            	let content = data[0].content;
            	let location = data[0].location;
            	let titleImage = data[0].titleImage;
            	let images = data[0].images.split('/');
            	let postNo = data[0].postNo;
            	
            	for(var i=0; i<images.length-1; i++){
                    if(i==0){
                       Citem+='<div class="carousel-item active"><img src="images/'+images[i]+'"></div>';
                    }else{
                       Citem+='<div class="carousel-item"><img src="images/'+images[i]+'"></div>';
                    }
                }
               	
            	userNickname ='<li>'+email+'</li>';
            	postContent ='<li>'+content+'</li>';
            	
				//내용 넣는 프로세스
                $(".Citem").html(Citem);
                $(".userNickname").html(userNickname);
                $(".postContent").html(postContent);
                
                $(".modify").attr('href','modify?postNo='+postNo);
                $(".delete").attr('href','delete.do?postNo='+postNo);
            },
            error:function(data){
                console.log("ajax 처리 실패");
            }
        });
        
        getComments();
        
    });

	
	$('.addcomment').click(function () {
		
		let content = $('.comment').val();
		let grpl = $('.grpl').attr('data-value');
		

		$.ajax({
			url : 'addcomments.do',
			type : 'post',
			data : {postNo : postNo,
					content : content,
					grpl : grpl},
			beforeSend: function(xhr){
		 	  	var token = $("meta[name='_csrf']").attr('content');
		 		var header = $("meta[name='_csrf_header']").attr('content');
	 		    xhr.setRequestHeader(header, token);
	 		},
	 		success : function (data) {
	 			console.log('success');
	 			getComments();
	 			$('.comment').val("");
			},
			error : function (data) {
				console.log('ERROR');
			}
			
		});
	});

	
	
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
	        	 console.log(data);
		           	for(var i=0; i<data.length; i++){
		           		comments += '<div>';
						
		           		for(var y=0; y<data[i].grpl; y++){
		           		comments += '&nbsp;&nbsp;';
						}
		           		
		           		comments += '<span style="font-size:15px;">'+data[i].content+'</span>&nbsp;&nbsp;&nbsp;';
						comments += '<span class ="replyClick" style="font-size:5px; cursor : pointer;">답글달기</span>&nbsp;';
						comments += '<i class="fa-solid fa-heart" style="font-size:5px; color:red; cursor : pointer;"></i>&nbsp;';
						comments += '<span class ="addHeart" style="font-size:5px;">'+data[i].likes+'</span>&nbsp;';
						comments += '<i class="fa-solid fa-x deleteRe" style="font-size:5px; color:red; cursor : pointer;" data-no="'+data[i].commentNo+'" ></i><br/>';
						comments += '<div class="row">';
						comments += '<input type="hidden" class="col-xs-10 replyComment" data-grp="'+data[i].grp+'" data-grpl="'+data[i].grpl+'" " data-grps="'+data[i].grps+'">';
						comments += '<input type="hidden" class="btn btn-outline-success addreplyComment" role="button" value="전송"></input>';
						comments += '</div>';
						comments += '</div>';
		           	}
		           	
					$('.comments').html(comments);
					
					$('.replyClick').click(function () { //re댓글 작성
						
						$(this).siblings('.row').children('.replyComment').attr('type','text');
						$(this).siblings('.row').children('.addreplyComment').attr('type','button');
						
						
						$('.addreplyComment').click(function () {
							let content = $(this).siblings('.replyComment').val();
							let grp = $(this).siblings('.replyComment').attr('data-grp');
							let grpl = $(this).siblings('.replyComment').attr('data-grpl');
							let grps = $(this).siblings('.replyComment').attr('data-grps');
					

							$.ajax({
								url : 'addReplyComments.do',
								type : 'post',
								data : {postNo : postNo,
										content : content,
										grp : grp,
										grpl : grpl,
										grps : grps},
								beforeSend: function(xhr){
							 	  	var token = $("meta[name='_csrf']").attr('content');
							 		var header = $("meta[name='_csrf_header']").attr('content');
						 		    xhr.setRequestHeader(header, token);
						 		},
						 		success : function (data) {
						 			console.log('success');
						 			getComments();
								},
								error : function (data) {
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
					 		success : function (data) {
					 			console.log('success');
					 			getComments();
							},
							error : function (data) {
								console.log('ERROR');
							}
							
						});
						
					});
	         },
	         error:function(data){
	             console.log("ajax 처리 실패");
	         }
	     });
	}
	
	
});



function deleteCheck(){
    if(confirm("삭제하시겠습니까?")){
        return true;
    } else {
    	$(".delete").attr('href','list');
        return false;
    }
}
</script>
</body>
</html>
