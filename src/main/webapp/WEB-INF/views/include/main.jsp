<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
table, table thead th {
	text-align: center;
}

</style>
<script>
function buttonChange(clickChangeState, autoChangeState) {
	var clickStatePanelId = clickChangeState.panelId;
	var clickStateIsApply = clickChangeState.isApply;
	

	console.log(clickStatePanelId+' '+clickStateIsApply)
	if(clickStateIsApply == true) {
		$('#state-td'+clickStatePanelId).text('Active');
		$('#'+clickStatePanelId).text('����');
		$('#'+clickStatePanelId).attr('class', 'btn btn-default state');
		$('#'+clickStatePanelId).data('apply', false);
	} else {
		$('#state-td'+clickStatePanelId).text('Inactive');
		$('#'+clickStatePanelId).text('����');
		$('#'+clickStatePanelId).attr('class', 'btn btn-info state');
		$('#'+clickStatePanelId).data('apply', true);
	}
	
	if(autoChangeState != null) {
		console.log('sdfdsfdsfsdf')
		var autoStatePanelId = autoChangeState.panelId;
		var autoStateIsApply = autoChangeState.isApply;
		
		$('#state-td'+autoStatePanelId).text('Inactive');
		$('#'+autoStatePanelId).text('����');
		$('#'+autoStatePanelId).attr('class', 'btn btn-info state');
		$('#'+autoStatePanelId).data('apply', true);
	}
}


/* �г� ����,���� ajax */
function stateChange(panelId, state, datas, dialog) {
	$.ajax({
		url: '${pageContext.servletContext.contextPath}/${mid}/api/'+panelId+'/isapply',
		type: 'put',
		dataType: 'json',
		contentType: 'application/json',
		data: JSON.stringify(datas),
		success: function(response) {
			if(state == true){
				dialog.dialog('close');	
			}
			buttonChange(response.data.clickChangeState, response.data.autoChangeState);
		}
	});
};

$(function() {
	/* panel �߰� �� ������ ���� dialog */
	var pageSelectDialog = $("#dialog-select-form").dialog({
		autoOpen : false, //�ڵ����� ����� X
		modal : true,
		buttons : {
			'����' : function() {
				if($('.chkbox:checked').length == 0) {
					$('.validateTips.normal').hide();
					$('.validateTips.error').show();
					return;
				}
				
				var datas = {"state": true};
				var list = [];
				$('.chkbox:checked').each(function(index, obj) {
					list.push(obj.value);
				});
				datas['data'] = list; 
				stateChange($(this).data("id"), true, datas, $(this));
			}
		},
		
		close : function() {
			$('.chkbox').prop('disabled', false);
			$('.chkbox').prop('checked', false);
			$('.validateTips.normal').show();
			$('.validateTips.error').hide();
		}
	});//pageSelectDialog
	

	/* ���� ��ư Ŭ�� */
	$('.state').click(function() {
		var state = false;
		var panelId = $(this).attr('id');
		var aaa = $(this).data('apply');
		if( aaa== true) {
			pageSelectDialog.dialog('open').data("id", panelId);
			return;
		}
		
		stateChange(panelId, false, {"state": false}, null);
	});
	
	/* dialog checkbox event */
	$('#chkbox-all').change(function() {
		if($(this).prop('checked')) {
			$('.chkbox:not(#chkbox-all)').attr('disabled', 'true');
			return;
		}
		
		$('.chkbox:not(#chkbox-all)').removeAttr('disabled');
	});
	$('.chkbox:not(#chkbox-all)').change(function() {
		if($('.chkbox:checked:not(#chkbox-all)').length > 0) {
			$('#chkbox-all').attr('disabled', 'true');
		} else if($('.chkbox:checked:not(#chkbox-all)').length == 0) {
			$('#chkbox-all').removeAttr('disabled');
		}
	});

	/* ���� ��ư click */
	// ����
	// 1. ���� ������ ��� row�� ���� �˻��ϴ� ���� ����
	//	131: if($(.state).data('apply') == false) ����
	// 2. ���� ��ư�� ���� tr�� ���������� ����
	//	138: removeTarget = $(this).parent().parent(); �߰�
	//	152: $(removeTarget).remove(); �߰�
	$('.btn-delete').click(function() {
		if($(this).prev().prev().data('apply') == false) {
			alert('���� ���� �� �������ּ���.');
			return;
		}
		var panelId = $(this).data('panelid');
		var count = $(this).data('count');
		var removeTarget = $(this).parent().parent();
		
		$.ajax({
			url: '${pageContext.servletContext.contextPath}/${mid}/api/delete?id='+panelId,
			type: 'GET',
			dataType: 'json',
			success: function(response) {
				if(response.data != 'removed') {
					console.log('can not remove');
					return;
				}
				
				//$('#tbl-panel-list tbody tr:nth-child('+count+')').remove();
				$(removeTarget).remove();
				
				for(i=1;i<=${fn:length(list)};i++) {
					$('#tbl-panel-list tbody tr:nth-child('+i+') td:first').text(i);
				}
				alert('�����Ǿ����ϴ�.');
			}
		});
	});
	
});



</script>
<div class="container">
	<h1>Application Main</h1>
	<div class="row">
		<a href="${pageContext.servletContext.contextPath }/${mid}/create"
			class="btn btn-primary pull-right">�����</a>
	</div>
	<div class="row">
		<table id="tbl-panel-list" class="table table-striped">
			<thead>
				<tr>
					<th>No.</th>
					<th>Panel Name</th>
					<th>Created Date</th>
					<th>State</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="panel" items="${list }" varStatus="stat">
					<tr>
						<td>${stat.count }</td>
						<td>${panel.name }</td>
						<td>${panel.createdDate }</td>
						<td id="state-td${panel.panelId }"><c:choose>
								<c:when test="${panel.script.isApply eq true}">
										Active
									</c:when>
								<c:otherwise>
										Inactive
									</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${panel.script.isApply eq true}">
									<button class="btn btn-default state" id="${panel.panelId }" data-apply="false">����</button>
								</c:when>
								<c:otherwise>
									<button class="btn btn-info state" id="${panel.panelId }" data-apply="true">����</button>
								</c:otherwise>
							</c:choose> 
							<a href="${pageContext.servletContext.contextPath }/${mid }/${panel.panelId }/update"
								class="btn btn-success">����</a>
							<button class="btn btn-danger btn-delete" data-panelid="${panel.panelId }" data-count="${stat.count }">����</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="dialog">
		<div id="dialog-select-form" title="�߰��� �г� ���� ������ ����" style="display:none">
			<p class="validateTips normal">��� ������� �г��� ������ �������� �������ּ���.</p>
			<p class="validateTips error" style="display:none">�ϳ� �̻� �����ؾ� �մϴ�.</p>
			<form>
				<input type="checkbox" class="chkbox" id="chkbox-all" name="chkbox-activepage" value="all"> ��ü ������ <br>
				<input type="checkbox" class="chkbox" id="chkbox-main" name="chkbox-activepage" value="main"> ���� ������<br>
				<input type="checkbox" class="chkbox" id="chkbox-product" name="chkbox-activepage" value="product"> ��ǰ ������<br>
			</form>
		</div>
		
		<div id="dialog-message" title="tets" style="display:none"> 
					<p></p>
		</div>
	</div>
</div>