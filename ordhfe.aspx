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
			q_desc = 1;
			q_tables = 's';
			var q_name = "ordh";
			var q_readonly = ['txtTgg', 'txtNoa', 'txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtNoq','txtOrdeno','txtNo2'];
			var q_readonlyt = [];

			var bbmNum = [
				['txtMoney', 10, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 10, 0, 1]
			];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 10;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Odate';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,tel,fax', 'txtTggno,txtTgg,txtNick,txtTel,txtFax', 'tgg_b.aspx']
				, ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t_money = 0;
				var t_moneys,t_unit,t_count,t_price;
				for(var i=0;i<q_bbsCount;i++){
					t_unit = $.trim($('#txtUnit_'+i).val()).toUpperCase();
					t_count = t_unit.length==0 || t_unit == 'KG' || t_unit == '公斤' ? q_float('txtWeight_'+i):q_float('txtMount_'+i);
					t_moneys = round(q_mul(t_count,q_float('txtPrice_'+i)),0);
					t_money += t_moneys;
					$('#txtMoney_'+i).val(t_moneys);
				}
				$('#txtMoney').val(t_money);
				calTax();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtIndate', r_picd]];
				bbsMask = [['txtIndate', r_picd]];
				bbsNum = [['txtMount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtWeight', 10, q_getPara('rc2.weightPrecision'), 1], ['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1], ['txtMoney', 10, 0, 1]];
				q_mask(bbmMask);
				q_cmbParse("combPaytype", q_getPara('rc2.paytype'),'s');
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				
				$('#cmbTaxtype').change(function(e){
					sum();
				}).click(function(e){
					if(q_cur==1 || q_cur==2)
						sum();
				});
				
				$('#btnImportOrdh').click(function(e){
					if(!(q_cur==1 || q_cur==2))
						return;
					var t_noa = $('#txtNoa').val();
                	var t_where ='';
                	q_box("ordhfe_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({ordhno:t_noa,para:'ordhfe'}), "import_ordhfe", "95%", "95%", '');
                });
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'import_ordhfe':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtTablea,txtTableaccy,txtOrdeno,txtNo2,txtProductno,txtProduct,txtLengthb,txtUnit,txtMount,txtWeight,txtPrice,txtEmount,txtEweight'
                        	, as.length, as, 'tablea,tableaccy,noa,noq,productno,product,lengthb,unit,emount,eweight,price,emount,eweight', '','');
                        }else{
                        }
                        sum();
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				sum();
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				var s1 = $('#txtNoa').val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordh') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordhfe_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
				    $('#lblNo_'+j).text(j+1);
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
						$("#combPaytype_"+j).change(function(e) {
							var n = $(this).attr('id').replace('combPaytype_','');
		                    if (q_cur == 1 || q_cur == 2)
		                        $('#txtPaytype_'+n).val($('#combPaytype_'+n).find(":selected").text());
		                });
					}
				}
				_bbsAssign();
			}
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
			}

			function btnPrint() {
				q_box("z_ordhfep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'ordhfe', "95%", "95%", m_print);
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
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
                    $('#btnImportOrdh').attr('disabled','disabled');
                } else {	
                    $('#btnImportOrdh').removeAttr('disabled');
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
			function btnPlut(org_htm, dest_tag, afield) {
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
			function q_popPost(s1) {
				switch (s1) {
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
                width: 400px; 
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
                width: 600px;
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
                width: 19%;
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
                width: 1400px;
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
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >   
        <div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
            <table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
                <tr>
                    <td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
                </tr>
                <tr>
                    <td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
                </tr>
            </table>
        </div>

        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:150px; color:black;"><a id='vewIndate'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" /></td>
                        <td style="text-align: center;" id='nick'>~nick</td>
                        <td style="text-align: left;" id='datea'>~datea</td>
                        <td style="text-align: left;" id='indate'>~indate</td>
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
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td colspan="2"><input id="txtNoa" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
                        <td colspan="2">
                        	<input id="txtCno" type="text" class="txt" style="width:40%;"/>
                        	<input id="txtAcomp" type="text" class="txt" style="width:60%;"/>
                    	</td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblTgg' class="lbl"> </a></td>
                        <td colspan="2">
                        	<input id="txtTggno" type="text" class="txt" style="width:40%;"/>
                        	<input id="txtTgg" type="text" class="txt" style="width:60%;"/>
                        	<input id="txtNick" type="text" class="txt" style="display:none;"/>
                    	</td>
                        <td><span> </span><a id='lblIndate' class="lbl"> </a></td>
                        <td><input id="txtIndate" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblTel' class="lbl"> </a></td>
                        <td colspan="2"><input id="txtTel" type="text" class="txt c1" /></td>
                        <td><span> </span><a id='lblDaya' class="lbl"> </a></td>
                        <td><input id="txtDaya" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblFax' class="lbl"> </a></td>
                        <td colspan="2"><input id="txtFax" type="text" class="txt c1" /></td>
                    	<td><span> </span><a id='lblEnda' class="lbl"> </a></td>
                    	<td>
                    		<input id="chkEnda" type="checkbox"/>
                    		<span> </span><a id='lblCancel'> </a>
							<input id="chkCancel" type="checkbox"/>
                    	</td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
                        <td><input id="txtMoney" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblTax' class="lbl"> </a></td>
                        <td><input id="txtTax" type="text" class="txt c1 num" /></td>
                        <td><select id="cmbTaxtype" class="txt c1" > </select></td>
                        <td> </td>
						<td><input type="button" id='btnImportOrdh' class="txt c1" value="訂單匯入"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
                    	<td colspan="4"><textarea id="txtMemo" type="text" class="txt c1" rows="3"></textarea></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
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
                    <td align="center" style="width:40px;"><a id='lblYn_s'>決</a></td>
                    <td align="center" style="width:80px;"><a id='lblComp_s'>廠商名稱</a></td>
                    <td align="center" style="width:80px;"><a id='lblBrand_s'>廠牌</a></td>
                    <td align="center" style="width:280px;"><a id='lblProduct_s'>物品</a></td>
                    <td align="center" style="width:80px;"><a id='lblLengthb_s'>米</a></td>
                    <td align="center" style="width:80px;"><a id='lblUnit_s'>單位</a></td>
                    <td align="center" style="width:80px;"><a id='lblMount_s'>預定數量</a></td>
                    <td align="center" style="width:80px;"><a id='lblWeight_s'>預定重量</a></td>
                    <td align="center" style="width:80px;"><a id='lblPrice_s'>單價</a></td>
                    <td align="center" style="width:80px;"><a id='lblMoney_s'>金額</a></td>
                    <td align="center" style="width:100px;"><a id='lblMemo_s'>備註</a></td>
                    <td align="center" style="width:100px;"><a id='lblIndate_s'>交貨日期</a></td>
                    <td align="center" style="width:150px;"><a id='lblPaytype_s'>付款方式</a></td>
                    <td align="center" style="width:140px;"><a>訂單</a></td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    
                    <td><input type="checkbox" id="chkYn.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtComp.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtBrand.*" style="width:95%;"/></td>
					<td>
						<input type="button" id="btnProduct.*" style="display:none;"/>
                  		<input type="text" id="txtProductno.*" style="width:80px;float:left;"/>
          				<input type="text" id="txtProduct.*" style="width:160px;float:left;"/>
          			</td>
                    <td><input type="text" id="txtLengthb.*" style="width:95%;text-align:right;"/></td>
                    <td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtMount.*" style="width:95%;text-align:right;"/></td>
                    <td><input type="text" id="txtWeight.*" style="width:95%;text-align:right;"/></td>
              		<td><input type="text" id="txtPrice.*" style="width:95%;text-align:right;"/></td>
              		<td><input type="text" id="txtMoney.*" style="width:95%;text-align:right;"/></td>
                	<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
                	<td><input type="text" id="txtIndate.*" style="width:95%;"/></td>
                	<td>
                		<input type="text" id="txtPaytype.*" style="width:120px;float:left;"/>
                		<select id="combPaytype.*" style="width:15px;float:left;"></select>
            		</td>
            		<td>
						<input class="txt" id="txtTablea.*" type="text" style="display:none;"/>
						<input class="txt" id="txtTableaccy.*" type="text" style="display:none;"/>
						<input class="txt" id="txtOrdeno.*" type="text" style="width:75%;float:left;"/>
						<input class="txt" id="txtNo2.*" type="text" style="width:20%;float:left;"/>
					</td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>