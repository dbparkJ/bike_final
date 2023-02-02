/*
 * check function
 */

/* 다음 주소검색 api */
function findAddr(){
	new daum.Postcode({
		oncomplete:function(data){
			document.getElementById('zipcode').value=data.zonecode;
			document.getElementById('address').value=data.address;
		}
	}).open();
}//findAddr()-end

/* 이메일 입력 여부와 ajax를 사용하여 db에서 같은 이메일 여부 확인 */
function emailCheck(){
	if($('#emailin').val()==''){
		alert("email를 입력 하세요");
		$('#emailin').focus();
		return false;
	}else{
		$.ajax({
		type:"POST",
		url:"../member/confirmEmail.jsp",
		data:"email="+$('#emailin').val(),/*서버로 보낼 데이터*/
		dataType:"JSON",/*서버로부터 받는 자료형*/
		success:function(data){
				if(data.x==1){
					alert("사용중인 email 입니다");
					$('#emailin').val('').focus();
				}else{
					alert("사용 가능한 email");
					$('#emailck').val('true');///******
				//alert("email중복 체크 했다는 증거 :"+$('#emailck').val());
				//$('#password').focus();
				}
			}
		});
	}
	return true;
}//emailCheck()-end
    
/* 이메일 중복체크버튼을 눌렀는지 확인하는 함수 */    
function email_Check(){
	if($('#emailck').val()=='false'){
		alert("email중복 체크 하세요");
		$('#email').focus();
		return false;
	}
}

/* 닉네임 입력 여부와 ajax를 사용하여 db에서 같은 이메일 여부 확인 */
function nickCheck(){
	if($('#nickname').val()==''){
		alert("nickname를 입력 하세요");
		$('#nickname').focus();
		return false;
	}else{
		$.ajax({
		type:"POST",
		url:"confirmNickname.jsp",
		data:"nickname="+$('#nickname').val(),
		dataType:"JSON",
		success:function(data){
				if(data.x==1){
					alert("사용중인 nickname 입니다")
					$('#nickname').val('').focus();
				}else{
					alert("사용 가능한 nickname");
					$('#nicknameck').val('true');
					//alert("nickname중복 체크 했다는 증거 :"+$('#nicknameck').val());
					$('#name').focus();
				}
			}
		});
	}
	return true;
}//nicknameCheck()-end
      
/* 이메일 중복체크버튼을 눌렀는지 확인하는 함수*/    
function nickname_Check(){
	if($('#nicknameck').val()==''){
		alert("nickname중복 체크 하세요");
		$('#nickname').focus();
		return false;
	}
}