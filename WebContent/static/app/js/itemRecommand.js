/*
 *    플라스크 아이템 추천 불러오기
 */

//------------------------------------------------------------------------------------------------
var item_id = [];

//------------------------------------------------------------------------------------------------
/**
 * 아이디 가져오기
 */
function recommandItemList(myItemId){
	console.log(myItemId)
		$.ajax({
			type : "GET",
	        url:"http://192.168.0.146:5000/recommandItem?item_id="+myItemId+"&cosine_weight=3",
	        dataType:"JSON",
	        success: function(data){
					$.ajax({
						type:'POST'
						
					})
		        		}
     	});
     	
     	
}