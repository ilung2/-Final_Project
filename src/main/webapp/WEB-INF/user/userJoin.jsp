<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
    .readonly-input {
        background-color: #f2f2f2;
        weight : 400px;
        height : 20px;
    }
    
</style>
</head>
<body>
    <h3>회원가입 폼</h3>

    <form id="userForm">
   
        ID: <input type="text" name="id"><br> 
		비밀번호: <input type="password" name="password"><br> 
		E-Mail: <input type="text" name="email"><br> 
		이름: <input type="text" name="name"><br> 
		닉네임: <input type="text" name="nickname"><br> 
		주민등록번호: <input type="text" name="identifynumber"><br> 
		전화번호: <input type="text" name="phonenumber"><br> 
		도로명주소: <input type="text" name="address" id="address" readonly> <input type="button" onclick="goPopup()" value="주소찾기"><br> 
		Join Date: <input type="date" name="join_date"><br> 
		Attendance: <input type="number" name="attendance"><br> 
		MBTI: <input type="text" name="mbti"><br>
		혈액형: <input type="text" name="bloodtype"><br> 
		<input type="button" value="가입" onclick="submitForm()">

    </form>
    

</body>
<script>
function submitForm() {
    var form = document.getElementById("userForm");
    var formData = new FormData(form);
    var jsonObject = {};

    formData.forEach(function(value, key) {
        jsonObject[key] = value;
    });

    var json = JSON.stringify(jsonObject);

    fetch('user?action=register', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json;charset=UTF-8'
        },
        body: json
    })
    .then(response => response.json())
 .then(data => {
    if (data.errors) {
        // 오류 메시지가 있는 경우 경고창으로 표시
        var errorMessage = "회원가입 실패:\n";
        for (var key in data.errors) {
            errorMessage += data.errors[key] + "\n";
        }
        alert(errorMessage); // errors 맵의 값을 경고창에 출력
    } else {
        alert("회원가입이 완료되었습니다.");
    }
})
    .catch(error => {
        console.error('Error:', error);
        alert('오류: ' + error.message);
    });
}
<<<<<<< HEAD
function goPopup(){
	// 주소검색을 수행할 팝업 페이지를 호출합니다.
	// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	var pop = window.open("/Address/addressAPI.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://business.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
}
function jusoCallBack(address){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
    document.getElementById("address").value = address;
	window.close();
}

</script>
</html>
