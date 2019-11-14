<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="card" id="resume-card${resume.id}">
	<div class="card-header" role="tab" id="heading-i" style="font-size: 14px">
		<a class="text-info collapsed" data-toggle="collapse" href="#collapse-i" aria-expanded="false" aria-controls="collapse-i">
			${resume.question}
		 </a>
	</div>
	<div id="collapse-i" class="collapse" role="tabpanel" aria-labelledby="heading-i" data-parent="#accordion2">
		<form>
			<div class="card-body">
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">자기소개서 문항</span>
					</div>
					<input type="text" id=" write-question-i" class="form-control write-question" name="question" value="${resume.question}">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">회사명</span>
					</div>
					<input type="text" class="form-control" name="company" value="${resume.company}">
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">태그</span>
					</div>
					<input name="tags" class="tags" value="dummy,dummy2,dummy3" />
				</div>
					
				<div class="input-group">
					<div class="input-group-prepend">
						<span class="input-group-text">내용</span>
					</div>
					<textarea class="form-control" name="answer" rows="15">${resume.answer}</textarea>
				</div>
				<button type="submit"  class="btn btn-primary">글올리기</button>
				<input type="hidden" class="resume-id" name="id" value="${resume.id}"/>
				<input type="hidden" class="resume-method" name="_method" value="${method}"/>
			</div>
		</form>
	</div>
</div>