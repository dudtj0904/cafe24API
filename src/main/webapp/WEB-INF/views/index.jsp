<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(function() {
	mallid = 'devbit005';
	clientid = '9A1VRuE0IRCkXF5SQjNJSC';
	redirect_uri = 'https://devbit005.cafe24.com/cafe24API/index2';
	scope = 'mall.read_product,mall.write_product';
	$.ajax({
		url: 'https://'+mallid+
			'.cafe24api.com/api/v2/oauth/authorize',
		type: 'post',
		dataType: 'json',
		data: 'response_type='+'code'+
				'&client_id='+clientid+
				'&state=123&redirect_uri='+redirect_uri+'&scope='+scope,
		success: function(response) {
			console.log(response);
			return;
		},
		error: function(err, a) {
			console.log(err);
			console.log(a);
			return;
		}
	});
});
</script>
</head>
<body>
	<h1>Hello World !!!</h1>
	<h1>${hello }</h1>
</body>
</html>