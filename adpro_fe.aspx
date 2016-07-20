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
			var q_readonly = ['txtNoa','txtWeight'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			q_desc = 1;
			aPop = new Array();

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
				bbmNum = [['txtWidth', 15, q_getPara('vcc.weightPrecision'), 1],['txtDime', 15, q_getPara('vcc.weightPrecision'), 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]];
				document.title='鋼筋存量設定';
				q_gt('add5', "where=^^1=1^^" , 0, 0, 0, "getadd5",r_accy,1); //號數
				var as = _q_appendData("add5", "", true);
				as.sort(function(a, b){if (a.typea > b.typea) {return 1;}if (a.typea < b.typea) {return -1;}});
				var t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].typea + '@' + as[i].typea;
					}
				}
				q_cmbParse("cmbStyle", t_item);
				
				q_gt('addrcase', "where=^^1=1^^", 0, 0, 0, "getaddrcase",r_accy,1); //材質
				var as = _q_appendData("addrcase", "", true);
				as.sort(function(a, b){if (a.addr > b.addr) {return 1;}if (a.addr < b.addr) {return -1;}});
				t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].addr + '@' + as[i].addr;
					}
				}
				q_cmbParse("cmbMon", t_item);
				q_gt('adsize', "where=^^1=1 and mon!='' ^^", 0, 0, 0, "getadsize",r_accy,1); //長度
				var as = _q_appendData("adsize", "", true);
				as.sort(function(a, b){if (a.mon > b.mon) {return 1;}if (a.mon < b.mon) {return -1;}});
				t_item = " @ ";
				if (as[0] != undefined) {
					for ( i = 0; i < as.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].mon + '@' + as[i].mon;
					}
				}
				q_cmbParse("cmbMemo1", t_item);
				
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
                            alert('號數:'+as[0].style+' 材質:'+as[0].mon+' 長度:'+as[0].memo1+' 已存在!!');
                            Unlock();
                            return;
                        } else {
                            var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
							if (s1.length == 0 || s1 == "AUTO")
								q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
							else
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
				q_box('adpro_fe_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#cmbStyle').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('disabled', 'disabled')
				$('#cmbStyle').focus();
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();

			}

			function btnOk() {
				Lock();
				
				
				t_where = "where=^^ style='" + $('#cmbStyle').val() + "' and mon='" + $('#cmbMon').val() + "' and memo1='" + $('#cmbMemo1').val() + "' and noa!='"+$('#txtNoa').val()+"' ^^";
				q_gt('adpro', t_where, 0, 0, 0, "check_btnOk", r_accy);
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
				$('#vewStyle').text('號數');
				$('#vewMon').text('材質');
				$('#vewMemo1').text('長度');
				$('#lblStyle').text('號數');
				$('#lblMon').text('材質');
				$('#lblMemo1').text('長度');
				$('#lblWidth').text('安全庫存量');
				$('#lblDime').text('螢幕顯示量');
				$('#lblWeight').text('庫存量');
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
						<td align="center" style="width:150px; color:black;"><a id='vewStyle'> </a></td>
						<td align="center" style="width:160px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:180px; color:black;"><a id='vewMemo1'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='style' style="text-align: center;">~style</td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='memo1' style="text-align: center;">~memo1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStyle' class="lbl"> </a></td>
						<td>
							<select id='cmbStyle'> </select>
							<input id="txtNoa"  type="text" class="txt c1" style="display: none;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><select id='cmbMon'> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo1' class="lbl"> </a></td>
						<td><select id='cmbMemo1'> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWidth' class="lbl"> </a></td>
						<td><input id="txtWidth"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDime' class="lbl"> </a></td>
						<td><input id="txtDime"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text" class="txt num c1" /></td>
					</tr>
					
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>