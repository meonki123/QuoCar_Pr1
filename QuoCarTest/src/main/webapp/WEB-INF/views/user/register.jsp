<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/css/register.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>	
<body>
<h3>회원가입</h3>
<h2>Quo Car</h2>
<p class="w-pct60 right" style="margin: 0 auto; padding-bottom: 5px; font-size: 13px;">*는 필수 입력 항목입니다.</p>
<form>
	<table class="w-pct60">
		<tr>
			<th class="w-px160">* 성명</th>
			<td><input type="text" name="name" /></td>
		</tr>
		<tr>
			<th>* 아이디</th>
			<td>
				<input type="text" name="id" class="chk"/><br>
				<div class='valid'>아이디를 입력하세요(영문 소문자, 숫자만 입력 가능)</div>
			</td>
		</tr>
		<tr>
			<th>* 비밀번호</th>
			<td>
				<input type="password" name="pw" class="chk" />
				<div class="valid">비밀번호를 입력하세요(영문 대/소문자, 숫자를 모두 포함)</div>
			</td>
			
		</tr>
		<tr>
			<th>* 비밀번호 확인</th>
			<td>
				<input type="password" name="pw_ck" class="chk" />
				<div class="valid">비밀번호를 다시 입력하세요</div>
			</td>
		</tr>
		<tr>
			<th>* 성별</th>
			<td>
				<label><input type="radio" name="gender" value="남" checked/>남</label>
				<label><input type="radio" name="gender" value="여" />여</label>
			</td>
		</tr>
		<tr>
			<th>* 이메일</th>
			<td>
				<input type="text" name="email" />
				<div class="valid">이메일을 입력하세요</div>
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<input type="text" name="birth" readonly />
				<span id="delete" style="color: red; position: relative; right: 25px; display: none;"><i class="fas fa-times font-img"></i></span>
				<!-- fontawesome에서 가져온 무료 아이콘 -->
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<input type="text" name="tel" /> - 
				<input type="text" name="tel" /> - 
				<input type="text" name="tel" />
			</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<a class='btn-fill-s' onclick="daum_post()">우편번호 찾기</a>
				<input type="text" name="post"  class="w-px60" readonly />
				<input type="text" name="addr" readonly/>
				<input type="text" name="addr" />
			</td>
		</tr>
	</table>
</form>

<script type="text/javascript" src="js/join_check.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/js/all.min.js"></script> <!-- cdnjs.com에서 가져온 fontawesome cdn 라이브러리 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	<!-- jQuery ui -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	<!-- 다음 우편번호 api -->
<script type="text/javascript">
$('.chk').on('keyup', function(){
	validate($(this));
});

function validate(t) {
	var data = join.tag_status(t);
	display_status(t.siblings('div'), data);
}

function display_status(div, data) {
	div.text(data.desc);
	div.addClass(data.code)
}

// 만 13세 이상만 선택 가능하게 처리
var today = new Date();
var endDay = new Date( today.getFullYear()-13, today.getMonth(), today.getDate() );

$('[name=birth]').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,
	changeMonth: true,	
	showMonthAfterYear: true,
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	maxDate: endDay
	//beforeShowDay: after	//오늘 이후로 선택 못하게 하는 함수
});

$('[name=birth]').change(function() {
	$('#delete').css('display', 'inline-block');
});

$('#delete').click(function(){
	$('[name=birth]').val('');
	$('#delete').css('display', 'none');
});

function after(date) {
	if(date > new Date()) {
		return [false];
	} else {
		return [true];
	}
}

function daum_post() {
    new daum.Postcode({
        oncomplete: function(data) {
			$('[name=post]').val( data.zonecode );	//우편번호
            //지번 주소 : J, 도로명 주소 : R
            var address = data.userSelectedType == 'J' ? data.jibunAddress : data.roadAddress;	//클릭한 지번주소나, 도로명주소가 저장됨
            if(data.buildingName != '') {
				address += ' (' + data.buildingName + ')';	//건물 명이 있으면 건물 명을 붙여줌
            }
            $('[name=addr]').eq(0).val( address );
        }
    }).open();
}
</script>
</body>
</html>