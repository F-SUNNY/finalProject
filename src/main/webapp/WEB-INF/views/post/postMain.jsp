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
<script src="../js/post/postMain.js"></script>

<link rel="stylesheet" type="text/css" href="../css/includes/header.css" />
<link rel="stylesheet" type="text/css" href="../css/search/searchResult.css" />
<link rel="stylesheet" type="text/css" href="../css/includes/footer.css" />
<title>List</title>
<style>
ul{
   list-style:none;
   }
.like.active {
	color: red;
}
.modal-like.active {
	color: red;
}
.profile-img-xs {
	display: flex;
	align-items: center;
	padding-top: 0.5px;
}
.post-nickname, bottom-likes, bottom-comments, bottom-views {
	height: 50%;
}
.img-xs {
	width: 100%;
	height: 90%;
	border-radius: 50%;
}
.userinfo, .status {
	height: 50%;
}
ul {
	list-style: none;	
}
.profile-img-s {
	height: 100%;
}
.img-s {
	width: 50px;
	height: 50px;
	border-radius: 50%;
}
.list-group-item:nth-child(3) {
	align-items: center;
}
input.comment,
input.recomment {
	width: 85%;
	border: none;
	border-bottom: 1px solid #dee2e6;
}
profile-img-xxs {
	height: 100%;
}
.img-xxs {
	width: 30px;
	height: 30px;
	border-radius: 50%;
}
.comments {
	height: 90%;
	overflow : auto;
}
.comments .coment-block {
	align-items: center;
}
span.comment-text {
	overflow-wrap: break-word;
}
.coment-block .form-group {
	display: none;
}
</style>
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<input type="hidden" value = "${user}" id="user">
<section class="container mb-4">
	<input type="hidden" id="modalBtn" data-toggle="modal" data-target="#myModal" value="modal" />

	<div class="result_posts">
		<div class="posts d-flex flex-wrap justify-content-start mt-2">
			<c:forEach items="${list}" var="post" >
				<div class="post mr-2">
					<div class="post-top border rounded">
						<img class="titleimg" style="cursor : pointer;" width="280px" src="../images/${post.titleImage}" data-value="${post.postNo}" data-toggle="modal" data-target="#modal-reg">
					</div>
					<div class="post-bottom border row mx-0">
						<div class="profile-img-xs col-3 px-0">
							<div class="img-xs border"></div>
						</div>
						
						<div class="info col-9 row mx-0 flex-wrap">
							<div class="post-nickname col-12 px-0 pt-2">
							${post.email}
							</div>
						
							<div class="bottom-likes col-4 px-0">
								<c:choose>
									<c:when test ="${empty user}">
										<i class="fa-solid fa-heart" data-postno="${post.postNo}"></i>
									</c:when>
		
									<c:when test="${post.heart == 0}">
										<i class="fa-solid fa-heart like" data-postno="${post.postNo}"></i>						
									</c:when>
									
									<c:otherwise>
										<i class="fa-solid fa-heart like active" data-postno="${post.postNo}"></i>
									</c:otherwise>
								</c:choose>
									<span id="likeCount">${post.likes}</span>
							</div>
								
							<div class="bottom-comments col-4 px-0">		  
								<i class="fa-solid fa-comment-dots"></i>
								<span id="commentCount">${post.comments}</span>
							</div>
							<div class="bottom-views col-4 px-0">
								<i class="fa-solid fa-eye"></i>
								<span id="viewCount">${post.views}</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>
<!--  modal And Caouosel -->
<!-- modal 창 -->
<div class="modal fade" id="modal-reg" role="dialog">
	<div class="modal-dialog modal-dialog-centered modal-xl d-block">
		<button type="button" id="modalCloseBtn" class="btn btn-lg btn-default text-white text-weight-bold display-1 float-right" data-dismiss="modal">&times;</button>
		<div class="modal-content">
			<div class="modal-body bg-light d-flex justify-content-between">
				<div class="post-img border rounded mr-2">
					<div id="demo" class="carousel slide" data-ride="carousel">
                    	<!-- The slideshow -->
                        <div class="carousel-inner Citem">
                        	<!-- 이미지 등록 -->
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
					<li class="list-group-item d-flex row mx-0 mb-1">
						<div class="profile-img-s col-2 px-0">
							<div class="img-s border"></div>
						</div>
						
						<div class="col-10">
							<div class="email">
								<!-- 닉네임 -->
							</div>
							
							<div class="location ">
								<!-- 장소 -->
							</div>
						</div>
					</li>
					
					
					<li class="list-group-item mb-1 content">
					<!-- 컨텐츠 내용 -->
					</li>
					
					<li class="list-group-item mb-1 d-flex row mx-0">
						
						<div class="col-4 likes">
						<!-- 좋아요 -->
						</div>
						
						<div class="col-4 views">
						<!-- 조회수 -->
						</div>
						
						<div class="col-4 comment_total">
						<!-- 댓글갯수 -->
						</div>
					</li>
					
					
					<li class="list-group-item">
                       	<input type="text" class="comment grpl" placeholder="comment" data-value="0">
                       	<button type="button" class="btn btn-sm btn-outline-success addcomment ml-1" role="button">전송</button>
					
						<div class="comments">
						</div>
					</li>

					<li>

                    </li>
				</ul>
			</div>
		</div>
	</div>
</div>


<%@ include file="../includes/footer.jsp" %>

</body>
</html>
