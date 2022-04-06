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
</style>
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<input type="hidden" value = "${user}" id="user">
<div id ="main-body">
<section  class="container mb-4">
	
	<div class="result_posts">
		<div class="posts d-flex flex-wrap justify-content-start mt-2">
		<a href="addPost">추가 ㄱ</a>
			<c:forEach items="${list}" var="post" >
				<div class="post mr-2">
					<div class="post-top border rounded">
						<img class="titleimg" style="cursor : pointer;" width="280px" src="../images/${post.titleImage}" data-value="${post.postNo}" data-toggle="modal" data-target="#modal-reg">
					</div>
					<div class="post-bottom border text-center" style="overflow: hidden;">
						
						<c:choose>
							<c:when test ="${empty user}">
								<i class="fa-solid fa-heart" style="color:red;"></i>${post.likes}
							</c:when>
							
							<c:otherwise>
								<c:choose>
									<c:when test="${0 == post.heart}">
										<i class="fa-solid fa-heart like" data-postno="${post.postNo}" style="color:black; cursor : pointer;"></i>${post.likes}
									</c:when>
									
									<c:otherwise>
										<i class="fa-solid fa-heart like" data-postno="${post.postNo}" style="color:red; cursor : pointer;"></i>${post.likes}	
									</c:otherwise>
								</c:choose>			
							</c:otherwise>	
						</c:choose>					  
						<i class="fa-solid fa-comment-dots"></i>&nbsp;${post.comments}
						<i class="fa-solid fa-eye"></i>&nbsp;${post.views}
					</div>
				</div>
			</c:forEach>
			
		</div>
	</div>
</section>
</div>
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
                            <div class="col-2 likes">
                           		<!-- 좋아요 갯수 들어감 -->
                            </div>
                            <div class="col-2 views">
                           		
                            </div>
                            <div class="col-2 comment_total">
                           		<!-- 댓글 갯수 들어감 -->
                            </div>
                            <div class="col-6 location">
                           		<!-- 댓글 갯수 들어감 -->
                            </div>
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
            <c:if test="${user == post.email}">
        	<div class="modal-footer">
        		<a class="btn btn-outline-success modify" href="#" role="button">Modify</a>
                <a class="btn btn-outline-danger delete" href="#" role="button" onclick="deleteCheck()">Delete</a>
        	</div>
        	</c:if>
        </div>
    </div>
</div>


<%@ include file="../includes/footer.jsp" %>

</body>
</html>
