﻿<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">  
		protected void Page_Load(object sender, EventArgs e)
		{
		    jwcf wcf = new jwcf();
		
		    wcf.q_content("orde", " left( $r_userno,1)!='B' or ( salesno=$r_userno or $r_rank >= 8 )");
		    
		}
	</script>
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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_desc = 1;
			q_tables = 's';
			var q_name = "orde";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtSales', 'txtOrdbno', 'txtOrdcno', 'txtWeight'];
			var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtC1', 'txtNotv'];
			var bbmNum = [['txtTotal', 10, 0, 1],['txtWeight', 10, 2, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],['txtFloata', 10, 5, 1], ['txtTotalus', 15, 2, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'odate';
			brwCount2 = 12;
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucc_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtAddr', '', 'view_road', 'memo,zipcode', '0txtAddr,txtPost', 'road_b.aspx'],
                ['txtAddr2', '', 'view_road', 'memo,zipcode', '0txtAddr2,txtPost2', 'road_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_fact,salesno,sales', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr,txtSalesno,txtSales', 'cust_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				$('#txtOdate').focus();
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0,t_total;
				for (var j = 0; j < q_bbsCount; j++) {
					t_unit = $.trim($('#txtUnit_' + j).val().toUpperCase());
					$('#txtUnit_' + j).val(t_unit);
					t_mount = q_float('txtMount_'+j);
					t_weight = q_float('txtWeight_'+j);
					t_price = q_float('txtPrice_'+j);
					t_total = round(q_mul((t_unit.length==0 || t_unit=='KG' || t_unit=='公斤'?t_weight:t_mount),t_price),0);
					// 計價量
					$('#txtTotal_' + j).val(t_total);

					q_tr('txtNotv_' + j, q_sub(q_float('txtMount_' + j), q_float('txtC1' + j)));
					t1 = q_add(t1, t_total);
				}
				$('#txtMoney').val(round(t1, 0));
				if (!emp($('#txtPrice').val()))
					$('#txtTranmoney').val(round(q_mul(t_weight, dec($('#txtPrice').val())), 0));
				// $('#txtWeight').val(round(t_weight, 0));
				q_tr('txtTotal', q_add(t1, dec($('#txtTax').val())));
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));
				calTax();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtOdate', r_picd],['txtDatea', r_picd],['txtGdate', r_picd]];
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
				//鉅昕  小數位到4位      2017/06/05
				bbsNum = [['txtPrice', 12, 3, 1],['txtWeight', 12, 4, 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 10, 0, 1],['txtC1', 10, q_getPara('vcc.mountPrecision'), 1], ['txtNotv', 10, q_getPara('vcc.mountPrecision'), 1]];
				
				$('.tr9').hide();
				
				q_cmbParse("cmbStype", q_getPara('orde.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('fe.trantype'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

				var t_where = "where=^^ 1=1 ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");

				$('#btnOrdei').click(function() {
					if (q_cur != 1 && $('#cmbStype').find("option:selected").text() == '外銷')
						q_box("ordei.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('popOrdei'));
				});
				$('#btnQuat').click(function() {
					btnQuat();
				});
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

				$('#btnCredit').click(function() {
					if(!emp($('#txtCustno').val())){
                        q_box("z_creditfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({custno:trim($('#txtCustno').val())}) + ";" + r_accy + "_" + r_cno, 'orde', "95%", "95%", m_print);
                    }
				});
				////-----------------以下為addr2控制事件---------------
				$('#btnAddr2').mousedown(function(e) {
					var t_post2 = $('#txtPost2').val().split(';');
					var t_addr2 = $('#txtAddr2').val().split(';');
					var maxline=0;//判斷最多有幾組地址
					t_post2.length>t_addr2.length?maxline=t_post2.length:maxline=t_addr2.length;
					maxline==0?maxline=1:maxline=maxline;
					var rowslength=document.getElementById("table_addr2").rows.length-1;
					for (var j = 1; j < rowslength; j++) {
						document.getElementById("table_addr2").deleteRow(1);
					}
					
					for (var i = 0; i < maxline; i++) {
						var tr = document.createElement("tr");
						tr.id = "bbs_"+i;
						tr.innerHTML = "<td id='addr2_tdBtn2_"+i+"'><input class='btn addr2' id='btnAddr_minus_"+i+"' type='button' value='-' style='width: 30px' onClick=minus_addr2("+i+") /></td>";
						tr.innerHTML+= "<td id='addr2_tdPost2_"+i+"'><input id='addr2_txtPost2_"+i+"' type='text' class='txt addr2' value='"+t_post2[i]+"' style='width: 70px'/></td>";
						tr.innerHTML+="<td id='addr2_tdAddr2_"+i+"'><input id='addr2_txtAddr2_"+i+"' type='text' class='txt c1 addr2' value='"+t_addr2[i]+"' /></td>";
						var tmp = document.getElementById("addr2_close");
						tmp.parentNode.insertBefore(tr,tmp);
					}
					readonly_addr2();
					$('#div_addr2').show();
				});
				
				$('#btnAddr_plus').click(function() {
					var rowslength=document.getElementById("table_addr2").rows.length-2;
					var tr = document.createElement("tr");
						tr.id = "bbs_"+rowslength;
						tr.innerHTML = "<td id='addr2_tdBtn2_"+rowslength+"'><input class='btn addr2' id='btnAddr_minus_"+rowslength+"' type='button' value='-' style='width: 30px' onClick=minus_addr2("+rowslength+") /></td>";
						tr.innerHTML+= "<td id='addr2_tdPost2_"+rowslength+"'><input id='addr2_txtPost2_"+rowslength+"' type='text' class='txt addr2' value='' style='width: 70px' /></td>";
						tr.innerHTML+="<td id='addr2_tdAddr2_"+rowslength+"'><input id='addr2_txtAddr2_"+rowslength+"' type='text' class='txt c1 addr2' value='' /></td>";
						var tmp = document.getElementById("addr2_close");
						tmp.parentNode.insertBefore(tr,tmp);
				});
				
				$('#btnClose_div_addr2').click(function() {
					if(q_cur==1||q_cur==2){
						var rows=document.getElementById("table_addr2").rows.length-3;
						var t_post2 = '';
						var t_addr2 = '';
						for (var i = 0; i <= rows; i++) {
							if(!emp($('#addr2_txtPost2_'+i).val())||!emp($('#addr2_txtAddr2_'+i).val())){
								t_post2 += $('#addr2_txtPost2_'+i).val()+';';
								t_addr2 += $('#addr2_txtAddr2_'+i).val()+';';
							}
						}
						$('#txtPost2').val(t_post2.substr(0,t_post2.length-1));
						$('#txtAddr2').val(t_addr2.substr(0,t_addr2.length-1));
					}
					$('#div_addr2').hide();
				});
				
				$('#btnOrdem').click(function() {
					q_box("ordemfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordem', "95%", "95%", q_getMsg('popOrdem'));
				});
				
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
                $('#btnClose_div_stk').click(function() {
                    $('#div_stk').toggle();
                });
			}
			
			//addr2控制事件vvvvvv-------------------
			function minus_addr2(seq) {	
				$('#addr2_txtPost2_'+seq).val('');
				$('#addr2_txtAddr2_'+seq).val('');
			}
			
			function readonly_addr2() {
				if(q_cur==1||q_cur==2){
					$('.addr2').removeAttr('disabled');
				}else{
					$('.addr2').attr('disabled', 'disabled');
				}
			}
			
			//addr2控制事件^^^^^^--------------------

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'quats':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							//取得報價的第一筆匯率等資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('quat', t_where, 0, 0, 0, "", r_accy);

							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtPrice,txtMount,txtQuatno,txtNo3', b_ret.length, b_ret, 'productno,product,spec,unit,price,mount,noa,no3', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							sum();
							bbsAssign();
						}
						break;

					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function browTicketForm(obj) {
				//資料欄位名稱不可有'_'否則會有問題
				if (($(obj).attr('readonly') == 'readonly') || ($(obj).attr('id').substring(0, 3) == 'lbl')) {
					if ($(obj).attr('id').substring(0, 3) == 'lbl')
						obj = $('#txt' + $(obj).attr('id').substring(3));
					var noa = $.trim($(obj).val());
					var openName = $(obj).attr('id').split('_')[0].substring(3).toLowerCase();
					if (noa.length > 0) {
						switch (openName) {
							case 'ordbno':
								q_box("ordb.aspx?;;;noa='" + noa + "';" + r_accy, 'ordb', "95%", "95%", q_getMsg("popOrdb"));
								break;
							case 'ordcno':
								q_box("ordc.aspx?;;;noa='" + noa + "';" + r_accy, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
								break;
							/*case 'quatno':
								改在bbsAssign
								q_box("quat.aspx?;;;noa='" + noa + "';" + r_accy, 'quat', "95%", "95%", q_getMsg("popQuat"));
								break;*/
						}
					}
				}
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
					case 'msg_ucc':
						var as = _q_appendData("ucc", "", true);
						t_msg = '';
						if (as[0] != undefined) {
							t_msg = "銷售單價：" + dec(as[0].saleprice) + "<BR>";
						}
						//客戶售價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and datea<'" + q_date() + "' ^^ stop=1";
						q_gt('quat', t_where, 0, 0, 0, "msg_quat", r_accy);
						break;
					case 'msg_quat':
						var as = _q_appendData("quats", "", true);
						var quat_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									quat_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近報價單價：" + quat_price + "<BR>";
						//最新出貨單價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and noa in (select noa from vccs" + r_accy + " where productno='" + $('#txtProductno_' + b_seq).val() + "' and price>0 ) ^^ stop=1";
						q_gt('vcc', t_where, 0, 0, 0, "msg_vcc", r_accy);
						break;
					case 'msg_vcc':
						var as = _q_appendData("vccs", "", true);
						var vcc_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									vcc_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近出貨單價：" + vcc_price;
						q_msg($('#txtPrice_' + b_seq), t_msg);
						break;
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = q_add(stkmount, dec(as[i].mount));
						}
						t_msg = "庫存量：" + stkmount;
						//平均成本
						var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by datea desc ^^ stop=1";
						q_gt('wcost', t_where, 0, 0, 0, "msg_wcost", r_accy);
						break;
					case 'msg_wcost':
						var as = _q_appendData("wcost", "", true);
						var wcost_price;
						if (as[0] != undefined) {
							if (dec(as[0].mount) == 0) {
								wcost_price = 0;
							} else {
								wcost_price = round(q_div(q_add(q_add(q_add(dec(as[0].costa), dec(as[0].costb)), dec(as[0].costc)), dec(as[0].costd)), dec(as[0].mount)), 0)
								//wcost_price=round((dec(as[0].costa)+dec(as[0].costb)+dec(as[0].costc)+dec(as[0].costd))/dec(as[0].mount),0);
							}
						}
						if (wcost_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + wcost_price;
							q_msg($('#txtMount_' + b_seq), t_msg);
						} else {
							//原料成本
							var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by mon desc ^^ stop=1";
							q_gt('costs', t_where, 0, 0, 0, "msg_costs", r_accy);
						}
						break;
					case 'msg_costs':
						var as = _q_appendData("costs", "", true);
						var costs_price;
						if (as[0] != undefined) {
							costs_price = as[0].price;
						}
						if (costs_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + costs_price;
						}
						q_msg($('#txtMount_' + b_seq), t_msg);
						break;
					 case 'msg_stk_all':
                        var as = _q_appendData("stkucc", "", true);
                        var rowslength = document.getElementById("table_stk").rows.length - 3;
                        for (var j = 1; j < rowslength; j++) {
                            document.getElementById("table_stk").deleteRow(3);
                        }
                        var stk_row = 0;

                        var stkmount = 0;
                        for (var i = 0; i < as.length; i++) {
                            //倉庫庫存
                            if (dec(as[i].mount) != 0) {
                                var tr = document.createElement("tr");
                                tr.id = "bbs_" + j;
                                tr.innerHTML = "<td id='assm_tdStoreno_" + stk_row + "'><input id='assm_txtStoreno_" + stk_row + "' type='text' class='txt c1' value='" + as[i].storeno + "' disabled='disabled'/></td>";
                                tr.innerHTML += "<td id='assm_tdStore_" + stk_row + "'><input id='assm_txtStore_" + stk_row + "' type='text' class='txt c1' value='" + as[i].store + "' disabled='disabled' /></td>";
                                tr.innerHTML += "<td id='assm_tdMount_" + stk_row + "'><input id='assm_txtMount_" + stk_row + "' type='text' class='txt c1 num' value='" + as[i].mount + "' disabled='disabled'/></td>";
                                var tmp = document.getElementById("stk_close");
                                tmp.parentNode.insertBefore(tr, tmp);
                                stk_row++;
                            }
                            //庫存總計
                            stkmount = stkmount + dec(as[i].mount);
                        }
                        var tr = document.createElement("tr");
                        tr.id = "bbs_" + j;
                        tr.innerHTML = "<td colspan='2' id='stk_tdStore_" + stk_row + "' style='text-align: right;'><span id='stk_txtStore_" + stk_row + "' class='txt c1' >倉庫總計：</span></td>";
                        tr.innerHTML += "<td id='stk_tdMount_" + stk_row + "'><span id='stk_txtMount_" + stk_row + "' type='text' class='txt c1 num' > " + stkmount + "</span></td>";
                        var tmp = document.getElementById("stk_close");
                        tmp.parentNode.insertBefore(tr, tmp);
                        stk_row++;

                        $('#div_stk').css('top', mouse_point.pageY - parseInt($('#div_stk').css('height')));
                        $('#div_stk').css('left', mouse_point.pageX - parseInt($('#div_stk').css('width')));
                        $('#div_stk').toggle();
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
					case 'quat':
						var as = _q_appendData("quat", "", true);
						if (as[0] != undefined) {
							$('#txtFloata').val(as[0].floata);
							$('#cmbCoin').val(as[0].coin);
							$('#txtPaytype').val(as[0].paytype);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							$('#txtContract').val(as[0].contract);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#txtPost').val(as[0].post);
							$('#txtAddr').val(as[0].addr);
							$('#txtPost2').val(as[0].post2);
							$('#txtAddr2').val(as[0].addr2);
							$('#cmbTaxtype').val(as[0].taxtype);
							sum();
						}
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
                     		}else if(t_para.action == 'getWeight_sum'){
                     			var as = _q_appendData('ucc', '', true);
                     			if (as[0] != undefined && parseFloat(as[0].uweight)!=0) {
                     				$('#txtWeight_'+t_para.n).val(round(parseFloat(as[0].uweight)*t_para.mount,3));
                     			}
                     			btnOk_sum(t_para.n)
                     		}
                     	}catch(e){
                     	}
                     	break;
				}
			}

			function btnQuat() {
				var t_custno = trim($('#txtCustno').val());
				var t_where = '';
				if (t_custno.length > 0) {
					//t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : ""); //// sql AND 語法，請用 &&
					t_where = "noa+'_'+no3 not in (select isnull(quatno,'')+'_'+isnull(no3,'') from view_ordes" + r_accy + " where noa!='" + $('#txtNoa').val() + "' )"
					t_where = t_where + ' and ' + q_sqlPara("custno", t_custno);
				}
				else {
					alert(q_getMsg('msgCustEmp'));
					return;
				}
				q_box("quat_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'quats', "95%", "95%", q_getMsg('popQuats'));
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				for(var k=0;k<q_bbsCount;k++){
					if($('#txtDatea_'+k).val().length==0)
						$('#txtDatea_'+k).val($('#txtDatea').val());
				}
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true');
					}
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				if($('#txtCustno').val().length==0){
                    alert('請輸入'+q_getMsg('lblCust'));
                    Unlock(1);
                    return;
                }
                btnOk_sum(q_bbsCount);
			}
			function btnOk_sum(n){
            	if(n==0){
            		sum();
            		var t_weight=0;
            		for(var i=0;i<q_bbsCount;i++){
            			t_weight+=q_float('txtWeight_'+i);
            		}
            		$('#txtWeight').val(t_weight);
            		q_func('qtxt.query.credit', 'credit.txt,fe,'+ encodeURI($('#txtCustno').val()) + ';' + encodeURI($('#txtNoa').val()));
            	}else{
            		n--;
            		t_productno = $.trim($('#txtProductno_'+n).val());
                    t_mount = q_float('txtMount_' + n);
                    //2016/01/11 只有在修改數量當下才重新計算重量,存檔時不必
                    //if(t_productno.length>0 && t_mount!=0){
                    //	q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0,JSON.stringify({action:"getWeight_sum",n:n,mount:t_mount}));	
                    //}else{
                    	btnOk_sum(n);
                    //}
            	}           		
            }
			function save(){
				//檢查單價
				var t_noa = $('#txtNoa').val();
				var t_ontract = $('#txtContract').val();
				var t_data ='';
				for(var i=0;i<q_bbsCount;i++){
					if($.trim($('#txtProductno_'+i).val().length>0)){
						t_data += (t_data.length>0?'$':'')+i+'@'+ $('#txtProductno_'+i).val()+'@'+q_float('txtPrice_'+i)+'@'+$('#txtOdate').val();
					}
				}
				q_func('qtxt.query.uccp_price', 'uccp.txt,uccp_price,'+t_noa+';'+t_ontract+';'+t_data); 
            }
            function save2(){
            	var s1 = $('#txtNoa').val();
                if (s1.length == 0 || s1 == "AUTO")/// 自動產生編號
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.uccp_price':
                		var as = _q_appendData("tmp0", "", true, true);
                        if(as[0]!=undefined){
                        	var msg = '';
                        	try{
                        		for(var i=0;i<as.length;i++){
                        			if(parseFloat(as[i].contprice)>0){
                        				//合約
                        				if(parseFloat(as[i].price)!=parseFloat(as[i].contprice)){
                        					msg += (msg.length>0?'\n':'') + as[i].productno +'  '+as[i].price+ ' 單價須等於合約單價 '+as[i].contprice;
                        					$('#txtPrice_'+as[i].n).val(parseFloat(as[i].contprice));
                        				}
                        			}else{
                        				//基價
                        				if(parseFloat(as[i].price)<parseFloat(as[i].uccpprice)){
		                        			msg += (msg.length>0?'\n':'') + as[i].productno +'  '+as[i].price+ ' 單價不可小於基價 '+as[i].uccpprice;
		                        			$('#txtPrice_'+as[i].n).val(q_mul(parseFloat(as[i].uccpprice),2));
		                        		}
                        			}
	                        	}
	                        	if(msg.length>0){
	                        		sum();
	                        		alert(msg+'\n自動調整成為"合約單價"或"2倍基價"!');
	                        	}
	                        	save2();
                        	}catch(e){
                        		alert('Error_01');
                        	}
                        }else{
                        	alert('無資料!');
                        }
                		break;
                    case 'qtxt.query.conform':
                        var as = _q_appendData("tmp0", "", true, true);
                        if(as[0]!=undefined){
                            var err = as[0].err;
                            var msg = as[0].msg;
                            var ordeno = as[0].ordeno;  
                            var userno = as[0].userno;  
                            var namea = '*';//as[0].namea;
                            if(err=='1'){
                                $('#txtConform').val(namea);
                                for(var i=0;i<abbm.length;i++){
                                    if(abbm[i].noa==ordeno){
                                        abbm[i].conform=namea;
                                        break;
                                    }
                                }
                                var obj = $('#tview').find('#noa');
                                for(var i=0;i<obj.length;i++){
                                    if(obj.eq(i).html()==ordeno){
                                        $('#tview').find('#conform').eq(i).html(namea);
                                        break;                                      
                                    }
                                }
                            }else{
                                alert(msg); 
                            }
                        }
                        Unlock(1);
                        break;
                    case 'qtxt.query.apv':
                        var as = _q_appendData("tmp0", "", true, true);
                        if(as[0]!=undefined){
                            var err = as[0].err;
                            var msg = as[0].msg;
                            var ordeno = as[0].ordeno;  
                            var userno = as[0].userno;  
                            var namea = as[0].namea;
                            if(err=='1'){
                                $('#txtApv').val(namea);
                                for(var i=0;i<abbm.length;i++){
                                    if(abbm[i].noa==ordeno){
                                        abbm[i].apv=namea;
                                        break;
                                    }
                                }
                                var obj = $('#tview').find('#noa');
                                for(var i=0;i<obj.length;i++){
                                    if(obj.eq(i).html()==ordeno){
                                        $('#tview').find('#apv').eq(i).html(namea);
                                        break;                                      
                                    }
                                }
                            }else{
                                alert(msg); 
                            }
                        }
                        Unlock(1);
                        break;
                    case 'qtxt.query.credit':
                        var as = _q_appendData("tmp0", "", true, true);                     
                        if(as[0]!=undefined){
                            var credit = parseFloat(as[0].credit.length==0?"0":as[0].credit);
                            var orde = parseFloat(as[0].orde.length==0?"0":as[0].orde);
						 	var ordetax = parseFloat(as[0].ordetax.length==0?"0":as[0].ordetax);
						 	var vcctotal = parseFloat(as[0].vcctotal.length==0?"0":as[0].vcctotal);
						 	var vcca = parseFloat(as[0].vcca.length==0?"0":as[0].vcca);
						 	var gqb = parseFloat(as[0].gqb.length==0?"0":as[0].gqb);
						 	var umm = parseFloat(as[0].umm.length==0?"0":as[0].umm);
						 	var total = parseFloat(as[0].total.length==0?"0":as[0].total);
						 	
                            var curorde = 0;
                            var curtotal = 0;
                            
                            for(var i=0;i<q_bbsCount;i++){
                                curorde = q_add(curorde,q_float('txtTotal_'+i));                     
                            }
                            curtotal = total - curorde;
                            if(curtotal<0){
                                var t_space = '          ';
                                var msg = as[0].custno+'\n'
                                +'＋額　　度：'+(t_space+q_trv(credit)).replace(/^.*(.{10})$/,'$1')+'\n'
                                +'－未出訂單：'+(t_space+q_trv((orde+ordetax))).replace(/^.*(.{10})$/,'$1')+'\n'
                                +'－應收貨款：'+(t_space+q_trv((vcctotal+vcca-umm))).replace(/^.*(.{10})$/,'$1')+'\n'
                                +'－應收票據：'+(t_space+q_trv(gqb)).replace(/^.*(.{10})$/,'$1')+'\n'
                                +'---------------------------------'+'\n' 
                                +'＋可用額度：'+(t_space+q_trv(total)).replace(/^.*(.{10})$/,'$1')+'\n'
                                +'－本張訂單：'+(t_space+q_trv(curorde)).replace(/^.*(.{10})$/,'$1')+'\n'
                                +'---------------------------------'+'\n'
                                +'　額度餘額：'+(t_space+q_trv(curtotal)).replace(/^.*(.{10})$/,'$1');
                                alert(msg);
                                Unlock(1);
                                return;
                            }                 
                        }
                        save();
                        break;
                }
            }

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordefe_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}
			
			var mouse_point;
			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtQuatno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            var t_accy = $('#txtTableaccy_' + n).val();
                            var t_tablea = $('#txtTablea_' + n).val();
                            var t_noa =  $('#txtQuatno_' + n).val();
                            
                            if(t_tablea.length==0)
                            	q_box("quat.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + r_accy, 'quat', "95%", "95%", q_getMsg("popQuat"));
                        	else
                        		q_box(t_tablea+".aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + t_noa + "';" + t_accy, t_tablea, "95%", "95%", "");
                        });
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						$('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnProduct_'+n).click();
                        });
						/*$('#btnProductno_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pop('ucc');
						});
						$('#txtProductno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//q_change($(this), 'ucc', 'noa', 'noa,product,unit');
						});*/

						$('#txtUnit_' + j).focusout(function() {
							sum();
						});
						// $('#txtWeight_' + j).focusout(function () { sum(); });
						$('#txtPrice_' + j).focusout(function() {
							sum();
						});
						$('#txtMount_' + j).focusout(function() {
							if (q_cur == 1 || q_cur == 2){
                            	var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            	t_productno = $.trim($('#txtProductno_'+n).val());
			                    t_mount = q_float('txtMount_' + n);
			                    if(t_productno.length>0 && t_mount!=0){
			                    	q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0,JSON.stringify({action:"getWeight",n:n,mount:t_mount}));	
			                    }
                            }
						});
						$('#txtTotal_' + j).focusout(function() {
							sum();
						});

						$('#txtMount_' + j).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								/*if (!emp($('#txtProductno_' + b_seq).val())) {
									//庫存
									var t_where = "where=^^ ['" + q_date() + "','','"+$('#txtProductno_' + b_seq).val()+"')  ^^";
									q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
								}*/
							}
						});
						$('#txtPrice_' + j).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								/*if (!emp($('#txtProductno_' + b_seq).val())) {
									//金額
									var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
									q_gt('ucc', t_where, 0, 0, 0, "msg_ucc", r_accy);
								}*/
							}
						});

						$('#btnBorn_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "noa='" + $('#txtNoa').val() + "' and no2='" + $('#txtNo2_' + b_seq).val() + "'";
							q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
						});
						$('#btnNeed_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "productno='" + $('#txtProductno_'+ b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
							q_box("z_vccneed.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Need', "95%", "95%", q_getMsg('lblNeed'));
						});

						$('#btnVccrecord_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "' and ordeno='"+$('#txtNoa').val()+"' and no2='"+$('#txtNo2_'+b_seq).val()+"' ";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
						
						$('#btnScheduled_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val())) {
								t_where = "noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
								q_box("z_scheduled.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
							}
						});
						
						$('#btnOrdemount_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "title='本期訂單' and bdate='"+q_cdn(q_date(),-61)+"' and edate='"+q_cdn(q_date(),+61)+"' and noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
							q_box("z_workgorde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
						});
						
						$('#btnStk_' + j).mousedown(function(e) {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
                                mouse_point = e;
                                document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
                                document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
                                //庫存
                                var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
                                q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
                            }
                        });
					}
				}
				_bbsAssign();
				
				if (q_cur<1 && q_cur>2) {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtDatea_'+j).datepicker( 'destroy' );
					}
				} else {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtDatea_'+j).removeClass('hasDatepicker')
						$('#txtDatea_'+j).datepicker();
					}
				}
				HiddenTreat();
			}

			function btnIns() {
				_btnIns();
				$('#chkIsproj').attr('checked', true);
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtGdate').val(q_date());
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();

				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
					return;
				_btnModi();
				$('#txtOdate').focus();
				
				if(dec($('#txtVcce').val())>0){
					alert('已轉派車單!!');
				}

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
               q_box("z_ordefep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'orde', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['odate'] = abbm2['odate'];

				if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];

				as['custno'] = abbm2['custno'];
				as['comp'] = abbm2['comp'];

				if (!as['enda'])
					as['enda'] = 'N';
				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('input[id*="txt"]').click(function() {
					browTicketForm($(this).get(0));
				});
				$('#div_addr2').hide();
				HiddenTreat();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnOrdei').removeAttr('disabled');
					$('#combAddr').attr('disabled', 'disabled');
					$('#txtOdate').datepicker( 'destroy' );
					$('#txtDatea').datepicker( 'destroy' );
					$('#txtGdate').datepicker( 'destroy' );
				} else {
					$('#btnOrdei').attr('disabled', 'disabled');
					$('#combAddr').removeAttr('disabled');
					$('#txtOdate').datepicker();
					$('#txtDatea').datepicker();
					$('#txtGdate').datepicker();
				}	
				
				$('#div_addr2').hide();
				readonly_addr2();
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
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
				if (q_chkClose())
					return;
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
				}
			}
			
			function HiddenTreat() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
				border-width: 0px;
			}
			.tview {
				width: 100%;
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
				width: 70%;
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
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_addr2" style="position:absolute; top:244px; left:500px; display:none; width:530px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_addr2" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="width:30px;background-color: #f8d463;" align="center">
						<input class="btn addr2" id="btnAddr_plus" type="button" value='＋' style="width: 30px" />
					</td>
					<td style="width:70px;background-color: #f8d463;" align="center">郵遞區號</td>
					<td style="width:430px;background-color: #f8d463;" align="center">指送地址</td>
				</tr>
				<tr id='addr2_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_addr2" type="button" value="確定">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_productno'></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_product'></td>
				</tr>
				<tr id='stk_top'>
					<td align="center" style="width: 30%;">倉庫編號</td>
					<td align="center" style="width: 45%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">倉庫數量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='3'>
					<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewOdate'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr class="tr1" style="height: 0px">
						<td class="td1" style="width: 10%;"></td>
						<td class="td2" style="width: 10%;"></td>
						<td class="td3" style="width: 10%;"></td>
						<td class="td4" style="width: 10%;"></td>
						<td class="td5" style="width: 10%;"></td>
						<td class="td6" style="width: 10%;"></td>
						<td class="td7" style="width: 10%;"></td>
						<td class="td8" style="width: 10%;"></td>
						<td class="tdZ" style="width: 1%;"></td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td2">
							<input id="txtOdate" type="text" class="txt c1"/>
							<input id="txtVcce" type="hidden"/>
						</td>
						<td class="td3"><span> </span><a id='lblStype' class="lbl" style="display:none;"> </a></td>
						<td class="td4"><select id="cmbStype" class="txt c1" style="display:none;"></select></td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td8" align="center"><input id="btnOrdei" type="button" style="display:none;"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
						<td class="td2"><input id="txtCno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td class="td5" ><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td class="td6"colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
						<td class="td8" align="center"><input id="btnOrdem" type="button" style="display:none;"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td6"><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td class="td7">
							<select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' ></select>
						</td>
						<td class="td8" align="center"><input id="btnCredit" type="button" value='' /></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2" colspan='3'><input id="txtTel" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtFax" type="text" class="txt c1" /></td>
						<td class="td8" align="center">
							<input id="btnQuat" type="button" value='' />
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
						<td class="td3"colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<td class="td7"><span> </span><a id='lblOrdbno' class="lbl"> </a></td>
						<td class="td8"><input id="txtOrdbno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td class="td2"><input id="txtPost2" type="text" class="txt c1"/></td>
						<td class="td3" colspan='4'>
							<input id="txtAddr2" type="text" class="txt c1" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td class="td7"><input id="btnAddr2" type="button" value='...' style="width: 30px;height: 21px" /> <span> </span><a id='lblOrdcno' class="lbl"> </a></td>
						<td class="td8"><input id="txtOrdcno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td class="td2" colspan="2">
							<select id="cmbTrantype" class="txt c1" name="D1" ></select>
						</td>
						<td class="td4"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td5" colspan="2">
							<input id="txtSalesno" type="text" class="txt c2"/>
							<input id="txtSales" type="text" class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td class="td8"><input id="txtApv" type="text" class="txt c1" disabled="disabled"/></td>					
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2" colspan='2'>
							<input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/>
						</td>
						<td class="td4"><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td class="td5"><input id="txtTax" type="text" class="txt num c1"/></td>
						<td class="td6"><select id="cmbTaxtype" class="txt c1" onchange='sum()' ></select></td>
						<td class="td7"><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td class="td8"><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td class="td2"><select id="cmbCoin"class="txt c1" onchange='coin_chg()'></select></td>
						<td class="td3"><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td class="td4"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td class="td5" colspan='2'><input id="txtTotalus" type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id='lblCustorde' class="lbl"> </a></td>
						<td class="td8"><input id="txtCustorde" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2" colspan='2'><input id="txtWorker" type="text" class="txt c1" /></td>
						<td class="td4"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td6" colspan='2'><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td colspan="2">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj'> </a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
							<input id="txtMemo2" type="text" style="display:none;" titlea="紀錄workj.trantype2"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">交貨日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><input id="txtTimea" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">接單日期</a></td>
						<td><input id="txtGdate" type="text" class="txt c1"/></td>
						<td><input id="txtGtime" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">總重量</a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1700px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:45px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:40px;"><a id='lblNo2'>訂序</a></td>
					<td align="center" style="width:250px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:95px;" class="isStyle"><a id='lblStyle'> </a></td>
					<td align="center" style="width:55px;"><a id='lblUnit'> </a></td>
					<!--<td align="center" style="width:85px;"><a >米數</a></td>-->
					<td align="center" style="width:85px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:85px;"><a id='lblWeight'> </a></td>
					<td align="center" style="width:85px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblGemounts'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:85px;"><a id='lblDateas'> </a></td>
					<td align="center" style="width:43px;"><a id='lblEndas'> </a></td>
					<td align="center" style="width:43px;"><a id='lblCancels'> </a></td>
					<td align="center" style="width:43px;"><a id='lblBorn'> </a></td>
					<td align="center" style="width:43px;"><a id='lblNeed'> </a></td>
					<td align="center" style="width:43px;"><a id='lblVccrecord'> </a></td>
					<td align="center" style="width:43px;"><a id='lblOrdemount'> </a></td>
					<td align="center" style="width:43px;"><a id='lblScheduled'> </a></td>
					<td align="center" style="width:43px;"><a id='lblStk'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt c7" id="txtNo2.*" type="text" /></td>
					<td align="center">
						<input class="txt c7" id="txtProductno.*" type="text" title="編號"/>
						<input class="txt c7" id="txtProduct.*" type="text" title="名稱"/>
						<input class="btn" id="btnProduct.*" type="button" style="display:none;" />
						<input id="txtSpec.*" type="text" style="display:none;"/>
					</td>
					<td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td align="center"><input class="txt c7" id="txtUnit.*" type="text"/></td>
					<!--<td><input class="txt num c7" id="txtLengthb.*" type="text" /></td>-->
					<td><input class="txt num c7" id="txtMount.*" type="text" /></td>
					<td><input class="txt num c7" id="txtWeight.*" type="text" /></td>
					<td><input class="txt num c7" id="txtPrice.*" type="text" /></td>
					<td><input class="txt num c7" id="txtTotal.*" type="text" /></td>
					<td>
						<input class="txt num c1" id="txtC1.*" type="text" />
						<input class="txt num c1" id="txtNotv.*" type="text" />
					</td>
					<td>
						<input class="txt c7" id="txtMemo.*" type="text" />
						<input class="txt" id="txtQuatno.*" type="text" style="width: 70%;" />
						<input class="txt" id="txtNo3.*" type="text" style="width: 20%;"/>
						<input id="recno.*" type="hidden" />
						<input id="txtTablea.*" type="text" style="display:none;"/>
						<input id="txtTableaccy.*" type="text" style="display:none;"/>
					</td>
					<td><input class="txt c7" id="txtDatea.*" type="text" /></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
					<td align="center">
						<input class="btn" id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td align="center">
						<input class="btn" id="btnNeed.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td align="center">
						<input class="btn" id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td align="center">
						<input class="btn" id="btnOrdemount.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td align="center">
						<input class="btn" id="btnScheduled.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td align="center">
					<input class="btn"  id="btnStk.*" type="button" value='.' style=" font-weight: bold;"/>
					</td>

				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>