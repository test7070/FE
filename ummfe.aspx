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
            t_part='',t_acomp= '';
            
            q_desc = 1;
            q_tables = 's';
            var q_name = "umm";
            var q_readonly = [ 'txtWorker', 'txtCno', 'txtAcomp', 'txtSale', 'txtTotal', 'txtPaysale', 'txtUnpay', 'txtOpay', 'textOpay','txtAccno','txtWorker2'];
            var q_readonlys = ['txtUnpay', 'txtUnpayorg', 'txtAcc1', 'txtAcc2', 'txtPart2','txtMemo2','txtCoin','txtPaymon','txtAcc1'];
            var bbmNum = new Array(['txtSale', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtOpay', 10, 0, 1], ['txtUnopay', 10, 0, 1], ['textOpay', 10, 0, 1]);
            var bbsNum = [['txtMoney', 10, 0, 1], ['txtChgs', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtUnpayorg', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];

            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwCount2 = 6;
            brwKey = 'Datea';
			
            var optionAcc={
            	item:'@,01@現金,02@匯款,03@信用狀,04@手續費,05@收票,06@開票,07@現金折讓,08@折讓金額,09@佣金支出,10@佣金收入,11@利息支出,12@利息收入,13@其它支出,14@其他收入'
            	,'01':{acc1:'1111.',acc2:'現金',modify:false}
            	,'02':{acc1:'1112.',acc2:'匯款',modify:true}
            	,'03':{acc1:'1112.',acc2:'信用狀',modify:true}
            	,'04':{acc1:'6206.',acc2:'手續費',modify:false}
            	,'05':{acc1:'1121.',acc2:'收票',modify:false}
            	,'06':{acc1:'2121.',acc2:'開票',modify:false}
            	,'07':{acc1:'4107.',acc2:'現金折讓',modify:false}
            	,'08':{acc1:'4106.',acc2:'折讓金額',modify:false}
            	,'09':{acc1:'6236.',acc2:'佣金支出',modify:false}
            	,'10':{acc1:'7114.',acc2:'佣金收入',modify:false}
            	,'11':{acc1:'8101.',acc2:'利息支出',modify:false}
            	,'12':{acc1:'7103.',acc2:'利息收入',modify:false}
            	,'13':{acc1:'8103.',acc2:'其它支出',modify:false}
            	,'14':{acc1:'7149.',acc2:'其他收入',modify:false}
            };
							
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                
                q_gt('part', '', 0, 0, 0, "");
		        
            });
            function main() {
                mainForm(1);
            }

            function mainPost() {
                q_cmbParse("cmbCno", t_acomp);
            	q_cmbParse("cmbPartno", t_part, 's');
                refresh(q_recno);  /// 第一次需要重新載入
            	
            	//放在mainPost 避免 r_accy抓不到
            	aPop = new Array(
            	['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx']
            	, ['txtAcc1_', '', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            	, ['txtBankno_', 'btnBank_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']
            	, ['txtUmmaccno_', '', 'ummacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'ummacc_b.aspx']);
            	
                q_getFormat();

                if (r_rank < 7)
                    q_readonly[q_readonly.length] = 'txtAccno';
				
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                bbsMask = [['txtIndate', r_picd], ['txtMon', r_picm]];
				
		        q_cmbParse("cmbHandle", optionAcc.item,'s');
		        
		        q_cmbParse("cmbRem1", ' ,'+q_getPara('gqb.rem1'),'s');
				
		         $('#txtDatea').blur(function() {
		         	if(!emp($('#txtDatea').val())&&(q_cur==1 || q_cur==2)){
		         		
		         		if(q_getPara('sys.project').toUpperCase()=='IT' || q_getPara('sys.project').toUpperCase()=='UU' || q_getPara('sys.project').toUpperCase()=='XY'){
		         			$('#txtMon').val($('#txtDatea').val().substr(0,6));
		         		}else{
                    		var d = new Date(dec($('#txtDatea').val().substr(0,3))+1911, dec($('#txtDatea').val().substr(4,2))-1, dec($('#txtDatea').val().substr(7,2)));
							d.setMonth(d.getMonth() - 1);
							$('#txtMon').val(d.getFullYear()-1911+'/'+('0'+(d.getMonth()+1)).slice(-2));
						}
					}
                });
		        
                $('#lblAccc').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substr(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('btnAccc'), true);
                });
                
                $('#lblCust2').click(function(e) {
					q_box("cust_b2.aspx", 'cust', "95%", "95%", q_getMsg("popCust"));
				});

                /*$('#txtOpay').change(function() {
                    sum();
                });*/
                $('#txtUnopay').change(function() {
                    sum();
                });

                $('#btnBank').click(function() {
                    q_box('bank.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", "銀行主檔");
                });

                $('#btnAuto').click(function(e) {
                    /// 自動沖帳
                    //$('#txtOpay').val(0);
                    //$('#txtUnopay').val(0);
                    for (var i = 0; i < q_bbsCount; i++) {
                        $('#txtPaysale_' + i).val(0);
                        //歸零
                        $('#txtUnpay_' + i).val($('#txtUnpayorg_' + i).val());
                        //歸零
                    }

                    var t_money = 0 + q_float('txtUnopay');
                    for (var i = 0; i < q_bbsCount; i++) {
                    	//$('#txtAcc1_' + i).val().indexOf('2121') == 0 ||
                        /*if ( $('#txtAcc1_' + i).val().indexOf('7149') == 0 || $('#txtAcc1_' + i).val().indexOf('7044') == 0)
                            t_money -= q_float('txtMoney_' + i);
                        else*/
                            t_money += q_float('txtMoney_' + i);
						//104/04/29費用不算在收款金額//0601恢復改為-
                        t_money -= q_float('txtChgs_' + i);
                    }

                    var t_unpay, t_pay = 0;
                    for (var i = 0; i < q_bbsCount; i++) {
                        if (q_float('txtUnpay_' + i) != 0) {
                            t_unpay = q_float('txtUnpayorg_' + i);
                            if (t_money >= t_unpay) {
                                q_tr('txtPaysale_' + i, t_unpay);
                                $('#txtUnpay_' + i).val(0);
                                t_money = t_money - t_unpay;
                            } else {
                                q_tr('txtPaysale_' + i, t_money);
                                q_tr('txtUnpay_' + i, t_unpay - t_money);
                                t_money = 0;
                            }
                        }
                    }
                    if (t_money > 0)
                        q_tr('txtOpay', t_money);
                    sum();
                });
                
                $('#btnVcc').click(function(e) {
                	var t_noa = $.trim($('#txtNoa').val());
                	var t_custno = $.trim($('#txtCustno').val());
                	var t_custno2 = $.trim($('#txtCustno2').val()).replace(/\,/g,'@');
                	var t_mon = $.trim($('#txtMon').val());
                	if(t_custno.length==0){
                		alert('請先輸入'+q_getMsg('lblCust')+'!!');
                		return;
                	}
                	q_gt('umm_import',"where=^^['"+t_noa+"','"+t_custno+"','"+t_custno2+"','"+t_mon+"','"+q_getPara('sys.d4taxtype')+"')^^", 0, 0, 0, "umm_import");
                	
                });
                
                $('#btnMon').click(function(e) {
                	if(q_cur==1 || q_cur==2){
                		var t_noa = $.trim($('#txtNoa').val());
	                	var t_custno = $.trim($('#txtCustno').val());
	                	var t_custno2 = $.trim($('#txtCustno2').val()).replace(/\,/g,'@');
	                	var t_mon = $.trim($('#txtMon').val());
	                	if(t_custno.length==0){
	                		alert('請先輸入'+q_getMsg('lblCust')+'!!');
	                		return;
	                	}
	                	if(t_mon.length==0){
	                		alert('請先輸入'+q_getMsg('lblMon')+'!!');
	                		return;
	                	}
	                	q_gt('umm_import',"where=^^['"+t_noa+"','"+t_custno+"','"+t_custno2+"','"+t_mon+"','mon')^^", 0, 0, 0, "umm_import");
                	}
                });
            }
			
			
            function getOpay() {
            	Lock(1,{opacity:0});
                var t_custno = $('#txtCustno').val();
                var s2 = (q_cur == 2 ? " and noa!='" + $('#txtNoa').val() + "'" : '');
                
                if(q_cur==4 ||q_cur==0 )
                	var t_where = "where=^^custno='" + t_custno + "'" + s2 + " and datea<='"+$('#txtDatea').val()+"' ^^";
                else
                	var t_where = "where=^^custno='" + t_custno + "'" + s2 + "^^";
                
                q_gt("umm_opay", t_where, 1, 1, 0, '', r_accy);
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtAcc1_':
                        sum();
                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {            
                    case 'cust':
                		ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4){
	                        if(ret[0]!=undefined){
	                        	for (var i = 0; i < ret.length; i++) {
	                        		if($('#txtCustno2').val().length>0){
		                            	var temp=$('#txtCustno2').val();
		                            	$('#txtCustno2').val(temp+','+ret[i].noa);
		                            }else{
		                            	$('#txtCustno2').val(ret[i].noa);
		                            } 
	                        	}
	                        }
						}
						break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function sum() {
                var t_money = 0, t_pay = 0, t_sale = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                	//$('#txtAcc1_' + j).val().indexOf('2121') == 0 ||
                    /*if ( $('#txtAcc1_' + j).val().indexOf('7149') == 0 || $('#txtAcc1_' + j).val().indexOf('7044') == 0)
                        t_money -= q_float('txtMoney_' + j);
                    else*/
                        t_money += q_float('txtMoney_' + j);
					//104/04/29費用不算在收款金額//0601恢復並改為-
                    t_money -= q_float('txtChgs_' + j);
                    t_sale += q_float('txtUnpayorg_' + j);
                    t_pay += q_float('txtPaysale_' + j);
                }

                //bbm收款金額(total)=bbs收款金額總額(money)
                //bbm應收金額(sale)=bbs應收金額總額(Unpayorg)
                //bbm本次沖帳(paysale)=bbs沖帳金額(paysale)+bbm預收沖帳(unopay)
                //bbm未收金額(unpay)=bbm應收金額(sale)-bbm本次沖帳(paysale)
                //bbm預收(opay)=bbm應收金額(total)-bbm本次沖帳(paysale)
                //bbm預收餘額=應收餘額+預收-預收沖帳

                q_tr('txtSale', t_sale);
                q_tr('txtTotal', t_money);
                q_tr('txtPaysale', t_pay);
                q_tr('txtUnpay', q_float('txtSale') - q_float('txtPaysale'));
                if (q_float('txtTotal') - q_float('txtPaysale') > 0) {
                    q_tr('txtOpay', q_float('txtTotal') - q_float('txtPaysale'));
                } else {
                    q_tr('txtOpay', 0);
                }
                q_tr('textOpay', q_float('textOpayOrg') + q_float('txtOpay') - q_float('txtUnopay'));
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'part':
		                var as = _q_appendData("part", "", true);
		                if (as[0] != undefined) {
		                	t_part = '@';
		                	for (i = 0; i < as.length; i++) {
		                		t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                		//t_part.push({noa:as[i].noa,part:as[i].part});
		                    } 
		                }
		                q_gt('acomp', '', 0, 0, 0, "");
		                break;
		            case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                	t_acomp = '';
		                	for (i = 0; i < as.length; i++) {
		                		t_acomp += (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
		                		//t_acomp.push({noa:as[i].noa,acomp:as[i].acomp});
		                    } 
		                }
		                q_gt(q_name, q_content, q_sqlCount, 1);
		                break;

                	case 'umm_import':
                		as = _q_appendData(t_name, "", true);
                		for (var i = 0; i < as.length; i++) {
                			as[i].tablea='vcc_fe';
						}
                		q_gridAddRow(bbsHtm, 'tbbs', 'txtCno,txtCustno,txtPaymon,txtCoin,txtUnpay,txtUnpayorg,txtTablea,txtAccy,txtVccno,txtMemo2', as.length, as, 'cno,custno,mon,coin,unpay,unpay,tablea,tableaccy,vccno,memo', '', '');
                		
                		var t_comp = q_getPara('sys.comp').substring(0,2);
                		for(var i=0;i<q_bbsCount;i++){
                			if($('#txtTablea_'+i).val()=='vcc' && t_comp == "裕承"){
                				$('#txtTablea_'+i).val('vccst');
                			}
                		}
                		
                		sum();
                		break;
                    case 'umm_opay':
                        var as = _q_appendData('umm', '', true);
                        var s1 = q_trv((as.length > 0 ? round(as[0].total, 0) : 0));
                        $('#textOpay').val(s1);
                        $('#textOpayOrg').val(s1);
						Unlock(1);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,13)=='gqb_btnOkbbs1'){
                    		//存檔時   bbs 支票號碼   先檢查view_gqb_chk,再檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]); 
                    		var t_checkno = t_name.split('_')[3];  
                    		var t_noa =  t_name.split('_')[4];               		
                    		var as = _q_appendData("view_gqb_chk", "", true);
                    		if(as[0]!=undefined){
                    			var t_isExist = false,t_msg = '';
                    			for(var i in as){
                    				if(as[i]['tablea']!=undefined ){
                    					t_isExist = true;
                    					if( as[i]['noa'] != t_noa){
                    						t_msg += (t_msg.length==0?'票據已存在:':'')+String.fromCharCode(13) + '【'+as[i]['title']+as[i]['noa']+'】'+as[i]['checkno'];
                    					}
                    				}
                    			}
                    			if(t_isExist && t_msg.length==0){
                    				checkGqb_bbs(t_sel-1);
                    			}
                    			else if(t_isExist && t_msg.length>0){
                    				alert('請由以下單據修改。'+String.fromCharCode(13)+t_msg);
                    				Unlock(1);
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock(1);
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_"+t_sel, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_"+t_sel, r_accy);
                    		}
                    	}else if(t_name.substring(0,13)=='gqb_btnOkbbs2'){
                    		//存檔時   bbs 支票號碼檢查
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);               		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
                    			Unlock(1);
                    		}else{
                    			checkGqb_bbs(t_sel-1);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_change1'){
                    		//先檢查view_gqb_chk,再檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]); 
                    		var t_checkno = t_name.split('_')[3];  
                    		var t_noa =  t_name.split('_')[4];           
                    		var as = _q_appendData("view_gqb_chk", "", true);
                    		if(as[0]!=undefined){
                    			var t_isExist = false,t_msg = '';
                    			for(var i in as){
                    				if(as[i]['tablea']!=undefined ){
                    					t_isExist = true;
                    					if( as[i]['noa'] != t_noa){
                    						t_msg += (t_msg.length==0?'票據已存在:':'')+String.fromCharCode(13) + '【'+as[i]['title']+as[i]['noa']+'】'+as[i]['checkno'];
                    					}
                    				}
                    			}
                    			if(t_isExist && t_msg.length==0){
                    				Unlock(1);
                    			}else if(t_isExist && t_msg.length>0){
                    				alert('請由以下單據修改。'+String.fromCharCode(13)+t_msg);
                    				Unlock(1);
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock(1);
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_"+t_sel, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_"+t_sel, r_accy);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_change2'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);               		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
                    		}
                    		Unlock(1);
                    	}else if(t_name.substring(0,11)=='gqb_status1'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("chk2s", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已託收，託收單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            					q_gt('ufs', t_where, 0, 0, 0, "gqb_status2_"+t_sel+"_"+t_checkno, r_accy);
                    		//}
                    	}else if(t_name.substring(0,11)=='gqb_status2'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("ufs", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已兌現，兌現單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			checkGqbStatus_btnModi(t_sel-1);
                    		//}
                    	}else if(t_name.substring(0,11)=='gqb_statusA'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("chk2s", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已託收，託收單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            					q_gt('ufs', t_where, 0, 0, 0, "gqb_statusB_"+t_sel+"_"+t_checkno, r_accy);
                    		//}
                    	}else if(t_name.substring(0,11)=='gqb_statusB'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("ufs", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已兌現，兌現單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			checkGqbStatus_btnDele(t_sel-1);
                    		//}
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                //$('#txtAccno').val(xmlString);
                Unlock(1);
            }
            
            function btnOk() {
            	Lock(1,{opacity:0});
            	$('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }
                for (var i = 0; i < q_bbsCount; i++) {
                	 if ($('#txtIndate_'+i).val().length > 0 && $('#txtIndate_'+i).val().indexOf('_')>-1) {
                    	alert(q_getMsg('lblIndate') + '錯誤。');
                    	Unlock(1);
                    	return;
                	}
                }
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                // 檢查空白
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
               /*if ($.trim($('#txtCustno').val()) == 0) {
                    alert(m_empty + q_getMsg('lblCust'));
                    Unlock(1);
                    return false;
                }*/
                var t_money = 0, t_chgs = 0, t_paysale, t_mon = '';
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtCheckno_'+i).val($.trim($('#txtCheckno_'+i).val()));
                	
                    t_money = q_float('txtMoney_' + i);
                    //104/04/29費用不算在收款金額//0601恢復並改為-
                    t_chgs = q_float('txtChgs_' + i);
                    if ($.trim($('#txtAcc1_' + i).val()).length == 0 && t_money - t_chgs > 0) {
                        t_err = true;
                        break;
                    }
                    if (t_money != 0 || i == 0)
                        t_mon = $('#txtVccno_' + i).val();
                }
                
                sum();
                
                if (t_err) {
                    alert(m_empty + q_getMsg('lblAcc1') + q_trv(t_money - t_chgs));
                    Unlock(1);
                    return false;
                }
                
                t_money=0,t_chgs=0;
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtCheckno_'+i).val($.trim($('#txtCheckno_'+i).val()));
                	
                    t_money += q_float('txtMoney_' + i);
                    //104/04/29費用不算在收款金額//0601恢復並改為-
                   t_chgs += q_float('txtChgs_' + i);
                }
                
                for (var i = 0; i < q_bbsCount; i++) {
                	if (emp($('#txtTablea_'+i).val())&&!emp($('#txtVccno_'+i).val())){
                		$('#txtTablea_'+i).val('vccfe');
                	}
                }
                
                if (emp($('#txtCustno').val()) && q_float('txtOpay')>0) {
                    alert('有預收金額客戶名稱不能空白!!');
                    Unlock(1);
                    return false;
                }
				
                var t_opay = q_float('txtOpay');
                var t_unopay = q_float('txtUnopay');
                var t1 = q_float('txtPaysale') + q_float('txtOpay') - q_float('txtUnopay');
                var t2 = t_money - t_chgs;
                if (t1 != t2) {
                    alert('收款金額  － 費用 ＝' + q_trv(t2) + '\r 【不等於】 沖帳金額 ＋ 預收 －　預收沖帳 ＝' + q_trv(t1) + '\r【差額】=' + Math.abs(t1 - t2));
                   	Unlock(1);
                    return false;
                }
                //先檢查BBS沒問題才存檔      
                checkGqb_bbs(q_bbsCount-1);
            }
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
			function checkGqb_bbs(n){
            	if(n<0){
            		for (var i = 0; i < q_bbsCount; i++) {
			            $('#txtPart_' + i).val($('#cmbPartno_' + i).find(":selected").text());
			        }
			        //為了查詢
	            	var t_part = '',t_checkno = '';
	            	for (var i = 0; i < q_bbsCount; i++) {
	            		if(t_part.indexOf($.trim($('#txtPart_'+i).val()))==-1)
	            			t_part += (t_part.length>0?',':'') + $.trim($('#txtPart_'+i).val());
	            		if($.trim($('#txtCheckno_'+i).val()).length>0 && t_checkno.indexOf($.trim($('#txtCheckno_'+i).val()))==-1)
	            			t_checkno += (t_checkno.length>0?',':'') + $.trim($('#txtCheckno_'+i).val());
	            	}
	            	$('#txtPart').val(t_part);
	            	$('#txtCheckno').val(t_checkno);
            		if(q_cur ==1){
		            	$('#txtWorker').val(r_name);
		            }else if(q_cur ==2){
		            	$('#txtWorker2').val(r_name);
		            }else{
		            	alert("error: btnok!");
		            }
		            //檢查票期
		            var t_item = '';
	               	for(var i=0;i<q_bbsCount;i++){
	               		t_item += (t_item.length>0?'|':'') + $('#txtCheckno_'+i).val()+'@'+$('#txtIndate_'+i).val();
	               		if(q_float('txtPaysale_'+i)!=0)
	               			t_item += '@'+$('#txtCustno_'+i).val()+'@'+$('#txtPaymon_'+i).val();
	               		else
	               			t_item += '@@';
	               	}
		            q_func('qtxt.query.ummfe', 'ummfe.txt,check,'+r_userno+';ummfe;' + $('#btnOk').data('guid')+';'+t_item); 
            	}else{
            		if($.trim($('#txtCheckno_'+n).val()).length>0 && $('#txtAcc1_'+n).val().substring(0,4)=='1121' && q_float('txtMoney_'+n)<0){
            			//收退  ,1121 , 金額負
            			checkGqb_bbs(n-1);
            		}else if($.trim($('#txtCheckno_'+n).val()).length>0){
            			var t_noa = $('#txtNoa').val();
	    				var t_checkno = $('#txtCheckno_'+n).val() ;   	
	        			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
	        			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOkbbs1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
            		}else{
            			checkGqb_bbs(n-1);
            		}
            	}
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.ummfe':
                		var as = _q_appendData("tmp0", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].val==1){
                        		var t_noa = trim($('#txtNoa').val());
				                var t_date = trim($('#txtDatea').val());
				                if (t_noa.length == 0 || t_noa == "AUTO")
				                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_umm') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				                else
				                    wrServer(t_noa);
                        	}else{
                        		alert(as[0].msg);
                        		Unlock(1);
                        		return;
                        	}
                        }else{
                    		alert('檢查異常，無法儲存。');
                    		Unlock(1);
                        	return;
                        }
                		break;
                    default:
                       break;
                }
            }
            
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('umm_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                    if ($('#btnMinus_' + i).hasClass('isAssign'))/// 重要
                        continue;
                    $('#cmbHandle_'+i).change(function(e){
						var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
						$('#txtAcc1_'+n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
						$('#txtAcc2_'+n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
						var t_handle = $(this).val();
						if(t_handle.length==0){
							$('#txtAcc1_'+n).val('');
							$('#txtAcc2_'+n).val('');
						}else{
							try{
								$('#txtAcc1_'+n).val(optionAcc[t_handle].acc1);
								$('#txtAcc2_'+n).val(optionAcc[t_handle].acc2);
								if(optionAcc[t_handle].modify){
									$('#txtAcc1_'+n).removeAttr('disabled').removeAttr('readonly').css('color','black').css('background','white');
									$('#txtAcc2_'+n).removeAttr('disabled').removeAttr('readonly').css('color','black').css('background','white');
								}
							}catch(e){
								$('#txtAcc1_'+n).val('');
								$('#txtAcc2_'+n).val('');
							}
						}
						
			        });
                    $('#txtAcc1_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAcc_'+n).click();
                    }).change(function() {
                    	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    	if($(this).val()=="=" && n>0){
                    		$('#txtAcc1_'+n).val($('#txtAcc1_'+(dec(n)-1)).val());
                    		$('#txtAcc2_'+n).val($('#txtAcc2_'+(dec(n)-1)).val());
                    	}
                    	
                        var patt = /^(\d{4})([^\.,.]*)$/g;
	                    $(this).val($(this).val().replace(patt,"$1.$2"));
                        sum();
                    });
                    $('#txtBankno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace('txtBankno_', '');
                        $('#btnBank_'+n).click();
                    });
                    /*$('#txtVccno_'+i).bind('contextmenu',function(e) {
                    	//滑鼠右鍵
                    	e.preventDefault();
                    	var n = $(this).attr('id').replace('txtVccno_','');
                    	var t_accy = $('#txtAccy_'+n).val();
                    	var t_tablea = $('#txtTablea_'+n).val();
                    	if(t_tablea.length>0 && $(this).val().indexOf('TAX')==-1 && !($(this).val().indexOf('-')>-1 && $(this).val().indexOf('/')>-1)){//稅額和月結排除
                    		//t_tablea = t_tablea + q_getPara('sys.project');
                    		//q_box(t_tablea+".aspx?;;;noa='" + $(this).val() + "'", t_tablea, "95%", "95%", q_getMsg("pop"+t_tablea));	
                    		q_box(t_tablea+".aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, t_tablea, "95%", "95%", q_getMsg("pop"+t_tablea));
                    	}
                    });*/
                    $('#txtVccno_'+i).change(function(e){
                    	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    	var t_custno='',t_mon='';	
                    	if($(this).val().match(/^(.*)-(\d{3,4}\/\d{2})$/)){
                			t_custno = $(this).val().replace(/^(.*)-(\d{3,4}\/\d{2})$/,'$1');
                    		t_mon = $(this).val().replace(/^(.*)-(\d{3,4}\/\d{2})$/,'$2');
                    	}
                    	$('#txtCustno_'+n).val(t_custno);
                    	$('#txtPaymon_'+n).val(t_mon);
                    	$('#txtCno_'+n).val($('#cmbCon').val());
                    });
					
                    $('#txtMoney_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtChgs_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtCheckno_'+i).change(function(){
        				Lock(1,{opacity:0});
        				
        				var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
        				var t_noa = $('#txtNoa').val();
        				var t_checkno = $('#txtCheckno_'+n).val() ;
            			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $('#txtAcc1_'+n).val().substring(0,4)=='1121' && q_float('txtMoney_'+n)<0){
	            			//收退  ,1121 , 金額負
	            			Unlock(1);
	            		}else if($.trim($('#txtCheckno_'+n).val()).length>0){
	            			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
            			}else{
            				Unlock(1);
            			}
            			
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $.trim($('#txtTitle_'+n).val()).length==0){
            				$('#txtTitle_'+n).val('鉅昕鋼鐵股份有限公司');
            			}
            			
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $.trim($('#cmbRem1_'+n).val()).length==0){
            				$('#cmbRem1_'+n).val('本人');
            			}
            			
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $.trim($('#txtRem2_'+n).val()).length==0){
            				$('#txtRem2_'+n).val('Y');
            			}
            			
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $.trim($('#txtRem3_'+n).val()).length==0){
            				$('#txtRem3_'+n).val('Y');
            			}
            			
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $.trim($('#txtRem4_'+n).val()).length==0){
            				$('#txtRem4_'+n).val('N');
            			}
            			
            		}).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        var t_checkno = $.trim($(this).val());
                        if (t_checkno.length > 0) {
                            q_box("gqb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";gqbno='" + t_checkno + "';" + r_accy, 'gqb', "95%", "95%", q_getMsg("popGqb"));
                        }
                    });
            		$('#txtPaysale_' + i).change(function(e) {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        
                        var t_unpay = dec($('#txtUnpayorg_' + b_seq).val()) - dec($('#txtPaysale_' + b_seq).val());
                        q_tr('txtUnpay_' + b_seq, t_unpay);
                        sum();
                    });
                }
                _bbsAssign();
                
                 for (var i = 0; i < q_bbsCount; i++) {
                 	if(emp($('#txtVccno_'+i).val()))
                 		$('#txtVccno_'+i).css('color','black').css('background','white').removeAttr('readonly');
                 	else
                 		$('#txtVccno_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                 }
                 
                 StatusAcc1();
                 
            }
			function StatusAcc1(){
				for(var n=0;n<q_bbsCount;n++){
					$('#txtAcc1_'+n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
					$('#txtAcc2_'+n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
				}
				if(!(q_cur==1 || q_cur==2))
					return;
				for(var n=0;n<q_bbsCount;n++){
					t_handle = $('#cmbHandle_'+n).val();
					try{
						if(t_handle.length>0 && optionAcc[t_handle].modify){
							$('#txtAcc1_'+n).removeAttr('disabled').removeAttr('readonly').css('color','black').css('background','white');
							$('#txtAcc2_'+n).removeAttr('disabled').removeAttr('readonly').css('color','black').css('background','white');
						}
					}catch(e){
						
					}
				}
			}
            function btnIns() {
                _btnIns();
                $('#txtDatea').focus();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                
                $('#cmbCno').val(r_cno);
                $('#txtAcomp').val(r_comp);
                
                //產生guid,送簽核用
               $('#btnOk').data('guid',guid());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
             		return;
               Lock(1,{opacity:0});
               //產生guid,送簽核用
               $('#btnOk').data('guid',guid());
              	
               checkGqbStatus_btnModi(q_bbsCount-1);
            }
            
            function checkGqbStatus_btnModi(n){
            	if(n<0){
            		 _btnModi();
               	     $('#textOpayOrg').val(q_float('textOpay') + q_float('txtUnopay') - q_float('txtOpay'));
            		Unlock(1);
            	}else{
            		var t_checkno = $.trim($('#txtCheckno_'+n).val());
            		if(t_checkno.length>0){
            			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            			q_gt('chk2s', t_where, 0, 0, 0, "gqb_status1_"+n+"_"+t_checkno, r_accy);
            		}else{
            			checkGqbStatus_btnModi(n-1);
            		}
            	}
            }
            function checkGqbStatus_btnDele(n){
            	if(n<0){
            		 _btnDele();
            		Unlock(1);
            	}else{
            		var t_checkno = $.trim($('#txtCheckno_'+n).val());
            		if(t_checkno.length>0){
            			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            			q_gt('chk2s', t_where, 0, 0, 0, "gqb_statusA_"+n+"_"+t_checkno, r_accy);
            		}else{
            			checkGqbStatus_btnDele(n-1);
            		}
            	}
            }

            function btnPrint() {
                q_box("z_ummp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'umm', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['acc1'] && (!as['money'] || parseFloat(as['money']) == 0) && (!as['paysale'] || parseFloat(as['paysale']) == 0)) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['mon'] = abbm2['mon'];
            	as['datea'] = abbm2['datea'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                 if(q_cur==1 || q_cur==2){
		        	$("#btnVcc").removeAttr("disabled");
		        	//$("#btnMon").removeAttr("disabled");
		        	$("#btnAuto").removeAttr("disabled");
		        }else{
		        	$("#btnVcc").attr("disabled","disabled");
		        	//$("#btnMon").attr("disabled","disabled");
		        	$("#btnAuto").attr("disabled","disabled");
		        }
		        StatusAcc1();
                getOpay();
            }


            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(q_cur==1 || q_cur==2){
		        	$("#btnVcc").removeAttr("disabled");
		        	//$("#btnMon").removeAttr("disabled");
		        	$("#btnAuto").removeAttr("disabled");
		        }else{
		        	$("#btnVcc").attr("disabled","disabled");
		        	//$("#btnMon").attr("disabled","disabled");
		        	$("#btnAuto").attr("disabled","disabled");
		        }
		        if(q_cur==1){
		        	$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
		        }else{
		        	$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		        }
		        
		        if(q_cur==2){
		        	for (var i = 0; i < q_bbsCount; i++) {
                 	if(emp($('#txtVccno_'+i).val()))
                 		$('#txtVccno_'+i).css('color','black').css('background','white').removeAttr('readonly');
                 	else
                 		$('#txtVccno_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                 }
		        }
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
            	Lock(1,{opacity:0});
            	checkGqbStatus_btnDele(q_bbsCount-1);
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function q_popPost(s1) {
			   	switch (s1) {
			   		case 'txtCustno':
                    	getOpay();
			        	break;
			   	}
			}
			
            function tipShow(){
				Lock(1);
				tipInit();
				var t_set = $('body');
				t_set.find('.tip').eq(0).show();//tipClose
				for(var i=1;i<t_set.data('tip').length;i++){
					index = t_set.data('tip')[i].index;
					obj = t_set.data('tip')[i].ref;
					msg = t_set.data('tip')[i].msg;
					shiftX = t_set.data('tip')[i].shiftX;
					shiftY = t_set.data('tip')[i].shiftY;
					if(obj.is(":visible")){
						t_set.find('.tip').eq(index).show().offset({top:round(obj.offset().top+shiftY,0),left:round(obj.offset().left+obj.width()+shiftX,0)}).html(msg);
					}else{
						t_set.find('.tip').eq(index).hide();
					}
				}
			}
			function tipInit(){
				
				tip($('#txtMon'),'<a style="color:red;font-size:16px;font-weight:bold;width:250px;display:block;">匯入資料前需注意【'+q_getMsg('lblMon')+'】有無輸入正確。</a>',-20,-10);
				tip($('#btnVcc'),'<a style="color:red;font-size:16px;font-weight:bold;width:300px;display:block;">【'+q_getMsg('btnVcc')+'】、【'+q_getMsg('btnMon')+'】只能擇一輸入。</a>',-50,30);
				tip($('#txtOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑本次預收金額。</a>',-100,30);
				tip($('#txtUnopay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑若使用預收金額來沖帳，則在此填入金額。</a>',-100,30);
				tip($('#textOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑累計預收金額。</a>',-100,30);
				tip($('#btnAuto'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑自動填入沖帳金額。</a>',-100,30);
				tip($('#txtAcc2_0'),'<a style="color:red;font-size:16px;font-weight:bold;width:200px;display:block;">若要退票，則會計科目輸入 1121. 應收票據，收款金額輸入負數。</a>',-100,30);
			}
			function tip(obj,msg,x,y){
				x = x==undefined?0:x;
				y = y==undefined?0:y;
				var t_set = $('body');
				if($('#tipClose').length==0){
					//顯示位置在btnTip上
					t_set.data('tip',new Array());
					t_set.append('<input type="button" id="tipClose" class="tip" value="關閉"/>');
					$('#tipClose')
					.css('position','absolute')
					.css('z-index','1001')
					.css('color','red')
					.css('font-size','18px')
					.css('display','none')
					.click(function(e){
						$('body').find('.tip').css('display','none');
						Unlock(1);
					});
					$('#tipClose').offset({top:round($('#btnTip').offset().top-2,0),left:round($('#btnTip').offset().left-15,0)});
					t_set.data('tip').push({index:0,ref:$('#tipClose')});
				}
				if(obj.data('tip')==undefined){
					t_index = t_set.find('.tip').length;
					obj.data('tip',t_index);
					t_set.append('<div class="tip" style="position: absolute;z-index:1000;display:none;"> </div>');
					t_set.data('tip').push({index:t_index,ref:obj,msg:msg,shiftX:x,shiftY:y});
				}			
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
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
				width: 1350px;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1300px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:30%"><a id='vewComp'> </a></td>
						<td align="center" style="width:30%"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width: 95px;"> </td>
						<td style="width: 120px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 120px;"> </td>
						<td style="width: 120px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 30px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtPart" type="text" style="display:none;"/>
							<input id="txtCheckno" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPayc' class="lbl btn"> </a></td>
						<td><input id="txtPayc"  type="text" class="txt c1"/></td>
						<td class="tdZ"><input type="button" id="btnTip" value="?" style="float:right;" onclick="tipShow()"/></td>
					</tr>
					<tr class="tr2">
						<td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
						<td>
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text" style="display:none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td class="td4" colspan="2">
						<input id="txtCustno" type="text" class="txt" style="float:left;width:40%;"/>
						<input id="txtComp"  type="text" class="txt" style="float:left;width:60%;"/>
						</td>
						<td colspan="2">
							<input type="button" id="btnVcc" class="txt c1 " style="display:none;"/>
							<input type="button" id="btnMon" class="txt c1 " style="width: 95px;"/>
							<span> </span><a id='lblCust2' class="lbl btn"> </a>
						</td>
						<td >
							<input id="txtCustno2" type="text" class="txt c1" title='多客戶使用"逗號"分隔'/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSale' class="lbl"> </a></td>
						<td class="td2"><input id="txtSale"  type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td class="td4"><input id="txtTotal" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblPaysale' class="lbl"> </a></td>
						<td class="td6"><input id="txtPaysale"  type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id='lblUnpay' class="lbl"> </a></td>
						<td class="td8"><input id="txtUnpay"  type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblOpay' class="lbl"> </a></td>
						<td class="td2"><input id="txtOpay"  type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblUnopay' class="lbl"> </a></td>
						<td class="td4"><input id="txtUnopay"  type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblTextopay' class="lbl"> </a></td>
						<td class="td6">
							<input id="textOpay"  type="text" class="txt num c1"/>
							<input type='hidden' id="textOpayOrg" />
						</td>
						<td><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" rowspan="6" ><textarea id="txtMemo"  rows='3' cols='3' style="width: 100%; " > </textarea></td>
						<td> </td>
						<td><input type="button" id="btnAuto" class="txt c1 "  style="color:red"/> </td>
						<td> </td>
						<td><input type="button" id="btnBank" class="txt c1 "/></td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblAcc1'> </a><br><a id='lblAcc2'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMoney'> </a><br><a id='lblAccmemo'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCheckno'> </a><br><a id='lblGqbtitle'> </a></td>
					<td align="center" style="width:70px;"><a id='lblRem1'> </a><br><a id='lblRem2'> </a></td>
					<td align="center" style="width:50px;"><a id='lblRem3'> </a><br><a id='lblRem4'> </a></td>
					<td align="center" style="width:120px;"><a id='lblAccount'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBankno'> </a><br><a id='lblBank'> </a></td>
					<td align="center" style="width:80px;"><a id='lblIndate'> </a></td>
					<td align="center" style="width:80px;"><a id='lblChgsTran'> </a><br><a id='lblParts'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:120px;"><a id='lblPaysales'> </a></td>
					<td align="center" style="width:80px;"><a id='lblUnpay_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCoins'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<select id="cmbHandle.*" style="width:95%;float:left;"> </select>
                        <input type="text" id="txtAcc1.*"  style="width:95%; float:left;" title="點擊滑鼠右鍵，列出明細。"/>
						<input type="text" id="txtAcc2.*"  style="width:95%; float:left;"/>
						<input type="button" id="btnAcc.*" style="display:none;" />
					</td>
					<td>
						<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtMemo.*" style="width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtCheckno.*"  style="width:95%;" />
						<input type="text" id="txtTitle.*" style="width:95%;" />
					</td>
					<td>
						<!--<input type="text" id="txtRem1.*"  style="width:95%;" />-->
						<select id="cmbRem1.*" style="width:95%;"> </select>
						<input type="text" id="txtRem2.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtRem3.*"  style="width:95%;" />
						<input type="text" id="txtRem4.*" style="width:95%;" />
					</td>
					<td><input type="text" id="txtAccount.*"  style="width:95%;" /></td>
					<td>
                        <input type="text" id="txtBankno.*"  style="width:95%; float:left;" title="點擊滑鼠右鍵，列出明細。"/>
						<input type="text" id="txtBank.*"  style="width:95%; float:left;"/>
						<input type="button" id="btnBank.*"  style=" display:none;"/>
					</td>
					<td><input type="text" id="txtIndate.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
						<select id="cmbPartno.*"  style="float:left;width:95%;" > </select>
						<input type="text" id="txtPart.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtMemo2.*" style="width:60%;float:left;"/>
						<input type="text" id="txtCno.*" style="width:30%;float:left;"/>
						<input type="text" id="txtVccno.*" style="width:95%;" title="點擊滑鼠右鍵，瀏覽單據內容。" />
						<input type="text" id="txtAccy.*" style="display:none;" />
						<input type="text" id="txtTablea.*" style="display:none;" />
						<input type="text" id="textTypea.*" style="display:none;" />
						<input type="text" id="txtCustno.*" style="display:none;" />
						
					</td>
					<td>
						<input type="text" id="txtPaysale.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtUnpayorg.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtUnpay.*"  style="width:95%; text-align: right;" />
						<input type="text" id="txtPart2.*"  style="float:left;width: 95%;"/>
					</td>
					<td>
						<input type="text" id="txtCoin.*" style="width:95%;"/>
						<input type="text" id="txtPaymon.*" style="width:95%;"/>
					</td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
