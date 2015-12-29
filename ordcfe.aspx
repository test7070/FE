<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">

			q_tables = 's';
			var q_name = "ordc";
			var q_readonly = ['txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtWeight', 'txtTotal', 'txtTax', 'txtTotalus'];
			var q_readonlys = ['txtC1', 'txtNotv', 'txtNo3', 'txtOrdbno', 'txtNo2'];
			var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 3, 1], ['txtFloata', 10, 4, 1]];
			var bbsNum = [['txtPrice', 15, 3, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 3, 1], ['txtMount', 10, 2, 1], ['txtTheory', 10, 3, 1], ['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A'],['txtIndate','999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx'],
				//['txtProductno1_', 'btnProductno1_', 'bcc', 'noa,product,unit', 'txtProductno1_,txtProduct_,txtUnit_', 'bcc_b.aspx'], 
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], 
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], 
				['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'], 
				['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx'], 
				['txtAddr2', '', 'view_road', 'memo,zipcode', '0txtAddr2,txtPost2', 'road_b.aspx'], 
				['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%'], 
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype,tel,fax,addr_fact,zip_fact', 'txtTggno,txtTgg,txtNick,txtPaytype,txtTel,txtFax,txtAddr,txtPost', 'tgg_b.aspx']
			);
			brwCount2 = 10;
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}

				mainForm(1);
			}

			function sum() {
				var t_unit, t_count, t_moneys,t_weight = 0, t_money= 0;
				var t_weight =0
				for (var j = 0; j < q_bbsCount; j++) {
					
					t_unit = $('#txtUnit_' + j).val().toUpperCase();
					t_count = t_unit.length==0 || t_unit=='KG' || t_unit=='公斤'?q_float('txtWeight_'+j):q_float('txtMount_'+j); 
					t_moneys = round(q_mul(q_float('txtPrice_'+j),t_count),0);
					t_money += t_moneys;
					$('#txtTotal_'+j).val(t_moneys);
					t_weight = q_add(t_weight,q_float('txtWeight_'+j));
				}
				$('#txtWeight').val(t_weight);
				$('#txtMoney').val(t_money);
				$('#txtTotal').val(t_money);
				calTax();
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

				$("#combPaytype").change(function(e) {
					if (q_cur == 1 || q_cur == 2)
						$('#txtPaytype').val($('#combPaytype').find(":selected").text());
				});
				$("#txtPaytype").focus(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				}).click(function(e) {
					var n = $(this).val().match(/[0-9]+/g);
					var input = document.getElementById("txtPaytype");
					if ( typeof (input.selectionStart) != 'undefined' && n != null) {
						input.selectionStart = $(this).val().indexOf(n);
						input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
					}
				});

				$("#cmbTaxtype").change(function(e) {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtFloata').change(function() {
					sum();
				});
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}

			function btnOk() {
			    Lock(1, {
                    opacity : 0
                });
				//日期檢查
				if ($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())) {
					alert(q_getMsg('lblOdate') + '錯誤。');
					Unlock(1);
					return;
				}
				if ($('#txtOdate').val().substring(0, 3) != r_accy) {
					alert('年度異常錯誤，請切換到【' + $('#txtOdate').val().substring(0, 3) + '】年度再作業。');
					Unlock(1);
					return;
				}
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtOdate').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('ordcfe_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_'+n).click();
                        });
                        $('#txtUnit_' + j).change(function() {
							sum();
						});
						$('#txtMount_' + j).change(function() {
							sum();
						});
						$('#txtWeight_' + j).change(function() {
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#txtTotal_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtOdate').val(q_date());
                $('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box("z_ordcfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !dec(as['total'])) {//不存檔條件
					as[bbsKey[1]] = '';
					/// no2 為空，不存檔
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				as['kind'] = abbm2['kind'];
				as['tggno'] = abbm2['tggno'];
				as['odate'] = abbm2['odate'];
				as['enda'] = abbm2['enda'];

				return true;
			}

			function refresh(recno) {
                _refresh(recno);
			}

			function q_popPost(s1) {
				switch (s1) {
					default:
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
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
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				width: 300px;
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
				width: 800px;
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
				color: black;
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
			.dbbs {
				width: 1200px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
			#dbbt {
				width: 1200px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewOdate"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewNoa"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNick"> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" class="control_noa" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td>
						<input id="txtOdate" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td><a id='lblIsproj' class="lbl" style="float:right;"> </a><span> </span>
						<input id="chkIsproj" type="checkbox" style="float:right;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCno" type="text" style="float:left;width:25%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"   type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td ><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtTggno" type="text" style="float:left;width:25%;"/>
						<input id="txtTgg"  type="text" style="float:left;width:75%;"/>
						<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtContract"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtTel"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblOrdb' class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtOrdbno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtFax" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
						<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>

					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
						<input id="txtPost"  type="text" style="float:left; width:25%;"/>
						<input id="txtAddr"  type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPaytype" type="text" style="float:left; width:115px;"/>
						<select id="combPaytype" style="float:left; width:25px;"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4" >
						<input id="txtPost2"  type="text" style="float:left; width:25%;"/>
						<input id="txtAddr2"  type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt" style="float:left; width:100%;"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>
						<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td>
						<input id="txtFloata" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbCoin" style="float:left;width:80px;" onchange='coin_chg()'></select></td>
						<td class="st"><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td class="st">
						<input id="txtWeight"  type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
						<input id="txtTax" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbTaxtype" style="float:left;width:80px;" ></select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7">
						<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td>
						<input id="txtApv" type="text"  class="txt c1" disabled="disabled"/>
						</td>
						<td><span> </span><a id='lblEnd' class="lbl"> </a></td>
						<td>
						<input id="chkEnda" type="checkbox"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:250px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblIndate_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNo2.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:45%;float:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:45%;float:left;"/>
						<input id="btnProduct.*" type="button" style="display:none;">
					</td>
					<td><input class="txt" id="txtLengthb.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtUnit.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtMount.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtWeight.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtPrice.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtTotal.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:95%;"></td>
					<td><input class="txt" id="txtIndate.*" type="text" style="width:95%;"></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
