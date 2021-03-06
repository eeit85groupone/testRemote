<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>編輯類別</title>
    

    <link href="${ctx }/css/style.css" rel="stylesheet">
    <link href="${ctx }/js/fancybox/jquery.fancybox.css" rel="stylesheet" />
    <!-- Latest compiled and minified CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous"> -->

<!-- Optional theme -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous"> -->

<!-- Latest compiled and minified JavaScript -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script> -->

</head>
<body>
<div id="div1" class="container-fluid">
	<div class="row">
		<div class="col-md-6">
	<FORM METHOD="post" ACTION="type_list.do" name="form1" enctype="multipart/form-data">
	<div>
		<jsp:useBean id="typeSvc" scope="page" class="com.lifeeditor.service.TypeListService" />
		<label for="exampleInputaccount">類別:</label> 
		<select id="select1" name="typeID1" class="opt">
			<option value=""></option>
			<c:forEach var="type" items="${types}">
<%-- 			<c:if test="${type.typeName != '自訂' }"> --%>
			<option value=${type.typeID }>${type.typeName }</option>
<%-- 			</c:if> --%>
			</c:forEach>
		</select>
	</div>
	<div>
		<label for="exampleUpdateaccount">類別名稱:</label>
		<input type="TEXT" class="form-control" id="exampleUpdateaccount" name="typeName1" value="${param.account}" size="45"  /><span>${errorMsgs1.errorAccountempty}</span>
	</div>
	
	<div class="form-group">
		<label for="exampleInputpicture">上傳圖片</label>
		<input type="file" id="exampleInputpicture" class="upl1" name="typePic1" size="22"  /><span>&nbsp&nbsp&nbsp${errorMsgs1.errorpicture}</span>
	</div>
	<div>
		<input type="hidden" name="action" value="update">
		<input type="submit"  class="btn btn-default" value="送出修改">
	</div>
	
</FORM>
<br>
<a class="fancybox" href="#addUser" title="新增類別"><button class="btn btn-default" type="submit">新增類別</button></a>
		</div>
		<div  class="col-md-6">	
		<div>
		<label>類別圖片</label><br>
		<img id="typePic" style="width:150px;height: 100px;" />	
		</div>
		<div>
		<label>預覽圖片</label><br>
        <img class="preview1" style="width: 150px; height: 100px;">
        <div class="size1"></div>
		</div>
		
		
		</div>
	</div>
</div>

<div id="addUser" style="width:600px;display: none;height: 500px;" >
<div id="div1" class="container-fluid">
	<div class="row">
		<div class="col-md-6">
		<FORM METHOD="post" ACTION="type_list.do" name="form1" enctype="multipart/form-data">


	<div>
		<label for="exampleInputaccount">類別名稱:</label>
		<input type="TEXT" class="form-control" id="exampleInputaccount" name="typeName" value="${param.account}" size="45"  /><span>${errorMsgs.errorAccountempty}</span>
	</div>
	
	<div class="form-group">
		<label for="exampleInputpicture">上傳圖片</label>
		<input type="file" id="exampleInputpicture" class="upl2" name="typePic" size="22"  /><span>&nbsp&nbsp&nbsp${errorMsgs.errorpicture}</span>
	</div>
	<div>
		<input type="hidden" name="action" value="insert">
		<input type="submit"  class="btn btn-default" value="送出新增">
	</div>
	
</FORM>
		</div>
		<div  class="col-md-6">		
		
		<div>
		<label>預覽圖片</label><br>
        <img class="preview2" style="width: 150px; height: 100px;">
        <div class="size2"></div>
		</div>
		
		
		</div>
	</div>
</div>
</div>
<div class="overlay"></div>
<script>
$(function (){
	 
    function format_float(num, pos)
    {
        var size = Math.pow(10, pos);
        return Math.round(num * size) / size;
    }
 
    function preview(input) {
 
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('.preview1').attr('src', e.target.result);
                var KB = format_float(e.total / 1024, 2);
                $('.size1').text("檔案大小：" + KB + " KB");
            }
 
            reader.readAsDataURL(input.files[0]);
        }
    }
 
    $("body").on("change", ".upl1", function (){
        preview(this);
    })
    
})
</script>
<script>
$(function (){
	 
    function format_float(num, pos)
    {
        var size = Math.pow(10, pos);
        return Math.round(num * size) / size;
    }
 
    function preview(input) {
 
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('.preview2').attr('src', e.target.result);
                var KB = format_float(e.total / 1024, 2);
                $('.size2').text("檔案大小：" + KB + " KB");
            }
 
            reader.readAsDataURL(input.files[0]);
        }
    }
 
    $("body").on("change", ".upl2", function (){
        preview(this);
    })
    
})
</script>
<script>
$(function(){
	
	$('#select1').change(function(){
	 
		var sel = $('#select1>:selected');
		var v = sel.text();
		var p = sel.val();
	    $('#exampleUpdateaccount').val(v);
	    //$('#typePic').src("getTypePic.do?typeID=8");
	    $('#typePic').attr("src","getTypePic.do?typeID="+p);
		
	});
		
});    
</script>
<script src="${ctx }/js/fancybox/jquery.fancybox.js"></script> 
<script type="text/javascript">
      $(function() {
        //    fancybox
          jQuery(".fancybox").fancybox();
      });
</script>	
</body>
</html>