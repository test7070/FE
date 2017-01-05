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
			q_tables = 's';
			var q_name = "ucce";
			var q_readonly = ['txtNoa','txtStore'];
			var q_readonlys = ['txtStore','txtAdjmount'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
				['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'],
				['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
				['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,product,unit', 'txtUno_,txtProductno_,txtProduct_,txtUnit_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%'],
				['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				brwCount2 = 2;
				q_bbsLen = 15;
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
				bbsNum = [['txtMount', 10, q_getPara('rc2.mountPrecision'), 1], ['txtWeight', 10, q_getPara('rc2.weightPrecision'), 1], ['txtLengthb', 10, 2, 1]
								,['txtEmount2', 10, q_getPara('rc2.mountPrecision'), 1], ['txtEweight2', 10, q_getPara('rc2.weightPrecision'), 1],['txtAdjmount', 10, q_getPara('rc2.mountPrecision'), 1]
								,['txtPrice', 10, q_getPara('rc2.pricePrecision'), 1], ['txtTotal', 15, 0, 1]];
				q_cmbParse("cmbKind", q_getPara('ucce.kind'));
				$('#cmbKind').change(function() {
					for (var j = 0; j < q_bbsCount; j++) {
						btnMinus('btnMinus_' + j);
					}
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
			function q_popPost(id) {
                switch (id) {
                	case 'txtProductno_':
                		var n = b_seq;
                		getWeight(n);
                		break;
                    default:
                        break;
                }
            }
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						if(t_name.substring(0,10)=='getWeight_'){
							var n = t_name.replace('getWeight_','');
							var as = _q_appendData("ucc", "", true);
							if(as[0]!=undefined){
								var t_mount = q_float('txtMount_'+n);
								var t_weight = as[0].uweight;
								$('#txtWeight_'+n).val(round(q_mul(t_weight,t_mount),2));
							}
						}
				}
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_storeno = $.trim($('#txtStoreno').val());
				var t_store = $.trim($('#txtStore').val());
				for(var k=0;k<q_bbsCount;k++){
					var bbsStoreno = $.trim($('#txtStoreno_'+k).val());
					if(bbsStoreno.length == 0){
						$('#txtStoreno_'+k).val(t_storeno);
						$('#txtStore_'+k).val(t_store);
					}
				}
				$('#txtWorker').val(r_name);
				//sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ucce') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('uccefe_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
<<<<<<< HEAD
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
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtAdjmount_' + b_seq, q_sub(q_float('txtMount_' + b_seq), q_float('txtEmount2_' + b_seq)));
						});
						$('#txtEmount2_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtAdjmount_' + b_seq, q_sub(q_float('txtMount_' + b_seq), q_float('txtEmount2_' + b_seq)));
						});
						
					}
=======
					if ($('#btnMinus_' + j).hasClass('isAssign'))
						continue;
					$('#txtProductno_' + j).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_' + n).click();
                    });
                    $('#txtStoreno_' + j).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStore_' + n).click();
                    });
					$('#txtMount_' + j).change(function() {
						var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
						getWeight(n);
					});
					
>>>>>>> 4779d6609236e37b5657bac0a5618c8bf438c507
				}
				_bbsAssign();
				if (q_getPara('sys.project').toUpperCase()!='FE'){
					$('.fe').hide();
				}else{
					$('.unfe').hide();
				}
			}
			function getWeight(n){
				var t_productno = $.trim($('#txtProductno_'+n).val());
				if(t_productno.length>0)
					q_gt('ucc', "where=^^ noa='"+t_productno+"'^^", 0, 0, 0, 'getWeight_'+n); 
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#cmbKind').val(1);
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
			}

			function btnPrint() {
				q_box('z_uccefep.aspx'+ "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] ) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
			}

			function sum() {
				/*var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					q_tr('txtAdjmount_' + j, q_sub(q_float('txtMount_' + j),q_float('txtEmount2_' + j)));
				}*/

			}

			function refresh(recno) {
				_refresh(recno);
				if (q_getPara('sys.project').toUpperCase()!='FE'){
					$('.fe').hide();
				}else{
					$('.unfe').hide();
				}
				
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				//sum();
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
            #dmain {
                overflow: visible;
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
                width: 70%;
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
            .txt.c2 {
                width: 130%;
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
                width: 1250px;
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
                width: 1200px;
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
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
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
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class='td2'><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class='td4'><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td5' style="display: none;"><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td class='td6' style="display: none;"><select id="cmbKind" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblStoreno" class="lbl btn"> </a></td>
						<td class='td2' colspan="2">
							<input id="txtStoreno" type="text" class="txt" style="width:30%"/>
							<input id="txtStore" type="text" class="txt" style="width:65%"/>
						</td>
						<td class='td2' colspan="3" style="color: red;">同一產品，所有倉庫 要同一日 盤點完畢</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
					<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:80px;"><a id='lblStoreno_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:80px;" class="fe"><a id='lblLengthb_fe_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblEmount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblEweight_s'> </a></td>
					<td align="center" style="width:80px;" class="unfe"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;" class="unfe"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					<!--<td align="center" style="width:80px;"><a id='lblEmount2_s'> </a></td>-->
					<!--<td align="center" style="width:80px;"><a id='lblEweight2_s'> </a></td>-->
					<!--<td align="center" style="width:80px;"><a id='lblAdjmount_s'> </a></td>-->
					<td align="center" style="width:150px;"><a id='lblUno_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtStoreno.*" type="text" style="width:95%;"/>
						<input id="txtStore.*" type="text" style="width:95%;"/>
						<input id="btnStore.*" type="button" style="display:none;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width:95%;"/>
						<input id="txtProduct.*" type="text" style="width:95%;"/>
						<input id="btnProduct.*" type="button" style="display:none;" />
					</td>
					<td class="fe"><input id="txtLengthb.*" type="text" class="txt c1 num fe" style="width:95%;"/></td>
					<td><input class="txt c1" id="txtUnit.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num c1" id="txtMount.*" type="text" style="width:95%;"/></td>
					<td><input class="txt num c1" id="txtWeight.*" type="text" style="width:95%;"/></td>
					<td class="unfe"><input class="txt num c1 unfe" id="txtPrice.*" type="text" /></td>
					<td class="unfe"><input class="txt num c1 unfe" id="txtTotal.*" type="text" /></td>
					<td>
						<input class="txt c1" id="txtMemo.*"type="text" style="width:95%;"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
					<!--<td><input class="txt num c1" id="txtEmount2.*" type="text" style="width:95%;"/></td>-->
					<!--<td><input class="txt num c1" id="txtEweight2.*" type="text" style="width:95%;"/></td>-->
					<!--<td><input class="txt num c1" id="txtAdjmount.*" type="text" style="width:95%;"/></td>-->
					<td><input class="txt c1" id="txtUno.*" type="text" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
