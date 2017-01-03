<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">  
		protected void Page_Load(object sender, EventArgs e)
		{
		    jwcf wcf = new jwcf();
		
		    wcf.q_content("cust", " left( $r_userno,1)!='B' or ( salesno=$r_userno or $r_rank >= 8 )");
		    
		}
	</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			var q_name = "cust";
			var q_readonly = "";
			var bbmNum = [['txtCredit', 10, 0, 1],['txtProfit', 10, 2, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 25;
			//ajaxPath = ""; // execute in Root
			aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
				['txtGrpno', 'lblGrp', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx'],
				['txtCustno2', 'lblCustno2', 'cust', 'noa,comp', 'txtCustno2,txtCust2', 'cust_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				xmlTable = 'conn';
				xmlKey = [['noa', 'noq']];
				xmlDec = [];
				q_popSave(xmlTable);
				// for conn_b.aspx
				q_brwCount();
				//q_gt(q_name, '', q_sqlCount, 1);
				$('#txtNoa').focus();
				
				if (r_rank <8){
					q_gt('acomp', 'where=^^1=1^^', 0, 1);
				}else{
					q_content = "";
					q_gt(q_name, q_content, q_sqlCount, 1);
				}
			});
			function currentData() {
			}

			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : ['txtUacc1', 'txtUacc2', 'txtUacc3'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				if(q_getPara('sys.comp').substring(0,2)=="傑期"){
					$('.pk').show();
				}
				
				if (q_getPara('sys.project').toUpperCase()=='FE'){
					q_readonly = ['txtCredit','txtWorker', 'txtKdate', 'txtSales', 'txtGrpname', 'txtCust2'];
					$('#lblConn').css("display","");
					$('#txtConn').css("display","");
					$('#lblConn').text("接洽人");					
				}else{
					q_readonly = ['txtWorker', 'txtKdate', 'txtSales', 'txtGrpname', 'txtUacc1', 'txtUacc2', 'txtUacc3','txtCust2'];
				}
				
				bbmMask = [['txtChkdate', r_picd], ['txtDueday', '999'], ['txtStartdate', '99'],['txtGetdate', '99']];
				
				q_mask(bbmMask);
				q_gt('custtype', '', 0, 0, 0, "custtype");
				
				if (q_getPara('sys.comp').indexOf('裕承隆') > -1){
					aPop = new Array(
						['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
						['txtAddr_fact', '', 'view_road', 'memo,zipcode', '0txtAddr_fact,txtZip_fact', 'road_b.aspx'],
						['txtAddr_fact2', '', 'view_road', 'memo,zipcode', '0txtAddr_fact2,txtZip_fact2', 'road_b.aspx'],
						['txtAddr_comp', '', 'view_road', 'memo,zipcode', '0txtAddr_comp,txtZip_comp', 'road_b.aspx'],
						['txtAddr_invo', '', 'view_road', 'memo,zipcode', '0txtAddr_invo,txtZip_invo', 'road_b.aspx'],
						['txtAddr_home', '', 'view_road', 'memo,zipcode', '0txtAddr_home,txtZip_home', 'road_b.aspx'],
						['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
						['txtGrpno', 'lblGrp', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx']
					);
				}
				
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbStatus", q_getPara('cust.status'));

				//後面有需要的公司在顯示
				$('.btnUcam').hide();// 嘜頭
				if (q_getPara('sys.project').toUpperCase()=='GU'){
					$('.btnUcam').show();
				}
				$('#btnCustm').hide();//稅務資料
				
				$('#btnUcam').click(function() {
					t_where = "custno='" + $('#txtNoa').val() + "'";
					q_box("ucam_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucam', "95%", "95%", q_getMsg('btnUcam'));
				});
				
				$('#btnConn').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						//104/03/13用 typea 區分客戶(1)與廠商(2)
						t_where = "noa='" + $('#txtNoa').val() + "' and typea='1' ";
						q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
					}
				});
				
				$('#btnCustm').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						t_where = "noa='" + $('#txtNoa').val() + "'";
						q_box("custm_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custm', "600px", "700px", $('#btnCustm').val());
					}
				});
				
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0){
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						} else {
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
						}
					}
				});
				
				$('#txtUacc4').change(function() {
					var s1 = trim($(this).val());
					if (s1.length > 4 && s1.indexOf('.') < 0)
						$(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
					if (s1.length == 4)
						$(this).val(s1 + '.');

				});
				
				$('#btnUsecrd').click(function(){
					_usecrd_credit = 0;//由usecrd.aspx  覆寫資料
					var t_custno = $('#txtNoa').val();
					var t_where = " noa='"+t_custno+"'";
					q_box("usecrd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" +t_where, JSON.stringify({action:'usecrd',custno:t_custno}), "95%", "95%", q_getMsg('usecrd'));					
				});
				
				$('#btnUpcust').click(function(e){
					var t_custno = $('#txtNoa').val();
                    q_box("upcust.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" + t_custno + "';" + r_accy, 'rc2tfe', "95%", "95%", q_getMsg('popPrint'));
				});
				
				$('#btnCredit2zero').click(function(e){
					if (confirm("額度歸0，是否繼續!")) {
					    var t_noa = $('#txtNoa').val();	
						q_func('qtxt.query.credit2zero', 'cust.txt,credit2zero,'+ encodeURI(r_userno) + ';'+ encodeURI(t_noa));
					}
				});
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
					default:
						try{
							t_para = JSON.parse(b_pop);
							//資料由 usecrd.aspx更新
							if(t_para.action=='usecrd'){
								//$('#txtCredit').val(_usecrd_credit);
								//abbm[q_recno].credit = _usecrd_credit;
								/*console.log('boxclose usecrd');
								setTimeout(function(){
									q_gt('usecrd', "where=^^noa='"+t_para.custno+"'^^", 0, 0, 0, JSON.stringify({action:"usecrd",custno:t_para.custno}));	
								},1500);*/
							}else{
								
							}
						}catch(e){
							console.log(e.message);
						}
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'acomp':
						var as = _q_appendData("acomp", "", true);
						if (q_getPara('sys.project').toUpperCase()=='FE' && (r_userno.substr(0,1).toUpperCase())=='B'){
							q_content = "where=^^salesno='" + r_userno + "'^^";
							q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
		
						}else{
							q_content = "";
							q_gt(q_name, q_content, q_sqlCount, 1);
						}
						break;
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
					case 'checkCustno_change':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
						}
						break;
					case 'checkCustno_btnOk':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						try{
							t_para = JSON.parse(t_name);
							/*if(t_para.action=='usecrd'){
								var as = _q_appendData("usecrd", "", true);
								t_credit = 0;
								if(as[0] != undefined){
									for(var i=0;i<as.length;i++){
										try{
											if(parseFloat(as[i].credit)>0)
												console.log(as[i].credit);
											t_credit += round(parseFloat(as[i].credit),0);
										}catch(e){
											
										}
									}
								}
								
								$('#txtCredit').val(t_credit);
								abbm[q_recno].credit = t_credit;
								if(t_para.issave){
									Save();
								}
							}else{
								
							}*/
						}catch(e){
							console.log('gtpost:'+e.message);
						}
						break;
				} /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				
				$('#txtNoa').focus();
				refreshBbm();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
			}

			function btnPrint() {
				q_box("z_label.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";cust=" + $('#txtNoa').val() + ";" + r_accy, 'z_label', "95%", "95%", q_getMsg('popZ_label'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}
			
			function btnOk() {
				
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if (q_cur==1 && !((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val()))) {
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
					Unlock();
					return;
				}

				if ($('#txtStartdate').val() > '31') {
					alert(q_getMsg("lblStartdate") + '最大天數為31日');
					Unlock();
					return;
				}
				if ($('#txtGetdate').val() > '31') {
					alert(q_getMsg("lblGetdate") + '最大天數為31日');
					Unlock();
					return;
				}

				if (dec($('#txtCredit').val()) > 9999999999)
					t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

				if (dec($('#txtGetdate').val()) > 31)
					t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r';
					
				if($('#txtNick').val() == ''){
					$('#txtNick').val($('#txtComp').val().substr(0,2));
				}	
					
				if(q_cur==1)
					$('#txtKdate').val(q_date());
					
				$('#txtWorker').val(r_name);
				
				Save();
			}
			function Save(){
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
				} else {
					wrServer($('#txtNoa').val());
				}
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
				refreshBbm();
				
				if (q_getPara('sys.project').toUpperCase()=='FE'){
					$('.isFE').show();
					$('.isFEA').hide();
				}else{
					$('.isFE').hide();
				}
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				refreshBbm();
				if(t_para){
					$('#btnConn').removeAttr('disabled');
					$('#btnCustm').removeAttr('disabled');
					
					$('#btnUpcust').removeAttr('disabled');
					$('#btnCredit2zero').removeAttr('disabled');
				}else{
					$('#btnConn').attr('disabled', 'disabled');
					$('#btnCustm').attr('disabled', 'disabled');
					
					$('#btnUpcust').attr('disabled', 'disabled');
					$('#btnCredit2zero').attr('disabled', 'disabled');
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

			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.credit2zero':
                		var t_noa = $('#txtNoa').val();
                		var as = _q_appendData("tmp0", "", true, true);                     
                        if(as[0]!=undefined){
	                        	if(as[0].success == 0){
	                        		alert(as[0].msg);
	                        	}else{
	                				$('#txtCredit').val(0);
                        			for(var i=0;i<abbm.length;i++){
                        				if(abbm[i].noa==t_noa){
                        					abbm[i].credit = "0";
                        					break;
                        				}
                        			}
                        			alert(as[0].msg);
	                        	}
	                        } 
                		break;
                	default:
                		break;
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 38%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.tview tr {
				height: 26px;
			}
			.dbbm {
				float: left;
				width: 60%;
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
			.tbbm select {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c6 {
				width: 49%;
				float: left;
			}
			.txt.c7 {
				width: 99%;
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
			input[type="text"], input[type="button"] {
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
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; width:25%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick' class='it'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/></td>
						<td>
							<div style="float:left;">
								<input id="Copy" type="checkbox" />
								<span> </span><a id="lblCopy"> </a>
							</div>
							<span> </span>
							<a id='lblWorker' class="lbl"> </a>
						</td>
						<td>
							<input id="txtKdate" type="text" class="txt c6"/>
							<input id="txtWorker" type="text" class="txt c6"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan='3'><input id="txtComp" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtBoss" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblHead' class="lbl"> </a></td>
						<td><input id="txtHead" type="text" class="txt c1"/></td>
						<td>
							<input id="btnConn" type="button" />
							<input id="btnCustm" type="button" />
						</td>
						<td><input id="btnUpcust" type="button" value="圖片、附件上傳"/></td>					
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><select id="cmbStatus" class="txt c1"> </select></td>
						<td><span> </span><a id='lblProfit' class="lbl isFE"> </a></td>
						<td><input id="txtProfit" type="text" class="txt c1 num isFE"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblGrp" class="lbl btn"> </a></td>
						<td>
							<input id="txtGrpno" type="text" style="float:left; width:40%;"/>
							<input id="txtGrpname" type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id='lblTeam' class="lbl"> </a></td>
						<td><input id="txtTeam" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a id='lblTeampaytype' class="lbl"> </a></td>
						<td><input id="txtTeampaytype" type="text" class="txt c1"/></td>-->
						<td><span> </span><a id='lblConn' class="lbl" style="display: none;"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1" style="display: none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input id="txtMobile" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvoicetitle' class="lbl"> </a></td>
						<td colspan='3'><input id="txtInvoicetitle" type="text" class="txt c7"/></td>
						<td><input id="btnUcam" type="button" style="float: right;" class="btnUcam" style="display: none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_comp' class="lbl"> </a></td>
						<td><input id="txtZip_comp" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_comp" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_fact' class="lbl"> </a></td>
						<td><input id="txtZip_fact" type="text" class="txt c1"></td>
						<td colspan='4'><input id="txtAddr_fact" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_fact2' class="lbl"> </a></td>
						<td><input id="txtZip_fact2" type="text" class="txt c1"></td>
						<td colspan='4'><input id="txtAddr_fact2" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
						<td><input id="txtZip_invo" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_invo" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td><input id="txtZip_home" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_home" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td colspan='5'><input id="txtEmail" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeb' class="lbl"> </a></td>
						<td colspan='5'><input id="txtWeb" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCredit" class="lbl" > </a></td>
						<td><input id="txtCredit" type="text" class="txt c1 num"/></td>
						<td class="isFE" colspan="2">
							<input id="btnUsecrd" type="button" style="float:left;width:120px;"/>
							<span style="float:left;width:20px; display:block;"> </span>
							<input id="btnCredit2zero" type="button" style="float:left;width:120px;" value="額度歸0"/>
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td>
							<input id="txtSalesno" type="text" class="txt c6"/>
							<input id="txtSales" type="text" class="txt c6"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkstatus' class="lbl"> </a></td>
						<td colspan='3'><input id="txtChkstatus" type="text" class="txt c7" /></td>
						<td><span> </span><a id='lblUacc4' class="lbl"> </a></td>
						<td><input id="txtUacc4" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkdate' class="lbl"> </a></td>
						<td><input id="txtChkdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblUacc1' class="lbl isFEA"> </a></td>
						<td><input id="txtUacc1" type="text" class="txt c1 isFEA"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDueday' class="lbl"> </a></td>
						<td><input id="txtDueday" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblGetdate' class="lbl"> </a></td>
						<td><input id="txtGetdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUacc2' class="lbl isFEA"> </a></td>
						<td><input id="txtUacc2" type="text" class="txt c1 isFEA"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td>
							<input id="txtPaytype" type="text" class="txt c6"/>
							<select id="combPaytype" class="txt c6" onchange='combPaytype_chg()'> </select>
						</td>
						<td><span> </span><a id='lblUacc3' class="lbl isFEA"> </a></td>
						<td><input id="txtUacc3" type="text" class="txt c1 isFEA"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea></td>
					</tr>
					<tr class="pk" style="display:none;">
						<td><span> </span><a class="lbl">訂單備註</a></td>
						<td colspan='5'>
							<textarea id="txtMemo2" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>