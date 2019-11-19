<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ include file="/WEB-INF/jspf/head.jspf"%>
<style>
[data-toggle="collapse"]:after {
	display: inline-block;
	font: normal normal normal 14px/1 FontAwesome;
	font-size: inherit;
	text-rendering: auto;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	content: "\f054";
	transform: rotate(90deg);
	transition: all linear 0.25s;
	float: right;
}

[data-toggle="collapse"].collapsed:after {
	transform: rotate(0deg);
}
</style>

<nav aria-label="breadcrumb">
	<div class=" breadcrumb pb-0  mx-0 row">
		<div class="nav nav-tabs col-2 " id="nav-tab-left" role="tablist">
			<a class="nav-item nav-link breadcrumb-item text-right" id="resume-create" href="#"> 새 자기소개서 </a>
		</div>
		<div class="nav nav-tabs accordion justify-content-center col-6" id="nav-tab" role="tablist">
			<a class="nav-item nav-link breadcrumb-item text-center active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab"
				aria-controls="nav-home" aria-selected="true">작성 목록</a>
			<!-- 작성중,작성중:내용없음 -->
			<a class="nav-item nav-link breadcrumb-item text-center" id="nav-profile-tab" data-toggle="tab" href="#nav-profile"
				role="tab" aria-controls="nav-profile" aria-selected="false">작성중</a>
			<a class="nav-item nav-link breadcrumb-item text-center" id="nav-contact-tab" data-toggle="tab" href="#nav-contact"
				role="tab" aria-controls="nav-contact" aria-selected="false">작성 완료</a>
			<!--작성완료:미제출,작성완료:제출됨 작성완료:서류합격 -->
			<!--
			<a class="nav-item nav-link breadcrumb-item text-center" id="nav-contact-tab" data-toggle="tab" href="#nav-contact"
				role="tab" aria-controls="nav-contact" aria-selected="false">작성 기록</a>
			-->
		</div>
		<div class="col-4">
			<div class="nav nav-tabs justify-content-right" id="nav-tab-right" role="tablist">
				<a class="nav-item nav-link breadcrumb-item text-right active" id="nav-search-tab" data-toggle="tab" href="#nav-search"
					role="tab" aria-controls="nav-search" aria-selected="false">자동 검색</a>
				<a class="nav-item nav-link breadcrumb-item text-right" id="nav-change-tab" data-toggle="tab" href="#nav-change"
					role="tab" aria-controls="nav-change" aria-selected="false">단어 교체</a>
				<a class="nav-item nav-link breadcrumb-item text-right" id="nav-compare-tab" data-toggle="tab" href="#nav-compare"
					role="tab" aria-controls="nav-compare" aria-selected="false">비교 하기</a>
			</div>
		</div>
	</div>
</nav>
<!--  -->
<div class="container-fluid row" style="min-height:66vh">
	<div class="col-1">
	</div>
	<div class="tab-content col-7" id="nav-tabContent">
		<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
			<div id="accordion1" role="tablist">
				<%@ include file="/WEB-INF/jsp/resume/list.jsp"%>
			</div>
		</div>
		<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
			<div id="accordion2" role="tablist"></div>
		</div>
		<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
			<div id="accordion3" role="tablist">새 자기소개서</div>
		</div>
	</div>
	<div class="col-4">
		<div class="card">
			<div class="card-header card-title">메모</div>
			<div class="card-body card-text">
				<textarea class="form-control" rows="6"></textarea>
			</div>
		</div>
		<div class="tab-content" id="nav-tabContent">
			<div class="tab-pane fade show active" id="nav-search" role="tabpanel" aria-labelledby="nav-search-tab">
				<div class="card" id="autoComplete">
					<div class="card-header card-title">자동 검색</div>
					<ul class="list-group list-group-flush card-text">
					  </ul>
					</div>
				</div>
			<div class="tab-pane fade" id="nav-change" role="tabpanel" aria-labelledby="nav-change-tab">
				<div class="card" id="wordChange">
					<div class="card-header card-title">단어 교체</div>
					<div class="card-body">
						<ul class="card-text list-group list-group-flush"></ul>
						<a href="#" class="btn btn-primary btn-load">내용 가져오기</a>
						<a href="#" class="btn btn-primary btn-apply">내용 적용하기</a>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="nav-compare" role="tabpanel" aria-labelledby="nav-compare-tab">
				<div class="card" id="compare">
					<div class="card-header card-title">비교 하기</div>
					<div class="card-body">
						<ul class="card-text list-group list-group-flush"></ul>
						<a href="#" class="btn btn-primary btn-load">내용 가져오기</a>
						<a href="#" class="btn btn-primary btn-apply">유사도검사</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	var resume_idx = 1;
	var resume_new = 1;
	$("body").delegate(".tagsinput","propertychange change keyup paste input",function(e) {//태그와 태그입력값 동기화
				var id = $(event.target).attr("id").replace("_tag", "");
				var tags = [];
				$("#" + id + "_tagsinput").find(".tag>span").each(
						function(i, e) {
							tags.push($.trim($(e).text()));
						});
				//console.log($("#"+id).val());
				$("#" + id).val(tags.join(","));
				return true;
			});
	$("body").delegate("#resume-create","click",function() {
				$(document.createDocumentFragment()).load("/resume/write",function(response) {//새 자기소개서
							var $result = $(response);
							$result.find(".card-header")
									.attr("id","heading-write" + resume_idx)
									.find("a")
									.attr("href","#collapse-write" + resume_idx)
									.attr("aria-controls","collapse-write" + resume_idx)
									.html("새 자기소개서 " + resume_new);
							$result.find(".collapse")
							.attr("id","collapse-write" + resume_idx)
							.attr("aria-labelledby","heading-write" + resume_idx)
									.find(".write-question")
									.attr("id","write-question" + resume_idx)
									.val("새 자기소개서 " + resume_new);
							$result.find(".collapse").find(".write-answer").attr("id","write-answer" + resume_idx);
							$result.find(".tags").attr("id","tags-write" + resume_idx);
							$("#nav-profile-tab").tab("show");
							$result.appendTo("#accordion2").find(".collapse")
									.collapse("show");
							$("#tags-write" + resume_idx).tagsInput({
								'height' : '100%',
								'width' : '80%',
							});
							resume_idx += 1;
							resume_new += 1;
						});
				return false;
			});
	$("#accordion1").delegate(".resume-link","click",function(e) {//자기소개서 불러오기
				var href = $(e.target).attr("href");
				var card = href.replace("/resume/write/", "#resume-card");

				if ($(card).length == 0) {
					$(document.createDocumentFragment()).load(
							href,
							function(response) {
								var $result = $(response);
								$result.find(".card-header").attr("id",
										"heading-write" + resume_idx)
										.find("a")
										.attr("href","#collapse-write" + resume_idx)
										.attr("aria-controls","collapse-write" + resume_idx)
								$result.find(".collapse")
									.attr("id","collapse-write" + resume_idx)
									.attr("aria-labelledby","heading-write" + resume_idx)
									.find(".write-question")
									.attr("id","write-question" + resume_idx);
								$result.find(".collapse").find(".write-answer").attr("id","write-answer" + resume_idx);
								$result.find(".tags")
									.attr("id","tags-write" + resume_idx);
								$("#nav-profile-tab").tab("show");
								$result.appendTo("#accordion2").find(".collapse").collapse("show");
								$("#tags-write" + resume_idx).tagsInput({
									'height' : '100%',
									'width' : '80%',
								});
								resume_idx += 1;
							});
				} else {
					$(card).find(".collapse").collapse("show");
				}
				return false;
			})
	$("#accordion2").delegate(".write-question","propertychange change keyup paste input", function(e){//제목 동기화
				var id = $(e.target).attr("id").replace("write-question", "");
				var currentVal=$(e.target).val();
				$("#heading-write" + id + " a").html(currentVal);
			});
	
	timer_auto=null;
	keyword=null;
	$("#accordion2").delegate(".write-answer","propertychange change paste input click", function(e){//내용 자동검색
		var currentVal=$(e.target).html();
		var pos=$(e.target).get(0).selectionEnd;
		var keywords=currentVal.substring(0,pos).split(/다 |\.|\n/);
		keyword=keywords[keywords.length-1];
		var form={keyword:$.trim(keyword)};
		//console.log(form);
		if(timer_auto){
			clearTimeout(timer_auto);
		}
		timer_auto = setTimeout(function(){
			$.get("/resume/auto", form, function(data) {
				console.log(data);
				var $frag=$(document.createDocumentFragment());
				data.list.forEach(function(e,i){
					var text=e.text.replace()
					$frag.append("<li class='list-group-item p-1'><font size='2'><a href='#'>"
							+e.text+"</a></font></li>");
				});
				$("#autoComplete ul").html("").append($frag);
			});	
		},300); 
	});
	$("#autoComplete ul").delegate("a","click",function(e){//자동완성 입력
		var currentVal=$(e.target).html();
		var $target=$("#accordion2 .card").find(".show").find(".write-answer");
		var beforeVal=$target.html();
		console.log(currentVal);
		console.log(beforeVal);
		var pos=$target.get(0).selectionEnd;
		var result=
			beforeVal.substring(0,pos-keyword.length)
			+currentVal+" "
			+beforeVal.substring(pos,beforeVal.length);
		$target.html(result);
		keyword=null;
		$("#autoComplete ul").html("");
		return false;
	});
	
	$("#accordion2").delegate(".card-header","click",function(e){
		keyword=null;
		$("#autoComplete ul").html("");
	});
	
	$("#wordChange,#compare").delegate(".btn-load","click",function(e){//단어교체,비교하기 불러오기
		var currentVal=$("#accordion2 .card").find(".show").find(".write-answer").html();
		var form={answer:currentVal};
		$.post("/resume/changelist", form, function(data) {
			$(e.target).parent().find("ul").html(data).sortable();
		});
		return false;
	});
	
	$("#wordChange").delegate(".btn-apply","click",function(e){//단어교체 적용하기
		var currentVal="";
		$("#wordChange ul li").each(function(i,element){
			currentVal+=$.trim($(element).text());
			
		});
		//console.log(currentVal);
		$("#accordion2 .card").find(".show").find(".write-answer").html(currentVal);
		return false;
	});
	
	$("#compare").delegate(".btn-apply","click",function(e){//유사도 검사
		$("#compare ul li").each(function(i,element){
			var currentVal = $(element).text();
			var form={sentence:currentVal};
			$.get("/resume/compare", form, function(data) {
				console.log(data.result);
			});
		});
		return false;
	});
	
	
	$("#accordion2").delegate("form", "submit", function(e) {//저장하기
		var form = $(e.target).serializeJSON();
		//console.log(form);
		$.post("/resume/content/" + form.id, form, function(data) {
			//console.log(data);
			$(e.target).find(".resume-id").val(data.map.id);
			$(e.target).find(".resume-method").val("put");
			$.get("/resume/content", function(data2) {
				//console.log(data2);
				$("#accordion1").html(data2);
			});
		});
		return false;
	});
</script>
<%@ include file="/WEB-INF/jspf/footer.jspf"%>


