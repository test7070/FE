<!--2016/01/20-->
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

            q_tables = 's';
            var q_name = "rc2";
            var decbbs = ['money', 'total', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
            var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney', 'totalus'];
            var q_readonly = ['txtNoa', 'txtAcomp', 'txtTgg', 'txtWorker', 'txtWorker2','txtTranstart','txtMoney','txtTax','txtTotal','txtAccno','txtCardeal','txtDriver','txtSales','txtTotalus'];
            var q_readonlys = ['txtNoq','txtTotal'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            aPop = new Array(
                ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,tel,paytype', 'txtTggno,txtComp,txtNick,txtTel,txtPaytype', 'tgg_b.aspx'],
                ['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
                ['txtRackno_', 'btnRackno_', 'rack', 'noa,rack,storeno,store', 'txtRackno_', 'rack_b.aspx'],
                ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
                ['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc_b.aspx'],
                //['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,unit,style,lengthb,spec', 'txtUno_,txtProductno_,txtProduct_,txtUnit_,txtStyle_,txtLengthb_,txtSpec_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
                //['txtCarno', 'lblCar', 'cardeal', 'noa,comp', '0txtCarno,txtCar', 'cardeal_b.aspx'],
                ['txtTranstartno', 'lblTranstart', 'addr2', 'noa,post','txtTranstartno,txtTranstart', 'addr2_b.aspx'],
                ['txtDriverno', 'lblDriver', 'driver', 'noa,namea','txtDriverno,txtDriver', 'driver_b.aspx']
            );

            var isinvosystem = false;
            //購買發票系統
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
                q_gt('ucca', 'stop=1 ', 0, 0, 0, "ucca_invo");
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
                //判斷是否有買發票系統
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function sum() {
            	if(!(q_cur=='1' || q_cur=='2')){
            		return;
            	}
                var t_unit,t_price, t_mount,t_weight, t_weights = 0,t_total,t_totals=0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_unit = $.trim($('#txtUnit_' + j).val());
                    t_price = q_float('txtPrice_' + j);
                    t_mount = q_float('txtMount_' + j);
                    t_weight = q_float('txtWeight_' + j);
                    t_weights= q_add(t_weights,t_weight);
                    t_discount = q_div(q_float('txtDiscount_' + j),100);
                    if(t_discount==0){
                    	$('#txtDiscount_' + j).val(100);
                    	t_discount = 100;
                    }
                    if(t_unit.length==0 || t_unit=='公斤' || t_unit.toUpperCase()=='KG'){
                        t_total = round(q_mul(t_price, t_weight), 0);
                    }else{
                        t_total = round(q_mul(t_price, t_mount), 0);
                    }
                    t_total=q_mul(t_total,t_discount);
                    
                    t_totals = q_add(t_totals,t_total);
                    $('#txtTotal_' + j).val(t_total);
                }
                $('#txtWeight').val(t_weights);
                 $('#txtMoney').val(t_totals);
                $('#txtTotal').val(q_add(t_totals,q_float('txtTax')));
                var total = 0;
                calTax();
                q_tr('txtTotalus', round(q_mul(q_float('txtTotal'), q_float('txtFloata')), 0));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1], ['txtTotalus', 15, 0, 1], ['txtFloata', 10, 2, 1],['txtCartrips',10,0,1]];
                bbsNum = [['txtLengthb', 15, 2, 1],['txtMount', 15, q_getPara('rc2.mountPrecision'), 1],['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1], ['txtPrice', 15, 3, 1], ['txtTotal', 15, 0, 1], ['txtDiscount', 5, 2, 1], ['txtCounta', 5, 0, 1]];
                
                q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
                //q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
                
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                var t_where = "where=^^ 1=1 ^^";
                q_gt('custaddr', t_where, 0, 0, 0, "");
                
                //限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入                  
                $('#txtMemo').change(function(){
                    if ($('#txtMemo').val().substr(0,1)=='*')
                        $('#txtMon').removeAttr('readonly');
                    else
                        $('#txtMon').attr('readonly', 'readonly');
                });
                
                $('#txtMon').click(function(){
                    if ($('#txtMon').attr("readonly")=="readonly" && (q_cur==1 || q_cur==2))
                        q_msg($('#txtMon'), "月份要另外設定，請在"+q_getMsg('lblMemo')+"的第一個字打'*'字");
                });
                
                $('#lblAccc').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
                });
                $('#lblOrdc').click(function() {
                    lblOrdc();
                });
                $('#lblInvono').click(function() {
                    t_where = '';
                    t_invo = $('#txtInvono').val();
                    if (t_invo.length > 0) {
                        t_where = "noa='" + t_invo + "'";
                        q_box("rc2a.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'rc2a', "95%", "95%", q_getMsg('popRc2a'));
                    }
                });
                
                $('#lblInvo').click(function() {
					t_where = '';
					t_invo = $('#txtInvo').val();
					if (t_invo.length > 0) {
						t_where = "noa='" + t_invo + "'";
						q_box("invoi.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invoi', "95%", "95%", $('#lblInvo').val());
					}
				});
                
                $('#lblLcno').click(function() {
                    t_where = '';
                    t_lcno = $('#txtLcno').val();
                    if (t_lcno.length > 0) {
                        t_where = "lcno='" + t_lcno + "'";
                        q_box("lcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'lcs', "95%", "95%", q_getMsg('popLcs'));
                    }
                });
                $('#txtFloata').change(function() {
                    sum();
                });
                $('#txtTotal').change(function() {
                    sum();
                });
                $('#txtTggno').change(function() {
                    if (!emp($('#txtTggno').val())) {
                        var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^";
                        q_gt('custaddr', t_where, 0, 0, 0, "");
                    }
                });

                $('#txtAddr').change(function() {
                    var t_tggno = trim($(this).val());
                    if (!emp(t_tggno)) {
                        focus_addr = $(this).attr('id');
                        zip_fact = $('#txtPost').attr('id');
                        var t_where = "where=^^ noa='" + t_tggno + "' ^^";
                        q_gt('tgg', t_where, 0, 0, 0, "");
                    }
                });
                $('#txtAddr2').change(function() {
                    var t_custno = trim($(this).val());
                    if (!emp(t_custno)) {
                        focus_addr = $(this).attr('id');
                        zip_fact = $('#txtPost2').attr('id');
                        var t_where = "where=^^ noa='" + t_custno + "' ^^";
                        q_gt('cust', t_where, 0, 0, 0, "");
                    }
                });
                if (isinvosystem)
                    $('.istax').hide();
                $('#txtPrice').change(function(){
                    sum();
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'ordcs':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0) {
                                b_pop = '';
                                return;
                            }
                            //取得採購的資料
                            var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
                            q_gt('ordc', t_where, 0, 0, 0, "", r_accy);

                            $('#txtOrdcno').val(b_ret[0].noa);
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtSpec,txtProduct,txtUnit,txtMount,txtWeight,txtOrdeno,txtNo2,txtPrice,txtTotal,txtMemo'
                            , b_ret.length, b_ret, 'uno,productno,spec,product,unit,mount,weight,noa,no2,price,total,memo', 'txtProductno,txtProduct');
                            bbsAssign();
                            sum();
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            var focus_addr = '', zip_fact = '';
            var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
            var carnoList = [];
            var thisCarSpecno = '';
            function q_gtPost(t_name) {
                switch (t_name) {
					case 'ucca_invo':
                        var as = _q_appendData("ucca", "", true);
                        if (as[0] != undefined) {
                            isinvosystem = true;
                            $('.istax').hide();
                        } else {
                            isinvosystem = false;
                        }
                        break;
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
                    case 'tgg':
                        var as = _q_appendData("tgg", "", true);
                        if (as[0] != undefined && focus_addr != '') {
                            $('#' + zip_fact).val(as[0].zip_fact);
                            $('#' + focus_addr).val(as[0].addr_fact);
                            zip_fact = '';
                            focus_addr = '';
                        }
                        break;
                    case 'cust':
                        var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined && focus_addr != '') {
                            $('#' + zip_fact).val(as[0].zip_fact);
                            $('#' + focus_addr).val(as[0].addr_fact);
                            zip_fact = '';
                            focus_addr = '';
                        }
                        break;
                    case 'btnDele':
                        var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                            var t_msg = "", t_paysale = 0;
                            for (var i = 0; i < as.length; i++) {
                                t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
                                if (t_paysale != 0)
                                    t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
                            }
                            if (t_msg.length > 0) {
                                alert('已沖帳:' + t_msg);
                                Unlock(1);
                                return;
                            }
                        }
                        _btnDele();
                        Unlock(1);
                        break;
                    case 'btnModi':
                        var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                            var t_msg = "", t_paysale = 0;
                            for (var i = 0; i < as.length; i++) {
                                t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
                                if (t_paysale != 0)
                                    t_msg += String.fromCharCode(13) + '付款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
                            }
                            if (t_msg.length > 0) {
                                alert('已沖帳:' + t_msg);
                                Unlock(1);
                                return;
                            }
                        }
                        _btnModi();
                        if(r_rank<8){
		                	$('#btnPlus').attr('disabled','disabled');
		                	for(var i=0;i<q_bbsCount;i++){
		                		$('#btnMinus_'+i).attr('disabled','disabled');	
		                	}
		                }
                        Unlock(1);
                        $('#txtDatea').focus();
                        if (!emp($('#txtTggno').val())) {
                            var t_where = "where=^^ noa='" + $('#txtTggno').val() + "'^^";
                            q_gt('custaddr', t_where, 0, 0, 0, "");
                        }
                        break;
                    case 'ordc':
                        var ordc = _q_appendData("ordc", "", true);
                        if (ordc[0] != undefined) {
                            $('#combPaytype').val(ordc[0].paytype);
                            $('#txtPaytype').val(ordc[0].pay);
                            $('#cmbCoin').val(ordc[0].coin);
                        }
                        break;
                    case 'startdate':
                        var as = _q_appendData('tgg', '', true);
                        var t_startdate='';
                        if (as[0] != undefined) {
                            t_startdate=as[0].startdate;
                        }
                        if(t_startdate.length==0 || ('00'+t_startdate).slice(-2)=='00' || $('#txtDatea').val().substr(7, 2)<('00'+t_startdate).substr(-2)){
                            $('#txtMon').val($('#txtDatea').val().substr(0, 6));
                        }else{
                            var t_date=$('#txtDatea').val();
                            var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,1);
                            nextdate.setMonth(nextdate.getMonth() +1);
                            t_date=''+(nextdate.getFullYear()-1911)+'/'+(nextdate.getMonth()<9?'0':'')+(nextdate.getMonth()+1);
                            $('#txtMon').val(t_date);
                        }
                        check_startdate=true;
                        btnOk();
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

            function lblOrdc() {
                var t_tggno = trim($('#txtTggno').val());
                var t_ordeno = trim($('#txtOrdeno').val());
                var t_where = '';
                if (t_tggno.length > 0) {
                    if (t_ordeno.length > 0)
                        t_where = "isnull(b.enda,0)=0 && isnull(view_ordcs.enda,0)=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "") + "&& " + (t_ordeno.length > 0 ? q_sqlPara("noa", t_ordeno) : "");
                    else
                        t_where = "isnull(b.enda,0)=0 && isnull(view_ordcs.enda,0)=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "");
                    t_where = t_where;
                } else {
                    alert(q_getMsg('msgTggEmp'));
                    return;
                }
                q_box("ordcs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var s1 = xmlString.split(';');
                abbm[q_recno]['accno'] = s1[0];
                $('#txtAccno').val(s1[0]);
            }
            
            var check_startdate=false;
            function btnOk() {
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
                // 檢查空白
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                //判斷起算日,寫入帳款月份
                //104/09/30 如果備註沒有*字就重算帳款月份
				//if(!check_startdate && emp($('#txtMon').val())){
				if(!check_startdate && $('#txtMemo').val().substr(0,1)!='*'){	
                    var t_where = "where=^^ noa='"+$('#txtTggno').val()+"' ^^";
                    q_gt('tgg', t_where, 0, 0, 0, "startdate", r_accy);
                    return;
                }
                check_startdate=false;
                
                /*$('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    return;
                }
                
                if (emp($('#txtMon').val()))
                    $('#txtMon').val($('#txtDatea').val().substr(0, 6));*/
                
                sum();
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                    
                var t_item = '';
               	for(var i=0;i<q_bbsCount;i++){
               		t_item += (t_item.length>0?'|':'') + $('#txtNoq_'+i).val()+'@'+q_float('txtTotal_'+i);
               	}
               	
                if(q_cur==2){
               		//修改需檢查金額(金額只可以改小不可以改大，改大要"特別權限")
               		q_func('qtxt.query.rc2fe', 'rc2fe.txt,check,'+r_userno+';rc2fe;' + $('#btnModi').data('guid')+';'+$('#txtNoa').val()+';'+t_item); 
               	}else{
               		save();
               	} 
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.rc2fe':
                		//BBS TEXTBOX全部鎖定
                		$('#tbbs').children().find('input[type="text"]').attr('disabled','disabled');
                		var as = _q_appendData("tmp0", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].val==1){
                        		save();
                        	}else{
                        		alert(as[0].msg);
                        		return;
                        	}
                        }else{
                    		alert('進貨單檢查異常，無法儲存。');
                        	return;
                        }
                		break;
                    default:
                       break;
                }
            }
            function save(){
            	var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2') + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('rc2fe_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function cmbPaytype_chg() {
                var cmb = document.getElementById("combPaytype");
                if (!q_cur)
                    cmb.value = '';
                else
                    $('#txtPaytype').val(cmb.value);
                cmb.value = '';
            }
            
            function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

            function combAddr_chg() {
                if (q_cur == 1 || q_cur == 2) {
                    $('#txtAddr2').val($('#combAddr').find("option:selected").text());
                    $('#txtPost2').val($('#combAddr').find("option:selected").val());
                }
            }

            function bbsAssign() {
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                	$('#lblNo_'+j).text(j+1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtProductno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_' + n).click();
                        });
                        $('#txtStoreno_' + j).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtStoreno_', '');
                            $('#btnStore_' + n).click();
                        });
                        
                        $('#btnMinus_' + j).click(function() {
                            btnMinus($(this).attr('id'));
                        });
                        $('#txtUno_' + j).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtDiscount_'+b_seq).val())&&(!emp($('#txtProductno_' + b_seq).val()) || !emp($('#txtUno_' + b_seq).val()))&&(q_cur==1 || q_cur==2)){
								$('#txtDiscount_'+b_seq).val('100.00');
							}
                        });
                        
                        $('#txtProductno_' + j).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtDiscount_'+b_seq).val())&&(!emp($('#txtProductno_' + b_seq).val()) || !emp($('#txtUno_' + b_seq).val()))&&(q_cur==1 || q_cur==2)){
								$('#txtDiscount_'+b_seq).val('100.00');
							}
                        });
                        
                        $('#txtUnit_' + j).focusout(function() {
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
                        $('#txtWeight_' + j).focusout(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).focusout(function() {
                            sum();
                        });
                        $('#txtDiscount_' + j).focusout(function() {
                            sum();
                        });
                        
                        $('#btnRecord_' + j).click(function() {
                            var n = replaceAll($(this).attr('id'), 'btnRecord_', '');
                            q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";tgg=" + $('#txtTggno').val() + "&product=" + $('#txtProductno_' + n).val() + ";" + r_accy, 'z_vccstp', "95%", "95%", q_getMsg('popPrint'));
                        });
                        
                        $('#btnRecord2_' + j).click(function() {
                            var n = replaceAll($(this).attr('id'), 'btnRecord2_', '');
                            q_box("rc2tfe.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";rc2no='" + $('#txtNoa').val() + "' and rc2noq='" + $('#txtNoq_' + n).val() + "';" + r_accy, 'rc2tfe', "95%", "95%", q_getMsg('popPrint'));
                        });
                    }
                }
                _bbsAssign();
                HiddenTreat();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtCno').val(z_cno);
                $('#txtAcomp').val(z_acomp);
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#cmbTaxtype').val(1);
                var t_where = "where=^^ 1=1 ^^";
                q_gt('custaddr', t_where, 0, 0, 0, "");
            }
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
					return;
                Lock(1, {
                    opacity : 0
                });
                //產生guid,送簽核用
              	$('#btnModi').data('guid',guid());
              	
                var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi', r_accy);
            }

            function btnPrint() {
				q_box("z_rc2fep.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
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
                as['datea'] = abbm2['datea'];
                as['tggno'] = abbm2['tggno'];
                as['kind'] = abbm2['kind'];
                if (abbm2['storeno'])
                    as['storeno'] = abbm2['storeno'];
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
                if (isinvosystem)
                    $('.istax').hide();
                HiddenTreat();
            }

            function HiddenTreat(returnType){
                returnType = $.trim(returnType).toLowerCase();
                var hasStyle = q_getPara('sys.isstyle');
                var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
                var hasSpec = q_getPara('sys.isspec');
                var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
                var hasRackComp = q_getPara('sys.rack');
                var isRack = (hasRackComp.toString()=='1'?$('.isRack').show():$('.isRack').hide());
                if(returnType=='style'){
                    return (hasStyle.toString()=='1');
                }else if(returnType=='spec'){
                    return (hasSpec.toString()=='1');
                }else if(returnType=='rack'){
                    return (hasRackComp.toString()=='1');
                }
                
                if(q_getPara('sys.menu').substr(0,3)=='qfe')
                	$('.isFe').show()
                else
                	$('.isFe').hide()
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#combAddr').attr('disabled', 'disabled');
                } else {
                    $('#combAddr').removeAttr('disabled');
                }
                HiddenTreat();
                
                //限制帳款月份的輸入 只有在備註的第一個字為*才能手動輸入
                if ($('#txtMemo').val().substr(0,1)=='*')
                    $('#txtMon').removeAttr('readonly');
                else
                    $('#txtMon').attr('readonly', 'readonly');
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
                dataErr = !_q_appendData(t_Table);
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
                Lock(1, {
                    opacity : 0
                });
                var t_where = " where=^^ rc2no='" + $('#txtNoa').val() + "'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtTggno':
                        if (!emp($('#txtTggno').val())) {
                           // var t_where = "where=^^ noa='" + $('#txtTggno').val() + "' ^^";
                           // q_gt('custaddr', t_where, 0, 0, 0, "");
                        }
                        break;
                }
            }

            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }

            function calTax() {
                var t_money = 0, t_tax = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_money += q_float('txtTotal_' + j);
                }
                t_total = t_money;
                if (!isinvosystem) {
                    var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
                    switch ($('#cmbTaxtype').val()) {
                        case '0':
                            // 無
                            t_tax = 0;
                            t_total = q_add(t_money, t_tax);
                            break;
                        case '1':
                            // 應稅
                            t_tax = round(q_mul(t_money, t_taxrate), 0);
                            t_total = q_add(t_money, t_tax);
                            break;
                        case '2':
                            //零稅率
                            t_tax = 0;
                            t_total = q_add(t_money, t_tax);
                            break;
                        case '3':
                            // 內含
                            t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
                            t_total = t_money;
                            t_money = q_sub(t_total, t_tax);
                            break;
                        case '4':
                            // 免稅
                            t_tax = 0;
                            t_total = q_add(t_money, t_tax);
                            break;
                        case '5':
                            // 自定
                            $('#txtTax').attr('readonly', false);
                            $('#txtTax').css('background-color', 'white').css('color', 'black');
                            t_tax = round(q_float('txtTax'), 0);
                            t_total = q_add(t_money, t_tax);
                            break;
                        case '6':
                            // 作廢-清空資料
                            t_money = 0, t_tax = 0, t_total = 0;
                            break;
                        default:
                            break;
                    }
                }
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTax').val(FormatNumber(t_tax));
                $('#txtTotal').val(FormatNumber(t_total));
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
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.ime {
                ime-mode:disabled;
                -webkit-ime-mode: disabled;
                -moz-ime-mode:disabled;
                -o-ime-mode:disabled;
                -ms-ime-mode:disabled;
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
                font-size: medium;
            }
            .tbbm td {
                width: 9%;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }

        </style>
    </head>
    <body>
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden; width: 1270px;">
            <div class="dview" id="dview">
                <table class="tview" id="tview" >
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:5%"><a id='vewTypea'> </a></td>
                        <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:25%"><a id='vewNoa'> </a></td>
                        <td align="center" style="width:45%"><a id='vewTgg'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='noa'>~noa</td>
                        <td align="center" id='nick' style="text-align: left;">~nick</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm" id="tbbm" style="width: 872px;">
                    <tr class="tr1">
                        <td class="td1"><span> </span><a id='lblType' class="lbl"> </a></td>
                        <td class="td2">
                            <input id="txtType" type="text" style='display:none;'/>
                            <select id="cmbTypea" class="txt c1"> </select>
                        </td>
                        <td class="td5"><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td class="td6"><input id="txtDatea" type="text" class="txt c1 ime"/></td>
                        <td class="td7" ><span> </span><a id='lblMon' class="lbl"> </a></td>
                        <td class="td8"><input id="txtMon" type="text" class="txt c1"/></td>
                        
                    </tr>
                    <tr>
                   		<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
                        <td class="td2"><input id="txtCno" type="text" class="txt c1" /></td>
                        <td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr2">
                       <td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
                        <td><input id="txtTggno" type="text" class="txt c1" /></td>
                        <td colspan="2">
                        	<input id="txtComp" type="text" class="txt c1"/>
                        	<input id="txtNick" type="text" style="display:none;"/>
                    	</td>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td>
                        	<input id="txtNoa" type="text" class="txt c1"/>
                        </td>
                    </tr>
                    <tr class="tr3">
                        <td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
                        <td class="td2" colspan="3"><input id="txtTel" type="text" class="txt c1"/></td>
                        <td class="td7"><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
                        <td class="td8" colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr4">
                    	<td class="td1"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
                        <td class="td2" colspan='2'><input id="txtPaytype" type="text" class="txt c1"/></td>
                        <td class="td1"><select id="combPaytype" class="txt c1" onchange='cmbPaytype_chg()'> </select></td>
                       <td class="td4"><span> </span><a id='lblOrdc' class="lbl btn"> </a></td>
                       <td class="td5" colspan='2'><input id="txtOrdcno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr7">
                    	<td class="td1"><span> </span><a id='lblSales_fe' class="lbl btn"> </a></td>
                        <td class="td2"><input id="txtSalesno" type="text" class="txt c1"/></td>
                        <td class="td3"  colspan='2'><input id="txtSales" type="text" class="txt c1"/></td>
                    	<td class="td5"><span> </span><a id='lblDriver' class="lbl btn"> </a></td>
                        <td class="td6"><input id="txtDriverno" type="text" class="txt c1"/></td>
                        <td class="td7"><input id="txtDriver" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr7">
                    	<td class="td1"><span> </span><a id='lblCartrips' class="lbl"> </a></td>
                        <td class="td2"><input id="txtCartrips" type="text" class="txt c1 num"/></td>
                    	<td class="td3"><span> </span><a id='lblCarno' class="lbl"> </a></td>
                        <td class="td4"><input id="txtCarno" type="text" class="txt c1"/></td>
                    	 <td class="td6"><span> </span><a id='lblTranstart' class="lbl btn"> </a></td>
                        <td class="td7"><input id="txtTranstartno" type="text" class="txt c1"/></td>
                       <td class="td8"><input id="txtTranstart" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr9">
                        <td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
                        <td class="td2"><input id="txtMoney" type="text" class="txt num c1" /></td>
                        <td class="td4" ><span> </span><a id='lblTax' class="lbl"> </a></td>
                        <td class="td5" >
                            <input id="txtTax" type="text" class="txt num c1 istax" style="width: 49%;" />
                            <select id="cmbTaxtype" class="txt c1" style="width: 49%;" onchange="calTax();"> </select>
                        </td>
                        <td class="td7"><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
                        <td class="td8" colspan='2'><input id="txtTotal" type="text" class="txt num c1 istax" /></td>
                    </tr>
                    <tr style="display:none;">
                    	<td class="td1"><span> </span><a id='lblCoin' class="lbl"> </a></td>
                        <td class="td2" ><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
                        <td class="td1"><span> </span><a id='lblFloata' class="lbl"> </a></td>
                        <td class="td3" ><input id="txtFloata" type="text" class="txt num c1" /></td>
                        <td class="td4"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
                        <td class="td5" colspan='2'><input id="txtTotalus" type="text" class="txt num c1" /></td>
                    </tr>
                    <tr class="tr10">
                        <td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
                        <td class="td2" colspan='6' >
                            <input id="txtMemo" type="text" class="txt" style="width:98%;"/>
                        </td>
                    </tr>
                    <tr class="tr11">
                        <td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td class="td1"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td class="td3"><input id="txtWorker2" type="text" class="txt c1"/></td>
                        <td class="td4"><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
                        <td class="td5" colspan="2"><input id="txtAccno" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs' style="width: 1900px;">
            <table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
                <tr style='color:White; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:150px;"><a id='lblUno_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblProductno'> </a></td>
                    <td align="center" style="width:250px;"><a id='lblProduct'> </a></td>
                    <td align="center" style="width:95px;" class="isStyle"><a id='lblStyle'> </a></td>
                    <td align="center" style="width:80px;" class="isFe"><a id='lblLengthb_fe_s'> </a></td>
                    <td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblMount'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblPrices'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblTotals'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblDiscount_s'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblBrand_s'> </a></td>
                    <td align="center" style="width:40px;"><a id='lblCounta_s'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblStore_s'> </a></td>
                    <td align="center" style="width:80px;" class="isRack"><a id='lblRackno_s'> </a></td>
                    <td align="center" style="width:180px;"><a id='lblMemos'> </a></td>
                    <td align="center" style="width:40px;"><a id='lblRecord_s'> </a></td>
                    <td align="center" style="width:150px;"><a id='lblUno2s'> </a></td>
                    <td align="center" style="width:50px;"><a>客戶<BR>出貨</a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                        <input id="txtNoq.*" type="text" style="display:none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="txtUno.*" type="text" class="txt c1"/></td>
                    <td>
                        
                        <input id="txtProductno.*" type="text" class="txt c1"/>      
                        <input class="btn"  id="btnProduct.*" type="button" style="display:none;" />             
                    </td>
                    <td>
                        <input type="text" id="txtProduct.*" class="txt c1"/>
                        <input type="text" id="txtSpec.*" class="txt c1 isSpec"/>
                    </td>
                    <td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1 isStyle"/></td>
                    <td class="isFe"><input id="txtLengthb.*" type="text" class="txt c1 num isFe"/></td>
                    <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtTotal.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtDiscount.*" type="text" class="txt num c1" /></td>
                    <td><input id="txtBrand.*" type="text" class="txt c1" /></td>
                    <td><input id="txtCounta.*" type="text" class="txt num c1" /></td>
                    <td>
                        <input id="txtStoreno.*" type="text" class="txt c1"/>
                        <input class="btn" id="btnStore.*" type="button" style="display:none;" />
                        <input id="txtStore.*" type="text" class="txt c1"/>
                    </td>
                    <td class="isRack">
                        <input class="btn" id="btnRackno.*" type="button" value='.' style="float:left;" />
                        <input id="txtRackno.*" type="text" class="txt c1 isRack" style="width: 65%"/>
                    </td>
                    <td>
                        <input id="txtMemo.*" type="text" class="txt c1"/>
                        <input id="txtOrdeno.*" type="text" class="txt" style="width:65%;" />
                        <input id="txtNo2.*" type="text" class="txt" style="width:25%;" />
                        <input id="recno.*" style="display:none;"/>
                    </td>
                    <td align="center">
                        <input class="btn" id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" />
                    </td>
                    <td><input id="txtUno2.*" type="text" class="txt c1"/></td>
                    <td align="center">
                        <input class="btn" id="btnRecord2.*" type="button" value='.' style=" font-weight: bold;" />
                    </td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>