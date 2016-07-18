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
			var q_name = "adknife";
			var q_readonly = ['txtNoa'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 10;
			aPop = new Array(
				['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				brwCount2 = 20
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
				bbmMask = [['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [['txtDime1', 10, 0, 1],['txtDime2', 10, 0, 1],['txtWidth1', 10, 0, 1],	['txtWidth2', 10, 0, 1],
									['txtKnife1', 10, 0, 1],['txtKnife2', 10, 0, 1],	['txtPrice', 10, 0, 1]];
				
				document.title='裁剪床設定';
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
						var as = _q_appendData("adknife", "", true);
                        if (as[0] != undefined) {
                            alert('噸數:'+as[0].price+' 號數:'+as[0].style+' 已存在!!');
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
				q_box('adknife_fe_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtMon').val(q_date().substring(0,6)).focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').attr('disabled', 'disabled')
				$('#txtProductno').focus();
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();

			}

			function btnOk() {
				if(dec($('#txtPrice').val())<=0){
					alert('請輸入正確噸數!!');
					return;
				}
				Lock();
				
				t_where = "where=^^ style='" + $('#cmbStyle').val() + "' and price='" + $('#txtPrice').val() + "' and noa!='"+$('#txtNoa').val()+"' ^^";
				q_gt('adknife', t_where, 0, 0, 0, "check_btnOk", r_accy);
			}

			function wrServer(key_value) {
				var i;
				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				$('#lblPrice').text('噸數');
				$('#lblStyle').text('號數');
				$('#lblKnife1').text('支/刀');
				$('#lblKnife2').text('小把/每大把');
				$('#lblDime').text('支/每小把');
				$('#lblWidth').text('把/排剪');
				$('#lblMemo').text('定尺尺寸');
				
				$('#vewPrice').text('噸數');
				$('#vewStyle').text('號數');
				$('#vewKnife1').text('支/刀');
				$('#vewKnife2').text('小把/每大把');
				$('#vewDime').text('支/每小把');
				$('#vewWidth').text('把/排剪');
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
				width: 600px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
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
				width: 410px;
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
				/*width: 10%;*/
			}
			.tbbm .tdZ {
				/*width: 1%;*/
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
						<td align="center" style="width:100px; color:black;"><a id='vewPrice'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewStyle'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewKnife1'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewKnife2'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewDime'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewWidth'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='price' style="text-align: center;">~price</td>
						<td id='style' style="text-align: center;">~style</td>
						<td id='knife1' style="text-align: center;">~knife1</td>
						<td id='knife2' style="text-align: center;">~knife2</td>
						<td id='dime1 dime2' style="text-align: center;">~dime1 ~ ~dime2</td>
						<td id='width1 width2' style="text-align: v;">~width1 ~ ~width2</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width: 100px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td>
							<input id="txtPrice" type="text" class="txt num c1" />
							<input id="txtNoa"  type="text" class="txt c1" style="display: none;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStyle' class="lbl"> </a></td>
						<td><select id='cmbStyle' > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblKnife1' class="lbl"> </a></td>
						<td><input id="txtKnife1"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblKnife2' class="lbl"> </a></td>
						<td><input id="txtKnife2"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDime' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtDime1"  type="text" class="txt num c1" style="width: 30%;"/>
							<a style="float: left;">~</a>
							<input id="txtDime2"  type="text" class="txt num c1" style="width: 30%;"/>
						</td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblWidth' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtWidth1"  type="text" class="txt num c1" style="width: 30%;"/>
							<a style="float: left;">~</a>
							<input id="txtWidth2"  type="text" class="txt num c1" style="width: 30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='3'><textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 350px;"> </textarea></td>
					</tr>
					<tr style="height:2px;"> </tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>