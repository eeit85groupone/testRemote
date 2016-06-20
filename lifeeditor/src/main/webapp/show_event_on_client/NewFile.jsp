<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<script type="text/javascript">

 $('.slider-for').slick({
  slidesToShow: 1,
  slidesToScroll: 1,
  arrows: false,
  fade: true,
  asNavFor: '.slider-nav'
});
$('.slider-nav').slick({
  slidesToShow: 3,
  slidesToScroll: 1,
  asNavFor: '.slider-for',
  dots: true,
  centerMode: true,
  focusOnSelect: true
});
</script>

<body>

	<div class="slider slider-for slick-initialized slick-slider">
		<div aria-live="polite" class="slick-list draggable">
			<div class="slick-track" style="opacity: 1; width: 2800px;"
				role="listbox">
				<div class="slick-slide" data-slick-index="0" aria-hidden="true"
					style="transition: opacity 500ms ease; width: 560px; position: relative; left: 0px; top: 0px; z-index: 998; opacity: 0;"
					tabindex="-1" role="option" aria-describedby="slick-slide120">
					<h3>1</h3>
				</div>
				<div class="slick-slide slick-current slick-active"
					data-slick-index="1" aria-hidden="false"
					style="width: 560px; position: relative; left: -560px; top: 0px; z-index: 999; opacity: 1;"
					tabindex="-1" role="option" aria-describedby="slick-slide121">
					<h3>2</h3>
				</div>
				<div class="slick-slide" data-slick-index="2" aria-hidden="true"
					style="transition: opacity 500ms ease; width: 560px; position: relative; left: -1120px; top: 0px; z-index: 998; opacity: 0;"
					tabindex="-1" role="option" aria-describedby="slick-slide122">
					<h3>3</h3>
				</div>
				<div class="slick-slide" data-slick-index="3" aria-hidden="true"
					style="transition: opacity 500ms ease; width: 560px; position: relative; left: -1680px; top: 0px; z-index: 998; opacity: 0;"
					tabindex="-1" role="option" aria-describedby="slick-slide123">
					<h3>4</h3>
				</div>
				<div class="slick-slide" data-slick-index="4" aria-hidden="true"
					style="transition: opacity 500ms ease; width: 560px; position: relative; left: -2240px; top: 0px; z-index: 998; opacity: 0;"
					tabindex="-1" role="option" aria-describedby="slick-slide124">
					<h3>5</h3>
				</div>
			</div>
		</div>
	</div>
	<div
		class="slider slider-nav slick-initialized slick-slider slick-dotted"
		role="toolbar">
		<button type="button" data-role="none" class="slick-prev slick-arrow"
			aria-label="Previous" role="button" style="display: block;">Previous</button>
		<div aria-live="polite" class="slick-list draggable"
			style="padding: 0px 50px;">
			<div class="slick-track"
				style="opacity: 1; width: 2002px; transform: translate3d(-616px, 0px, 0px);"
				role="listbox">
				<div class="slick-slide slick-cloned" data-slick-index="-4"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>2</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="-3"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>3</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="-2"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>4</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="-1"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>5</h3>
				</div>
				<div class="slick-slide slick-active" data-slick-index="0"
					aria-hidden="false" style="width: 154px;" tabindex="-1"
					role="option" aria-describedby="slick-slide130">
					<h3>1</h3>
				</div>
				<div class="slick-slide slick-current slick-active slick-center"
					data-slick-index="1" aria-hidden="false" style="width: 154px;"
					tabindex="-1" role="option" aria-describedby="slick-slide131">
					<h3>2</h3>
				</div>
				<div class="slick-slide slick-active" data-slick-index="2"
					aria-hidden="false" style="width: 154px;" tabindex="-1"
					role="option" aria-describedby="slick-slide132">
					<h3>3</h3>
				</div>
				<div class="slick-slide" data-slick-index="3" aria-hidden="true"
					style="width: 154px;" tabindex="-1" role="option"
					aria-describedby="slick-slide133">
					<h3>4</h3>
				</div>
				<div class="slick-slide" data-slick-index="4" aria-hidden="true"
					style="width: 154px;" tabindex="-1" role="option"
					aria-describedby="slick-slide134">
					<h3>5</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="5"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>1</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="6"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>2</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="7"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>3</h3>
				</div>
				<div class="slick-slide slick-cloned" data-slick-index="8"
					aria-hidden="true" style="width: 154px;" tabindex="-1">
					<h3>4</h3>
				</div>
			</div>
		</div>




		<button type="button" data-role="none" class="slick-next slick-arrow"
			aria-label="Next" role="button" style="display: block;">Next</button>
		<ul class="slick-dots" style="display: block;" role="tablist">
			<li class="" aria-hidden="true" role="presentation"
				aria-selected="true" aria-controls="navigation130"
				id="slick-slide130"><button type="button" data-role="none"
					role="button" tabindex="0">1</button></li>
			<li aria-hidden="false" role="presentation" aria-selected="false"
				aria-controls="navigation131" id="slick-slide131"
				class="slick-active"><button type="button" data-role="none"
					role="button" tabindex="0">2</button></li>
			<li aria-hidden="true" role="presentation" aria-selected="false"
				aria-controls="navigation132" id="slick-slide132" class=""><button
					type="button" data-role="none" role="button" tabindex="0">3</button></li>
			<li aria-hidden="true" role="presentation" aria-selected="false"
				aria-controls="navigation133" id="slick-slide133" class=""><button
					type="button" data-role="none" role="button" tabindex="0">4</button></li>
			<li aria-hidden="true" role="presentation" aria-selected="false"
				aria-controls="navigation134" id="slick-slide134" class=""><button
					type="button" data-role="none" role="button" tabindex="0">5</button></li>
		</ul>
	</div>


</body>
</html>