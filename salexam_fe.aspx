<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title>考核主檔</title>
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
            q_tables = 's';
            var q_name = "salexam";
            var q_readonly = ['txtNoa','txtWorker', 'txtWorker2', 'txtTotal'];
            var q_readonlys = ['txtTotal'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';

            aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']);
            q_desc = 1;

            function sum() {
                
                for (var i = 0; i < q_bbsCount; i++) {
					$('#txtTotal_'+i).val(q_float('txtEfficiency_'+i)*q_float('txtWorkdegree_'+i));
                }
            }

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '');
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
                
                $('#btnImportBase').click(function(e){
                	var t_typea = $.trim($('#txtTypea').val());
                	var t_where = "where=^^ typea='"+t_typea+"' ^^";
                	q_gt('salexambase', t_where, 0, 0, 0, "import", r_accy);
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

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'import':
                		var a = _q_appendData("salexambase", "", true);
                		var as = _q_appendData("salexambases", "", true);
						
						for(var i=0;i<q_bbsCount;i++){
							$('#btnMinus_'+i).click();
						}
						
						while(q_bbsCount<as.length)
							$('#btnPlus').click();
						
						for(var i=0;i<as.length;i++){
							for(var j=0;j<a.length;j++){
								if(as[i].noa == a[j].noa){
									$('#txtPart_'+i).val(a[j].description);
									break;
								}
							}
							$('#txtJobno_'+i).val(as[i].noa);
							$('#txtJob_'+i).val(as[i].noq);
							$('#txtNamea_'+i).val(as[i].description);
							$('#txtWorkdegree_'+i).val(as[i].weight);
						}
						sum();
						//console.log(a);
						//console.log(as);
						break;
               		case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function btnOk() {
                var t_date = $.trim($('#txtDatea').val());
                if(t_date.length==0 || !q_cd(t_date)){
                	alert('日期異常');
                	return;
                }
                sum();

                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);

                var t_noa = $.trim($('txtNoa').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_salexam') + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;

                q_box('salexam_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))
                        continue;
                    $('#txtEfficiency_' + i).change(function() {
                        sum();
                    });
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
                $('#txtMemo').focus();
            }

            function btnPrint() {
                q_box('z_salexam.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['namea']) {
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
                    $('#txtDatea').datepicker('destroy');
                } else {
                    $('#txtDatea').datepicker();
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
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
		</script>
		<style type="text/css">
			#dmain {
				overflow: auto;
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
				width: 630px;
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
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
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
				width: 1600px;
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
			.font1 {
				font-family: "細明體", Arial, sans-serif;
			}
			#tableTranordet tr td input[type="text"]{
				width:80px;
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
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a>類型</a></td>
						<td align="center" style="width:120px; color:black;"><a>員工編號</a></td>
						<td align="center" style="width:80px; color:black;"><a>員工姓名</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='typea' style="text-align: center;">~typea</td>
						<td id='sssno' style="text-align: center;">~sssno</td>
						<td id='sss' style="text-align: center;">~sss</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input type="text" id="txtNoa" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><input type="text" id="txtTypea" list="listType" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSss" class="lbl btn">員工</a></td>
						<td colspan="3">
							<input type="text" id="txtSssno" class="txt" style="width:40%;float: left; " />
							<input type="text" id="txtSss" class="txt" style="width:60%;float: left; " />
						</td>
						<td> </td>
						<td><input type="button" id="btnImportBase" value="匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
							<textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>

					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a class="lbl">總分</a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:200px"><a>大項</a></td>
					<td align="center" style="width:200px"><a>評核項目</a></td>
					<td align="center" style="width:80px"><a>評分(0-5)</a></td>
					<td align="center" style="width:80px"><a>權重</a></td>
					<td align="center" style="width:80px"><a>分數</a></td>
					<td align="center" style="width:200px"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtPart.*" style="width:95%;" /> </td>
					<td>
						<input type="text" id="txtNamea.*" style="width:95%;" />
						<input type="text" id="txtJobno.*" style="display:none;" /> 
						<input type="text" id="txtJob.*" style="display:none;" /> 
					</td>
					<td><input type="text" id="txtEfficiency.*" class="num" style="width:95%;" /> </td>
					<td><input type="text" id="txtWorkdegree.*" class="num" style="width:95%;" /> </td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;" /></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
		<datalist id="listType">
        	<option value="內勤"> </option>
        	<option value="廠務"> </option>
        </datalist>
		<input id="q_sys" type="hidden" />
	</body>
</html>
