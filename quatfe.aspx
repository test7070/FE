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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc = 1;
			q_tables = 't';
			var q_name = "quat";
			var decbbs = ['price', 'weight', 'mount', 'total', 'dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
			var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'totalus'];
			var decbbt = [];
			var q_readonly = ['txtNoa','txtWorker', 'txtComp', 'txtSales', 'txtWorker2','txtApv', 'txtMoney', 'txtTotal', 'txtWeight'];
			var q_readonlys = ['txtNo3'];
			var q_readonlyt = ['txtMemo','txtMemo2'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 11;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,paytype,trantype,tel,fax,zip_comp,addr_fact,salesno,sales', 'txtCustno,txtComp,txtNick,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr,txtSalesno,txtSales', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			);
			q_copy = 1;
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
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
				var t_unit, t_price, t_mount, t_weight, t_weights = 0, t_total, t_totals = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                	
                    t_unit = $.trim($('#txtUnit_' + j).val());
                    t_price = q_float('txtPrice_' + j);
                    t_mount = q_float('txtMount_' + j);
                    t_weight = q_float('txtWeight_' + j);
                    
                    t_weights = q_add(t_weights, t_weight);

                    if (t_unit == '公斤' || t_unit.toUpperCase() == 'KG' || t_unit.length == 0) {
                        t_total = round(q_mul(t_price, t_weight), 0);
                    } else {
                        t_total = round(q_mul(t_price, t_mount), 0);
                    }
                    t_totals = q_add(t_totals, t_total);
                    $('#txtTotal_' + j).val(t_total);
                }
                $('#txtMoney').val(t_totals);
                $('#txtWeight').val(t_weights);
				calTax();
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd], ['txtTimea', '99:99']];
				q_mask(bbmMask);
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1], ['txtFloata', 15, 3, 1]];
				bbsNum = [['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1],['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1], ['txtTotal', 15, 0, 1]];
				
				q_cmbParse("cmbTypea", '加工成型,板料');
				q_cmbParse("cmbStype", q_getPara('vcc.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");

				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				//判斷核准是否顯示
				if(q_getPara('sys.project').toUpperCase()=='XY'){
					$('.apv').show();
				}else{
					$('.apv').hide();
				}
				
				$('#cmbTaxtype').change(function(e){
					sum();
				}).click(function(e){
					if(q_cur==1 || q_cur==2)
						sum();
				});
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
				$('#c5_1').change(function(e){
					refreshData();
				});
				$('#b6_1_a_3').change(function(e){
					refreshData();
				});
				$('#b6_1_b_1').change(function(e){
					refreshData();
				});
				$('#c6_1_a_3').change(function(e){
					refreshData();
				});
				$('#c6_1_b_1').change(function(e){
					refreshData();
				});
				$('#b1_1_c').change(function(e){
					refreshData();
				});
				$('#c1_1_c').change(function(e){
					refreshData();
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			var focus_addr = '';
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
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
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
                     	try{
                     		t_para = JSON.parse(t_name);
                     		if(t_para.action == 'getWeight'){
                     			var as = _q_appendData('ucc', '', true);
                     			if (as[0] != undefined && parseFloat(as[0].uweight)!=0) {
                     				$('#txtWeight_'+t_para.n).val(round(parseFloat(as[0].uweight)*t_para.mount,3));
                     			}
                     			sum();
                     		}
                     	}catch(e){
                     	}
                     	break;
				}
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
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
						if(cobj.eq(i).hasClass('ignore')){
							;
						}else if(cobj.eq(i)[0].nodeName == 'BR'){
							string += '\n';
						}else if(!cobj.eq(i).is(":visible")){
							;
						}else if(cobj.eq(i).attr('id')=='b1_1_c'){
							;
						}else if(cobj.eq(i).attr('id')=='c1_1_c'){
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
					if(obj.eq(i).hasClass('ignore'))
						continue;
					string = getString(obj.eq(i));
					if(string.length>0)
						memo2 += (i==0?'':'\n') + string;
				}
				$('#txtMemo2').val(memo2);
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true');
					}
				}
				sum();
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
					
				//只要修改都會重新送簽核，將核准變回N
				if(q_getPara('sys.project').toUpperCase()=='XY'){
					$('#txtApv').val('N');
				}

				var s1 = $('#txtNoa').val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quat') + (!emp($('#txtDatea').val())?$('#txtDatea').val():q_date()), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('quat_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_'+i).text(i+1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_' + n).click();
                        });
                        $('#txtProduct_' + i).change(function(e){
                        	refreshData();
                        });
						$('#txtUnit_' + i).change(function(e){
                        	sum();
                        });
                        $('#txtPrice_' + i).change(function(e){
                        	sum();
                        });
                        $('#txtWeight_' + i).change(function(e){
                        	sum();
                        });
                        $('#txtMount_' + i).focusout(function() {
                            if (q_cur == 1 || q_cur == 2){
                            	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            	t_productno = $.trim($('#txtProductno_'+n).val());
			                    t_mount = q_float('txtMount_' + n);
			                    if(t_productno.length>0 && t_mount!=0){
			                    	q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0,JSON.stringify({action:"getWeight",n:n,mount:t_mount}));	
			                    }
                            }    
                        });
						$('#btnVccrecord_' + i).click(function() {
							t_IdSeq = -1;
							/// 要先給 才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
					}
				}
				_bbsAssign();
				refreshData();
			}

			function btnIns() {
				_btnIns();
				
				$('#chkIsproj').attr('checked', true);
				
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtDatea').val(q_cdn(q_date(), 3));
				
				if(q_getPara('sys.project').toUpperCase()=='XY'){
					$('#chkIsproj').attr('checked', false);
					$('#txtDatea').val(q_date().substr(0,3)+'/12/31');
				}
				
				$('#txtDatea').focus();

				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);

				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				loadData();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
					return;
				_btnModi();
				$('#txtProduct').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
				loadData();
			}

			function btnPrint() {
				q_box("z_quatfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val()),typea:trim($('#cmbTypea').val())}) + ";" + r_accy + "_" + r_cno, 'quat', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['datea'] = abbm2['datea'];
				as['odate'] = abbm2['odate'];
				as['custno'] = abbm2['custno'];
				as['apv'] = abbm2['apv'];
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
				
				$('.b1_1_c').hide();
				switch($('#b1_1_c').val()){
					case 'A':
						$('#b1_1_c_1').show();
						break;
					case 'B':
						$('#b1_1_c_2').show();
						break;
					case 'C':
						$('#b1_1_c_3').show();
						break;
					default:
						break;	
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
						case 'D':
							$('#b5_1_g').show();
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
						case 'D':
							$('#b5_1_g').show();
							break;
					}
				}
				/*$('#b2_1_a').hide();
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
				};*/
				
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
				
				$('.b6_1_a_3').hide();
				switch($('#b6_1_a_3').val()){
					case '月結30天票期':
						$('#b6_1_a_3a').show();
						break;
					case '月結45天票期':
						$('#b6_1_a_3b').show();
						break;
					case '月結60天票期':
						$('#b6_1_a_3c').show();
						break;
					case '月結現金':
						$('#b6_1_a_3d').show();
						break;
					default:
						break;
				}
				$('.b6_1_b_1').hide();
				switch($('#b6_1_b_1').val()){
					case '月結30天票期':
						$('#b6_1_b_1a').show();
						break;
					case '月結45天票期':
						$('#b6_1_b_1b').show();
						break;
					case '月結60天票期':
						$('#b6_1_b_1c').show();
						break;
					case '月結現金':
						$('#b6_1_b_1d').show();
						break;
					default:
						break;
				}
				
				$('#divBB').find('input[type="text"]').css('text-align','right');
				$('#b3_1').css('text-align','center');
				$('#b5_1_a_a').css('text-align','center');
				$('#b5_1_b_a').css('text-align','center');
				$('#b5_1_c_a').css('text-align','center');
				$('#b5_1_d_a').css('text-align','center');
				$('#b5_1_e_a').css('text-align','center');
				$('#b5_1_f_a').css('text-align','center');
				$('#b5_1_g_a').css('text-align','left');
				$('#b6_9_1').css('text-align','center');
			}
			function refreshDivCC(){
				$('#divCC').show();
				
				$('.c1_1_c').hide();
				switch($('#c1_1_c').val()){
					case 'A':
						$('#c1_1_c_1').show();
						break;
					case 'B':
						$('#c1_1_c_2').show();
						break;
					case 'C':
						$('#c1_1_c_3').show();
						break;
					default:
						break;	
				}
				
				$('.c5_1x').hide();
				if($('#c5_1').val()=='A' && $('#c1_1_a').val()=='含'){
					$('#c5_1_a').show();
				}else if($('#c5_1').val()=='A' && $('#c1_1_a').val()!='含'){
					$('#c5_1_b').show();
				}else {
					$('#c5_1_g').show();
				}
				
				/*$('#c2_1_a').hide();
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
				};*/
				
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
				$('.c6_1_a_3').hide();
				switch($('#c6_1_a_3').val()){
					case '月結30天票期':
						$('#c6_1_a_3a').show();
						break;
					case '月結45天票期':
						$('#c6_1_a_3b').show();
						break;
					case '月結60天票期':
						$('#c6_1_a_3c').show();
						break;
					case '月結現金':
						$('#c6_1_a_3d').show();
						break;
					default:
						break;
				}
				$('.c6_1_b_1').hide();
				switch($('#c6_1_b_1').val()){
					case '月結30天票期':
						$('#c6_1_b_1a').show();
						break;
					case '月結45天票期':
						$('#c6_1_b_1b').show();
						break;
					case '月結60天票期':
						$('#c6_1_b_1c').show();
						break;
					case '月結現金':
						$('#c6_1_b_1d').show();
						break;
					default:
						break;
				}
				$('#divCC').find('input[type="text"]').css('text-align','right');
				$('#c3_1').css('text-align','center');
				$('#c5_1_a_a').css('text-align','center');
				$('#c5_1_b_a').css('text-align','center');
				$('#c5_1_g_a').css('text-align','left');
				$('#c6_9_1').css('text-align','center');
			}
			function refreshData(){
				if($('#cmbTypea').val()=='加工成型'){
					$('#divCC').hide();
					$('#divBB').show();
					refreshDivBB();
				}else{
					$('#divBB').hide();
					$('#divCC').show();
					refreshDivCC();
				}
			}
			function refresh(recno) {
				_refresh(recno);
				loadData();
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

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
					$('#combPaytype').attr('disabled', 'disabled');
					
					$('#divBB').find('input,select').attr('disabled', 'disabled');
					$('#divCC').find('input,select').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
					$('#combPaytype').removeAttr('disabled');
					
					$('#divBB').find('input,select').removeAttr('disabled');
					$('#divCC').find('input,select').removeAttr('disabled');
				}
			}
			
			function btnMinus(id) {
				_btnMinus(id);
				sum();
				refreshData();
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
				if (q_chkClose())
					return;
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						refreshData();
						break;
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
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
                width: 350px; 
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
                width: 1000px;
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size:medium;
            }
            .dbbs {
                width: 1250px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
        </style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1500px;">
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
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
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
					<tr>
						<td> </td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtDatea" type="text" class="txt" style="float:left;width:45%;"/>
							<input id="txtTimea" type="text" class="txt" style="float:left;width:30%;"/>
							<input id="chkIsproj" type="checkbox"/><span> </span><a id='lblIsproj'> </a>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td><input id="txtContract" type="text" class="txt c1"/></td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td>
							<input id="txtComp" type="text" class="txt c1"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" class="txt" style="float:left;width:85%;"/>
							<select id="combPaytype" class="txt" style="float:left;width:10%;"> </select>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td><input id="txtSalesno" type="text" class="txt c1"/></td>
						<td><input id="txtSales" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel"	type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"></td>
						<td colspan='4' ><input id="txtAddr" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan="4">
							<input id="txtAddr2" type="text" class="txt" style="float:left;width:90%;"/>
							<select id="combAddr" style="float:left;width:5%;" onchange='combAddr_chg()'> </select>
						</td>
						<td><span> </span><a id='lblApv' class="lbl apv"> </a></td>
						<td><input id="txtApv" type="text" class="txt c1 apv" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/></td>
						<td><select id="cmbTaxtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
						<td>
							<span> </span>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus"	type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td>
							<span> </span>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">類型</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td align="right">
							<span> </span><a id='lblMemo' class="lbl"> </a>
						</td>
						<td colspan='6' >
							<textarea id="txtMemo" class="txt c1" rows="4"> </textarea>
						</td>
						<td>
							<input type="button" id="btnMemo" value="鋼筋報價" style="display:none;" />
						</td>
					</tr>
					<tr>
						<td align="right">
							<span> </span><a id='lblMemo3' class="lbl">未成交原因</a>
						</td>
						<td colspan='6' >
							<textarea id="txtMemo3" class="txt c1" rows="4"> </textarea>
						</td>
					</tr>
					<tr style="display:none;">
						<td align="right">
							<span> </span><a id='lblMemo2' class="lbl"> </a>
						</td>
						<td colspan='6' >
							<textarea id="txtMemo2" class="txt c1" rows="7"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;" /></td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:40px;"><a id='lblNo3_s'> </a></td>
					<td align="center" style="width:250px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:100px;"><a>規格</a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblCancels'> </a></td>
					<td align="center" style="width:40px;"><a id='lblVccrecord'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="txtNo3.*" type="text" class="txt" style="float:left;width:95%;"/></td>
					<td align="center">
						<input id="txtProductno.*" type="text" class="txt" style="float:left;width:95%;"/>
						<input id="txtProduct.*" type="text" class="txt" style="float:left;width:95%;"/>
						<input id="btnProduct.*" type="button" style="display:none;" />
					</td>
					<td><input id="txtSize.*" type="text" class="txt" style="float:left;width:95%;"/></td>
					<td><input id="txtUnit.*" type="text" class="txt" style="float:left;width:95%;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td><input id="txtTotal.*" type="text" class="txt num" style="float:left;width:95%;"/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt" style="float:left;width:95%;"/>
						<input id="txtOrdeno.*" type="text" class="txt" style="float:left;width:70%;" />
						<input id="txtNo2.*" type="text" class="txt" style="float:left;width:25%;" />
					</td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
					<td align="center">
						<input class="btn" id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id='divBB' style="font-family: '細明體';">
			<table style="">
				<tr style="color:white; background:#003366;" class="ignore">
					<td>品名</td>
					<td>規格</td>
					<td>單位</td>
					<td>數量</td>
					<td>單價</td>
					<td>備註</td>
				</tr>
				<tr class="ignore">
					<td>熱軋鋼筋SD280</td>
					<td>4#、5#</td>
					<td>噸</td>
					<td rowspan="3"><input type="text" style="width:60px;" id="b0_1_a" /></td>
					<td><input type="text" style="width:60px;" id="b0_2_a" /></td>
					<td>加工成型</td>
				</tr>
				<tr class="ignore">
					<td>熱軋鋼筋SD280W</td>
					<td>4#、5#</td>
					<td>噸</td>
					<td><input type="text" style="width:60px;" id="b0_2_b" /></td>
					<td>加工成型</td>
				</tr>
				<tr class="ignore">
					<td>熱軋鋼筋SD420W</td>
					<td>4#、5#、6#、7#、8#、10#</td>
					<td>噸</td>
					<td><input type="text" style="width:60px;" id="b0_2_c" /></td>
					<td>加工成型</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<a style="float:left;">1.(1)本報價單價不含5%稅金。</a>
						<select id="b1_1_a" style="float:left;"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a style="float:left;">運費、</a>
						<select id="b1_1_b" style="float:left;"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a style="float:left;">磅費、</a>
						<select id="b1_1_c" style="float:left;">
							<option value='A'>A</option>
							<option value='B'>B</option>
							<option value='C'>C</option>
						</select>
						<div id="b1_1_c_1" class="b1_1_c" style="float:left;"><a>不含檢驗費。</a></div>
						<div id="b1_1_c_2" class="b1_1_c" style="float:left;"><a>含物性檢驗費，不分爐號，每</a><input type="text" style="width:60px;" id="b1_1_c_2a" /><a>噸。檢驗<a><input type="text" style="width:60px;" id="b1_1_c_3b1" /></a>支，共</a><input type="text" style="width:60px;" id="b1_1_c_2b" /><a>支。</a></div>
						<div id="b1_1_c_3" class="b1_1_c" style="float:left;">
							<a>每</a><input type="text" style="width:60px;" id="b1_1_c_3a" /><a>噸檢驗?支，物性共</a><input type="text" style="width:60px;" id="b1_1_c_3c" /><a>支，化性共</a><input type="text" style="width:60px;" id="b1_1_c_3d" />
							<a>支，共</a><input type="text" style="width:60px;" id="b1_1_c_3b" /><a>支。</a>
						</div>
					</td>
				</tr>
				<tr class="b1_3"><td><a>　(2)馬架10CM以下、圓形、特殊框形、漸變尺寸及少量多樣尺寸加工不在此單價內。</a></td></tr>
				<!-- 依BBS  動態產生-->
		 		<tr class="b1_4">
		 			<td>
		 				<a>　</a><a>(3)</a><a>鋼筋3#每噸加價</a><input type="text" style="width:60px;" id="b1_4_a" /><a>元。</a>
		 				<a>鋼筋9#每噸加價</a><input type="text" style="width:60px;" id="b1_4_b" /><a>元。</a>
		 				<a>鋼筋11#每噸加價</a><input type="text" style="width:60px;" id="b1_4_c" /><a>元。</a>
		 			</td>
		 		</tr>
				
				<tr><td><a>　</a><a>(4)</a><a>本報價單不含至續接廠運輸費用。</a></td></tr>
				<tr><td><a>　</a><a>(5)</a><a>加工成型部份總料計價，整案承接：不分板料、彎料、直料含入續接柱筋。</a></td></tr>
				<tr><td><a>　</a><a>(6)</a><a>此單價不含裁切長度70CM以下直料及植筋用料。</a></td></tr>
				<tr><td><a>　</a><a>(7)</a><a>鋼筋加工成品包裝所需鋼筋與線材重量，納入鋼筋加工重量與工資計算。</a></td></tr>
				<tr><td><a>　</a><a>(8)</a><a>加工成型若分料包裝(台料)每噸加價600元。</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">2.</a><a style="float:left;">交貨地點：</a>
						<input style="float:left;" id="b2_1" list="b2_1a">
						<datalist id="b2_1a" class="ignore">
						  <option value='自訂'> </option>
						  <option value='廠交(自運)'> </option>
						</datalist>
						<a style="float:left;">。交貨期限：</a>
						<input type="text" style="width:40px;float:left;" id="b2_1_c"/>
						<a style="float:left;">年</a>
						<input type="text" style="width:40px;float:left;" id="b2_1_d"/>
						<a style="float:left;">月</a>
						<input type="text" style="width:40px;float:left;" id="b2_1_e"/>
						<a style="float:left;">日止。</a>
					</td>
				</tr>
				<tr><td><a>3.</a><a>工程名稱：</a><input type="text" style="width:200px;" id="b3_1"/><a>。</a></td></tr>
				<tr><td><a>4.</a><a>鋼筋計價重量：以賣方實際過磅為準，若磅差超出千分之三時買方得要求公證地磅會磅，千分之三內買方</a></td></tr>
				<tr><td><a>  </a><a>　　　　　　　　不得扣失重，若超出千分之三以上，雙方各半。</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">5.交貨辦法：</a>
						<select id="b5_1" style="float:left;">
							<option value='A'>A</option>
							<option value='B'>B</option>
							<option value='C'>C</option>
							<option value='D'>D</option>
						</select>
					</td>
				</tr>
				<!-- 含運  -->
				<tr id="b5_1_a" class="b5_1x">
					<td>
						<a>　</a><a>(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="b5_1_a_a"/>
						<a>，買方負責卸貨。每趟出貨須達30噸，未達30噸者需補貼運費至30噸，每噸</a>
						<input type="text" style="width:60px;" id="b5_1_a_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_b" class="b5_1x">
					<td>
						<a>　</a><a>(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_b_a"/>
						<a>，賣方負責卸貨，卸貨以1F地坪為限。每趟出貨須達20噸，未達20噸者需補</a><br>
                        <a>　 　</a><a>貼運費至20噸，每噸</a>
						<input type="text" style="width:60px;" id="b5_1_b_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_c" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_c_a"/>
						<a>限</a><input type="text" style="width:60px;" id="b5_1_c_b"/>
						<a>運輸以內，賣方負責卸貨以1F地坪為限。</a>
					</td>
				</tr>
				<!-- 不含運  -->
				<tr id="b5_1_d" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="b5_1_d_a"/>
						<a>，每噸</a><input type="text" style="width:60px;" id="b5_1_d_b"/>
						<a>元，買方負責卸貨。每趟出貨須達30噸，未達30噸者需補貼運費至30噸，每噸</a>
						<input type="text" style="width:60px;" id="b5_1_d_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="b5_1_e" class="b5_1x">
					<td>
						<a>　(1)</a>
						<a>吊車送達</a><input type="text" style="width:200px;" id="b5_1_e_a"/>
						<a>，每噸</a><input type="text" style="width:60px;" id="b5_1_e_b"/>
						<a>元，賣方負責卸貨，卸貨以1F地坪為限。每趟出貨須達20噸，未達20噸者需補貼運費至20噸，每噸</a>
						<input type="text" style="width:60px;" id="b5_1_e_c"/><a>元。</a>
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
				<tr id="b5_1_g" class="b5_1x"><td><a>　(1)</a><input type="text" style="width:500px;" id="b5_1_g_a" placeholder="自訂"/></td></tr>
				<tr>
					<td>
						<a>　</a><a>(2)</a>
						<a>鋼筋材料若為加工成型者，買方應於21日前通知賣方交貨數量規格。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(3)</a>
						<a>買方應備妥足夠容納進貨之場地，及35噸拖車可安全到達之卸貨場地，否則因而產生的其他費用由</a>
					</td>
				</tr>
				<tr><td><a>　　 買方負擔。 </a></td></tr>
				<tr>
					<td>
						<a>　</a><a>(4)</a>
						<a>板車料長度12M、14M。超長運費加價14.1M~15M，毎米毎噸加價 </a><input type="text" style="width:60px;" id="b5_1_5_a"/><a>元，超長運費加價15.1M~18M，</a><br>
						<a>　　  毎米毎噸加價</a><input type="text" style="width:60px;" id="b5_1_5_b"/><a>元，不足一米以一米計。 </a>
					</td>
				</tr>
				
				<tr><td><a>6.</a><a>付款條件：</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">　(1)</a>
						<select id="b6_1" style="float:left;" class="ignore">
							<option value='預付'>預付</option>
							<option value='月結'>月結</option>
							<option value='電匯'>電匯</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="b6_1_a" style="float:left;">
							<a>預付</a><input type="text" style="width:40px;" id="b6_1_a_1"/><a>%貨款現金</a><select id="b6_1_as" style="float:left;"><option value='含'>含</option><option value='不含'>不含</option></select><a>稅為定金，</a>
							<select id="b6_1_a_2">
								<option value='定金抵尾款'>定金抵尾款</option>
								<option value='定金依出貨比例扣除'>定金依出貨比例扣除</option>
							</select>
							<a>每月出貨貨款為當月</a>
							<select id="b6_1_a_3">
								<option value='月結30天票期'>月結30天票期</option>
								<option value='月結45天票期'>月結45天票期</option>
								<option value='月結60天票期'>月結60天票期</option>
								<option value='月結現金'>月結現金</option>
							</select>
							<a>。</a><br>
							<a id="b6_1_a_3a" class="b6_1_a_3">　　  例：7月帳，開立8月30日到期支票。</a>
							<a id="b6_1_a_3b" class="b6_1_a_3">　　  例：7月帳，開立9月15日到期支票。</a>
							<a id="b6_1_a_3c" class="b6_1_a_3">　　  例：7月帳，開立9月30日到期支票。</a>
							<a id="b6_1_a_3d" class="b6_1_a_3">　　  例：7月帳，開立8月10日前電匯現金。</a>
						</div>
						<div id="b6_1_b" style="float:left;">
							<a>每月出貨貨款為當月</a>
							<select id="b6_1_b_1">
								<option value='月結30天票期'>月結30天票期</option>
								<option value='月結45天票期'>月結45天票期</option>
								<option value='月結60天票期'>月結60天票期</option>
								<option value='月結現金'>月結現金</option>
							</select>
							<a id="b6_1_b_1a" class="b6_1_b_1">。例：7月帳，開立8月30日到期支票。</a>
							<a id="b6_1_b_1b" class="b6_1_b_1">。例：7月帳，開立9月15日到期支票。</a>
							<a id="b6_1_b_1c" class="b6_1_b_1">。例：7月帳，開立9月30日到期支票。</a>
							<a id="b6_1_b_1d" class="b6_1_b_1">。例：7月帳，開立8月10日前電匯現金。</a>
						</div>
						<div id="b6_1_c" style="float:left;">
							<a>出貨前電匯貨款全額。</a><input type="text" style="width:150px;" id="b6_1_c_1"/>
						</div>
						<div id="b6_1_d" style="float:left;"><a> </a><input type="text" style="width:150px;" id="b6_1_d_1"/></div>
					</td>
				</tr>
				<tr><td><a>　</a><a>(2)</a><a>交貨期限到需將未出鋼筋噸數的金額扣除訂金依當期貨款支付現金完案。</a></td></tr>
				<tr><td><a>　</a><a>(3)</a><a>買方同意依照合約所定之付款日期及方式繳付價款予賣方，如逾期未付則按總價款之日息萬分之六</a></td></tr>
				<tr><td><a>　　 計算遲延付款之利息，賣方並得據以暫停出貨。</a></td></tr>
				<tr><td><a>7.</a><a>材料檢驗：</a></td></tr>
				<tr><td><a>　(1)賣方鋼筋出廠毎批均附鋼筋無輻射證明，買方需要檢驗報告時依CNS560規範執行。</a></td></tr>
				<tr><td><a>　(2)鋼筋未經送驗合格前，不得加工及使用，否則所衍費用由買方自行吸收，且該批鋼筋不得辦理退貨。</a></td></tr>
				<tr><td>
                        <a>　(3)買賣雙方對交貨、加工、材質有所爭議時，雙方應先協調檢驗及驗收方式，如買方未經賣方同意而自</a><br>
						<a>　</a><a> 　行扣款，則賣方有 權終止合約。</a>
				</td></tr>
				<tr><td><a>　(4)</a><a>賣方加工之鋼筋各項尺寸公差為±5公分。</a></td></tr>
          		<tr>
					<td>
						<a>8.</a><a>(1)本合約之各項材料單價，不論市面價款之漲落，買賣雙方均不得提出增減價格及數量之要求。</a><br>
						<a>　</a><a>(2)賣方所提供材料於買方各期貨款支付或票據兌現前賣方仍保有所有權。</a><br>
						<a>　</a><a>(3)賣方加工完成後通知買方出貨，買方需接受賣方於7天內出貨完成。若買方未能7天內出貨，則補貼</a><br>
						<a>　</a><a> 　賣方成品放置面積廠租費及吊移費，以每平方公尺每日10元補貼賣方。</a>
					</td>
				</tr>
				<tr><td><a>9.</a><a>報價時效：本報價期限至</a><input type="text" style="width:200px;" id="b6_9_1"/><a>止為有效報價日。</a></td></tr>
				<tr><td><a>10.</a><a>本報價單蓋章回傳視同訂購。</a></td></tr>
			</table>
		</div>
		<!------以下板料------->
		<div id='divCC' style="font-family: '細明體';">
			<table style="">
				<tr style="color:white; background:#003366;" class="ignore">
					<td>品名</td>
					<td>規格</td>
					<td>單位</td>
					<td>數量</td>
					<td>單價</td>
					<td>備註</td>
				</tr>
				<tr class="ignore">
					<td>熱軋鋼筋SD280</td>
					<td>4#、5#</td>
					<td>噸</td>
					<td rowspan="3"><input type="text" style="width:60px;" id="c0_1_a" /></td>
					<td><input type="text" style="width:60px;" id="c0_2_a" /></td>
					<td>板車料，以件數出貨</td>
				</tr>
				<tr class="ignore">
					<td>熱軋鋼筋SD280W</td>
					<td>4#、5#</td>
					<td>噸</td>
					<td><input type="text" style="width:60px;" id="c0_2_b" /></td>
					<td>板車料，以件數出貨</td>
				</tr>
				<tr class="ignore">
					<td>熱軋鋼筋SD420W</td>
					<td>4#、5#、6#、7#、8#、10#</td>
					<td>噸</td>
					<td><input type="text" style="width:60px;" id="c0_2_c" /></td>
					<td>板車料，以件數出貨</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<a style="float:left;">1.(1)本報價單價不含5%稅金。</a>
						<select id="c1_1_a" style="float:left;"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a style="float:left;">運費、</a>
						<select id="c1_1_b" style="float:left;"><option value='含'>含</option><option value='不含'>不含</option></select>
						<a style="float:left;">磅費、</a>
						<select id="c1_1_c" style="float:left;">
							<option value='A'>A</option>
							<option value='B'>B</option>
							<option value='C'>C</option>
						</select>
						<div id="c1_1_c_1" class="c1_1_c" style="float:left;"><a>不含檢驗費。</a></div>
						<div id="c1_1_c_2" class="c1_1_c" style="float:left;"><a>含物性檢驗費，不分爐號，每</a><input type="text" style="width:60px;" id="c1_1_c_2a" /><a>噸。檢驗1支，共</a><input type="text" style="width:60px;" id="c1_1_c_2b" /><a>支。</a></div>
						<div id="c1_1_c_3" class="c1_1_c" style="float:left;">
							<a>每</a><input type="text" style="width:60px;" id="c1_1_c_3a" /><a>噸檢驗</a><input type="text" style="width:60px;" id="c1_1_c_3a1" /><a>支，物性共</a>
							<input type="text" style="width:60px;" id="c1_1_c_3b" /><a>支，</a>
							<a>支，化性共</a><input type="text" style="width:60px;" id="c1_1_c_3d" /><a>支，共</a><input type="text" style="width:60px;" id="c1_1_c_3c" /><a>支。</a>
						</div>
					</td>
				</tr>
				<tr><td><a>　(2)</a><a>定尺品每噸加價</a><input type="text" style="width:60px;" id="c1_2_a" /><a>元。定尺品長度最短2米，以0.1米為一單位，尺寸公差為±10公分。16米以上定尺</a></td></tr>
				<tr><td><a>　　 價格另議。板料不拆支。</a></td></tr>
				<tr class="c1_3"><td><a>　</a><a>(3)</a><a>定尺品每尺寸最少5噸，不足5噸依加工成型計價。</a></td></tr>
			 	<!-- 依BBS  動態產生-->
		 		<tr class="c1_4">
		 			<td>
		 				<a>　</a><a>(4)</a><a>鋼筋3#每噸加價</a><input type="text" style="width:60px;" id="c1_4_a" /><a>元。</a>
	 					<a>鋼筋9#每噸加價</a><input type="text" style="width:60px;" id="c1_4_b" /><a>元。</a>
	 					<a>鋼筋11#每噸加價</a><input type="text" style="width:60px;" id="c1_4_c" /><a>元。</a>
	 				</td>
 				</tr>
				
				<tr><td><a>　</a><a>(5)</a><a>本報價單不含至續接廠運輸費用。</a></td></tr>
				<tr><td><a>　</a><a>(6)</a><a>本報價單單價不含裁切植筋用料及漸變尺寸。</a></td></tr>
				<tr><td><a>　</a><a>(7)</a><a>包裝鋼筋成品所需之鋼筋與線材重量，納入重量計算。</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">2.</a><a style="float:left;">交貨地點：</a>
						<input style="float:left;" id="c2_1" list="c2_1a">
						<datalist id="c2_1a" class="ignore">
						  <option value='廠交(自運)'> </option>
                          <option value='自訂'>自訂</option>
						</datalist>
						<!--<select id="c2_1" style="float:left;">
							<option value='廠交(自運)'>廠交(自運)</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="c2_1_a" style="float:left;">
							<a>　</a>
						</div>
						<div id="c2_1_b" style="float:left;">
							<a>　</a><input type="text" style="width:120px;" id="c2_1_b_1"/>
						</div>-->
						<a style="float:left;">。交貨期限：</a>
						<input type="text" style="width:40px;float:left;" id="c2_1_c"/><a style="float:left;">年</a>
						<input type="text" style="width:40px;float:left;" id="c2_1_d"/><a style="float:left;">月</a>
						<input type="text" style="width:40px;float:left;" id="c2_1_e"/><a style="float:left;">日止。</a>
					</td>
				</tr>
				<tr><td><a>3.</a><a>工程名稱：</a><input type="text" style="width:200px;" id="c3_1"/><a>。</a></td></tr>
				<tr><td><a>4.</a><a>鋼筋計價重量：以賣方實際過磅為準，若磅差超出千分之三時買方得要求公證地磅會磅，千分之三內買方</a></td></tr>
				<tr><td><a>　不得扣失重，若超出千分之三以上，雙方各半。</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">5.交貨辦法：</a>
						<select id="c5_1" style="float:left;" class='ignore'>
							<option value='A'>預設</option>
							<option value='D'>自訂</option>
						</select>
					</td>
				</tr>
				<tr id="c5_1_a" class="c5_1x">
					<td>
						<a>　(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="c5_1_a_a"/><a>，</a>
						<select id="c5_1_a_b"><option value='買方'>買方</option><option value='賣方'>賣方</option></select>
						<a>負責卸貨。每趟出貨須達30噸，未達30噸者需補貼運費至30噸，每噸</a>
						<input type="text" style="width:60px;" id="c5_1_a_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="c5_1_b" class="c5_1x">
					<td>
						<a>　(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="c5_1_b_a"/><a>，每噸</a><input type="text" style="width:60px;" id="c5_1_b_b"/><a>元。</a>
						<a>買方負責卸貨。 出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="c5_1_b_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="c5_1_g" class="c5_1x">
					<td>
						<a>　(1)</a><input type="text" style="width:500px;" id="c5_1_g_a" placeholder="自訂"/>
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
						<a>買方應備妥足夠容納進貨之場地，及35噸拖車可安全到達之卸貨場地，否則因而產生的其他費用由買方</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 負擔。 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(4)</a>
						<a>板車料長度12M、14M。超長運費加價14.1M~15M，毎米毎噸加價 </a><input type="text" style="width:60px;" id="c5_1_5_a"/><a>元</a>
						<br>
						<a>　　 ，超長運費加價15.1M~18M，毎米毎噸加價</a><input type="text" style="width:60px;" id="c5_1_5_b"/><a>元，不足一米以一米計。 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(5)</a>
						<a>板車承裝加工成型料整台運費每噸另加50元。 </a>
					</td>
				</tr>
				
				<tr><td><a>6.</a><a>付款條件：</a></td></tr>
				<tr>
					<td>
						<a style="float:left;">　(1)</a>
						<select id="c6_1" style="float:left;" class="ignore">
							<option value='預付'>預付</option>
							<option value='月結'>月結</option>
							<option value='電匯'>電匯</option>
							<option value='自訂'>自訂</option>
						</select>
						<div id="c6_1_a" style="float:left;">
							<a>預付</a><input type="text" style="width:40px;" id="c6_1_a_1"/><a>%貨款現金</a><select id="c6_1_as" style="float:left;"><option value='含'>含</option><option value='不含'>不含</option></select><a>稅為訂金，</a>
							<select id="c6_1_a_2">
								<option value='訂金抵尾款'>定金抵尾款</option>
								<option value='訂金依出貨比例扣除'>定金依出貨比例扣除</option>
							</select>
							<a>每月出貨貨款為當月</a>
							<select id="c6_1_a_3">
								<option value='月結30天票期'>月結30天票期</option>
								<option value='月結45天票期'>月結45天票期</option>
								<option value='月結60天票期'>月結60天票期</option>
								<option value='月結現金'>月結現金</option>
							</select>
							<a>。</a>
							<br>
							<a id="c6_1_a_3a" class="c6_1_a_3">　 　例：7月帳，開立8月30日到期支票。</a>
							<a id="c6_1_a_3b" class="c6_1_a_3">　　 例：7月帳，開立9月15日到期支票。</a>
							<a id="c6_1_a_3c" class="c6_1_a_3">　　 例：7月帳，開立9月30日到期支票。</a>
							<a id="c6_1_a_3d" class="c6_1_a_3">　　 例：7月帳，開立8月10日前電匯現金。</a>
							<br>
							<a>　　 交貨期限到需將未出鋼筋噸數的金額扣除訂金依當期貨款支付現金完案。</a>
						</div>
						<div id="c6_1_b" style="float:left;">
							<a>每月出貨貨款為當月</a>
							<select id="c6_1_b_1">
								<option value='月結30天票期'>月結30天票期</option>
								<option value='月結45天票期'>月結45天票期</option>
								<option value='月結60天票期'>月結60天票期</option>
								<option value='月結現金'>月結現金</option>
							</select>
							<a id="c6_1_b_1a" class="c6_1_b_1">。例：7月帳，開立8月30日到期支票。</a>
							<a id="c6_1_b_1b" class="c6_1_b_1">。例：7月帳，開立9月15日到期支票。</a>
							<a id="c6_1_b_1c" class="c6_1_b_1">。例：7月帳，開立9月30日到期支票。</a>
							<a id="c6_1_b_1d" class="c6_1_b_1">。例：7月帳，開立8月10日前電匯現金。</a>
						</div>
						<div id="c6_1_c" style="float:left;">
							<a>出貨前電匯貨款全額。</a><input type="text" style="width:150px;" id="c6_1_c_1"/>
						</div>
						<div id="c6_1_d" style="float:left;"><a> </a><input type="text" style="width:150px;" id="c6_1_d_1"/></div>
					</td>
				</tr>
				<tr><td><a>　</a><a>(2)</a><a>交貨期限到需將未出鋼筋噸數的金額扣除訂金依當期貨款支付現金完案。</a></td></tr>
				<tr><td><a>　</a><a>(3)</a><a>買方同意依照合約所定之付款日期及方式繳付價款予賣方，如逾期未付則按總價款之日息萬分之六</a></td></tr>
				<tr><td><a>　　 計算遲延付款之利息，賣方並得據以暫停出貨。</a></td></tr>
				<tr><td><a>7.</a><a>材料檢驗：</a></td></tr>
				<tr><td><a>　(1)</a><a>賣方鋼筋出廠毎批均附鋼筋無輻射證明，買方需要檢驗報告時依CNS560規範執行。</a></td></tr>
				<tr><td><a>　(2)</a><a>鋼筋未經送驗合格前，不得加工及使用，否則所衍費用由買方自行吸收，且該批鋼筋不得辦理退貨。</a></td></tr>
				<tr><td><a>　(3)</a><a>買賣雙方對交貨、加工、材質有所爭議時，雙方應先協調檢驗及驗收方式，如買方未經賣方同意而自</a></td></tr>
				<tr><td><a>　   </a><a> 　行扣款，則賣方有權終止合約。</a></td></tr>
          		<tr>
					<td>
						<a>8.</a><a>(1)本合約之各項材料單價，不論市面價款之漲落，買賣雙方均不得提出增減價格及數量之要求。</a><br>
						<a>　</a><a>(2)賣方所提供材料於買方各期貨款支付或票據兌現前賣方仍保有所有權。</a><br>
						<a>　</a><a>(3)賣方加工完成後通知買方出貨，買方需接受賣方於7天內出貨完成。若買方未能7天內出貨，則補貼賣方</a><br>
						<a>　</a><a>　 成品放置面積廠租費及吊移費，以每平方公尺每日10元補貼賣方。</a>
					</td>
				</tr>
				<tr><td><a>9.</a><a>報價時效：本報價期限至</a><input type="text" style="width:200px;" id="c6_9_1"/><a>止為有效報價日。</a></td></tr>
				<tr><td><a>10.</a><a>本報價單蓋章回傳視同訂購。</a></td></tr>
			</table>
		</div>
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
	</body>
</html>
