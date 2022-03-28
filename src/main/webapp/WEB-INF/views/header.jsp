<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-default fixed-top border-bottom pt-3 bg-white">
	<div class="container">
		<div class="navbar-header">
			<a href="home" class="navbar-brand">
				<i class="menu-icon fa-solid fa-house"></i>
			</a>
		</div>
		
		<div>
			<form action="searchPage" id="serachPage">
				<div class="input-group border rounded bg-light">
			    	<div class="input-group-btn">
			    		
			        	<select class="form-control"  name="searchVal">
			        		<option value="writer" selected>작성자</option>
			        		<option value="title">제목</option>
			        		<option value="content">내용</option>
			        		<option value="location">장소</option>
			        		<option value="hashtag">#HashTag</option>
			        	</select>
			      	
			      	</div>
			      	<input type="text" class="form-control bg-light mr-1" name="keyword" size="30" aria-label="000" placeholder="search...">
		    		<button type="submit" class="btn btn-default mr-1"><i class="fa-brands fa-sistrix"></i></button>	      	
			    </div>
		    </form>
		</div>
		
		<ul class="nav navbar">
			<li class="mr-4">
				<a href="feed">
					<i class="menu-icon fa-regular fa-circle-user"></i>
				</a>
			</li>
			
			<li class="mr-4">
				<a href="#">
					<i class="menu-icon fa-regular fa-bell"></i>
				</a>
			</li>
			
			<li class="mr-4">
				<a href="#">
					<i class="menu-icon fa-regular fa-comment-dots"></i>
				</a>
			</li>
		</ul>
		
	</div>		

</nav>


