<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" />

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
								<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220118_268%2F1642494655979WNKBr_JPEG%2FKakaoTalk_20220117_152141415_07.jpg" class="figure-img img-thumbnail rounded" alt="...">
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
				<p class="me-3 pb-2 fs-5">
					AI추천 맛집
				</p>
				<div class="row border pt-2">
					<div class="col">
						<figure class="figure" style="width: 8rem;">
							<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220118_268%2F1642494655979WNKBr_JPEG%2FKakaoTalk_20220117_152141415_07.jpg" class="figure-img img-thumbnail rounded" alt="...">
							<figcaption class="figure-caption ms-1">맛집1</figcaption>
						</figure>
					</div>
					<div class="col">
						<figure class="figure" style="width: 8rem;">
							<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyMzAxMDhfMTM1%2FMDAxNjczMTcwNjI0MjUx.0SbFjJI68kUJSOIwE9I5_n2-FDbuDmWyGRvaF4I_yPog.7B-2V-jor_L2tG-l7uAR7qwLsFu22FEdL1m9EHYHKpgg.JPEG%2FDCF515BC-1E17-4797-8545-99E6DF587A74.jpeg" class="figure-img img-thumbnail rounded" alt="...">
							<figcaption class="figure-caption ms-1">맛집2</figcaption>
						</figure>
					</div>
					<div class="col">
						<figure class="figure" style="width: 8rem;">
							<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyMzAxMDhfMTM1%2FMDAxNjczMTcwNjI0MjUx.0SbFjJI68kUJSOIwE9I5_n2-FDbuDmWyGRvaF4I_yPog.7B-2V-jor_L2tG-l7uAR7qwLsFu22FEdL1m9EHYHKpgg.JPEG%2FDCF515BC-1E17-4797-8545-99E6DF587A74.jpeg" class="figure-img img-thumbnail rounded" alt="...">
							<figcaption class="figure-caption ms-1">맛집3</figcaption>
						</figure>
					</div>
					<div class="col">
						<figure class="figure" style="width: 8rem;">
							<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyMzAxMDhfMTM1%2FMDAxNjczMTcwNjI0MjUx.0SbFjJI68kUJSOIwE9I5_n2-FDbuDmWyGRvaF4I_yPog.7B-2V-jor_L2tG-l7uAR7qwLsFu22FEdL1m9EHYHKpgg.JPEG%2FDCF515BC-1E17-4797-8545-99E6DF587A74.jpeg" class="figure-img img-thumbnail rounded" alt="...">
							<figcaption class="figure-caption ms-1">맛집4</figcaption>
						</figure>
					</div>
					<div class="col">
						<figure class="figure" style="width: 8rem;">
							<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fpup-review-phinf.pstatic.net%2FMjAyMzAxMDhfMTM1%2FMDAxNjczMTcwNjI0MjUx.0SbFjJI68kUJSOIwE9I5_n2-FDbuDmWyGRvaF4I_yPog.7B-2V-jor_L2tG-l7uAR7qwLsFu22FEdL1m9EHYHKpgg.JPEG%2FDCF515BC-1E17-4797-8545-99E6DF587A74.jpeg" class="figure-img img-thumbnail rounded" alt="...">
							<figcaption class="figure-caption ms-1">맛집5</figcaption>
						</figure>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>