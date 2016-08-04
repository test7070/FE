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
			
			var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'totalus'];
			var decbbs = ['price', 'weight', 'mount', 'total', 'dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
			var decbbt = [];
			var q_readonly = ['txtNoa','txtWorker', 'txtComp', 'txtSales', 'txtWorker2','txtApv', 'txtMoney', 'txtTotal', 'txtWeight'];
			var q_readonlys = ['txtNo3'];
			var q_readonlyt = ['txtMemo','txtMemo2'];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 11;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,paytype,trantype,tel,fax,zip_comp,addr_fact', 'txtCustno,txtComp,txtNick,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
				, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				bbtKey = ['noa', 'noq'];
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
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1]];
				bbsNum = [['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1],['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1], ['txtTotal', 15, 0, 1]];
				
				//q_cmbParse("cmbStype", q_getPara('vcc.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				var t_where = "where=^^ 1=1 ^^";
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
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
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
				$('#c1_1_a').change(function(e){
					refreshData();
				});
				$('#c2_1').change(function(e){
					refreshData();
				});
				$('#c6_1').change(function(e){
					refreshData();
				});
				
			}

			function q_boxClose(s2) {
				var
				ret;
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
						if(cobj.eq(i)[0].nodeName == 'BR'){
							string += '\n';
						}else if(!cobj.eq(i).is(":visible")){
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
				for(var i=0;i<q_bbtCount;i++){
					$('#btnMinut__'+i).click();
				}
				var obj=$('#divCC').find('input,select');
				for(var i=0;i<obj.length;i++){
					if(q_bbtCount<i){
						$('#btnPlut').click();
					}
					$('#txtKeya__'+i).val(obj.eq(i).attr('id'));
					$('#txtValue__'+i).val(obj.eq(i).val());
				}
				//MEMO2
				var memo2 = '';
				var obj = $('#divCC').find('tr');
				var string = '';
				for(var i=0;i<obj.length;i++){
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
                            	var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
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

				var t_where = "where=^^ 1=1 ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
					return;
				_btnModi();
				$('#txtProduct').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
				q_box("z_quatfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'quat', "95%", "95%", m_print);
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
			
			function refreshData(){
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
			}
			
			function refresh(recno) {
				_refresh(recno);
				//init then  load
				refreshData();
				var obj = $('#divCC').find('input');
				for(var i=0;i<obj.length;i++){
					obj.eq(i).val('');
				}
				var obj = $('#divCC').find('select');
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
					
					$('#divCC').find('input,select').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
					$('#combPaytype').removeAttr('disabled');
					
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
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
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
                        <td class="tdZ"></td>
                    </tr>
					<tr>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
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
						<td align="right">
							<span> </span><a id='lblMemo' class="lbl"> </a>
						</td>
						<td colspan='6' >
							<textarea id="txtMemo" class="txt c1" rows="7"> </textarea>
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
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:40px;"><a id='lblNo3_s'> </a></td>
					<td align="center" style="width:250px;"><a>單名</a></td>
					<td align="center" style="width:250px;"><a>規格</a></td>
					<td align="center" style="width:40px;"><a>單位</a></td>
					<td align="center" style="width:100px;"><a>數量</a></td>
					<td align="center" style="width:100px;"><a>重量</a></td>
					<td align="center" style="width:100px;"><a>單價</a></td>
					<td align="center" style="width:100px;"><a>金額</a></td>
					<td align="center" style="width:150px;"><a>備註</a></td>
					<td align="center" style="width:40px;"><a>結案</a></td>
					<td align="center" style="width:40px;"><a>取消</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="txtNo3.*" type="text" class="txt" style="float:left;width:95%;"/></td>
					<td align="center">
						<input id="txtProductno.*" type="text" class="txt" style="float:left;width:35%;"/>
						<input id="txtProduct.*" type="text" class="txt" style="float:left;width:60%;"/>
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
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />

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
				<tr><td><a>4.</a><a>以賣方實際過磅為準，若磅差超出千分之三時買方得要求公證地磅會磅，千分之三內買方</a></td></tr>
				<tr><td><a>　不得扣失重，若超出千分之三以上，雙方各半。</a></td></tr>
				<tr>
					<td>
						<a>5.</a><a>交貨辦法：</a>
					</td>
				</tr>
				<tr id="c5_1_a">
					<td>
						<a>　</a><a>(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="c5_1_a_a"/><a>，</a>
						<select id="c5_1_a_b"><option value='買方'>買方</option><option value='賣方'>賣方</option></select>
						<a>負責卸貨。</a>
						<br>
						<a>　　　出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="c5_1_a_c"/><a>元。</a>
					</td>
				</tr>
				<tr id="c5_1_b">
					<td>
						<a>　</a><a>(1)</a>
						<a>板車送達</a><input type="text" style="width:200px;" id="c5_1_b_a"/><a>，每噸</a><input type="text" style="width:60px;" id="c5_1_b_b"/><a>元。</a>
						<a>買方負責卸貨。</a>
						<br>
						<a>　 　出貨須達25噸，未達25噸者須補貼運費至25噸，每噸</a><input type="text" style="width:60px;" id="c5_1_b_c"/><a>元。</a>
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
						<a>買方工地向賣方訂貨後，如遇天災或人力不可抗力之因素時，由雙方再議定交貨時間，</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 經賣方同意展期外，買方應按訂貨數量交貨。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　</a><a>(4)</a>
						<a>買方應備妥足夠容納進貨之場地，及35噸拖車可安全到達之卸貨場地，否則因而產生的其他費用 </a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 由買方負擔。 </a>
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
						<a>　</a><a>(2)</a><a>買方同意依照合約所定之付款日期及方式繳付價款予賣方，如逾期未付則按總價款</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 之日息萬分之六計算遲延付款之利息，賣方並得據以暫停出貨。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>7.</a><a>材料檢驗：</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　(1)</a><a>賣方鋼筋出廠毎批均附鋼筋無輻射證明，買方需要檢驗報告時依CNS560規範執行。</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　(2)</a><a>鋼筋未經送驗合格前，不得加工及使用，否則所衍費用由買方自行吸收，且該批鋼筋不得辦理</a>
					</td>
				</tr>
				<tr>
					<td>
						<a>　　 退貨。</a>
					</td>
				</tr>
          		<tr>
					<td>
						<a>8.</a><a>特約事項：賣方所提供材料於買方各期貨款支付或票據兌現前賣方仍保有所有權。</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<a>9.</a><a>報價時效：本報價期限至</a><input type="text" style="width:200px;" id="c6_9_1"/><a>止為有效報價日。</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<a>10.</a><a>本報價單蓋公司大小章回傳視同訂購。</a>
					</td>
				</tr>
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
						<td style="width:200px; text-align: center;">備註2</td>
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
