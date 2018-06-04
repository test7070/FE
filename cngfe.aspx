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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "cng";
			var q_readonly = ['txtNoa','txtComp','txtStorein','txtStore','txtNamea', 'txtWorker', 'txtWorker2', 'txtTotal'];
			var q_readonlys = [];
			var bbmNum = [['txtTotal', 15, 0, 1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtRackno', 'lblRackno', 'rack', 'noa,rack,storeno,store', 'txtRackno', 'rack_b.aspx'],
				['txtStoreinno', 'lblStorein', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx'],
				['txtRackinno', 'lblRackinno', 'rack', 'noa,rack,storeno,store', 'txtRackinno', 'rack_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,tel,salesno,sales', 'txtCustno,txtComp,txtTel,txtSssno,txtNamea', 'cust_b.aspx'],
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtMemo', '', 'qphr', 'noa,phr', '0,txtMemo', ''],
				['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,unit,style,lengthb,spec', 'txtUno_,txtProductno_,txtProduct_,txtUnit_,txtStyle_,txtLengthb_,txtSpec_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('cng.typea'));
				bbsNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1],['txtTotal', 15, 0, 1],['txtLengthb', 15, 2, 1]];
				if (q_getPara('sys.project').toUpperCase()=='YC'){
					aPop = new Array(
						['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
						['txtRackno', 'lblRackno', 'rack', 'noa,rack,storeno,store', 'txtRackno', 'rack_b.aspx'],
						['txtStoreinno', 'lblStorein', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx'],
						['txtRackinno', 'lblRackinno', 'rack', 'noa,rack,storeno,store', 'txtRackinno', 'rack_b.aspx'],
						['txtCustno', 'lblCust', 'cust', 'noa,nick,tel,salesno,sales', 'txtCustno,txtComp,txtTel,txtSssno,txtNamea', 'cust_b.aspx'],
						['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
						['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'],
						['textStoreoutno', '', 'store', 'noa,store', 'textStoreoutno,textStoreout', 'store_b.aspx'],
						['textStoreinno', '', 'store', 'noa,store', 'textStoreinno,textStorein', 'store_b.aspx'],
						['textBproductno', '', 'ucaucc', 'noa,product', 'textBproductno,textBproduct', 'ucaucc_b.aspx'],
						['textEproductno', '', 'ucaucc', 'noa,product', 'textEproductno,textEproduct', 'ucaucc_b.aspx']
					);
					bbsNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1],['txtTotal', 15, 0, 1],['txtLengthb', 15, 0, 1],['textLengthb', 10, 0, 1]];
				}
								
				$('#btnStorecng').click(function() {
					$('#divStorecng').show();
				});
				
				$('#textStoreoutno').focusin(function() {
					q_cur=2;
				}).focusout(function() {
					q_cur=0;
				});
				
				$('#textStoreinno').focusin(function() {
					q_cur=2;
				}).focusout(function() {
					q_cur=0;
				});
				
				$('#textBproductno').focusin(function() {
					q_cur=2;
				}).focusout(function() {
					q_cur=0;
				});
				
				$('#textEproductno').focusin(function() {
					q_cur=2;
				}).focusout(function() {
					q_cur=0;
				});
				
				$('#btnOkStorecng').click(function() {
					if(!emp($('#textStoreoutno').val()) && !emp($('#textStoreinno').val())){
						var t_storeoutno=$('#textStoreoutno').val();
						var t_storeinno=$('#textStoreinno').val();
						var t_bproductno=emp($('#textBproductno').val())?'#non':$('#textBproductno').val();
						var t_eproductno=emp($('#textEproductno').val())?'#non':$('#textEproductno').val();
						$('#btnOkStorecng').val('調倉中...').attr('disabled', 'disabled');
						
						var t_paras = t_storeoutno+ ';'+t_storeinno+ ';'+t_bproductno+ ';'+t_eproductno+ ';'+r_userno+ ';'+r_name+ ';'+q_getPara('sys.project').toUpperCase();
						q_func('qtxt.query.storecng', 'cng.txt,storecng,' + t_paras);
						
					}else{
						if(emp($('#textStoreoutno').val()) && emp($('#textStoreinno').val()))
							alert('請輸入倉庫!!');
						else if (emp($('#textStoreinno').val()))
							alert('請輸入調入倉庫!!');
						else
							alert('請輸入調出倉庫!!');
					}
				});
				
				$('#btnCloseStorecng').click(function() {
					$('#divStorecng').hide();
				});
				
				$('#btnClose_div_stk').click(function() {
                    $('#div_stk').hide();
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
			
			function q_popPost(s1) {
				switch (s1) {
					
				}
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
				    case 'msg_stk_all':
                        var as = _q_appendData("stkucc", "", true);
                        var rowslength=document.getElementById("table_stk").rows.length-3;
                            for (var j = 1; j < rowslength; j++) {
                                document.getElementById("table_stk").deleteRow(3);
                            }
                        var stk_row=0;
                        
                        var stkmount = 0,stkweight = 0;
                        for (var i = 0; i < as.length; i++) {
                            //倉庫庫存
                            if(dec(as[i].mount)!=0){
                                var tr = document.createElement("tr");
                                tr.id = "bbs_"+j;
                                tr.innerHTML = "<td id='assm_tdStoreno_"+stk_row+"'><input id='assm_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
                                tr.innerHTML+="<td id='assm_tdStore_"+stk_row+"'><input id='assm_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
                                tr.innerHTML+="<td id='assm_tdMount_"+stk_row+"'><input id='assm_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
                                tr.innerHTML+="<td id='assm_tdWeight_"+stk_row+"'><input id='assm_txtWeight_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].weight+"' disabled='disabled'/></td>";
                                var tmp = document.getElementById("stk_close");
                                tmp.parentNode.insertBefore(tr,tmp);
                                stk_row++;
                            }
                            //庫存總計
                            stkmount = stkmount + dec(as[i].mount);
                            stkweight = stkweight + dec(as[i].weight);
                        }
                        var tr = document.createElement("tr");
                        tr.id = "bbs_"+j;
                        tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >倉庫總計：</span></td>";
                        tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
                        tr.innerHTML+="<td id='stk_tdWeight_"+stk_row+"'><span id='stk_txtWeight_"+stk_row+"' type='text' class='txt c1 num' > "+stkweight+"</span></td>";
                        var tmp = document.getElementById("stk_close");
                        tmp.parentNode.insertBefore(tr,tmp);
                        stk_row++;
                        
                        $('#div_stk').css('top',mouse_point.pageY-parseInt($('#div_stk').css('height')));
                        $('#div_stk').css('left',mouse_point.pageX-parseInt($('#div_stk').css('width')));
                        $('#div_stk').toggle();
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.split('_')[0]=="uccuweight"){
					var n=t_name.split('_')[1];
					var as = _q_appendData("ucc", "", true);
					if (as[0] != undefined) {
						q_tr('txtWeight_'+n,q_mul(q_float('txtMount_'+n),dec(as[0].uweight)));
						sum();
					}
				}
				if(t_name.split('_')[0]=="uccstdmount"){
					var n=t_name.split('_')[1];
					var as = _q_appendData("ucc", "", true);
					if (as[0] != undefined) {
						q_tr('txtMount_'+n,q_mul(q_float('txtLengthb_'+n),dec(as[0].stdmount)));
						q_tr('txtWeight_'+n,q_mul(q_float('txtMount_'+n),dec(as[0].uweight)));
						sum();
					}
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_getPara('sys.project').toUpperCase()=='YC'){
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtLengthb_'+i).val($('#textLengthb_'+i).val());
					}
				}
				for(var i=0;i<q_bbsCount;i++){
					$('#txtStoreno_'+i).val($.trim($('#txtStoreno').val()));
					$('#txtStoreinno_'+i).val($.trim($('#txtStoreinno').val()));
				}
					
					
					
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cng') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cngfe_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtProductno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_' + n).click();
                        });
						$('#txtMount_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' +b_seq).val();
							if(t_unit=='公斤' || t_unit.toUpperCase()=='KG'){
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtWeight_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}else{
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtMount_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}
							
							if (!emp($('#txtProductno_' + b_seq).val()) && q_getPara('sys.project').toUpperCase()=='YC') {
								var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
								q_gt('ucc', t_where, 0, 0, 0, "uccuweight_"+b_seq, r_accy);
							}
							
							sum();
						});
						$('#txtWeight_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' +b_seq).val();
							if(t_unit=='公斤' || t_unit.toUpperCase()=='KG'){
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtWeight_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}else{
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtMount_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}
							sum();
						});
						$('#txtPrice_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' +b_seq).val();
							if(t_unit=='公斤' || t_unit.toUpperCase()=='KG'){
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtWeight_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}else{
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtMount_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}
							sum();
						});
						$('#txtUnit_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_unit = $('#txtUnit_' +b_seq).val();
							if(t_unit=='公斤' || t_unit.toUpperCase()=='KG'){
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtWeight_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}else{
								q_tr('txtTotal_' + b_seq, round(q_mul(q_float('txtMount_' + b_seq), q_float('txtPrice_' + b_seq)),0));
							}
							sum();
						});
						$('#txtTotal_' + i).change(function() {
							sum();
						});
						
						$('#textLengthb_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#txtLengthb_'+b_seq).val($(this).val());
							
							if (!emp($('#txtProductno_' + b_seq).val()) && q_getPara('sys.project').toUpperCase()=='YC') {
								var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
								q_gt('ucc', t_where, 0, 0, 0, "uccstdmount_"+b_seq, r_accy);
							}
						});
						
						if (q_getPara('sys.project').toUpperCase()=='YC'){
                            $('#textLengthb_' + i).focusout(function() {
                                sum();
                                $('#btnClose_div_stk').click();
                            });
                            
                            $('#textLengthb_' + i).focusin(function(e) {
                                if (q_cur == 1 || q_cur == 2) {
                                    t_IdSeq = -1;
                                    q_bodyId($(this).attr('id'));
                                    b_seq = t_IdSeq;
                                    if (!emp($('#txtProductno_' + b_seq).val())) {
                                        //庫存
                                        //var t_where = "where=^^ ['" + q_date() + "','','"+$('#txtProductno_' + b_seq).val()+"')  ^^";
                                        //q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
                                        //顯示DIV 105/02/22
                                        mouse_point=e;
                                        mouse_point.pageY=$('#txtMount_'+b_seq).offset().top;
                                        mouse_point.pageX=$('#txtMount_'+b_seq).offset().left;
                                        document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
                                        document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
                                        //庫存
                                        var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
                                        q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
                                    }
                                }
                            });
                        }
					}
				}
				_bbsAssign();
				refresh_field();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				refresh_field();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refresh_field();
				//判斷是否由撥料作業轉來>>鎖定欄位
				if(!emp($('#txtWorkkno').val()) || !emp($('#txtWorklno').val())){
					$('#cmbTypea').attr('disabled', 'disabled');
					$('#txtDatea').attr('disabled', 'disabled');
					$('#txtStoreno').attr('disabled', 'disabled');
					$('#txtStoreinno').attr('disabled', 'disabled');
					$('#lblStorek').css('display', 'inline').text($('#lblStore').text());
					$('#lblStoreink').css('display', 'inline').text($('#lblStorein').text());
					$('#lblStore').css('display','none');
					$('#lblStorein').css('display','none');
					
					$('#btnPlus').attr('disabled', 'disabled');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#btnMinus_'+j).attr('disabled', 'disabled');
						$('#txtUno_'+j).attr('disabled', 'disabled');
						$('#txtProductno_'+j).attr('disabled', 'disabled');
						$('#btnProductno_'+j).attr('disabled', 'disabled');
						$('#txtProduct_'+j).attr('disabled', 'disabled');
						$('#txtStyle_'+j).attr('disabled', 'disabled');
						$('#txtLengthb_'+j).attr('disabled', 'disabled');
						$('#txtWeight_'+j).attr('disabled', 'disabled');
						$('#txtPrice_'+j).attr('disabled', 'disabled');
						$('#txtTotal_'+j).attr('disabled', 'disabled');
						$('#txtUnit_'+j).attr('disabled', 'disabled');
						$('#txtSpec_'+j).attr('disabled', 'disabled');
						$('#txtMount_'+j).attr('disabled', 'disabled');
					}
				}
				
				$('#txtCustno').focus();
			}

			function btnPrint() {
				q_box('z_cngfep.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['tggno'] = abbm2['tggno'];
				as['typea'] = abbm2['typea'];
				as['storeno'] = abbm2['storeno'];
				as['storeinno'] = abbm2['storeinno'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				refresh_field();
			}
			
			function refresh_field() {
				if (q_getPara('sys.project').toUpperCase()=='YC'){
					$('.yc_hide').hide();
					$('.yc_show').show();
					for (var i = 0; i < q_bbsCount; i++) {
						$('#textLengthb_'+i).val($('#txtLengthb_'+i).val());
					}
				}
				
				$('#lblProducts').text('品名');
				$('#lblLengthb_yc_s').text('箱數');
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#btnStorecng').removeAttr('disabled');
				}else{
					$('#btnStorecng').attr('disabled', 'disabled');
				}
				$('#divStorecng').hide();
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
				if(!emp($('#txtWorkkno').val())){
					alert("該調撥單由撥料作業("+$('#txtWorkkno').val()+")轉來，請至撥料作業刪除!!!")
					return;
				}
				
				if(!emp($('#txtWorklno').val())){
					alert("該調撥單由委外撥料作業("+$('#txtWorklno').val()+")轉來，請至委外撥料作業刪除!!!")
					return;
				}
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.storecng':
						var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	if(as[0].noa!=''){
                        		q_func('cng_post.post', r_accy + ',' + as[0].noa + ',1');	
                        	}else{
                        		//無產生調撥
                        		alert("調出倉庫無物品可調撥!!");
                        	}
                        }
                        
                        $('#btnOkStorecng').val('確定').removeAttr('disabled');
						$('#divStorecng').hide();
						break;
					case 'cng_post.post':
						alert("倉庫調撥單產生完畢!!");
						location.href=location.href;
						break;
				}
			}

			function sum() {
				var t_total=0;
				for (var j = 0; j < q_bbsCount; j++) {
					if(!emp($('#txtProductno_'+j).val()))
						t_total=q_add(t_total,q_float('txtTotal_'+j));
				}
				q_tr('txtTotal',t_total);
			}

		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 400px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
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
                 width: 750px;
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
                width: 16%;
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
                font-size: medium;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1200px;
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
                width: 1200px;
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
            #dbbt {
                width: 1260px;
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
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
            <table id="table_stk" style="width:100%;" border="1" cellpadding='3'  cellspacing='0'>
                <tr>
                    <td style="background-color: #f8d463;" align="center">產品編號</td>
                    <td style="background-color: #f8d463;" colspan="3" id='stk_productno'> </td>
                </tr>
                <tr>
                    <td style="background-color: #f8d463;" align="center">產品名稱</td>
                    <td style="background-color: #f8d463;" colspan="3" id='stk_product'> </td>
                </tr>
                <tr id='stk_top'>
                    <td align="center" style="width: 19%;">倉庫編號</td>
                    <td align="center" style="width: 25%;">倉庫名稱</td>
                    <td align="center" style="width: 25%;">倉庫數量</td>
                    <td align="center" style="width: 25%;">倉庫重量</td>
                </tr>
                <tr id='stk_close'>
                    <td align="center" colspan='4'>
                        <input id="btnClose_div_stk" type="button" value="關閉視窗">
                    </td>
                </tr>
            </table>
        </div>
		<div id="divStorecng" style="top:50px;right:180px;position:absolute; display: none;">
			<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:550px">
	            <tr>
	                <td align="center" style="width:25%;"><span> </span><a >調出倉庫</a></td>
	                <td align="center" style="width:30%;"><input id="textStoreoutno" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	                <td align="center" style="width:55%;"><input id="textStoreout" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	            </tr>
	            <tr>
	                <td align="center"><span> </span><a >調入倉庫</a></td>
	                <td align="center"><input id="textStoreinno" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	                <td align="center"><input id="textStorein" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	            </tr>
	            <tr>
	                <td align="center"><span> </span><a >起始物品</a></td>
	                <td align="center"><input id="textBproductno" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	                <td align="center"><input id="textBproduct" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	            </tr>
	            <tr>
	                <td align="center"><span> </span><a >終止物品</a></td>
	                <td align="center"><input id="textEproductno" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	                <td align="center"><input id="textEproduct" type="text"  class="txt" style=" float: left;width: 98%;"/></td>
	            </tr>
	            <tr>
	            	<td align="center" colspan="3">
	            		<input id="btnOkStorecng" type="button" value="確定"/>
	            		<input id="btnCloseStorecng" type="button"/ value="關閉">
	                </td>
	            </tr>
        	</table>
		</div>
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewStore'> </a></td>
						<td align="center" style="width:25%"><a id='vewStorein'> </a></td>
						<td align="center" style="width:25%"><a id='vewCust'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='store'>~store</td>
						<td align="center" id='storein'>~storein</td>
						<td align="center" id='comp,4'>~comp,4</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr1">
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>						
						<td style="display: none;"><span> </span><a id="lblType" class="lbl" > </a></td>
						<td style="display: none;"><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr class="tr2">
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTel" class="lbl" > </a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td><span> </span><a id="lblSssno" class="lbl btn"> </a></td>
						<td><input id="txtSssno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtNamea" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input id="btnStorecng" type="button" class="yc_show" style="display: none;" value="倉庫調撥"></td>
					</tr>
					<tr class="tr4">
						<td class='td3'>
							<span> </span><a id="lblStore" class="lbl btn"> </a>
							<a id="lblStorek" class="lbl btn" style="display: none"> </a>
						</td>
						<td><input id="txtStoreno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtStore" type="text" class="txt c1"/></td>
						<td class='td3 isRack'><span> </span><a id="lblRackno" class="lbl btn"> </a></td>
						<td class="td4 isRack"><input id="txtRackno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id="lblStorein" class="lbl btn"> </a>
							<a id="lblStoreink" class="lbl btn" style="display: none"> </a>
						</td>
						<td><input id="txtStoreinno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtStorein" type="text" class="txt c1"/></td>
						<td class="isRack"><span> </span><a id="lblRackinno" class="lbl btn"> </a></td>
						<td class="isRack"><input id="txtRackinno" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
							<input id="txtWorkkno" type="hidden" /><input id="txtWorklno" type="hidden" />
						</td>
					</tr>
					<tr class="tr7">
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td class="yc_hide"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="yc_hide"><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:150px;" align="center"><a id='lblProductnos'> </a></td>
					<td style="width:300px;" align="center"><a id='lblProducts'> </a></td>
					<td style="width:80px;" align="center" class="yc_hide"><a id='lblLengthb_fe_s'> </a></td>
					<td style="width:40px;" align="center"><a id='lblUnit'> </a></td>
					<td style="width:80px;display: none;" align="center" class="yc_show"><a id='lblLengthb_yc_s'> </a></td>
					<td style="width:100px;" align="center"><a id='lblMounts'> </a></td>
					<td style="width:100px;" align="center"><a id='lblWeights'> </a></td>
					<td style="width:100px;" align="center" class="yc_hide"><a id='lblPrices'> </a></td>
					<td style="width:100px;" align="center" class="yc_hide"><a id='lblTotals'> </a></td>
					<td style="width:200px;" align="center" class="yc_hide"><a id='lblUno'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
						<input id="txtStoreno.*" type="hidden" />
						<input id="txtStoreinno.*" type="hidden" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%;"/>
						<input id="btnProduct.*" type="button" style="display:none;" />
					</td>
					<td><input id="txtProduct.*" type="text" style="width:95%;"/></td>
					<td class="yc_hide"><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
					<td><input class="txt c1" id="txtUnit.*" type="text" /></td>
					<td class="yc_show" style="display: none;"><input id="textLengthb.*" type="text" class="txt c1 num"/></td>
					<td><input class="txt num c1" id="txtMount.*" type="text"/></td>
					<td><input class="txt num c1" id="txtWeight.*" type="text"/></td>
					<td class="yc_hide"><input class="txt num c1" id="txtPrice.*" type="text"/></td>
					<td class="yc_hide"><input class="txt num c1" id="txtTotal.*" type="text"/></td>
					<td class="yc_hide"><input class="txt c1" id="txtUno.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>