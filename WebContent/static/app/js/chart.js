window.onload = function () {//페이지가 로드되면 자동으로 실행되는 전역 콜백함수
    startLoadFile();
};

function startLoadFile(){
	timer = setInterval( function () {
	    $.ajax({
	        url: 'image.json',// 절대경로
	        type: 'GET',
	        dataType : 'text',
	        success : function (data) {
				alert("연결성공");
	            //img태그에 경로넣기
	        }
	    });
    }, 5000);//5초에 한 번
}

