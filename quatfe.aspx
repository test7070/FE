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
			q_tables = 's';
			var q_name = "quat";
			var decbbs = ['price', 'weight', 'mount', 'total', 'dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
			var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'totalus'];
			var q_readonly = ['txtNoa','txtWorker', 'txtComp', 'txtSales', 'txtWorker2','txtApv', 'txtMoney', 'txtTotal', 'txtWeight'];
			var q_readonlys = ['txtNo3'];
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
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,paytype,trantype,tel,fax,zip_comp,addr_fact', 'txtCustno,txtComp,txtNick,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
				, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
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
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				bbmNum = [['txtMoney', 15, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1], ['txtFloata', 15, 3, 1]];
				bbsNum = [['txtMount', 10, q_getPara('vcc.mountPrecision'), 1], ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1], ['txtTotal', 15, 0, 1]];
				
				q_cmbParse("cmbStype", q_getPara('vcc.stype'));
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
				
				$('#btnMemo').click(function(e){
					var t_string='1. （1）本報價單價不含5%稅金。 (含/不含) 運費、  (含/不含) 磅費、  (含/不含) 檢驗費。';
					t_string += '\n   （2）馬架10CM以下，圓型特殊框型不在此單價內。';
					t_string += '\n   （3）本報價單不含至續接廠運輸費用。';
					t_string += '\n   （4）加工成型部份為不分板料、彎料、直料。';
					t_string += '\n   （5）加工成型部份尺寸公差為±5公分。此單價不含裁切長度70CM以下直料。';
					t_string += '\n2. 交貨地點：(廠交/自運/XX工地)。 交貨期限： 年 月 日止。';
					t_string += '\n3. 工程名稱：。';
					t_string += '\n4. 鋼筋計價重量：以賣方實際過磅為準，若磅差超出千分之三時買方得要求公證地磅會磅，千分之三';
					t_string += '\n   內買方不得扣失重，若超出千分之三以上，雙方各半。;' ;   
                 	t_string += '\n5. 交貨辦法：（1）(A：板車送達 XX工地，買方負責卸貨。出貨須達25噸，未達25';
                 	t_string += '\n   噸者須補貼運費至25噸，每噸 XXX元。)';
                 	t_string += '\n   (B：吊車送達 XX工地，賣方負責卸貨。出貨需達10噸，未達10';
                 	t_string += '\n   噸者須補貼運費至10噸，每噸 XXX元。)';
                 	t_string += '\n  C：吊車送達高雄市(工地手KEY)工地，限一趟(手KEY)運輸以內，賣方負責卸貨。';
                 	t_string += '\n';
/*5.	交貨辦法：（1）
             1.當上面第一大項第一點如勾選含運費時
             選項A：板車送達高雄市(工地手KEY)工地，買方負責卸貨。出貨須達25噸，未達25
                     噸者須補貼運費至25噸，每噸200(手KEY)元。
             選項B：吊車送達高雄市(工地手KEY)工地，賣方負責卸貨。出貨需達10噸，未達10
                     噸者須補貼運費至10噸，每噸200(手KEY)元。
             選項C：吊車送達高雄市(工地手KEY)工地，限一趟(手KEY)運輸以內，賣方負責卸貨。
             2.當上面第一大項第一點如勾選不含運費時                     
             選項A：板車送達高雄市(工地手KEY)工地，每噸200(手KEY)元，買方負責卸貨。出貨
                     須達25噸，未達25噸者須補貼運費至25噸，每噸200(手KEY)元。 
             選項B：吊車送達高雄市(工地手KEY)工地，每噸200(手KEY)元，賣方負責卸貨。出貨
                     需達10噸，未達10噸者須補貼運費至10噸，每噸200(手KEY)元。
             選項C：吊車送達高雄市(工地手KEY)工地，每趟3000(手KEY)元。*/
				



					
					t_string += '\n';
					$('#txtMemo').attr('value',t_string);
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

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCust')], ['txtOdate', q_getMsg('lblOdate')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
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
				sum();
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
					
				//只要修改都會重新送簽核，將核准變回N
				if(q_getPara('sys.project').toUpperCase()=='XY'){
					$('#txtApv').val('N');
				}

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
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
                            var n = $(this).attr('id').replace('txtProductno_', '');
                            $('#btnProduct_' + n).click();
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

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
					$('#combPaytype').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
					$('#combPaytype').removeAttr('disabled');
				}
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
                width: 1200px;
            }
            .tbbs a {
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
		<div id='dmain'>
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
						<td> </td>
						<td><select id="cmbStype" class="txt c1"></select></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><input id="chkIsproj" type="checkbox"/><span> </span><a id='lblIsproj'> </a></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'></select></td>
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
						<td align="right">
							<span> </span><a id='lblMemo' class="lbl"> </a>
						</td>
						<td colspan='6' >
							<textarea id="txtMemo" class="txt c1" rows="7"> </textarea>
						</td>
						<td>
							<input type="button" id="btnMemo" value="鋼筋報價" style="display:none;" />
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
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:40px;"><a id='lblNo3_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProductno'> </a></td>
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
						<input id="txtProductno.*" type="text" class="txt" style="float:left;width:35%;"/>
						<input id="txtProduct.*" type="text" class="txt" style="float:left;width:60%;"/>
						<input id="btnProduct.*" type="button" style="display:none;" />
					</td>
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
	</body>
</html>
