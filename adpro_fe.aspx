<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			var q_name = "adpro";
			var q_readonly = ['txtProduct'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			q_desc = 1;
			aPop = new Array(
				['txtNoa', '', 'ucc', 'noa,product', 'txtNoa,txtProduct', 'ucc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				brwCount2 = 20;
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
				
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				bbmMask = [];
				q_mask(bbmMask);
				bbmNum = [['txtDiffprice', 3, 0, 1],['txtExprice', 1, 0, 1],['txtExreprice', 1, 0, 1]];
				document.title='安全庫存增加模式作業';
				
				$('#txtExprice').change(function() {
					if($(this).val()!='1'){
						$(this).val(0);
					}
				});
				$('#txtExreprice').change(function() {
					if($(this).val()!='1'){
						$(this).val(0);
					}
				});
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'check_btnOk':
						var as = _q_appendData("adpro", "", true);
                        if (as[0] != undefined) {
                            alert('物品編號【'+as[0].noa+'】已存在!!');
                            Unlock();
                            return;
                        } else {
                            var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
							wrServer(s1);
                        }
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('adpro_fe_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtDiffprice').val('10');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('disabled', 'disabled')
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();

			}

			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', '物品編號']]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				Lock();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if(q_cur==1){
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "' ^^";
					q_gt('adpro', t_where, 0, 0, 0, "check_btnOk", r_accy);
				}else{
					wrServer(s1);
				}
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 500px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 500px;
				/*margin: -1px;
				 border: 1px black solid;*/
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 25%;
				float: left;
			}
			.txt.c3 {
				width: 73%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.tbbs input[type="text"] {
				width: 98%;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.bbs {
				float: left;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewNoafe'>物品編號</a></td>
						<td align="center" style="width:160px; color:black;"><a id='vewProductfe'>物品名稱</a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='product' style="text-align: center;">~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa_fe' class="lbl">物品編號</a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct_fe' class="lbl">物品名稱</a></td>
						<td colspan="3"><input id="txtProduct" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDiffprice_fe' class="lbl">增加比例</a></td>
						<td><input id="txtDiffprice" type="text" class="txt num c1" style="width: 75%;"/><a class="lbl">%</a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblExprice_fe' class="lbl">第一次增量</a></td>
						<td><input id="txtExprice" type="text" class="txt num c1" style="width: 20px;" /></td>
						<td><span> </span><a id='lblExreprice_fe' class="lbl">第二次增量</a></td>
						<td><input id="txtExreprice" type="text" class="txt num c1" style="width: 20px;" /></td>
					</tr>
					
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>