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
            q_tables = 's';
            var q_name = "salaryfe";
            var decbbs = [];
            var decbbm = [];
            var q_readonly = ['txtNoa','txtSales','txtWorker','txtWorker2','txtTotal'];
            var q_readonlys = ['txtNoq'];
            var bbmNum = [['txtTotal',10,0,1],['txtBase',10,0,1]
            	,['txtAllowance01',10,0,1],['txtAllowance02',10,0,1],['txtAllowance03',10,0,1],['txtAllowance04',10,0,1],['txtAllowance05',10,0,1],['txtAllowance06',10,0,1]
            	,['txtAllowance07',10,0,1],['txtAllowance08',10,0,1],['txtAllowance09',10,0,1],['txtAllowance10',10,0,1],['txtAllowance11',10,0,1],['txtAllowance12',10,0,1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            aPop = new Array(['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
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

            function sum() {
            	if(!(q_cur=='1' || q_cur=='2')){
            		return;
            	}
            	var total = q_float('txtBase')
              	+q_float('txtAllowance01')+q_float('txtAllowance02')+q_float('txtAllowance03')
              	+q_float('txtAllowance04')+q_float('txtAllowance05')+q_float('txtAllowance06')
              	+q_float('txtAllowance07')+q_float('txtAllowance08')+q_float('txtAllowance09')
              	+q_float('txtAllowance10')+q_float('txtAllowance11')+q_float('txtAllowance12');
              	$('#txtTotal').val(FormatNumber(total));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
                
                $('#txtBase').change(function(e){
                	sum();
                });
                $('#txtAllowance01').change(function(e){
                	sum();
                });
             	$('#txtAllowance02').change(function(e){
                	sum();
                });
                $('#txtAllowance03').change(function(e){
                	sum();
                });
                $('#txtAllowance04').change(function(e){
                	sum();
                });
                $('#txtAllowance05').change(function(e){
                	sum();
                });
                $('#txtAllowance06').change(function(e){
                	sum();
                });
                $('#txtAllowance07').change(function(e){
                	sum();
                });
                $('#txtAllowance08').change(function(e){
                	sum();
                });
                $('#txtAllowance09').change(function(e){
                	sum();
                });
                $('#txtAllowance10').change(function(e){
                	sum();
                });
                $('#txtAllowance11').change(function(e){
                	sum();
                });
                $('#txtAllowance12').change(function(e){
                	sum();
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                     	break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            
            function btnOk() {

                sum();
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                
				var s1 = $('#txtNoa').val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtMon').val(), '/', ''));
                else
                    wrServer(s1);
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                       break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('salaryfe_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < (q_bbsCount == 0 ? 1 : q_bbsCount); i++) {
                	$('#lblNo_'+i).text(i+1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))
						continue;
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
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
                _btnModi();
            }

            function btnPrint() {
				//q_box("z_rc2fep.aspx?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['vccno'] && !as['vccnoq']) {
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
                /*if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                } else {	
                    $('#txtDatea').datepicker();
                }*/
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

        </script>
        <style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				width: 500px;
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
				width: 1200px;
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
			#dbbt {
				width: 400px;
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
        <div id='dmain'>
            <div class="dview" id="dview">
                <table class="tview" id="tview" >
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td style="display:none;">noa</td>
                        <td align="center" style="width:20%"><a id='vewMon'>月份</a></td>
                        <td style="display:none;">salesno</td>
                        <td align="center" style="width:20%"><a id='vewSales'>業務</a></td>
                        <td align="center" style="width:20%"><a id='vewTotal'>薪資</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td style="display:none;" id='noa'>~noa</td>
                        <td align="center" id='mon'>~mon</td>
                        <td style="display:none;" id='salesno'>~salesno</td>
                        <td align="center" id='sales'>~sales</td>
                        <td align="center" id='total'>~total</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm" id="tbbm">
                	<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl">電腦編號</a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblMon' class="lbl">月份</a></td>
                        <td><input id="txtMon" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblSales' class="lbl">業務</a></td>
                        <td><input id="txtSalesno" type="text" class="txt c1"/></td>
                        <td><input id="txtSales" type="text" class="txt c1"/></td>
                        <td> </td>
                        <td><span> </span><a id='lblBase' class="lbl">本薪</a></td>
                        <td><input id="txtBase" type="text" class="txt num c1"/></td>
                    </tr>
                    
                    <tr>
                    	<td><span> </span><a id='lblAllowance01' class="lbl">全勤</a></td>
                        <td><input id="txtAllowance01" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance02' class="lbl">無遲到</a></td>
                        <td><input id="txtAllowance02" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance03' class="lbl">團體獎金</a></td>
                        <td><input id="txtAllowance03" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblAllowance04' class="lbl">個人獎金</a></td>
                        <td><input id="txtAllowance04" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance05' class="lbl">會議出勤</a></td>
                        <td><input id="txtAllowance05" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance06' class="lbl">成交獎金</a></td>
                        <td><input id="txtAllowance06" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblAllowance07' class="lbl">收現獎金</a></td>
                        <td><input id="txtAllowance07" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance08' class="lbl">早收獎金</a></td>
                        <td><input id="txtAllowance08" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance09' class="lbl">簽約獎金</a></td>
                        <td><input id="txtAllowance09" type="text" class="txt num c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblAllowance10' class="lbl">職等級</a></td>
                        <td><input id="txtAllowance10" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance11' class="lbl">報價獎金</a></td>
                        <td><input id="txtAllowance11" type="text" class="txt num c1"/></td>
                        <td><span> </span><a id='lblAllowance12' class="lbl">拜訪獎金</a></td>
                        <td><input id="txtAllowance12" type="text" class="txt num c1"/></td>
                    </tr> 
                    <tr>
                    	<td> </td>
                    	<td> </td>
                        <td> </td>
                        <td> </td>
                        <td><span> </span><a id='lblTotal' class="lbl">總計</a></td>
                        <td><input id="txtTotal" type="text" class="txt num c1"/></td>
                    </tr>             
                    <tr>
						<td><span> </span><a id='lblMemo' class="lbl">備註</a></td>
						<td colspan="5"><textarea id="txtMemo" rows="3" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl">製單人</a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl">修改人</a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
                </table>
            </div>
        </div>
        <div class='dbbs' style="display:none;">
            <table id="tbbs" class='tbbs'>
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:1%;">
                        <input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:100px;"><a> </a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td>
                        <input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="txtNoq.*" type="text" class="txt c1"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>