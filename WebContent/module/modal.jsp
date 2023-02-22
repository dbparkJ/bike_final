<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" />

<div class="modal" id="wtf" tabindex="-1">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					 <div class="row">
					 	<div class="col ms-3" id="store_info">
					 	</div>
					 	<div class="col ms-5">
					 		<figure class="figure" id="main_img"style="width: 20rem;">
								<figcaption class="figure-caption text-end me-1">#키워드1 #키워드2 #키워드3</figcaption>
								<figcaption class="figure-caption text-end me-1"><a href="https://www.naver.com" target="_blank" rel="noopener noreferrer">상세보기</a></figcaption>
							</figure>
					 	</div>
					 </div>
				</div>
				<div class="border mx-3" id="review">
					
				</div>
			</div>
			<div class="modal-footer bg-light">
				<div class="container-center" id="aiRecommand">
				</div>
			</div>
		</div>
	</div>
</div>