<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내게시물</title>
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Custom CSS for Table and Pagination -->
<style>
/* Custom CSS for Table */
.table {
	width: 100%;
	margin-bottom: 1rem;
	background-color: transparent;
}

.table th, .table td {
	padding: 0.75rem;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}

.table thead th {
	vertical-align: bottom;
	border-bottom: 2px solid #dee2e6;
}

/* Custom CSS for Pagination */
.pagination {
	margin-top: 20px;
}

.pagination .page-item {
	display: inline-block;
}

.pagination .page-item .page-link {
	color: #007bff;
	border: 1px solid #dee2e6;
	padding: 0.375rem 0.75rem;
}

.pagination .page-item.active .page-link {
	z-index: 1;
	color: #fff;
	background-color: #007bff;
	border-color: #007bff;
}

.pagination .page-link {
	position: relative;
	display: block;
	padding: 0.5rem 0.75rem;
	margin-left: -1px;
	line-height: 1.25;
	text-decoration: none;
	background-color: #fff;
	border: 1px solid #dee2e6;
}

.pagination .page-link:hover {
	z-index: 2;
	color: #0056b3;
	text-decoration: none;
	background-color: #e9ecef;
	border-color: #dee2e6;
}

/* Custom CSS for buttons */
.btn-small {
	padding: 0.2rem 0.5rem;
	font-size: 0.8rem;
}

/* Custom CSS for button group */
.btn-group-sm .btn {
	padding: 0.2rem 0.5rem;
	font-size: 0.8rem;
}
</style>
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- Navigation-->
		<%@ include file="/WEB-INF/user/navigation.jsp"%>
		<section class="py-5">
			<div class="container px-5">
				<div class="bg-light rounded-4 py-5 px-4 px-md-5">
					<div class="row align-items-center">
						<!-- 내정보 -->
						<div class="col-md-3 mb-3 mb-md-0" style="height: 500px;">
							<%@ include file="/WEB-INF/myinfo/MyInfoSidebar.jsp"%>
						</div>
						<!-- 테이블 -->
						<div class="col-md-9">
							<div class="d-flex flex-column flex-shrink-0 p-3 bg-light">
								<div class="row justify-content-center">
									<div class="col-12">
										<h3>내가쓴댓글</h3>
										<table class="table table-hover table-bordered" id="postTable">
											<thead class="table-light">
												<tr>
													<th scope="col" style="width: 60%;">제목</th>
													<th scope="col" style="width: 20%;">작성일</th>
													<!-- <th scope="col" style="width: 20%;"></th> -->
												</tr>
											</thead>
											<tbody class="table-group-divider">
											</tbody>
										</table>
										<nav aria-label="Page navigation example">
											<ul class="pagination justify-content-center" id="pagination">
												<!-- Pagination dynamically created by JavaScript -->
											</ul>
										</nav>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
</body>
<script type="text/javascript">
    const postTable = document.getElementById("postTable");
    const pagination = document.getElementById("pagination");
    let currentPage = 1; // 초기 페이지는 1로 설정
    const itemsPerPage = 5; // 페이지당 아이템 수
    const tbody = postTable.querySelector("tbody");

    // 페이지를 로드할 때 초기 데이터를 가져오는 함수 호출
    loadPosts(currentPage);
	function formattedDate(element) {
        // MySQL DATETIME 값을 Date 객체로 변환
        const timestamp = Number(element.reviewDate);
        const date = new Date(timestamp);

        // 년, 월, 일 추출
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, "0"); // 월은 0부터 시작하므로 1을 더하고, 2자리로 맞춤
        const day = String(date.getDate()).padStart(2, "0"); // 일은 1일부터 시작하므로 2자리로 맞춤

        // 'YYYY-MM-DD' 형식으로 문자열 조합
        const formattedDate = `${year}-${month}-${day}`;

        return formattedDate;
      }
    function loadPosts(page) {
        fetch(`/review/list?page=${page}&pagePer=${itemsPerPage}`, {
            method: 'POST'
        })
        .then((resp) => resp.json())
        .then((data) => {
            tbody.innerHTML = ""; // 기존 게시물 내용 초기화
            
            data.items.forEach((element) => {
                let contenttr = document.createElement("tr");
                let tdTitle = document.createElement("td");
                let tdResistDate = document.createElement("td");
                //let tdActions = document.createElement("td"); // 수정 및 삭제 버튼을 포함할 셀
                
                tdTitle.innerText = `${element.review}`;
                tdResistDate.innerText = formattedDate(element);
                
                // 클릭 이벤트 추가하여 상세 페이지로 이동
                contenttr.addEventListener("click", () => {
                    window.location.href = `/post/detail?post_Id=${element.postId}`;
                });
                
                
             /*     // 수정 버튼 생성
                let editButton = document.createElement("button");
                editButton.textContent = "수정";
                editButton.classList.add("btn", "btn-primary", "btn-small", "mx-1");
                editButton.addEventListener("click", () => {
                    // 수정 기능 수행
                    window.location.href = `editpost?postId=${postId}`;
                    console.log(`수정 버튼 클릭 - 게시물 ID: ${element.post_Id}`);
                }); 
                
                // 삭제 버튼 생성
                let deleteButton = document.createElement("button");
                deleteButton.textContent = "삭제";
                deleteButton.classList.add("btn", "btn-danger", "btn-small", "mx-1");
                deleteButton.addEventListener("click", () => {
                    fetch(`/post/deleteReview/${reviewId}`, {
                        method: 'DELETE'
                    })
                    .then(response => {
                        if (response.ok) {
                            console.log('리뷰가 성공적으로 삭제되었습니다.');
                            // 삭제된 리뷰 아이템을 화면에서도 제거
                            event.target.parentNode.remove(); // 삭제 버튼의 부모인 리뷰 아이템을 제거
                        } else {
                            console.error('리뷰 삭제 중 오류 발생:', response.status);
                            alert('리뷰 삭제 중 오류가 발생했습니다.');
                        }
                    })
                    console.log(`삭제 버튼 클릭 - 게시물 ID: ${element.post_Id}`);
                });  */
                
                // 버튼을 셀에 추가
                //tdActions.appendChild(editButton);
                //tdActions.appendChild(deleteButton);
                
                contenttr.appendChild(tdTitle);
                contenttr.appendChild(tdResistDate);
                //contenttr.appendChild(tdActions); // 수정 및 삭제 버튼을 포함한 셀 추가
                tbody.appendChild(contenttr);
            });
            
            displayPagination(data.totalPages, page); // 페이지네이션 표시
        });
    }

</script>
<!-- 페이지 번호 -->
<script src="/js/pagination.js"></script>
</html>
