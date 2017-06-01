window.onload = function() { // 椤甸潰鎵�湁鍏冪礌鍔犺浇瀹屾瘯
	var item = document.getElementById("tb"); // 鑾峰彇id涓簍b鐨勫厓绱�table)
	var tbody = item.getElementsByTagName("tbody")[0]; // 鑾峰彇琛ㄦ牸鐨勭涓�釜tbody鍏冪礌
	
}

function openTitle(id) {
	window.location.href = "ad_action_edit.html?id=" + id;
}
function orderOp(orderCode) {
	$("#orderCode").val(orderCode);
	var orderType = $("#orderType").val();
	if (orderType == "" || orderType == "2") {
		$("#orderType").val("1");
	} else if (orderType == "1") {
		$("#orderType").val("2");
	}
	$("#submitId").click();
}
