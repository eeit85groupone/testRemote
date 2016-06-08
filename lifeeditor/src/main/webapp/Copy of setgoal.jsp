<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>測試版_設定目標</title>
<link href="css/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" href="css/main.css" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- <script src="js/validate.js"></script> -->

<style>
.set_goal {
	margin: auto;
	width: 1200px;
	text-align: center;
}

.type {
	width: 120px;
	height: 120px;
	padding: 5px;
	float: left;
	margin: 0 10px 10px 10px;
}

#set {
	width: 880px;
	height: 220px;
	border: 2px solid #ff6666;
	float: left;
	margin: 30px 10px 50px 150px;
	text-align: center;
}

.goal {
	width: 120px;
	height: 120px;
	display: inline-block;
	float: left;
	margin: 45px 10px 45px 60px;
}

.sec_list {
	display: none;
	position: absolute;
	z-index: 2;
	left: 55px;
	top: 180px;
	width: 480px;
	height: 360px;
	overflow: scroll;
	background-color: white;
}

.secPic {
	width: 65px;
	height: 65px;
	margin: 10px 5px 10px 35px;
	float: left;
	text-align: center;
}

#myForm {
    display: none;  
	position: absolute;
	z-index: 2;
	left: 250px;
	top: 180px;
	width: 600px;
	border-width: 3px;
	border-style: ridge;
	border-color: #66ffff;
	background-color: white;
}

.form-group{
    margin:20px 0px 10px 0px;
 
}
</style>

<script>
	var types = JSON.parse('${jTypes}');
	var secs = JSON.parse('${secs}');
	// 	console.log('${jTypes}');
	//	console.log('${secs}');
	//	console.log(secs[1][0].secName);

	$(function(){
		
		$("#myForm").submit(function(e)
			    {
			var myForm = document.querySelector("#myForm");
			var postData = new FormData(myForm);
			postData.append("action","insert");
			var formURL = $(myForm).attr("action");
			 $.ajax(
			{
				url : formURL,
				type: "POST",
				data : postData,
           		processData: false,
				contentType: false,
	            success:function(data) 
	            {
				    alert("資料寫入成功");
					
				},
			});
			 e.preventDeault();
		});
				

				
				var frag = $(new DocumentFragment());
				$.each(types, function(i, type) {
					var div = $("<div></div>");
					//<img id="type1" class="type" src="type.typePic" alt="typeName">
// 					if (type.typeName != "自訂") {
						var img = $("<img>").attr("id", type.typeID).addClass(
								"type").attr("src",
								"data:image/png;base64," + type.typePic).attr(
								"alt", type.typeName);
// 					} 
// 					else {
// 						var img = $("<img>").attr("src",
// 								"data:image/png;base64," + type.typePic).attr(
// 								"alt", type.typeName).css({
// 							width : "120px",
// 							height : "120px",
// 							padding : "5px",
// 							float : "left",
// 							margin : "0 10px 10px 10px"
// 						});
// 					}
					div.append(img);
					frag.append(div);
				})
				$(".type_list").append(frag);

				$(".type").draggable({
					helper : "clone",
					revert : "invalid"
				});

				$(".goal:first").droppable(
						{
							accept : ".type",
							drop : function(ev, ui) {
								$(this).attr("src", ui.draggable.attr("src"));

								$('#secs').empty();

								$.each(secs[ui.draggable.attr("id")], function(
										i, sec) {
									var d = $("#secs");
									var s = $("<img>").attr("id", sec.secID)
											.attr(
													"src",
													"data:image/png;base64,"
															+ sec.secPic).attr(
													"title", sec.secName)
											.addClass("secPic");

									$(s).draggable({
										helper : "clone",
										revert : "invalid"
									});

									d.append(s);

									(s).click(function() {
										$("#circle2>img").attr("src",
												$(this).attr("src")).css({
											"border" : "5px solid black",
											"border-radius" : "60px",
										});
										$('#secs').empty().hide();
										$("#myForm").fadeIn("slow");

										$('#submit').click(function(e){
											document.querySelector("#myForm").submit();
											
											
						                 });
									});
								});
								$("#secs").fadeIn("slow");
							}
						});

                       
				    
//                        $('#reset').click(function(){
//                     	  this.form.reset(); 
//                        });
				
				
			});
</script>

</head>
<body>
	<div id="wrapper">

		<!-- Header -->
		<header id="header">
			<h1>
				<a href="#">Life Editor</a>
			</h1>
			<nav class="links">
				<ul>
					<li><a href="userPage.jsp">目標</a></li>
					<li><a href="#">行事曆</a></li>
					<li><a href="#">朋友</a></li>
					<li><a href="#">關於我</a></li>
				</ul>
			</nav>
			<nav class="main">
											<ul>
											<c:choose>
										    	<c:when test="${ ! empty FbPicture }">
										    			<img src="${FbPicture}"></img>
												</c:when>
											<c:otherwise>
												<img height='40px' width='30px' src="HomeGetPicture">
											</c:otherwise> 
									</c:choose>
								  <a href="<c:url value='/logout_index.jsp' />" "   onclick="javascript:logout();"> 登出 </a>    


												<li class="search">
													<a class="fa-search" href="#search">Search</a>
													<form id="search" method="get" action="#">
														<input type="text" name="query" placeholder="Search" />
													</form>
												</li>

												<li class="menu">
													<a class="fa-bars" href="#menu">Menu</a>
												</li>
											</ul>
			</nav>
		</header>
		<!-- Main -->
		<article class="set_goal">

			<div style="text-align: center; margin: 10px 10px 50px 10px;">
				<h1>步驟一 : 請將你想要完成的目標類型拖曳到下方的類別圓圈裡</h1>
			</div>

			<div class="type_list"
				style="text-align: center; margin: 10px 10px 50px 100px;">

				<!-- 				<div> -->
				<!-- 					<img id="type0" -->
				<!-- 						style="width: 120px; height: 120px; padding: 5px; float: left; margin: 0 10px 10px 10px;" -->
				<!-- 						src="images/type0.png" alt="自訂"> -->
				<!-- 				</div> -->
			</div>

			<div id="set">
				<div id="circle1" style="position: relative">
					<img class="goal" src="images/sec_list/goal.png">
					<div id="secs" class="sec_list"
						style="border-width: 3px; border-style: ridge; border-color: #66ffff; padding: 4px;">
					</div>
				</div>

				<div id="circle2" style="position: relative">
					<img class="goal" src="images/sec_list/sec.png">
					<form id="myForm" method="POST" action="target">
						
							<label style="display:inline;margin-right:10px;">名  稱 : </label>
							<input style="display:inline; width: 30em;" placeholder="" type="text" name="trgName">
					
						
							<label style="display:inline;margin-right:10px;">初  衷 : </label> 
							<input style="display:inline; width: 30em;" type="text" name="intention">
						
						
							<label style="display:inline;margin-right:10px;">開  始 : </label> 
							<input style="display:inline; width: 30em;" type="date" name="timeStart">
						
						
							<label style="display:inline;margin-right:10px;">結  束 : </label> 
							<input style="display:inline;width: 30em;" type="date" name="timeFinish">
						
						
							<label style="display:inline;margin-right:10px;">順   序 : </label> 
							<select style="display:inline;width: 30em;">
								<option value="1">十萬火急!一定要完成</option>
								<option value="2" selected>普通</option>
								<option value="3">享受過程~慢慢來~</option>
							</select>
						
						
							<label style="display:inline;margin-right:10px;">隱   私 : </label> 
							<select style="display:inline;width: 30em;">
								<option value="1">公開</option>
								<option value="2">朋友</option>
								<option value="3">私人</option>
							</select>
						
							<input id="reset" value="重設" type="button"/>
							<input id="submit" value="確認"  type="button"/>
						
						
					</form>
				</div>

				<div id="circle3" style="position: relative">
					<img class="goal" src="images/sec_list/detail.png">
				</div>

				<div id="circle4">
					<img class="goal" src="images/sec_list/go.png">
				</div>
			</div>




		</article>
	</div>


</body>

</html>