<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc=1;
			q_tables = 't';
			var q_name = "cont";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtApv', 'txtWorker2'];
			var q_readonlys = ['txtNoq'];
			var q_readonlyt = ['txtNoq'];
			var bbmNum = [];
			var bbsNum = [['txtMount',10,2,1],['txtWeight',10,2,1],['txtPrice',10,3,1]];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
							, ['txtTggno', 'lblTgg', 'custtgg', 'noa,comp,nick,conn', 'txtTggno,txtComp,txtNick', 'custtgg_b.aspx']
							, ['txtSales', 'lblSales', 'sss', 'namea,noa', 'txtSales,txtSalesno', 'sss_b.aspx']
							, ['txtAssigner', 'lblAssigner', 'sss', 'namea,noa', 'txtAssigner,txtAssignerno', 'sss_b.aspx']
							, ['txtAssistant', 'lblAssistant', 'sss', 'namea,noa', 'txtAssistant,txtAssistantno', 'sss_b.aspx']
							, ['txtBankno', 'lblBankno', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx']
							, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style','',0,0,0,'');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '');
			});
			
			function sum(){
				for(var i=0;i<q_bbsCount;i++){
					t_unit = $('#txtUnit_'+i).val().toUpperCase();
					t_total = round(q_mul((t_unit=='公斤' || t_unit=='KG' || t_unit.length==0 ?q_float('txtWeight_'+i) : q_float('txtMount_'+i)),q_float('txtPrice_'+i)),0);
					$('#txtTotal_'+i).val(t_total);
				}
			};
			
			function main() {
				if(dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}
			function mainPost() {
				q_getFormat();
				q_cmbParse("cmbKind", q_getPara('sys.stktype')); 
				bbmMask = [['txtEnddate', r_picd],['txtDatea', r_picd], ['txtPledgedate', r_picd], ['txtPaydate', r_picd], ['txtBcontdate', r_picd], ['txtEcontdate', r_picd], ['txtChangecontdate', r_picd]];
				q_mask(bbmMask);
				
				q_cmbParse("cmbTypea", '加工成型,板料');
				q_cmbParse("cmbEnsuretype", ('').concat(new Array('', '定存單質押', '不可撤銷保證', '銀行本票質押', '商業本票質押', '現金質押')));
				q_cmbParse("cmbEtype", ('').concat(new Array('','存入', '存出')));
				q_gt('acomp', '', 0, 0, 0, "");
				$('#btnConn_cust').click(function() {
					t_where = "noa='" + $('#txtTggno').val() + "'";
					q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Conn_cust', "95%", "650px", q_getMsg('lblConn'));
				});
				/*$('#lblStype').click(function(e) {
					q_box("conttype.aspx", 'conttype', "90%", "600px", q_getMsg("popConttype"));
				});*/

				$('#lblCust2').click(function(e) {
					q_box("cust_b2.aspx", 'cust', "90%", "600px", q_getMsg("popCust"));
				});
				
				//------------------------------------------------------
				$('#cmbTypea').change(function(e){
					refreshData();
				});
				$('#c1_1_a').change(function(e){
					refreshData();
				});
				$('#c2_1').change(function(e){
					refreshData();
				});
				$('#c6_1').change(function(e){
					refreshData();
				});
				$('#b1_1_a').change(function(e){
					refreshData();
				});
				$('#b2_1').change(function(e){
					refreshData();
				});
				$('#b6_1').change(function(e){
					refreshData();
				});
				$('#b5_1').change(function(e){
					refreshData();
				});
			}

			function q_boxClose(s2) {///   q_boxClose 2/4
				var ret;
				switch (b_pop) {
					case 'conttype':
						location.href = (location.origin == undefined ? '' : location.origin) + location.pathname + "?" + r_userno + ";" + r_name + ";" + q_id + ";;" + r_accy;
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'acomp':
						var as = _q_appendData("acomp", "", true);
						var t_item = " @ ";
						var t_item2 = " @ ";
						 for ( i = 0; i < as.length; i++) {
						 	t_item2 = t_item2 + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
						 	t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
						 }
						 //q_cmbParse("cmbCno", t_item);
						 q_cmbParse("cmbCnonick", t_item2);
						 q_cmbParse("cmbGuarantorno", t_item);
						 if(abbm[q_recno]){
						 	//$("#cmbCno").val(abbm[q_recno].cno);
						 	$("#cmbCnonick").val(abbm[q_recno].cno);
						 	$("#cmbGuarantorno").val(abbm[q_recno].guarantorno);
						 }
						break;
					case 'style' :
							var as = _q_appendData("style", "", true);
							StyleList = new Array();
							StyleList = as;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}
			
			function getString(obj){
				var string = '';
				var cobj = obj.children();
				if(cobj.length==0){
					if(obj.eq(0)[0].nodeName == 'BR'){
						string += '\n';
					}else if(!obj.eq(0).is(":visible")){
						;
					}else if(obj[0].nodeName == 'INPUT' || obj[0].nodeName == 'SELECT'){
						string = obj.val();
					}
					else{
						string = obj.text();
					}
				}else{
					var string = '';
					for(var i=0;i<cobj.length;i++){
						if(cobj.eq(i)[0].nodeName == 'BR'){
							string += '\n';
						}else if(!cobj.eq(i).is(":visible")){
							;
						}else if(cobj.eq(i).attr('id')=='b5_1'){
							;
						}else if(cobj.eq(i).attr('id')=='c6_1'){
							;
						}else if(cobj.eq(i)[0].nodeName == 'SELECT'){
							string+=cobj.eq(i).val();
						}else{
							string+=getString(cobj.eq(i));	
						}
					}
				}
				return string;
			}

			function btnOk() {
				var curObj = ($('#cmbTypea').val()=='加工成型'?$('#divBB'):$('#divCC'));
				
				for(var i=0;i<q_bbtCount;i++){
					$('#btnMinut__'+i).click();
				}
				var obj=curObj.find('input,select');
				for(var i=0;i<obj.length;i++){
					if(q_bbtCount<i){
						$('#btnPlut').click();
					}
					$('#txtKeya__'+i).val(obj.eq(i).attr('id'));
					$('#txtValue__'+i).val(obj.eq(i).val());
				}
				//MEMO2
				var memo2 = '';
				var obj = curObj.find('tr');
				var string = '';
				for(var i=0;i<obj.length;i++){
					string = getString(obj.eq(i));
					if(string.length>0)
						memo2 += (i==0?'':'\n') + string;
				}
				$('#txtMemo2').val(memo2);
				//----------------------------------------------------------------
				/*$('#txtAcomp').val($('#cmbCno').find(":selected").text());
				$('#cmbCnonick').val($('#cmbCno').val());
				$('#txtAcompnick').val($('#cmbCnonick').find(":selected").text());
				$('#txtGuarantor').val($('#cmbGuarantorno').find(":selected").text());
				*/
				sum();
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_contst') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if(q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('quat_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			

			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						
						$('#txtMount_' + j).change(function () {
							sum();
						});
						$('#txtPrice_' + j).change(function () {
							sum();
						});
						$('#txtWeight_' + j).change(function () {
							sum();
						});
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });
						//-------------------------------------------------------------------------------------
					}
				}
				_bbsAssign();
				refreshData();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtTggno').focus();
				
				loadData();
			}

			function btnModi() {
				if(emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtTggno').focus();
				
				loadData();
			}

			function btnPrint() {
				q_box("z_contfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val()),typea:trim($('#cmbTypea').val())}) + ";" + r_accy + "_" + r_cno, 'cont', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if(!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				return true;
			}
			function bbtSave(as) {
				if (!as['keya']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			function refreshDivBB(){
				$('#divBB').show();
				$('#divBB').find('.b1_4').remove();
				var obj = $('.b1_3');
				var n=0;
				for(var i=0;i<q_bbsCount;i++){
					if($('#txtProduct_'+i).val().length>0){
						n++;
						obj.after('<tr class="b1_4"><td><a>　</a><a>'+(n==1?'(3)':'　 ')+'</a><a>'+$('#txtProduct_'+i).val()+'每噸加價</a><input type="text" style="width:60px;" id="b1_4_'+n+'" /><a>元。</a></td></tr>');
						obj = obj.next();
						if(!(q_cur==1 || q_cur==2))
							$('#b1_4_'+n).attr('disabled', 'disabled');
						for(var j=0;j<q_bbtCount;j++){
							if($('#txtKeya__'+j).val()=='b1_4_'+n){
								$('#b1_4_'+n).val($('#txtValue__'+j).val());
								break;
							}
						}
					}
				}
				
				$('.b5_1x').hide();
				if($('#b1_1_a').val()=='含'){
					switch($('#b5_1').val()){
						case 'A':
							$('#b5_1_a').show();
							break;
						case 'B':
							$('#b5_1_b').show();
							break;
						case 'C':
							$('#b5_1_c').show();
							break;
					}
				}else{
					switch($('#b5_1').val()){
						case 'A':
							$('#b5_1_d').show();
							break;
						case 'B':
							$('#b5_1_e').show();
							break;
						case 'C':
							$('#b5_1_f').show();
							break;
					}
				}
				$('#b2_1_a').hide();
				$('#b2_1_b').hide();
				switch($('#b2_1').val()){
					case '廠交(自運)':
						$('#b2_1_a').show();
						break;
					case '自訂':
						$('#b2_1_b').show();
						break;
					default:
						break;
				};
				
				$('#b6_1_a').hide();
				$('#b6_1_b').hide();
				$('#b6_1_c').hide();
				$('#b6_1_d').hide();
				switch($('#b6_1').val()){
					case '預付':
						$('#b6_1_a').show();
						break;
					case '月結':
						$('#b6_1_b').show();
						break;
					case '電匯':
						$('#b6_1_c').show();
						break;
					case '自訂':
						$('#b6_1_d').show();
						break;
					default:
						break;
				};
				$('#divBB').find('input[type="text"]').css('text-align','right');
				$('#b3_1').css('text-align','center');
				$('#b5_1_a_a').css('text-align','center');
				$('#b5_1_b_a').css('text-align','center');
				$('#b5_1_c_a').css('text-align','center');
				$('#b5_1_d_a').css('text-align','center');
				$('#b5_1_e_a').css('text-align','center');
				$('#b5_1_f_a').css('text-align','center');
				$('#b6_9_1').css('text-align','center');
			}
			function refreshDivCC(){
				$('#divCC').show();
				$('#divCC').find('.c1_4').remove();
				var obj = $('.c1_3');
				var n=0;
				for(var i=0;i<q_bbsCount;i++){
					if($('#txtProduct_'+i).val().length>0){
						n++;
						obj.after('<tr class="c1_4"><td><a>　</a><a>'+(n==1?'(4)':'　 ')+'</a><a>'+$('#txtProduct_'+i).val()+'每噸加價</a><input type="text" style="width:60px;" id="c1_4_'+n+'" /><a>元。</a></td></tr>');
						obj = obj.next();
						if(!(q_cur==1 || q_cur==2))
							$('#c1_4_'+n).attr('disabled', 'disabled');
						for(var j=0;j<q_bbtCount;j++){
							if($('#txtKeya__'+j).val()=='c1_4_'+n){
								$('#c1_4_'+n).val($('#txtValue__'+j).val());
								break;
							}
						}
					}
				}
				
				if($('#c1_1_a').val()=='含'){
					$('#c5_1_a').show();
					$('#c5_1_b').hide();
				}else{
					$('#c5_1_a').hide();
					$('#c5_1_b').show();
				}
				$('#c2_1_a').hide();
				$('#c2_1_b').hide();
				switch($('#c2_1').val()){
					case '廠交(自運)':
						$('#c2_1_a').show();
						break;
					case '自訂':
						$('#c2_1_b').show();
						break;
					default:
						break;
				};
				
				$('#c6_1_a').hide();
				$('#c6_1_b').hide();
				$('#c6_1_c').hide();
				$('#c6_1_d').hide();
				switch($('#c6_1').val()){
					case '預付':
						$('#c6_1_a').show();
						break;
					case '月結':
						$('#c6_1_b').show();
						break;
					case '電匯':
						$('#c6_1_c').show();
						break;
					case '自訂':
						$('#c6_1_d').show();
						break;
					default:
						break;
				};
				$('#divCC').find('input[type="text"]').css('text-align','right');
				$('#c3_1').css('text-align','center');
				$('#c5_1_a_a').css('text-align','center');
				$('#c5_1_b_a').css('text-align','center');
				$('#c6_9_1').css('text-align','center');
			}
			function refreshData(){
				if($('#cmbTypea').val()=='加工成型'){
					$('#divCC').hide();
					refreshDivBB();
				}else{
					$('#divBB').hide();
					refreshDivCC();
				}
			}
			function loadData(){
				var curObj = ($('#cmbTypea').val()=='加工成型'?$('#divBB'):$('#divCC'));
				refreshData();
				var obj = curObj.find('input');
				for(var i=0;i<obj.length;i++){
					obj.eq(i).val('');
				}
				var obj = curObj.find('select');
				for(var i=0;i<obj.length;i++){
					obj.eq(i)[0].selectedIndex = 0;
				}
				for(var i=0;i<q_bbtCount;i++){
					$('#'+$('#txtKeya__'+i).val()).val($('#txtValue__'+i).val());
				}
				refreshData();
			}
			function refresh(recno) {
				_refresh(recno);
				loadData();
			}
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
		                	$(this).attr('OldValue',$('#txtProductno_'+thisId).val());
						});
                        if(trim($('#txtStyle_' + b_seq).val()).length != 0)
                        	ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
						
						refreshData();
					break;
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#divBB').find('input,select').attr('disabled', 'disabled');
					$('#divCC').find('input,select').attr('disabled', 'disabled');
				} else {
					$('#divBB').find('input,select').removeAttr('disabled');
					$('#divCC').find('input,select').removeAttr('disabled');
				}
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
		.dview {
			float: left;
			width: 28%;
		}	
		.tview {
			margin: 0;
			padding: 2px;
			border: 1px black double;
			border-spacing: 0;
			font-size: medium;
			background-color: #FFFF66;
			color: blue;
			width: 100%;
		}
		.tview td {
			padding: 2px;
			text-align: center;
			border: 1px black solid;
		}
		.dbbm {
			float: left;
			width: 70%;
			margin: -1px;
			border: 1px black solid;
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
			width: 9%;
		}
		.tbbm .tdZ {
			width: 2%;
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
			font-size: medium;
		}
		.tbbm tr td .lbl.btn:hover {
			color: #FF8F19;
		}
		.txt.c1 {
			width: 98%;
			float: left;
		}
		.txt.c6 {
			width: 85%;
			text-align:center;
		}
		.txt.c7 {
			width: 95%;
			float: left;
		}
		.txt.c8 {
			float:left;
			width: 65px;
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
		.tbbm td input[type="button"] {
			float: left;
		}
		.tbbm select {
			border-width: 1px;
			padding: 0px;
			margin: -1px;
			font-size:medium;
		}
		.dbbs {
			float:left;
			width: 100%;
		}
		.tbbs a {
			font-size: medium;
		}
		.num {
			text-align: right;
		}
		.tbbs tr.error input[type="text"] {
			color: red;
		}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
		.trX{
			background: pink;
		}
		.trTitle{
			padding-left: 18px;
			font-size: 18px;
			font-weight: bolder;
			color: brown;
			letter-spacing: 5px;
		}
</style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
	<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewEcontdate'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
						<td align="center" id='econtdate'>~econtdate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td><input id="txtEnddate" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtAcomp"  type="text" class="txt" style="width:70%; float: left;"/>
						</td>
						<td><span> </span><a id="lblStype" class="lbl">類型</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%; float: left;"/>
							<input id="txtNick"  type="text" style="display: none;"/>
						</td>
						<td><input id="btnConn_cust" type="button" /></td>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProj' class="lbl"> </a></td>
						<td colspan="2"><input id="txtProj" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblSite' class="lbl"> </a></td>
						<td colspan="2"><input id="txtSite" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblChktype' class="lbl"> </a></td>
						<td><input id="txtChktype" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id='lblBcontdate' class="lbl"> </a></td>
						<td class="td4"><input id="txtBcontdate" type="text"  class="txt c1"/></td>
						<td align="center"><a id="lblEcontdate"> </a></td>
						<td class="td6"><input id="txtEcontdate" type="text"  class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblChangecontdate' class="lbl"> </a></td>
						<td class="td8"><input id="txtChangecontdate" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblContitem' class="lbl"> </a></td>
						<td class="td2" colspan="7"><input id="txtContitem" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="3">
							<!--<select id="cmbCno" class="txt c1"> </select>-->
							<select id="cmbCnonick" class="txt c1" style="display:none;"> </select>
							<input id="txtAcomp"  type="hidden" class="txt" style="width:80%; float: left;"/>
							<input id="txtAcompnick"  type="hidden" style="display: none;"/>
						</td>
						<td ><span> </span><a id="lblGuarantor" class="lbl"> </a></td>
						<td  colspan="3">
							<select id="cmbGuarantorno" class="txt c1"> </select>
							<input id="txtGuarantor"  type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td>
							<input id="txtSalesno" type="text" class="txt" style="display: none;"/>
							<input id="txtSales" type="text" class="txt c1">
						</td>
						<td><span> </span><a id='lblAssigner' class="lbl btn"> </a></td>
						<td>
							<input id="txtAssignerno" type="text" class="txt" style="display: none;"/>
							<input id="txtAssigner" type="text" class="txt c1">
						</td>
						<td><span> </span><a id="lblAssistant" class="lbl btn"> </a></td>
						<td>
							<input id="txtAssistantno" type="text" class="txt" style="display: none;"/>
							<input id="txtAssistant" type="text" class="txt c1">
						</td>
					</tr>
					<tr>
						<td colspan="8" class="trX"><span> </span><a class="trTitle">保證金</a></td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblEtype' class="lbl"> </a></td>
						<td class="trX"><select id="cmbEtype" class="txt c1"> </select></td>
						<td class="trX"><span> </span><a id='lblEnsuretype' class="lbl"> </a></td>
						<td class="trX"><select id="cmbEnsuretype" class="txt c1"> </select></td>
						<td class="trX"><span> </span><a id='lblEarnest' class="lbl"> </a></td>
						<td class="trX"><input id="txtEarnest" type="text"  class="txt c1 num"/></td>
						<td class="trX" colspan="2"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id="lblBankno_st" class="lbl btn"> </a></td>
						<td class="trX" colspan="3">
							<input id="txtBankno" type="text" style="width:30%; float: left;"/>
							<input id="txtBank"  type="text"  style="width:70%; float: left;"/>
						</td>
						<td class="trX"><span> </span><a id='lblCheckno_st' class="lbl"> </a></td>
						<td class="trX" colspan="3"><input id="txtCheckno" type="text"  class="txt c1"/></td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblPledgedate' class="lbl"> </a></td>
						<td class="trX"><input id="txtPledgedate" type="text"  class="txt c1"/></td>
						<td class="trX"><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td class="trX"><input id="txtPaydate" type="text"  class="txt c1"/></td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><textarea id="txtMemo" rows="5" cols="10" type="text" class="txt c1"></textarea></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblMemo2' class="lbl"> </a></td>
						<td colspan="7"><textarea id="txtMemo2" rows="5" cols="10" type="text" class="txt c1"></textarea></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td class="td1"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker2"  type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id='lblApv' class="lbl"> </a></td>
						<td class="td4"><input id="txtApv"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEnda' class="lbl"> </a></td>
						<td><input id="chkEnda" type="checkbox"/></td>
					</tr>
				</table>
			</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
				  	<td style="width:20px;">
					<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'>品名</a></td>
					<td align="center" style="width:120px;"><a>規格</a></td>
					<td align="center" style="width:60px;"><a id='lblUnit_s'>單位</a></td>
					<td align="center" style="width:60px;"><a id='lblLengthb_s'>單支長</a></td>
					<td align="center" style="width:60px;"><a id='lblMount_s'>數量</a></td>
					<td align="center" style="width:60px;"><a id='lblWeight_s'>重量</a></td>
					<td align="center" style="width:60px;"><a id='lblPrice_s'>單價</a></td>
					<td align="center" style="width:60px;"><a id='lblTotal_s'>小計</a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'>備註</a></td>
					<td align="center" style="width:50px;"><a id='lblEnda_s'>結案</a></td>
					<td align="center" style="width:70px;">議價記錄1</td>
					<td align="center" style="width:70px;">議價記錄2</td>
					<td align="center" style="width:70px;">議價記錄3</td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input type="text" id="txtNoq.*"  style="display: none;"/>
						<input type="text" id="txtProductno.*"  style="width:45%; float:left;"/>
						<input id="txtProduct.*" type="text" class="txt"style="width:45%; float:left;"/>
						<input class="btn"  id="btnProduct.*" type="button" style="display: none;" />
					</td> 
					<td ><input id="txtSize.*" type="text"  class="txt c7"/></td>
					<td ><input id="txtUnit.*" type="text"  class="txt c7"/></td>
					<td ><input id="txtLengthb.*" type="text"  class="txt num c7"/></td>
					<td ><input id="txtMount.*" type="text"  class="txt num c7"/></td>
					<td ><input id="txtWeight.*" type="text"  class="txt num c7" /></td>
					<td ><input id="txtPrice.*" type="text" class="txt num c7" /></td>
					<td ><input id="txtTotal.*" type="text" class="txt num c7" /></td>
					<td><input id="txtMemo.*" type="text" class="txt c7"/></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td ><input id="txtGweight.*" type="text" class="txt num c7" /></td>
					<td ><input id="txtOrdgweight.*" type="text" class="txt num c7" /></td>
					<td ><input id="txtOrdeweight.*" type="text" class="txt num c7" /></td>
				</tr>
			</table>
		</div>
	</div>
	<input id="q_sys" type="hidden" />
	<div id="dbbt" style="display:none;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:100px; text-align: center;">field</td>
						<td style="width:100px; text-align: center;">value</td>
						<td style="width:200px; text-align: center;">備註</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input class="txt" id="txtKeya..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtValue..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		
		<div id='divBB' style="font-family: '細明體';">
			<table>
				<tr>
					<td>
						<a>1.</a><a>(1)</a><a>本報價單價不含5%稅金。</a>
						<select id="b1_1_a"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a>運費、</a>
						<select id="b1_1_b"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a>磅費、</a>
						<select id="b1_1_c"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a>檢驗費。</a>
					</td>
				</tr>
				<tr class="b1_3">
					<td>
						<a>　(2)馬架10CM以下，圓型特殊框型不在此單價內。</a>
					</td>
				</tr>
				<!-- 依BBS  動態產生
		 		<tr class="b1_4"><td><a>　</a><a>（3）</a><a>鋼筋3#每噸加價</a><input type="text" style="width:60px;" id="c1_4_a" /><a>元。</a></td></tr>
				<tr class="b1_4"><td><a>　</a><a>　</a><a>鋼筋9#每噸加價</a><input type="text" style="width:60px;" id="c1_4_b" /><a>元。</a></td></tr>
				<tr class="b1_4"><td><a>　</a><a>　</a><a>鋼筋11#每噸加價</a><input type="text" style="width:60px;" id="c1_4_c" /><a>元。</a></td></tr>
				-->
				<tr><td><a>　</a><a>(4)</a><a>本報價單不含至續接廠運輸費用。</a></td></tr>
				<tr><td><a>　</a><a>(5)</a><a>加工成型部份為不分板料、彎料、直料。</a></td></tr>
				<tr><td><a>　</a><a>(6)</a><a>加工成型部份尺寸公差為±5公分。此單價不含裁切長度70CM以下直料。</a></td></tr>
				
				<tr>
					<td>
						<a style="float:left;">2.</a><a style="float:left;">交貨地點：</a>
						<select id="b2_1" style="float:left;">
							<option value='廠交(自運)'>廠交(自運)</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="b2_1_a" style="float:left;">
							<a>　</a>
						</div>
						<div id="b2_1_b" style="float:left;">
							<a>　</a><input type="text" style="width:120px;" id="b2_1_b_1"/>
						</div>
						<a style="float:left;">交貨期限：</a>
						<input type="text" style="width:40px;float:left;" id="b2_1_c"/>
						<a style="float:left;">年</a>
						<input type="text" style="width:40px;float:left;" id="b2_1_d"/>
						<a style="float:left;">月</a>
						<input type="text" style="width:40px;float:left;" id="b2_1_e"/>
						<a style="float:left;">日止。</a>
					</td>
				</tr>
				<tr><td><a>3.</a><a>工程名稱：</a><input type="text" style="width:200px;" id="b3_1"/></td></tr>
				<tr><td><a>4.</a><a>鋼筋計價重量：以乙方實際過磅為準，若磅差超出千分之三時甲方得要求公證地磅會磅，</a></td></tr>
				<tr><td><a>　千分之三內甲方不得扣失重，若超出千分之三以上，雙方各半。</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">5.交貨辦法：</a>
						<select id="b5_1" style="float:left;">
							<option value='A'>A</option>
							<option value='B'>B</option>
							<option value='C'>C</option>
						</select>
					</td>
				</tr>
				<!-- 含運  -->
				<tr id="b5_1_a" class="b5_1x">
					<td>
						<a>　</a><a>(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="b5_1_a_a"/>
						<a>，買方負責卸貨。</a>
						<br>
						<a>　　 出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="b5_1_a_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_b" class="b5_1x">
					<td>
						<a>　</a><a>(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_b_a"/>
						<a>，賣方負責卸貨。</a>
						<br>
						<a>　　 出貨需達10噸，未達10噸者須補貼運費至10噸，每噸</a><input type="text" style="width:60px;" id="b5_1_b_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_c" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_c_a"/>
						<a>限</a><input type="text" style="width:60px;" id="b5_1_c_b"/>
						<a>運輸以內，賣方負責卸貨。</a>
					</td>
				</tr>
				<!-- 不含運  -->
				<tr id="b5_1_d" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="b5_1_d_a"/>
						<a>，每噸</a><input type="text" style="width:60px;" id="b5_1_d_b"/>
						<a>元，甲方負責卸貨。</a>
						<br>
						<a>　　　出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="b5_1_d_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_e" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_e_a"/>
						<a>，每噸</a><input type="text" style="width:60px;" id="b5_1_e_b"/>
						<a>元，乙方負責卸貨。</a>
						<br>
						<a>　　　出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="b5_1_e_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_f" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_f_a"/>
						<a>，每趟</a><input type="text" style="width:60px;" id="b5_1_f_b"/>
						<a>)元。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(2)鋼筋材料若為加工成型者，甲方應於21日前通知乙方交貨數量規格。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(3)甲方工地向乙方訂貨後，如遇天災或人力不可抗力之因素時，由雙方再議定交貨時間</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 ，經乙方同意展期外，甲方應按訂貨數量交貨。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(4)甲方應備妥足夠容納進貨之場地，及35噸拖車可安全到達之卸貨場地，否則因而產生的其他費用</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　由甲方負擔。 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(5)</a>
						<a>板車料長度12M、14M。超長運費加價14.1M~15M，毎米毎噸加價 </a><input type="text" style="width:60px;" id="b5_1_5_a"/><a>元，</a>
						<br>
						<a>　　 超長運費加價15.1M~18M，毎米毎噸加價</a><input type="text" style="width:60px;" id="b5_1_5_b"/><a>元，不足一米以一米計。 </a>
					</td>
				</tr>
				
				<tr>
					<td>
						<a>6.</a><a>付款條件：</a>
					</td>
				</tr>
				<tr>
					<td>
						<a style="float:left;">　(1)</a>
						<select id="b6_1" style="float:left;">
							<option value='預付'>預付</option>
							<option value='月結'>月結</option>
							<option value='電匯'>電匯</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="b6_1_a" style="float:left;">
							<a>預付</a><input type="text" style="width:40px;" id="b6_1_a_1"/><a>%貨款現金含稅為訂金，</a>
							<select id="b6_1_a_2">
								<option value='訂金抵尾款'>訂金抵尾款</option>
								<option value='訂金依出貨比例扣除'>訂金依出貨比例扣除</option>
							</select>
							<a>。每月出貨貨款為當月月結</a><input type="text" style="width:40px;" id="b6_1_a_3"/><a>天票期。</a>
							<br>
							<a>　　 例：7月帳，開立9月10日到期支票。</a>
							<br>
							<a>　　 交貨期限到需將未出鋼筋噸數的金額扣除訂金依 當期貨款支付現金完案。</a>
						</div>
						<div id="b6_1_b" style="float:left;">
							<a>每月出貨貨款為當月月結</a><input type="text" style="width:40px;" id="b6_1_b_1"/><a>天票期。例：7月帳，開立9月10日到期支票。</a>
							<br>
							<a>　　 交貨期限到需將未出鋼筋噸數的金額依當期貨款支付現金完案。</a>
						</div>
						<div id="b6_1_c" style="float:left;">
							<a>出貨前電匯貨款全額。</a><input type="text" style="width:150px;" id="b6_1_c_1"/>
						</div>
						<div id="b6_1_d" style="float:left;">
							<a></a><input type="text" style="width:150px;" id="b6_1_d_1"/>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(2)</a><a>甲方同意依照合約所定之付款日期及方式繳付價款予乙方，如逾期未付則按總價款</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 之日息萬分之六計算遲延付款之利息，乙方並得據以暫停出貨。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>7.</a><a>材料檢驗：</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　(1)</a><a>乙方鋼筋出廠毎批均附鋼筋無輻射證明，甲方需要檢驗報告時依CNS560規範執行。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　(2)</a><a>鋼筋未經送驗合格前，不得加工及使用，否則所衍費用由甲方自行吸收，且該批鋼筋不得辦理</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 退貨。</a>
					</td>
				</tr>
          		<tr>
					<td>
						<a>8.</a><a>特約事項：乙方所提供材料於甲方各期貨款支付或票據兌現前乙方仍保有所有權。</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<a>9.</a><a>本交易為附條件買賣，依動產交易法第三章之規定，在貨款未付清或票據未兌現之前，標的物之所有權歸屬本公司所有，買受人無異議，本公司無需經法律程序隨時取回本貨品或貨物清償。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>10.</a><a>本合約所立條文不得任意更改。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>11.</a><a>本合約如有爭議雙方願以高雄地方法院為第一管轄法院。</a>
					</td>
				</tr>
			</table>
		</div>
		
		<div id='divCC' style="font-family: '細明體';">
			<table>
				<tr>
					<td>
						<a>1.</a><a>(1)</a><a>本報價單價不含5%稅金。</a>
						<select id="c1_1_a"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a>運費、</a>
						<select id="c1_1_b"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a>磅費、</a>
						<select id="c1_1_c"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a>檢驗費。</a>
					</td>
				</tr>
				<tr><td><a>　(2)</a><a>定尺品每噸加價</a><input type="text" style="width:60px;" id="c1_2_a" /><a>元。定尺品長度最短2米，以0.1米為一單位，尺寸公差為±10公分。</a></td></tr>
				<tr><td><a>　　 16米以上定尺價格另議。板料不拆支。</a></td></tr>
				<tr class="c1_3"><td><a>　</a><a>(3)</a><a>定尺品每尺寸最少5噸，不足5噸依加工成型計價。</a></td></tr>
			 	
			 	<!-- 依BBS  動態產生
		 		<tr class="c1_4"><td><a>　</a><a>(4)</a><a>鋼筋3#每噸加價</a><input type="text" style="width:60px;" id="c1_4_a" /><a>元。</a></td></tr>
				<tr class="c1_4"><td><a>　</a><a>　</a><a>鋼筋9#每噸加價</a><input type="text" style="width:60px;" id="c1_4_b" /><a>元。</a></td></tr>
				<tr class="c1_4"><td><a>　</a><a>　</a><a>鋼筋11#每噸加價</a><input type="text" style="width:60px;" id="c1_4_c" /><a>元。</a></td></tr>
				-->
				<tr><td><a>　</a><a>(5)</a><a>本報價單不含至續接廠運輸費用。</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">2.</a><a style="float:left;">交貨地點：</a>
						<select id="c2_1" style="float:left;">
							<option value='廠交(自運)'>廠交(自運)</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="c2_1_a" style="float:left;">
							<a>　</a>
						</div>
						<div id="c2_1_b" style="float:left;">
							<a>　</a><input type="text" style="width:120px;" id="c2_1_b_1"/>
						</div>
						<a style="float:left;">交貨期限：</a>
						<input type="text" style="width:40px;float:left;" id="c2_1_c"/>
						<a style="float:left;">年</a>
						<input type="text" style="width:40px;float:left;" id="c2_1_d"/>
						<a style="float:left;">月</a>
						<input type="text" style="width:40px;float:left;" id="c2_1_e"/>
						<a style="float:left;">日止。</a>
					</td>
				</tr>
				<tr><td><a>3.</a><a>工程名稱：</a><input type="text" style="width:200px;" id="c3_1"/></td></tr>
				<tr><td><a>4.</a><a>鋼筋計價重量：以乙方實際過磅為準，若磅差超出千分之三時買方得要求公證地磅會磅，</a></td></tr>
				<tr><td><a>　千分之三內甲方不得扣失重，若超出千分之三以上，雙方各半。</a></td></tr>
				<tr>
					<td>
						<a>5.</a><a>交貨辦法：</a>
					</td>
				</tr>
				<tr id="c5_1_a">
					<td>
						<a>　(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="c5_1_a_a"/><a>，</a>
						<select id="c5_1_a_b"><option value='買方'>甲方</option><option value='賣方'>乙方</option></select>
						<a>負責卸貨。</a>
						<br>
						<a>　　 出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="c5_1_a_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="c5_1_b">
					<td>
						<a>　(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="c5_1_b_a"/><a>，每噸</a><input type="text" style="width:60px;" id="c5_1_b_b"/><a>元。</a>
						<a>買方負責卸貨。</a>
						<br>
						<a>　　 出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="c5_1_b_c"/><a>元。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(2)</a>
						<a>鋼筋材料若為定尺料者，買方應於14日前通知賣方交貨數量規格。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(3)</a>
						<a>甲方工地向乙方訂貨後，如遇天災或人力不可抗力之因素時，由雙方再議定交貨時間，</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 經乙方同意展期外，買方應按訂貨數量交貨。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(4)</a>
						<a>甲方應備妥足夠容納進貨之場地，及35噸拖車可安全到達之卸貨場地，否則因而產生的其他費用 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 由甲方負擔。 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(5)</a>
						<a>板車料長度12M、14M。超長運費加價14.1M~15M，毎米毎噸加價 </a><input type="text" style="width:60px;" id="c5_1_5_a"/><a>元，</a>
						<br>
						<a>　　 超長運費加價15.1M~18M，毎米毎噸加價</a><input type="text" style="width:60px;" id="c5_1_5_b"/><a>元，不足一米以一米計。 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(6)</a>
						<a>板車承裝加工成型料整台運費每噸另加50元。 </a>
					</td>
				</tr>
				
				<tr>
					<td>
						<a>6.</a><a>付款條件：</a>
					</td>
				</tr>
				<tr>
					<td>
						<a style="float:left;">　(1)</a>
						<select id="c6_1" style="float:left;">
							<option value='預付'>預付</option>
							<option value='月結'>月結</option>
							<option value='電匯'>電匯</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="c6_1_a" style="float:left;">
							<a>預付</a><input type="text" style="width:40px;" id="c6_1_a_1"/><a>%貨款現金含稅為訂金，</a>
							<select id="c6_1_a_2">
								<option value='訂金抵尾款'>訂金抵尾款</option>
								<option value='訂金依出貨比例扣除'>訂金依出貨比例扣除</option>
							</select>
							<a>。每月出貨貨款為當月月結</a><input type="text" style="width:40px;" id="c6_1_a_3"/><a>天票期。</a>
							<br>
							<a>　　 例：7月帳，開立9月10日到期支票。</a>
							<br>
							<a>　　 交貨期限到需將未出鋼筋噸數的金額扣除訂金依 當期貨款支付現金完案。</a>
						</div>
						<div id="c6_1_b" style="float:left;">
							<a>每月出貨貨款為當月月結</a><input type="text" style="width:40px;" id="c6_1_b_1"/><a>天票期。例：7月帳，開立9月10日到期支票。</a>
							<br>
							<a>　　 交貨期限到需將未出鋼筋噸數的金額依當期貨款支付現金完案。</a>
						</div>
						<div id="c6_1_c" style="float:left;">
							<a>出貨前電匯貨款全額。</a><input type="text" style="width:150px;" id="c6_1_c_1"/>
						</div>
						<div id="c6_1_d" style="float:left;">
							<a></a><input type="text" style="width:150px;" id="c6_1_d_1"/>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(2)</a><a>甲方同意依照合約所定之付款日期及方式繳付價款予乙方，如逾期未付則按總價款</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 之日息萬分之六計算遲延付款之利息，乙方並得據以暫停出貨。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>7.</a><a>材料檢驗：</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　(1)</a><a>乙方鋼筋出廠毎批均附鋼筋無輻射證明，甲方需要檢驗報告時依CNS560規範執行。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　(2)</a><a>鋼筋未經送驗合格前，不得加工及使用，否則所衍費用由甲方自行吸收，且該批鋼筋不得辦理</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 退貨。</a>
					</td>
				</tr>
          		<tr>
					<td>
						<a>8.</a><a>特約事項：乙方所提供材料於甲方各期貨款支付或票據兌現前乙方仍保有所有權。</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<a>9.</a><a>本交易為附條件買賣，依動產交易法第三章之規定，在貨款未付清或票據未兌現之前，標的物之所有權歸屬本公司所有，買受人無異議，本公司無需經法律程序隨時取回本貨品或貨物清償。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>10.</a><a>本合約所立條文不得任意更改。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>11.</a><a>本合約如有爭議雙方願以高雄地方法院為第一管轄法院。</a>
					</td>
				</tr>
			</table>
		</div>
		
	</body>
	
	
		
</html>